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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3DDC38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C947B21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kREQt1nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDROjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDROje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:39:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7021C061A0F;
        Sat, 18 Apr 2020 07:39:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so910290wme.1;
        Sat, 18 Apr 2020 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L754Km9Q9zep0jG23tHJM73Id+x+F/JcQ+J50WzXMn4=;
        b=kREQt1nAybMu/RdjR4TjKfiubqKWPftllECuR+Dq868v3it3j6lBhGfD3ltmcz/tMe
         YVOoHhyYMc4HCAawB2HNkZ8UfFeJwTPmM1e4k6Y5e9YRtUrWNjsQKj8X65eV60mY0o7W
         uNHDRjNH7xhbH23YmtoivilQKTAn+kzKMZiYs10gWCL0Fet+ufmuM8GIbwoh6gkfAM59
         6yoS6GEkIhgKay0ZvVl31wHQXmi1rE3E4aCqI/JXYUvQadeoka0jqsxj9NhCYfF3WubF
         FKpX4yWgiuJdAey9SnQvH4dZzJG4/H7NGfTp7D0R0KWjOq5OH+ZalOI6s56kTfPEpgSf
         AIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L754Km9Q9zep0jG23tHJM73Id+x+F/JcQ+J50WzXMn4=;
        b=LGfsqiNQpAXnmyPxXS0UckFbaeJGTtNH3x+492/OVjka0rfs8bLYRawIHNNKhcnzkw
         0O88EIW/JwhSTh56WdFDQ3gCaIGkO59nAoavA+6iPk78tw8wncrTKKF4ZuTMM8uQ1BAL
         +3NmeQoLNvv2hRpjLylOBt1jCRzH8/xS+3WVcJw4D6FGKmMquzB2Ng1Zn02hYMYxnGSD
         a6zhLMVRbMyTrgm5JGGGg86PS5RNgLZIPYzbp2fm597LRlgbLi0C8Tc4behAycS751Yg
         XH9bz4ChH2sqQbOSua6Fel+xyeR5xCYL0VHX94RIdC9VAUvZ//WauorUP4vQmvTUO8CN
         +F2Q==
X-Gm-Message-State: AGi0Pubzl7TaiB73gEk7/F/YZIBVvLuPZMZ7eEYAe9zhMuQA5QxIRoqJ
        2IRLI8sHGsnq7WDKv/X0LGA=
X-Google-Smtp-Source: APiQypK70GbL5q6azow7ysviNaikQgOhrMij9w0SifS3JCnc2xPjm/sbDQKKkLmsCfYiJhtPXSVfgg==
X-Received: by 2002:a1c:964a:: with SMTP id y71mr6116731wmd.89.1587220772297;
        Sat, 18 Apr 2020 07:39:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id s9sm25375322wrg.27.2020.04.18.07.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 07:39:31 -0700 (PDT)
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
Subject: [PATCH 5/7] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Sat, 18 Apr 2020 16:39:21 +0200
Message-Id: <20200418143923.19608-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418143923.19608-1-peron.clem@gmail.com>
References: <20200418143923.19608-1-peron.clem@gmail.com>
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
index e5f00be8cdcf..a0090b5ced83 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -571,6 +571,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1057,6 +1060,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1064,14 +1071,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
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

