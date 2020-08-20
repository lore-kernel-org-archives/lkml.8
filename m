Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E096208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgHTRHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:07:11 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46412
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730319AbgHTRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:03:58 -0400
X-IronPort-AV: E=Sophos;i="5.76,333,1592863200"; 
   d="scan'208";a="356934513"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 19:03:22 +0200
Date:   Thu, 20 Aug 2020 19:03:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re: [PATCH]
 checkpatch: Add test for comma use that should be semicolon)
In-Reply-To: <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2008201856110.2524@hadrien>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>  <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>  <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>  <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
 <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have a bunch of variations of this that are more complicated than I
> > would have expected.  One shorter variant that I have is:
> >
> > @@
> > expression e1,e2;
> > statement S;
> > @@
> >
> >  S
> >  e1
> > -,
> > +;
> >   (<+... e2 ...+>);
> >
> > This will miss cases where the first statement is the comma thing.  But I
> > think it is possible to improve this now.  I will check.
>
> Hi Julia.
>
> Right, thanks, this adds a dependency on a statement
> before the expression.  Any stragglers would be easily
> found using slightly different form.
> There are not very many of these in linux kernel.
>
> Another nicety would be to allow the s/,/;/ conversion to
> find both b and c in this sequence:
> 	a = 1;
> 	b = 2,
> 	c = 3,
> 	d = 4;
> without running the script multiple times.
> There are many dozen uses of this style in linux kernel.
>
> I tried variants of adding a comma after the e2 expression,
> but cocci seems to have parsing problems with:
>
> @@
> expression e1;
> expression e2;
> @@
> 	e1
> -	,
> +	;
> 	e2,

This doesn't work because it's not a valid expression.

The problem is solved by doing:

  e1
- ,
+ ;
  e2
  ... when any

But that doesn't work in the current version of Coccinelle.  I have fixed
the problem, though and it will work shortly.

> I do appreciate that coccinelle adds braces for multiple
> expression comma use after an if.
>
> i.e.:
> 	if (foo)
> 		a = 1, b = 2;
> becomes
> 	if (foo) {
> 		a = 1; b = 2;
> 	}

I wasn't sure what was wanted for such things.  Should b = 2 now be on a
separate line?

I took the strategy of avoiding the problem and leaving those cases as is.
That also solves the LIST_HEAD problem.  But if it is wanted to change
these commas under ifs, then that is probably possible too.

My current complete solution is as follows.  The first rule avoids changing
commas in macros, where thebody of the macro is just an expression.  The
second rule uses position variables to ensure that the two expression are
on different lines.

@r@
expression e1,e2;
statement S;
position p;
@@

e1 ,@S@p e2;

@@
expression e1,e2;
position p1;
position p2 :
    script:ocaml(p1) { not((List.hd p1).line_end = (List.hd p2).line) };
statement S;
position r.p;
@@

e1@p1
-,@S@p
+;
e2@p2
... when any

The generated patch is below.

julia

diff -u -p a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -89,7 +89,7 @@ static int hi3660_reset_probe(struct pla
 		return PTR_ERR(rc->map);
 	}

-	rc->rst.ops = &hi3660_reset_ops,
+	rc->rst.ops = &hi3660_reset_ops;
 	rc->rst.of_node = np;
 	rc->rst.of_reset_n_cells = 2;
 	rc->rst.of_xlate = hi3660_reset_xlate;
diff -u -p a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -123,7 +123,7 @@ static int snvs_lpgpr_probe(struct platf
 	cfg->dev = dev;
 	cfg->stride = 4;
 	cfg->word_size = 4;
-	cfg->size = dcfg->size,
+	cfg->size = dcfg->size;
 	cfg->owner = THIS_MODULE;
 	cfg->reg_read  = snvs_lpgpr_read;
 	cfg->reg_write = snvs_lpgpr_write;
diff -u -p a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -876,7 +876,7 @@ static int lqasc_probe(struct platform_d
 	port->flags	= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	port->ops	= &lqasc_pops;
 	port->fifosize	= 16;
-	port->type	= PORT_LTQ_ASC,
+	port->type	= PORT_LTQ_ASC;
 	port->line	= line;
 	port->dev	= &pdev->dev;
 	/* unused, just to be backward-compatible */
diff -u -p a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -955,7 +955,7 @@ static int rtl2832u_frontend_attach(stru
 			struct mn88472_config mn88472_config = {};

 			mn88472_config.fe = &adap->fe[1];
-			mn88472_config.i2c_wr_max = 22,
+			mn88472_config.i2c_wr_max = 22;
 			strscpy(info.type, "mn88472", I2C_NAME_SIZE);
 			mn88472_config.xtal = 20500000;
 			mn88472_config.ts_mode = SERIAL_TS_MODE;
@@ -980,7 +980,7 @@ static int rtl2832u_frontend_attach(stru
 			struct mn88473_config mn88473_config = {};

 			mn88473_config.fe = &adap->fe[1];
-			mn88473_config.i2c_wr_max = 22,
+			mn88473_config.i2c_wr_max = 22;
 			strscpy(info.type, "mn88473", I2C_NAME_SIZE);
 			info.addr = 0x18;
 			info.platform_data = &mn88473_config;
diff -u -p a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -958,7 +958,7 @@ static void mtk_jpeg_set_default_params(
 	struct mtk_jpeg_q_data *q = &ctx->out_q;
 	int i;

-	ctx->colorspace = V4L2_COLORSPACE_JPEG,
+	ctx->colorspace = V4L2_COLORSPACE_JPEG;
 	ctx->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	ctx->quantization = V4L2_QUANTIZATION_DEFAULT;
 	ctx->xfer_func = V4L2_XFER_FUNC_DEFAULT;
diff -u -p a/drivers/media/radio/radio-sf16fmr2.c b/drivers/media/radio/radio-sf16fmr2.c
--- a/drivers/media/radio/radio-sf16fmr2.c
+++ b/drivers/media/radio/radio-sf16fmr2.c
@@ -215,7 +215,7 @@ static int fmr2_probe(struct fmr2 *fmr2,
 			return -EBUSY;

 	strscpy(fmr2->v4l2_dev.name, "radio-sf16fmr2",
-		sizeof(fmr2->v4l2_dev.name)),
+		sizeof(fmr2->v4l2_dev.name));
 	fmr2->io = io;

 	if (!request_region(fmr2->io, 2, fmr2->v4l2_dev.name)) {
diff -u -p a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1323,8 +1323,8 @@ static int intel_hdmi_hdcp_write(struct
 	memcpy(&write_buf[1], buffer, size);

 	msg.addr = DRM_HDCP_DDC_ADDR;
-	msg.flags = 0,
-	msg.len = size + 1,
+	msg.flags = 0;
+	msg.len = size + 1;
 	msg.buf = write_buf;

 	ret = i2c_transfer(adapter, &msg, 1);
diff -u -p a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
--- a/drivers/gpio/gpio-sama5d2-piobu.c
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -193,15 +193,15 @@ static int sama5d2_piobu_probe(struct pl
 	piobu->chip.label = pdev->name;
 	piobu->chip.parent = &pdev->dev;
 	piobu->chip.of_node = pdev->dev.of_node;
-	piobu->chip.owner = THIS_MODULE,
-	piobu->chip.get_direction = sama5d2_piobu_get_direction,
-	piobu->chip.direction_input = sama5d2_piobu_direction_input,
-	piobu->chip.direction_output = sama5d2_piobu_direction_output,
-	piobu->chip.get = sama5d2_piobu_get,
-	piobu->chip.set = sama5d2_piobu_set,
-	piobu->chip.base = -1,
-	piobu->chip.ngpio = PIOBU_NUM,
-	piobu->chip.can_sleep = 0,
+	piobu->chip.owner = THIS_MODULE;
+	piobu->chip.get_direction = sama5d2_piobu_get_direction;
+	piobu->chip.direction_input = sama5d2_piobu_direction_input;
+	piobu->chip.direction_output = sama5d2_piobu_direction_output;
+	piobu->chip.get = sama5d2_piobu_get;
+	piobu->chip.set = sama5d2_piobu_set;
+	piobu->chip.base = -1;
+	piobu->chip.ngpio = PIOBU_NUM;
+	piobu->chip.can_sleep = 0;

 	piobu->regmap = syscon_node_to_regmap(pdev->dev.of_node);
 	if (IS_ERR(piobu->regmap)) {
diff -u -p a/drivers/gpio/gpio-rc5t583.c b/drivers/gpio/gpio-rc5t583.c
--- a/drivers/gpio/gpio-rc5t583.c
+++ b/drivers/gpio/gpio-rc5t583.c
@@ -104,16 +104,16 @@ static int rc5t583_gpio_probe(struct pla
 	if (!rc5t583_gpio)
 		return -ENOMEM;

-	rc5t583_gpio->gpio_chip.label = "gpio-rc5t583",
-	rc5t583_gpio->gpio_chip.owner = THIS_MODULE,
-	rc5t583_gpio->gpio_chip.free = rc5t583_gpio_free,
-	rc5t583_gpio->gpio_chip.direction_input = rc5t583_gpio_dir_input,
-	rc5t583_gpio->gpio_chip.direction_output = rc5t583_gpio_dir_output,
-	rc5t583_gpio->gpio_chip.set = rc5t583_gpio_set,
-	rc5t583_gpio->gpio_chip.get = rc5t583_gpio_get,
-	rc5t583_gpio->gpio_chip.to_irq = rc5t583_gpio_to_irq,
-	rc5t583_gpio->gpio_chip.ngpio = RC5T583_MAX_GPIO,
-	rc5t583_gpio->gpio_chip.can_sleep = true,
+	rc5t583_gpio->gpio_chip.label = "gpio-rc5t583";
+	rc5t583_gpio->gpio_chip.owner = THIS_MODULE;
+	rc5t583_gpio->gpio_chip.free = rc5t583_gpio_free;
+	rc5t583_gpio->gpio_chip.direction_input = rc5t583_gpio_dir_input;
+	rc5t583_gpio->gpio_chip.direction_output = rc5t583_gpio_dir_output;
+	rc5t583_gpio->gpio_chip.set = rc5t583_gpio_set;
+	rc5t583_gpio->gpio_chip.get = rc5t583_gpio_get;
+	rc5t583_gpio->gpio_chip.to_irq = rc5t583_gpio_to_irq;
+	rc5t583_gpio->gpio_chip.ngpio = RC5T583_MAX_GPIO;
+	rc5t583_gpio->gpio_chip.can_sleep = true;
 	rc5t583_gpio->gpio_chip.parent = &pdev->dev;
 	rc5t583_gpio->gpio_chip.base = -1;
 	rc5t583_gpio->rc5t583 = rc5t583;
diff -u -p a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -924,7 +924,7 @@ static int stfsm_read_status(struct stfs
 	BUG_ON(bytes != 1 && bytes != 2);

 	seq->seq_opc[0] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-			   SEQ_OPC_OPCODE(cmd)),
+			   SEQ_OPC_OPCODE(cmd));

 	stfsm_load_seq(fsm, seq);

diff -u -p a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -923,8 +923,8 @@ static int wiz_probe(struct platform_dev

 	phy_reset_dev = &wiz->wiz_phy_reset_dev;
 	phy_reset_dev->dev = dev;
-	phy_reset_dev->ops = &wiz_phy_reset_ops,
-	phy_reset_dev->owner = THIS_MODULE,
+	phy_reset_dev->ops = &wiz_phy_reset_ops;
+	phy_reset_dev->owner = THIS_MODULE;
 	phy_reset_dev->of_node = node;
 	/* Reset for each of the lane and one for the entire SERDES */
 	phy_reset_dev->nr_resets = num_lanes + 1;
diff -u -p a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1757,7 +1757,7 @@ static int bq24190_probe(struct i2c_clie
 	charger_cfg.drv_data = bdi;
 	charger_cfg.of_node = dev->of_node;
 	charger_cfg.supplied_to = bq24190_charger_supplied_to;
-	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to),
+	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to);
 	bdi->charger = power_supply_register(dev, &bq24190_charger_desc,
 						&charger_cfg);
 	if (IS_ERR(bdi->charger)) {
diff -u -p a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
--- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
@@ -165,7 +165,7 @@ static int fs_enet_mdio_probe(struct pla
 	if (!new_bus)
 		goto out_free_priv;

-	new_bus->name = "CPM2 Bitbanged MII",
+	new_bus->name = "CPM2 Bitbanged MII";

 	ret = fs_mii_bitbang_init(new_bus, ofdev->dev.of_node);
 	if (ret)
diff -u -p a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4866,7 +4866,7 @@ static int hclge_init_fd_config(struct h
 	}

 	key_cfg = &hdev->fd_cfg.key_cfg[HCLGE_FD_STAGE_1];
-	key_cfg->key_sel = HCLGE_FD_KEY_BASE_ON_TUPLE,
+	key_cfg->key_sel = HCLGE_FD_KEY_BASE_ON_TUPLE;
 	key_cfg->inner_sipv6_word_en = LOW_2_WORDS;
 	key_cfg->inner_dipv6_word_en = LOW_2_WORDS;
 	key_cfg->outer_sipv6_word_en = 0;
diff -u -p a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
@@ -1732,13 +1732,13 @@ netxen_setup_hwops(struct netxen_adapter
 	adapter->stop_port = netxen_niu_disable_xg_port;

 	if (NX_IS_REVISION_P2(adapter->ahw.revision_id)) {
-		adapter->crb_read = netxen_nic_hw_read_wx_128M,
-		adapter->crb_write = netxen_nic_hw_write_wx_128M,
-		adapter->pci_set_window = netxen_nic_pci_set_window_128M,
-		adapter->pci_mem_read = netxen_nic_pci_mem_read_128M,
-		adapter->pci_mem_write = netxen_nic_pci_mem_write_128M,
-		adapter->io_read = netxen_nic_io_read_128M,
-		adapter->io_write = netxen_nic_io_write_128M,
+		adapter->crb_read = netxen_nic_hw_read_wx_128M;
+		adapter->crb_write = netxen_nic_hw_write_wx_128M;
+		adapter->pci_set_window = netxen_nic_pci_set_window_128M;
+		adapter->pci_mem_read = netxen_nic_pci_mem_read_128M;
+		adapter->pci_mem_write = netxen_nic_pci_mem_write_128M;
+		adapter->io_read = netxen_nic_io_read_128M;
+		adapter->io_write = netxen_nic_io_write_128M;

 		adapter->macaddr_set = netxen_p2_nic_set_mac_addr;
 		adapter->set_multi = netxen_p2_nic_set_multi;
@@ -1746,13 +1746,13 @@ netxen_setup_hwops(struct netxen_adapter
 		adapter->set_promisc = netxen_p2_nic_set_promisc;

 	} else {
-		adapter->crb_read = netxen_nic_hw_read_wx_2M,
-		adapter->crb_write = netxen_nic_hw_write_wx_2M,
-		adapter->pci_set_window = netxen_nic_pci_set_window_2M,
-		adapter->pci_mem_read = netxen_nic_pci_mem_read_2M,
-		adapter->pci_mem_write = netxen_nic_pci_mem_write_2M,
-		adapter->io_read = netxen_nic_io_read_2M,
-		adapter->io_write = netxen_nic_io_write_2M,
+		adapter->crb_read = netxen_nic_hw_read_wx_2M;
+		adapter->crb_write = netxen_nic_hw_write_wx_2M;
+		adapter->pci_set_window = netxen_nic_pci_set_window_2M;
+		adapter->pci_mem_read = netxen_nic_pci_mem_read_2M;
+		adapter->pci_mem_write = netxen_nic_pci_mem_write_2M;
+		adapter->io_read = netxen_nic_io_read_2M;
+		adapter->io_write = netxen_nic_io_write_2M;

 		adapter->set_mtu = nx_fw_cmd_set_mtu;
 		adapter->set_promisc = netxen_p3_nic_set_promisc;
diff -u -p a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -381,9 +381,9 @@ static int davinci_mdio_probe(struct pla
 	}

 	data->bus->name		= dev_name(dev);
-	data->bus->read		= davinci_mdio_read,
-	data->bus->write	= davinci_mdio_write,
-	data->bus->reset	= davinci_mdio_reset,
+	data->bus->read		= davinci_mdio_read;
+	data->bus->write	= davinci_mdio_write;
+	data->bus->reset	= davinci_mdio_reset;
 	data->bus->parent	= dev;
 	data->bus->priv		= data;

diff -u -p a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -59,7 +59,7 @@ int mt7663u_mcu_init(struct mt7615_dev *
 	};
 	int ret;

-	dev->mt76.mcu_ops = &mt7663u_mcu_ops,
+	dev->mt76.mcu_ops = &mt7663u_mcu_ops;

 	/* usb does not support runtime-pm */
 	clear_bit(MT76_STATE_PM, &dev->mphy.state);
diff -u -p a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1127,7 +1127,7 @@ mt7915_mcu_sta_ba_tlv(struct sk_buff *sk
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));

 	ba = (struct sta_rec_ba *)tlv;
-	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT,
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
 	ba->winsize = cpu_to_le16(params->buf_size);
 	ba->ssn = cpu_to_le16(params->ssn);
 	ba->ba_en = enable << params->tid;
@@ -1583,7 +1583,7 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *s
 		tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
 						wtbl_tlv, sta_wtbl);
 		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC,
+		vht->ldpc = sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC;
 		vht->vht = true;

 		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
@@ -2763,7 +2763,7 @@ int mt7915_mcu_init(struct mt7915_dev *d
 	};
 	int ret;

-	dev->mt76.mcu_ops = &mt7915_mcu_ops,
+	dev->mt76.mcu_ops = &mt7915_mcu_ops;

 	ret = mt7915_driver_own(dev);
 	if (ret)
diff -u -p a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -513,7 +513,7 @@ static int agp_serverworks_probe(struct
 		return -ENOMEM;

 	bridge->driver = &sworks_driver;
-	bridge->dev_private_data = &serverworks_private,
+	bridge->dev_private_data = &serverworks_private;
 	bridge->dev = pci_dev_get(pdev);

 	pci_set_drvdata(pdev, bridge);
diff -u -p a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -358,7 +358,7 @@ int rave_sp_exec(struct rave_sp *sp,

 	ackid       = atomic_inc_return(&sp->ackid);
 	reply.ackid = ackid;
-	reply.code  = rave_sp_reply_code((u8)command),
+	reply.code  = rave_sp_reply_code((u8)command);

 	mutex_lock(&sp->bus_lock);

diff -u -p a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -582,8 +582,8 @@ static int mc13892_regulator_probe(struc
 	/* update mc13892_vcam ops */
 	memcpy(&mc13892_vcam_ops, mc13892_regulators[MC13892_VCAM].desc.ops,
 						sizeof(struct regulator_ops));
-	mc13892_vcam_ops.set_mode = mc13892_vcam_set_mode,
-	mc13892_vcam_ops.get_mode = mc13892_vcam_get_mode,
+	mc13892_vcam_ops.set_mode = mc13892_vcam_set_mode;
+	mc13892_vcam_ops.get_mode = mc13892_vcam_get_mode;
 	mc13892_regulators[MC13892_VCAM].desc.ops = &mc13892_vcam_ops;

 	mc13xxx_data = mc13xxx_parse_regulators_dt(pdev, mc13892_regulators,
diff -u -p a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -97,7 +97,7 @@ static int ixp4xx_spkr_probe(struct plat

 	input_set_drvdata(input_dev, (void *) dev->id);

-	input_dev->name = "ixp4xx beeper",
+	input_dev->name = "ixp4xx beeper";
 	input_dev->phys = "ixp4xx/gpio";
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->id.vendor  = 0x001f;
diff -u -p a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -655,7 +655,7 @@ static void __init __hugetlb_cgroup_file
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
 	cft->private = MEMFILE_PRIVATE(idx, 0);
 	cft->seq_show = hugetlb_events_show;
-	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]),
+	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
 	cft->flags = CFTYPE_NOT_ON_ROOT;

 	/* Add the events.local file */
@@ -664,7 +664,7 @@ static void __init __hugetlb_cgroup_file
 	cft->private = MEMFILE_PRIVATE(idx, 0);
 	cft->seq_show = hugetlb_events_local_show;
 	cft->file_offset = offsetof(struct hugetlb_cgroup,
-				    events_local_file[idx]),
+				    events_local_file[idx]);
 	cft->flags = CFTYPE_NOT_ON_ROOT;

 	/* NULL terminate the last cft */
diff -u -p a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -245,7 +245,7 @@ static void __init export_crashk_values(
 				"linux,crashkernel-size", NULL));

 	if (crashk_res.start != 0) {
-		crashk_base = cpu_to_be_ulong(crashk_res.start),
+		crashk_base = cpu_to_be_ulong(crashk_res.start);
 		of_add_property(node, &crashk_base_prop);
 		crashk_size = cpu_to_be_ulong(resource_size(&crashk_res));
 		of_add_property(node, &crashk_size_prop);
diff -u -p a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8586,7 +8586,7 @@ struct perf_buffer *perf_buffer__new(int
 	struct perf_buffer_params p = {};
 	struct perf_event_attr attr = { 0, };

-	attr.config = PERF_COUNT_SW_BPF_OUTPUT,
+	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.sample_type = PERF_SAMPLE_RAW;
 	attr.sample_period = 1;
diff -u -p a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -269,7 +269,7 @@ struct evsel *evsel__new_idx(struct perf

 	if (evsel__is_bpf_output(evsel)) {
 		evsel->core.attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
-					    PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
+					    PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD);
 		evsel->core.attr.sample_period = 1;
 	}

diff -u -p a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -151,9 +151,9 @@ static void sock_fanout_set_ebpf(int fd)
 	attr.insns = (unsigned long) prog;
 	attr.insn_cnt = sizeof(prog) / sizeof(prog[0]);
 	attr.license = (unsigned long) "GPL";
-	attr.log_buf = (unsigned long) log_buf,
-	attr.log_size = sizeof(log_buf),
-	attr.log_level = 1,
+	attr.log_buf = (unsigned long) log_buf;
+	attr.log_size = sizeof(log_buf);
+	attr.log_level = 1;

 	pfd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
 	if (pfd < 0) {
diff -u -p a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -44,7 +44,7 @@ int hda_dsp_core_reset_enter(struct snd_
 	reset = HDA_DSP_ADSPCS_CRST_MASK(core_mask);
 	snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
 					 HDA_DSP_REG_ADSPCS,
-					 reset, reset),
+					 reset, reset);

 	/* poll with timeout to check if operation successful */
 	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
diff -u -p a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -908,7 +908,7 @@ static int __init alarmtimer_init(void)
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
 	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
-	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64,
+	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64;
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
 	alarm_bases[ALARM_BOOTTIME].get_timespec = get_boottime_timespec;
diff -u -p a/drivers/leds/leds-lm3642.c b/drivers/leds/leds-lm3642.c
--- a/drivers/leds/leds-lm3642.c
+++ b/drivers/leds/leds-lm3642.c
@@ -339,7 +339,7 @@ static int lm3642_probe(struct i2c_clien
 	chip->cdev_flash.max_brightness = 16;
 	chip->cdev_flash.brightness_set_blocking = lm3642_strobe_brightness_set;
 	chip->cdev_flash.default_trigger = "flash";
-	chip->cdev_flash.groups = lm3642_flash_groups,
+	chip->cdev_flash.groups = lm3642_flash_groups;
 	err = led_classdev_register(&client->dev, &chip->cdev_flash);
 	if (err < 0) {
 		dev_err(chip->dev, "failed to register flash\n");
@@ -351,7 +351,7 @@ static int lm3642_probe(struct i2c_clien
 	chip->cdev_torch.max_brightness = 8;
 	chip->cdev_torch.brightness_set_blocking = lm3642_torch_brightness_set;
 	chip->cdev_torch.default_trigger = "torch";
-	chip->cdev_torch.groups = lm3642_torch_groups,
+	chip->cdev_torch.groups = lm3642_torch_groups;
 	err = led_classdev_register(&client->dev, &chip->cdev_torch);
 	if (err < 0) {
 		dev_err(chip->dev, "failed to register torch\n");
diff -u -p a/drivers/s390/crypto/zcrypt_msgtype6.h b/drivers/s390/crypto/zcrypt_msgtype6.h
--- a/drivers/s390/crypto/zcrypt_msgtype6.h
+++ b/drivers/s390/crypto/zcrypt_msgtype6.h
@@ -146,9 +146,9 @@ static inline void rng_type6CPRB_msgX(st
 	};

 	msg->hdr = static_type6_hdrX;
-	msg->hdr.FromCardLen2 = random_number_length,
+	msg->hdr.FromCardLen2 = random_number_length;
 	msg->cprbx = local_cprbx;
-	msg->cprbx.rpl_datal = random_number_length,
+	msg->cprbx.rpl_datal = random_number_length;
 	memcpy(msg->function_code, msg->hdr.function_code, 0x02);
 	msg->rule_length = 0x0a;
 	memcpy(msg->rule, "RANDOM  ", 8);
diff -u -p a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4769,14 +4769,14 @@ static int devm_tcpm_psy_register(struct
 	snprintf(psy_name, psy_name_len, "%s%s", tcpm_psy_name_prefix,
 		 port_dev_name);
 	port->psy_desc.name = psy_name;
-	port->psy_desc.type = POWER_SUPPLY_TYPE_USB,
+	port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 	port->psy_desc.usb_types = tcpm_psy_usb_types;
 	port->psy_desc.num_usb_types = ARRAY_SIZE(tcpm_psy_usb_types);
-	port->psy_desc.properties = tcpm_psy_props,
-	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props),
-	port->psy_desc.get_property = tcpm_psy_get_prop,
-	port->psy_desc.set_property = tcpm_psy_set_prop,
-	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable,
+	port->psy_desc.properties = tcpm_psy_props;
+	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props);
+	port->psy_desc.get_property = tcpm_psy_get_prop;
+	port->psy_desc.set_property = tcpm_psy_set_prop;
+	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable;

 	port->usb_type = POWER_SUPPLY_USB_TYPE_C;

diff -u -p a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -2079,8 +2079,8 @@ static void usb_reset_228x(struct net228
 			abort_dma(ep);
 	}

-	writel(~0, &dev->regs->irqstat0),
-	writel(~(u32)BIT(SUSPEND_REQUEST_INTERRUPT), &dev->regs->irqstat1),
+	writel(~0, &dev->regs->irqstat0);
+	writel(~(u32)BIT(SUSPEND_REQUEST_INTERRUPT), &dev->regs->irqstat1);

 	/* reset, and enable pci */
 	tmp = readl(&dev->regs->devinit) |
diff -u -p a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
--- a/drivers/reset/sti/reset-syscfg.c
+++ b/drivers/reset/sti/reset-syscfg.c
@@ -152,7 +152,7 @@ static int syscfg_reset_controller_regis
 	if (!rc->channels)
 		return -ENOMEM;

-	rc->rst.ops = &syscfg_reset_ops,
+	rc->rst.ops = &syscfg_reset_ops;
 	rc->rst.of_node = dev->of_node;
 	rc->rst.nr_resets = data->nr_channels;
 	rc->active_low = data->active_low;
diff -u -p a/drivers/md/raid10.c b/drivers/md/raid10.c
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2150,7 +2150,7 @@ static void fix_recovery_read_error(stru
 			s = PAGE_SIZE >> 9;

 		rdev = conf->mirrors[dr].rdev;
-		addr = r10_bio->devs[0].addr + sect,
+		addr = r10_bio->devs[0].addr + sect;
 		ok = sync_page_io(rdev,
 				  addr,
 				  s << 9,
diff -u -p a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -552,8 +552,8 @@ static int meson_spicc_clk_init(struct m
 		parent_data[0].hw = __clk_get_hw(spicc->core);
 	init.num_parents = 1;

-	pow2_fixed_div->mult = 1,
-	pow2_fixed_div->div = 4,
+	pow2_fixed_div->mult = 1;
+	pow2_fixed_div->div = 4;
 	pow2_fixed_div->hw.init = &init;

 	clk = devm_clk_register(dev, &pow2_fixed_div->hw);
@@ -571,9 +571,9 @@ static int meson_spicc_clk_init(struct m
 	parent_data[0].hw = &pow2_fixed_div->hw;
 	init.num_parents = 1;

-	pow2_div->shift = 16,
-	pow2_div->width = 3,
-	pow2_div->flags = CLK_DIVIDER_POWER_OF_TWO,
+	pow2_div->shift = 16;
+	pow2_div->width = 3;
+	pow2_div->flags = CLK_DIVIDER_POWER_OF_TWO;
 	pow2_div->reg = spicc->base + SPICC_CONREG;
 	pow2_div->hw.init = &init;

@@ -602,8 +602,8 @@ static int meson_spicc_clk_init(struct m
 		parent_data[0].hw = __clk_get_hw(spicc->core);
 	init.num_parents = 1;

-	enh_fixed_div->mult = 1,
-	enh_fixed_div->div = 2,
+	enh_fixed_div->mult = 1;
+	enh_fixed_div->div = 2;
 	enh_fixed_div->hw.init = &init;

 	clk = devm_clk_register(dev, &enh_fixed_div->hw);
@@ -621,8 +621,8 @@ static int meson_spicc_clk_init(struct m
 	parent_data[0].hw = &enh_fixed_div->hw;
 	init.num_parents = 1;

-	enh_div->shift	= 16,
-	enh_div->width	= 8,
+	enh_div->shift	= 16;
+	enh_div->width	= 8;
 	enh_div->reg = spicc->base + SPICC_ENH_CTL0;
 	enh_div->hw.init = &init;

@@ -642,8 +642,8 @@ static int meson_spicc_clk_init(struct m
 	init.num_parents = 2;
 	init.flags = CLK_SET_RATE_PARENT;

-	mux->mask = 0x1,
-	mux->shift = 24,
+	mux->mask = 0x1;
+	mux->shift = 24;
 	mux->reg = spicc->base + SPICC_ENH_CTL0;
 	mux->hw.init = &init;

diff -u -p a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -282,7 +282,7 @@ static int pms7003_probe(struct serdev_d
 	state->serdev = serdev;
 	indio_dev->info = &pms7003_info;
 	indio_dev->name = PMS7003_DRIVER_NAME;
-	indio_dev->channels = pms7003_channels,
+	indio_dev->channels = pms7003_channels;
 	indio_dev->num_channels = ARRAY_SIZE(pms7003_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = pms7003_scan_masks;
diff -u -p a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -142,7 +142,7 @@ static int sdam_probe(struct platform_de
 	sdam->sdam_config.dev = &pdev->dev;
 	sdam->sdam_config.name = "spmi_sdam";
 	sdam->sdam_config.id = NVMEM_DEVID_AUTO;
-	sdam->sdam_config.owner = THIS_MODULE,
+	sdam->sdam_config.owner = THIS_MODULE;
 	sdam->sdam_config.stride = 1;
 	sdam->sdam_config.word_size = 1;
 	sdam->sdam_config.reg_read = sdam_read;
diff -u -p a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -265,9 +265,9 @@ static int isst_if_get_platform_info(voi
 {
 	struct isst_if_platform_info info;

-	info.api_version = ISST_IF_API_VERSION,
-	info.driver_version = ISST_IF_DRIVER_VERSION,
-	info.max_cmds_per_ioctl = ISST_IF_CMD_LIMIT,
+	info.api_version = ISST_IF_API_VERSION;
+	info.driver_version = ISST_IF_DRIVER_VERSION;
+	info.max_cmds_per_ioctl = ISST_IF_CMD_LIMIT;
 	info.mbox_supported = punit_callbacks[ISST_IF_DEV_MBOX].registered;
 	info.mmio_supported = punit_callbacks[ISST_IF_DEV_MMIO].registered;

diff -u -p a/drivers/tty/mxser.c b/drivers/tty/mxser.c
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1213,15 +1213,15 @@ static int mxser_get_serial_info(struct
 		return -ENOTTY;

 	mutex_lock(&port->mutex);
-	ss->type = info->type,
-	ss->line = tty->index,
-	ss->port = info->ioaddr,
-	ss->irq = info->board->irq,
-	ss->flags = info->port.flags,
-	ss->baud_base = info->baud_base,
-	ss->close_delay = info->port.close_delay,
-	ss->closing_wait = info->port.closing_wait,
-	ss->custom_divisor = info->custom_divisor,
+	ss->type = info->type;
+	ss->line = tty->index;
+	ss->port = info->ioaddr;
+	ss->irq = info->board->irq;
+	ss->flags = info->port.flags;
+	ss->baud_base = info->baud_base;
+	ss->close_delay = info->port.close_delay;
+	ss->closing_wait = info->port.closing_wait;
+	ss->custom_divisor = info->custom_divisor;
 	mutex_unlock(&port->mutex);
 	return 0;
 }
diff -u -p a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2319,7 +2319,7 @@ static int imx_uart_probe(struct platfor
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
 	sport->port.membase = base;
-	sport->port.type = PORT_IMX,
+	sport->port.type = PORT_IMX;
 	sport->port.iotype = UPIO_MEM;
 	sport->port.irq = rxirq;
 	sport->port.fifosize = 32;
diff -u -p a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -2864,7 +2864,7 @@ static int coda_register_device(struct c
 	strscpy(vfd->name, dev->devtype->vdevs[i]->name, sizeof(vfd->name));
 	vfd->fops	= &coda_fops;
 	vfd->ioctl_ops	= &coda_ioctl_ops;
-	vfd->release	= video_device_release_empty,
+	vfd->release	= video_device_release_empty;
 	vfd->lock	= &dev->dev_mutex;
 	vfd->v4l2_dev	= &dev->v4l2_dev;
 	vfd->vfl_dir	= VFL_DIR_M2M;
diff -u -p a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -2703,7 +2703,7 @@ static void complete_scsi_command(struct
 				cmd->result);
 		} else {  /* scsi status is zero??? How??? */
 			dev_warn(&h->pdev->dev, "cp %p SCSI status was 0. "
-				"Returning no connection.\n", cp),
+				"Returning no connection.\n", cp);

 			/* Ordinarily, this case should never happen,
 			 * but there is a bug in some released firmware
diff -u -p a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
--- a/drivers/scsi/isci/host.c
+++ b/drivers/scsi/isci/host.c
@@ -2266,7 +2266,7 @@ static int sci_controller_dma_alloc(stru
 	if (!ihost->remote_node_context_table)
 		return -ENOMEM;

-	size = ihost->task_context_entries * sizeof(struct scu_task_context),
+	size = ihost->task_context_entries * sizeof(struct scu_task_context);
 	ihost->task_context_table = dmam_alloc_coherent(dev, size, &ihost->tc_dma,
 							GFP_KERNEL);
 	if (!ihost->task_context_table)
diff -u -p a/drivers/gpu/drm/i915/selftests/i915_buddy.c b/drivers/gpu/drm/i915/selftests/i915_buddy.c
--- a/drivers/gpu/drm/i915/selftests/i915_buddy.c
+++ b/drivers/gpu/drm/i915/selftests/i915_buddy.c
@@ -128,7 +128,7 @@ static int igt_check_blocks(struct i915_
 		err = igt_check_block(mm, block);

 		if (!i915_buddy_block_is_allocated(block)) {
-			pr_err("block not allocated\n"),
+			pr_err("block not allocated\n");
 			err = -EINVAL;
 		}

diff -u -p a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -636,7 +636,7 @@ static int tegra186_gpio_probe(struct pl
 	gpio->gpio.get_direction = tegra186_gpio_get_direction;
 	gpio->gpio.direction_input = tegra186_gpio_direction_input;
 	gpio->gpio.direction_output = tegra186_gpio_direction_output;
-	gpio->gpio.get = tegra186_gpio_get,
+	gpio->gpio.get = tegra186_gpio_get;
 	gpio->gpio.set = tegra186_gpio_set;
 	gpio->gpio.set_config = tegra186_gpio_set_config;
 	gpio->gpio.add_pin_ranges = tegra186_gpio_add_pin_ranges;
diff -u -p a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -857,7 +857,7 @@ static int ab8500_fg_volt_to_capacity(st
 	const struct abx500_v_to_cap *tbl;
 	int cap = 0;

-	tbl = di->bm->bat_type[di->bm->batt_id].v_to_cap_tbl,
+	tbl = di->bm->bat_type[di->bm->batt_id].v_to_cap_tbl;
 	tbl_size = di->bm->bat_type[di->bm->batt_id].n_v_cap_tbl_elements;

 	for (i = 0; i < tbl_size; ++i) {
diff -u -p a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -333,7 +333,7 @@ static int mv88e6xxx_g1_atu_move(struct
 	mask = chip->info->atu_move_port_mask;
 	shift = bitmap_weight(&mask, 16);

-	entry.state = 0xf, /* Full EntryState means Move */
+	entry.state = 0xf; /* Full EntryState means Move */
 	entry.portvec = from_port & mask;
 	entry.portvec |= (to_port & mask) << shift;

diff -u -p a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -3474,7 +3474,7 @@ static void rt2800_config_channel_rf55xx
 			rt2800_rfcsr_write(rt2x00dev, 52, 0x0C);
 			rt2800_rfcsr_write(rt2x00dev, 54, 0xF8);
 			if (rf->channel <= 50) {
-				rt2800_rfcsr_write(rt2x00dev, 55, 0x06),
+				rt2800_rfcsr_write(rt2x00dev, 55, 0x06);
 				rt2800_rfcsr_write(rt2x00dev, 56, 0xD3);
 			} else if (rf->channel >= 52) {
 				rt2800_rfcsr_write(rt2x00dev, 55, 0x04);
diff -u -p a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -223,12 +223,12 @@ static int rza1_irqc_probe(struct platfo
 		goto out_put_node;
 	}

-	priv->chip.name = "rza1-irqc",
-	priv->chip.irq_mask = irq_chip_mask_parent,
-	priv->chip.irq_unmask = irq_chip_unmask_parent,
-	priv->chip.irq_eoi = rza1_irqc_eoi,
-	priv->chip.irq_retrigger = irq_chip_retrigger_hierarchy,
-	priv->chip.irq_set_type = rza1_irqc_set_type,
+	priv->chip.name = "rza1-irqc";
+	priv->chip.irq_mask = irq_chip_mask_parent;
+	priv->chip.irq_unmask = irq_chip_unmask_parent;
+	priv->chip.irq_eoi = rza1_irqc_eoi;
+	priv->chip.irq_retrigger = irq_chip_retrigger_hierarchy;
+	priv->chip.irq_set_type = rza1_irqc_set_type;
 	priv->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;

 	priv->irq_domain = irq_domain_add_hierarchy(parent, 0, IRQC_NUM_IRQ,
diff -u -p a/drivers/char/hw_random/mxc-rnga.c b/drivers/char/hw_random/mxc-rnga.c
--- a/drivers/char/hw_random/mxc-rnga.c
+++ b/drivers/char/hw_random/mxc-rnga.c
@@ -143,9 +143,9 @@ static int __init mxc_rnga_probe(struct
 	mxc_rng->dev = &pdev->dev;
 	mxc_rng->rng.name = "mxc-rnga";
 	mxc_rng->rng.init = mxc_rnga_init;
-	mxc_rng->rng.cleanup = mxc_rnga_cleanup,
-	mxc_rng->rng.data_present = mxc_rnga_data_present,
-	mxc_rng->rng.data_read = mxc_rnga_data_read,
+	mxc_rng->rng.cleanup = mxc_rnga_cleanup;
+	mxc_rng->rng.data_present = mxc_rnga_data_present;
+	mxc_rng->rng.data_read = mxc_rnga_data_read;

 	mxc_rng->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mxc_rng->clk)) {
diff -u -p a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -891,8 +891,8 @@ static int mtk_build_gpiochip(struct mtk
 	chip->direction_output	= mtk_gpio_direction_output;
 	chip->get		= mtk_gpio_get;
 	chip->set		= mtk_gpio_set;
-	chip->to_irq		= mtk_gpio_to_irq,
-	chip->set_config	= mtk_gpio_set_config,
+	chip->to_irq		= mtk_gpio_to_irq;
+	chip->set_config	= mtk_gpio_set_config;
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
 	chip->of_node		= np;
diff -u -p a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -98,7 +98,7 @@ static int atmel_flexcom_resume(struct d
 	if (err)
 		return err;

-	val = FLEX_MR_OPMODE(ddata->opmode),
+	val = FLEX_MR_OPMODE(ddata->opmode);
 	writel(val, ddata->base + FLEX_MR);

 	clk_disable_unprepare(ddata->clk);
diff -u -p a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -148,10 +148,10 @@ static int wm831x_isink_probe(struct pla
 	isink->desc.ops = &wm831x_isink_ops;
 	isink->desc.type = REGULATOR_CURRENT;
 	isink->desc.owner = THIS_MODULE;
-	isink->desc.curr_table = wm831x_isinkv_values,
-	isink->desc.n_current_limits = ARRAY_SIZE(wm831x_isinkv_values),
-	isink->desc.csel_reg = isink->reg,
-	isink->desc.csel_mask = WM831X_CS1_ISEL_MASK,
+	isink->desc.curr_table = wm831x_isinkv_values;
+	isink->desc.n_current_limits = ARRAY_SIZE(wm831x_isinkv_values);
+	isink->desc.csel_reg = isink->reg;
+	isink->desc.csel_mask = WM831X_CS1_ISEL_MASK;

 	config.dev = pdev->dev.parent;
 	config.init_data = pdata->isink[id];
diff -u -p a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
--- a/drivers/watchdog/rza_wdt.c
+++ b/drivers/watchdog/rza_wdt.c
@@ -189,8 +189,8 @@ static int rza_wdt_probe(struct platform
 		return -ENOENT;
 	}

-	priv->wdev.info = &rza_wdt_ident,
-	priv->wdev.ops = &rza_wdt_ops,
+	priv->wdev.info = &rza_wdt_ident;
+	priv->wdev.ops = &rza_wdt_ops;
 	priv->wdev.parent = dev;

 	priv->cks = (u8)(uintptr_t) of_device_get_match_data(dev);
diff -u -p a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -271,7 +271,7 @@ static int pm8941_pwrkey_probe(struct pl
 		return error;
 	}

-	pwrkey->reboot_notifier.notifier_call = pm8941_reboot_notify,
+	pwrkey->reboot_notifier.notifier_call = pm8941_reboot_notify;
 	error = register_reboot_notifier(&pwrkey->reboot_notifier);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register reboot notifier: %d\n",
diff -u -p a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -193,7 +193,7 @@ void __init txx9_clockevent_init(unsigne
 	cd->min_delta_ns = clockevent_delta2ns(0xf, cd);
 	cd->min_delta_ticks = 0xf;
 	cd->irq = irq;
-	cd->cpumask = cpumask_of(0),
+	cd->cpumask = cpumask_of(0);
 	clockevents_register_device(cd);
 	if (request_irq(irq, txx9tmr_interrupt, IRQF_PERCPU | IRQF_TIMER,
 			"txx9tmr", &txx9_clock_event_device))
diff -u -p a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
--- a/arch/mips/kernel/vpe-cmp.c
+++ b/arch/mips/kernel/vpe-cmp.c
@@ -117,8 +117,8 @@ int __init vpe_module_init(void)
 	}

 	device_initialize(&vpe_device);
-	vpe_device.class	= &vpe_class,
-	vpe_device.parent	= NULL,
+	vpe_device.class	= &vpe_class;
+	vpe_device.parent	= NULL;
 	dev_set_name(&vpe_device, "vpe_sp");
 	vpe_device.devt = MKDEV(major, VPE_MODULE_MINOR);
 	err = device_add(&vpe_device);
diff -u -p a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -250,8 +250,8 @@ void __init palm27x_ac97_init(int minv,
 		palm27x_ac97_pdata.codec_pdata[0] = NULL;
 		pxa_set_ac97_info(&palm27x_ac97_pdata);
 	} else {
-		palm27x_batt_pdata.min_voltage	= minv,
-		palm27x_batt_pdata.max_voltage	= maxv,
+		palm27x_batt_pdata.min_voltage	= minv;
+		palm27x_batt_pdata.max_voltage	= maxv;

 		pxa_set_ac97_info(&palm27x_ac97_pdata);
 		platform_device_register(&palm27x_asoc);
diff -u -p a/arch/arm/vfp/vfp.h b/arch/arm/vfp/vfp.h
--- a/arch/arm/vfp/vfp.h
+++ b/arch/arm/vfp/vfp.h
@@ -189,7 +189,7 @@ static inline void vfp_single_unpack(str
 {
 	u32 significand;

-	s->sign = vfp_single_packed_sign(val) >> 16,
+	s->sign = vfp_single_packed_sign(val) >> 16;
 	s->exponent = vfp_single_packed_exponent(val);

 	significand = (u32) val;
diff -u -p a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -643,7 +643,7 @@ static int __cmd_inject(struct perf_inje
 		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
 		inject->tool.auxtrace	    = perf_event__process_auxtrace;
 		inject->tool.aux	    = perf_event__drop_aux;
-		inject->tool.itrace_start   = perf_event__drop_aux,
+		inject->tool.itrace_start   = perf_event__drop_aux;
 		inject->tool.ordered_events = true;
 		inject->tool.ordering_requires_timestamps = true;
 		/* Allow space in the header for new attributes */
diff -u -p a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -580,7 +580,7 @@ static void *uffd_poll_thread(void *arg)
 			perror("poll"), exit(1);
 		if (pollfd[1].revents & POLLIN) {
 			if (read(pollfd[1].fd, &tmp_chr, 1) != 1)
-				fprintf(stderr, "read pipefd error\n"),
+				fprintf(stderr, "read pipefd error\n");
 					exit(1);
 			break;
 		}
@@ -944,7 +944,7 @@ static int __uffdio_zeropage(int ufd, un
 		/* real retval in ufdio_zeropage.zeropage */
 		if (has_zeropage) {
 			if (uffdio_zeropage.zeropage == -EEXIST)
-				fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n"),
+				fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n");
 					exit(1);
 			else
 				fprintf(stderr, "UFFDIO_ZEROPAGE error %Ld\n",
@@ -1007,7 +1007,7 @@ static int userfaultfd_zeropage_test(voi
 	if ((uffdio_register.ioctls & expected_ioctls) !=
 	    expected_ioctls)
 		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
+			"unexpected missing ioctl for anon memory\n");
 			exit(1);

 	if (uffdio_zeropage(uffd, 0)) {
@@ -1054,7 +1054,7 @@ static int userfaultfd_events_test(void)
 	if ((uffdio_register.ioctls & expected_ioctls) !=
 	    expected_ioctls)
 		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
+			"unexpected missing ioctl for anon memory\n");
 			exit(1);

 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
@@ -1117,7 +1117,7 @@ static int userfaultfd_sig_test(void)
 	if ((uffdio_register.ioctls & expected_ioctls) !=
 	    expected_ioctls)
 		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
+			"unexpected missing ioctl for anon memory\n");
 			exit(1);

 	if (faulting_process(1))
@@ -1404,7 +1404,7 @@ static void set_test_type(const char *ty
 		page_size = sysconf(_SC_PAGE_SIZE);

 	if (!page_size)
-		fprintf(stderr, "Unable to determine page size\n"),
+		fprintf(stderr, "Unable to determine page size\n");
 				exit(2);
 	if ((unsigned long) area_count(NULL, 0) + sizeof(unsigned long long) * 2
 	    > page_size)
diff -u -p a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -274,7 +274,7 @@ static ssize_t sta_aql_read(struct file
 		"Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/%u\n",
 		q_depth[0], q_depth[1], q_depth[2], q_depth[3],
 		q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
-		q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]),
+		q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]);

 	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 	kfree(buf);
diff -u -p a/net/ipv6/calipso.c b/net/ipv6/calipso.c
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -761,7 +761,7 @@ static int calipso_genopt(unsigned char
 	calipso[1] = len - 2;
 	*(__be32 *)(calipso + 2) = htonl(doi_def->doi);
 	calipso[6] = (len - CALIPSO_HDR_LEN) / 4;
-	calipso[7] = secattr->attr.mls.lvl,
+	calipso[7] = secattr->attr.mls.lvl;
 	crc = ~crc_ccitt(0xffff, calipso, len);
 	calipso[8] = crc & 0xff;
 	calipso[9] = (crc >> 8) & 0xff;
diff -u -p a/net/ipv6/route.c b/net/ipv6/route.c
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4202,7 +4202,7 @@ static struct fib6_info *rt6_add_route_i
 		.fc_nlinfo.nl_net = net,
 	};

-	cfg.fc_table = l3mdev_fib_table(dev) ? : RT6_TABLE_INFO,
+	cfg.fc_table = l3mdev_fib_table(dev) ? : RT6_TABLE_INFO;
 	cfg.fc_dst = *prefix;
 	cfg.fc_gateway = *gwaddr;

diff -u -p a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -177,7 +177,7 @@ static int zcrypt_cex2a_queue_probe(stru
 	atomic_set(&zq->load, 0);
 	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
-	aq->request_timeout = CEX2A_CLEANUP_TIME,
+	aq->request_timeout = CEX2A_CLEANUP_TIME;
 	aq->private = zq;
 	rc = zcrypt_queue_register(zq);
 	if (rc) {
diff -u -p a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -616,7 +616,7 @@ static int zcrypt_cex4_queue_probe(struc
 	atomic_set(&zq->load, 0);
 	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
-	aq->request_timeout = CEX4_CLEANUP_TIME,
+	aq->request_timeout = CEX4_CLEANUP_TIME;
 	aq->private = zq;
 	rc = zcrypt_queue_register(zq);
 	if (rc) {
diff -u -p a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
--- a/drivers/clk/uniphier/clk-uniphier-mux.c
+++ b/drivers/clk/uniphier/clk-uniphier-mux.c
@@ -70,7 +70,7 @@ struct clk_hw *uniphier_clk_register_mux
 	init.ops = &uniphier_clk_mux_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = data->parent_names;
-	init.num_parents = data->num_parents,
+	init.num_parents = data->num_parents;

 	mux->regmap = regmap;
 	mux->reg = data->reg;
diff -u -p a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -121,11 +121,11 @@ static int imx_iim_probe(struct platform
 	if (IS_ERR(iim->clk))
 		return PTR_ERR(iim->clk);

-	cfg.name = "imx-iim",
-	cfg.read_only = true,
-	cfg.word_size = 1,
-	cfg.stride = 1,
-	cfg.reg_read = imx_iim_read,
+	cfg.name = "imx-iim";
+	cfg.read_only = true;
+	cfg.word_size = 1;
+	cfg.stride = 1;
+	cfg.reg_read = imx_iim_read;
 	cfg.dev = dev;
 	cfg.size = drvdata->nregs;
 	cfg.priv = iim;
diff -u -p a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
--- a/drivers/tty/hvc/hvsi_lib.c
+++ b/drivers/tty/hvc/hvsi_lib.c
@@ -301,7 +301,7 @@ int hvsilib_write_mctrl(struct hvsi_priv
 	pr_devel("HVSI@%x: %s DTR...\n", pv->termno,
 		 dtr ? "Setting" : "Clearing");

-	ctrl.hdr.type = VS_CONTROL_PACKET_HEADER,
+	ctrl.hdr.type = VS_CONTROL_PACKET_HEADER;
 	ctrl.hdr.len = sizeof(struct hvsi_control);
 	ctrl.verb = cpu_to_be16(VSV_SET_MODEM_CTL);
 	ctrl.mask = cpu_to_be32(HVSI_TSDTR);
diff -u -p a/drivers/tty/moxa.c b/drivers/tty/moxa.c
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -2036,10 +2036,10 @@ static int moxa_get_serial_info(struct t
 	if (!info)
 		return -ENODEV;
 	mutex_lock(&info->port.mutex);
-	ss->type = info->type,
-	ss->line = info->port.tty->index,
-	ss->flags = info->port.flags,
-	ss->baud_base = 921600,
+	ss->type = info->type;
+	ss->line = info->port.tty->index;
+	ss->flags = info->port.flags;
+	ss->baud_base = 921600;
 	ss->close_delay = info->port.close_delay;
 	mutex_unlock(&info->port.mutex);
 	return 0;
diff -u -p a/drivers/media/usb/dvb-usb/dib0700_devices.c b/drivers/media/usb/dvb-usb/dib0700_devices.c
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -3079,8 +3079,8 @@ static int nim7090_tuner_attach(struct d
 	struct dib0700_adapter_state *st = adap->priv;
 	struct i2c_adapter *tun_i2c = st->dib7000p_ops.get_i2c_tuner(adap->fe_adap[0].fe);

-	nim7090_dib0090_config.reset = st->dib7000p_ops.tuner_sleep,
-	nim7090_dib0090_config.sleep = st->dib7000p_ops.tuner_sleep,
+	nim7090_dib0090_config.reset = st->dib7000p_ops.tuner_sleep;
+	nim7090_dib0090_config.sleep = st->dib7000p_ops.tuner_sleep;
 	nim7090_dib0090_config.get_adc_power = st->dib7000p_ops.get_adc_power;

 	if (dvb_attach(dib0090_register, adap->fe_adap[0].fe, tun_i2c, &nim7090_dib0090_config) == NULL)
diff -u -p a/drivers/media/usb/em28xx/em28xx-audio.c b/drivers/media/usb/em28xx/em28xx-audio.c
--- a/drivers/media/usb/em28xx/em28xx-audio.c
+++ b/drivers/media/usb/em28xx/em28xx-audio.c
@@ -583,9 +583,9 @@ static int em28xx_cvol_new(struct snd_ca
 	struct snd_kcontrol_new tmp;

 	memset(&tmp, 0, sizeof(tmp));
-	tmp.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	tmp.private_value = id,
-	tmp.name  = ctl_name,
+	tmp.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	tmp.private_value = id;
+	tmp.name  = ctl_name;

 	/* Add Mute Control */
 	sprintf(ctl_name, "%s Switch", name);
@@ -600,16 +600,16 @@ static int em28xx_cvol_new(struct snd_ca
 		ctl_name, id);

 	memset(&tmp, 0, sizeof(tmp));
-	tmp.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	tmp.private_value = id,
-	tmp.name  = ctl_name,
+	tmp.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	tmp.private_value = id;
+	tmp.name  = ctl_name;

 	/* Add Volume Control */
 	sprintf(ctl_name, "%s Volume", name);
 	tmp.get   = em28xx_vol_get;
 	tmp.put   = em28xx_vol_put;
 	tmp.info  = em28xx_vol_info;
-	tmp.tlv.p = em28xx_db_scale,
+	tmp.tlv.p = em28xx_db_scale;
 	kctl = snd_ctl_new1(&tmp, dev);
 	err = snd_ctl_add(card, kctl);
 	if (err < 0)
diff -u -p a/drivers/media/usb/dvb-usb-v2/lmedm04.c b/drivers/media/usb/dvb-usb-v2/lmedm04.c
--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -391,7 +391,7 @@ static int lme2510_int_read(struct dvb_u
 	ep = usb_pipe_endpoint(d->udev, lme_int->lme_urb->pipe);

 	if (usb_endpoint_type(&ep->desc) == USB_ENDPOINT_XFER_BULK)
-		lme_int->lme_urb->pipe = usb_rcvbulkpipe(d->udev, 0xa),
+		lme_int->lme_urb->pipe = usb_rcvbulkpipe(d->udev, 0xa);

 	usb_submit_urb(lme_int->lme_urb, GFP_ATOMIC);
 	info("INT Interrupt Service Started");
diff -u -p a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -1056,13 +1056,13 @@ static int rtl2832_probe(struct i2c_clie
 	dev->sleeping = true;
 	INIT_DELAYED_WORK(&dev->i2c_gate_work, rtl2832_i2c_gate_work);
 	/* create regmap */
-	dev->regmap_config.reg_bits =  8,
-	dev->regmap_config.val_bits =  8,
-	dev->regmap_config.volatile_reg = rtl2832_volatile_reg,
-	dev->regmap_config.max_register = 5 * 0x100,
-	dev->regmap_config.ranges = regmap_range_cfg,
-	dev->regmap_config.num_ranges = ARRAY_SIZE(regmap_range_cfg),
-	dev->regmap_config.cache_type = REGCACHE_NONE,
+	dev->regmap_config.reg_bits =  8;
+	dev->regmap_config.val_bits =  8;
+	dev->regmap_config.volatile_reg = rtl2832_volatile_reg;
+	dev->regmap_config.max_register = 5 * 0x100;
+	dev->regmap_config.ranges = regmap_range_cfg;
+	dev->regmap_config.num_ranges = ARRAY_SIZE(regmap_range_cfg);
+	dev->regmap_config.cache_type = REGCACHE_NONE;
 	dev->regmap = regmap_init_i2c(client, &dev->regmap_config);
 	if (IS_ERR(dev->regmap)) {
 		ret = PTR_ERR(dev->regmap);
diff -u -p a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1793,9 +1793,9 @@ static int m88ds3103_probe(struct i2c_cl
 	dev->config.lnb_en_pol = pdata->lnb_en_pol;
 	dev->cfg = &dev->config;
 	/* create regmap */
-	dev->regmap_config.reg_bits = 8,
-	dev->regmap_config.val_bits = 8,
-	dev->regmap_config.lock_arg = dev,
+	dev->regmap_config.reg_bits = 8;
+	dev->regmap_config.val_bits = 8;
+	dev->regmap_config.lock_arg = dev;
 	dev->regmap = devm_regmap_init_i2c(client, &dev->regmap_config);
 	if (IS_ERR(dev->regmap)) {
 		ret = PTR_ERR(dev->regmap);
diff -u -p a/drivers/scsi/arm/eesox.c b/drivers/scsi/arm/eesox.c
--- a/drivers/scsi/arm/eesox.c
+++ b/drivers/scsi/arm/eesox.c
@@ -166,10 +166,10 @@ eesoxscsi_dma_setup(struct Scsi_Host *ho
 		bufs = copy_SCp_to_sg(&info->sg[0], SCp, NR_SG);

 		if (direction == DMA_OUT)
-			map_dir = DMA_TO_DEVICE,
+			map_dir = DMA_TO_DEVICE;
 			dma_dir = DMA_MODE_WRITE;
 		else
-			map_dir = DMA_FROM_DEVICE,
+			map_dir = DMA_FROM_DEVICE;
 			dma_dir = DMA_MODE_READ;

 		dma_map_sg(dev, info->sg, bufs, map_dir);
diff -u -p a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -439,7 +439,7 @@ static int ti_eqep_remove(struct platfor
 	struct device *dev = &pdev->dev;

 	counter_unregister(&priv->counter);
-	pm_runtime_put_sync(dev),
+	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);

 	return 0;
diff -u -p a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -994,7 +994,7 @@ imsttfb_fillrect(struct fb_info *info, c
 	bgc |= (bgc << 8);
 	bgc |= (bgc << 16);

-	Bpp = info->var.bits_per_pixel >> 3,
+	Bpp = info->var.bits_per_pixel >> 3;
 	line_pitch = info->fix.line_length;

 	dy = rect->dy * line_pitch;
@@ -1035,7 +1035,7 @@ imsttfb_copyarea(struct fb_info *info, c
 	__u32 Bpp, line_pitch, fb_offset_old, fb_offset_new, sp, dp_octl;
  	__u32 cnt, bltctl, sx, sy, dx, dy, height, width;

-	Bpp = info->var.bits_per_pixel >> 3,
+	Bpp = info->var.bits_per_pixel >> 3;

 	sx = area->sx * Bpp;
 	sy = area->sy;
diff -u -p a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -290,7 +290,7 @@ static int sky81452_bl_probe(struct plat
 	}

 	memset(&props, 0, sizeof(props));
-	props.max_brightness = SKY81452_MAX_BRIGHTNESS,
+	props.max_brightness = SKY81452_MAX_BRIGHTNESS;
 	name = pdata->name ? pdata->name : SKY81452_DEFAULT_NAME;
 	bd = devm_backlight_device_register(dev, name, dev, regmap,
 						&sky81452_bl_ops, &props);
diff -u -p a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -85,7 +85,7 @@ void amdgpu_sa_bo_manager_fini(struct am
 	}

 	if (!list_empty(&sa_manager->olist)) {
-		sa_manager->hole = &sa_manager->olist,
+		sa_manager->hole = &sa_manager->olist;
 		amdgpu_sa_bo_try_free(sa_manager);
 		if (!list_empty(&sa_manager->olist)) {
 			dev_err(adev->dev, "sa_manager is not empty, clearing anyway\n");
diff -u -p a/drivers/gpu/drm/i915/intel_region_lmem.c b/drivers/gpu/drm/i915/intel_region_lmem.c
--- a/drivers/gpu/drm/i915/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/intel_region_lmem.c
@@ -115,7 +115,7 @@ intel_setup_fake_lmem(struct drm_i915_pr

 	/* Your mappable aperture belongs to me now! */
 	mappable_end = pci_resource_len(pdev, 2);
-	io_start = pci_resource_start(pdev, 2),
+	io_start = pci_resource_start(pdev, 2);
 	start = i915->params.fake_lmem_start;

 	mem = intel_memory_region_create(i915,
diff -u -p a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
@@ -285,7 +285,7 @@ nv50_disp_chan_child_get(struct nvkm_obj
 	if (sclass->engine && sclass->engine->func->base.sclass) {
 		sclass->engine->func->base.sclass(sclass, index, &oclass);
 		if (oclass) {
-			sclass->ctor = nv50_disp_chan_child_new,
+			sclass->ctor = nv50_disp_chan_child_new;
 			sclass->priv = oclass;
 			return 0;
 		}
diff -u -p a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1377,15 +1377,15 @@ static int omap_gpio_probe(struct platfo
 	if (!irqc)
 		return -ENOMEM;

-	irqc->irq_startup = omap_gpio_irq_startup,
-	irqc->irq_shutdown = omap_gpio_irq_shutdown,
-	irqc->irq_ack = dummy_irq_chip.irq_ack,
-	irqc->irq_mask = omap_gpio_mask_irq,
-	irqc->irq_unmask = omap_gpio_unmask_irq,
-	irqc->irq_set_type = omap_gpio_irq_type,
-	irqc->irq_set_wake = omap_gpio_wake_enable,
-	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
-	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
+	irqc->irq_startup = omap_gpio_irq_startup;
+	irqc->irq_shutdown = omap_gpio_irq_shutdown;
+	irqc->irq_ack = dummy_irq_chip.irq_ack;
+	irqc->irq_mask = omap_gpio_mask_irq;
+	irqc->irq_unmask = omap_gpio_unmask_irq;
+	irqc->irq_set_type = omap_gpio_irq_type;
+	irqc->irq_set_wake = omap_gpio_wake_enable;
+	irqc->irq_bus_lock = omap_gpio_irq_bus_lock;
+	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock;
 	irqc->name = dev_name(&pdev->dev);
 	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
 	irqc->parent_device = dev;
diff -u -p a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -434,7 +434,7 @@ static int wcove_gpio_probe(struct platf
 	wg->chip.get_direction = wcove_gpio_get_direction;
 	wg->chip.get = wcove_gpio_get;
 	wg->chip.set = wcove_gpio_set;
-	wg->chip.set_config = wcove_gpio_set_config,
+	wg->chip.set_config = wcove_gpio_set_config;
 	wg->chip.base = -1;
 	wg->chip.ngpio = WCOVE_VGPIO_NUM;
 	wg->chip.can_sleep = true;
diff -u -p a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -395,8 +395,8 @@ int rproc_add_virtio_dev(struct rproc_vd
 		ret = -ENOMEM;
 		goto out;
 	}
-	vdev->id.device	= id,
-	vdev->config = &rproc_virtio_config_ops,
+	vdev->id.device	= id;
+	vdev->config = &rproc_virtio_config_ops;
 	vdev->dev.parent = dev;
 	vdev->dev.release = rproc_virtio_dev_release;

diff -u -p a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2356,7 +2356,7 @@ static int marvell_nfc_setup_interface(s
 	 * be greater than that to be sure tCCS delay is respected.
 	 */
 	nfc_tmg.tWHR = TO_CYCLES(max_t(int, sdr->tWHR_min, sdr->tCCS_min),
-				 period_ns) - 2,
+				 period_ns) - 2;
 	nfc_tmg.tRHW = TO_CYCLES(max_t(int, sdr->tRHW_min, sdr->tCCS_min),
 				 period_ns);

diff -u -p a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -577,7 +577,7 @@ static int wm831x_power_probe(struct pla
 		goto err;
 	}

-	power->usb_desc.name = power->usb_name,
+	power->usb_desc.name = power->usb_name;
 	power->usb_desc.type = POWER_SUPPLY_TYPE_USB;
 	power->usb_desc.properties = wm831x_usb_props;
 	power->usb_desc.num_properties = ARRAY_SIZE(wm831x_usb_props);
diff -u -p a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
@@ -233,7 +233,7 @@ static void vema_get_class_port_info(str

 	port_info = (struct opa_class_port_info *)rsp_mad->data;
 	memcpy(port_info, &port->class_port_info, sizeof(*port_info));
-	port_info->base_version = OPA_MGMT_BASE_VERSION,
+	port_info->base_version = OPA_MGMT_BASE_VERSION;
 	port_info->class_version = OPA_EMA_CLASS_VERSION;

 	/*
diff -u -p a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -1737,7 +1737,7 @@ static void qib_setup_7220_setextled(str

 	if (ppd->led_override) {
 		ltst = (ppd->led_override & QIB_LED_PHYS) ?
-			IB_PHYSPORTSTATE_LINKUP : IB_PHYSPORTSTATE_DISABLED,
+			IB_PHYSPORTSTATE_LINKUP : IB_PHYSPORTSTATE_DISABLED;
 		lst = (ppd->led_override & QIB_LED_LOG) ?
 			IB_PORT_ACTIVE : IB_PORT_DOWN;
 	} else if (on) {
diff -u -p a/drivers/infiniband/hw/qib/qib_iba6120.c b/drivers/infiniband/hw/qib/qib_iba6120.c
--- a/drivers/infiniband/hw/qib/qib_iba6120.c
+++ b/drivers/infiniband/hw/qib/qib_iba6120.c
@@ -1448,7 +1448,7 @@ static void qib_6120_setup_setextled(str
 	/* Allow override of LED display for, e.g. Locating system in rack */
 	if (ppd->led_override) {
 		ltst = (ppd->led_override & QIB_LED_PHYS) ?
-			IB_PHYSPORTSTATE_LINKUP : IB_PHYSPORTSTATE_DISABLED,
+			IB_PHYSPORTSTATE_LINKUP : IB_PHYSPORTSTATE_DISABLED;
 		lst = (ppd->led_override & QIB_LED_LOG) ?
 			IB_PORT_ACTIVE : IB_PORT_DOWN;
 	} else if (on) {
diff -u -p a/drivers/infiniband/hw/hfi1/qsfp.c b/drivers/infiniband/hw/hfi1/qsfp.c
--- a/drivers/infiniband/hw/hfi1/qsfp.c
+++ b/drivers/infiniband/hw/hfi1/qsfp.c
@@ -242,7 +242,7 @@ static int i2c_bus_write(struct hfi1_dev
 		msgs[0].buf = offset_bytes;

 		msgs[1].addr = slave_addr;
-		msgs[1].flags = I2C_M_NOSTART,
+		msgs[1].flags = I2C_M_NOSTART;
 		msgs[1].len = len;
 		msgs[1].buf = data;
 		break;
@@ -290,7 +290,7 @@ static int i2c_bus_read(struct hfi1_devd
 		msgs[0].buf = offset_bytes;

 		msgs[1].addr = slave_addr;
-		msgs[1].flags = I2C_M_RD,
+		msgs[1].flags = I2C_M_RD;
 		msgs[1].len = len;
 		msgs[1].buf = data;
 		break;
diff -u -p a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -728,7 +728,7 @@ static int hid_sensor_custom_dev_if_add(

 	sensor_inst->custom_dev.minor = MISC_DYNAMIC_MINOR;
 	sensor_inst->custom_dev.name = dev_name(&sensor_inst->pdev->dev);
-	sensor_inst->custom_dev.fops = &hid_sensor_custom_fops,
+	sensor_inst->custom_dev.fops = &hid_sensor_custom_fops;
 	ret = misc_register(&sensor_inst->custom_dev);
 	if (ret) {
 		kfifo_free(&sensor_inst->data_fifo);
diff -u -p a/drivers/net/ethernet/mellanox/mlx5/core/esw/chains.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/chains.c
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/chains.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/chains.c
@@ -741,7 +741,7 @@ mlx5_esw_chains_create_global_table(stru
 		goto err_ignore;
 	}

-	chain = mlx5_esw_chains_get_chain_range(esw),
+	chain = mlx5_esw_chains_get_chain_range(esw);
 	prio = mlx5_esw_chains_get_prio_range(esw);
 	level = mlx5_esw_chains_get_level_range(esw);

diff -u -p a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -462,7 +462,7 @@ mlx5_eswitch_add_fwd_rule(struct mlx5_es
 		}
 	}
 	dest[i].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest[i].ft = fwd_fdb,
+	dest[i].ft = fwd_fdb;
 	i++;

 	mlx5_eswitch_set_rule_source_port(esw, spec, attr);
diff -u -p a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -365,7 +365,7 @@ int aq_ring_rx_clean(struct aq_ring_s *s
 		if (!buff->is_eop) {
 			buff_ = buff;
 			do {
-				next_ = buff_->next,
+				next_ = buff_->next;
 				buff_ = &self->buff_ring[next_];
 				is_rsc_completed =
 					aq_ring_dx_in_range(self->sw_head,
@@ -388,7 +388,7 @@ int aq_ring_rx_clean(struct aq_ring_s *s
 			    (buff->is_lro && buff->is_cso_err)) {
 				buff_ = buff;
 				do {
-					next_ = buff_->next,
+					next_ = buff_->next;
 					buff_ = &self->buff_ring[next_];

 					buff_->is_cleaned = true;
@@ -468,7 +468,7 @@ int aq_ring_rx_clean(struct aq_ring_s *s
 				buff_ = buff;
 				i = 1U;
 				do {
-					next_ = buff_->next,
+					next_ = buff_->next;
 					buff_ = &self->buff_ring[next_];

 					dma_sync_single_range_for_cpu(
diff -u -p a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -544,9 +544,9 @@ static phy_interface_t hns_mac_get_phy_i
 	obj_args.integer.type = ACPI_TYPE_INTEGER;
 	obj_args.integer.value = mac_cb->mac_id;

-	argv4.type = ACPI_TYPE_PACKAGE,
-	argv4.package.count = 1,
-	argv4.package.elements = &obj_args,
+	argv4.type = ACPI_TYPE_PACKAGE;
+	argv4.package.count = 1;
+	argv4.package.elements = &obj_args;

 	obj = acpi_evaluate_dsm(ACPI_HANDLE(mac_cb->dev),
 				&hns_dsaf_acpi_dsm_guid, 0,
@@ -591,9 +591,9 @@ static int hns_mac_get_sfp_prsnt_acpi(st
 	obj_args.integer.type = ACPI_TYPE_INTEGER;
 	obj_args.integer.value = mac_cb->mac_id;

-	argv4.type = ACPI_TYPE_PACKAGE,
-	argv4.package.count = 1,
-	argv4.package.elements = &obj_args,
+	argv4.type = ACPI_TYPE_PACKAGE;
+	argv4.package.count = 1;
+	argv4.package.elements = &obj_args;

 	obj = acpi_evaluate_dsm(ACPI_HANDLE(mac_cb->dev),
 				&hns_dsaf_acpi_dsm_guid, 0,
diff -u -p a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -1112,7 +1112,7 @@ int ks8851_probe_common(struct net_devic

 	/* setup mii state */
 	ks->mii.dev		= netdev;
-	ks->mii.phy_id		= 1,
+	ks->mii.phy_id		= 1;
 	ks->mii.phy_id_mask	= 1;
 	ks->mii.reg_num_mask	= 0xf;
 	ks->mii.mdio_read	= ks8851_phy_read;
diff -u -p a/drivers/net/ethernet/8390/axnet_cs.c b/drivers/net/ethernet/8390/axnet_cs.c
--- a/drivers/net/ethernet/8390/axnet_cs.c
+++ b/drivers/net/ethernet/8390/axnet_cs.c
@@ -1269,7 +1269,7 @@ static void ei_tx_intr(struct net_device
 			ei_local->txing = 1;
 			NS8390_trigger_send(dev, ei_local->tx2, ei_local->tx_start_page + 6);
 			netif_trans_update(dev);
-			ei_local->tx2 = -1,
+			ei_local->tx2 = -1;
 			ei_local->lasttx = 2;
 		}
 		else ei_local->lasttx = 20, ei_local->txing = 0;
diff -u -p a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1804,7 +1804,7 @@ static int i40e_get_eeprom(struct net_de
 			len = eeprom->len - (I40E_NVM_SECTOR_SIZE * i);
 			last = true;
 		}
-		offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i),
+		offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i);
 		ret_val = i40e_aq_read_nvm(hw, 0x0, offset, len,
 				(u8 *)eeprom_buff + (I40E_NVM_SECTOR_SIZE * i),
 				last, NULL);
diff -u -p a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -1241,7 +1241,7 @@ static int tbnet_probe(struct tb_service
 	dev->max_mtu = TBNET_MAX_MTU - ETH_HLEN;

 	net->handler.uuid = &tbnet_svc_uuid;
-	net->handler.callback = tbnet_handle_packet,
+	net->handler.callback = tbnet_handle_packet;
 	net->handler.data = net;
 	tb_register_protocol_handler(&net->handler);

diff -u -p a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -891,7 +891,7 @@ mt7615_mcu_sta_ba_tlv(struct sk_buff *sk
 	tlv = mt7615_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));

 	ba = (struct sta_rec_ba *)tlv;
-	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT,
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
 	ba->winsize = cpu_to_le16(params->buf_size);
 	ba->ssn = cpu_to_le16(params->ssn);
 	ba->ba_en = enable << params->tid;
@@ -1124,7 +1124,7 @@ mt7615_mcu_wtbl_ht_tlv(struct sk_buff *s
 		tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
 						wtbl_tlv, sta_wtbl);
 		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC,
+		vht->ldpc = sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC;
 		vht->vht = 1;

 		af = (sta->vht_cap.cap &
@@ -2449,7 +2449,7 @@ int mt7615_mcu_init(struct mt7615_dev *d
 	};
 	int ret;

-	dev->mt76.mcu_ops = &mt7615_mcu_ops,
+	dev->mt76.mcu_ops = &mt7615_mcu_ops;

 	ret = mt7615_driver_own(dev);
 	if (ret)
diff -u -p a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
--- a/drivers/clocksource/mps2-timer.c
+++ b/drivers/clocksource/mps2-timer.c
@@ -149,9 +149,9 @@ static int __init mps2_clockevent_init(s
 	ce->clkevt.rating = 200;
 	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->clkevt.cpumask = cpu_possible_mask;
-	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown,
-	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic,
-	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown,
+	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown;
+	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic;
+	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown;
 	ce->clkevt.set_next_event	= mps2_timer_set_next_event;

 	/* Ensure timer is disabled */
diff -u -p a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -181,12 +181,12 @@ static int armada_370_xp_timer_starting_
 		clr = TIMER0_25MHZ;
 	local_timer_ctrl_clrset(clr, set);

-	evt->name		= "armada_370_xp_per_cpu_tick",
+	evt->name		= "armada_370_xp_per_cpu_tick";
 	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_PERIODIC;
-	evt->shift		= 32,
-	evt->rating		= 300,
-	evt->set_next_event	= armada_370_xp_clkevt_next_event,
+	evt->shift		= 32;
+	evt->rating		= 300;
+	evt->set_next_event	= armada_370_xp_clkevt_next_event;
 	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
 	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
 	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;
diff -u -p a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -547,10 +547,10 @@ int mmc_cqe_recovery(struct mmc_host *ho
 	host->cqe_ops->cqe_recovery_start(host);

 	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode       = MMC_STOP_TRANSMISSION,
-	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC,
+	cmd.opcode       = MMC_STOP_TRANSMISSION;
+	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, 0);

 	memset(&cmd, 0, sizeof(cmd));
@@ -558,7 +558,7 @@ int mmc_cqe_recovery(struct mmc_host *ho
 	cmd.arg          = 1; /* Discard entire queue */
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	err = mmc_wait_for_cmd(host, &cmd, 0);

 	host->cqe_ops->cqe_recovery_finish(host);
diff -u -p a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -195,10 +195,10 @@ static int iproc_rng200_probe(struct pla
 		return PTR_ERR(priv->base);
 	}

-	priv->rng.name = "iproc-rng200",
-	priv->rng.read = iproc_rng200_read,
-	priv->rng.init = iproc_rng200_init,
-	priv->rng.cleanup = iproc_rng200_cleanup,
+	priv->rng.name = "iproc-rng200";
+	priv->rng.read = iproc_rng200_read;
+	priv->rng.init = iproc_rng200_init;
+	priv->rng.cleanup = iproc_rng200_cleanup;

 	/* Register driver */
 	ret = devm_hwrng_register(dev, &priv->rng);
diff -u -p a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -382,7 +382,7 @@ static int agp_nvidia_probe(struct pci_d
 		return -ENOMEM;

 	bridge->driver = &nvidia_driver;
-	bridge->dev_private_data = &nvidia_private,
+	bridge->dev_private_data = &nvidia_private;
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;

diff -u -p a/drivers/pinctrl/berlin/pinctrl-as370.c b/drivers/pinctrl/berlin/pinctrl-as370.c
--- a/drivers/pinctrl/berlin/pinctrl-as370.c
+++ b/drivers/pinctrl/berlin/pinctrl-as370.c
@@ -346,9 +346,9 @@ static int as370_pinctrl_probe(struct pl
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-	rmconfig->reg_bits = 32,
-	rmconfig->val_bits = 32,
-	rmconfig->reg_stride = 4,
+	rmconfig->reg_bits = 32;
+	rmconfig->val_bits = 32;
+	rmconfig->reg_stride = 4;
 	rmconfig->max_register = resource_size(res);

 	regmap = devm_regmap_init_mmio(&pdev->dev, base, rmconfig);
diff -u -p a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1742,7 +1742,7 @@ static int at91_gpio_of_irq_setup(struct
 	gpio_irqchip->irq_disable = gpio_irq_mask;
 	gpio_irqchip->irq_mask = gpio_irq_mask;
 	gpio_irqchip->irq_unmask = gpio_irq_unmask;
-	gpio_irqchip->irq_set_wake = gpio_irq_set_wake,
+	gpio_irqchip->irq_set_wake = gpio_irq_set_wake;
 	gpio_irqchip->irq_set_type = at91_gpio->ops->irq_type;

 	/* Disable irqs of this PIO controller */
diff -u -p a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1569,12 +1569,12 @@ static int byt_gpio_probe(struct intel_p
 	if (irq > 0) {
 		struct gpio_irq_chip *girq;

-		vg->irqchip.name = "BYT-GPIO",
-		vg->irqchip.irq_ack = byt_irq_ack,
-		vg->irqchip.irq_mask = byt_irq_mask,
-		vg->irqchip.irq_unmask = byt_irq_unmask,
-		vg->irqchip.irq_set_type = byt_irq_type,
-		vg->irqchip.flags = IRQCHIP_SKIP_SET_WAKE,
+		vg->irqchip.name = "BYT-GPIO";
+		vg->irqchip.irq_ack = byt_irq_ack;
+		vg->irqchip.irq_mask = byt_irq_mask;
+		vg->irqchip.irq_unmask = byt_irq_unmask;
+		vg->irqchip.irq_set_type = byt_irq_type;
+		vg->irqchip.flags = IRQCHIP_SKIP_SET_WAKE;

 		girq = &gc->irq;
 		girq->chip = &vg->irqchip;
diff -u -p a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -310,10 +310,10 @@ static int dc_pinctrl_probe(struct platf
 	if (!pctl_desc)
 		return -ENOMEM;

-	pctl_desc->name	= DRIVER_NAME,
-	pctl_desc->owner = THIS_MODULE,
-	pctl_desc->pctlops = &dc_pinctrl_ops,
-	pctl_desc->pmxops = &dc_pmxops,
+	pctl_desc->name	= DRIVER_NAME;
+	pctl_desc->owner = THIS_MODULE;
+	pctl_desc->pctlops = &dc_pinctrl_ops;
+	pctl_desc->pmxops = &dc_pmxops;
 	pctl_desc->npins = PINS_COUNT;
 	pctl_desc->pins = pins;
 	pmap->desc = pctl_desc;
diff -u -p a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -459,7 +459,7 @@ static void rk808_pm_power_off(void)
 		bit = DEV_OFF;
 		break;
 	case RK808_ID:
-		reg = RK808_DEVCTRL_REG,
+		reg = RK808_DEVCTRL_REG;
 		bit = DEV_OFF_RST;
 		break;
 	case RK818_ID:
diff -u -p a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -806,10 +806,10 @@ static int talitos_register_rng(struct d
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	int err;

-	priv->rng.name		= dev_driver_string(dev),
-	priv->rng.init		= talitos_rng_init,
-	priv->rng.data_present	= talitos_rng_data_present,
-	priv->rng.data_read	= talitos_rng_data_read,
+	priv->rng.name		= dev_driver_string(dev);
+	priv->rng.init		= talitos_rng_init;
+	priv->rng.data_present	= talitos_rng_data_present;
+	priv->rng.data_read	= talitos_rng_data_read;
 	priv->rng.priv		= (unsigned long)dev;

 	err = hwrng_register(&priv->rng);
diff -u -p a/drivers/crypto/amcc/crypto4xx_alg.c b/drivers/crypto/amcc/crypto4xx_alg.c
--- a/drivers/crypto/amcc/crypto4xx_alg.c
+++ b/drivers/crypto/amcc/crypto4xx_alg.c
@@ -55,7 +55,7 @@ static void set_dynamic_sa_command_1(str
 	sa->sa_command_1.w = 0;
 	sa->sa_command_1.bf.crypto_mode31 = (cm & 4) >> 2;
 	sa->sa_command_1.bf.crypto_mode9_8 = cm & 3;
-	sa->sa_command_1.bf.feedback_mode = cfb,
+	sa->sa_command_1.bf.feedback_mode = cfb;
 	sa->sa_command_1.bf.sa_rev = 1;
 	sa->sa_command_1.bf.hmac_muting = hmac_mc;
 	sa->sa_command_1.bf.extended_seq_num = esn;
diff -u -p a/drivers/crypto/hifn_795x.c b/drivers/crypto/hifn_795x.c
--- a/drivers/crypto/hifn_795x.c
+++ b/drivers/crypto/hifn_795x.c
@@ -780,8 +780,8 @@ static int hifn_register_rng(struct hifn
 						   dev->pk_clk_freq) * 256;

 	dev->rng.name		= dev->name;
-	dev->rng.data_present	= hifn_rng_data_present,
-	dev->rng.data_read	= hifn_rng_data_read,
+	dev->rng.data_present	= hifn_rng_data_present;
+	dev->rng.data_read	= hifn_rng_data_read;
 	dev->rng.priv		= (unsigned long)dev;

 	return hwrng_register(&dev->rng);
diff -u -p a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -558,8 +558,8 @@ static int iTCO_wdt_probe(struct platfor
 		break;
 	}

-	p->wddev.info =	&ident,
-	p->wddev.ops = &iTCO_wdt_ops,
+	p->wddev.info =	&ident;
+	p->wddev.ops = &iTCO_wdt_ops;
 	p->wddev.bootstatus = 0;
 	p->wddev.timeout = WATCHDOG_TIMEOUT;
 	watchdog_set_nowayout(&p->wddev, nowayout);
diff -u -p a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
--- a/drivers/watchdog/pm8916_wdt.c
+++ b/drivers/watchdog/pm8916_wdt.c
@@ -185,7 +185,7 @@ static int pm8916_wdt_probe(struct platf
 		return err;
 	}

-	wdt->wdev.ops = &pm8916_wdt_ops,
+	wdt->wdev.ops = &pm8916_wdt_ops;
 	wdt->wdev.parent = dev;
 	wdt->wdev.min_timeout = PM8916_WDT_MIN_TIMEOUT;
 	wdt->wdev.max_timeout = PM8916_WDT_MAX_TIMEOUT;
diff -u -p a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2037,7 +2037,7 @@ static unsigned int input_estimate_event
 		mt_slots = dev->mt->num_slots;
 	} else if (test_bit(ABS_MT_TRACKING_ID, dev->absbit)) {
 		mt_slots = dev->absinfo[ABS_MT_TRACKING_ID].maximum -
-			   dev->absinfo[ABS_MT_TRACKING_ID].minimum + 1,
+			   dev->absinfo[ABS_MT_TRACKING_ID].minimum + 1;
 		mt_slots = clamp(mt_slots, 2, 32);
 	} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
 		mt_slots = 2;
diff -u -p a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -683,7 +683,7 @@ show_cpuinfo (struct seq_file *m, void *
 	for (i = 0; i < ARRAY_SIZE(feature_bits) && size > 1; ++i) {
 		if (mask & feature_bits[i].mask) {
 			cp += snprintf(cp, size, "%s%s", sep,
-				       feature_bits[i].feature_name),
+				       feature_bits[i].feature_name);
 			sep = ", ";
 			mask &= ~feature_bits[i].mask;
 			size = sizeof(features) - (cp - features);
diff -u -p a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -74,10 +74,10 @@ void openrisc_clockevent_init(void)
 #ifdef CONFIG_SMP
 	evt->broadcast = tick_broadcast;
 #endif
-	evt->name = "openrisc_timer_clockevent",
-	evt->features = CLOCK_EVT_FEAT_ONESHOT,
-	evt->rating = 300,
-	evt->set_next_event = openrisc_timer_set_next_event,
+	evt->name = "openrisc_timer_clockevent";
+	evt->features = CLOCK_EVT_FEAT_ONESHOT;
+	evt->rating = 300;
+	evt->set_next_event = openrisc_timer_set_next_event;

 	evt->cpumask = cpumask_of(cpu);

diff -u -p a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -124,7 +124,7 @@ static void do_stf_entry_barrier_fixups(
 	long *start, *end;
 	int i;

-	start = PTRRELOC(&__start___stf_entry_barrier_fixup),
+	start = PTRRELOC(&__start___stf_entry_barrier_fixup);
 	end = PTRRELOC(&__stop___stf_entry_barrier_fixup);

 	instrs[0] = 0x60000000; /* nop */
@@ -176,7 +176,7 @@ static void do_stf_exit_barrier_fixups(e
 	long *start, *end;
 	int i;

-	start = PTRRELOC(&__start___stf_exit_barrier_fixup),
+	start = PTRRELOC(&__start___stf_exit_barrier_fixup);
 	end = PTRRELOC(&__stop___stf_exit_barrier_fixup);

 	instrs[0] = 0x60000000; /* nop */
@@ -240,7 +240,7 @@ void do_rfi_flush_fixups(enum l1d_flush_
 	long *start, *end;
 	int i;

-	start = PTRRELOC(&__start___rfi_flush_fixup),
+	start = PTRRELOC(&__start___rfi_flush_fixup);
 	end = PTRRELOC(&__stop___rfi_flush_fixup);

 	instrs[0] = 0x60000000; /* nop */
@@ -313,7 +313,7 @@ void do_barrier_nospec_fixups(bool enabl
 {
 	void *start, *end;

-	start = PTRRELOC(&__start___barrier_nospec_fixup),
+	start = PTRRELOC(&__start___barrier_nospec_fixup);
 	end = PTRRELOC(&__stop___barrier_nospec_fixup);

 	do_barrier_nospec_fixups_range(enable, start, end);
diff -u -p a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -484,11 +484,11 @@ static int ar2315_pci_probe(struct platf
 	apc->io_res.name = "AR2315 IO space";
 	apc->io_res.start = 0;
 	apc->io_res.end = 0;
-	apc->io_res.flags = IORESOURCE_IO,
+	apc->io_res.flags = IORESOURCE_IO;

 	apc->pci_ctrl.pci_ops = &ar2315_pci_ops;
-	apc->pci_ctrl.mem_resource = &apc->mem_res,
-	apc->pci_ctrl.io_resource = &apc->io_res,
+	apc->pci_ctrl.mem_resource = &apc->mem_res;
+	apc->pci_ctrl.io_resource = &apc->io_res;

 	register_pci_controller(&apc->pci_ctrl);

diff -u -p a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -365,8 +365,8 @@ int __init vpe_module_init(void)
 	}

 	device_initialize(&vpe_device);
-	vpe_device.class	= &vpe_class,
-	vpe_device.parent	= NULL,
+	vpe_device.class	= &vpe_class;
+	vpe_device.parent	= NULL;
 	dev_set_name(&vpe_device, "vpe1");
 	vpe_device.devt = MKDEV(major, VPE_MODULE_MINOR);
 	err = device_add(&vpe_device);
diff -u -p a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -253,7 +253,7 @@ static void __init ixdp425_init(void)

 #if defined(CONFIG_MTD_NAND_PLATFORM) || \
     defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
-	ixdp425_flash_nand_resource.start = IXP4XX_EXP_BUS_BASE(3),
+	ixdp425_flash_nand_resource.start = IXP4XX_EXP_BUS_BASE(3);
 	ixdp425_flash_nand_resource.end   = IXP4XX_EXP_BUS_BASE(3) + 0x10 - 1;

 	gpio_request(IXDP425_NAND_NCE_PIN, "NAND NCE pin");
diff -u -p a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -537,7 +537,7 @@ static int z2_lbs_spi_setup(struct spi_d
 	mdelay(180);

 	spi->bits_per_word = 16;
-	spi->mode = SPI_MODE_2,
+	spi->mode = SPI_MODE_2;

 	spi_setup(spi);

diff -u -p a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -4070,7 +4070,7 @@ xfs_btree_delrec(
 	 * surviving block, and log it.
 	 */
 	xfs_btree_set_numrecs(left, lrecs + rrecs);
-	xfs_btree_get_sibling(cur, right, &cptr, XFS_BB_RIGHTSIB),
+	xfs_btree_get_sibling(cur, right, &cptr, XFS_BB_RIGHTSIB);
 	xfs_btree_set_sibling(cur, left, &cptr, XFS_BB_RIGHTSIB);
 	xfs_btree_log_block(cur, lbp, XFS_BB_NUMRECS | XFS_BB_RIGHTSIB);

diff -u -p a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -511,7 +511,7 @@ xfs_attr_rmtval_set_value(
 		ASSERT((map.br_startblock != DELAYSTARTBLOCK) &&
 		       (map.br_startblock != HOLESTARTBLOCK));

-		dblkno = XFS_FSB_TO_DADDR(mp, map.br_startblock),
+		dblkno = XFS_FSB_TO_DADDR(mp, map.br_startblock);
 		dblkcnt = XFS_FSB_TO_BB(mp, map.br_blockcount);

 		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, &bp);
diff -u -p a/fs/ceph/dir.c b/fs/ceph/dir.c
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1324,7 +1324,7 @@ void __ceph_dentry_dir_lease_touch(struc

 	mdsc = ceph_sb_to_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
-	__dentry_dir_lease_touch(mdsc, di),
+	__dentry_dir_lease_touch(mdsc, di);
 	spin_unlock(&mdsc->dentry_list_lock);
 }

diff -u -p a/fs/afs/inode.c b/fs/afs/inode.c
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -494,7 +494,7 @@ static int afs_iget5_set_root(struct ino
 	struct afs_vnode *vnode = AFS_FS_I(inode);

 	vnode->volume		= as->volume;
-	vnode->fid.vid		= as->volume->vid,
+	vnode->fid.vid		= as->volume->vid;
 	vnode->fid.vnode	= 1;
 	vnode->fid.unique	= 1;
 	inode->i_ino		= 1;
@@ -527,7 +527,7 @@ struct inode *afs_root_iget(struct super
 	BUG_ON(!(inode->i_state & I_NEW));

 	vnode = AFS_FS_I(inode);
-	vnode->cb_v_break = as->volume->cb_v_break,
+	vnode->cb_v_break = as->volume->cb_v_break;

 	op = afs_alloc_operation(key, as->volume);
 	if (IS_ERR(op)) {
diff -u -p a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -863,8 +863,8 @@ static int skeleton_probe(struct pci_dev
 	 * function. The release callback must be non-NULL.
 	 */
 	vdev->release = video_device_release_empty;
-	vdev->fops = &skel_fops,
-	vdev->ioctl_ops = &skel_ioctl_ops,
+	vdev->fops = &skel_fops;
+	vdev->ioctl_ops = &skel_ioctl_ops;
 	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 			    V4L2_CAP_STREAMING;
 	/*
diff -u -p a/block/bsg-lib.c b/block/bsg-lib.c
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -378,7 +378,7 @@ struct request_queue *bsg_setup_queue(st
 	bset->timeout_fn = timeout;

 	set = &bset->tag_set;
-	set->ops = &bsg_mq_ops,
+	set->ops = &bsg_mq_ops;
 	set->nr_hw_queues = 1;
 	set->queue_depth = 128;
 	set->numa_node = NUMA_NO_NODE;
diff -u -p a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1833,8 +1833,8 @@ static int data_init(int argc, const cha
 		struct perf_data *data = &d->data;

 		data->path  = use_default ? defaults[i] : argv[i];
-		data->mode  = PERF_DATA_MODE_READ,
-		data->force = force,
+		data->mode  = PERF_DATA_MODE_READ;
+		data->force = force;

 		d->idx  = i;
 	}
diff -u -p a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -928,7 +928,7 @@ int symbol__tui_annotate(struct map_symb

 	browser.b.width = notes->max_line_len;
 	browser.b.nr_entries = notes->nr_entries;
-	browser.b.entries = &notes->src->source,
+	browser.b.entries = &notes->src->source;
 	browser.b.width += 18; /* Percentage */

 	if (notes->options->hide_src_code)
diff -u -p a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -190,7 +190,7 @@ void __ui__info_window(const char *title
 	nr_lines += 2;
 	if (exit_msg)
 		nr_lines += 2;
-	y = SLtt_Screen_Rows / 2 - nr_lines / 2,
+	y = SLtt_Screen_Rows / 2 - nr_lines / 2;
 	x = SLtt_Screen_Cols / 2 - max_len / 2;

 	SLsmg_set_color(0);
diff -u -p a/net/smc/smc_clc.c b/net/smc/smc_clc.c
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -603,7 +603,7 @@ int smc_clc_send_accept(struct smc_sock
 		aclc.rmbe_idx = 1;		/* as long as 1 RMB = 1 RMBE */
 		aclc.rmbe_alert_token = htonl(conn->alert_token_local);
 		aclc.qp_mtu = link->path_mtu;
-		aclc.rmbe_size = conn->rmbe_size_short,
+		aclc.rmbe_size = conn->rmbe_size_short;
 		aclc.rmb_dma_addr = cpu_to_be64((u64)sg_dma_address
 				(conn->rmb_desc->sgt[link->link_idx].sgl));
 		hton24(aclc.psn, link->psn_initial);
diff -u -p a/net/tls/tls_main.c b/net/tls/tls_main.c
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -860,7 +860,7 @@ static int __init tls_register(void)

 	tls_sw_proto_ops = inet_stream_ops;
 	tls_sw_proto_ops.splice_read = tls_sw_splice_read;
-	tls_sw_proto_ops.sendpage_locked   = tls_sw_sendpage_locked,
+	tls_sw_proto_ops.sendpage_locked   = tls_sw_sendpage_locked;

 	tls_device_init();
 	tcp_register_ulp(&tcp_tls_ulp_ops);
diff -u -p a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -3019,11 +3019,11 @@ static int madera_hw_params_rate(struct
 		tar = 2 << MADERA_AIF1_RATE_SHIFT;
 		break;
 	case MADERA_CLK_ASYNCCLK_1:
-		reg = MADERA_ASYNC_SAMPLE_RATE_1,
+		reg = MADERA_ASYNC_SAMPLE_RATE_1;
 		tar = 8 << MADERA_AIF1_RATE_SHIFT;
 		break;
 	case MADERA_CLK_ASYNCCLK_2:
-		reg = MADERA_ASYNC_SAMPLE_RATE_2,
+		reg = MADERA_ASYNC_SAMPLE_RATE_2;
 		tar = 9 << MADERA_AIF1_RATE_SHIFT;
 		break;
 	default:
diff -u -p a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -143,7 +143,7 @@ static int byt_rt5651_prepare_and_enable

 	/* Configure the PLL before selecting it */
 	if (!(byt_rt5651_quirk & BYT_RT5651_MCLK_EN)) {
-		clk_id = RT5651_PLL1_S_BCLK1,
+		clk_id = RT5651_PLL1_S_BCLK1;
 		clk_freq = rate * bclk_ratio;
 	} else {
 		clk_id = RT5651_PLL1_S_MCLK;
diff -u -p a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2451,7 +2451,7 @@ static int alloc_generic_hdmi(struct hda
 	spec->chmap.ops.get_chmap = hdmi_get_chmap;
 	spec->chmap.ops.set_chmap = hdmi_set_chmap;
 	spec->chmap.ops.is_pcm_attached = is_hdmi_pcm_attached;
-	spec->chmap.ops.get_spk_alloc = hdmi_get_spk_alloc,
+	spec->chmap.ops.get_spk_alloc = hdmi_get_spk_alloc;

 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
diff -u -p a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -148,7 +148,7 @@ pcm_init_hw_params(struct snd_efw *efw,
 	}

 	/* limit rates */
-	runtime->hw.rates = efw->supported_sampling_rate,
+	runtime->hw.rates = efw->supported_sampling_rate;
 	snd_pcm_limit_hw_rates(runtime);

 	limit_channels(&runtime->hw, pcm_channels);
diff -u -p a/kernel/sched/fair.c b/kernel/sched/fair.c
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11208,7 +11208,7 @@ void show_numa_stats(struct task_struct
 			tpf = p->numa_faults[task_faults_idx(NUMA_MEM, node, 1)];
 		}
 		if (ng) {
-			gsf = ng->faults[task_faults_idx(NUMA_MEM, node, 0)],
+			gsf = ng->faults[task_faults_idx(NUMA_MEM, node, 0)];
 			gpf = ng->faults[task_faults_idx(NUMA_MEM, node, 1)];
 		}
 		print_numa_stats(m, node, tsf, tpf, gsf, gpf);
diff -u -p a/kernel/audit.c b/kernel/audit.c
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2283,7 +2283,7 @@ static void audit_log_set_loginuid(kuid_

 	uid = from_kuid(&init_user_ns, task_uid(current));
 	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
-	loginuid = from_kuid(&init_user_ns, kloginuid),
+	loginuid = from_kuid(&init_user_ns, kloginuid);
 	tty = audit_get_tty();

 	audit_log_format(ab, "pid=%d uid=%u", task_tgid_nr(current), uid);
diff -u -p a/drivers/leds/leds-ariel.c b/drivers/leds/leds-ariel.c
--- a/drivers/leds/leds-ariel.c
+++ b/drivers/leds/leds-ariel.c
@@ -96,14 +96,14 @@ static int ariel_led_probe(struct platfo
 		return -ENOMEM;

 	leds[0].ec_index = EC_BLUE_LED;
-	leds[0].led_cdev.name = "blue:power",
+	leds[0].led_cdev.name = "blue:power";
 	leds[0].led_cdev.default_trigger = "default-on";

 	leds[1].ec_index = EC_AMBER_LED;
-	leds[1].led_cdev.name = "amber:status",
+	leds[1].led_cdev.name = "amber:status";

 	leds[2].ec_index = EC_GREEN_LED;
-	leds[2].led_cdev.name = "green:status",
+	leds[2].led_cdev.name = "green:status";
 	leds[2].led_cdev.default_trigger = "default-on";

 	for (i = 0; i < NLEDS; i++) {
diff -u -p a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -679,7 +679,7 @@ static int lm3533_led_probe(struct platf
 	led->cdev.brightness_get = lm3533_led_get;
 	led->cdev.blink_set = lm3533_led_blink_set;
 	led->cdev.brightness = LED_OFF;
-	led->cdev.groups = lm3533_led_attribute_groups,
+	led->cdev.groups = lm3533_led_attribute_groups;
 	led->id = pdev->id;

 	mutex_init(&led->mutex);
diff -u -p a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -855,7 +855,7 @@ static int pci_endpoint_test_probe(struc
 		err = -ENOMEM;
 		goto err_release_irq;
 	}
-	misc_device->fops = &pci_endpoint_test_fops,
+	misc_device->fops = &pci_endpoint_test_fops;

 	err = misc_register(misc_device);
 	if (err) {
diff -u -p a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -173,9 +173,9 @@ static int intel_xhci_usb_probe(struct p
 	if (ret)
 		return ret;

-	sw_desc.set = intel_xhci_usb_set_role,
-	sw_desc.get = intel_xhci_usb_get_role,
-	sw_desc.allow_userspace_control = true,
+	sw_desc.set = intel_xhci_usb_set_role;
+	sw_desc.get = intel_xhci_usb_get_role;
+	sw_desc.allow_userspace_control = true;
 	sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);
 	sw_desc.driver_data = data;

diff -u -p a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -220,11 +220,11 @@ int ucsi_register_port_psy(struct ucsi_c
 		return -ENOMEM;

 	con->psy_desc.name = psy_name;
-	con->psy_desc.type = POWER_SUPPLY_TYPE_USB,
+	con->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 	con->psy_desc.usb_types = ucsi_psy_usb_types;
 	con->psy_desc.num_usb_types = ARRAY_SIZE(ucsi_psy_usb_types);
-	con->psy_desc.properties = ucsi_psy_props,
-	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props),
+	con->psy_desc.properties = ucsi_psy_props;
+	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props);
 	con->psy_desc.get_property = ucsi_psy_get_prop;

 	con->psy = power_supply_register(dev, &con->psy_desc, &psy_cfg);
diff -u -p a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -1566,13 +1566,13 @@ isp1301_probe(struct i2c_client *i2c, co

 	isp->phy.dev = &i2c->dev;
 	isp->phy.label = DRIVER_NAME;
-	isp->phy.set_power = isp1301_set_power,
+	isp->phy.set_power = isp1301_set_power;

 	isp->phy.otg->usb_phy = &isp->phy;
-	isp->phy.otg->set_host = isp1301_set_host,
-	isp->phy.otg->set_peripheral = isp1301_set_peripheral,
-	isp->phy.otg->start_srp = isp1301_start_srp,
-	isp->phy.otg->start_hnp = isp1301_start_hnp,
+	isp->phy.otg->set_host = isp1301_set_host;
+	isp->phy.otg->set_peripheral = isp1301_set_peripheral;
+	isp->phy.otg->start_srp = isp1301_start_srp;
+	isp->phy.otg->start_hnp = isp1301_start_hnp;

 	enable_vbus_draw(isp, 0);
 	power_down(isp);
diff -u -p a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -2246,7 +2246,7 @@ static int isp1362_mem_config(struct usb
 	spin_lock_irqsave(&isp1362_hcd->lock, flags);

 	for (i = 0; i < 2; i++) {
-		isp1362_hcd->istl_queue[i].buf_start = i * istl_size / 2,
+		isp1362_hcd->istl_queue[i].buf_start = i * istl_size / 2;
 		isp1362_hcd->istl_queue[i].buf_size = istl_size / 2;
 		isp1362_hcd->istl_queue[i].blk_size = 4;
 		INIT_LIST_HEAD(&isp1362_hcd->istl_queue[i].active);
diff -u -p a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1994,12 +1994,12 @@ static int __init acm_init(void)
 	acm_tty_driver = alloc_tty_driver(ACM_TTY_MINORS);
 	if (!acm_tty_driver)
 		return -ENOMEM;
-	acm_tty_driver->driver_name = "acm",
-	acm_tty_driver->name = "ttyACM",
-	acm_tty_driver->major = ACM_TTY_MAJOR,
-	acm_tty_driver->minor_start = 0,
-	acm_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
-	acm_tty_driver->subtype = SERIAL_TYPE_NORMAL,
+	acm_tty_driver->driver_name = "acm";
+	acm_tty_driver->name = "ttyACM";
+	acm_tty_driver->major = ACM_TTY_MAJOR;
+	acm_tty_driver->minor_start = 0;
+	acm_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
+	acm_tty_driver->subtype = SERIAL_TYPE_NORMAL;
 	acm_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	acm_tty_driver->init_termios = tty_std_termios;
 	acm_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD |
diff -u -p a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
--- a/drivers/reset/reset-lpc18xx.c
+++ b/drivers/reset/reset-lpc18xx.c
@@ -198,8 +198,8 @@ static int lpc18xx_rgu_probe(struct plat
 		goto dis_clks;
 	}

-	rc->restart_nb.priority = 192,
-	rc->restart_nb.notifier_call = lpc18xx_rgu_restart,
+	rc->restart_nb.priority = 192;
+	rc->restart_nb.notifier_call = lpc18xx_rgu_restart;
 	ret = register_restart_handler(&rc->restart_nb);
 	if (ret)
 		dev_warn(&pdev->dev, "failed to register restart handler\n");
diff -u -p a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -269,8 +269,8 @@ static int npcm_rc_probe(struct platform
 	if (!of_property_read_u32(pdev->dev.of_node, "nuvoton,sw-reset-number",
 				  &rc->sw_reset_number)) {
 		if (rc->sw_reset_number && rc->sw_reset_number < 5) {
-			rc->restart_nb.priority = 192,
-			rc->restart_nb.notifier_call = npcm_rc_restart,
+			rc->restart_nb.priority = 192;
+			rc->restart_nb.notifier_call = npcm_rc_restart;
 			ret = register_restart_handler(&rc->restart_nb);
 			if (ret)
 				dev_warn(&pdev->dev, "failed to register restart handler\n");
diff -u -p a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
--- a/drivers/clk/mvebu/ap-cpu-clk.c
+++ b/drivers/clk/mvebu/ap-cpu-clk.c
@@ -197,7 +197,7 @@ static int ap_cpu_clk_set_rate(struct cl

 	stable_bit = BIT(clk->pll_regs->ratio_state_offset +
 			 clk->cluster *
-			 clk->pll_regs->ratio_state_cluster_offset),
+			 clk->pll_regs->ratio_state_cluster_offset);
 	ret = regmap_read_poll_timeout(clk->pll_cr_base,
 				       clk->pll_regs->ratio_state_reg, reg,
 				       reg & stable_bit, STATUS_POLL_PERIOD_US,
diff -u -p a/drivers/clk/uniphier/clk-uniphier-cpugear.c b/drivers/clk/uniphier/clk-uniphier-cpugear.c
--- a/drivers/clk/uniphier/clk-uniphier-cpugear.c
+++ b/drivers/clk/uniphier/clk-uniphier-cpugear.c
@@ -90,7 +90,7 @@ struct clk_hw *uniphier_clk_register_cpu
 	init.ops = &uniphier_clk_cpugear_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = data->parent_names;
-	init.num_parents = data->num_parents,
+	init.num_parents = data->num_parents;

 	gear->regmap = regmap;
 	gear->regbase = data->regbase;
diff -u -p a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -57,7 +57,7 @@ int meson_aoclkc_probe(struct platform_d
 	rstc->data = data;
 	rstc->regmap = regmap;
 	rstc->reset.ops = &meson_aoclk_reset_ops;
-	rstc->reset.nr_resets = data->num_reset,
+	rstc->reset.nr_resets = data->num_reset;
 	rstc->reset.of_node = dev->of_node;
 	ret = devm_reset_controller_register(dev, &rstc->reset);
 	if (ret) {
diff -u -p a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -404,7 +404,7 @@ STORE(__cached_dev)
 		if (!env)
 			return -ENOMEM;
 		add_uevent_var(env, "DRIVER=bcache");
-		add_uevent_var(env, "CACHED_UUID=%pU", dc->sb.uuid),
+		add_uevent_var(env, "CACHED_UUID=%pU", dc->sb.uuid);
 		add_uevent_var(env, "CACHED_LABEL=%s", buf);
 		kobject_uevent_env(&disk_to_dev(dc->disk.disk)->kobj,
 				   KOBJ_CHANGE,
diff -u -p a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
--- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -248,7 +248,7 @@ static int au0828_init_isoc(struct au082
 		memset(dev->isoc_ctl.transfer_buffer[i], 0, sb_size);

 		pipe = usb_rcvisocpipe(dev->usbdev,
-				       dev->isoc_in_endpointaddr),
+				       dev->isoc_in_endpointaddr);

 		usb_fill_int_urb(urb, dev->usbdev, pipe,
 				 dev->isoc_ctl.transfer_buffer[i], sb_size,
diff -u -p a/drivers/media/usb/gspca/ov534.c b/drivers/media/usb/gspca/ov534.c
--- a/drivers/media/usb/gspca/ov534.c
+++ b/drivers/media/usb/gspca/ov534.c
@@ -1220,9 +1220,9 @@ static int sd_init_controls(struct gspca
 	int hflip_def;

 	if (sd->sensor == SENSOR_OV767x) {
-		saturation_min = 0,
-		saturation_max = 6,
-		saturation_def = 3,
+		saturation_min = 0;
+		saturation_max = 6;
+		saturation_def = 3;
 		brightness_min = -127;
 		brightness_max = 127;
 		brightness_def = 0;
@@ -1233,9 +1233,9 @@ static int sd_init_controls(struct gspca
 		exposure_def = 0x13;
 		hflip_def = 1;
 	} else {
-		saturation_min = 0,
-		saturation_max = 255,
-		saturation_def = 64,
+		saturation_min = 0;
+		saturation_max = 255;
+		saturation_def = 64;
 		brightness_min = 0;
 		brightness_max = 255;
 		brightness_def = 0;
diff -u -p a/drivers/media/usb/pvrusb2/pvrusb2-devattr.c b/drivers/media/usb/pvrusb2/pvrusb2-devattr.c
--- a/drivers/media/usb/pvrusb2/pvrusb2-devattr.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-devattr.c
@@ -594,7 +594,7 @@ static int pvr2_lgdt3306a_attach(struct
 	lgdt3306a_config.mpeg_mode = LGDT3306A_MPEG_PARALLEL;
 	lgdt3306a_config.tpclk_edge = LGDT3306A_TPCLK_FALLING_EDGE;
 	lgdt3306a_config.tpvalid_polarity = LGDT3306A_TP_VALID_LOW;
-	lgdt3306a_config.xtalMHz = 25, /* demod clock MHz; 24/25 supported */
+	lgdt3306a_config.xtalMHz = 25; /* demod clock MHz; 24/25 supported */

 	adap->i2c_client_demod[0] = dvb_module_probe("lgdt3306a", NULL,
 						     &adap->channel.hdw->i2c_adap,
diff -u -p a/drivers/media/usb/dvb-usb-v2/dvbsky.c b/drivers/media/usb/dvb-usb-v2/dvbsky.c
--- a/drivers/media/usb/dvb-usb-v2/dvbsky.c
+++ b/drivers/media/usb/dvb-usb-v2/dvbsky.c
@@ -287,8 +287,8 @@ static int dvbsky_s960_attach(struct dvb
 	m88ds3103_pdata.ts_clk = 16000;
 	m88ds3103_pdata.ts_clk_pol = 0;
 	m88ds3103_pdata.agc = 0x99;
-	m88ds3103_pdata.lnb_hv_pol = 1,
-	m88ds3103_pdata.lnb_en_pol = 1,
+	m88ds3103_pdata.lnb_hv_pol = 1;
+	m88ds3103_pdata.lnb_en_pol = 1;

 	state->i2c_client_demod = dvb_module_probe("m88ds3103", NULL,
 						   &d->i2c_adap,
@@ -383,15 +383,15 @@ static int dvbsky_s960c_attach(struct dv
 	struct sp2_config sp2_config = {};

 	/* attach demod */
-	m88ds3103_pdata.clk = 27000000,
-	m88ds3103_pdata.i2c_wr_max = 33,
-	m88ds3103_pdata.clk_out = 0,
-	m88ds3103_pdata.ts_mode = M88DS3103_TS_CI,
-	m88ds3103_pdata.ts_clk = 10000,
-	m88ds3103_pdata.ts_clk_pol = 1,
-	m88ds3103_pdata.agc = 0x99,
-	m88ds3103_pdata.lnb_hv_pol = 0,
-	m88ds3103_pdata.lnb_en_pol = 1,
+	m88ds3103_pdata.clk = 27000000;
+	m88ds3103_pdata.i2c_wr_max = 33;
+	m88ds3103_pdata.clk_out = 0;
+	m88ds3103_pdata.ts_mode = M88DS3103_TS_CI;
+	m88ds3103_pdata.ts_clk = 10000;
+	m88ds3103_pdata.ts_clk_pol = 1;
+	m88ds3103_pdata.agc = 0x99;
+	m88ds3103_pdata.lnb_hv_pol = 0;
+	m88ds3103_pdata.lnb_en_pol = 1;

 	state->i2c_client_demod = dvb_module_probe("m88ds3103", NULL,
 						   &d->i2c_adap,
diff -u -p a/drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c
@@ -363,7 +363,7 @@ int sun4i_csi_v4l2_register(struct sun4i
 	vdev->lock = &csi->lock;

 	/* Set a default format */
-	csi->fmt.pixelformat = sun4i_csi_formats[0].fourcc,
+	csi->fmt.pixelformat = sun4i_csi_formats[0].fourcc;
 	csi->fmt.width = CSI_DEFAULT_WIDTH;
 	csi->fmt.height = CSI_DEFAULT_HEIGHT;
 	_sun4i_csi_try_fmt(csi, &csi->fmt);
diff -u -p a/drivers/media/tuners/mt2060.c b/drivers/media/tuners/mt2060.c
--- a/drivers/media/tuners/mt2060.c
+++ b/drivers/media/tuners/mt2060.c
@@ -215,7 +215,7 @@ static int mt2060_set_params(struct dvb_
 	f_lo2 = f_lo1 - freq - IF2;
 	// From the Comtech datasheet, the step used is 50kHz. The tuner chip could be more precise
 	f_lo2 = ((f_lo2 + 25) / 50) * 50;
-	priv->frequency =  (f_lo1 - f_lo2 - IF2) * 1000,
+	priv->frequency =  (f_lo1 - f_lo2 - IF2) * 1000;

 #ifdef MT2060_SPURCHECK
 	// LO-related spurs detection and correction
diff -u -p a/drivers/media/dvb-frontends/ts2020.c b/drivers/media/dvb-frontends/ts2020.c
--- a/drivers/media/dvb-frontends/ts2020.c
+++ b/drivers/media/dvb-frontends/ts2020.c
@@ -569,11 +569,11 @@ static int ts2020_probe(struct i2c_clien

 	/* create regmap */
 	mutex_init(&dev->regmap_mutex);
-	dev->regmap_config.reg_bits = 8,
-	dev->regmap_config.val_bits = 8,
-	dev->regmap_config.lock = ts2020_regmap_lock,
-	dev->regmap_config.unlock = ts2020_regmap_unlock,
-	dev->regmap_config.lock_arg = dev,
+	dev->regmap_config.reg_bits = 8;
+	dev->regmap_config.val_bits = 8;
+	dev->regmap_config.lock = ts2020_regmap_lock;
+	dev->regmap_config.unlock = ts2020_regmap_unlock;
+	dev->regmap_config.lock_arg = dev;
 	dev->regmap = regmap_init_i2c(client, &dev->regmap_config);
 	if (IS_ERR(dev->regmap)) {
 		ret = PTR_ERR(dev->regmap);
diff -u -p a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -1950,7 +1950,7 @@ static void pmcraid_soft_reset(struct pm
 	}

 	iowrite32(doorbell, pinstance->int_regs.host_ioa_interrupt_reg);
-	ioread32(pinstance->int_regs.host_ioa_interrupt_reg),
+	ioread32(pinstance->int_regs.host_ioa_interrupt_reg);
 	int_reg = ioread32(pinstance->int_regs.ioa_host_interrupt_reg);

 	pmcraid_info("Waiting for IOA to become operational %x:%x\n",
diff -u -p a/drivers/scsi/arm/cumana_2.c b/drivers/scsi/arm/cumana_2.c
--- a/drivers/scsi/arm/cumana_2.c
+++ b/drivers/scsi/arm/cumana_2.c
@@ -167,12 +167,12 @@ cumanascsi_2_dma_setup(struct Scsi_Host
 		bufs = copy_SCp_to_sg(&info->sg[0], SCp, NR_SG);

 		if (direction == DMA_OUT)
-			map_dir = DMA_TO_DEVICE,
-			dma_dir = DMA_MODE_WRITE,
+			map_dir = DMA_TO_DEVICE;
+			dma_dir = DMA_MODE_WRITE;
 			alatch_dir = ALATCH_DMA_OUT;
 		else
-			map_dir = DMA_FROM_DEVICE,
-			dma_dir = DMA_MODE_READ,
+			map_dir = DMA_FROM_DEVICE;
+			dma_dir = DMA_MODE_READ;
 			alatch_dir = ALATCH_DMA_IN;

 		dma_map_sg(dev, info->sg, bufs, map_dir);
diff -u -p a/drivers/scsi/arm/powertec.c b/drivers/scsi/arm/powertec.c
--- a/drivers/scsi/arm/powertec.c
+++ b/drivers/scsi/arm/powertec.c
@@ -139,10 +139,10 @@ powertecscsi_dma_setup(struct Scsi_Host
 		bufs = copy_SCp_to_sg(&info->sg[0], SCp, NR_SG);

 		if (direction == DMA_OUT)
-			map_dir = DMA_TO_DEVICE,
+			map_dir = DMA_TO_DEVICE;
 			dma_dir = DMA_MODE_WRITE;
 		else
-			map_dir = DMA_FROM_DEVICE,
+			map_dir = DMA_FROM_DEVICE;
 			dma_dir = DMA_MODE_READ;

 		dma_map_sg(dev, info->sg, bufs, map_dir);
diff -u -p a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -412,7 +412,7 @@ static void s3c2410fb_activate_var(struc
 	/* set lcd address pointers */
 	s3c2410fb_set_lcdaddr(info);

-	fbi->regs.lcdcon1 |= S3C2410_LCDCON1_ENVID,
+	fbi->regs.lcdcon1 |= S3C2410_LCDCON1_ENVID;
 	writel(fbi->regs.lcdcon1, regs + S3C2410_LCDCON1);
 }

diff -u -p a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -594,8 +594,8 @@ static int pxa3xx_gcu_probe(struct platf
 	 * container_of(). This isn't really necessary as we have a fixed minor
 	 * number anyway, but this is to avoid statics. */

-	priv->misc_dev.minor	= PXA3XX_GCU_MINOR,
-	priv->misc_dev.name	= DRV_NAME,
+	priv->misc_dev.minor	= PXA3XX_GCU_MINOR;
+	priv->misc_dev.name	= DRV_NAME;
 	priv->misc_dev.fops	= &pxa3xx_gcu_miscdev_fops;

 	/* handle IO resources */
diff -u -p a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
--- a/drivers/gpu/drm/radeon/radeon_sa.c
+++ b/drivers/gpu/drm/radeon/radeon_sa.c
@@ -80,7 +80,7 @@ void radeon_sa_bo_manager_fini(struct ra
 	struct radeon_sa_bo *sa_bo, *tmp;

 	if (!list_empty(&sa_manager->olist)) {
-		sa_manager->hole = &sa_manager->olist,
+		sa_manager->hole = &sa_manager->olist;
 		radeon_sa_bo_try_free(sa_manager);
 		if (!list_empty(&sa_manager->olist)) {
 			dev_err(rdev->dev, "sa_manager is not empty, clearing anyway\n");
diff -u -p a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -80,7 +80,7 @@ static int imx_pd_connector_get_modes(st
 			return ret;

 		drm_mode_copy(mode, &imxpd->mode);
-		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 		drm_mode_probed_add(connector, mode);
 		num_modes++;
 	}
diff -u -p a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2509,7 +2509,7 @@ static int vmw_cmd_dx_set_so_targets(str

 		binding.bi.ctx = ctx_node->ctx;
 		binding.bi.res = res;
-		binding.bi.bt = vmw_ctx_binding_so_target,
+		binding.bi.bt = vmw_ctx_binding_so_target;
 		binding.offset = cmd->targets[i].offset;
 		binding.size = cmd->targets[i].sizeInBytes;
 		binding.slot = i;
diff -u -p a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
--- a/drivers/gpio/gpio-mc33880.c
+++ b/drivers/gpio/gpio-mc33880.c
@@ -99,7 +99,7 @@ static int mc33880_probe(struct spi_devi

 	mc->spi = spi;

-	mc->chip.label = DRIVER_NAME,
+	mc->chip.label = DRIVER_NAME;
 	mc->chip.set = mc33880_set;
 	mc->chip.base = pdata->base;
 	mc->chip.ngpio = PIN_NUMBER;
diff -u -p a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -325,7 +325,7 @@ static int max77620_gpio_probe(struct pl
 	girq->parents = NULL;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_edge_irq;
-	girq->init_hw = max77620_gpio_irq_init_hw,
+	girq->init_hw = max77620_gpio_irq_init_hw;
 	girq->threaded = true;

 	platform_set_drvdata(pdev, mgpio);
diff -u -p a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -246,12 +246,12 @@ static int rda_gpio_probe(struct platfor
 	rda_gpio->chip.of_node = np;

 	if (rda_gpio->irq >= 0) {
-		rda_gpio->irq_chip.name = "rda-gpio",
-		rda_gpio->irq_chip.irq_ack = rda_gpio_irq_ack,
-		rda_gpio->irq_chip.irq_mask = rda_gpio_irq_mask,
-		rda_gpio->irq_chip.irq_unmask = rda_gpio_irq_unmask,
-		rda_gpio->irq_chip.irq_set_type = rda_gpio_irq_set_type,
-		rda_gpio->irq_chip.flags = IRQCHIP_SKIP_SET_WAKE,
+		rda_gpio->irq_chip.name = "rda-gpio";
+		rda_gpio->irq_chip.irq_ack = rda_gpio_irq_ack;
+		rda_gpio->irq_chip.irq_mask = rda_gpio_irq_mask;
+		rda_gpio->irq_chip.irq_unmask = rda_gpio_irq_unmask;
+		rda_gpio->irq_chip.irq_set_type = rda_gpio_irq_set_type;
+		rda_gpio->irq_chip.flags = IRQCHIP_SKIP_SET_WAKE;

 		girq = &rda_gpio->chip.irq;
 		girq->chip = &rda_gpio->irq_chip;
diff -u -p a/drivers/gpio/gpio-vx855.c b/drivers/gpio/gpio-vx855.c
--- a/drivers/gpio/gpio-vx855.c
+++ b/drivers/gpio/gpio-vx855.c
@@ -216,7 +216,7 @@ static void vx855gpio_gpio_setup(struct
 	c->direction_output = vx855gpio_direction_output;
 	c->get = vx855gpio_get;
 	c->set = vx855gpio_set;
-	c->set_config = vx855gpio_set_config,
+	c->set_config = vx855gpio_set_config;
 	c->dbg_show = NULL;
 	c->base = 0;
 	c->ngpio = NR_VX855_GP;
diff -u -p a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -2620,7 +2620,7 @@ int imgu_css_cfg_acc(struct imgu_css *cs
 		return -EINVAL;

 	acc->awb.config.grid.height_per_slice =
-		IMGU_ABI_AWB_MAX_CELLS_PER_SET / acc->awb.config.grid.width,
+		IMGU_ABI_AWB_MAX_CELLS_PER_SET / acc->awb.config.grid.width;
 	imgu_css_grid_end_calc(&acc->awb.config.grid);

 	for (i = 0; i < stripes; i++)
diff -u -p a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -142,7 +142,7 @@ static void rkvdec_reset_fmt(struct rkvd
 	memset(f, 0, sizeof(*f));
 	f->fmt.pix_mp.pixelformat = fourcc;
 	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
-	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709,
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
 	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
 	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
diff -u -p a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -316,7 +316,7 @@ hantro_reset_fmt(struct v4l2_pix_format_

 	fmt->pixelformat = vpu_fmt->fourcc;
 	fmt->field = V4L2_FIELD_NONE;
-	fmt->colorspace = V4L2_COLORSPACE_JPEG,
+	fmt->colorspace = V4L2_COLORSPACE_JPEG;
 	fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
 	fmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
diff -u -p a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -517,7 +517,7 @@ static int pn533_usb_probe(struct usb_in
 	case PN533_DEVICE_ACR122U:
 		protocols = PN533_NO_TYPE_B_PROTOCOLS;
 		fops = &pn533_acr122_frame_ops;
-		protocol_type = PN533_PROTO_REQ_RESP,
+		protocol_type = PN533_PROTO_REQ_RESP;

 		rc = pn533_acr122_poweron_rdr(phy);
 		if (rc < 0) {
diff -u -p a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
--- a/drivers/mtd/maps/pci.c
+++ b/drivers/mtd/maps/pci.c
@@ -90,8 +90,8 @@ intel_iq80310_init(struct pci_dev *dev,
 	u32 win_base;

 	map->map.bankwidth = 1;
-	map->map.read = mtd_pci_read8,
-	map->map.write = mtd_pci_write8,
+	map->map.read = mtd_pci_read8;
+	map->map.write = mtd_pci_write8;

 	map->map.size     = 0x00800000;
 	map->base         = ioremap(pci_resource_start(dev, 0),
@@ -185,8 +185,8 @@ intel_dc21285_init(struct pci_dev *dev,
 		return -ENXIO;

 	map->map.bankwidth = 4;
-	map->map.read = mtd_pci_read32,
-	map->map.write = mtd_pci_write32,
+	map->map.read = mtd_pci_read32;
+	map->map.write = mtd_pci_write32;
 	map->map.size     = len;
 	map->base         = ioremap(base, len);

diff -u -p a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1781,7 +1781,7 @@ static int mxcnd_probe(struct platform_d
 	this->legacy.chip_delay = 5;

 	nand_set_controller_data(this, host);
-	nand_set_flash_node(this, pdev->dev.of_node),
+	nand_set_flash_node(this, pdev->dev.of_node);
 	this->legacy.dev_ready = mxc_nand_dev_ready;
 	this->legacy.cmdfunc = mxc_nand_command;
 	this->legacy.read_byte = mxc_nand_read_byte;
diff -u -p a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
--- a/drivers/bcma/driver_pci_host.c
+++ b/drivers/bcma/driver_pci_host.c
@@ -419,12 +419,12 @@ void bcma_core_pci_hostmode_init(struct
 	pc_host->pci_ops.read = bcma_core_pci_hostmode_read_config;
 	pc_host->pci_ops.write = bcma_core_pci_hostmode_write_config;

-	pc_host->mem_resource.name = "BCMA PCIcore external memory",
+	pc_host->mem_resource.name = "BCMA PCIcore external memory";
 	pc_host->mem_resource.start = BCMA_SOC_PCI_DMA;
 	pc_host->mem_resource.end = BCMA_SOC_PCI_DMA + BCMA_SOC_PCI_DMA_SZ - 1;
 	pc_host->mem_resource.flags = IORESOURCE_MEM | IORESOURCE_PCI_FIXED;

-	pc_host->io_resource.name = "BCMA PCIcore external I/O",
+	pc_host->io_resource.name = "BCMA PCIcore external I/O";
 	pc_host->io_resource.start = 0x100;
 	pc_host->io_resource.end = 0x7FF;
 	pc_host->io_resource.flags = IORESOURCE_IO | IORESOURCE_PCI_FIXED;
diff -u -p a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1994,8 +1994,8 @@ static int iommu_init_intcapxt(struct am
 	 * whenever the irq affinity is changed from user-space.
 	 */
 	notify->irq = iommu->dev->irq;
-	notify->notify = _irq_notifier_notify,
-	notify->release = _irq_notifier_release,
+	notify->notify = _irq_notifier_notify;
+	notify->release = _irq_notifier_release;
 	ret = irq_set_affinity_notifier(iommu->dev->irq, notify);
 	if (ret) {
 		pr_err("Failed to register irq affinity notifier (devid=%#x, irq %d)\n",
diff -u -p a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -275,7 +275,7 @@ static int ipoib_mcast_join_finish(struc

 	memset(&av, 0, sizeof(av));
 	av.type = rdma_ah_find_type(priv->ca, priv->port);
-	rdma_ah_set_dlid(&av, be16_to_cpu(mcast->mcmember.mlid)),
+	rdma_ah_set_dlid(&av, be16_to_cpu(mcast->mcmember.mlid));
 	rdma_ah_set_port_num(&av, priv->port);
 	rdma_ah_set_sl(&av, mcast->mcmember.sl);
 	rdma_ah_set_static_rate(&av, mcast->mcmember.rate);
diff -u -p a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -400,7 +400,7 @@ static struct siw_device *siw_device_cre
 	       sizeof(base_dev->iw_ifname));

 	/* Disable TCP port mapping */
-	base_dev->iw_driver_flags = IW_F_NO_PORT_MAP,
+	base_dev->iw_driver_flags = IW_F_NO_PORT_MAP;

 	sdev->attrs.max_qp = SIW_MAX_QP;
 	sdev->attrs.max_qp_wr = SIW_MAX_QP_WR;
diff -u -p a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -334,7 +334,7 @@ int scmi_base_protocol_init(struct scmi_
 	if (!prot_imp)
 		return -ENOMEM;

-	rev->major_ver = PROTOCOL_REV_MAJOR(version),
+	rev->major_ver = PROTOCOL_REV_MAJOR(version);
 	rev->minor_ver = PROTOCOL_REV_MINOR(version);

 	scmi_base_attributes_get(handle);
diff -u -p a/drivers/net/usb/cdc-phonet.c b/drivers/net/usb/cdc-phonet.c
--- a/drivers/net/usb/cdc-phonet.c
+++ b/drivers/net/usb/cdc-phonet.c
@@ -275,7 +275,7 @@ static const struct net_device_ops usbpn
 static void usbpn_setup(struct net_device *dev)
 {
 	dev->features		= 0;
-	dev->netdev_ops		= &usbpn_ops,
+	dev->netdev_ops		= &usbpn_ops;
 	dev->header_ops		= &phonet_header_ops;
 	dev->type		= ARPHRD_PHONET;
 	dev->flags		= IFF_POINTOPOINT | IFF_NOARP;
diff -u -p a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
--- a/drivers/net/ipa/ipa_qmi.c
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -413,7 +413,7 @@ static void ipa_client_init_driver_work(
 	int ret;

 	ipa_qmi = container_of(work, struct ipa_qmi, init_driver_work);
-	qmi = &ipa_qmi->client_handle,
+	qmi = &ipa_qmi->client_handle;

 	ipa = container_of(ipa_qmi, struct ipa, qmi);
 	dev = &ipa->pdev->dev;
diff -u -p a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -430,7 +430,7 @@ static int fsl_pq_mdio_probe(struct plat
 		return -ENOMEM;

 	priv = new_bus->priv;
-	new_bus->name = "Freescale PowerQUICC MII Bus",
+	new_bus->name = "Freescale PowerQUICC MII Bus";
 	new_bus->read = &fsl_pq_mdio_read;
 	new_bus->write = &fsl_pq_mdio_write;
 	new_bus->reset = &fsl_pq_mdio_reset;
diff -u -p a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -891,7 +891,7 @@ static void efx_ptp_read_timeset(MCDI_DE
 	timeset->host_start = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTSTART);
 	timeset->major = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_MAJOR);
 	timeset->minor = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_MINOR);
-	timeset->host_end = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTEND),
+	timeset->host_end = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTEND);
 	timeset->wait = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_WAITNS);

 	/* Ignore seconds */
diff -u -p a/drivers/net/ethernet/8390/lib8390.c b/drivers/net/ethernet/8390/lib8390.c
--- a/drivers/net/ethernet/8390/lib8390.c
+++ b/drivers/net/ethernet/8390/lib8390.c
@@ -597,7 +597,7 @@ static void ei_tx_intr(struct net_device
 			ei_local->txing = 1;
 			NS8390_trigger_send(dev, ei_local->tx2, ei_local->tx_start_page + 6);
 			netif_trans_update(dev);
-			ei_local->tx2 = -1,
+			ei_local->tx2 = -1;
 			ei_local->lasttx = 2;
 		} else
 			ei_local->lasttx = 20, ei_local->txing = 0;
diff -u -p a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -650,7 +650,7 @@ cw1200_tx_h_rate_policy(struct cw1200_co
 	wsm->flags |= t->txpriv.rate_id << 4;

 	t->rate = cw1200_get_tx_rate(priv,
-		&t->tx_info->control.rates[0]),
+		&t->tx_info->control.rates[0]);
 	wsm->max_tx_rate = t->rate->hw_value;
 	if (t->rate->flags & IEEE80211_TX_RC_MCS) {
 		if (cw1200_ht_greenfield(&priv->ht_info))
diff -u -p a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1949,7 +1949,7 @@ static ssize_t iwl_dbgfs_mem_write(struc
 		return -EFAULT;
 	}

-	hcmd.flags = CMD_WANT_SKB | CMD_SEND_IN_RFKILL,
+	hcmd.flags = CMD_WANT_SKB | CMD_SEND_IN_RFKILL;
 	hcmd.data[0] = (void *)cmd;
 	hcmd.len[0] = cmd_size;

diff -u -p a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -138,7 +138,7 @@ int mt7663s_mcu_init(struct mt7615_dev *
 	if (ret)
 		return ret;

-	dev->mt76.mcu_ops = &mt7663s_mcu_ops,
+	dev->mt76.mcu_ops = &mt7663s_mcu_ops;

 	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
 	if (ret) {
diff -u -p a/drivers/net/wan/sbni.c b/drivers/net/wan/sbni.c
--- a/drivers/net/wan/sbni.c
+++ b/drivers/net/wan/sbni.c
@@ -261,7 +261,7 @@ static int __init sbni_init(struct net_d
 	/* otherwise we have to perform search our adapter */

 	if( io[ num ] != -1 )
-		dev->base_addr	= io[ num ],
+		dev->base_addr	= io[ num ];
 		dev->irq	= irq[ num ];
 	else if( scandone  ||  io[ 0 ] != -1 )
 		return  -ENODEV;
@@ -401,7 +401,7 @@ sbni_probe1( struct net_device  *dev,  u

 	if( (nl->cur_rxl_index = rxl[ num ]) == -1 )
 		/* autotune rxl */
-		nl->cur_rxl_index = DEF_RXL,
+		nl->cur_rxl_index = DEF_RXL;
 		nl->delta_rxl = DEF_RXL_DELTA;
 	else
 		nl->delta_rxl = 0;
@@ -513,11 +513,11 @@ sbni_interrupt( int  irq,  void  *dev_id
 	do {
 		repeat = 0;
 		if( inb( dev->base_addr + CSR0 ) & (RC_RDY | TR_RDY) )
-			handle_channel( dev ),
+			handle_channel( dev );
 			repeat = 1;
 		if( nl->second  && 	/* second channel present */
 		    (inb( nl->second->base_addr+CSR0 ) & (RC_RDY | TR_RDY)) )
-			handle_channel( nl->second ),
+			handle_channel( nl->second );
 			repeat = 1;
 	} while( repeat );

@@ -611,9 +611,9 @@ recv_frame( struct net_device  *dev )
 		if( framelen > 4 )
 			nl->in_stats.all_rx_number++;
 	} else
-		nl->state &= ~FL_PREV_OK,
-		change_level( dev ),
-		nl->in_stats.all_rx_number++,
+		nl->state &= ~FL_PREV_OK;
+		change_level( dev );
+		nl->in_stats.all_rx_number++;
 		nl->in_stats.bad_rx_number++;

 	return  !frame_ok  ||  framelen > 4;
@@ -690,7 +690,7 @@ download_data( struct net_device  *dev,

 	/* if packet too short we should write some more bytes to pad */
 	for( len = nl->framelen - len;  len--; )
-		outb( 0, dev->base_addr + DAT ),
+		outb( 0, dev->base_addr + DAT );
 		*crc_p = CRC32( 0, *crc_p );
 }

@@ -704,7 +704,7 @@ upload_data( struct net_device  *dev,  u
 	int  frame_ok;

 	if( is_first )
-		nl->wait_frameno = frameno,
+		nl->wait_frameno = frameno;
 		nl->inppos = 0;

 	if( nl->wait_frameno == frameno ) {
@@ -718,13 +718,13 @@ upload_data( struct net_device  *dev,  u
 		 */
 		else if( (frame_ok = skip_tail( dev->base_addr, framelen, crc ))
 			 != 0 )
-			nl->wait_frameno = 0,
-			nl->inppos = 0,
+			nl->wait_frameno = 0;
+			nl->inppos = 0;
 #ifdef CONFIG_SBNI_MULTILINE
-			nl->master->stats.rx_errors++,
+			nl->master->stats.rx_errors++;
 			nl->master->stats.rx_missed_errors++;
 #else
-		        dev->stats.rx_errors++,
+		        dev->stats.rx_errors++;
 			dev->stats.rx_missed_errors++;
 #endif
 			/* now skip all frames until is_first != 0 */
@@ -736,12 +736,12 @@ upload_data( struct net_device  *dev,  u
 		 * Frame has been broken, but we had already stored
 		 * is_first... Drop entire packet.
 		 */
-		nl->wait_frameno = 0,
+		nl->wait_frameno = 0;
 #ifdef CONFIG_SBNI_MULTILINE
-		nl->master->stats.rx_errors++,
+		nl->master->stats.rx_errors++;
 		nl->master->stats.rx_crc_errors++;
 #else
-		dev->stats.rx_errors++,
+		dev->stats.rx_errors++;
 		dev->stats.rx_crc_errors++;
 #endif

@@ -787,7 +787,7 @@ interpret_ack( struct net_device  *dev,
 						   nl->maxframe,
 						   nl->tx_buf_p->len - nl->outpos);
 			else
-				send_complete( dev ),
+				send_complete( dev );
 #ifdef CONFIG_SBNI_MULTILINE
 				netif_wake_queue( nl->master );
 #else
@@ -873,13 +873,13 @@ drop_xmit_queue( struct net_device  *dev
 	struct net_local  *nl = netdev_priv(dev);

 	if( nl->tx_buf_p )
-		dev_kfree_skb_any( nl->tx_buf_p ),
-		nl->tx_buf_p = NULL,
+		dev_kfree_skb_any( nl->tx_buf_p );
+		nl->tx_buf_p = NULL;
 #ifdef CONFIG_SBNI_MULTILINE
-		nl->master->stats.tx_errors++,
+		nl->master->stats.tx_errors++;
 		nl->master->stats.tx_carrier_errors++;
 #else
-		dev->stats.tx_errors++,
+		dev->stats.tx_errors++;
 		dev->stats.tx_carrier_errors++;
 #endif

@@ -1328,10 +1328,10 @@ sbni_ioctl( struct net_device  *dev,  st
 		spin_lock( &nl->lock );
 		flags = *(struct sbni_flags*) &ifr->ifr_ifru;
 		if( flags.fixed_rxl )
-			nl->delta_rxl = 0,
+			nl->delta_rxl = 0;
 			nl->cur_rxl_index = flags.rxl;
 		else
-			nl->delta_rxl = DEF_RXL_DELTA,
+			nl->delta_rxl = DEF_RXL_DELTA;
 			nl->cur_rxl_index = DEF_RXL;

 		nl->csr1.rxl = rxl_tab[ nl->cur_rxl_index ];
diff -u -p a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1700,8 +1700,8 @@ static int __init pc87360_device_add(uns
 			continue;
 		res[res_count].start = extra_isa[i];
 		res[res_count].end = extra_isa[i] + PC87360_EXTENT - 1;
-		res[res_count].name = "pc87360",
-		res[res_count].flags = IORESOURCE_IO,
+		res[res_count].name = "pc87360";
+		res[res_count].flags = IORESOURCE_IO;

 		err = acpi_check_resource_conflict(&res[res_count]);
 		if (err)
diff -u -p a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -797,7 +797,7 @@ static int glk_emmc_probe_slot(struct sd
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE;

 	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
-		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES,
+		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
 		slot->host->mmc_host_ops.hs400_enhanced_strobe =
 						intel_hs400_enhanced_strobe;
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
diff -u -p a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -145,12 +145,12 @@ static int stm32_rng_probe(struct platfo

 	dev_set_drvdata(dev, priv);

-	priv->rng.name = dev_driver_string(dev),
+	priv->rng.name = dev_driver_string(dev);
 #ifndef CONFIG_PM
-	priv->rng.init = stm32_rng_init,
-	priv->rng.cleanup = stm32_rng_cleanup,
+	priv->rng.init = stm32_rng_init;
+	priv->rng.cleanup = stm32_rng_cleanup;
 #endif
-	priv->rng.read = stm32_rng_read,
+	priv->rng.read = stm32_rng_read;
 	priv->rng.priv = (unsigned long) dev;
 	priv->rng.quality = 900;

diff -u -p a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -425,7 +425,7 @@ static int agp_amdk7_probe(struct pci_de
 		return -ENOMEM;

 	bridge->driver = &amd_irongate_driver;
-	bridge->dev_private_data = &amd_irongate_private,
+	bridge->dev_private_data = &amd_irongate_private;
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;

diff -u -p a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -462,9 +462,9 @@ static int bt_bmc_probe(struct platform_
 	mutex_init(&bt_bmc->mutex);
 	init_waitqueue_head(&bt_bmc->queue);

-	bt_bmc->miscdev.minor	= MISC_DYNAMIC_MINOR,
-	bt_bmc->miscdev.name	= DEVICE_NAME,
-	bt_bmc->miscdev.fops	= &bt_bmc_fops,
+	bt_bmc->miscdev.minor	= MISC_DYNAMIC_MINOR;
+	bt_bmc->miscdev.name	= DEVICE_NAME;
+	bt_bmc->miscdev.fops	= &bt_bmc_fops;
 	bt_bmc->miscdev.parent = dev;
 	rc = misc_register(&bt_bmc->miscdev);
 	if (rc) {
diff -u -p a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -1058,7 +1058,7 @@ static int ppc4xx_edac_mc_init(struct me
 	/* Initialize strings */

 	mci->mod_name		= PPC4XX_EDAC_MODULE_NAME;
-	mci->ctl_name		= ppc4xx_edac_match->compatible,
+	mci->ctl_name		= ppc4xx_edac_match->compatible;
 	mci->dev_name		= np->full_name;

 	/* Initialize callbacks */
diff -u -p a/drivers/pinctrl/berlin/berlin-bg4ct.c b/drivers/pinctrl/berlin/berlin-bg4ct.c
--- a/drivers/pinctrl/berlin/berlin-bg4ct.c
+++ b/drivers/pinctrl/berlin/berlin-bg4ct.c
@@ -465,9 +465,9 @@ static int berlin4ct_pinctrl_probe(struc
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-	rmconfig->reg_bits = 32,
-	rmconfig->val_bits = 32,
-	rmconfig->reg_stride = 4,
+	rmconfig->reg_bits = 32;
+	rmconfig->val_bits = 32;
+	rmconfig->reg_stride = 4;
 	rmconfig->max_register = resource_size(res);

 	regmap = devm_regmap_init_mmio(&pdev->dev, base, rmconfig);
diff -u -p a/drivers/pinctrl/intel/pinctrl-merrifield.c b/drivers/pinctrl/intel/pinctrl-merrifield.c
--- a/drivers/pinctrl/intel/pinctrl-merrifield.c
+++ b/drivers/pinctrl/intel/pinctrl-merrifield.c
@@ -908,7 +908,7 @@ static int mrfld_pinctrl_probe(struct pl
 	 * Make a copy of the families which we can use to hold pointers
 	 * to the registers.
 	 */
-	nfamilies = ARRAY_SIZE(mrfld_families),
+	nfamilies = ARRAY_SIZE(mrfld_families);
 	families = devm_kmemdup(&pdev->dev, mrfld_families,
 					    sizeof(mrfld_families),
 					    GFP_KERNEL);
diff -u -p a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1044,13 +1044,13 @@ static int pmic_gpio_probe(struct platfo
 	if (!parent_domain)
 		return -ENXIO;

-	state->irq.name = "spmi-gpio",
-	state->irq.irq_ack = irq_chip_ack_parent,
-	state->irq.irq_mask = irq_chip_mask_parent,
-	state->irq.irq_unmask = irq_chip_unmask_parent,
-	state->irq.irq_set_type = irq_chip_set_type_parent,
-	state->irq.irq_set_wake = irq_chip_set_wake_parent,
-	state->irq.flags = IRQCHIP_MASK_ON_SUSPEND,
+	state->irq.name = "spmi-gpio";
+	state->irq.irq_ack = irq_chip_ack_parent;
+	state->irq.irq_mask = irq_chip_mask_parent;
+	state->irq.irq_unmask = irq_chip_unmask_parent;
+	state->irq.irq_set_type = irq_chip_set_type_parent;
+	state->irq.irq_set_wake = irq_chip_set_wake_parent;
+	state->irq.flags = IRQCHIP_MASK_ON_SUSPEND;

 	girq = &state->chip.irq;
 	girq->chip = &state->irq;
diff -u -p a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -704,7 +704,7 @@ static void ti_iodelay_pinconf_group_dbg
 		u32 reg = 0;

 		cfg = &group->cfg[i];
-		regmap_read(iod->regmap, cfg->offset, &reg),
+		regmap_read(iod->regmap, cfg->offset, &reg);
 			seq_printf(s, "\n\t0x%08x = 0x%08x (%3d, %3d)",
 				   cfg->offset, reg, cfg->a_delay,
 				   cfg->g_delay);
diff -u -p a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -514,8 +514,8 @@ static int mtk_build_gpiochip(struct mtk
 	chip->direction_output	= mtk_gpio_direction_output;
 	chip->get		= mtk_gpio_get;
 	chip->set		= mtk_gpio_set;
-	chip->to_irq		= mtk_gpio_to_irq,
-	chip->set_config	= mtk_gpio_set_config,
+	chip->to_irq		= mtk_gpio_to_irq;
+	chip->set_config	= mtk_gpio_set_config;
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
 	chip->of_node		= np;
diff -u -p a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -916,7 +916,7 @@ static void device_power_init(struct pm8
 	power_devs[0].platform_data = pdata->power;
 	power_devs[0].pdata_size = sizeof(struct pm860x_power_pdata);
 	power_devs[0].num_resources = ARRAY_SIZE(battery_resources);
-	power_devs[0].resources = &battery_resources[0],
+	power_devs[0].resources = &battery_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &power_devs[0], 1,
 			      &battery_resources[0], chip->irq_base, NULL);
 	if (ret < 0)
@@ -925,7 +925,7 @@ static void device_power_init(struct pm8
 	power_devs[1].platform_data = pdata->power;
 	power_devs[1].pdata_size = sizeof(struct pm860x_power_pdata);
 	power_devs[1].num_resources = ARRAY_SIZE(charger_resources);
-	power_devs[1].resources = &charger_resources[0],
+	power_devs[1].resources = &charger_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &power_devs[1], 1,
 			      &charger_resources[0], chip->irq_base, NULL);
 	if (ret < 0)
@@ -942,7 +942,7 @@ static void device_power_init(struct pm8
 		pdata->chg_desc->charger_regulators =
 			&chg_desc_regulator_data[0];
 		pdata->chg_desc->num_charger_regulators	=
-			ARRAY_SIZE(chg_desc_regulator_data),
+			ARRAY_SIZE(chg_desc_regulator_data);
 		power_devs[3].platform_data = pdata->chg_desc;
 		power_devs[3].pdata_size = sizeof(*pdata->chg_desc);
 		ret = mfd_add_devices(chip->dev, 0, &power_devs[3], 1,
@@ -958,7 +958,7 @@ static void device_onkey_init(struct pm8
 	int ret;

 	onkey_devs[0].num_resources = ARRAY_SIZE(onkey_resources);
-	onkey_devs[0].resources = &onkey_resources[0],
+	onkey_devs[0].resources = &onkey_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
 			      ARRAY_SIZE(onkey_devs), &onkey_resources[0],
 			      chip->irq_base, NULL);
@@ -972,7 +972,7 @@ static void device_codec_init(struct pm8
 	int ret;

 	codec_devs[0].num_resources = ARRAY_SIZE(codec_resources);
-	codec_devs[0].resources = &codec_resources[0],
+	codec_devs[0].resources = &codec_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
 			      ARRAY_SIZE(codec_devs), &codec_resources[0], 0,
 			      NULL);
diff -u -p a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -184,7 +184,7 @@ static inline void regmap_calc_tot_len(s
 {
 	/* Calculate the length of a fixed format  */
 	if (!map->debugfs_tot_len) {
-		map->debugfs_reg_len = regmap_calc_reg_len(map->max_register),
+		map->debugfs_reg_len = regmap_calc_reg_len(map->max_register);
 		map->debugfs_val_len = 2 * map->format.val_bytes;
 		map->debugfs_tot_len = map->debugfs_reg_len +
 			map->debugfs_val_len + 3;      /* : \n */
diff -u -p a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -610,7 +610,7 @@ static void i2c_imx_stop(struct imx_i2c_
 		i2c_imx_bus_busy(i2c_imx, 0, atomic);

 	/* Disable I2C controller */
-	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
+	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 }

diff -u -p a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -912,7 +912,7 @@ static void atmel_tdes_skcipher_alg_init
 {
 	alg->base.cra_priority = ATMEL_TDES_PRIORITY;
 	alg->base.cra_flags = CRYPTO_ALG_ASYNC;
-	alg->base.cra_ctxsize = sizeof(struct atmel_tdes_ctx),
+	alg->base.cra_ctxsize = sizeof(struct atmel_tdes_ctx);
 	alg->base.cra_module = THIS_MODULE;

 	alg->init = atmel_tdes_init_tfm;
diff -u -p a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -175,8 +175,8 @@ static int mpc8xxx_wdt_probe(struct plat

 	spin_lock_init(&ddata->lock);

-	ddata->wdd.info = &mpc8xxx_wdt_info,
-	ddata->wdd.ops = &mpc8xxx_wdt_ops,
+	ddata->wdd.info = &mpc8xxx_wdt_info;
+	ddata->wdd.ops = &mpc8xxx_wdt_ops;

 	ddata->wdd.timeout = WATCHDOG_TIMEOUT;
 	watchdog_init_timeout(&ddata->wdd, timeout, dev);
diff -u -p a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c
+++ b/drivers/input/serio/parkbd.c
@@ -168,7 +168,7 @@ static struct serio *parkbd_allocate_ser
 	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		serio->id.type = parkbd_mode;
-		serio->write = parkbd_write,
+		serio->write = parkbd_write;
 		strlcpy(serio->name, "PARKBD AT/XT keyboard adapter", sizeof(serio->name));
 		snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", parkbd_dev->port->name);
 	}
diff -u -p a/lib/test_rhashtable.c b/lib/test_rhashtable.c
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -517,7 +517,7 @@ static unsigned int __init print_ht(stru
 				cnt++;
 			} while (list);

-			pos = next,
+			pos = next;
 			next = !rht_is_a_nulls(pos) ?
 				rht_dereference(pos->next, ht) : NULL;

diff -u -p a/arch/x86/platform/intel-mid/device_libs/platform_bt.c b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
--- a/arch/x86/platform/intel-mid/device_libs/platform_bt.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
@@ -88,8 +88,8 @@ static int __init bt_sfi_init(void)
 	memset(&info, 0, sizeof(info));
 	info.fwnode	= ddata->dev->fwnode;
 	info.parent	= ddata->dev;
-	info.name	= ddata->name,
-	info.id		= PLATFORM_DEVID_NONE,
+	info.name	= ddata->name;
+	info.id		= PLATFORM_DEVID_NONE;

 	pdev = platform_device_register_full(&info);
 	if (IS_ERR(pdev))
diff -u -p a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -537,9 +537,9 @@ static void __init print_out_mtrr_range_
 		if (!size_base)
 			continue;

-		size_base = to_size_factor(size_base, &size_factor),
+		size_base = to_size_factor(size_base, &size_factor);
 		start_base = range_state[i].base_pfn << (PAGE_SHIFT - 10);
-		start_base = to_size_factor(start_base, &start_factor),
+		start_base = to_size_factor(start_base, &start_factor);
 		type = range_state[i].type;

 		pr_debug("reg %d, base: %ld%cB, range: %ld%cB, type %s\n",
diff -u -p a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -113,7 +113,7 @@ static long iommu_batch_flush(struct iom
 				return -1;
 			}
 		} else {
-			index_count = HV_PCI_IOTSB_INDEX_COUNT(npages, entry),
+			index_count = HV_PCI_IOTSB_INDEX_COUNT(npages, entry);
 			iotsb_num = pbm->iommu->atu->iotsb->iotsb_num;
 			ret = pci_sun4v_iotsb_map(devhandle,
 						  iotsb_num,
diff -u -p a/arch/m68k/lib/muldi3.c b/arch/m68k/lib/muldi3.c
--- a/arch/m68k/lib/muldi3.c
+++ b/arch/m68k/lib/muldi3.c
@@ -84,7 +84,7 @@ __muldi3 (DItype u, DItype v)
   DIunion w;
   DIunion uu, vv;

-  uu.ll = u,
+  uu.ll = u;
   vv.ll = v;

   w.ll = __umulsidi3 (uu.s.low, vv.s.low);
diff -u -p a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -46,13 +46,13 @@ int __init bcm63xx_spi_register(void)
 	spi_resources[1].start = bcm63xx_get_irq_number(IRQ_SPI);

 	if (BCMCPU_IS_6338() || BCMCPU_IS_6348()) {
-		bcm63xx_spi_device.name = "bcm6348-spi",
+		bcm63xx_spi_device.name = "bcm6348-spi";
 		spi_resources[0].end += BCM_6348_RSET_SPI_SIZE - 1;
 	}

 	if (BCMCPU_IS_3368() || BCMCPU_IS_6358() || BCMCPU_IS_6362() ||
 		BCMCPU_IS_6368()) {
-		bcm63xx_spi_device.name = "bcm6358-spi",
+		bcm63xx_spi_device.name = "bcm6358-spi";
 		spi_resources[0].end += BCM_6358_RSET_SPI_SIZE - 1;
 	}

diff -u -p a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -62,7 +62,7 @@ static void davinci_pm_suspend(void)

 	/* Configure sleep count in deep sleep register */
 	val = __raw_readl(pm_config.deepsleep_reg);
-	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK,
+	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK;
 	val |= pm_config.sleepcount;
 	__raw_writel(val, pm_config.deepsleep_reg);

diff -u -p a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -537,7 +537,7 @@ static void __init e740_init(void)
 	pxa_set_stuart_info(NULL);
 	eseries_register_clks();
 	clk_add_alias("CLK_CK48M", e740_t7l66xb_device.name,
-			"UDCCLK", &pxa25x_device_udc.dev),
+			"UDCCLK", &pxa25x_device_udc.dev);
 	eseries_get_tmio_gpios();
 	gpiod_add_lookup_table(&e7xx_gpio_vbus_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(e740_devices));
@@ -737,7 +737,7 @@ static void __init e750_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 	clk_add_alias("CLK_CK3P6MI", e750_tc6393xb_device.name,
-			"GPIO11_CLK", NULL),
+			"GPIO11_CLK", NULL);
 	eseries_get_tmio_gpios();
 	gpiod_add_lookup_table(&e7xx_gpio_vbus_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(e750_devices));
@@ -956,7 +956,7 @@ static void __init e800_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 	clk_add_alias("CLK_CK3P6MI", e800_tc6393xb_device.name,
-			"GPIO11_CLK", NULL),
+			"GPIO11_CLK", NULL);
 	eseries_get_tmio_gpios();
 	gpiod_add_lookup_table(&e800_gpio_vbus_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(e800_devices));
diff -u -p a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -256,7 +256,7 @@ int copy_thread(unsigned long clone_flag
 		childstack->r26 = (unsigned long) ret_from_kernel_thread;
 		childstack->r9 = usp;	/* function */
 		childstack->r10 = kthread_arg;
-		childregs->hae = alpha_mv.hae_cache,
+		childregs->hae = alpha_mv.hae_cache;
 		childti->pcb.usp = 0;
 		return 0;
 	}
diff -u -p a/fs/lockd/host.c b/fs/lockd/host.c
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -163,7 +163,7 @@ static struct nlm_host *nlm_alloc_host(s
 	host->h_nsmhandle  = nsm;
 	host->h_addrbuf    = nsm->sm_addrbuf;
 	host->net	   = ni->net;
-	host->h_cred	   = get_cred(ni->cred),
+	host->h_cred	   = get_cred(ni->cred);
 	strlcpy(host->nodename, utsname()->nodename, sizeof(host->nodename));

 out:
diff -u -p a/fs/omfs/file.c b/fs/omfs/file.c
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -22,8 +22,8 @@ void omfs_make_empty_table(struct buffer
 	struct omfs_extent *oe = (struct omfs_extent *) &bh->b_data[offset];

 	oe->e_next = ~cpu_to_be64(0ULL);
-	oe->e_extent_count = cpu_to_be32(1),
-	oe->e_fill = cpu_to_be32(0x22),
+	oe->e_extent_count = cpu_to_be32(1);
+	oe->e_fill = cpu_to_be32(0x22);
 	oe->e_entry.e_cluster = ~cpu_to_be64(0ULL);
 	oe->e_entry.e_blocks = ~cpu_to_be64(0ULL);
 }
diff -u -p a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -588,7 +588,7 @@ int nfs42_proc_copy_notify(struct file *
 	if (args == NULL)
 		return -ENOMEM;

-	args->cna_src_fh  = NFS_FH(file_inode(src)),
+	args->cna_src_fh  = NFS_FH(file_inode(src));
 	args->cna_dst.nl4_type = NL4_NETADDR;
 	nfs42_set_netaddr(dst, &args->cna_dst.u.nl4_addr);
 	exception.stateid = &args->cna_src_stateid;
diff -u -p a/fs/reiserfs/do_balan.c b/fs/reiserfs/do_balan.c
--- a/fs/reiserfs/do_balan.c
+++ b/fs/reiserfs/do_balan.c
@@ -1392,8 +1392,8 @@ static int balance_leaf(struct tree_bala
 	if (tb->insert_size[0] < 0)
 		return balance_leaf_when_delete(tb, flag);

-	tb->item_pos = PATH_LAST_POSITION(tb->tb_path),
-	tb->pos_in_item = tb->tb_path->pos_in_item,
+	tb->item_pos = PATH_LAST_POSITION(tb->tb_path);
+	tb->pos_in_item = tb->tb_path->pos_in_item;
 	tb->zeroes_num = 0;
 	if (flag == M_INSERT && !body)
 		tb->zeroes_num = ih_item_len(ih);
diff -u -p a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -367,7 +367,7 @@ static int jump__parse(struct arch *arch
 	}

 	target.addr = map__objdump_2mem(map, ops->target.addr);
-	start = map->unmap_ip(map, sym->start),
+	start = map->unmap_ip(map, sym->start);
 	end = map->unmap_ip(map, sym->end);

 	ops->target.outside = target.addr < start || target.addr > end;
diff -u -p a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -404,7 +404,7 @@ static void perfbuf_libbpf_setup()
 	ctx->skel = perfbuf_setup_skeleton();

 	memset(&attr, 0, sizeof(attr));
-	attr.config = PERF_COUNT_SW_BPF_OUTPUT,
+	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.sample_type = PERF_SAMPLE_RAW;
 	/* notify only every Nth sample */
diff -u -p a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -151,7 +151,7 @@ loop:
 		insn[i++] = BPF_MOV64_IMM(BPF_REG_2, 1);
 		insn[i++] = BPF_MOV64_IMM(BPF_REG_3, 2);
 		insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-					 BPF_FUNC_skb_vlan_push),
+					 BPF_FUNC_skb_vlan_push);
 		insn[i] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, len - i - 3);
 		i++;
 	}
@@ -162,7 +162,7 @@ loop:
 		i++;
 		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
 		insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-					 BPF_FUNC_skb_vlan_pop),
+					 BPF_FUNC_skb_vlan_pop);
 		insn[i] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, len - i - 3);
 		i++;
 	}
diff -u -p a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -2874,7 +2874,7 @@ static int setup_result(void *buf, size_
 	result = kmalloc(sizeof(union acpi_object) + size, GFP_KERNEL);
 	if (!result)
 		return -ENOMEM;
-	result->package.type = ACPI_TYPE_BUFFER,
+	result->package.type = ACPI_TYPE_BUFFER;
 	result->buffer.pointer = (void *) (result + 1);
 	result->buffer.length = size;
 	memcpy(result->buffer.pointer, buf, size);
diff -u -p a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
--- a/net/ipv4/tcp_vegas.c
+++ b/net/ipv4/tcp_vegas.c
@@ -293,10 +293,10 @@ size_t tcp_vegas_get_info(struct sock *s
 	const struct vegas *ca = inet_csk_ca(sk);

 	if (ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
-		info->vegas.tcpv_enabled = ca->doing_vegas_now,
-		info->vegas.tcpv_rttcnt = ca->cntRTT,
-		info->vegas.tcpv_rtt = ca->baseRTT,
-		info->vegas.tcpv_minrtt = ca->minRTT,
+		info->vegas.tcpv_enabled = ca->doing_vegas_now;
+		info->vegas.tcpv_rttcnt = ca->cntRTT;
+		info->vegas.tcpv_rtt = ca->baseRTT;
+		info->vegas.tcpv_minrtt = ca->minRTT;

 		*attr = INET_DIAG_VEGASINFO;
 		return sizeof(struct tcpvegas_info);
diff -u -p a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -69,7 +69,7 @@ bool __rxrpc_set_call_completion(struct
 	if (call->state < RXRPC_CALL_COMPLETE) {
 		call->abort_code = abort_code;
 		call->error = error;
-		call->completion = compl,
+		call->completion = compl;
 		call->state = RXRPC_CALL_COMPLETE;
 		trace_rxrpc_call_complete(call);
 		wake_up(&call->waitq);
diff -u -p a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -189,7 +189,7 @@ static int snow_probe(struct platform_de
 			return PTR_ERR(priv->clk_i2s_bus);
 		}
 	} else {
-		link->codecs->dai_name = "HiFi",
+		link->codecs->dai_name = "HiFi";

 		link->cpus->of_node = of_parse_phandle(dev->of_node,
 						"samsung,i2s-controller", 0);
diff -u -p a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4764,7 +4764,7 @@ void snd_soc_dapm_init(struct snd_soc_da

 	if (component) {
 		dapm->dev		= component->dev;
-		dapm->idle_bias_off	= !component->driver->idle_bias_on,
+		dapm->idle_bias_off	= !component->driver->idle_bias_on;
 		dapm->suspend_bias_off	= component->driver->suspend_bias_off;
 	} else {
 		dapm->dev		= card->dev;
diff -u -p a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2829,7 +2829,7 @@ static int dspxfr_one_seg(struct hda_cod
 	}

 	data = fls->data;
-	chip_addx = fls->chip_addr,
+	chip_addx = fls->chip_addr;
 	words_to_write = fls->count;

 	if (!words_to_write)
diff -u -p a/kernel/dma/debug.c b/kernel/dma/debug.c
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1272,7 +1272,7 @@ void debug_dma_map_page(struct device *d
 	entry->dev       = dev;
 	entry->type      = dma_debug_single;
 	entry->pfn	 = page_to_pfn(page);
-	entry->offset	 = offset,
+	entry->offset	 = offset;
 	entry->dev_addr  = dma_addr;
 	entry->size      = size;
 	entry->direction = direction;
@@ -1363,7 +1363,7 @@ void debug_dma_map_sg(struct device *dev
 		entry->type           = dma_debug_sg;
 		entry->dev            = dev;
 		entry->pfn	      = page_to_pfn(sg_page(s));
-		entry->offset	      = s->offset,
+		entry->offset	      = s->offset;
 		entry->size           = sg_dma_len(s);
 		entry->dev_addr       = sg_dma_address(s);
 		entry->direction      = direction;
