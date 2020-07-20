Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22981C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36392064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259836;
	bh=PKbze4aIN2Tiq+hHX/fexUrT/75/AE9fmKBYSnkr+oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvQCUfsX1/Sio0SzKAryFDPRqS+NnBoW5jC1yYVzLRYjlt+ktwJ90ZcwGH/dHw55U
	 24dnRxvwXHLS4MS5r4yB//dzp0BnmhbTpEFe3cMmEZqiG6hln1UZ+Scoj5+3HXwiuh
	 t4txijt13SDLH5+ckpk9EXe5Bo5ffpBj4Nl3xVJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgGTPny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbgGTPnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:43:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1AF2064B;
        Mon, 20 Jul 2020 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259828;
        bh=PKbze4aIN2Tiq+hHX/fexUrT/75/AE9fmKBYSnkr+oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+tbrBEjTzGSWFKWu8Afi3olui7rrpzeko7i4SEJAGggeuCSrMK8Hm/9pRPYcapVP
         F4yD51n98kA/S4hwT4tEmgY1jpvliUoajcv3VEQn8sldxuxJrbxWrD3tqS1FcmOXrY
         IoiFB6OYxnw3vBK9EIvhRLubG+yaSxbvYDfcXHi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0f4ecfe6a2c322c81728@syzkaller.appspotmail.com,
        syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 63/86] ALSA: usb-audio: Fix race against the error recovery URB submission
Date:   Mon, 20 Jul 2020 17:36:59 +0200
Message-Id: <20200720152756.340958934@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
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
@@ -1477,6 +1477,8 @@ void snd_usbmidi_disconnect(struct list_
 	spin_unlock_irq(&umidi->disc_lock);
 	up_write(&umidi->disc_rwsem);
 
+	del_timer_sync(&umidi->error_timer);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)
@@ -1503,7 +1505,6 @@ void snd_usbmidi_disconnect(struct list_
 			ep->in = NULL;
 		}
 	}
-	del_timer_sync(&umidi->error_timer);
 }
 EXPORT_SYMBOL(snd_usbmidi_disconnect);
 
@@ -2260,16 +2261,22 @@ void snd_usbmidi_input_stop(struct list_
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
 
@@ -2285,7 +2292,7 @@ void snd_usbmidi_input_start(struct list
 	if (umidi->input_running || !umidi->opened[1])
 		return;
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
+		snd_usbmidi_input_start_ep(umidi, umidi->endpoints[i].in);
 	umidi->input_running = 1;
 }
 EXPORT_SYMBOL(snd_usbmidi_input_start);


