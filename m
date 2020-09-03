Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F6C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CDA206EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="YEqwU/C2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgICBva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:51:30 -0400
Received: from crapouillou.net ([89.234.176.41]:47958 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICBv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599097860; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIG4jiWjH+rBhh8d5jjI9SW/ilDkObyn2SfYZpymXII=;
        b=YEqwU/C2s/AUhkh3zikP0PI9p4us/M2QQpEhIv2p9YuU/lm1x2ImGLWtFM8td8iH4hOrdT
        DlriEC5LZQEGvfy+XKAurnC8XAHxHiZ51174FGmX8hvYlEYuaCql4gL6RkXXJwacfYZP2R
        65fBUDdecTZCR0tBefysKTckawFOIJ8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] clk: ingenic: Respect CLK_SET_RATE_PARENT in .round_rate
Date:   Thu,  3 Sep 2020 03:50:48 +0200
Message-Id: <20200903015048.3091523-5-paul@crapouillou.net>
In-Reply-To: <20200903015048.3091523-1-paul@crapouillou.net>
References: <20200903015048.3091523-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks that don't have a divider are in our case all marked with the
CLK_SET_RATE_PARENT flag. In this case, the .round_rate implementation
should modify the value pointed to by parent_rate, in order to propagate
the rate change to the parent, as explained in the documentation of
clk_set_rate().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index a1a4f1adaa3a..dac6edc670cc 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -445,6 +445,8 @@ ingenic_clk_round_rate(struct clk_hw *hw, unsigned long req_rate,
 		div = ingenic_clk_calc_div(clk_info, *parent_rate, req_rate);
 	else if (clk_info->type & CGU_CLK_FIXDIV)
 		div = clk_info->fixdiv.div;
+	else if (clk_hw_can_set_rate_parent(hw))
+		*parent_rate = req_rate;
 
 	return DIV_ROUND_UP(*parent_rate, div);
 }
-- 
2.28.0

