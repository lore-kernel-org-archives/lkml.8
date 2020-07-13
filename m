Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B0C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A72C206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rjtjssG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgGMNaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbgGMN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:29:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A49C08C5DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:29:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so16570458wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3jegAPn8dEWDwA2jKK/TKMWUAwSW1c+kfPrDn36rN0=;
        b=rjtjssG0t5fwkJ/bK3zKeSuK3hemP7k2bwpDoN0qPwGCaeDUJfhCGnGgZpoCBjfQiS
         yasn1xsEK8k7jiMcXCqPb1tQ0Ck390nSkR6bbmnhkrQOavyHtDIddseuRGzYXCAxwrfn
         U0kP9gNMliwn3M1NzJmsdTuEd7LfQoFfDdHhB0oMKCtAyc958cDW9W417eutK+G4Ok2e
         0ZZa5ogMlkMhBfUM8b4W0o2hmQC/beNyfbkmxpprZ9IB5kI4D85O0mk26MWpLDSTVhl5
         YNPjltdJzwAdiHJ/Bc1aH7gqN2lcV7p3Q6uS3ZbPzJ/5CW8y2WLdCiFCJo+xwezwGNGa
         z9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3jegAPn8dEWDwA2jKK/TKMWUAwSW1c+kfPrDn36rN0=;
        b=kAAIFL6Q5e1Bzp/+PIEiv51m8wpkoMJWcNINFs84fBwNueWx7z4raoMBdUBHToO/Zv
         DbZMDMbZvfeMTBXFTbDTtKfAA2r+SucRdSwKG/snfRZ3LXllE2OYRZKzAIDsErfp78og
         Eg/zBwMC5WJPADGq7kQMFd8rnAsWPRmG15lsm524XSboJlkwEZTApWHF9aj7VXcSgNVd
         TcR+3fEtAWHC0gtukGwPqWPoINkPY8H4otFHibM5yefmvMRuc9EiRFhg4C81Q/KHA90E
         x3luK8eGIh5IfU8KyiwExbCDTjLIz4/d3mAdKdheZJ07HHgNOQE5A1r0ybIfCzgZPF0i
         ihTA==
X-Gm-Message-State: AOAM531yev7mDyLw2kzdrcWKP4zzv7l/vnnZ8DJjkIabxaH+csQ/QQ1d
        MbiqU4ZaLebPpYEKSEmbBC8kZQ==
X-Google-Smtp-Source: ABdhPJxHGBzJR0QjDgKIHesYQqxJcTGrTtX5dYMcBSQk8ZMLKU/1+AHv9TMOoA0leJOzpc+GdBRH3g==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr78308832wrw.63.1594646982147;
        Mon, 13 Jul 2020 06:29:42 -0700 (PDT)
Received: from linux.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j14sm23896642wrs.75.2020.07.13.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:29:41 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 2/6] remoteproc: Add a remoteproc driver for the MT8183's APU
Date:   Mon, 13 Jul 2020 15:29:23 +0200
Message-Id: <20200713132927.24925-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713132927.24925-1-abailon@baylibre.com>
References: <20200713132927.24925-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a driver to control the APU present in the MT8183.
This loads the firmware and start the DSP.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/remoteproc/Kconfig         |  10 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/mtk_apu_rproc.c | 308 +++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)
 create mode 100644 drivers/remoteproc/mtk_apu_rproc.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c4d1731295eb..e116d4a12ac3 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -42,6 +42,16 @@ config MTK_SCP
 
 	  It's safe to say N here.
 
+config MTK_APU
+	tristate "Mediatek APU remoteproc support"
+	depends on ARCH_MEDIATEK
+	depends on MTK_IOMMU
+	help
+	  Say y to support the Mediatek's Accelerated Processing Unit (APU) via
+	  the remote processor framework.
+
+	  It's safe to say N here.
+
 config OMAP_REMOTEPROC
 	tristate "OMAP remoteproc support"
 	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index e8b886e511f0..2ea231b75fa6 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -12,6 +12,7 @@ remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
 obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
 obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
+obj-$(CONFIG_MTK_APU)			+= mtk_apu_rproc.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
diff --git a/drivers/remoteproc/mtk_apu_rproc.c b/drivers/remoteproc/mtk_apu_rproc.c
new file mode 100644
index 000000000000..fb416a817ef3
--- /dev/null
+++ b/drivers/remoteproc/mtk_apu_rproc.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 BayLibre SAS
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+
+#include "remoteproc_internal.h"
+
+/* From MT8183 4.5 Vision Processor Unit (VPU).pdf datasheet */
+#define SW_RST					(0x0000000C)
+#define  SW_RST_OCD_HALT_ON_RST			BIT(12)
+#define  SW_RST_IPU_D_RST			BIT(8)
+#define  SW_RST_IPU_B_RST			BIT(4)
+#define CORE_CTRL				(0x00000110)
+#define  CORE_CTRL_PDEBUG_ENABLE		BIT(31)
+#define	 CORE_CTRL_SRAM_64K_iMEM		(0x00 << 27)
+#define	 CORE_CTRL_SRAM_96K_iMEM		(0x01 << 27)
+#define	 CORE_CTRL_SRAM_128K_iMEM		(0x02 << 27)
+#define	 CORE_CTRL_SRAM_192K_iMEM		(0x03 << 27)
+#define	 CORE_CTRL_SRAM_256K_iMEM		(0x04 << 27)
+#define  CORE_CTRL_PBCLK_ENABLE			BIT(26)
+#define  CORE_CTRL_RUN_STALL			BIT(23)
+#define  CORE_CTRL_STATE_VECTOR_SELECT		BIT(19)
+#define  CORE_CTRL_PIF_GATED			BIT(17)
+#define  CORE_CTRL_NMI				BIT(0)
+#define CORE_XTENSA_INT				(0x00000114)
+#define CORE_CTL_XTENSA_INT			(0x00000118)
+#define CORE_DEFAULT0				(0x0000013C)
+#define  CORE_DEFAULT0_QOS_SWAP_0		(0x00 << 28)
+#define  CORE_DEFAULT0_QOS_SWAP_1		(0x01 << 28)
+#define  CORE_DEFAULT0_QOS_SWAP_2		(0x02 << 28)
+#define  CORE_DEFAULT0_QOS_SWAP_3		(0x03 << 28)
+#define  CORE_DEFAULT0_ARUSER_USE_IOMMU		(0x10 << 23)
+#define  CORE_DEFAULT0_AWUSER_USE_IOMMU		(0x10 << 18)
+#define CORE_DEFAULT1				(0x00000140)
+#define  CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU	(0x10 << 0)
+#define  CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU	(0x10 << 5)
+#define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
+
+struct mtk_vpu_rproc {
+	struct device *dev;
+	struct rproc *rproc;
+
+	void __iomem *base;
+	int irq;
+	struct clk *axi;
+	struct clk *ipu;
+	struct clk *jtag;
+};
+
+static u32 vpu_read32(struct mtk_vpu_rproc *vpu_rproc, u32 off)
+{
+	return readl(vpu_rproc->base + off);
+}
+
+static void vpu_write32(struct mtk_vpu_rproc *vpu_rproc, u32 off, u32 value)
+{
+	writel(value, vpu_rproc->base + off);
+}
+
+static int mtk_vpu_rproc_start(struct rproc *rproc)
+{
+	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
+	u32 core_ctrl;
+
+	vpu_write32(vpu_rproc, CORE_XTENSA_ALTRESETVEC, rproc->bootaddr);
+
+	core_ctrl = vpu_read32(vpu_rproc, CORE_CTRL);
+	core_ctrl |= CORE_CTRL_PDEBUG_ENABLE | CORE_CTRL_PBCLK_ENABLE |
+		     CORE_CTRL_STATE_VECTOR_SELECT | CORE_CTRL_RUN_STALL |
+		     CORE_CTRL_PIF_GATED;
+	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);
+
+	vpu_write32(vpu_rproc, SW_RST, SW_RST_OCD_HALT_ON_RST |
+				       SW_RST_IPU_B_RST | SW_RST_IPU_D_RST);
+	ndelay(27);
+	vpu_write32(vpu_rproc, SW_RST, 0);
+
+	core_ctrl &= ~CORE_CTRL_PIF_GATED;
+	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);
+
+	vpu_write32(vpu_rproc, CORE_DEFAULT0, CORE_DEFAULT0_AWUSER_USE_IOMMU |
+					      CORE_DEFAULT0_ARUSER_USE_IOMMU |
+					      CORE_DEFAULT0_QOS_SWAP_1);
+	vpu_write32(vpu_rproc, CORE_DEFAULT1,
+		    CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU |
+		    CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU);
+
+	core_ctrl &= ~CORE_CTRL_RUN_STALL;
+	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);
+
+	return 0;
+}
+
+static int mtk_vpu_rproc_stop(struct rproc *rproc)
+{
+	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
+	u32 core_ctrl;
+
+	core_ctrl = vpu_read32(vpu_rproc, CORE_CTRL);
+	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl | CORE_CTRL_RUN_STALL);
+
+	return 0;
+}
+
+static void mtk_vpu_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
+
+	vpu_write32(vpu_rproc, CORE_CTL_XTENSA_INT, 1 << vqid);
+}
+
+static const struct rproc_ops mtk_vpu_rproc_ops = {
+	.start		= mtk_vpu_rproc_start,
+	.stop		= mtk_vpu_rproc_stop,
+	.kick		= mtk_vpu_rproc_kick,
+};
+
+static irqreturn_t mtk_vpu_rproc_callback(int irq, void *data)
+{
+	struct rproc *rproc = (struct rproc *)data;
+	struct mtk_vpu_rproc *vpu_rproc = (struct mtk_vpu_rproc *)rproc->priv;
+
+	vpu_write32(vpu_rproc, CORE_XTENSA_INT, 1);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t handle_event(int irq, void *data)
+{
+	struct rproc *rproc = (struct rproc *)data;
+
+	rproc_vq_interrupt(rproc, 0);
+	rproc_vq_interrupt(rproc, 1);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_vpu_rproc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_vpu_rproc *vpu_rproc;
+	struct rproc *rproc;
+	struct resource *res;
+	int ret;
+
+	rproc = rproc_alloc(dev, "apu", &mtk_vpu_rproc_ops, NULL,
+			    sizeof(*vpu_rproc));
+	if (!rproc)
+		return -ENOMEM;
+
+	rproc->recovery_disabled = true;
+	rproc->has_iommu = false;
+
+	vpu_rproc = rproc->priv;
+	vpu_rproc->rproc = rproc;
+	vpu_rproc->dev = dev;
+
+	platform_set_drvdata(pdev, rproc);
+
+	rproc->domain = iommu_get_domain_for_dev(dev);
+	if (!rproc->domain) {
+		dev_err(dev, "Failed to get the IOMMU domain\n");
+		ret = -EINVAL;
+		goto free_rproc;
+	}
+
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	vpu_rproc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(vpu_rproc->base)) {
+		dev_err(&pdev->dev, "Failed to map mmio\n");
+		ret = PTR_ERR(vpu_rproc->base);
+		goto free_rproc;
+	}
+
+	vpu_rproc->irq = platform_get_irq(pdev, 0);
+	if (vpu_rproc->irq < 0) {
+		ret = vpu_rproc->irq;
+		goto free_rproc;
+	}
+
+	ret = devm_request_threaded_irq(dev, vpu_rproc->irq,
+					mtk_vpu_rproc_callback, handle_event,
+					IRQF_SHARED | IRQF_ONESHOT,
+					"mtk_vpu-remoteproc", rproc);
+	if (ret) {
+		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
+		goto free_rproc;
+	}
+
+	vpu_rproc->ipu = devm_clk_get(dev, "ipu");
+	if (IS_ERR(vpu_rproc->ipu)) {
+		dev_err(dev, "Failed to get ipu clock\n");
+		ret = PTR_ERR(vpu_rproc->ipu);
+		goto free_rproc;
+	}
+
+	ret = clk_prepare_enable(vpu_rproc->ipu);
+	if (ret) {
+		dev_err(dev, "Failed to enable ipu clock\n");
+		goto free_rproc;
+	}
+
+	vpu_rproc->axi = devm_clk_get(dev, "axi");
+	if (IS_ERR(vpu_rproc->axi)) {
+		dev_err(dev, "Failed to get axi clock\n");
+		ret = PTR_ERR(vpu_rproc->axi);
+		goto clk_disable_ipu;
+	}
+
+	ret = clk_prepare_enable(vpu_rproc->axi);
+	if (ret) {
+		dev_err(dev, "Failed to enable axi clock\n");
+		goto clk_disable_ipu;
+	}
+
+	vpu_rproc->jtag = devm_clk_get_optional(dev, "jtag");
+	if (IS_ERR(vpu_rproc->jtag)) {
+		dev_err(dev, "Failed to enable jtag clock\n");
+		ret = PTR_ERR(vpu_rproc->jtag);
+		goto clk_disable_axi;
+	}
+
+	ret = clk_prepare_enable(vpu_rproc->jtag);
+	if (ret) {
+		dev_err(dev, "Failed to enable jtag clock\n");
+		goto clk_disable_axi;
+	}
+
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_err(dev, "device does not have specific CMA pool\n");
+		goto clk_disable_jtag;
+	}
+
+	ret = rproc_add(rproc);
+	if (ret) {
+		dev_err(dev, "rproc_add failed: %d\n", ret);
+		goto free_mem;
+	}
+
+	return 0;
+
+free_mem:
+	of_reserved_mem_device_release(dev);
+clk_disable_jtag:
+	clk_disable_unprepare(vpu_rproc->jtag);
+clk_disable_axi:
+	clk_disable_unprepare(vpu_rproc->axi);
+clk_disable_ipu:
+	clk_disable_unprepare(vpu_rproc->ipu);
+free_rproc:
+	rproc_free(rproc);
+
+	return ret;
+}
+
+static int mtk_vpu_rproc_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct mtk_vpu_rproc *vpu_rproc = (struct mtk_vpu_rproc *)rproc->priv;
+	struct device *dev = &pdev->dev;
+
+	disable_irq(vpu_rproc->irq);
+
+	rproc_del(rproc);
+	of_reserved_mem_device_release(dev);
+	clk_disable_unprepare(vpu_rproc->jtag);
+	clk_disable_unprepare(vpu_rproc->axi);
+	clk_disable_unprepare(vpu_rproc->ipu);
+	rproc_free(rproc);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_vpu_rproc_of_match[] __maybe_unused = {
+	{ .compatible = "mediatek,mt8183-apu", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mtk_vpu_rproc_of_match);
+
+static struct platform_driver mtk_vpu_rproc_driver = {
+	.probe = mtk_vpu_rproc_probe,
+	.remove = mtk_vpu_rproc_remove,
+	.driver = {
+		.name = "mtk_vpu-rproc",
+		.of_match_table = of_match_ptr(mtk_vpu_rproc_of_match),
+	},
+};
+module_platform_driver(mtk_vpu_rproc_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Alexandre Bailon");
+MODULE_DESCRIPTION("Mt8183 VPU Remote Processor control driver");
-- 
2.26.2

