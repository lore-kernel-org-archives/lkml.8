Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080C2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09BF2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgG2MIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:08:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48114 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgG2MIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:08:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CBFB1A01D1;
        Wed, 29 Jul 2020 14:08:28 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C7521A1111;
        Wed, 29 Jul 2020 14:08:28 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C52F72032B;
        Wed, 29 Jul 2020 14:08:27 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Fugang Duan <fugang.duan@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 14/17] clk: imx8mp: Add media blk_ctrl clocks and resets
Date:   Wed, 29 Jul 2020 15:08:00 +0300
Message-Id: <1596024483-21482-15-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add media blk_ctrl clocks and resets in the i.MX8MP clock
driver to be picked up by the clk-blk-ctrl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-blk-ctrl.c |  4 +++
 drivers/clk/imx/clk-imx8mp.c   | 68 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/clk/imx/clk-blk-ctrl.c b/drivers/clk/imx/clk-blk-ctrl.c
index cee7298..81fc91c 100644
--- a/drivers/clk/imx/clk-blk-ctrl.c
+++ b/drivers/clk/imx/clk-blk-ctrl.c
@@ -308,6 +308,10 @@ static const struct of_device_id imx_blk_ctrl_of_match[] = {
 		.data = &imx8mp_audio_blk_ctrl_dev_data
 	},
 	{
+		.compatible = "fsl,imx8mp-media-blk-ctrl",
+		.data = &imx8mp_media_blk_ctrl_dev_data
+	},
+	{
 		.compatible = "fsl,imx8mp-hdmi-blk-ctrl",
 		.data = &imx8mp_hdmi_blk_ctrl_dev_data
 	},
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 6b0f4ef..8553032 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -121,6 +121,62 @@ static struct imx_blk_ctrl_hw imx8mp_hdmi_blk_ctrl_hws[] = {
 	IMX_BLK_CTRL_RESET_MASK(IMX8MP_HDMI_BLK_CTRL_LCDIF_RESET, 0x20, 4, 0x3),
 };
 
+static struct imx_blk_ctrl_hw imx8mp_media_blk_ctrl_hws[] = {
+	/* clocks */
+	IMX_BLK_CTRL_CLK_GATE("mipi_dsi_pclk", IMX8MP_CLK_MEDIA_BLK_CTRL_MIPI_DSI_PCLK, 0x4, 0, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("mipi_dsi_clkref", IMX8MP_CLK_MEDIA_BLK_CTRL_MIPI_DSI_CLKREF, 0x4, 1, "media_mipi_phy1_ref"),
+	IMX_BLK_CTRL_CLK_GATE("mipi_csi_pclk", IMX8MP_CLK_MEDIA_BLK_CTRL_MIPI_CSI_PCLK, 0x4, 2, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("mipi_csi_aclk", IMX8MP_CLK_MEDIA_BLK_CTRL_MIPI_CSI_ACLK, 0x4, 3, "media_cam1_pix_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif_pixel_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_LCDIF_PIXEL, 0x4, 4, "media_disp1_pix_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif_apb_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_LCDIF_APB, 0x4, 5, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("isi_proc_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_ISI_PROC, 0x4, 6, "media_axi_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("isi_apb_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_ISI_APB, 0x4, 7, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("bus_blk_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_BUS_BLK, 0x4, 8, "media_axi_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("mipi_csi2_pclk", IMX8MP_CLK_MEDIA_BLK_CTRL_MIPI_CSI2_PCLK, 0x4, 9, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("mipi_csi2_aclk", IMX8MP_CLK_MEDIA_BLK_CTRL_MIPI_CSI2_ACLK, 0x4, 10, "media_cam2_pix_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif2_pixel_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_LCDIF2_PIXEL, 0x4, 11, "media_disp2_pix_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif2_apb_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_LCDIF2_APB, 0x4, 12, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("isp1_cor_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_ISP1_COR, 0x4, 13, "media_isp_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("isp1_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_ISP1_AXI, 0x4, 14, "media_axi_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("isp1_ahb_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_ISP1_AHB, 0x4, 15, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("isp0_cor_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_ISP0_COR, 0x4, 16, "media_isp_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("isp0_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_ISP0_AXI, 0x4, 17, "media_axi_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("isp0_ahb_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_ISP0_AHB, 0x4, 18, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("dwe_cor_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_DWE_COR, 0x4, 19, "media_axi_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("dwe_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_DWE_AXI, 0x4, 20, "media_axi_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("dwe_ahb_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_DWE_AHB, 0x4, 21, "media_apb_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("mipi_dsi2_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_MIPI_DSI2, 0x4, 22, "media_mipi_phy1_ref"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_LCDIF_AXI, 0x4, 23, "media_axi_root_clk"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif2_axi_clk", IMX8MP_CLK_MEDIA_BLK_CTRL_LCDIF2_AXI, 0x4, 24, "media_axi_root_clk"),
+
+	/* resets */
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_DSI_PCLK, 0, 0),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_DSI_CLKREF, 0, 1),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_CSI_PCLK, 0, 2),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_CSI_ACLK, 0, 3),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF_PIXEL, 0, 4),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF_APB, 0, 5),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_ISI_PROC, 0, 6),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_ISI_APB, 0, 7),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_BUS_BLK, 0, 8),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_CSI2_PCLK, 0, 9),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_CSI2_ACLK, 0, 10),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF2_PIXEL, 0, 11),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF2_APB, 0, 12),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_ISP1_COR, 0, 13),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_ISP1_AXI, 0, 14),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_ISP1_AHB, 0, 15),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_ISP0_COR, 0, 16),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_ISP0_AXI, 0, 17),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_ISP0_AHB, 0, 18),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_DWE_COR, 0, 19),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_DWE_AXI, 0, 20),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_DWE_AHB, 0, 21),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_DSI2, 0, 22),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF_AXI, 0, 23),
+	IMX_BLK_CTRL_RESET(IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF2_AXI, 0, 24)
+};
+
 static struct imx_blk_ctrl_hw imx8mp_audio_blk_ctrl_hws[] = {
 	/* clocks */
 	IMX_BLK_CTRL_CLK_MUX("sai_pll_ref_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL_REF_SEL, 0x400, 0, 2, imx_sai_pll_ref_sels),
@@ -194,6 +250,18 @@ const struct imx_blk_ctrl_dev_data imx8mp_hdmi_blk_ctrl_dev_data __initconst = {
 	.pm_runtime_saved_regs_num = 0
 };
 
+const struct imx_blk_ctrl_dev_data imx8mp_media_blk_ctrl_dev_data __initconst = {
+	.hws = imx8mp_media_blk_ctrl_hws,
+	.hws_num = ARRAY_SIZE(imx8mp_media_blk_ctrl_hws),
+	.clocks_max = IMX8MP_CLK_MEDIA_BLK_CTRL_END,
+	.resets_max = IMX8MP_MEDIA_BLK_CTRL_RESET_NUM,
+	.pm_runtime_saved_regs_num = 2,
+	.pm_runtime_saved_regs = {
+		IMX_MEDIA_BLK_CTRL_SFT_RSTN,
+		IMX_MEDIA_BLK_CTRL_CLK_EN,
+	},
+};
+
 const struct imx_blk_ctrl_dev_data imx8mp_audio_blk_ctrl_dev_data __initconst = {
 	.hws = imx8mp_audio_blk_ctrl_hws,
 	.hws_num = ARRAY_SIZE(imx8mp_audio_blk_ctrl_hws),
-- 
2.7.4

