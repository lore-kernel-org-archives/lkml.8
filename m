Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5514DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B35220809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgG2MJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:09:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48080 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgG2MIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:08:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C2E281A1120;
        Wed, 29 Jul 2020 14:08:27 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B5E621A111A;
        Wed, 29 Jul 2020 14:08:27 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1AB8C2032B;
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
Subject: [PATCH 13/17] clk: imx8mp: Add hdmi blk_ctrl clocks and resets
Date:   Wed, 29 Jul 2020 15:07:59 +0300
Message-Id: <1596024483-21482-14-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hdmi blk_ctrl clocks and resets in the i.MX8MP clock
driver to be picked up by the clk-blk-ctrl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-blk-ctrl.c |  4 +++
 drivers/clk/imx/clk-imx8mp.c   | 63 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/clk/imx/clk-blk-ctrl.c b/drivers/clk/imx/clk-blk-ctrl.c
index 67cf223..cee7298 100644
--- a/drivers/clk/imx/clk-blk-ctrl.c
+++ b/drivers/clk/imx/clk-blk-ctrl.c
@@ -307,6 +307,10 @@ static const struct of_device_id imx_blk_ctrl_of_match[] = {
 		.compatible = "fsl,imx8mp-audio-blk-ctrl",
 		.data = &imx8mp_audio_blk_ctrl_dev_data
 	},
+	{
+		.compatible = "fsl,imx8mp-hdmi-blk-ctrl",
+		.data = &imx8mp_hdmi_blk_ctrl_dev_data
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_blk_ctrl_of_match);
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 00e7f5e..6b0f4ef 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -66,6 +66,61 @@ static const char * const imx_pdm_sels[] = {"pdm_root", "sai_pll_div2", "dummy",
 static const char * const imx_sai_pll_ref_sels[] = {"osc_24m", "dummy", "dummy", "dummy", };
 static const char * const imx_sai_pll_bypass_sels[] = {"sai_pll", "sai_pll_ref_sel", };
 
+static const char * const imx_hdmi_phy_clks_sels[] = {"hdmi_glb_24m", "dummy", };
+static const char * const imx_lcdif_clks_sels[] = {"dummy", "hdmi_glb_pix", };
+static const char * const imx_hdmi_pipe_clks_sels[] = {"dummy", "hdmi_glb_pix", };
+
+static struct imx_blk_ctrl_hw imx8mp_hdmi_blk_ctrl_hws[] = {
+	/* clocks */
+	IMX_BLK_CTRL_CLK_GATE("hdmi_glb_apb", IMX8MP_CLK_HDMI_BLK_CTRL_GLOBAL_APB_CLK, 0x40, 0, "hdmi_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_glb_b", IMX8MP_CLK_HDMI_BLK_CTRL_GLOBAL_B_CLK, 0x40, 1, "hdmi_axi"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_glb_ref_266m", IMX8MP_CLK_HDMI_BLK_CTRL_GLOBAL_REF266M_CLK, 0x40, 2, "hdmi_ref_266m"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_glb_24m", IMX8MP_CLK_HDMI_BLK_CTRL_GLOBAL_XTAL24M_CLK, 0x40, 4, "hdmi_24m"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_glb_32k", IMX8MP_CLK_HDMI_BLK_CTRL_GLOBAL_XTAL32K_CLK, 0x40, 5, "osc_32k"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_glb_pix", IMX8MP_CLK_HDMI_BLK_CTRL_GLOBAL_TX_PIX_CLK, 0x40, 7, "hdmi_phy"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_irq_steer", IMX8MP_CLK_HDMI_BLK_CTRL_IRQS_STEER_CLK, 0x40, 9, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_noc", IMX8MP_CLK_HDMI_BLK_CTRL_NOC_HDMI_CLK, 0x40, 10, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdcp_noc", IMX8MP_CLK_HDMI_BLK_CTRL_NOC_HDCP_CLK, 0x40, 11,  "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif3_apb", IMX8MP_CLK_HDMI_BLK_CTRL_LCDIF_APB_CLK, 0x40, 16, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif3_b", IMX8MP_CLK_HDMI_BLK_CTRL_LCDIF_B_CLK, 0x40, 17, "hdmi_glb_b"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif3_pdi", IMX8MP_CLK_HDMI_BLK_CTRL_LCDIF_PDI_CLK, 0x40, 18, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif3_pxl", IMX8MP_CLK_HDMI_BLK_CTRL_LCDIF_PIX_CLK, 0x40, 19, "hdmi_glb_pix"),
+	IMX_BLK_CTRL_CLK_GATE("lcdif3_spu", IMX8MP_CLK_HDMI_BLK_CTRL_LCDIF_SPU_CLK, 0x40, 20, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_fdcc_ref", IMX8MP_CLK_HDMI_BLK_CTRL_FDCC_REF_CLK, 0x50, 2, "hdmi_fdcc_tst"),
+	IMX_BLK_CTRL_CLK_GATE("hrv_mwr_apb", IMX8MP_CLK_HDMI_BLK_CTRL_HRV_MWR_APB_CLK, 0x50, 3, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hrv_mwr_b", IMX8MP_CLK_HDMI_BLK_CTRL_HRV_MWR_B_CLK, 0x50, 4, "hdmi_glb_axi"),
+	IMX_BLK_CTRL_CLK_GATE("hrv_mwr_cea", IMX8MP_CLK_HDMI_BLK_CTRL_HRV_MWR_CEA_CLK, 0x50, 5, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("vsfd_cea", IMX8MP_CLK_HDMI_BLK_CTRL_VSFD_CEA_CLK, 0x50, 6, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_tx_hpi", IMX8MP_CLK_HDMI_BLK_CTRL_TX_HPI_CLK, 0x50, 13, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_tx_apb", IMX8MP_CLK_HDMI_BLK_CTRL_TX_APB_CLK, 0x50, 14, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_cec", IMX8MP_CLK_HDMI_BLK_CTRL_TX_CEC_CLK, 0x50, 15, "hdmi_glb_32k"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_esm", IMX8MP_CLK_HDMI_BLK_CTRL_TX_ESM_CLK, 0x50, 16, "hdmi_glb_ref_266m"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_tx_gpa", IMX8MP_CLK_HDMI_BLK_CTRL_TX_GPA_CLK, 0x50, 17, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_tx_pix", IMX8MP_CLK_HDMI_BLK_CTRL_TX_PIXEL_CLK, 0x50, 18, "hdmi_glb_pix"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_tx_sfr", IMX8MP_CLK_HDMI_BLK_CTRL_TX_SFR_CLK, 0x50, 19, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_tx_skp", IMX8MP_CLK_HDMI_BLK_CTRL_TX_SKP_CLK, 0x50, 20, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_tx_prep", IMX8MP_CLK_HDMI_BLK_CTRL_TX_PREP_CLK, 0x50, 21, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_phy_apb", IMX8MP_CLK_HDMI_BLK_CTRL_TX_PHY_APB_CLK, 0x50, 22, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_phy_int", IMX8MP_CLK_HDMI_BLK_CTRL_TX_PHY_INT_CLK, 0x50, 24, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_sec_mem", IMX8MP_CLK_HDMI_BLK_CTRL_TX_SEC_MEM_CLK, 0x50, 25, "hdmi_glb_ref_266m"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_trng_skp", IMX8MP_CLK_HDMI_BLK_CTRL_TX_TRNG_SKP_CLK, 0x50, 27, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_vid_pix",  IMX8MP_CLK_HDMI_BLK_CTRL_TX_VID_LINK_PIX_CLK, 0x50, 28, "hdmi_glb_pix"),
+	IMX_BLK_CTRL_CLK_GATE("hdmi_trng_apb", IMX8MP_CLK_HDMI_BLK_CTRL_TX_TRNG_APB_CLK, 0x50, 30, "hdmi_glb_apb"),
+	IMX_BLK_CTRL_CLK_MUX("hdmi_phy_sel", IMX8MP_CLK_HDMI_BLK_CTRL_HTXPHY_CLK_SEL, 0x50, 10, 1, imx_hdmi_phy_clks_sels),
+	IMX_BLK_CTRL_CLK_MUX("lcdif_clk_sel", IMX8MP_CLK_HDMI_BLK_CTRL_LCDIF_CLK_SEL, 0x50, 11, 1, imx_lcdif_clks_sels),
+	IMX_BLK_CTRL_CLK_MUX("hdmi_pipe_sel", IMX8MP_CLK_HDMI_BLK_CTRL_TX_PIPE_CLK_SEL, 0x50, 12, 1, imx_hdmi_pipe_clks_sels),
+
+	/* resets */
+	IMX_BLK_CTRL_RESET_MASK(IMX8MP_HDMI_BLK_CTRL_HDMI_TX_RESET, 0x20, 6, 0x33),
+	IMX_BLK_CTRL_RESET(IMX8MP_HDMI_BLK_CTRL_HDMI_PHY_RESET, 0x20, 12),
+	IMX_BLK_CTRL_RESET(IMX8MP_HDMI_BLK_CTRL_HDMI_PAI_RESET, 0x20, 18),
+	IMX_BLK_CTRL_RESET(IMX8MP_HDMI_BLK_CTRL_HDMI_PAI_RESET, 0x20, 22),
+	IMX_BLK_CTRL_RESET(IMX8MP_HDMI_BLK_CTRL_HDMI_TRNG_RESET, 0x20, 20),
+	IMX_BLK_CTRL_RESET(IMX8MP_HDMI_BLK_CTRL_IRQ_STEER_RESET, 0x20, 16),
+	IMX_BLK_CTRL_RESET(IMX8MP_HDMI_BLK_CTRL_HDMI_HDCP_RESET, 0x20, 13),
+	IMX_BLK_CTRL_RESET_MASK(IMX8MP_HDMI_BLK_CTRL_LCDIF_RESET, 0x20, 4, 0x3),
+};
+
 static struct imx_blk_ctrl_hw imx8mp_audio_blk_ctrl_hws[] = {
 	/* clocks */
 	IMX_BLK_CTRL_CLK_MUX("sai_pll_ref_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL_REF_SEL, 0x400, 0, 2, imx_sai_pll_ref_sels),
@@ -131,6 +186,14 @@ static struct imx_blk_ctrl_hw imx8mp_audio_blk_ctrl_hws[] = {
 	IMX_BLK_CTRL_RESET(IMX8MP_AUDIO_BLK_CTRL_EARC_PHY_RESET, 0x200, 1),
 };
 
+const struct imx_blk_ctrl_dev_data imx8mp_hdmi_blk_ctrl_dev_data __initconst = {
+	.hws = imx8mp_hdmi_blk_ctrl_hws,
+	.hws_num = ARRAY_SIZE(imx8mp_hdmi_blk_ctrl_hws),
+	.clocks_max = IMX8MP_CLK_HDMI_BLK_CTRL_END,
+	.resets_max = IMX8MP_HDMI_BLK_CTRL_RESET_NUM,
+	.pm_runtime_saved_regs_num = 0
+};
+
 const struct imx_blk_ctrl_dev_data imx8mp_audio_blk_ctrl_dev_data __initconst = {
 	.hws = imx8mp_audio_blk_ctrl_hws,
 	.hws_num = ARRAY_SIZE(imx8mp_audio_blk_ctrl_hws),
-- 
2.7.4

