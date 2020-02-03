Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B68C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C666820CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DvCPSi4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgBCSdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:33:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43784 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgBCScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:32:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so6184667plq.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXYsSn/bpLUzHQDBpuUsY8VACz18k1Ng4zjCUcwxPLU=;
        b=DvCPSi4kRl7tU7zUHQYYkP2oswPPToVk5xFfvz7f2QZP7q16XqP64C1ZgbTSwLYtJC
         4fJQ4r7/L0E91nja7MKi4SThX74OjlvF9y/Jpt+naf3yD1GWrwB5Zdy+6cjE8b9hRYo1
         yLjstt5SXIEqmBMG8L6Ct9aQUsnHNlcCbDGhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXYsSn/bpLUzHQDBpuUsY8VACz18k1Ng4zjCUcwxPLU=;
        b=i+4FLUG3z/2fch/sfLHUYBwmWNcRm1rPi2xTeO2/WwJ8x76yMw6+RRcx83tXOXSI/U
         /9cMPH4JIkv6Vjb1jkYYGz5qXZFPKBQYMnpRVt1ZflO/fVeHJxl5ATpd9ug/PIOGTqiM
         ZNGauXPBDtp6rhsZJq0PuXGfg6Jejb7dUBsrIk1xzTuaIn9Q527hQjyafKgYK8tOuMgJ
         OpHGjyz4TRQHMKCciYzmsnsLmOqNtqyKPtlNeac9aRplzYXcDGZmn6GV9v2VMPt6uFTk
         g3NWAihokH/SyTseEqTeTCBCR2wA9M9sFb2aPebwP5W8ZONbK+cB04GK1LWJZJIoa+ih
         JfBg==
X-Gm-Message-State: APjAAAWzmhWAnLfaEvZPJvKxrExgppXj6ssXT9hlbNEqwp9NnyqeQYu9
        6lPt5QRoHqrZFt7XpmzbNCAXFw==
X-Google-Smtp-Source: APXvYqy7AcJrWdMib9/JT8Iy6xmiUWomyiuo8ggeOh8yMGAzAJB004x763BL5QJdNTKafdw+YuCQ6g==
X-Received: by 2002:a17:902:aa81:: with SMTP id d1mr26001471plr.16.1580754740036;
        Mon, 03 Feb 2020 10:32:20 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f9sm21009137pfd.141.2020.02.03.10.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:32:19 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/15] clk: qcom: Use ARRAY_SIZE in dispcc-sc7180 for parent clocks
Date:   Mon,  3 Feb 2020 10:31:39 -0800
Message-Id: <20200203103049.v4.6.If590c468722d2985cea63adf60c0d2b3098f37d9@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203183149.73842-1-dianders@chromium.org>
References: <20200203183149.73842-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's nicer to use ARRAY_SIZE instead of hardcoding.  Had we always
been doing this it would have prevented a previous bug.  See commit
74c31ff9c84a ("clk: qcom: gpu_cc_gmu_clk_src has 5 parents, not 6").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- Patch ("clk: qcom: Use ARRAY_SIZE in dispcc-sc7180...") split out for v3.

Changes in v2: None

 drivers/clk/qcom/dispcc-sc7180.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
index 397f5d9dafc8..dd7af41e47eb 100644
--- a/drivers/clk/qcom/dispcc-sc7180.c
+++ b/drivers/clk/qcom/dispcc-sc7180.c
@@ -154,7 +154,7 @@ static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_ahb_clk_src",
 		.parent_data = disp_cc_parent_data_4,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -168,7 +168,7 @@ static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_byte0_clk_src",
 		.parent_data = disp_cc_parent_data_2,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_byte2_ops,
 	},
@@ -188,7 +188,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_dp_aux_clk_src",
 		.parent_data = disp_cc_parent_data_0,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -201,7 +201,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_dp_crypto_clk_src",
 		.parent_data = disp_cc_parent_data_1,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_byte2_ops,
 	},
@@ -215,7 +215,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_dp_link_clk_src",
 		.parent_data = disp_cc_parent_data_1,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_byte2_ops,
 	},
@@ -229,7 +229,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_dp_pixel_clk_src",
 		.parent_data = disp_cc_parent_data_1,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_dp_ops,
 	},
@@ -244,7 +244,7 @@ static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_esc0_clk_src",
 		.parent_data = disp_cc_parent_data_2,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -267,7 +267,7 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_mdp_clk_src",
 		.parent_data = disp_cc_parent_data_3,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.ops = &clk_rcg2_shared_ops,
 	},
 };
@@ -280,7 +280,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_pclk0_clk_src",
 		.parent_data = disp_cc_parent_data_5,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_pixel_ops,
 	},
@@ -295,7 +295,7 @@ static struct clk_rcg2 disp_cc_mdss_rot_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_rot_clk_src",
 		.parent_data = disp_cc_parent_data_3,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.ops = &clk_rcg2_shared_ops,
 	},
 };
@@ -309,7 +309,7 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_vsync_clk_src",
 		.parent_data = disp_cc_parent_data_0,
-		.num_parents = 1,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
 		.ops = &clk_rcg2_shared_ops,
 	},
 };
-- 
2.25.0.341.g760bfbb309-goog

