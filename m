Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820EAC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7632082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TePUltcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgBCScp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:32:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37998 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgBCSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:32:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so8258786pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwHxgEKez+fOFQykbyJ2qqd0S0Aa+T2rnyaksz+8v/M=;
        b=TePUltcYjHGOlhvm0sss/m7Bi8+vuqTXeBmxqiuTXNO7vBo8DOMdKF8xaaGZ+Ak1/L
         e+xMsYn8+w1pPO2BsSHcBT9+8H8s1i0ZN+cXyfYYl3D4XMGvL9VvLivjnfdhUztJtqpN
         nAlwQ0RtFvqRjNWTF81qT183sNFpLO6Dx+2mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwHxgEKez+fOFQykbyJ2qqd0S0Aa+T2rnyaksz+8v/M=;
        b=n71eJSsOTu9wVP1verm+QKh9s1tlzajnwfHi1rnWWf6jn0DOa0UBgqOxz8G+RB0nc5
         b4aTTHPUeT7Dwi2xgb3KHZdi8TAMAdradHpTejAsC+3TRn5HZgfS2PQ+mr9DiCPqF+Jq
         gkx/0pwn2OGnmPUgAu8MBMpIHodt+S8Ha13g96f28Icr3SlwGCeoIWwaxq8YY3308E3r
         S5qeUoRZhwP5qlSIp9TUL0sLxoe/OUmdIumP1YVG7Dg90Bqv6ieqV7GEDaCIbGnxq+lF
         PthoiH7aliAoYv/6Hg4wJDVOw2dpCZ61MViRd/zcyyZuBufWMYHQsdYfAK7EyV/LP4xQ
         FmRA==
X-Gm-Message-State: APjAAAUX9UtCOcxEuQfbjSZFiAeh5QIuCQzRewbLZEuMX6hNXHwTO1HR
        3xiOTcvl6ieYU6NLOOeD2Cj+OA==
X-Google-Smtp-Source: APXvYqz38nwGUpv83wdaxTCNi+AL895a1bGWZsc4tkumVdC6AUR9GLTk3X5Ee2dUKrhJgDGub2DzRQ==
X-Received: by 2002:a63:1f5b:: with SMTP id q27mr12770437pgm.434.1580754747633;
        Mon, 03 Feb 2020 10:32:27 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f9sm21009137pfd.141.2020.02.03.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:32:27 -0800 (PST)
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
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/15] clk: qcom: Get rid of the test clock for videocc-sc7180
Date:   Mon,  3 Feb 2020 10:31:45 -0800
Message-Id: <20200203103049.v4.12.Ifd19a2701a102ec9f04e61a09345198383a9e937@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203183149.73842-1-dianders@chromium.org>
References: <20200203183149.73842-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test clock isn't in the bindings and apparently it's not used by
anyone upstream.  Remove it.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- Patch ("clk: qcom: Get rid of the test...videocc-sc7180") new for v3.

Changes in v2: None

 drivers/clk/qcom/videocc-sc7180.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
index 76add30024aa..653fc4e6bb6f 100644
--- a/drivers/clk/qcom/videocc-sc7180.c
+++ b/drivers/clk/qcom/videocc-sc7180.c
@@ -50,13 +50,11 @@ static struct clk_alpha_pll video_pll0 = {
 static const struct parent_map video_cc_parent_map_1[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_VIDEO_PLL0_OUT_MAIN, 1 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data video_cc_parent_data_1[] = {
 	{ .fw_name = "bi_tcxo" },
 	{ .hw = &video_pll0.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
 };
 
 static const struct freq_tbl ftbl_video_cc_venus_clk_src[] = {
@@ -78,7 +76,7 @@ static struct clk_rcg2 video_cc_venus_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "video_cc_venus_clk_src",
 		.parent_data = video_cc_parent_data_1,
-		.num_parents = 3,
+		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_shared_ops,
 	},
-- 
2.25.0.341.g760bfbb309-goog

