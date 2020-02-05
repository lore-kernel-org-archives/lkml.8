Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F050C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F324621741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JbHW6Y+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgBEGyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:54:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBEGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:54:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so489151pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 22:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xC6pTkHOfWDELEok5+Rk1+a9t64mfOMziwPkHBy7kSE=;
        b=JbHW6Y+RQ+QybQ7Gk2Mx+Qkw7MsZxHziwp2ap85W9f0rNcbLqhN+21ukKwPPvKo+1k
         BLURHbCzVbGG+DYX1+w7EaLK6UsUcAaK0MDtMo3lpMtXuMfnxymPl/eyLpiwq3Lay191
         78N/ayHrbaAG/KBmuJ3digCu40Cf7aWoX6rbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xC6pTkHOfWDELEok5+Rk1+a9t64mfOMziwPkHBy7kSE=;
        b=GtynvFS4rIS4uHQaasshsSVPbuC2wpnFtI77jRbbTONmGEUUR+6kqVWo0noK5RbH0j
         Kug905hjqNxXbMA95EpxxnFyO63L1AgzzVQToLXI5yNWAvZdiaq3yR7ZeQoDwkcEZN2v
         IkzpVLEpthCHKU9y/fv45UN1+XE/899vPmR9o5NWNln7EZ8SQ6vo6/36TLcuudtv37Dq
         mDOZ7ia3/kF3B9bglWcGvYmnaOrJE6Fgj4qrhaywShVKtwv7xHg1sDs1YrRBIP1g+r3b
         prxoo25eRz6xzBo8pCA7b9fxlJOjzWn+IUROq9dP2kJ2nHuy83XNfA3S1VGH7Acdeg3N
         KQjA==
X-Gm-Message-State: APjAAAU4bpTnEE1XNcx2oiosNe8XOjHopD23ghKCT0XqmTgMWgNRgnUB
        aT8iITUXSmLXgrccWdDphXpp6g==
X-Google-Smtp-Source: APXvYqxLtsypnc5e6xwR5LhibDb5b+SOMmWOhDPpwbRPbyJCr56/sg1cj0sMa+gJN96i0oonpU3OWg==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr35694347pfg.51.1580885662409;
        Tue, 04 Feb 2020 22:54:22 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u18sm26278894pgi.44.2020.02.04.22.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 22:54:21 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH] clk: qcom: alpha-pll: Make error prints more informative
Date:   Tue,  4 Feb 2020 22:54:21 -0800
Message-Id: <20200205065421.9426-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently ran across this printk error message spewing in my logs

 Call set rate on the PLL with rounded rates!

and I had no idea what clk that was or what rate was failing to round
properly. Make the printk more informative by telling us what went wrong
and also add the name of the clk that's failing to change rate.
Furthermore, update the other printks in this file with the clk name
each time so we know what clk we're talking about.

Cc: Taniya Das <tdas@codeaurora.org>
Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 7c2936da9b14..6d946770a80f 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -544,7 +544,8 @@ static int __clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
 	vco = alpha_pll_find_vco(pll, rate);
 	if (pll->vco_table && !vco) {
-		pr_err("alpha pll not in a valid vco range\n");
+		pr_err("%s: alpha pll not in a valid vco range\n",
+		       clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
@@ -722,7 +723,7 @@ static int alpha_pll_huayra_set_rate(struct clk_hw *hw, unsigned long rate,
 	 */
 	if (clk_alpha_pll_is_enabled(hw)) {
 		if (cur_alpha != a) {
-			pr_err("clock needs to be gated %s\n",
+			pr_err("%s: clock needs to be gated\n",
 			       clk_hw_get_name(hw));
 			return -EBUSY;
 		}
@@ -1170,7 +1171,7 @@ static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, alpha_width = pll_alpha_width(pll);
 	u64 a;
-	unsigned long rrate;
+	unsigned long rrate, max = rate + FABIA_PLL_RATE_MARGIN;
 
 	rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
 
@@ -1178,8 +1179,9 @@ static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
 	 * Due to limited number of bits for fractional rate programming, the
 	 * rounded up rate could be marginally higher than the requested rate.
 	 */
-	if (rrate > (rate + FABIA_PLL_RATE_MARGIN) || rrate < rate) {
-		pr_err("Call set rate on the PLL with rounded rates!\n");
+	if (rrate > max || rrate < rate) {
+		pr_err("%s: Rounded rate %lu not within range [%lu, %lu)\n",
+		       clk_hw_get_name(hw), rrate, rate, max);
 		return -EINVAL;
 	}
 
@@ -1196,6 +1198,7 @@ static int alpha_pll_fabia_prepare(struct clk_hw *hw)
 	struct clk_hw *parent_hw;
 	unsigned long cal_freq, rrate;
 	u32 cal_l, val, alpha_width = pll_alpha_width(pll);
+	const char *name = clk_hw_get_name(hw);
 	u64 a;
 	int ret;
 
@@ -1210,7 +1213,7 @@ static int alpha_pll_fabia_prepare(struct clk_hw *hw)
 
 	vco = alpha_pll_find_vco(pll, clk_hw_get_rate(hw));
 	if (!vco) {
-		pr_err("alpha pll: not in a valid vco range\n");
+		pr_err("%s: alpha pll not in a valid vco range\n", name);
 		return -EINVAL;
 	}
 
@@ -1236,7 +1239,7 @@ static int alpha_pll_fabia_prepare(struct clk_hw *hw)
 	/* Bringup the PLL at calibration frequency */
 	ret = clk_alpha_pll_enable(hw);
 	if (ret) {
-		pr_err("alpha pll calibration failed\n");
+		pr_err("%s: alpha pll calibration failed\n", name);
 		return ret;
 	}
 
-- 
Sent by a computer, using git, on the internet

