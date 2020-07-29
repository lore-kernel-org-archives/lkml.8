Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021BFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17D4207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jCVXP2mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgG2PoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgG2PoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:44:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD79C0619D6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:44:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so3453003wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+stM08urg1MpZtIURBzurop2zYVssGxsR+vYUwG2fs=;
        b=jCVXP2mQ0g3I2lQs3Yc2Dt4So4ExRRYZ/pKduxeOF61Jkg4sAon5xCNAcwi6ZUC6ts
         vIL5+ecZp3TFcvMB1iutrKisLoiSP17Trjedha8GV9Y0wmrzzmCNnH4wSeV9fqLxbIJc
         blLoHCX5q8ytYhwvR+KQXQp2hQFlUl5PHzmw0nbt6Vb+Nf3oDaDbiWYKPzwWrzDyF6ry
         twbhjzdGIn9XCLiHw5l4cow4QDX/8Ms03uUVxuPL9sfW2vkak9WSZiYsvINls00SNouA
         hmLrVbLYfsyvLPLQKyFpRMizq7Eu3nVpDcZ9dv7DNNEmmhn+RMQEkFyJD8+5OV/so4MV
         cQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+stM08urg1MpZtIURBzurop2zYVssGxsR+vYUwG2fs=;
        b=MxD27AN0O32W0ho0m8TrJwVGZS6GpNk+vkCDP+Yhq6E4eKMw8vCKwdUFl0EKtXJhWQ
         C8sZ02XzpzeMvbFRm5d3KIJUdIL19M3YEu13UjsMlUroEZI5o7ddwxd+vpIUXL+27Rmm
         7t6mQc+2FTcshM+k0JU8TZFb4VCbzbTbCdrQTXmTM8JH3JmoA6diYfcE7y/2/FfEa9PA
         PIBzoAHJqeARSNukE39diQLPBxM/XAigL6NaRG2ONr/w9A5vG4UYRREm3+lLCpg3f8z9
         Sh2f9pMiC91OLfTfkuWRd4sqgs9QEd28Khgp5o37O3DrsUpPhfyn74J3gG4jLNvKr3i5
         lYwQ==
X-Gm-Message-State: AOAM531BDjfVdChNlNtrwMCCnny4YBqgRnB6/CEE+tAa+N2AFWI9SLWM
        tgwRsxxMfgr1q9nDk1MzF5U+LA==
X-Google-Smtp-Source: ABdhPJyGVavZA3HF6yfY3RkIlIer3uK/JkzW+9Dxi5rltIpks9NfFZDBbEcl/1zDdJ36dgWl9O0naA==
X-Received: by 2002:a1c:6007:: with SMTP id u7mr9608865wmb.32.1596037448515;
        Wed, 29 Jul 2020 08:44:08 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a134sm6526030wmd.17.2020.07.29.08.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:44:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, linux-clk@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: meson: axg-audio: separate axg and g12a regmap tables
Date:   Wed, 29 Jul 2020 17:43:58 +0200
Message-Id: <20200729154359.1983085-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729154359.1983085-1-jbrunet@baylibre.com>
References: <20200729154359.1983085-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more differences than what we initially thought.
Let's keeps things clear and separate the axg and g12a regmap tables of the
audio clock controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 135 ++++++++++++++++++++++++++++++++--
 1 file changed, 127 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 53715e36326c..9918cb375de3 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -1209,13 +1209,132 @@ static struct clk_hw_onecell_data sm1_audio_hw_onecell_data = {
 };
 
 
-/* Convenience table to populate regmap in .probe()
- * Note that this table is shared between both AXG and G12A,
- * with spdifout_b clocks being exclusive to G12A. Since those
- * clocks are not declared within the AXG onecell table, we do not
- * feel the need to have separate AXG/G12A regmap tables.
- */
+/* Convenience table to populate regmap in .probe(). */
 static struct clk_regmap *const axg_clk_regmaps[] = {
+	&ddr_arb,
+	&pdm,
+	&tdmin_a,
+	&tdmin_b,
+	&tdmin_c,
+	&tdmin_lb,
+	&tdmout_a,
+	&tdmout_b,
+	&tdmout_c,
+	&frddr_a,
+	&frddr_b,
+	&frddr_c,
+	&toddr_a,
+	&toddr_b,
+	&toddr_c,
+	&loopback,
+	&spdifin,
+	&spdifout,
+	&resample,
+	&power_detect,
+	&mst_a_mclk_sel,
+	&mst_b_mclk_sel,
+	&mst_c_mclk_sel,
+	&mst_d_mclk_sel,
+	&mst_e_mclk_sel,
+	&mst_f_mclk_sel,
+	&mst_a_mclk_div,
+	&mst_b_mclk_div,
+	&mst_c_mclk_div,
+	&mst_d_mclk_div,
+	&mst_e_mclk_div,
+	&mst_f_mclk_div,
+	&mst_a_mclk,
+	&mst_b_mclk,
+	&mst_c_mclk,
+	&mst_d_mclk,
+	&mst_e_mclk,
+	&mst_f_mclk,
+	&spdifout_clk_sel,
+	&spdifout_clk_div,
+	&spdifout_clk,
+	&spdifin_clk_sel,
+	&spdifin_clk_div,
+	&spdifin_clk,
+	&pdm_dclk_sel,
+	&pdm_dclk_div,
+	&pdm_dclk,
+	&pdm_sysclk_sel,
+	&pdm_sysclk_div,
+	&pdm_sysclk,
+	&mst_a_sclk_pre_en,
+	&mst_b_sclk_pre_en,
+	&mst_c_sclk_pre_en,
+	&mst_d_sclk_pre_en,
+	&mst_e_sclk_pre_en,
+	&mst_f_sclk_pre_en,
+	&mst_a_sclk_div,
+	&mst_b_sclk_div,
+	&mst_c_sclk_div,
+	&mst_d_sclk_div,
+	&mst_e_sclk_div,
+	&mst_f_sclk_div,
+	&mst_a_sclk_post_en,
+	&mst_b_sclk_post_en,
+	&mst_c_sclk_post_en,
+	&mst_d_sclk_post_en,
+	&mst_e_sclk_post_en,
+	&mst_f_sclk_post_en,
+	&mst_a_sclk,
+	&mst_b_sclk,
+	&mst_c_sclk,
+	&mst_d_sclk,
+	&mst_e_sclk,
+	&mst_f_sclk,
+	&mst_a_lrclk_div,
+	&mst_b_lrclk_div,
+	&mst_c_lrclk_div,
+	&mst_d_lrclk_div,
+	&mst_e_lrclk_div,
+	&mst_f_lrclk_div,
+	&mst_a_lrclk,
+	&mst_b_lrclk,
+	&mst_c_lrclk,
+	&mst_d_lrclk,
+	&mst_e_lrclk,
+	&mst_f_lrclk,
+	&tdmin_a_sclk_sel,
+	&tdmin_b_sclk_sel,
+	&tdmin_c_sclk_sel,
+	&tdmin_lb_sclk_sel,
+	&tdmout_a_sclk_sel,
+	&tdmout_b_sclk_sel,
+	&tdmout_c_sclk_sel,
+	&tdmin_a_sclk_pre_en,
+	&tdmin_b_sclk_pre_en,
+	&tdmin_c_sclk_pre_en,
+	&tdmin_lb_sclk_pre_en,
+	&tdmout_a_sclk_pre_en,
+	&tdmout_b_sclk_pre_en,
+	&tdmout_c_sclk_pre_en,
+	&tdmin_a_sclk_post_en,
+	&tdmin_b_sclk_post_en,
+	&tdmin_c_sclk_post_en,
+	&tdmin_lb_sclk_post_en,
+	&tdmout_a_sclk_post_en,
+	&tdmout_b_sclk_post_en,
+	&tdmout_c_sclk_post_en,
+	&tdmin_a_sclk,
+	&tdmin_b_sclk,
+	&tdmin_c_sclk,
+	&tdmin_lb_sclk,
+	&tdmout_a_sclk,
+	&tdmout_b_sclk,
+	&tdmout_c_sclk,
+	&tdmin_a_lrclk,
+	&tdmin_b_lrclk,
+	&tdmin_c_lrclk,
+	&tdmin_lb_lrclk,
+	&tdmout_a_lrclk,
+	&tdmout_b_lrclk,
+	&tdmout_c_lrclk,
+};
+
+static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&ddr_arb,
 	&pdm,
 	&tdmin_a,
@@ -1713,8 +1832,8 @@ static const struct audioclk_data axg_audioclk_data = {
 };
 
 static const struct audioclk_data g12a_audioclk_data = {
-	.regmap_clks = axg_clk_regmaps,
-	.regmap_clk_num = ARRAY_SIZE(axg_clk_regmaps),
+	.regmap_clks = g12a_clk_regmaps,
+	.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
 	.hw_onecell_data = &g12a_audio_hw_onecell_data,
 	.reset_offset = AUDIO_SW_RESET,
 	.reset_num = 26,
-- 
2.25.4

