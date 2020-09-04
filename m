Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0EEC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F522087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599222545;
	bh=NRvKpp9J3Z0q+aVQV/lP7N9hE3PGRgvBtvmoaphxUrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g93pTUzt0/2n7mDZo7LyqmvlHYwjzs8Kwdz7fjbG3g8lta1xV9A4q+LIlHoR2i9d1
	 54+hklzvlBzZ9U8OhRj5mObGVA+1SNp6tYuR8+30yAj1d0Zj/l4JbnSwbBo4QSPjTJ
	 dB4Sj+euokzhz7M+ZUG3+FW1qfSfbGUErO49gvPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgIDM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgIDM25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:28:57 -0400
Received: from coco.lan (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9902084D;
        Fri,  4 Sep 2020 12:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599222536;
        bh=NRvKpp9J3Z0q+aVQV/lP7N9hE3PGRgvBtvmoaphxUrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rh0Bl7z1db7PzJBKpIJ/jrIv9zIg4gYpA/b6cQ7nVFW985lQeWbiZHLup+Qn47HwV
         muva5GzOMMVqm0pCg2enETWvICHU1GvwNQHRm2iVB+lQnKw59+fpv+iR4CQTlWy9uN
         uLWJ75r8fo90BkUz0XuVhHHZcIj4X65LxM3HphLI=
Date:   Fri, 4 Sep 2020 14:28:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [RFC 00/10] Add USB support for Hikey 970
Message-ID: <20200904142849.7d3fed88@coco.lan>
In-Reply-To: <84b7dfcd-05e9-53b2-e0a0-b03105937eb3@arm.com>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
        <84b7dfcd-05e9-53b2-e0a0-b03105937eb3@arm.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 4 Sep 2020 11:53:10 +0100
Robin Murphy <robin.murphy@arm.com> escreveu:

> On 2020-09-04 11:23, Mauro Carvalho Chehab wrote:
> > This RFC adds what seems to be needed for USB to work with Hikey 970.
> > While this driver works fine on Kernel 4.9 and 4.19, there's a hack there,
> > in the form of some special binding logic under dwg3 driver,  that seems to
> >   be just adding some delay,  and doing some different initializations at
> > PM (basically, disabling autosuspend).
> > 
> > With upstream Kernel, however, I'm getting a hard to track
> > Kernel panic:
> > 
> > [    1.837458] SError Interrupt on CPU0, code 0xbf000002 -- SError
> > [    1.837462] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #205
> > [    1.837463] Hardware name: HiKey970 (DT)
> > [    1.837465] Workqueue: events deferred_probe_work_func
> > [    1.837467] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=--)
> > [    1.837468] pc : _raw_spin_unlock_irqrestore+0x18/0x50
> > [    1.837469] lr : regmap_unlock_spinlock+0x14/0x20
> > [    1.837470] sp : ffff8000124dba60
> > [    1.837471] x29: ffff8000124dba60 x28: 0000000000000000
> > [    1.837474] x27: ffff0001b7e854c8 x26: ffff80001204ea18
> > [    1.837476] x25: 0000000000000005 x24: ffff800011f918f8
> > [    1.837479] x23: ffff800011fbb588 x22: ffff0001b7e40e00
> > [    1.837481] x21: 0000000000000100 x20: 0000000000000000
> > [    1.837483] x19: ffff0001b767ec00 x18: 00000000ff10c000
> > [    1.837485] x17: 0000000000000002 x16: 0000b0740fdb9950
> > [    1.837488] x15: ffff8000116c1198 x14: ffffffffffffffff
> > [    1.837490] x13: 0000000000000030 x12: 0101010101010101
> > [    1.837493] x11: 0000000000000020 x10: ffff0001bf17d130
> > [    1.837495] x9 : 0000000000000000 x8 : ffff0001b6938080
> > [    1.837497] x7 : 0000000000000000 x6 : 000000000000003f
> > [    1.837500] x5 : 0000000000000000 x4 : 0000000000000000
> > [    1.837502] x3 : ffff80001096a880 x2 : 0000000000000000
> > [    1.837505] x1 : ffff0001b7e40e00 x0 : 0000000100000001
> > [    1.837507] Kernel panic - not syncing: Asynchronous SError Interrupt
> > [    1.837509] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #205
> > [    1.837510] Hardware name: HiKey970 (DT)
> > [    1.837511] Workqueue: events deferred_probe_work_func
> > [    1.837513] Call trace:
> > [    1.837514]  dump_backtrace+0x0/0x1e0
> > [    1.837515]  show_stack+0x18/0x24
> > [    1.837516]  dump_stack+0xc0/0x11c
> > [    1.837517]  panic+0x15c/0x324
> > [    1.837518]  nmi_panic+0x8c/0x90
> > [    1.837519]  arm64_serror_panic+0x78/0x84
> > [    1.837520]  do_serror+0x158/0x15c
> > [    1.837521]  el1_error+0x84/0x100
> > [    1.837522]  _raw_spin_unlock_irqrestore+0x18/0x50
> > [    1.837523]  regmap_write+0x58/0x80
> > [    1.837524]  hi3660_reset_deassert+0x28/0x34
> > [    1.837526]  reset_control_deassert+0x50/0x260
> > [    1.837527]  reset_control_deassert+0xf4/0x260
> > [    1.837528]  dwc3_probe+0x5dc/0xe6c
> > [    1.837529]  platform_drv_probe+0x54/0xb0
> > [    1.837530]  really_probe+0xe0/0x490
> > [    1.837531]  driver_probe_device+0xf4/0x160
> > [    1.837532]  __device_attach_driver+0x8c/0x114
> > [    1.837533]  bus_for_each_drv+0x78/0xcc
> > [    1.837534]  __device_attach+0x108/0x1a0
> > [    1.837535]  device_initial_probe+0x14/0x20
> > [    1.837537]  bus_probe_device+0x98/0xa0
> > [    1.837538]  deferred_probe_work_func+0x88/0xe0
> > [    1.837539]  process_one_work+0x1cc/0x350
> > [    1.837540]  worker_thread+0x2c0/0x470
> > [    1.837541]  kthread+0x154/0x160
> > [    1.837542]  ret_from_fork+0x10/0x30
> > [    1.837569] SMP: stopping secondary CPUs
> > [    1.837570] Kernel Offset: 0x1d0000 from 0xffff800010000000
> > [    1.837571] PHYS_OFFSET: 0x0
> > [    1.837572] CPU features: 0x240002,20882004
> > [    1.837573] Memory Limit: none
> > 
> > I suspect that the driver works downstream because of the extra
> > delay of probing an additional driver, as porting such driver
> > to upstream sometimes makes this driver to work. So, it could
> > be due to some race condition.
> > 
> > The problem could also be due to something wrong at DT,
> > as, with the additional driver, the DT bindings are different.
> > 
> > As I'm not familiar about the Serror error mechanism on ARM,
> > I'm wondering if someone could give me some hint about how
> > can I identify what's happening here.  Due to the panic(), I
> > can't check what wrong happened there. Not sure if it would
> > be safe to just hack the error handling part of Serror, in order
> > to let the boot to finish.  
> 
> As one of my colleagues so wonderfully puts it, SError is effectively 
> "part of the SoC has fallen off" - it's an asynchronous notification of 
> some serious error condition external to the CPU. In this case, it seems 
> quite likely from trying to access a hardware block before it's powered 
> up or has finished its reset cycle, and so some CPU access is raising an 
> error in the interconnect instead of completing as expected.

Looking at the datasheet:

	https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf

It sounds that the only power supply related to USB is for the USB
hub (ldo17), with sounds unlikely to affect dwc3. Yet, just in case,
I added a dirty hack at dwc3_probe:

<snip>
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25c686a752b0..e42be91fe6c2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1491,6 +1491,11 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	}
 
+struct regulator *reg;
+reg = devm_regulator_get(dev, "ldo17");
+ret = PTR_ERR_OR_ZERO(reg);
+if (ret) return ret;
+
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
 		return ret;
</snip>

Nothing changed.

The enclosed patch is enough for it to stop panic'ing and for the driver
to show signs of life:

	$ lsusb
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

The probe code there is pretty much the same as the dwc3 one, but
it doesn't contain calls to pm_* stuff. So, as far as I understood, 
this way, dwc3 won't touch the clocks. 

Thanks,
Mauro




diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index bde3f5ece80c..dcc436de9b41 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -823,14 +823,16 @@ usb31_misc_rst: usb31_misc_rst_controller {
 			hisi,rst-syscon = <&usb3_otg_bc>;
 		};
 
-		dwc3: dwc3@ff100000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0xff100000 0x0 0x100000>;
+		usb3: hisi_dwc3 {
+			compatible = "hisilicon,kirin970-dwc3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
 
 			clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
-				 <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
-				 <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
-				 <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+				  <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
+				  <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
+				  <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
 			clock-names = "clk_gate_abb_usb",
 				      "hclk_gate_usb3otg",
 				      "clk_gate_usb3otg_ref",
@@ -843,11 +845,16 @@ dwc3: dwc3@ff100000 {
 				 <&usb31_misc_rst 0xA0 8>,
 				 <&usb31_misc_rst 0xA0 9>;
 
-			interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 161 IRQ_TYPE_LEVEL_HIGH>;
+			dwc3: dwc3@ff100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff100000 0x0 0x100000>;
 
-			phys = <&usb_phy>;
-			phy-names = "usb3-phy";
+				interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
+					    <0 161 IRQ_TYPE_LEVEL_HIGH>;
+
+				phys = <&usb_phy>;
+				phy-names = "usb3-phy";
+			};
 		};
 	};
 };
diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 7a2304565a73..be6985775046 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -139,4 +139,12 @@ config USB_DWC3_QCOM
 	  for peripheral mode support.
 	  Say 'Y' or 'M' if you have one such device.
 
+config USB_DWC3_HISI
+	tristate "HiSilicon Kirin Platforms"
+	depends on ((ARCH_HISI && ARM64) || COMPILE_TEST) && OF
+	default USB_DWC3
+	help
+	  Support of USB2/3 functionality in HiSilicon Kirin platforms.
+	  Say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index ae86da0dc5bd..8f4d8440c309 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
+obj-$(CONFIG_USB_DWC3_HISI)		+= dwc3-hisi.o
diff --git a/drivers/usb/dwc3/dwc3-hisi.c b/drivers/usb/dwc3/dwc3-hisi.c
new file mode 100644
index 000000000000..9b40b5ec6ead
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-hisi.c
@@ -0,0 +1,329 @@
+/**
+ * dwc3-hisi.c - Support for dwc3 platform devices on HiSilicon platforms
+ *
+ * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
+ *		http://www.huawei.com
+ *
+ * Authors: Yu Chen <chenyu56@huawei.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/extcon.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
+
+struct dwc3_hisi {
+	struct device		*dev;
+	struct regulator	*usb_regu;
+	struct clk		**clks;
+	int			num_clocks;
+	struct reset_control	**rstcs;
+	int			num_rstcs;
+};
+
+struct dwc3_hisi *g_dwc3_hisi;
+
+static int dwc3_hisi_init_clks(struct dwc3_hisi *dwc3_hisi,
+		struct device_node *np)
+{
+	struct device *dev = dwc3_hisi->dev;
+	int i;
+
+	dwc3_hisi->num_clocks = of_clk_get_parent_count(np);
+	if (!dwc3_hisi->num_clocks)
+		return -ENOENT;
+
+	dwc3_hisi->clks = devm_kcalloc(dev, dwc3_hisi->num_clocks,
+			sizeof(struct clk *), GFP_KERNEL);
+	if (!dwc3_hisi->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < dwc3_hisi->num_clocks; i++) {
+		struct clk	*clk;
+
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk)) {
+			while (--i >= 0)
+				clk_put(dwc3_hisi->clks[i]);
+
+			return PTR_ERR(clk);
+		}
+
+		dwc3_hisi->clks[i] = clk;
+	}
+
+	return 0;
+}
+
+static int dwc3_hisi_enable_clks(struct dwc3_hisi *dwc3_hisi)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < dwc3_hisi->num_clocks; i++) {
+		ret = clk_prepare_enable(dwc3_hisi->clks[i]);
+		if (ret < 0) {
+			while (--i >= 0)
+				clk_disable_unprepare(dwc3_hisi->clks[i]);
+
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void dwc3_hisi_disable_clks(struct dwc3_hisi *dwc3_hisi)
+{
+	int i;
+
+	for (i = 0; i < dwc3_hisi->num_clocks; i++)
+		clk_disable_unprepare(dwc3_hisi->clks[i]);
+}
+
+static int dwc3_hisi_get_rstcs(struct dwc3_hisi *dwc3_hisi,
+		struct device_node *np)
+{
+	struct device *dev = dwc3_hisi->dev;
+	int i;
+
+	dwc3_hisi->num_rstcs = of_count_phandle_with_args(np,
+			"resets", "#reset-cells");
+	if (!dwc3_hisi->num_rstcs)
+		return -ENOENT;
+
+	dwc3_hisi->rstcs = devm_kcalloc(dev, dwc3_hisi->num_rstcs,
+			sizeof(struct reset_control *), GFP_KERNEL);
+	if (!dwc3_hisi->rstcs)
+		return -ENOMEM;
+
+	for (i = 0; i < dwc3_hisi->num_rstcs; i++) {
+		struct reset_control *rstc;
+
+		rstc = of_reset_control_get_shared_by_index(np, i);
+		if (IS_ERR(rstc)) {
+			while (--i >= 0)
+				reset_control_put(dwc3_hisi->rstcs[i]);
+			return PTR_ERR(rstc);
+		}
+
+		dwc3_hisi->rstcs[i] = rstc;
+	}
+
+	return 0;
+}
+
+static int dwc3_hisi_reset_control_assert(struct dwc3_hisi *dwc3_hisi)
+{
+	int i, ret;
+
+	for (i = dwc3_hisi->num_rstcs - 1; i >= 0 ; i--) {
+		ret = reset_control_assert(dwc3_hisi->rstcs[i]);
+		if (ret) {
+			while (--i >= 0)
+				reset_control_deassert(dwc3_hisi->rstcs[i]);
+			return ret;
+		}
+		udelay(10);
+	}
+
+	return 0;
+}
+
+static int dwc3_hisi_reset_control_deassert(struct dwc3_hisi *dwc3_hisi)
+{
+	int i, ret;
+
+	for (i = 0; i < dwc3_hisi->num_rstcs; i++) {
+		ret = reset_control_deassert(dwc3_hisi->rstcs[i]);
+		if (ret) {
+			while (--i >= 0)
+				reset_control_assert(dwc3_hisi->rstcs[i]);
+			return ret;
+		}
+		udelay(10);
+	}
+
+	return 0;
+}
+
+static int dwc3_hisi_probe(struct platform_device *pdev)
+{
+	struct dwc3_hisi	*dwc3_hisi;
+	struct device		*dev = &pdev->dev;
+	struct device_node	*np = dev->of_node;
+
+	int			ret;
+	int			i;
+
+	dwc3_hisi = devm_kzalloc(dev, sizeof(*dwc3_hisi), GFP_KERNEL);
+	if (!dwc3_hisi)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, dwc3_hisi);
+	dwc3_hisi->dev = dev;
+
+	ret = dwc3_hisi_init_clks(dwc3_hisi, np);
+	if (ret) {
+		dev_err(dev, "could not get clocks\n");
+		return ret;
+	}
+
+	ret = dwc3_hisi_enable_clks(dwc3_hisi);
+	if (ret) {
+		dev_err(dev, "could not enable clocks\n");
+		goto err_put_clks;
+	}
+
+	ret = dwc3_hisi_get_rstcs(dwc3_hisi, np);
+	if (ret) {
+		dev_err(dev, "could not get reset controllers\n");
+		goto err_disable_clks;
+	}
+	ret = dwc3_hisi_reset_control_deassert(dwc3_hisi);
+	if (ret) {
+		dev_err(dev, "reset control deassert failed\n");
+		goto err_put_rstcs;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to add dwc3 core\n");
+		goto err_reset_assert;
+	}
+
+	g_dwc3_hisi = dwc3_hisi;
+	return 0;
+
+err_reset_assert:
+	ret = dwc3_hisi_reset_control_assert(dwc3_hisi);
+	if (ret)
+		dev_err(dev, "reset control assert failed\n");
+err_put_rstcs:
+	for (i = 0; i < dwc3_hisi->num_rstcs; i++)
+		reset_control_put(dwc3_hisi->rstcs[i]);
+err_disable_clks:
+	dwc3_hisi_disable_clks(dwc3_hisi);
+err_put_clks:
+	for (i = 0; i < dwc3_hisi->num_clocks; i++)
+		clk_put(dwc3_hisi->clks[i]);
+
+	return ret;
+}
+
+static int dwc3_hisi_remove(struct platform_device *pdev)
+{
+	struct dwc3_hisi	*dwc3_hisi = platform_get_drvdata(pdev);
+	struct device		*dev = &pdev->dev;
+	int			i, ret;
+
+	of_platform_depopulate(dev);
+
+	ret = dwc3_hisi_reset_control_assert(dwc3_hisi);
+	if (ret) {
+		dev_err(dev, "reset control assert failed\n");
+		return ret;
+	}
+
+	for (i = 0; i < dwc3_hisi->num_clocks; i++) {
+		clk_disable_unprepare(dwc3_hisi->clks[i]);
+		clk_put(dwc3_hisi->clks[i]);
+	}
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int dwc3_hisi_suspend(struct device *dev)
+{
+	struct dwc3_hisi *dwc3_hisi = dev_get_drvdata(dev);
+	int ret;
+
+	dev_info(dev, "%s\n", __func__);
+
+	ret = dwc3_hisi_reset_control_assert(dwc3_hisi);
+	if (ret) {
+		dev_err(dev, "reset control assert failed\n");
+		return ret;
+	}
+
+	dwc3_hisi_disable_clks(dwc3_hisi);
+	pinctrl_pm_select_default_state(dev);
+	return 0;
+}
+
+static int dwc3_hisi_resume(struct device *dev)
+{
+	struct dwc3_hisi *dwc3_hisi = dev_get_drvdata(dev);
+	int ret;
+
+	dev_info(dev, "%s\n", __func__);
+	pinctrl_pm_select_default_state(dev);
+
+	ret = dwc3_hisi_enable_clks(dwc3_hisi);
+	if (ret) {
+		dev_err(dev, "could not enable clocks\n");
+		return ret;
+	}
+
+	ret = dwc3_hisi_reset_control_deassert(dwc3_hisi);
+	if (ret) {
+		dev_err(dev, "reset control deassert failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(dwc3_hisi_dev_pm_ops,
+		dwc3_hisi_suspend, dwc3_hisi_resume);
+
+static const struct of_device_id dwc3_hisi_match[] = {
+	{ .compatible = "hisilicon,hi3660-dwc3" },
+	{ .compatible = "hisilicon,kirin970-dwc3" },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, dwc3_hisi_match);
+
+static struct platform_driver dwc3_hisi_driver = {
+	.probe = dwc3_hisi_probe,
+	.remove = dwc3_hisi_remove,
+	.driver = {
+		.name = "usb-hisi-dwc3",
+		.of_match_table = dwc3_hisi_match,
+		.pm = &dwc3_hisi_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dwc3_hisi_driver);
+
+MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare USB3 HiSilicon Glue Layer");


