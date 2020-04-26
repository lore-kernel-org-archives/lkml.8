Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E296C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F02070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpGT0O9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDZKlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDZKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:41:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06942C061A0C;
        Sun, 26 Apr 2020 03:41:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so13607364wma.0;
        Sun, 26 Apr 2020 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPmRG0eokqpdl/q2VMZgNzJBd9cVrpLdjOI8ETo+m6A=;
        b=EpGT0O9Iarn76rrEIWIz78idcptdCG/Ex0bRkE0WB14Sp3hBUGQsGfpbJz2soHss1S
         /6r+2EqiqnXv98wkZN7flIEf6HlTQfO/CVxJ5vf0kchFY3vZzzwrQEkH0sSjAve6amxg
         6jSNxGlqrfmsePNfMBCh9yRL1Xp3EDoqLnMWlGpgKwfaEtL3751QfsdxZ85KsSfbT8Pb
         ytTLHsDCB0wKayozdQp47VkK3ykTeaDMOm3oIfIop8R9rXanGyVX0uzPzuqJjzBYmisi
         6s2CEQc1KyudTuYsY657g0DiNqHh4xOupY0Cza2WgP7ao3Efj8CmIzRGBSBriWg5fihR
         bDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPmRG0eokqpdl/q2VMZgNzJBd9cVrpLdjOI8ETo+m6A=;
        b=fJMAB25Arb9SNEDuGKGUKoSRT/h2xvj+IPRQAkdYSckzY+iMTuqAngDYC3O2XPfY8H
         zaYnrPl2Tg/75quHUGIDbmUnjtKN0HaBYMQ9WoU6bVrHiXDmFXwK6LmZNJC19/rcB10I
         Hn5wRFxDE+Yu3eiVTAnBWnt7gyCWnQkYSgMJwhizaEXCb89GnuyndEyMQqcoh1vB/E6t
         17L5nIgLoeYg3T9ThnRLjIRAINopjFAAlzkNvs/PbPIuJuP7YnTMzgtBhnKhUzKHwAlH
         SMkxTEBkiNew/5w3SOQiM95kS4Rk/aaUXEdv57GHSE/n7cd2stCe69Yosh2pYUOWS6ut
         8QwQ==
X-Gm-Message-State: AGi0PuZ08uBnjdYoo8C8SD9l4u8KCLpxV/Hffd35f2gg1ixEF0Idf3Ln
        5nn6AQ48kUc/HP/CljAq58U=
X-Google-Smtp-Source: APiQypI6n/5+7cpoIEtCz+tkkyK76+2/yd5WP4fqwKKPC90tfsehNHzeXrlr753fWnjqoEVUFPBkCw==
X-Received: by 2002:a1c:24d4:: with SMTP id k203mr20537615wmk.49.1587897684680;
        Sun, 26 Apr 2020 03:41:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id y10sm10491793wma.5.2020.04.26.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 03:41:23 -0700 (PDT)
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
Subject: [PATCH v3 5/7] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Sun, 26 Apr 2020 12:41:13 +0200
Message-Id: <20200426104115.22630-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426104115.22630-1-peron.clem@gmail.com>
References: <20200426104115.22630-1-peron.clem@gmail.com>
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
index 8ea08b49e7fe..277bf566c154 100644
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

