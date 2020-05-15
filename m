Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B9AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 04:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD8A206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 04:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEOEPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 00:15:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:13161 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgEOEPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 00:15:48 -0400
IronPort-SDR: yvDlW/4+FWbM5MqhgKyFCSgUJDIXvDmyoCRPYkLVEyhwT5jypkSrYlKX5TiUEZhwDwxcHrSotw
 sjfTa+wGgcSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 21:15:47 -0700
IronPort-SDR: h21gBEuc1WSXsq8NSuif0vOqjl206dBqGYH1UlpT5XC4yIptNdSmDunNfMV8M5pQJWRmKg1I1p
 4q4+5QVdf89A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="253683839"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga008.fm.intel.com with ESMTP; 14 May 2020 21:15:42 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brent Lu <brent.lu@intel.com>,
        paulhsia <paulhsia@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcm: fix incorrect hw_base increase
Date:   Fri, 15 May 2020 12:09:39 +0800
Message-Id: <1589515779-20987-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hw_base will be increased by runtime->buffer_size frames
unconditionally if the runtime->status->hw_ptr is not updated for over
half of buffer time. As the hw_base increases, so does the
runtime->status->hw_ptr which could lead to invalid return value when
user space program calls snd_pcm_avail() function.

By updating runtime->hw_ptr_jiffies each time the HWSYNC is called,
the hw_base will keep the same when buffer stall happens, so does the
hw_ptr.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/core/pcm_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 872a852..d531e1b 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -433,6 +433,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 
  no_delta_check:
 	if (runtime->status->hw_ptr == new_hw_ptr) {
+		runtime->hw_ptr_jiffies = curr_jiffies;
 		update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp);
 		return 0;
 	}
-- 
2.7.4

