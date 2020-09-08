Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99DF20672
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgIHK1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:27:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57038 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgIHK0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 046A020119C;
        Tue,  8 Sep 2020 12:26:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EAA4B20025C;
        Tue,  8 Sep 2020 12:26:13 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4490D20327;
        Tue,  8 Sep 2020 12:26:13 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, devicetree@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 11/14] clk: imx: Add blk-ctl driver for i.MX8MP
Date:   Tue,  8 Sep 2020 13:24:48 +0300
Message-Id: <1599560691-3763-12-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is intended to work with the following BLK_CTL IPs found in
i.MX8MP:
 - Audio
 - Media
 - HDMI

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile             |   2 +-
 drivers/clk/imx/clk-blk-ctl-imx8mp.c | 313 +++++++++++++++++++++++++++++++++++
 2 files changed, 314 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-blk-ctl-imx8mp.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 105c117..e3aaf76 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_MXC_CLK) += mxc-clk.o
 
 obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
 obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
-obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-blk-ctl.o
+obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-blk-ctl.o clk-blk-ctl-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
diff --git a/drivers/clk/imx/clk-blk-ctl-imx8mp.c b/drivers/clk/imx/clk-blk-ctl-imx8mp.c
new file mode 100644
index 00000000..eacecbe
--- /dev/null
+++ b/drivers/clk/imx/clk-blk-ctl-imx8mp.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 NXP.
+ */
+
+
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/reset/imx8mp-reset.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "clk.h"
+#include "clk-blk-ctl.h"
+
+#define	IMX_AUDIO_BLK_CTL_CLKEN0		0x0
+#define	IMX_AUDIO_BLK_CTL_CLKEN1		0x4
+#define	IMX_AUDIO_BLK_CTL_EARC			0x200
+#define	IMX_AUDIO_BLK_CTL_SAI1_MCLK_SEL		0x300
+#define	IMX_AUDIO_BLK_CTL_SAI2_MCLK_SEL		0x304
+#define	IMX_AUDIO_BLK_CTL_SAI3_MCLK_SEL		0x308
+#define	IMX_AUDIO_BLK_CTL_SAI5_MCLK_SEL		0x30C
+#define	IMX_AUDIO_BLK_CTL_SAI6_MCLK_SEL		0x310
+#define	IMX_AUDIO_BLK_CTL_SAI7_MCLK_SEL		0x314
+#define	IMX_AUDIO_BLK_CTL_PDM_CLK		0x318
+#define	IMX_AUDIO_BLK_CTL_SAI_PLL_GNRL_CTL	0x400
+#define	IMX_AUDIO_BLK_CTL_SAI_PLL_FDIVL_CTL0	0x404
+#define	IMX_AUDIO_BLK_CTL_SAI_PLL_FDIVL_CTL1	0x408
+#define	IMX_AUDIO_BLK_CTL_SAI_PLL_SSCG_CTL	0x40C
+#define	IMX_AUDIO_BLK_CTL_SAI_PLL_MNIT_CTL	0x410
+#define	IMX_AUDIO_BLK_CTL_IPG_LP_CTRL		0x504
+
+#define IMX_MEDIA_BLK_CTL_SFT_RSTN		0x0
+#define IMX_MEDIA_BLK_CTL_CLK_EN		0x4
+
+static int shared_count_pdm;
+
+static const struct imx_pll14xx_rate_table imx_blk_ctl_sai_pll_tbl[] = {
+	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
+};
+
+static const struct imx_pll14xx_clk imx_blk_ctl_sai_pll = {
+	.type = PLL_1443X,
+	.rate_table = imx_blk_ctl_sai_pll_tbl,
+};
+
+static const char * const imx_sai_mclk2_sels[] = {"sai1_root", "sai2_root", "sai3_root", "dummy",
+					   "sai5_root", "sai6_root", "sai7_root", "sai1_mclk",
+					   "sai2_mclk", "sai3_mclk", "dummy",
+					   "sai5_mclk", "sai6_mclk", "sai7_mclk", "spdif1_ext_clk"};
+static const char * const imx_sai1_mclk1_sels[] = {"sai1_root", "sai1_mclk", };
+static const char * const imx_sai2_mclk1_sels[] = {"sai2_root", "sai2_mclk", };
+static const char * const imx_sai3_mclk1_sels[] = {"sai3_root", "sai3_mclk", };
+static const char * const imx_sai5_mclk1_sels[] = {"sai5_root", "sai5_mclk", };
+static const char * const imx_sai6_mclk1_sels[] = {"sai6_root", "sai6_mclk", };
+static const char * const imx_sai7_mclk1_sels[] = {"sai7_root", "sai7_mclk", };
+static const char * const imx_pdm_sels[] = {"pdm_root", "sai_pll_div2", "dummy", "dummy" };
+static const char * const imx_sai_pll_ref_sels[] = {"osc_24m", "dummy", "dummy", "dummy", };
+static const char * const imx_sai_pll_bypass_sels[] = {"sai_pll", "sai_pll_ref_sel", };
+
+static const char * const imx_hdmi_phy_clks_sels[] = {"hdmi_glb_24m", "dummy", };
+static const char * const imx_lcdif_clks_sels[] = {"dummy", "hdmi_glb_pix", };
+static const char * const imx_hdmi_pipe_clks_sels[] = {"dummy", "hdmi_glb_pix", };
+
+static struct imx_blk_ctl_hw imx8mp_hdmi_blk_ctl_hws[] = {
+	/* clocks */
+	IMX_BLK_CTL_CLK_GATE("hdmi_glb_apb", IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_APB_CLK, 0x40, 0, "hdmi_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_glb_b", IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_B_CLK, 0x40, 1, "hdmi_axi"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_glb_ref_266m", IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_REF266M_CLK, 0x40, 2, "hdmi_ref_266m"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_glb_24m", IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_XTAL24M_CLK, 0x40, 4, "hdmi_24m"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_glb_32k", IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_XTAL32K_CLK, 0x40, 5, "osc_32k"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_glb_pix", IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_TX_PIX_CLK, 0x40, 7, "hdmi_phy"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_irq_steer", IMX8MP_CLK_HDMI_BLK_CTL_IRQS_STEER_CLK, 0x40, 9, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_noc", IMX8MP_CLK_HDMI_BLK_CTL_NOC_HDMI_CLK, 0x40, 10, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdcp_noc", IMX8MP_CLK_HDMI_BLK_CTL_NOC_HDCP_CLK, 0x40, 11,  "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("lcdif3_apb", IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_APB_CLK, 0x40, 16, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("lcdif3_b", IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_B_CLK, 0x40, 17, "hdmi_glb_b"),
+	IMX_BLK_CTL_CLK_GATE("lcdif3_pdi", IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_PDI_CLK, 0x40, 18, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("lcdif3_pxl", IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_PIX_CLK, 0x40, 19, "hdmi_glb_pix"),
+	IMX_BLK_CTL_CLK_GATE("lcdif3_spu", IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_SPU_CLK, 0x40, 20, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_fdcc_ref", IMX8MP_CLK_HDMI_BLK_CTL_FDCC_REF_CLK, 0x50, 2, "hdmi_fdcc_tst"),
+	IMX_BLK_CTL_CLK_GATE("hrv_mwr_apb", IMX8MP_CLK_HDMI_BLK_CTL_HRV_MWR_APB_CLK, 0x50, 3, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hrv_mwr_b", IMX8MP_CLK_HDMI_BLK_CTL_HRV_MWR_B_CLK, 0x50, 4, "hdmi_glb_axi"),
+	IMX_BLK_CTL_CLK_GATE("hrv_mwr_cea", IMX8MP_CLK_HDMI_BLK_CTL_HRV_MWR_CEA_CLK, 0x50, 5, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("vsfd_cea", IMX8MP_CLK_HDMI_BLK_CTL_VSFD_CEA_CLK, 0x50, 6, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_tx_hpi", IMX8MP_CLK_HDMI_BLK_CTL_TX_HPI_CLK, 0x50, 13, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_tx_apb", IMX8MP_CLK_HDMI_BLK_CTL_TX_APB_CLK, 0x50, 14, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_cec", IMX8MP_CLK_HDMI_BLK_CTL_TX_CEC_CLK, 0x50, 15, "hdmi_glb_32k"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_esm", IMX8MP_CLK_HDMI_BLK_CTL_TX_ESM_CLK, 0x50, 16, "hdmi_glb_ref_266m"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_tx_gpa", IMX8MP_CLK_HDMI_BLK_CTL_TX_GPA_CLK, 0x50, 17, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_tx_pix", IMX8MP_CLK_HDMI_BLK_CTL_TX_PIXEL_CLK, 0x50, 18, "hdmi_glb_pix"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_tx_sfr", IMX8MP_CLK_HDMI_BLK_CTL_TX_SFR_CLK, 0x50, 19, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_tx_skp", IMX8MP_CLK_HDMI_BLK_CTL_TX_SKP_CLK, 0x50, 20, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_tx_prep", IMX8MP_CLK_HDMI_BLK_CTL_TX_PREP_CLK, 0x50, 21, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_phy_apb", IMX8MP_CLK_HDMI_BLK_CTL_TX_PHY_APB_CLK, 0x50, 22, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_phy_int", IMX8MP_CLK_HDMI_BLK_CTL_TX_PHY_INT_CLK, 0x50, 24, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_sec_mem", IMX8MP_CLK_HDMI_BLK_CTL_TX_SEC_MEM_CLK, 0x50, 25, "hdmi_glb_ref_266m"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_trng_skp", IMX8MP_CLK_HDMI_BLK_CTL_TX_TRNG_SKP_CLK, 0x50, 27, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_vid_pix",  IMX8MP_CLK_HDMI_BLK_CTL_TX_VID_LINK_PIX_CLK, 0x50, 28, "hdmi_glb_pix"),
+	IMX_BLK_CTL_CLK_GATE("hdmi_trng_apb", IMX8MP_CLK_HDMI_BLK_CTL_TX_TRNG_APB_CLK, 0x50, 30, "hdmi_glb_apb"),
+	IMX_BLK_CTL_CLK_MUX("hdmi_phy_sel", IMX8MP_CLK_HDMI_BLK_CTL_HTXPHY_CLK_SEL, 0x50, 10, 1, imx_hdmi_phy_clks_sels),
+	IMX_BLK_CTL_CLK_MUX("lcdif_clk_sel", IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_CLK_SEL, 0x50, 11, 1, imx_lcdif_clks_sels),
+	IMX_BLK_CTL_CLK_MUX("hdmi_pipe_sel", IMX8MP_CLK_HDMI_BLK_CTL_TX_PIPE_CLK_SEL, 0x50, 12, 1, imx_hdmi_pipe_clks_sels),
+
+	/* resets */
+	IMX_BLK_CTL_RESET_MASK(IMX8MP_HDMI_BLK_CTL_HDMI_TX_RESET, 0x20, 6, 0x33),
+	IMX_BLK_CTL_RESET(IMX8MP_HDMI_BLK_CTL_HDMI_PHY_RESET, 0x20, 12),
+	IMX_BLK_CTL_RESET(IMX8MP_HDMI_BLK_CTL_HDMI_PAI_RESET, 0x20, 18),
+	IMX_BLK_CTL_RESET(IMX8MP_HDMI_BLK_CTL_HDMI_PAI_RESET, 0x20, 22),
+	IMX_BLK_CTL_RESET(IMX8MP_HDMI_BLK_CTL_HDMI_TRNG_RESET, 0x20, 20),
+	IMX_BLK_CTL_RESET(IMX8MP_HDMI_BLK_CTL_IRQ_STEER_RESET, 0x20, 16),
+	IMX_BLK_CTL_RESET(IMX8MP_HDMI_BLK_CTL_HDMI_HDCP_RESET, 0x20, 13),
+	IMX_BLK_CTL_RESET_MASK(IMX8MP_HDMI_BLK_CTL_LCDIF_RESET, 0x20, 4, 0x3),
+};
+
+static struct imx_blk_ctl_hw imx8mp_media_blk_ctl_hws[] = {
+	/* clocks */
+	IMX_BLK_CTL_CLK_GATE("mipi_dsi_pclk", IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI_PCLK, 0x4, 0, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("mipi_dsi_clkref", IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI_CLKREF, 0x4, 1, "media_mipi_phy1_ref"),
+	IMX_BLK_CTL_CLK_GATE("mipi_csi_pclk", IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI_PCLK, 0x4, 2, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("mipi_csi_aclk", IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI_ACLK, 0x4, 3, "media_cam1_pix_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("lcdif_pixel_clk", IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_PIXEL, 0x4, 4, "media_disp1_pix_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("lcdif_apb_clk", IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_APB, 0x4, 5, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isi_proc_clk", IMX8MP_CLK_MEDIA_BLK_CTL_ISI_PROC, 0x4, 6, "media_axi_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isi_apb_clk", IMX8MP_CLK_MEDIA_BLK_CTL_ISI_APB, 0x4, 7, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("bus_blk_clk", IMX8MP_CLK_MEDIA_BLK_CTL_BUS_BLK, 0x4, 8, "media_axi_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("mipi_csi2_pclk", IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI2_PCLK, 0x4, 9, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("mipi_csi2_aclk", IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI2_ACLK, 0x4, 10, "media_cam2_pix_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("lcdif2_pixel_clk", IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_PIXEL, 0x4, 11, "media_disp2_pix_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("lcdif2_apb_clk", IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_APB, 0x4, 12, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isp1_cor_clk", IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_COR, 0x4, 13, "media_isp_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isp1_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_AXI, 0x4, 14, "media_axi_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isp1_ahb_clk", IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_AHB, 0x4, 15, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isp0_cor_clk", IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_COR, 0x4, 16, "media_isp_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isp0_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_AXI, 0x4, 17, "media_axi_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isp0_ahb_clk", IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_AHB, 0x4, 18, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("dwe_cor_clk", IMX8MP_CLK_MEDIA_BLK_CTL_DWE_COR, 0x4, 19, "media_axi_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("dwe_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTL_DWE_AXI, 0x4, 20, "media_axi_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("dwe_ahb_clk", IMX8MP_CLK_MEDIA_BLK_CTL_DWE_AHB, 0x4, 21, "media_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("mipi_dsi2_clk", IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI2, 0x4, 22, "media_mipi_phy1_ref"),
+	IMX_BLK_CTL_CLK_GATE("lcdif_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_AXI, 0x4, 23, "media_axi_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("lcdif2_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_AXI, 0x4, 24, "media_axi_root_clk"),
+
+	/* resets */
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_DSI_PCLK, 0, 0),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_DSI_CLKREF, 0, 1),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_CSI_PCLK, 0, 2),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_CSI_ACLK, 0, 3),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF_PIXEL, 0, 4),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF_APB, 0, 5),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_ISI_PROC, 0, 6),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_ISI_APB, 0, 7),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_BUS_BLK, 0, 8),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_CSI2_PCLK, 0, 9),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_CSI2_ACLK, 0, 10),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF2_PIXEL, 0, 11),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF2_APB, 0, 12),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_ISP1_COR, 0, 13),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_ISP1_AXI, 0, 14),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_ISP1_AHB, 0, 15),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_ISP0_COR, 0, 16),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_ISP0_AXI, 0, 17),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_ISP0_AHB, 0, 18),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_DWE_COR, 0, 19),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_DWE_AXI, 0, 20),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_DWE_AHB, 0, 21),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_DSI2, 0, 22),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF_AXI, 0, 23),
+	IMX_BLK_CTL_RESET(IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF2_AXI, 0, 24)
+};
+
+static struct imx_blk_ctl_hw imx8mp_audio_blk_ctl_hws[] = {
+	/* clocks */
+	IMX_BLK_CTL_CLK_MUX("sai_pll_ref_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI_PLL_REF_SEL, 0x400, 0, 2, imx_sai_pll_ref_sels),
+	IMX_BLK_CTL_CLK_PLL14XX("sai_pll", IMX8MP_CLK_AUDIO_BLK_CTL_SAI_PLL, 0x400, "sai_pll_ref_sel", &imx_blk_ctl_sai_pll),
+	IMX_BLK_CTL_CLK_MUX_FLAGS("sai_pll_bypass", IMX8MP_CLK_AUDIO_BLK_CTL_SAI_PLL_BYPASS, 0x400, 4, 1, imx_sai_pll_bypass_sels, CLK_SET_RATE_PARENT),
+	IMX_BLK_CTL_CLK_GATE("sai_pll_out", IMX8MP_CLK_AUDIO_BLK_CTL_SAI_PLL_OUT, 0x400, 13, "sai_pll_bypass"),
+	IMX_BLK_CTL_CLK_MUX_FLAGS("sai1_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI1_MCLK1_SEL, 0x300, 0, 1, imx_sai1_mclk1_sels, CLK_SET_RATE_PARENT),
+	IMX_BLK_CTL_CLK_MUX("sai1_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI1_MCLK2_SEL, 0x300, 1, 4, imx_sai_mclk2_sels),
+	IMX_BLK_CTL_CLK_MUX_FLAGS("sai2_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI2_MCLK1_SEL, 0x304, 0, 1, imx_sai2_mclk1_sels, CLK_SET_RATE_PARENT),
+	IMX_BLK_CTL_CLK_MUX("sai2_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI2_MCLK2_SEL, 0x304, 1, 4, imx_sai_mclk2_sels),
+	IMX_BLK_CTL_CLK_MUX_FLAGS("sai3_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI3_MCLK1_SEL, 0x308, 0, 1, imx_sai3_mclk1_sels, CLK_SET_RATE_PARENT),
+	IMX_BLK_CTL_CLK_MUX("sai3_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI3_MCLK2_SEL, 0x308, 1, 4, imx_sai_mclk2_sels),
+	IMX_BLK_CTL_CLK_MUX("sai5_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI5_MCLK1_SEL, 0x30C, 0, 1, imx_sai5_mclk1_sels),
+	IMX_BLK_CTL_CLK_MUX("sai5_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI5_MCLK2_SEL, 0x30C, 1, 4, imx_sai_mclk2_sels),
+	IMX_BLK_CTL_CLK_MUX("sai6_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI6_MCLK1_SEL, 0x310, 0, 1, imx_sai6_mclk1_sels),
+	IMX_BLK_CTL_CLK_MUX("sai6_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI6_MCLK2_SEL, 0x310, 1, 4, imx_sai_mclk2_sels),
+	IMX_BLK_CTL_CLK_MUX("sai7_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI7_MCLK1_SEL, 0x314, 0, 1, imx_sai7_mclk1_sels),
+	IMX_BLK_CTL_CLK_MUX("sai7_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTL_SAI7_MCLK2_SEL, 0x314, 1, 4, imx_sai_mclk2_sels),
+	IMX_BLK_CTL_CLK_GATE("sai1_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_SAI1_IPG, 0, 0, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("sai1_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI1_MCLK1, 0, 1, "sai1_mclk1_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai1_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI1_MCLK2, 0, 2, "sai1_mclk2_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai1_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI1_MCLK3, 0, 3, "sai_pll_out"),
+	IMX_BLK_CTL_CLK_GATE("sai2_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_SAI2_IPG, 0, 4, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("sai2_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI2_MCLK1, 0, 5, "sai2_mclk1_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai2_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI2_MCLK2, 0, 6, "sai2_mclk2_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai2_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI2_MCLK3, 0, 7, "sai_pll_out"),
+	IMX_BLK_CTL_CLK_GATE("sai3_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_SAI3_IPG, 0, 8, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("sai3_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI3_MCLK1, 0, 9, "sai3_mclk1_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai3_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI3_MCLK2, 0, 10, "sai3_mclk2_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai3_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI3_MCLK3, 0, 11, "sai_pll_out"),
+	IMX_BLK_CTL_CLK_GATE("sai5_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_SAI5_IPG, 0, 12, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("sai5_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI5_MCLK1, 0, 13, "sai5_mclk1_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai5_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI5_MCLK2, 0, 14, "sai5_mclk2_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai5_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI5_MCLK3, 0, 15, "sai_pll_out"),
+	IMX_BLK_CTL_CLK_GATE("sai6_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_SAI6_IPG, 0, 16, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("sai6_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI6_MCLK1, 0, 17, "sai6_mclk1_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai6_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI6_MCLK2, 0, 18, "sai6_mclk2_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai6_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI6_MCLK3, 0, 19, "sai_pll_out"),
+	IMX_BLK_CTL_CLK_GATE("sai7_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_SAI7_IPG, 0, 20, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("sai7_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI7_MCLK1, 0, 21, "sai7_mclk1_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai7_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI7_MCLK2, 0, 22, "sai7_mclk2_sel"),
+	IMX_BLK_CTL_CLK_GATE("sai7_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SAI7_MCLK3, 0, 23, "sai_pll_out"),
+	IMX_BLK_CTL_CLK_GATE("asrc_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_ASRC_IPG, 0, 24, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_SHARED_GATE("pdm_ipg_clk", IMX8MP_CLK_AUDIO_BLK_CTL_PDM_IPG, 0, 25, "audio_ahb_root", &shared_count_pdm),
+	IMX_BLK_CTL_CLK_SHARED_GATE("pdm_root_clk", IMX8MP_CLK_AUDIO_BLK_CTL_PDM_ROOT, 0, 25, "pdm_root", &shared_count_pdm),
+	IMX_BLK_CTL_CLK_GATE("sdma2_root_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SDMA2_ROOT, 0, 26, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("sdma3_root_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SDMA3_ROOT, 0, 27, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("spba2_root_clk", IMX8MP_CLK_AUDIO_BLK_CTL_SPBA2_ROOT, 0, 28, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("dsp_root_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_DSP_ROOT, 0, 29, "audio_axi_root"),
+	IMX_BLK_CTL_CLK_GATE("dsp_dbg_clk",    IMX8MP_CLK_AUDIO_BLK_CTL_DSPDBG_ROOT, 0, 30, "audio_axi_root"),
+	IMX_BLK_CTL_CLK_GATE("earc_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_EARC_IPG, 0, 31, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("ocram_a_ipg_clk", IMX8MP_CLK_AUDIO_BLK_CTL_OCRAMA_IPG, 4, 0, "audio_axi_root"),
+	IMX_BLK_CTL_CLK_GATE("aud2htx_ipg_clk", IMX8MP_CLK_AUDIO_BLK_CTL_AUD2HTX_IPG, 4, 1, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("edma_root_clk",   IMX8MP_CLK_AUDIO_BLK_CTL_EDMA_ROOT, 4, 2, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("aud_pll_clk",  IMX8MP_CLK_AUDIO_BLK_CTL_AUDPLL_ROOT, 4, 3, "osc_24m"),
+	IMX_BLK_CTL_CLK_GATE("mu2_root_clk", IMX8MP_CLK_AUDIO_BLK_CTL_MU2_ROOT, 4, 4, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("mu3_root_clk", IMX8MP_CLK_AUDIO_BLK_CTL_MU3_ROOT, 4, 5, "audio_ahb_root"),
+	IMX_BLK_CTL_CLK_GATE("earc_phy_clk", IMX8MP_CLK_AUDIO_BLK_CTL_EARC_PHY, 4, 6, "sai_pll_out"),
+	IMX_BLK_CTL_CLK_MUX("pdm_sel", IMX8MP_CLK_AUDIO_BLK_CTL_PDM_SEL, 0x318, 1, 4, imx_pdm_sels),
+
+	/* resets */
+	IMX_BLK_CTL_RESET(IMX8MP_AUDIO_BLK_CTL_EARC_RESET, 0x200, 0),
+	IMX_BLK_CTL_RESET(IMX8MP_AUDIO_BLK_CTL_EARC_PHY_RESET, 0x200, 1),
+};
+
+const struct imx_blk_ctl_dev_data imx8mp_hdmi_blk_ctl_dev_data __initconst = {
+	.hws = imx8mp_hdmi_blk_ctl_hws,
+	.hws_num = ARRAY_SIZE(imx8mp_hdmi_blk_ctl_hws),
+	.clocks_max = IMX8MP_CLK_HDMI_BLK_CTL_END,
+	.resets_max = IMX8MP_HDMI_BLK_CTL_RESET_NUM,
+	.pm_runtime_saved_regs_num = 0
+};
+
+const struct imx_blk_ctl_dev_data imx8mp_media_blk_ctl_dev_data __initconst = {
+	.hws = imx8mp_media_blk_ctl_hws,
+	.hws_num = ARRAY_SIZE(imx8mp_media_blk_ctl_hws),
+	.clocks_max = IMX8MP_CLK_MEDIA_BLK_CTL_END,
+	.resets_max = IMX8MP_MEDIA_BLK_CTL_RESET_NUM,
+	.pm_runtime_saved_regs_num = 2,
+	.pm_runtime_saved_regs = {
+		IMX_MEDIA_BLK_CTL_SFT_RSTN,
+		IMX_MEDIA_BLK_CTL_CLK_EN,
+	},
+};
+
+const struct imx_blk_ctl_dev_data imx8mp_audio_blk_ctl_dev_data __initconst = {
+	.hws = imx8mp_audio_blk_ctl_hws,
+	.hws_num = ARRAY_SIZE(imx8mp_audio_blk_ctl_hws),
+	.clocks_max = IMX8MP_CLK_AUDIO_BLK_CTL_END,
+	.resets_max = IMX8MP_AUDIO_BLK_CTL_RESET_NUM,
+	.pm_runtime_saved_regs_num = 16,
+	.pm_runtime_saved_regs = {
+		IMX_AUDIO_BLK_CTL_CLKEN0,
+		IMX_AUDIO_BLK_CTL_CLKEN1,
+		IMX_AUDIO_BLK_CTL_EARC,
+		IMX_AUDIO_BLK_CTL_SAI1_MCLK_SEL,
+		IMX_AUDIO_BLK_CTL_SAI2_MCLK_SEL,
+		IMX_AUDIO_BLK_CTL_SAI3_MCLK_SEL,
+		IMX_AUDIO_BLK_CTL_SAI5_MCLK_SEL,
+		IMX_AUDIO_BLK_CTL_SAI6_MCLK_SEL,
+		IMX_AUDIO_BLK_CTL_SAI7_MCLK_SEL,
+		IMX_AUDIO_BLK_CTL_PDM_CLK,
+		IMX_AUDIO_BLK_CTL_SAI_PLL_GNRL_CTL,
+		IMX_AUDIO_BLK_CTL_SAI_PLL_FDIVL_CTL0,
+		IMX_AUDIO_BLK_CTL_SAI_PLL_FDIVL_CTL1,
+		IMX_AUDIO_BLK_CTL_SAI_PLL_SSCG_CTL,
+		IMX_AUDIO_BLK_CTL_SAI_PLL_MNIT_CTL,
+		IMX_AUDIO_BLK_CTL_IPG_LP_CTRL
+	},
+};
+
+static const struct of_device_id imx_blk_ctl_of_match[] = {
+	{
+		.compatible = "fsl,imx8mp-audio-blk-ctl",
+		.data = &imx8mp_audio_blk_ctl_dev_data
+	},
+	{
+		.compatible = "fsl,imx8mp-media-blk-ctl",
+		.data = &imx8mp_media_blk_ctl_dev_data
+	},
+	{
+		.compatible = "fsl,imx8mp-hdmi-blk-ctl",
+		.data = &imx8mp_hdmi_blk_ctl_dev_data
+	},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
+
+static struct platform_driver imx_blk_ctl_driver = {
+	.probe = imx_blk_ctl_probe,
+	.driver = {
+		.name = "imx-blk-ctl",
+		.of_match_table = of_match_ptr(imx_blk_ctl_of_match),
+		.pm = &imx_blk_ctl_pm_ops,
+	},
+};
+module_platform_driver(imx_blk_ctl_driver);
-- 
2.7.4

