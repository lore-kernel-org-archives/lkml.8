Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5110C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE47920809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgG3ISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:18:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:58443 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730309AbgG3ISU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:18:20 -0400
IronPort-SDR: tRx7MsAyFR+ea4geXd0924D/VtgsjQCJGYiOHpAwIMBg9qwQTRuf/t9FgQZEl0EaJ9vgROqMI6
 DAXriDb3X8nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="149019974"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="149019974"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 01:18:19 -0700
IronPort-SDR: k0kGGPm0otlYqoP7r1Zz2We7YFrNk5rK8v6oAb+SU6HippbZesdgZMt2V/i2BuuFOUrIfeHDqd
 7dvdEoZrLqpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="272863433"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2020 01:18:15 -0700
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
Subject: [PATCH v2 1/2] ASoC: intel: atom: Add period size constraint
Date:   Thu, 30 Jul 2020 16:13:34 +0800
Message-Id: <1596096815-32043-2-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
References: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use constraint to enforce the period sizes which are validated in
Android BSP.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 49b9f18..70100ef 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -300,6 +300,16 @@ static void power_down_sst(struct sst_runtime_stream *stream)
 	stream->ops->power(sst->dev, false);
 }
 
+static const unsigned int media_period_size[] = {
+	/* sizes validated on Android platform */
+	240, 320, 960, 3072,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_media_period_size = {
+	.count = ARRAY_SIZE(media_period_size),
+	.list  = media_period_size,
+};
+
 static int sst_media_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -333,6 +343,11 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 	if (ret_val < 0)
 		return ret_val;
 
+	/* Avoid using period size which is not validated */
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+			&constraints_media_period_size);
+
 	/* Make sure, that the period size is always even */
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 			   SNDRV_PCM_HW_PARAM_PERIODS, 2);
-- 
2.7.4

