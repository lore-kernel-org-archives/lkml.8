Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB0C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2C82073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DPEN5idy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgATGRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:17:55 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14659 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATGRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:17:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2545e80000>; Sun, 19 Jan 2020 22:17:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Jan 2020 22:17:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Jan 2020 22:17:54 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jan
 2020 06:17:53 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jan 2020 06:17:53 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e25460f0000>; Sun, 19 Jan 2020 22:17:52 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <oder_chiou@realtek.com>, <bardliao@realtek.com>, <tiwai@suse.com>,
        <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] ASoC: rt5659: add S32_LE format
Date:   Mon, 20 Jan 2020 11:47:39 +0530
Message-ID: <1579501059-27936-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579501032; bh=y0KuUHnikrqaYl+AkuZgAWArMBLX50J5YFwz5WfJk08=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=DPEN5idyJgzm2UDuPOm/OFoQREwFgQerUJtKuDcWM5En/svuJEE3lPbniYiVh6lTU
         zOIPi3LEjcDeT42jhY+iQ724jJX/K24V2wezlqrSlN0tknEyYvoF27jOfiEgLNsuM+
         xeRQBem8lqAp+SdfJCwBRGYomAwl1M1BlQ2CB4hLgmb76UF+1kFHepZcqYESjywQhB
         eptOA3axpayafuiDhb+G4gORb+qWi73maMWfP93qjEc1NlARp7isRsf0RdEE6YLyw7
         qbu/z8z0f0SLibcBZVFJ08KHzDaRI7derNbbVkUN7gm/QBsxxf2KlwqzoOw44r/Etd
         gd1d5iAnsJoog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALC5659 supports maximum data length of 24-bit. Currently driver supports
S24_LE which is a 32-bit container with valid data in [23:0] and 0s in MSB.
S24_3LE is not commonly used and is hard to find audio streams with this
format. Also many SoC HW do not support S24_LE and S32_LE is used in
general. The 24-bit data can be represented in S32_LE [31:8] and 0s are
padded in LSB.

This patch adds S32_LE to ALC5659 driver and data length for this is set
to 24 as per codec's maximum data length support. This helps to play
24-bit audio, packed in S32_LE, on HW which do not support S24_LE.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/codecs/rt5659.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index fc74dd63..f910ddf 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3339,6 +3339,7 @@ static int rt5659_hw_params(struct snd_pcm_substream *substream,
 		val_len |= RT5659_I2S_DL_20;
 		break;
 	case 24:
+	case 32:
 		val_len |= RT5659_I2S_DL_24;
 		break;
 	case 8:
@@ -3733,7 +3734,8 @@ static int rt5659_resume(struct snd_soc_component *component)
 
 #define RT5659_STEREO_RATES SNDRV_PCM_RATE_8000_192000
 #define RT5659_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
-		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
+		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE | \
+		SNDRV_PCM_FMTBIT_S8)
 
 static const struct snd_soc_dai_ops rt5659_aif_dai_ops = {
 	.hw_params = rt5659_hw_params,
-- 
2.7.4

