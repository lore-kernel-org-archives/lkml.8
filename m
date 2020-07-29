Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D26C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59587207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WWZhs4ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgG2PpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgG2PpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:45:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d190so3140238wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4N4tDfzOiQqATdi2Zol4rwsnSDbJ8cgT+uEdMs1E22o=;
        b=WWZhs4MLKcUYxBMvUVTtWl0OAPx5neW6I3yi2mxSSN5FUCj+m2aiudakBjm5Zyn49G
         qNoZzgivw+l/W6yq8djsxGTazCCcggn8Pdw1nVPO/SxKY53BIYC8rJ37jQ6oVHIFn9bj
         TDE/IMadGdIEd6FW0+Uwn11oO/Wt7jiYKgY1uaAnpifIqkVnE+paKfydATCD8pnB1t8H
         RMPrl8/PzhHRDQVdgqTHRLIwQ0auujdmd+dX2focKFZz9yigqXmKMHqD8pW9euBmr4h9
         l2TOcSdKUsvE2xOj9nfWpk0IyMTwrJVcgBAyrVcS3yeK80UKf8oHd2oQg9BgVPf5Gep3
         qT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4N4tDfzOiQqATdi2Zol4rwsnSDbJ8cgT+uEdMs1E22o=;
        b=PeJ9yy3mB2oehdv7vhXAk5lGm0+RdJuiq3v2Xk7lwbRL6gxuBX+/Jv9imu6HSDTUKi
         7BfrGJateA6v2mEtyneUgw7dXvGSYEC1GG586n3IHhgFTU6MDWxUdlk6GHgroC6KInRz
         ivuXMD5C9yVWhBzamo9Dgny9z6S6nrf71YU9Bbic5MpQUvDuOoGoA6fG7X49qAXAx3yi
         ruh0qYVf7/Kn32rUnwHf21+uphSD3h3NNN7FkYeGbVUtEmJXY6vzbKPdhJpBa3H6ZM0I
         nmMr3VVOjyGlGd1EAVkm4/SObcqNGOhYB83JO2IJesMOLnPtS2T2UwlSiUPLHWpk3Smk
         rBKA==
X-Gm-Message-State: AOAM530zzlh2Mb9KKRn5oKgYL5WVNaUyT+n9x3Xp9vzloBFamyEFIDvE
        HupoFggZd5nEPniO2OFZeq1jD3ZBXOj1bg==
X-Google-Smtp-Source: ABdhPJxDdW0mOc4UD1kq9GZvvkv4pRetXTg0qhqbn32pV9vNmdYnY++BBuAjJwZ83bppWNUoVHSA5g==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr6152075wmj.92.1596037516141;
        Wed, 29 Jul 2020 08:45:16 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k10sm5950967wrm.74.2020.07.29.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:45:15 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 3/4] ASoC: meson: axg-tdm-formatters: fix sclk inversion
Date:   Wed, 29 Jul 2020 17:44:55 +0200
Message-Id: <20200729154456.1983396-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729154456.1983396-1-jbrunet@baylibre.com>
References: <20200729154456.1983396-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After carefully checking, it appears that both tdmout and tdmin require the
rising edge of the sclk they get to be synchronized with the frame sync
event (which should be a rising edge of lrclk).

TDMIN was improperly set before this patch. Remove the sclk_invert quirk
which is no longer needed and fix the sclk phase.

Fixes: 1a11d88f499c ("ASoC: meson: add tdm formatter base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-formatter.c | 11 ++++++-----
 sound/soc/meson/axg-tdm-formatter.h |  1 -
 sound/soc/meson/axg-tdmin.c         |  2 --
 sound/soc/meson/axg-tdmout.c        |  3 ---
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 358c8c0d861c..f7e8e9da68a0 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
 static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
 {
 	struct axg_tdm_stream *ts = formatter->stream;
-	bool invert = formatter->drv->quirks->invert_sclk;
+	bool invert;
 	int ret;
 
 	/* Do nothing if the formatter is already enabled */
@@ -96,11 +96,12 @@ static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
 		return ret;
 
 	/*
-	 * If sclk is inverted, invert it back and provide the inversion
-	 * required by the formatter
+	 * If sclk is inverted, it means the bit should latched on the
+	 * rising edge which is what our HW expects. If not, we need to
+	 * invert it before the formatter.
 	 */
-	invert ^= axg_tdm_sclk_invert(ts->iface->fmt);
-	ret = clk_set_phase(formatter->sclk, invert ? 180 : 0);
+	invert = axg_tdm_sclk_invert(ts->iface->fmt);
+	ret = clk_set_phase(formatter->sclk, invert ? 0 : 180);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/meson/axg-tdm-formatter.h b/sound/soc/meson/axg-tdm-formatter.h
index 9ef98e955cb2..a1f0dcc0ff13 100644
--- a/sound/soc/meson/axg-tdm-formatter.h
+++ b/sound/soc/meson/axg-tdm-formatter.h
@@ -16,7 +16,6 @@ struct snd_kcontrol;
 
 struct axg_tdm_formatter_hw {
 	unsigned int skew_offset;
-	bool invert_sclk;
 };
 
 struct axg_tdm_formatter_ops {
diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index 3d002b4eb939..88ed95ae886b 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -228,7 +228,6 @@ static const struct axg_tdm_formatter_driver axg_tdmin_drv = {
 	.regmap_cfg	= &axg_tdmin_regmap_cfg,
 	.ops		= &axg_tdmin_ops,
 	.quirks		= &(const struct axg_tdm_formatter_hw) {
-		.invert_sclk	= false,
 		.skew_offset	= 2,
 	},
 };
@@ -238,7 +237,6 @@ static const struct axg_tdm_formatter_driver g12a_tdmin_drv = {
 	.regmap_cfg	= &axg_tdmin_regmap_cfg,
 	.ops		= &axg_tdmin_ops,
 	.quirks		= &(const struct axg_tdm_formatter_hw) {
-		.invert_sclk	= false,
 		.skew_offset	= 3,
 	},
 };
diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
index 418ec314b37d..3ceabddae629 100644
--- a/sound/soc/meson/axg-tdmout.c
+++ b/sound/soc/meson/axg-tdmout.c
@@ -238,7 +238,6 @@ static const struct axg_tdm_formatter_driver axg_tdmout_drv = {
 	.regmap_cfg	= &axg_tdmout_regmap_cfg,
 	.ops		= &axg_tdmout_ops,
 	.quirks		= &(const struct axg_tdm_formatter_hw) {
-		.invert_sclk = true,
 		.skew_offset = 1,
 	},
 };
@@ -248,7 +247,6 @@ static const struct axg_tdm_formatter_driver g12a_tdmout_drv = {
 	.regmap_cfg	= &axg_tdmout_regmap_cfg,
 	.ops		= &axg_tdmout_ops,
 	.quirks		= &(const struct axg_tdm_formatter_hw) {
-		.invert_sclk = true,
 		.skew_offset = 2,
 	},
 };
@@ -309,7 +307,6 @@ static const struct axg_tdm_formatter_driver sm1_tdmout_drv = {
 	.regmap_cfg	= &axg_tdmout_regmap_cfg,
 	.ops		= &axg_tdmout_ops,
 	.quirks		= &(const struct axg_tdm_formatter_hw) {
-		.invert_sclk = true,
 		.skew_offset = 2,
 	},
 };
-- 
2.25.4

