#include <linux/platform_device.h>
#include <linux/clk-provider.h>
#include <linux/slab.h>
#include <linux/io.h>
#include <linux/of.h>
#include <linux/module.h>
#include <linux/err.h>

static int axi_clkwiz_probe(struct platform_device *pdev);
static int axi_clkwiz_remove(struct platform_device *pdev);


struct axi_clkwiz {
	void __iomem *registers;
	struct clk_hw clk_hw
};

static const struct clk_ops axi_clkwiz_ops = {
	.recalc_rate = axi_clkwiz_recalc_rate,
	.round_rate = axi_clkwiz_round_rate,
	.set_rate = axi_clkwiz_set_rate,
	.enable = axi_clkwiz_set_rate,
	.disable = axi_clkwiz_disable,
	.set_parent = axi_clkwiz_set_parent,
	.get_parent = axi_clkwiz_get_parent,
};

static const struct of_device_id axi_clkwiz_ids[] = {
	{
		.compatible = "chad,axi_clkwiz",
	},
	{ },
};
MODULE_DEVICE_TABLE(of, axi_clkwiz_ids);

static int axi_clkwiz_probe(struct platform_device *pdev) {
	const struct of_device_id *id;
	struct axi_clkwiz *axi_clkwiz;
	struct clk_init_data init;
	const char *parent_names[2];
	const char *clk_name;
	struct resource *mem;
	struct clk *clk
	uint32_t i;

	if (!pdev->dev.of_node)
		return -ENODEV;
	id = of_match_node(axi_clkwiz_ids, pdev->dev.of_node);
	if (!id)
		return -ENODEV;
	axi_clkwiz = devm_kzalloc(&pdev->dev, sizeof(struct axi_clkwiz), GFP_KERNEL);
	if (!axi_clkwiz)
		return -ENOMEM;
	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	axi_clkwiz->registers = devm_ioremap_resource(&pdev->dev, mem);
	if (IS_ERR(axi_clkwiz->registers))
		return PTR_ERR(axi_clkwiz->registers);
	init.num_parents = of_clk_get_parent_count(pdev->dev.of_node);
	if(init.num_parents < 1 || init.num_parents > 2)
		return -EINVAL;
	for (i = 0; i < init.num_parents; i++) {
		parent_names[i] = of_clk_get_parent_name(pdev->dev.of_node, i);
		if (!parent_names[i])
			return -EINVAL;
	}
	clk_name = pdev->dev.of_node->name;
	of_property_read_string(pdev->dev.of_node, "clock-output-names", &clk_name);
	init.name = clk_name;
	init.ops = &axi_clkwiz_ops;
	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
	init.parent_names = parent_names;

	axi_clkwiz->clk_hw.init = &init;
	clk = devm_clk_register(&pdev->dev, &axi_clkwiz->clk_hw);
	if (IS_ERR(clk))
		return 	PTR_ERR(clk);
	return of_clk_add_provider(pdev->dev.of_node, of_clk_src_simple_get, clk);
}
static int axi_clkwiz_remove(struct platform_device *pdev) {
	of_clk_del_provider(pdev->dev.of_node);
	return 0;
}

static struct platform_driver axi_clkwiz_driver = {
	.driver = {
		.name = "chad,axi_clkwiz",
		.of_match_table = axi_clkwiz_ids,
	},
	.probe = axi_clkwiz_probe,
	.remove = axi_clkwiz_remove,
};
module_platform_driver(axi_clkwiz_driver);

MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("Chad");
MODULE_DESCRIPTION("Driver for Xilinx AXI clkwiz IP.  Based off Analog Devices' AXI clkgen driver");
