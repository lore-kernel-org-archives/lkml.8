Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C10C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBEA2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgGPGaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:30:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:43366 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgGPGai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:30:38 -0400
IronPort-SDR: jVHbbEHJkM3Xt816+fmHunR4OXEih/z3JD3Jf985At9edlccRbZpaOii5+on2bR8RMusOufHno
 nVLRNGoX97wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="146839348"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="146839348"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 23:30:38 -0700
IronPort-SDR: D8J6wRg5tZG+0hXVNjp5mwySZxVxNo9S/DBrHfYM/jVX/S6Bof9gv0UX7a8uz1z3Jaezgum1DB
 kM7OsNhvYtrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="308520128"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2020 23:30:35 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 1/3] clk: intel: Use devm_clk_hw_register() instead of clk_hw_register()
Date:   Thu, 16 Jul 2020 14:30:30 +0800
Message-Id: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure that clks are unregistered in case of any failure, use
devm_clk_hw_register() instead of clk_hw_register().

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/clk/x86/clk-cgu-pll.c | 2 +-
 drivers/clk/x86/clk-cgu.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu-pll.c b/drivers/clk/x86/clk-cgu-pll.c
index c03cc6b85b9f..3179557b5f78 100644
--- a/drivers/clk/x86/clk-cgu-pll.c
+++ b/drivers/clk/x86/clk-cgu-pll.c
@@ -128,7 +128,7 @@ lgm_clk_register_pll(struct lgm_clk_provider *ctx,
 	pll->hw.init = &init;
 
 	hw = &pll->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index 56af0e04ec1e..88ebeb53b109 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -119,7 +119,7 @@ lgm_clk_register_mux(struct lgm_clk_provider *ctx,
 	mux->hw.init = &init;
 
 	hw = &mux->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -247,7 +247,7 @@ lgm_clk_register_divider(struct lgm_clk_provider *ctx,
 	div->hw.init = &init;
 
 	hw = &div->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -361,7 +361,7 @@ lgm_clk_register_gate(struct lgm_clk_provider *ctx,
 	gate->hw.init = &init;
 
 	hw = &gate->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -624,7 +624,7 @@ int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
 		ddiv->hw.init = &init;
 
 		hw = &ddiv->hw;
-		ret = clk_hw_register(dev, hw);
+		ret = devm_clk_hw_register(dev, hw);
 		if (ret) {
 			dev_err(dev, "register clk: %s failed!\n", list->name);
 			return ret;
-- 
2.11.0

