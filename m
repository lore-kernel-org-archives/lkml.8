Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F79C43458
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2AE22CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259581;
	bh=4LYVKqyKN9xV8M9TBHUesmBHO5eygQaHSnBzaG4HhQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IRaLscYSlgjXwWhzOMHaf/lqa4ZxLEX9LBQVduL4qbzM8Jj/tEafXiTEJcFjsTYbS
	 gPE79zkoBzTvntwUn4SkPDn6qm1HWZrt+k/9tBmqk1NyamrMZ7eyWBENPFKXXInuj8
	 B5kx+6qUeZyVS1Lk4TTyVVgI711Op31SFc66nHlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgGTPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbgGTPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16D022CB2;
        Mon, 20 Jul 2020 15:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259576;
        bh=4LYVKqyKN9xV8M9TBHUesmBHO5eygQaHSnBzaG4HhQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUi/DP00Ksp0MFTxjPRPw/0WNRIMClirTpdywylbrYU7sm8NtJeK5HnEjCDqhag2L
         0brVbmV+9BWrdeYOdHDPLD+LKAV2JZ/sZzbQAwvKfb/uCGGgCQhw5TYURGXOsxkRfm
         qcRbtsH0dCzmMgyWZIe2PAM7foMzhRO1myaCdDWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0f4ecfe6a2c322c81728@syzkaller.appspotmail.com,
        syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 40/58] ALSA: usb-audio: Fix race against the error recovery URB submission
Date:   Mon, 20 Jul 2020 17:36:56 +0200
Message-Id: <20200720152749.218145840@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 9b7e5208a941e2e491a83eb5fa83d889e888fa2f upstream.

USB MIDI driver has an error recovery mechanism to resubmit the URB in
the delayed timer handler, and this may race with the standard start /
stop operations.  Although both start and stop operations themselves
don't race with each other due to the umidi->mutex protection, but
this isn't applied to the timer handler.

For fixing this potential race, the following changes are applied:

- Since the timer handler can't use the mutex, we apply the
  umidi->disc_lock protection at each input stream URB submission;
  this also needs to change the GFP flag to GFP_ATOMIC
- Add a check of the URB refcount and skip if already submitted
- Move the timer cancel call at disconnection to the beginning of the
  procedure; this assures the in-flight timer handler is gone properly
  before killing all pending URBs

Reported-by: syzbot+0f4ecfe6a2c322c81728@syzkaller.appspotmail.com
Reported-by: syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200710160656.16819-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/midi.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1475,6 +1475,8 @@ void snd_usbmidi_disconnect(struct list_
 	spin_unlock_irq(&umidi->disc_lock);
 	up_write(&umidi->disc_rwsem);
 
+	del_timer_sync(&umidi->error_timer);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)
@@ -1501,7 +1503,6 @@ void snd_usbmidi_disconnect(struct list_
 			ep->in = NULL;
 		}
 	}
-	del_timer_sync(&umidi->error_timer);
 }
 EXPORT_SYMBOL(snd_usbmidi_disconnect);
 
@@ -2258,16 +2259,22 @@ void snd_usbmidi_input_stop(struct list_
 }
 EXPORT_SYMBOL(snd_usbmidi_input_stop);
 
-static void snd_usbmidi_input_start_ep(struct snd_usb_midi_in_endpoint *ep)
+static void snd_usbmidi_input_start_ep(struct snd_usb_midi *umidi,
+				       struct snd_usb_midi_in_endpoint *ep)
 {
 	unsigned int i;
+	unsigned long flags;
 
 	if (!ep)
 		return;
 	for (i = 0; i < INPUT_URBS; ++i) {
 		struct urb *urb = ep->urbs[i];
-		urb->dev = ep->umidi->dev;
-		snd_usbmidi_submit_urb(urb, GFP_KERNEL);
+		spin_lock_irqsave(&umidi->disc_lock, flags);
+		if (!atomic_read(&urb->use_count)) {
+			urb->dev = ep->umidi->dev;
+			snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
+		}
+		spin_unlock_irqrestore(&umidi->disc_lock, flags);
 	}
 }
 
@@ -2283,7 +2290,7 @@ void snd_usbmidi_input_start(struct list
 	if (umidi->input_running || !umidi->opened[1])
 		return;
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
+		snd_usbmidi_input_start_ep(umidi, umidi->endpoints[i].in);
 	umidi->input_running = 1;
 }
 EXPORT_SYMBOL(snd_usbmidi_input_start);


