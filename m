Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A454C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1B4214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDRBaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 21:30:14 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36477 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725939AbgDRBaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:30:13 -0400
Received: (qmail 23212 invoked by uid 500); 17 Apr 2020 21:30:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2020 21:30:12 -0400
Date:   Fri, 17 Apr 2020 21:30:12 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+7bf5a7b0f0a1f9446f4c@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usbhid_close (3)
In-Reply-To: <0000000000005f3ae305a3823448@google.com>
Message-ID: <Pine.LNX.4.44L0.2004172128290.23070-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> WARNING in usbhid_stop
> 
> usb 2-1: USB disconnect, device number 5
> ------------[ cut here ]------------
> usbhid 2-1:0.0: Stop while open (alloc = 1)

Okay, good.  usbhid_close() should have been called before this 
happened.  Let's try tracing the pathway; maybe this will show where it 
goes off the rails.

Alan Stern


#syz test: https://github.com/google/kasan.git 0fa84af8

Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -747,6 +747,7 @@ static void usbhid_close(struct hid_devi
 		return;
 
 	hid_cancel_delayed_stuff(usbhid);
+	--hid->alan_open;
 	usb_kill_urb(usbhid->urbin);
 	usbhid->intf->needs_remote_wakeup = 0;
 }
@@ -1177,6 +1178,7 @@ static int usbhid_start(struct hid_devic
 		usbhid_set_leds(hid);
 		device_set_wakeup_enable(&dev->dev, 1);
 	}
+	++hid->alan_open;
 	return 0;
 
 fail:
@@ -1197,6 +1199,10 @@ static void usbhid_stop(struct hid_devic
 	if (WARN_ON(!usbhid))
 		return;
 
+	if (hid->alan_open > 0)
+		dev_WARN(&usbhid->intf->dev, "Stop while open = %d: %d %d %d\n",
+				hid->alan_open,
+				hid->alan1, hid->alan2, hid->alan3);
 	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
 		clear_bit(HID_IN_POLLING, &usbhid->iofl);
 		usbhid->intf->needs_remote_wakeup = 0;
Index: usb-devel/drivers/hid/hid-input.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-input.c
+++ usb-devel/drivers/hid/hid-input.c
@@ -1960,6 +1960,7 @@ void hidinput_disconnect(struct hid_devi
 {
 	struct hid_input *hidinput, *next;
 
+	++hid->alan1;
 	hidinput_cleanup_battery(hid);
 
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
Index: usb-devel/drivers/input/evdev.c
===================================================================
--- usb-devel.orig/drivers/input/evdev.c
+++ usb-devel/drivers/input/evdev.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/hid.h>
 #include "input-compat.h"
 
 struct evdev {
@@ -1329,6 +1330,11 @@ static void evdev_mark_dead(struct evdev
 static void evdev_cleanup(struct evdev *evdev)
 {
 	struct input_handle *handle = &evdev->handle;
+	struct hid_device *hid;
+
+	hid = (struct hid_device *) input_get_drvdata(evdev->handle.dev);
+	if (hid)
+		++hid->alan3;
 
 	evdev_mark_dead(evdev);
 	evdev_hangup(evdev);
Index: usb-devel/drivers/input/input.c
===================================================================
--- usb-devel.orig/drivers/input/input.c
+++ usb-devel/drivers/input/input.c
@@ -23,6 +23,7 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/hid.h>
 #include "input-compat.h"
 #include "input-poller.h"
 
@@ -2081,7 +2082,11 @@ static void input_cleanse_bitmasks(struc
 static void __input_unregister_device(struct input_dev *dev)
 {
 	struct input_handle *handle, *next;
+	struct hid_device *hid;
 
+	hid = (struct hid_device *) input_get_drvdata(dev);
+	if (hid)
+		++hid->alan2;
 	input_disconnect_device(dev);
 
 	mutex_lock(&input_mutex);
Index: usb-devel/include/linux/hid.h
===================================================================
--- usb-devel.orig/include/linux/hid.h
+++ usb-devel/include/linux/hid.h
@@ -618,6 +618,9 @@ struct hid_device {							/* device repo
 	struct list_head debug_list;
 	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
+
+	int alan_open;
+	int alan1, alan2, alan3;
 };
 
 #define to_hid_device(pdev) \

