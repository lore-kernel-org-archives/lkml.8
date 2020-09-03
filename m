Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961A9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A2E20684
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFMsoPly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgICUbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgICUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E3C061244;
        Thu,  3 Sep 2020 13:30:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so4138856wmm.2;
        Thu, 03 Sep 2020 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhOFrQ6qfsRT/zbm84NK9LroiUxtwPSR9pzAEC7Suno=;
        b=JFMsoPlyGtgBGt24O6d0Z2GCxKVLK+IYNemL5MJdARV1G8W1XXtfyOdWLa0GApOIn4
         CbbB6eEVcn6k9FawxC6TrC292zmqD021A1fz4iyUM4ZUqlccNtkLAnxn9HDCP8x8uQoG
         rbWgJSA8VYpnR74P4O6uHsWRnuKOmrNdffp1LIf+RVxfNm138dSYu0OfSBPgoUWwQIS0
         OYVRot6DoyQST1V4eijt6BQHY6tW4rhRhLmhAm1tZC154OYTIJ0voy7Fu55++YjW7ZFu
         B9MiGteEt/IldzUGwKeT3fLpzwOgnnyAJ952vLn1zPjKcM2q24YqD4QvexL2SevOtytE
         dOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhOFrQ6qfsRT/zbm84NK9LroiUxtwPSR9pzAEC7Suno=;
        b=GfNep2u9PMCNXCyl8wD7/K+WWAh61hFtij1BXmPLxgqiU1CK2/P01TySXy3Vq3oxTH
         BYIuDKL3mqA5yHIHQYx+dQmeRHXNwmfJ8CYsrNlMrcw85WGkc0oTQg/ydr+jqioSWv3t
         BjCe7gztpKvHCKboWbRUmZd27pYREMJvUsHBGROclDTLOOAq5vN5lpcRAdnM+tcZn7z7
         RrOguxlTmT2KMtbJGjFfyBTSWIPFYSzemyaoLulhG0BcVhKiiq49nRpvdP+vaGLAtl3Q
         hWGaG0uW0yR6H5KxVsZgD3YraZlXj88u9oGNuUsdASPNbvFTlD1GrXR0+CQw4zwrKeuP
         /uyg==
X-Gm-Message-State: AOAM532xCNn+XUcaOylBTTravLmRjXFMfQ3NPr91g7RutLJb2wSQkwOy
        gqNybKBW4xt5p85VahFUo9qwJBC0poxM4w==
X-Google-Smtp-Source: ABdhPJxFPdJWP5bs+Yfd6VN8HjhX9dy6LULxDIz3bk0NEQYa1SFSpokHHgBIJt0OuBT3VbISemQnkQ==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr4197688wmc.35.1599165044454;
        Thu, 03 Sep 2020 13:30:44 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:43 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 01/20] Revert "ASoC: sun4i-i2s: Fix the LRCK polarity"
Date:   Thu,  3 Sep 2020 22:30:15 +0200
Message-Id: <20200903203034.1057334-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit dd657eae8164f7e4bafe8b875031a7c6c50646a9.

There was a misinterpretation of the analysis using a scope.
After rechecking this using a logical analyzer the LRCK polarity is
fine.

Fixes: dd657eae8164 ("ASoC: sun4i-i2s: Fix the LRCK polarity")
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f23ff29e7c1d..fabff7bcccbc 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -603,29 +603,23 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	u32 mode, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
+	/* DAI clock polarity */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_IF:
 		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
+		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
 		/* Invert frame clock */
-		val = 0;
+		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		val = 0;
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.1

