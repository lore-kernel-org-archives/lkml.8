Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ECBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC51204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgGPROI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:14:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:3242 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgGPROI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:14:08 -0400
IronPort-SDR: V7I+Fu9P0xR6n8pnXJ7lmTTRCZHOX/MV7eEMu8i9R6iGjBZajrzku09Scyl/nIm+k7BtxHds8D
 dq/HQ552JHEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="136896015"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="136896015"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:14:07 -0700
IronPort-SDR: 6R0t2Qz3xSDnnYjKm0gNGfTjzRigT680d016xG8ijHFG4kqpS3pVSpC4YV+DWV4U1Pt2CT/GuN
 Ad4BlzF4EQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="308707428"
Received: from joycetoh-desk.sc.intel.com ([172.25.206.187])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2020 10:14:06 -0700
From:   Harsha Priya <harshapriya.n@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com
Cc:     lma@semihalf.com, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com, rad@semihalf.com,
        zwisler@google.com, linux-kernel@vger.kernel.org,
        sathya.prakash.m.r@intel.com, brndt@google.com, mw@semihalf.com,
        levinale@chromium.org,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v6] ASoC: Intel: kbl_rt5663_rt5514_max98927: Fix kabylake_ssp_fixup function
Date:   Thu, 16 Jul 2020 10:13:57 -0700
Message-Id: <1594919637-31460-1-git-send-email-harshapriya.n@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>

kabylake_ssp_fixup function uses snd_soc_dpcm to identify the codecs DAIs.
The hw parameters are changed based on the codec DAI,
the stream is intended for. The earlier approach to get
snd_soc_dpcm was using container_of() macro on snd_pcm_hw_params.
The structures have been modified over time and snd_soc_dpcm does 
not have snd_pcm_hw_params as a reference but as a copy.
This causes the current driver to crash when used.
This patch changes the way snd_soc_dpcm is extracted.
The snd_soc_pcm_runtime holds 2 dpcm
instances (one for playback and one for capture).
The 2 codecs on this SSP are dmic and speakers.
One is for capture and one is for playback respectively.
Based on the direction of the stream,
the snd_soc_dpcm is extracted from the snd_soc_pcm_runtime structure.
Tested for all use cases of the driver.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
Tested-by: Lukasz Majczak <lma@semihalf.com>
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
v4 -> v5:
- Cosmetic Changes
v5 -> v6:
- Dmic regression seen with v4 fixed 
- Using available routines for obtaining dpcm information
---
---
 .../intel/boards/kbl_rt5663_rt5514_max98927.c | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 584e4f9cedc2..b261b1c466a8 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -379,22 +379,30 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct snd_interval *chan = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
-	struct snd_soc_dpcm *dpcm = container_of(
-			params, struct snd_soc_dpcm, hw_params);
-	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
-	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
+	struct snd_soc_dpcm *dpcm, *rtd_dpcm;
+
+	/*
+	 * This macro will be called for playback stream
+	 */
+	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_PLAYBACK, dpcm)
+		rtd_dpcm = dpcm;
+	/*
+	 * This macro will be called for capture stream
+	 */
+	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_CAPTURE, dpcm)
+		rtd_dpcm = dpcm;
 
 	/*
 	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
 	 */
-	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
+	if (!strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Port") ||
+	    !strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Headset Playback") ||
+	    !strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Capture Port")) {
 		rate->min = rate->max = 48000;
 		chan->min = chan->max = 2;
 		snd_mask_none(fmt);
 		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
-	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
+	} else if (!strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio DMIC cap")) {
 		if (params_channels(params) == 2 ||
 				DMIC_CH(dmic_constraints) == 2)
 			chan->min = chan->max = 2;
@@ -405,7 +413,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
 	 * thus changing the mask here
 	 */
-	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
+	if (!strcmp(rtd_dpcm->be->dai_link->name, "SSP0-Codec"))
 		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
-- 
2.17.1

