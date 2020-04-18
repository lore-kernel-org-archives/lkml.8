Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36625C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A521D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBpMCKqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgDRWpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 18:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgDRWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:44:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989BC061A0C;
        Sat, 18 Apr 2020 15:44:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so7376103wrg.11;
        Sat, 18 Apr 2020 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxlFylBEMHP1jAoGZfSxBsIHY2H4BZ1sTMv7tdFsx0k=;
        b=mBpMCKqHG2SfOXcnCap8iR0f/B7HGFhKZdMy5ig7HK/OlFABYDm0hIll3vV+Fs3/E2
         MemLzcDWcEG1eZMGEt11QJROvMFeBiyeNFxbsdzZFsz30iRkOKq0KNsC499z52Y3PnIb
         rgUcOHM5l+Klk14ppPMaXuELw7kaIsqP5bFwyhXI8JiWWSzYx7mBW7XeuKjtZv3mcw8+
         BMy3XFU/sneRsFANUoXTvZdJ3YS99DW3zLWFR4nLpdboc51AHWkDqIchI+7NfrUzPUvQ
         GQZIK46c81MLKZ1cEHupP2QrODrt6n98Ko2z2YpzgmRUaiTYbsPSD79+KEkgy7cxRn44
         mOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxlFylBEMHP1jAoGZfSxBsIHY2H4BZ1sTMv7tdFsx0k=;
        b=Kv9JAYb8y/coOCTQZdx9CxBN0c/uMPU1qPLlnvbGRyo4yTQR7p26US/q95tWxHLxUJ
         euFPSsTjgmsKNtGljJuChNGZFMxlcjYkYlQ9LZ8wrEjRBypFf86OXTcebAnJ+yQXPjhW
         o/kx14jV7zu2ITS8weHe7tm47PE1qfmW583fitnZyCT4StJBbdmPVHDrUj06AsjJSt+L
         C+wTwySjwCugcBrUhlq6k70KaqztyWxMHhB6VsuyRYgJ9KIYbvoe5Xleq8z80mn3p61Z
         ZYWbHwHryJGgW9k3IquTD2zpuc9zk6rHkfnTQBQrELqMCS7Ex7GrqQuv7oKQVIbIq3fx
         zJiw==
X-Gm-Message-State: AGi0Pua463XcFlCdnftcspdjO8LlSUmGQq/kMWAgBWOlNBYGY0ap9cMS
        2WtrcFT/YMW2CZOhfkIQxdc=
X-Google-Smtp-Source: APiQypKTnGAMc2x527csx6OG/t51sbyg6UU1kp5+g0xKPogZNyMX2T0dDmdRAiavu+QJY/l+rzDfcQ==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr10700285wrp.130.1587249885925;
        Sat, 18 Apr 2020 15:44:45 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id t16sm13371559wmi.27.2020.04.18.15.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:44:45 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 5/7] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Sun, 19 Apr 2020 00:44:33 +0200
Message-Id: <20200418224435.23672-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418224435.23672-1-peron.clem@gmail.com>
References: <20200418224435.23672-1-peron.clem@gmail.com>
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
index 618bbc5156f1..9778af37fbca 100644
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
2.20.1

