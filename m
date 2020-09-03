Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D895C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D85A206EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="yiPWvnkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgICBvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:51:23 -0400
Received: from crapouillou.net ([89.234.176.41]:47938 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICBvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599097859; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJiJklocasIc6J5kOikYu2s2q4dlO3I37o2u+17tEl4=;
        b=yiPWvnkNMeeaC0df5QWltkTSLeR7f08S3ehUikCIPMW1W5KAvjhSnEo9hzezHmugdA8dsz
        p1o7McQHHqgxfTWzjt8jgCj19QBGKXdtcBpmhVSF8A47qy3Wrm6W4Sd9wAZoRSBGSABD3s
        LWIRKVhkS49w1esP72W27JIfdpEhWvk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] clk: ingenic: Don't tag custom clocks with CLK_SET_RATE_PARENT
Date:   Thu,  3 Sep 2020 03:50:47 +0200
Message-Id: <20200903015048.3091523-4-paul@crapouillou.net>
In-Reply-To: <20200903015048.3091523-1-paul@crapouillou.net>
References: <20200903015048.3091523-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom clocks have custom functions to round, get or set their rate.
Therefore, we can't assume that they need the CLK_SET_RATE_PARENT flag.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 521a40dfcb72..a1a4f1adaa3a 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -629,6 +629,13 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 
 	caps = clk_info->type;
 
+	if (caps & CGU_CLK_DIV) {
+		caps &= ~CGU_CLK_DIV;
+	} else if (!(caps & CGU_CLK_CUSTOM)) {
+		/* pass rate changes to the parent clock */
+		clk_init.flags |= CLK_SET_RATE_PARENT;
+	}
+
 	if (caps & (CGU_CLK_MUX | CGU_CLK_CUSTOM)) {
 		clk_init.num_parents = 0;
 
@@ -690,13 +697,6 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 		caps &= ~(CGU_CLK_MUX | CGU_CLK_MUX_GLITCHFREE);
 	}
 
-	if (caps & CGU_CLK_DIV) {
-		caps &= ~CGU_CLK_DIV;
-	} else {
-		/* pass rate changes to the parent clock */
-		clk_init.flags |= CLK_SET_RATE_PARENT;
-	}
-
 	if (caps) {
 		pr_err("%s: unknown clock type 0x%x\n", __func__, caps);
 		goto out;
-- 
2.28.0

