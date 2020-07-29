Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F54DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559082083E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n+OxTPRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgG2PsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2PsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:48:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:48:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so22099634wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36JMClzoi7h93LvxaQw3joeoIat/KioNOebe1PCxRfY=;
        b=n+OxTPRilig3haxEVJ5AhEQGmEPmRUF1YiywGsBdl5Z+XrM+gmIBqBlJw6szHy+r2A
         wuuM3o0C5jxjVER9hXK/E9j+AWnICQXWRAVe3M0VfvHE45ZgFE8ixPDfuLGsZgmaQziM
         Sqir7xV7BPs1bG13tLiBw1wwQOG8oGgoP7IejuwPWVa2zKp7+qgGxcYFzmDHye5Obg/K
         Bgsq6xYOiRMDuPU5bBPYXtaUpByB0ilY0FtTffIUubB7vuRRwNe5jFtEwjt8691LkdEz
         bfkADdUcJyZ24AizWb9313N2o3wNGuuLzOnY4T2WdPx3Dd23zfy4uxlH7EvBNYvL/lqB
         znTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36JMClzoi7h93LvxaQw3joeoIat/KioNOebe1PCxRfY=;
        b=hfuNS3f8oG6Bs+rVLu+D9L7iJdbR1JHU3v+8oRtEGonsx2+jKi2RPmR8jD39l5SmcP
         fvNR0SY5pjA+YA4ZV09/5oO7ZTuXwGkGlyPJ/i8dlT+I1r27Zgl9sl5w2m8jp9WPVMLl
         2+GEPNV0Ks9c1iEbFE1wXp1ZrZvyTlK97kGB2RJFxXB+dmco7IvMcTTfYQ5YoKc8WzPl
         L6lxZ/Kn04eV7AEVbc04gXF6sn+eX3XYpk3nJkChOAr+we8Dp69f2Ie2V/0JABYYkrqR
         si55h82SBQogMWI12LPhuKSIGXAOEn4/0YD3414gYby7NL+RM6JJ5M9vbG7BenZjxidV
         MgmQ==
X-Gm-Message-State: AOAM5327zydfVSbFENVGrEYEdl9Ng9OlqJSPYQf4e8whtTlcd1XObRkc
        dxOjvCBjrdJnFZpWBBYV0Fz9VOAakcpLrw==
X-Google-Smtp-Source: ABdhPJyrcNry8P8JgzRYvpG5FsopA4iFS5SUa/WXhOO/PIw8l2gzCtCcunQ+sUCAiMde/GxaIvpDdg==
X-Received: by 2002:a5d:5486:: with SMTP id h6mr28823589wrv.136.1596037684667;
        Wed, 29 Jul 2020 08:48:04 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t2sm6224808wmb.28.2020.07.29.08.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:48:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>, zhangn1985@outlook.com,
        Stephan Gerhold <stephan@gerhold.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: core: restore dpcm flags semantics
Date:   Wed, 29 Jul 2020 17:46:39 +0200
Message-Id: <20200729154639.1983854-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
changed dpcm_playback and dpcm_capture semantic by throwing an error if
these flags are not aligned with DAIs capabilities on the link.

The former semantic did not force the flags and DAI caps to be aligned.
The flag previously allowed card drivers to disable a stream direction on
a link (whether or not such feature is deemed useful).

With change ('ASoC: core: use less strict tests for dailink capabilities')
an error is thrown if the flags and and the DAI caps are not aligned. Those
parameters were not meant to aligned initially. No technical reason was
given about why cards should now be considered "broken" in such condition
is not met, or why it should be considered to be an improvement to enforce
that.

Forcing the flags to be aligned with DAI caps just make the information
the flag carry redundant with DAI caps, breaking a few cards along the way.

This change drops the added error conditions and restore the initial flag
semantics.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi Mark,

 Because b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
 introduced more than one problem, the change
 "ASoC: core: use less strict tests for dailink capabilities" [0] is still
 necessary but the change of semantic remains a problem with it.

 This patch applies on top of it.

 sound/soc/soc-pcm.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 00ac1cbf6f88..2e205b738eae 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2749,13 +2749,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 					break;
 				}
 			}
-
-			if (!playback) {
-				dev_err(rtd->card->dev,
-					"No CPU DAIs support playback for stream %s\n",
-					rtd->dai_link->stream_name);
-				return -EINVAL;
-			}
 		}
 		if (rtd->dai_link->dpcm_capture) {
 			stream = SNDRV_PCM_STREAM_CAPTURE;
@@ -2766,13 +2759,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 					break;
 				}
 			}
-
-			if (!capture) {
-				dev_err(rtd->card->dev,
-					"No CPU DAIs support capture for stream %s\n",
-					rtd->dai_link->stream_name);
-				return -EINVAL;
-			}
 		}
 	} else {
 		/* Adapt stream for codec2codec links */
-- 
2.25.4

