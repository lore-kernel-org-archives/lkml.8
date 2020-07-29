Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45452C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA2E207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgG2LIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:08:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:6763 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2LIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:08:16 -0400
IronPort-SDR: DkFCgW2CVGE07YH6vb3eXcZRneOxOZfDMgK/ys3xd7acbH6zaC++pVXbG3KKO2L8LJEemya6/A
 DrZX91U9u+SA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="212927290"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="212927290"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 04:08:15 -0700
IronPort-SDR: UjG7wrUkSisjIz3Jc9k+dFCTkYjjmt0CuRXHWlZfjg8+KzO4N4pnocjt3x+0Y2oap5itMwZ1v2
 PPb4GiOkVV8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="490254805"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2020 04:08:11 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: [PATCH 2/2] ASoC: Intel: Add period size constraint on strago board
Date:   Wed, 29 Jul 2020 19:03:05 +0800
Message-Id: <1596020585-11517-3-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu-Hsuan Hsu <yuhsuan@chromium.org>

The CRAS server does not set the period size in hw_param so ALSA will
calculate a value for period size which is based on the buffer size
and other parameters. The value may not always be aligned with Atom's
dsp design so a constraint is added to make sure the board always has
a good value.

Cyan uses chtmax98090 and others(banon, celes, edgar, kefka...) use
rt5650.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 14 +++++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 835e9bd..bf67254 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -283,8 +283,20 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 
 static int cht_aif1_startup(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_hw_constraint_single(substream->runtime,
+	int err;
+
+	/* Set period size to 240 to align with Atom design */
+	err = snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_constraint_single(substream->runtime,
 			SNDRV_PCM_HW_PARAM_RATE, 48000);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 static int cht_max98090_headset_init(struct snd_soc_component *component)
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index b53c024..6e62f0d 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -414,8 +414,20 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 
 static int cht_aif1_startup(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_hw_constraint_single(substream->runtime,
+	int err;
+
+	/* Set period size to 240 to align with Atom design */
+	err = snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_constraint_single(substream->runtime,
 			SNDRV_PCM_HW_PARAM_RATE, 48000);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 static const struct snd_soc_ops cht_aif1_ops = {
-- 
2.7.4

