Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C02C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B79D206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbgGaMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:30:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:59727 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733191AbgGaMao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:30:44 -0400
IronPort-SDR: 8pdLd7vkamO5L316bPanob9DzqVzShEaV45qZG7l5yourkGTYqllQaZmQmJsq5XP2lnlSwrUXg
 /Fl4YIBCniAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="150963378"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="150963378"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:30:43 -0700
IronPort-SDR: 3ncVmCcCNj+kcfqtoxKO0Smsyp/L27d5EyoqOCNhtQ0vcZITqrgOHCAvmFVOhXoDdTpZHljAzH
 My9r2MEzGXwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="365483171"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2020 05:30:40 -0700
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
Subject: [PATCH v3 1/2] ASoC: intel: atom: Add period size constraint
Date:   Fri, 31 Jul 2020 20:26:04 +0800
Message-Id: <1596198365-10105-2-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596198365-10105-1-git-send-email-brent.lu@intel.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-1-git-send-email-brent.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use constraint to make sure the period size could always be multiple
of 1ms to align with the fundamental design/limitation of firmware.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 49b9f18..5f89956 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -333,6 +333,17 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 	if (ret_val < 0)
 		return ret_val;
 
+	/*
+	 * Make sure the period to be multiple of 1ms to align the
+	 * design of firmware. Apply same rule to buffer size to make
+	 * sure alsa could always find a value for period size
+	 * regardless the buffer size given by user space.
+	 */
+	snd_pcm_hw_constraint_step(substream->runtime, 0,
+			   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 48);
+	snd_pcm_hw_constraint_step(substream->runtime, 0,
+			   SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 48);
+
 	/* Make sure, that the period size is always even */
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 			   SNDRV_PCM_HW_PARAM_PERIODS, 2);
-- 
2.7.4

