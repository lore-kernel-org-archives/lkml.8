Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4103C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D658020657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgGONHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:07:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:61454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgGONHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:07:03 -0400
IronPort-SDR: 4mlgv5VBAoy8aa4TriM1ER9YbZiCJUaFgSrqzmqErlz5fj35Pq434hoWCeJgxkBqVZhgXdSdAf
 1uG3YgL/avQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="146648471"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="146648471"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 06:07:02 -0700
IronPort-SDR: E3pA83vvknl1Df5oHsY6r61hOoIDzniJHE8XzU9CoYabakhau/AgfLvtlpy6dDBj35AO9l6AFY
 apgQ9NUm9/LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="324828700"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2020 06:06:55 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdac_hdmi: remove cancel_work_sync in runtime suspend
Date:   Wed, 15 Jul 2020 21:01:50 +0800
Message-Id: <1594818110-786-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A deadlock is identified when there are three contexts running at the
same time:
- a HDMI jack work which is calling snd_soc_dapm_sync().
- user space is calling snd_pcm_release() to close pcm device.
- pm is calling runtime suspend function of HDMI codec driver.

By removing the clear_dapm_works() invocation in the
hdac_hdmi_runtime_suspend() function, the snd_pcm_release() could
always returns from dapm_power_widgets() function call without
blocking the hdac_hdmi_jack_dapm_work() work thread or being blocked
by the hdac_hdmi_runtime_suspend() function. The purpose of the jack
work is to enable/disable the dapm jack pin so it's not necessary to
cancel the work in runtime suspend function which is usually called
when pcm device is closed.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f26b77f..9052edd 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2097,8 +2097,6 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	if (!bus)
 		return 0;
 
-	clear_dapm_works(hdev);
-
 	/*
 	 * Power down afg.
 	 * codec_read is preferred over codec_write to set the power state.
-- 
2.7.4

