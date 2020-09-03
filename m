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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B921C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF502083B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJmA4ic0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgICUlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgICUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996BC061245;
        Thu,  3 Sep 2020 13:30:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so4573347wrp.8;
        Thu, 03 Sep 2020 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIXpju43i4Jg9vuM4D1hPqA0p/QuMqwDr+5ieWDqPBc=;
        b=XJmA4ic05bqYJiH8XSglfibsrHedMOqI1oL0PnBy6JWSdbwlKY6+fGyewEpFm4tXv7
         1IJbYdC7lvHOVtieItrlbvHdlK1Vj+eRf5ckuoBUz6kzj/Rbb7XW2n9aS1zSDxYeEIaQ
         ZnpjE1tIxbFH857dJ5yAgm3pFER6eFlj9Nm9HJEJWXZqwmLgVpd2G55GjOkJVjNA3zK1
         6ygeKuapH8UtZB3b56tSP3dqvVQRYMDvBCgatEgTyQ92hOd1nozv4jP2JkTc54InM0ZZ
         79ymq4RvLti38isRhWcnN+eB+0CKNV3qm0s+3N4mAl5xRNVdjacQUU2KWc3NhPvZJgeO
         aLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIXpju43i4Jg9vuM4D1hPqA0p/QuMqwDr+5ieWDqPBc=;
        b=MJN0h7wZ0wG7RdhzUV0mqlLTviQLXKX0JIxAP5/riZoZn5xN6QnSq8cj99vc7SMYKt
         gX0zBeCBIFX42D9/Yv3atl6y3+w7kSdAmcuvbSVUZ6jTsHXtvj3qSiOiLBiYqKle1ed2
         xrhGtUONLp66oZQehOpaPnuQVqcQ5pbAAQ2BulOLOdVu2p6GKClEdCIqnf82+rZtKoxY
         EyIS0GPiLKozfka1o5TgUGaL/LrdvtymYfThMKZtb2+lAKvywiu3ZAqD6JKGf+NdzFcK
         UOba33uouU1Ewd9GAMJTpRADTUjPI9Jsex8ig4A8CZmiKXGDSjY16fiw0esOKrV+GyOD
         CH4g==
X-Gm-Message-State: AOAM532jnLgNAoVqOZdZBxI+kVp1qa2jfZgNegPU8ytKjAnJSu/X5Trt
        LUiHJnYd8UbUsYbsFadYbms=
X-Google-Smtp-Source: ABdhPJw0tBMq5EwMZ7iM7eO1IpZYKZhZLLG9OvLxuj7MQlpv73SxOh/smd45fJuTmVp82znJ2UIz/w==
X-Received: by 2002:adf:f846:: with SMTP id d6mr4574464wrq.56.1599165050638;
        Thu, 03 Sep 2020 13:30:50 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:50 -0700 (PDT)
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
Subject: [PATCH v2 06/20] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Thu,  3 Sep 2020 22:30:20 +0200
Message-Id: <20200903203034.1057334-7-peron.clem@gmail.com>
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

From: Marcus Cooper <codekipper@gmail.com>

Extend the functionality of the driver to include support of 20 and
24 bits per sample.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 13e64180e917..df73cd5751c0 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -585,6 +585,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1054,6 +1057,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1061,14 +1068,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
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

