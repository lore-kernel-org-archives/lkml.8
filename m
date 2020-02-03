Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC24C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B0E2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CvGiqH0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgBCSdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:33:07 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54154 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgBCScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:32:20 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so126615pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH2VHzIYCpT+rZpNMMgV4M3UjpaUwOy/kLPvqGqahvE=;
        b=CvGiqH0drGyvUEVTEBzFooiDMIUNa93Ws8upu6f0HgyTgAMLnaz8ehySsJjGJywtHu
         HPBIZCQWNrKDyXjH7qlolZhdQN9SNYQnLJK9oOX01ZYXvH5djzUuI6Trn3Gp/P7XFgcQ
         /IqdSWoNFGjTv7uyOoZZKgVKKuyfVG01G5BPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH2VHzIYCpT+rZpNMMgV4M3UjpaUwOy/kLPvqGqahvE=;
        b=DbK+L/4FvAxrT04AMtuT08rOgEFxRyUusUKJ9eJt8If9BiSuvVUAZ/sj8eRFlRT3gM
         FSg5DChFjV1WDrRsSrgt+z0x/fVhJJUOZ0uYxGUsacg7IT/jmtwWvbSr8V28awvCQuMa
         8j/3qLA5SuVkHiQEjBxAtYXSKvvgWDRJiX3WcWgXX4TExWQJ0ym3q/Wvw2x9IN1eHHsP
         Vh7/zYtfhxNWG18yA/ValgFp7WgCWOExJJvVl8mQCaI+u1lj8VzkA7N6c3yKnogiYmE/
         T4ivpQ+9L8eVuYSiQejbc7pKalqDx8gvtzIRQnnyykgYQdMlPM96b606PdaDJG2V8VtM
         GyLg==
X-Gm-Message-State: APjAAAVaEDPAcfe9v4q9D5mQmsE1e2iDyhX3Jv3O4F5BaMTLLFwawH/Q
        emKnkmFK+uYfBbf3AzRulVAIiQ==
X-Google-Smtp-Source: APXvYqyPXpKehvy2AjeRkBSQUjKH2EOgPXz+MelenVCUi3J2jDRNXHSfdFBcwNkledlRgR8cKWaK1A==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr22743656pll.120.1580754737825;
        Mon, 03 Feb 2020 10:32:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f9sm21009137pfd.141.2020.02.03.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:32:17 -0800 (PST)
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
Subject: [PATCH v4 04/15] clk: qcom: Get rid of fallback global names for dispcc-sc7180
Date:   Mon,  3 Feb 2020 10:31:37 -0800
Message-Id: <20200203103049.v4.4.Ia3706a5d5add72e88dbff60fd13ec06bf7a2fd48@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203183149.73842-1-dianders@chromium.org>
References: <20200203183149.73842-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the new world input clocks should be matched by ".fw_name".  sc7180
is new enough that no backward compatibility use of global names
should be needed.  Remove it.

With a proper device tree and downstream display patches I have
verified booting a sc7180 up and seeing the display after this patch.

Fixes: dd3d06622138 ("clk: qcom: Add display clock controller driver for SC7180")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- Patch ("clk: qcom: Get rid of fallback...dispcc-sc7180") split out for v3.
- Unlike in v2, use internal name instead of purist name.

Changes in v2: None

 drivers/clk/qcom/dispcc-sc7180.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
index 30c1e25d3edb..a820e1558677 100644
--- a/drivers/clk/qcom/dispcc-sc7180.c
+++ b/drivers/clk/qcom/dispcc-sc7180.c
@@ -81,7 +81,7 @@ static const struct parent_map disp_cc_parent_map_0[] = {
 
 static const struct clk_parent_data disp_cc_parent_data_0[] = {
 	{ .fw_name = "bi_tcxo" },
-	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
+	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map disp_cc_parent_map_1[] = {
@@ -93,10 +93,9 @@ static const struct parent_map disp_cc_parent_map_1[] = {
 
 static const struct clk_parent_data disp_cc_parent_data_1[] = {
 	{ .fw_name = "bi_tcxo" },
-	{ .fw_name = "dp_phy_pll_link_clk", .name = "dp_phy_pll_link_clk" },
-	{ .fw_name = "dp_phy_pll_vco_div_clk",
-				.name = "dp_phy_pll_vco_div_clk"},
-	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
+	{ .fw_name = "dp_phy_pll_link_clk" },
+	{ .fw_name = "dp_phy_pll_vco_div_clk" },
+	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map disp_cc_parent_map_2[] = {
@@ -107,9 +106,8 @@ static const struct parent_map disp_cc_parent_map_2[] = {
 
 static const struct clk_parent_data disp_cc_parent_data_2[] = {
 	{ .fw_name = "bi_tcxo" },
-	{ .fw_name = "dsi0_phy_pll_out_byteclk",
-				.name = "dsi0_phy_pll_out_byteclk" },
-	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
+	{ .fw_name = "dsi0_phy_pll_out_byteclk" },
+	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map disp_cc_parent_map_3[] = {
@@ -125,7 +123,7 @@ static const struct clk_parent_data disp_cc_parent_data_3[] = {
 	{ .hw = &disp_cc_pll0.clkr.hw },
 	{ .fw_name = "gcc_disp_gpll0_clk_src" },
 	{ .hw = &disp_cc_pll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
+	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map disp_cc_parent_map_4[] = {
@@ -137,7 +135,7 @@ static const struct parent_map disp_cc_parent_map_4[] = {
 static const struct clk_parent_data disp_cc_parent_data_4[] = {
 	{ .fw_name = "bi_tcxo" },
 	{ .fw_name = "gcc_disp_gpll0_clk_src" },
-	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
+	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map disp_cc_parent_map_5[] = {
@@ -148,9 +146,8 @@ static const struct parent_map disp_cc_parent_map_5[] = {
 
 static const struct clk_parent_data disp_cc_parent_data_5[] = {
 	{ .fw_name = "bi_tcxo" },
-	{ .fw_name = "dsi0_phy_pll_out_dsiclk",
-				.name = "dsi0_phy_pll_out_dsiclk" },
-	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
+	{ .fw_name = "dsi0_phy_pll_out_dsiclk" },
+	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
-- 
2.25.0.341.g760bfbb309-goog

