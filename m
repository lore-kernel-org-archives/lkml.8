Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0695CC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE433206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIHKg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:36:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56356 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbgIHK0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BED472011C6;
        Tue,  8 Sep 2020 12:26:11 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B1DC720025C;
        Tue,  8 Sep 2020 12:26:11 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B28120327;
        Tue,  8 Sep 2020 12:26:11 +0200 (CEST)
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
Subject: [PATCH v3 08/14] clk: imx8mp: Add audio shared gate
Date:   Tue,  8 Sep 2020 13:24:45 +0300
Message-Id: <1599560691-3763-9-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the RM, the CCGR101 is shared for the following root clocks:
- AUDIO_AHB_CLK_ROOT
- AUDIO_AXI_CLK_ROOT
- SAI2_CLK_ROOT
- SAI3_CLK_ROOT
- SAI5_CLK_ROOT
- SAI6_CLK_ROOT
- SAI7_CLK_ROOT
- PDM_CLK_ROOT

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 12ce477..6812a01 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -17,6 +17,7 @@
 
 static u32 share_count_nand;
 static u32 share_count_media;
+static u32 share_count_audio;
 
 static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
@@ -725,7 +726,16 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_HDMI_ROOT] = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", ccm_base + 0x45f0, 0);
 	hws[IMX8MP_CLK_TSENSOR_ROOT] = imx_clk_hw_gate4("tsensor_root_clk", "ipg_root", ccm_base + 0x4620, 0);
 	hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", ccm_base + 0x4630, 0);
-	hws[IMX8MP_CLK_AUDIO_ROOT] = imx_clk_hw_gate4("audio_root_clk", "ipg_root", ccm_base + 0x4650, 0);
+
+	hws[IMX8MP_CLK_AUDIO_AHB_ROOT] = imx_clk_hw_gate2_shared2("audio_ahb_root", "audio_ahb", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_AUDIO_AXI_ROOT] = imx_clk_hw_gate2_shared2("audio_axi_root", "audio_axi", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI1_ROOT] = imx_clk_hw_gate2_shared2("sai1_root", "sai1", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root", "sai2", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root", "sai3", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root", "sai5", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root", "sai6", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root", "sai7", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root", "pdm", ccm_base + 0x4650, 0, &share_count_audio);
 
 	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
 					     hws[IMX8MP_CLK_A53_CORE]->clk,
-- 
2.7.4

