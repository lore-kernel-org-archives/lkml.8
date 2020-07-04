Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B81C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994A32084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAcb77ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGDLjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgGDLjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4BEC061794;
        Sat,  4 Jul 2020 04:39:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so35385228wrw.12;
        Sat, 04 Jul 2020 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESvvN/D0Hfp01gqc7DB6yCCc1XPduthb29WoQdXR4XI=;
        b=HAcb77ZJONKREpW52PASaGho76Okwx4LA+qV206R+/N0/goTrfOGVoXxy5HSUwzFul
         L5N3WxT/n1rrBMykKCO+fYppCvkZYb7ojRh7oPiH9Oeokiikv9RvF8VP52hvHP3AboTj
         mI/wpw907Awdp6ZZQjIH2MtsrB46+H4w0F6OgjIlGMDH/4JbiTgVmgNkBXqT9CTnXYD5
         w5Q2lgxa5v9Va179bQ1LiOq5cqALEfB3gwn0Np7N4mSpUH8FHusQFAqmFVTDQz33a7jO
         v5awH1PzzKiSuHHJr0mbKd3TNlyTAyPs+5n1jBrLUdL8U/7iYgdkTqXOOEED02n8qN3J
         3ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESvvN/D0Hfp01gqc7DB6yCCc1XPduthb29WoQdXR4XI=;
        b=b/nbWaWoogpQyqdOyeEODKYc65s27RHTkHTi7IVGkhsr0wT2Br1UmXca3J5D5i5Pl1
         ZpDgISgpxVbyA5ahW9SoT8wZJ5AZdQzbX4oqMNx7yl1M4H/rf+luLMJb1C4k40ym/hdL
         PcUc2X9EbOGCsogwEy0rgzGhihHKQctQar5qYfyFgWtmMJ55RdnCFzY2HMaqSBXKkjzP
         J9NPu2pS8NTfVmSA508Ht6Y2EBr+ZXkTzSWqPPEdkQ3zxR9l7/SaUP+vpX3O++8ue3QS
         l9alXzdsX/wMhmUPwZPbyKBM8n9GdGQWUEKmEmFmQGhEeVyJSnyW6gNgVtcBDg9Rz9Ow
         bAlA==
X-Gm-Message-State: AOAM533dtFfFRJwFbD4EXN5ZEjFH81q6LuxTiUwIw9nigUyedHwfDr4H
        2MwYMWJZm76KnO/PRw50gymRu2HP8sFBBg==
X-Google-Smtp-Source: ABdhPJxIUWrIjz3LSlsiaQlsL6gMInsAYaGWfox28gRQLMNg4u+OoJTeTKOrr6S/rQGsaI5bMhBS1w==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr39790634wrw.405.1593862751825;
        Sat, 04 Jul 2020 04:39:11 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:11 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 05/16] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Sat,  4 Jul 2020 13:38:51 +0200
Message-Id: <20200704113902.336911-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Extend the functionality of the driver to include support of 20 and
24 bits per sample.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f78167e152ce..bc7f9343bc7a 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -577,6 +577,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1063,6 +1066,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1070,14 +1077,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
-- 
2.25.1

