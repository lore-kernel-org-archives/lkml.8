Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F77C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBD6206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oEbadlBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgASOTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 09:19:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2721 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgASOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:19:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2465690000>; Sun, 19 Jan 2020 06:19:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Jan 2020 06:19:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Jan 2020 06:19:38 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Jan
 2020 14:19:35 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 Jan 2020 14:19:35 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e2465750003>; Sun, 19 Jan 2020 06:19:35 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>
CC:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
Date:   Sun, 19 Jan 2020 19:49:23 +0530
Message-ID: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579443563; bh=rFEFNNnjn/oFYBOvROmovtPy+XEjEPcolgI3hKuqxZc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=oEbadlBrApqADc6KOru0g7hQMweDuKGV5p6vnJcQBoYPz7HWZ0KmxehJkZrwcplk3
         lf4eP4FsFzZjikZc1bJDq5SPDF06GHAsHVCh1kH2IMIiLjVv747W8g8dueW9vTHAkz
         OGODQixeG+WcR4rtsNsNQ5oJxJOfOitpM7ztFP/8d/ckBRpeMx3GaBiDepeMWDF0Ev
         UbBBXhwioxobwN01uItg9XBtoftLT3zh6Xzrml33t02VXusaBXlF5BXdtMQrU/z8it
         Ac39PFowcO9ASFphoi5XDJWc+3gwGoSAJymE2AOlDsi8SB5mUAgRiYSny50GplDmQK
         lCvg37/W9FKvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crash happens in snd_soc_dapm_new_dai() when substream->private_data
access is made and substream is NULL here. This is seen for DAIs where
only playback or capture stream is defined. This seems to be happening
for codec2codec DAI link.

Both playback and capture are 0 during soc_new_pcm(). This is probably
happening because cpu_dai and codec_dai are both validated either for
SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE.

Shouldn't be playback = 1 when,
 - playback stream is available for codec_dai AND
 - capture stream is available for cpu_dai

and vice-versa for capture = 1?

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 74d340d..5aa9c0b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2855,10 +2855,10 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 		for_each_rtd_codec_dai(rtd, i, codec_dai) {
 			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
-			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
+			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
 				playback = 1;
 			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
-			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
+			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
 				capture = 1;
 		}
 
-- 
2.7.4

