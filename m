Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE85C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FBD20725
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="jjnN0Drm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEGWDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgEGWDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:03:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6477EC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 15:03:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so8037197ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=wUuNuaJIglL+Kx5ApW0YvQ2BpX31cdZYGLJ2BUr4Tvs=;
        b=jjnN0DrmtBzX5eCaj5CLxE3x/6tX8xc+xUqp7+sjt26xKKaixfXPpZTbSSbc/kGCDL
         1GmTHBJ23lXZm2Bx5sy4NBd+9MNy1KyQ6SBfhIiQ9N8Elg3BVT12iXakMMVFe/tYlwmo
         8AdCHMohcZt6/OugywymC2rIyNOEKrf3kvNa4HJz+7POopF+wtHjrR43HRO0nhKX6Os3
         o9j0Wpw6JVwng7qk1MTXH/+YTIcQH9CmQTxD0O8LlEgLqagzAqwDrcWWed7/6cdeY9fh
         tnMczF33SvTguEIfSP8JMHvpxfzyfebE6iN8oOmq7RaLTfMJqFSDEjcoaPafnbzoc1yN
         8/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wUuNuaJIglL+Kx5ApW0YvQ2BpX31cdZYGLJ2BUr4Tvs=;
        b=Waoucns6kYyUb1OP2AjfeqC49tPPAz9lcFznS9SEFOVwb70oPUxCy8gFOGTy/ldu3I
         NAw3ygF+Bafif3Ua7lLXCl+i5f+gNKvDe5Oqf8KimoTuoveKl6OLjsoHAQruRQzxCaKq
         yel4XIMQwTjAolv0EVf8q3N+Zv+dUh+oaam7VmVlTr3sDmv1A6yGw4jdFIMQ04jiy6o9
         n01rzYg233Phk4K+Ktl6llP2b+RYEVSNvrlFlBYo2dTJb6DUxvfvEjg1AWBEG7daUbcw
         K/BA+UoOUwwpHfrSh81q17eNQdy6BRkIKAbwgxUaXATjFoUcswQZu3DWnDlpbH/7IzZT
         96hQ==
X-Gm-Message-State: AGi0PuYZ4InsHoKekoBt6O0J3pkQD+FpqnN/4j/MK6TF1TkzL02rq02Y
        QSce1PIIgO22gWovVGyqoHJ7Iw==
X-Google-Smtp-Source: APiQypLfjpW+TsQ8WZmwmd/fpl1/0cAj9W9AWHktmin9enHLmhIo3KDk1ZXJ6X2Heb2MyqGmrKXyfg==
X-Received: by 2002:a2e:9691:: with SMTP id q17mr9599037lji.116.1588889025769;
        Thu, 07 May 2020 15:03:45 -0700 (PDT)
Received: from rad-H81M-S1.semihalf.local (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id a13sm4095267ljm.25.2020.05.07.15.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 15:03:44 -0700 (PDT)
From:   Radoslaw Biernacki <rad@semihalf.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Ben Zhang <benzh@chromium.org>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>,
        Chinyue Chen <chinyue@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Radoslaw Biernacki <rad@semihalf.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Boards: Support headset button function for nau88l25max and nau88l25ssm
Date:   Fri,  8 May 2020 00:03:32 +0200
Message-Id: <20200507220332.24686-1-rad@semihalf.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map the buttons from the Android reference headset to
KEY_PLAYPAUSE, KEY_VOICECOMMAND, KEY_VOLUMEUP, and KEY_VOLUMEDOWN.
KEY_PLAYPAUSE is used instead of KEY_MEDIA for BTN_0 as it is more
logical and have much broader userspace support. Like Chrome OS
use it to play/pause of video and audio. KEY_PLAYPAUSE is also
supported by Android (USB headset spec requires KEY_PLAYPAUSE
for BTN_0.)
https://source.android.com/devices/accessories/headset/usb-headset-spec

Signed-off-by: Chinyue Chen <chinyue@chromium.org>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 7 +++++++
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index d7b8154c43a4..103ea94c3bd1 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2015, Intel Corporation. All rights reserved.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -158,6 +159,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	struct snd_soc_jack *jack;
 
 	/*
 	 * Headset buttons map to the google Reference headset.
@@ -172,6 +174,11 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	jack = &skylake_headset;
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 	nau8825_enable_jack_detect(component, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 4b317bcf6ea0..1528e72c3a11 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -10,6 +10,7 @@
  *   Copyright (C) 2015, Intel Corporation. All rights reserved.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -177,6 +178,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	struct snd_soc_jack *jack;
 
 	/*
 	 * 4 buttons here map to the google Reference headset
@@ -191,6 +193,11 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	jack = &skylake_headset;
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 	nau8825_enable_jack_detect(component, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");

base-commit: f8729a41aa17f5eb5291a0e78926154e948bb4ad
-- 
2.17.1

