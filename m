Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271DB20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HVwSupNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgIBXDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgIBXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:02:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103BDC06125E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:02:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s2so499492pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwN4Lh5cIbYb5K/fWg1B1RhUro5At/hehYhhAFZFYDY=;
        b=HVwSupNRyAt5qg38NUR/fQsc16sOP7RT0vs04n7Ld8c0xycgsACvoptse10SGP2ptz
         BegceDPWP7y72W3BZ4Z+7C7t2lo8KaESMi/CIKGrvETNT2fzyF5QdOa//FhxwzsLI9wX
         DV+FptzZFasdr1/mr2sHHPMam49JA0dB7LynE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwN4Lh5cIbYb5K/fWg1B1RhUro5At/hehYhhAFZFYDY=;
        b=ZqYIV/zgjyJ14GJJSA77EDqJEXpPHw1JGOLA431wA91gQ5hhwChGpe0I6N6Y1q+M6P
         LKAC5egGQSOc3fHuh7yqpwzVylu4f0H6RKLtyLegPQNj+k4tdnOttD8h8HwbRkK01p+Y
         CsxbAInJbBC5yUIAqr7ahWoyr5V3MJUqocva9G4Zi27OM+0uzYmHB4tnf41YIbXGYziH
         UmQpjSd1yg3bLZyINvl5AC2m/S/R3G8kt2S9w5S0hxZKxvG8LpLQ4tra6w5i+G1RPdq4
         by8q0e4c2jGprJAZC9WwlHTe4dlkX72iYIZJMHSv3/jGrOLTF4qL5CNnsVtO0SYqZtji
         YPNA==
X-Gm-Message-State: AOAM530hfW8jdW9Aszyv6VAlAxQz0/0IF9Ts7Y+ojgJtXnN4yMfoiexu
        +FUSXVOSSBEKFun1Zdt9uOafGg==
X-Google-Smtp-Source: ABdhPJyf7Col0ONJABbEvtaMDB0Asdh5yKEaCbKFoQ5JcY/Kx/F85x+LXRanLFyxDGZudI2+5S2FyA==
X-Received: by 2002:a17:90a:d496:: with SMTP id s22mr20720pju.167.1599087748649;
        Wed, 02 Sep 2020 16:02:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x12sm410277pjq.43.2020.09.02.16.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 16:02:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH v2 09/10] clk: qcom: dispcc: Update DP clk ops for phy design
Date:   Wed,  2 Sep 2020 16:02:14 -0700
Message-Id: <20200902230215.3452712-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200902230215.3452712-1-swboyd@chromium.org>
References: <20200902230215.3452712-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_rcg2_dp_determine_rate() function is used for the DP pixel clk.
This function should return the rate that can be achieved by the pixel
clk in 'struct clk_rate_request::rate' and match the logic similar to
what is seen in clk_rcg2_dp_set_rate(). But that isn't the case. Instead
the code merely bubbles the rate request up to the parent of the pixel
clk and doesn't try to do a rational approximation of the rate that
would be achieved by picking some m/n value for the RCG.

Let's change this logic so that we can assume the parent clk frequency
is fixed (it is because it's the VCO of the DP PLL that is configured
based on the link rate) and so that we can calculate what the m/n value
will be and adjust the req->rate appropriately.

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Manu Gautam <mgautam@codeaurora.org>
Cc: Sandeep Maheswaram <sanm@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/clk-rcg2.c      | 19 +++++++++++++------
 drivers/clk/qcom/dispcc-sc7180.c |  3 ---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 357159fe85b5..59a5a0f261f3 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1182,14 +1182,21 @@ static int clk_rcg2_dp_set_rate_and_parent(struct clk_hw *hw,
 static int clk_rcg2_dp_determine_rate(struct clk_hw *hw,
 				struct clk_rate_request *req)
 {
-	struct clk_rate_request parent_req = *req;
-	int ret;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	unsigned long num, den;
+	u64 tmp;
 
-	ret = __clk_determine_rate(clk_hw_get_parent(hw), &parent_req);
-	if (ret)
-		return ret;
+	/* Parent rate is a fixed phy link rate */
+	rational_best_approximation(req->best_parent_rate, req->rate,
+			GENMASK(rcg->mnd_width - 1, 0),
+			GENMASK(rcg->mnd_width - 1, 0), &den, &num);
+
+	if (!num || !den)
+		return -EINVAL;
 
-	req->best_parent_rate = parent_req.rate;
+	tmp = req->best_parent_rate * num;
+	do_div(tmp, den);
+	req->rate = tmp;
 
 	return 0;
 }
diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
index 0a5d395bce93..f487515701e3 100644
--- a/drivers/clk/qcom/dispcc-sc7180.c
+++ b/drivers/clk/qcom/dispcc-sc7180.c
@@ -202,7 +202,6 @@ static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src = {
 		.name = "disp_cc_mdss_dp_crypto_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_byte2_ops,
 	},
 };
@@ -216,7 +215,6 @@ static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
 		.name = "disp_cc_mdss_dp_link_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_byte2_ops,
 	},
 };
@@ -230,7 +228,6 @@ static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src = {
 		.name = "disp_cc_mdss_dp_pixel_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_dp_ops,
 	},
 };
-- 
Sent by a computer, using git, on the internet

