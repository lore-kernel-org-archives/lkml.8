Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E8C2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Opi3W/us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgEOKoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:44:15 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41830 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589539428; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXAuPl/siwagV9/iK5/rwUKdTQEKo5yaP4d596FiAHU=;
        b=Opi3W/usBLjDR9XB7qd2L+KZj9Ts8iY/TJ0BLqdk9FrW+Gxx5DRnzzQEpVgfXM4bFdwWmv
        8QnWlMTitIvXpUR+6M/4lylqJtMqU/+PZmHxwIdukY5eIM4YKH11MwbgGb2JVEkffVXjnS
        4bSUPNvtiA5tXykm9DU0l/vLZSELuEM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v7 4/5] remoteproc: ingenic: Added remoteproc driver
Date:   Fri, 15 May 2020 12:43:39 +0200
Message-Id: <20200515104340.10473-4-paul@crapouillou.net>
In-Reply-To: <20200515104340.10473-1-paul@crapouillou.net>
References: <20200515104340.10473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used to boot, communicate with and load firmwares to the
MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---

Notes:
    v2: Remove exception for always-mapped memories
    v3: - Use clk_bulk API
    	- Move device-managed code to its own patch [3/4]
    	- Move devicetree table right above ingenic_rproc_driver
    	- Removed #ifdef CONFIG_OF around devicetree table
    	- Removed .owner = THIS_MODULE in ingenic_rproc_driver
    	- Removed useless platform_set_drvdata()
    v4: - Add fix reported by Julia
    	- Change Kconfig symbol to INGENIC_VPU_RPROC
    	- Add documentation to struct vpu
    	- disable_irq_nosync() -> disable_irq()
    v5: No change
    v6: Instead of prepare/unprepare callbacks, use PM runtime callbacks
    v7: - Remove use of of_match_ptr()
    	- Move Kconfig symbol so that it's in alphabetical order
    	- Add missing doc for private structure field aux_base
    	- Don't check for (len <= 0) in da_to_va()
    	- Add missing \n in dev_info/dev_err messages

 drivers/remoteproc/Kconfig         |   9 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/ingenic_rproc.c | 280 +++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
 create mode 100644 drivers/remoteproc/ingenic_rproc.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index fbaed079b299..c4d1731295eb 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -23,6 +23,15 @@ config IMX_REMOTEPROC
 
 	  It's safe to say N here.
 
+config INGENIC_VPU_RPROC
+	tristate "Ingenic JZ47xx VPU remoteproc support"
+	depends on MIPS || COMPILE_TEST
+	help
+	  Say y or m here to support the VPU in the JZ47xx SoCs from Ingenic.
+
+	  This can be either built-in or a loadable module.
+	  If unsure say N.
+
 config MTK_SCP
 	tristate "Mediatek SCP support"
 	depends on ARCH_MEDIATEK
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 0effd3825035..e8b886e511f0 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
+obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
 obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
diff --git a/drivers/remoteproc/ingenic_rproc.c b/drivers/remoteproc/ingenic_rproc.c
new file mode 100644
index 000000000000..189020d77b25
--- /dev/null
+++ b/drivers/remoteproc/ingenic_rproc.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Ingenic JZ47xx remoteproc driver
+ * Copyright 2019, Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/remoteproc.h>
+
+#include "remoteproc_internal.h"
+
+#define REG_AUX_CTRL		0x0
+#define REG_AUX_MSG_ACK		0x10
+#define REG_AUX_MSG		0x14
+#define REG_CORE_MSG_ACK	0x18
+#define REG_CORE_MSG		0x1C
+
+#define AUX_CTRL_SLEEP		BIT(31)
+#define AUX_CTRL_MSG_IRQ_EN	BIT(3)
+#define AUX_CTRL_NMI_RESETS	BIT(2)
+#define AUX_CTRL_NMI		BIT(1)
+#define AUX_CTRL_SW_RESET	BIT(0)
+
+struct vpu_mem_map {
+	const char *name;
+	unsigned int da;
+};
+
+struct vpu_mem_info {
+	const struct vpu_mem_map *map;
+	unsigned long len;
+	void __iomem *base;
+};
+
+static const struct vpu_mem_map vpu_mem_map[] = {
+	{ "tcsm0", 0x132b0000 },
+	{ "tcsm1", 0xf4000000 },
+	{ "sram",  0x132f0000 },
+};
+
+/**
+ * struct vpu - Ingenic VPU remoteproc private structure
+ * @irq: interrupt number
+ * @clks: pointers to the VPU and AUX clocks
+ * @aux_base: raw pointer to the AUX interface registers
+ * @mem_info: array of struct vpu_mem_info, which contain the mapping info of
+ *            each of the external memories
+ * @dev: private pointer to the device
+ */
+struct vpu {
+	int irq;
+	struct clk_bulk_data clks[2];
+	void __iomem *aux_base;
+	struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
+	struct device *dev;
+};
+
+static int ingenic_rproc_start(struct rproc *rproc)
+{
+	struct vpu *vpu = rproc->priv;
+	u32 ctrl;
+
+	enable_irq(vpu->irq);
+
+	/* Reset the AUX and enable message IRQ */
+	ctrl = AUX_CTRL_NMI_RESETS | AUX_CTRL_NMI | AUX_CTRL_MSG_IRQ_EN;
+	writel(ctrl, vpu->aux_base + REG_AUX_CTRL);
+
+	return 0;
+}
+
+static int ingenic_rproc_stop(struct rproc *rproc)
+{
+	struct vpu *vpu = rproc->priv;
+
+	disable_irq(vpu->irq);
+
+	/* Keep AUX in reset mode */
+	writel(AUX_CTRL_SW_RESET, vpu->aux_base + REG_AUX_CTRL);
+
+	return 0;
+}
+
+static void ingenic_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct vpu *vpu = rproc->priv;
+
+	writel(vqid, vpu->aux_base + REG_CORE_MSG);
+}
+
+static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
+{
+	struct vpu *vpu = rproc->priv;
+	void __iomem *va = NULL;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
+		const struct vpu_mem_info *info = &vpu->mem_info[i];
+		const struct vpu_mem_map *map = info->map;
+
+		if (da >= map->da && (da + len) < (map->da + info->len)) {
+			va = info->base + (da - map->da);
+			break;
+		}
+	}
+
+	return (__force void *)va;
+}
+
+static struct rproc_ops ingenic_rproc_ops = {
+	.start = ingenic_rproc_start,
+	.stop = ingenic_rproc_stop,
+	.kick = ingenic_rproc_kick,
+	.da_to_va = ingenic_rproc_da_to_va,
+};
+
+static irqreturn_t vpu_interrupt(int irq, void *data)
+{
+	struct rproc *rproc = data;
+	struct vpu *vpu = rproc->priv;
+	u32 vring;
+
+	vring = readl(vpu->aux_base + REG_AUX_MSG);
+
+	/* Ack the interrupt */
+	writel(0, vpu->aux_base + REG_AUX_MSG_ACK);
+
+	return rproc_vq_interrupt(rproc, vring);
+}
+
+static void ingenic_rproc_disable_clks(void *data)
+{
+	struct vpu *vpu = data;
+
+	pm_runtime_resume(vpu->dev);
+	pm_runtime_disable(vpu->dev);
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
+}
+
+static int ingenic_rproc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *mem;
+	struct rproc *rproc;
+	struct vpu *vpu;
+	unsigned int i;
+	int ret;
+
+	rproc = devm_rproc_alloc(dev, "ingenic-vpu",
+				 &ingenic_rproc_ops, NULL, sizeof(*vpu));
+	if (!rproc)
+		return -ENOMEM;
+
+	vpu = rproc->priv;
+	vpu->dev = &pdev->dev;
+	platform_set_drvdata(pdev, vpu);
+
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux");
+	vpu->aux_base = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(vpu->aux_base)) {
+		dev_err(dev, "Failed to ioremap\n");
+		return PTR_ERR(vpu->aux_base);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
+		mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   vpu_mem_map[i].name);
+
+		vpu->mem_info[i].base = devm_ioremap_resource(dev, mem);
+		if (IS_ERR(vpu->mem_info[i].base)) {
+			ret = PTR_ERR(vpu->mem_info[i].base);
+			dev_err(dev, "Failed to ioremap\n");
+			return ret;
+		}
+
+		vpu->mem_info[i].len = resource_size(mem);
+		vpu->mem_info[i].map = &vpu_mem_map[i];
+	}
+
+	vpu->clks[0].id = "vpu";
+	vpu->clks[1].id = "aux";
+
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(vpu->clks), vpu->clks);
+	if (ret) {
+		dev_err(dev, "Failed to get clocks\n");
+		return ret;
+	}
+
+	vpu->irq = platform_get_irq(pdev, 0);
+	if (vpu->irq < 0)
+		return vpu->irq;
+
+	ret = devm_request_irq(dev, vpu->irq, vpu_interrupt, 0, "VPU", rproc);
+	if (ret < 0) {
+		dev_err(dev, "Failed to request IRQ\n");
+		return ret;
+	}
+
+	disable_irq(vpu->irq);
+
+	/* The clocks must be enabled for the firmware to be loaded in TCSM */
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
+	if (ret) {
+		dev_err(dev, "Unable to start clocks\n");
+		return ret;
+	}
+
+	pm_runtime_irq_safe(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = devm_add_action_or_reset(dev, ingenic_rproc_disable_clks, vpu);
+	if (ret) {
+		dev_err(dev, "Unable to register action\n");
+		goto out_pm_put;
+	}
+
+	ret = devm_rproc_add(dev, rproc);
+	if (ret) {
+		dev_err(dev, "Failed to register remote processor\n");
+		goto out_pm_put;
+	}
+
+out_pm_put:
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static const struct of_device_id ingenic_rproc_of_matches[] = {
+	{ .compatible = "ingenic,jz4770-vpu-rproc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
+
+static int __maybe_unused ingenic_rproc_suspend(struct device *dev)
+{
+	struct vpu *vpu = dev_get_drvdata(dev);
+
+	clk_bulk_disable(ARRAY_SIZE(vpu->clks), vpu->clks);
+
+	return 0;
+}
+
+static int __maybe_unused ingenic_rproc_resume(struct device *dev)
+{
+	struct vpu *vpu = dev_get_drvdata(dev);
+
+	return clk_bulk_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
+}
+
+static const struct dev_pm_ops __maybe_unused ingenic_rproc_pm = {
+	SET_RUNTIME_PM_OPS(ingenic_rproc_suspend, ingenic_rproc_resume, NULL)
+};
+
+static struct platform_driver ingenic_rproc_driver = {
+	.probe = ingenic_rproc_probe,
+	.driver = {
+		.name = "ingenic-vpu",
+#ifdef CONFIG_PM
+		.pm = &ingenic_rproc_pm,
+#endif
+		.of_match_table = ingenic_rproc_of_matches,
+	},
+};
+module_platform_driver(ingenic_rproc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control driver");
-- 
2.26.2

