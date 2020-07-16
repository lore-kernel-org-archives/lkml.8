Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E87AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182C7206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgGPGap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:30:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:33403 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgGPGao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:30:44 -0400
IronPort-SDR: gOku7sMeGEhyoC08WgQYt7RONdQeqUocjpuz7t0AOhxHCA0EbYz0rMRv1CaRR925ezJ3EGo+hO
 ognwrkrWNGYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="167459551"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="167459551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 23:30:43 -0700
IronPort-SDR: oGun7jWaU2QBowGoUD3ZcWtrOx6mBdXSyBlmihxJnd2HEnon5i6t8v/thqatm4IsihE9DQakaV
 QTdgvdWnvhqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="270479642"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2020 23:30:40 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 2/3] clk: intel: Improve locking in the driver
Date:   Thu, 16 Jul 2020 14:30:31 +0800
Message-Id: <79c0f5f9f5bc512a7e2b5f3c91f6341f28b5854c.1594880946.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
References: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
References: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove/reduce unnecessary spin locking of the code.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/clk/x86/clk-cgu.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index 88ebeb53b109..c379fedfb9f2 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -420,18 +420,14 @@ lgm_clk_ddiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
 	unsigned int div0, div1, exdiv;
-	unsigned long flags;
 	u64 prate;
 
-	spin_lock_irqsave(&ddiv->lock, flags);
 	div0 = lgm_get_clk_val(ddiv->membase, ddiv->reg,
 			       ddiv->shift0, ddiv->width0) + 1;
 	div1 = lgm_get_clk_val(ddiv->membase, ddiv->reg,
 			       ddiv->shift1, ddiv->width1) + 1;
 	exdiv = lgm_get_clk_val(ddiv->membase, ddiv->reg,
 				ddiv->shift2, ddiv->width2);
-	spin_unlock_irqrestore(&ddiv->lock, flags);
-
 	prate = (u64)parent_rate;
 	do_div(prate, div0);
 	do_div(prate, div1);
@@ -548,24 +544,21 @@ lgm_clk_ddiv_round_rate(struct clk_hw *hw, unsigned long rate,
 		div = div * 2;
 		div = DIV_ROUND_CLOSEST_ULL((u64)div, 5);
 	}
+	spin_unlock_irqrestore(&ddiv->lock, flags);
 
-	if (div <= 0) {
-		spin_unlock_irqrestore(&ddiv->lock, flags);
+	if (div <= 0)
 		return *prate;
-	}
 
-	if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2) != 0) {
-		if (lgm_clk_get_ddiv_val(div + 1, &ddiv1, &ddiv2) != 0) {
-			spin_unlock_irqrestore(&ddiv->lock, flags);
+	if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2) != 0)
+		if (lgm_clk_get_ddiv_val(div + 1, &ddiv1, &ddiv2) != 0)
 			return -EINVAL;
-		}
-	}
 
 	rate64 = *prate;
 	do_div(rate64, ddiv1);
 	do_div(rate64, ddiv2);
 
 	/* if predivide bit is enabled, modify rounded rate by factor of 2.5 */
+	spin_lock_irqsave(&ddiv->lock, flags);
 	if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
 		rate64 = rate64 * 2;
 		rate64 = DIV_ROUND_CLOSEST_ULL(rate64, 5);
-- 
2.11.0

