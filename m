Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D5C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E562076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgDQTPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:15:34 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36455 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728563AbgDQTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:15:33 -0400
Received: (qmail 26691 invoked by uid 500); 17 Apr 2020 15:15:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2020 15:15:32 -0400
Date:   Fri, 17 Apr 2020 15:15:32 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+7bf5a7b0f0a1f9446f4c@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usbhid_close (3)
In-Reply-To: <00000000000002c98f05a31a949a@google.com>
Message-ID: <Pine.LNX.4.44L0.2004171505170.25043-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Apr 2020, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=14453a8be00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
> dashboard link: https://syzkaller.appspot.com/bug?extid=7bf5a7b0f0a1f9446f4c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140c644fe00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163fb28be00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7bf5a7b0f0a1f9446f4c@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
> BUG: KASAN: use-after-free in usb_kill_urb drivers/usb/core/urb.c:696 [inline]
> BUG: KASAN: use-after-free in usb_kill_urb+0x24b/0x2c0 drivers/usb/core/urb.c:688
> Read of size 4 at addr ffff8881c6d6e210 by task systemd-udevd/1137

Details removed.  Given how hard this is to reproduce, it definitely 
seems like some sort of race.  But it's very hard to tell what is 
racing with what.

Let's start off easy and get a little extra information at the point 
where the bug occurs.  As far as I can tell, usbhid_close() is always 
supposed to be called before usbhid_stop().

Alan Stern

#syz test: https://github.com/google/kasan.git 0fa84af8

Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -747,6 +747,13 @@ static void usbhid_close(struct hid_devi
 		return;
 
 	hid_cancel_delayed_stuff(usbhid);
+	if (usbhid->alan_alloc == 0)
+		dev_WARN(&usbhid->intf->dev, "Close after dealloc (open %d)\n",
+				usbhid->alan_open);
+	if (usbhid->alan_open != 1)
+		dev_WARN(&usbhid->intf->dev, "Close while open = %d\n",
+				usbhid->alan_open);
+	--usbhid->alan_open;
 	usb_kill_urb(usbhid->urbin);
 	usbhid->intf->needs_remote_wakeup = 0;
 }
@@ -1120,6 +1127,7 @@ static int usbhid_start(struct hid_devic
 				continue;
 			if (!(usbhid->urbin = usb_alloc_urb(0, GFP_KERNEL)))
 				goto fail;
+			++usbhid->alan_alloc;
 			pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
 			usb_fill_int_urb(usbhid->urbin, dev, pipe, usbhid->inbuf, insize,
 					 hid_irq_in, hid, interval);
@@ -1177,6 +1185,7 @@ static int usbhid_start(struct hid_devic
 		usbhid_set_leds(hid);
 		device_set_wakeup_enable(&dev->dev, 1);
 	}
+	++usbhid->alan_open;
 	return 0;
 
 fail:
@@ -1197,6 +1206,9 @@ static void usbhid_stop(struct hid_devic
 	if (WARN_ON(!usbhid))
 		return;
 
+	if (usbhid->alan_open > 0)
+		dev_WARN(&usbhid->intf->dev, "Stop while open (alloc = %d)\n",
+				usbhid->alan_alloc);
 	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
 		clear_bit(HID_IN_POLLING, &usbhid->iofl);
 		usbhid->intf->needs_remote_wakeup = 0;
@@ -1206,6 +1218,7 @@ static void usbhid_stop(struct hid_devic
 	spin_lock_irq(&usbhid->lock);	/* Sync with error and led handlers */
 	set_bit(HID_DISCONNECTED, &usbhid->iofl);
 	spin_unlock_irq(&usbhid->lock);
+	--usbhid->alan_alloc;
 	usb_kill_urb(usbhid->urbin);
 	usb_kill_urb(usbhid->urbout);
 	usb_kill_urb(usbhid->urbctrl);
Index: usb-devel/drivers/hid/usbhid/usbhid.h
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/usbhid.h
+++ usb-devel/drivers/hid/usbhid/usbhid.h
@@ -87,6 +87,9 @@ struct usbhid_device {
 	unsigned int retry_delay;                                       /* Delay length in ms */
 	struct work_struct reset_work;                                  /* Task context for resets */
 	wait_queue_head_t wait;						/* For sleeping */
+
+	int alan_alloc;
+	int alan_open;
 };
 
 #define	hid_to_usb_dev(hid_dev) \

