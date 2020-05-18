Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B1F20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgEREgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 00:36:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:37316 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgEREgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 00:36:13 -0400
IronPort-SDR: 0Ee9XBo2/mPDKSEPUA2IzW+LRwMK1/O9L+QOR13Lu2YY15nEF/F/NyKJPc8MAONHZUGxzGoWU/
 kDMi+WMsZedg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 21:36:13 -0700
IronPort-SDR: p6rRiXeEHC+/m4vNIGsbrHMJ9LBqCeWcTTsYh1TDx/sWGdIU7OJYQ9+K4mdJ2S+OmcV7dQxnhy
 PjLe/HKozgUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="scan'208";a="411123175"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2020 21:36:11 -0700
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
Subject: [PATCH v2] ALSA: pcm: fix incorrect hw_base increase
Date:   Mon, 18 May 2020 12:30:38 +0800
Message-Id: <1589776238-23877-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a corner case that ALSA keeps increasing the hw_ptr but DMA
already stop working/updating the position for a long time.

In following log we can see the position returned from DMA driver does
not move at all but the hw_ptr got increased at some point of time so
snd_pcm_avail() will return a large number which seems to be a buffer
underrun event from user space program point of view. The program
thinks there is space in the buffer and fill more data.

[  418.510086] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 4096 avail 12368
[  418.510149] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 6910 avail 9554
...
[  418.681052] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 15102 avail 1362
[  418.681130] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 16464 avail 0
[  418.726515] sound pcmC0D5p: pos 96 hw_ptr 16464 appl_ptr 16464 avail 16368

This is because the hw_base will be increased by runtime->buffer_size
frames unconditionally if the hw_ptr is not updated for over half of
buffer time. As the hw_base increases, so does the hw_ptr increased
by the same number.

The avail value returned from snd_pcm_avail() could exceed the limit
(buffer_size) easily becase the hw_ptr itself got increased by same
buffer_size samples when the corner case happens. In following log,
the buffer_size is 16368 samples but the avail is 21810 samples so
CRAS server complains about it.

[  418.851755] sound pcmC0D5p: pos 96 hw_ptr 16464 appl_ptr 27390 avail 5442
[  418.926491] sound pcmC0D5p: pos 96 hw_ptr 32832 appl_ptr 27390 avail 21810

cras_server[1907]: pcm_avail returned frames larger than buf_size:
sof-glkda7219max: :0,5: 21810 > 16368

By updating runtime->hw_ptr_jiffies each time the HWSYNC is called,
the hw_base will keep the same when buffer stall happens at long as
the interval between each HWSYNC call is shorter than half of buffer
time.

Following is a log captured by a patched kernel. The hw_base/hw_ptr
value is fixed in this corner case and user space program should be
aware of the buffer stall and handle it.

[  293.525543] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 4096 avail 12368
[  293.525606] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 6880 avail 9584
[  293.525975] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 10976 avail 5488
[  293.611178] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 15072 avail 1392
[  293.696429] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 16464 avail 0
...
[  381.139517] sound pcmC0D5p: pos 96 hw_ptr 96 appl_ptr 16464 avail 0

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

