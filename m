Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE395C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2C218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgBYIzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:55:31 -0500
Received: from inva020.nxp.com ([92.121.34.13]:43778 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgBYIza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:55:30 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68C081B35C6;
        Tue, 25 Feb 2020 09:55:28 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D294D1B35AE;
        Tue, 25 Feb 2020 09:55:20 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1FCDF402B3;
        Tue, 25 Feb 2020 16:55:12 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, peng.fan@nxp.com,
        ping.bai@nxp.com, fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/4] clk: imx8mn: A53 core clock no need to be critical
Date:   Tue, 25 Feb 2020 16:49:11 +0800
Message-Id: <1582620554-32689-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'A53_CORE' is just a mux and no need to be critical, being critical
will cause its parent clock always ON which does NOT make sense,
to make sure CPU's hardware clock source NOT being disabled during
clock tree setup, need to move the 'A53_SRC'/'A53_CORE' reparent
operations to after critical clock 'ARM_CLK' setup finished.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 83618af..0bc7070 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -428,7 +428,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_GPU_SHADER_DIV] = hws[IMX8MN_CLK_GPU_SHADER];
 
 	/* CORE SEL */
-	hws[IMX8MN_CLK_A53_CORE] = imx_clk_hw_mux2_flags("arm_a53_core", base + 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels), CLK_IS_CRITICAL);
+	hws[IMX8MN_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels));
 
 	/* BUS */
 	hws[IMX8MN_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800);
@@ -559,15 +559,15 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MN_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
 
-	clk_hw_set_parent(hws[IMX8MN_CLK_A53_SRC], hws[IMX8MN_SYS_PLL1_800M]);
-	clk_hw_set_parent(hws[IMX8MN_CLK_A53_CORE], hws[IMX8MN_ARM_PLL_OUT]);
-
 	hws[IMX8MN_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
 					   hws[IMX8MN_CLK_A53_CORE]->clk,
 					   hws[IMX8MN_CLK_A53_CORE]->clk,
 					   hws[IMX8MN_ARM_PLL_OUT]->clk,
 					   hws[IMX8MN_CLK_A53_DIV]->clk);
 
+	clk_hw_set_parent(hws[IMX8MN_CLK_A53_SRC], hws[IMX8MN_SYS_PLL1_800M]);
+	clk_hw_set_parent(hws[IMX8MN_CLK_A53_CORE], hws[IMX8MN_ARM_PLL_OUT]);
+
 	imx_check_clk_hws(hws, IMX8MN_CLK_END);
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
-- 
2.7.4

