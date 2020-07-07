Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44728C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B422063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="toXR90TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGGIfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:35:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:35:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so24024488ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pi2QMJooQDzVTGiaXTaVqMs0R9UTlGQl5bhYVsHngfI=;
        b=toXR90TMB7k7cCx6gaO5MN+eBimOAZHRNRfqjIuD0Zk7N0Ch8Sc924611G/bauaRsv
         ihyB8jNAcwbKZijx4P59FKAE3UF8KN5xDidw4pRzxm5DKtzMXF6zLtPoQA8V0ZZkj1tk
         m+HqkSXZoqpnrcGmN85xBLg0vNVp5Yhm1iKnWUEVlj+i40GdxO+VouZQ3a9+QssFe73V
         uXBOHtcEi7V1/1Q1snnxYgv+oSxSxpNmKgEWM+/QeU3pt7TOEF914xcaFt9yn26o5t+p
         j2K/f3/+wj3VB6AHmTWSifNbTahpfeTDKlS9gqcJYXQlLX5M090nORCu6p60Wy6zwpOG
         Tdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pi2QMJooQDzVTGiaXTaVqMs0R9UTlGQl5bhYVsHngfI=;
        b=Fpa2KXy/w3xxt57pPCJLj4IyIt11CoF77AHMQI6Xn9eunKa1b1y9REQWEamV/Qd6Eo
         ZcY1z4qIbk5Gnl8mgjzHZ5qhexwubLB9cz5lL/cDQNBZVOzylGvIErCxS3qDaSq/yKUM
         Z/Jb5hWQMfOOYjoj5LgGg7syBsQqe2xoqP6bpK0kM3lhpar0pF+OOtvx1Ymg0bmXCqN2
         WVHuxs9mciEJRxeedPqKpqwzxnXbsnvtc0NDkuqOy7WWlzqfuHiKFsPqzENIe4X5xKwV
         EJUKrNdPcbGs1OUB5YElcAi+ymHr1p5sdD+ieKRYaKQaHd5Gh3CHab4TXxQGDOtPpB7o
         JTDg==
X-Gm-Message-State: AOAM531HE8UMsBlkr9yCROk08HJg7uANIUBzYINXMTNpy2D14n7c7SOK
        Ws2z7O59wd6h0nr7djg5Tb5reQ==
X-Google-Smtp-Source: ABdhPJw5MCqfotmslsO3I9DujkwsheCGyPVqFFOQmAhSwl6XIqEKOc+/EBiKyzNZEans4qpO/FUi5w==
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr7057822ljj.209.1594110910357;
        Tue, 07 Jul 2020 01:35:10 -0700 (PDT)
Received: from localhost.localdomain (89-70-221-122.dynamic.chello.pl. [89.70.221.122])
        by smtp.gmail.com with ESMTPSA id g142sm9437382lfd.41.2020.07.07.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:35:09 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Harsha Priya <harshapriya.n@intel.com>
Cc:     Gopal Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Bob Brandt <brndt@google.com>,
        Alex Levin <levinale@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v5] ASoC: Intel: kbl_rt5663_rt5514_max98927: Fix kabylake_ssp_fixup function
Date:   Tue,  7 Jul 2020 10:34:04 +0200
Message-Id: <20200707083404.3846-1-lma@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703121650.547944-1-lma@semihalf.com>
References: <20200703121650.547944-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kabylake_ssp_fixup function to distinguish codecs DAIs by names,
as current approach, leads to crash while trying to get snd_soc_dpcm with
container_of() macro in kabylake_ssp_fixup().
The crash call path looks as below:
soc_pcm_hw_params()
snd_soc_dai_hw_params(codec_dai, substream, &codec_params);
rtd->dai_link->be_hw_params_fixup(rtd, params)
kabylake_ssp_fixup()
In this case, codec_params is just a copy of an internal structure and is
not embedded into struct snd_soc_dpcm thus we cannot use
container_of() on it.

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
v1 -> v2:
- Extract dmic from SSP0 as every BE should have own fixup function.
v2 -> v3:
- Restore naming in the dapm route table to not confuse with other
drivers
- Fixed indentations
v3 -> v4:
- Updated code and commit description according to
solution proposed by Harsha
---
 .../intel/boards/kbl_rt5663_rt5514_max98927.c | 28 ++++++++-----------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index b34cf6cf11395..df454de40739a 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -333,36 +333,32 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_interval *rate = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *chan = hw_param_interval(params,
+	struct snd_interval *channels = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
-	struct snd_soc_dpcm *dpcm = container_of(
-			params, struct snd_soc_dpcm, hw_params);
-	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
-	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 
 	/*
 	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
 	 */
-	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
+
+	if (!strcmp(codec_dai->name, KBL_REALTEK_DMIC_CODEC_DAI)) {
+		if (params_channels(params) == 2 ||
+			DMIC_CH(dmic_constraints) == 2)
+			channels->min = channels->max = 2;
+		else
+			channels->min = channels->max = 4;
+	} else {
 		rate->min = rate->max = 48000;
-		chan->min = chan->max = 2;
+		channels->min = channels->max = 2;
 		snd_mask_none(fmt);
 		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
-	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
-		if (params_channels(params) == 2 ||
-				DMIC_CH(dmic_constraints) == 2)
-			chan->min = chan->max = 2;
-		else
-			chan->min = chan->max = 4;
 	}
 	/*
 	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
 	 * thus changing the mask here
 	 */
-	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
+	if (!strcmp(codec_dai->name, KBL_MAXIM_CODEC_DAI))
 		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
-- 
2.25.1

