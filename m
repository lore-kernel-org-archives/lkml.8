Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203EFC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0040620757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341090;
	bh=QtraSO/KBfOH6GBWPZ9xnZquO0Vf93a/M99u/hbLZRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q80/pre7AMMYb8j0wsMK8wfdCd+RrBPNgucUPZISpWT5M/nVFYLpPyo2oL+3QXRwA
	 jTEOoBg9IZ4a3bVq3AKF/QNN150xowM7w9aWPmHvl7RgoOjJQourQYoGA9ZbCG4b2a
	 huCmYjvTEM+hm8O5yU3N2vPTQgT6sIsC9z7Oe59U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgEANv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731065AbgEANif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:38:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ACFA205C9;
        Fri,  1 May 2020 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340314;
        bh=QtraSO/KBfOH6GBWPZ9xnZquO0Vf93a/M99u/hbLZRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+NLmu/g/UH8XkeudmVfNIXnvW/i+LhJM09ArJUnIXLP4qRhVBuCbZMkHjhXj0AFh
         PfLf12pNcxfCNI6VUyrHaIEVmoXE04p4itaQ+ZjOdRZBM2FS5tHFg3Ysds9gTyiyY0
         BA8RvSN/RS7xMKq9jbl5SqumqGBpaNWLepCohFeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 15/83] ASoC: q6dsp6: q6afe-dai: add missing channels to MI2S DAIs
Date:   Fri,  1 May 2020 15:22:54 +0200
Message-Id: <20200501131527.908472952@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit 0c824ec094b5cda766c80d88c2036e28c24a4cb1 upstream.

For some reason, the MI2S DAIs do not have channels_min/max defined.
This means that snd_soc_dai_stream_valid() returns false,
i.e. the DAIs have neither valid playback nor capture stream.

It's quite surprising that this ever worked correctly,
but in 5.7-rc1 this is now failing badly: :)

Commit 0e9cf4c452ad ("ASoC: pcm: check if cpu-dai supports a given stream")
introduced a check for snd_soc_dai_stream_valid() before calling
hw_params(), which means that the q6i2s_hw_params() function
was never called, eventually resulting in:

    qcom-q6afe aprsvc:q6afe:4:4: no line is assigned

... even though "qcom,sd-lines" is set in the device tree.

Commit 9b5db059366a ("ASoC: soc-pcm: dpcm: Only allow playback/capture if supported")
now even avoids creating PCM devices if the stream is not supported,
which means that it is failing even earlier with e.g.:

    Primary MI2S: ASoC: no backend playback stream

Avoid all that trouble by adding channels_min/max for the MI2S DAIs.

Fixes: 24c4cbcfac09 ("ASoC: qdsp6: q6afe: Add q6afe dai driver")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200415150050.616392-1-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/qcom/qdsp6/q6afe-dai.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -902,6 +902,8 @@ static struct snd_soc_dai_driver q6afe_d
 				 SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
 			.rate_min =     8000,
 			.rate_max =     48000,
 		},
@@ -917,6 +919,8 @@ static struct snd_soc_dai_driver q6afe_d
 				 SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
 			.rate_min =     8000,
 			.rate_max =     48000,
 		},
@@ -931,6 +935,8 @@ static struct snd_soc_dai_driver q6afe_d
 			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
 				 SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.channels_min = 1,
+			.channels_max = 8,
 			.rate_min =     8000,
 			.rate_max =     48000,
 		},
@@ -946,6 +952,8 @@ static struct snd_soc_dai_driver q6afe_d
 				 SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
 			.rate_min =     8000,
 			.rate_max =     48000,
 		},
@@ -960,6 +968,8 @@ static struct snd_soc_dai_driver q6afe_d
 			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
 				 SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.channels_min = 1,
+			.channels_max = 8,
 			.rate_min =     8000,
 			.rate_max =     48000,
 		},
@@ -975,6 +985,8 @@ static struct snd_soc_dai_driver q6afe_d
 				 SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
 			.rate_min =     8000,
 			.rate_max =     48000,
 		},
@@ -989,6 +1001,8 @@ static struct snd_soc_dai_driver q6afe_d
 			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
 				 SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.channels_min = 1,
+			.channels_max = 8,
 			.rate_min =     8000,
 			.rate_max =     48000,
 		},
@@ -1004,6 +1018,8 @@ static struct snd_soc_dai_driver q6afe_d
 				 SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
 			.rate_min =     8000,
 			.rate_max =     48000,
 		},


