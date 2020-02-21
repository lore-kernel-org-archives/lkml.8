Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDE6C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7320656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBUHFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:05:40 -0500
Received: from inva021.nxp.com ([92.121.34.21]:37148 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgBUHFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:05:39 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 78435206BD2;
        Fri, 21 Feb 2020 08:05:37 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68574206BCF;
        Fri, 21 Feb 2020 08:05:30 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CD73A40246;
        Fri, 21 Feb 2020 15:05:21 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, john@phrozen.org, heiko@sntech.de,
        jonas.gorski@gmail.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] clk: imx: clk-sscg-pll: Drop unnecessary initialization
Date:   Fri, 21 Feb 2020 14:59:36 +0800
Message-Id: <1582268376-1672-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to initialize 'ret' in many functions, as it will get
the return value from function call, so remove the initializtion
of 'ret'.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-sscg-pll.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pll.c
index acd1b90..d4a2be1 100644
--- a/drivers/clk/imx/clk-sscg-pll.c
+++ b/drivers/clk/imx/clk-sscg-pll.c
@@ -195,10 +195,10 @@ static int clk_sscg_pll2_find_setup(struct clk_sscg_pll_setup *setup,
 					uint64_t ref)
 {
 
-	int ret = -EINVAL;
+	int ret;
 
 	if (ref < PLL_STAGE1_MIN_FREQ || ref > PLL_STAGE1_MAX_FREQ)
-		return ret;
+		return -EINVAL;
 
 	temp_setup->vco1 = ref;
 
@@ -254,10 +254,10 @@ static int clk_sscg_pll1_find_setup(struct clk_sscg_pll_setup *setup,
 					uint64_t ref)
 {
 
-	int ret = -EINVAL;
+	int ret;
 
 	if (ref < PLL_REF_MIN_FREQ || ref > PLL_REF_MAX_FREQ)
-		return ret;
+		return -EINVAL;
 
 	temp_setup->ref = ref;
 
@@ -428,7 +428,7 @@ static int __clk_sscg_pll_determine_rate(struct clk_hw *hw,
 	struct clk_sscg_pll_setup *setup = &pll->setup;
 	struct clk_hw *parent_hw = NULL;
 	int bypass_parent_index;
-	int ret = -EINVAL;
+	int ret;
 
 	req->max_rate = max;
 	req->min_rate = min;
@@ -467,10 +467,10 @@ static int clk_sscg_pll_determine_rate(struct clk_hw *hw,
 	uint64_t rate = req->rate;
 	uint64_t min = req->min_rate;
 	uint64_t max = req->max_rate;
-	int ret = -EINVAL;
+	int ret;
 
 	if (rate < PLL_OUT_MIN_FREQ || rate > PLL_OUT_MAX_FREQ)
-		return ret;
+		return -EINVAL;
 
 	ret = __clk_sscg_pll_determine_rate(hw, req, req->rate, req->rate,
 						rate, PLL_BYPASS2);
-- 
2.7.4

