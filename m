Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE5DC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2768B21927
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSBem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:34:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:32869 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725877AbgDSBel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:34:41 -0400
Received: (qmail 26346 invoked by uid 500); 18 Apr 2020 21:34:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2020 21:34:40 -0400
Date:   Sat, 18 Apr 2020 21:34:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+7bf5a7b0f0a1f9446f4c@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usbhid_close (3)
In-Reply-To: <000000000000f4957305a3968e84@google.com>
Message-ID: <Pine.LNX.4.44L0.2004182131100.26218-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> WARNING in usbhid_stop
> 
> usbhid 6-1:0.0: Stop: 1 1 0 0
> ------------[ cut here ]------------
> usbhid 6-1:0.0: Stop while open = 1

This indicates there is some confusion about whether the wacom device
is an input device.  Apparently hidinput_connect() either doesn't get
called or fails, but nevertheless an evdev input handler gets
associated with the device.

Maybe the confusion is only in my head.  This test may help clear it up 
a little.

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
@@ -1197,6 +1199,11 @@ static void usbhid_stop(struct hid_devic
 	if (WARN_ON(!usbhid))
 		return;
 
+	dev_info(&usbhid->intf->dev, "Stop: %d %d %d %d\n",
+			hid->alan1, hid->alan2, hid->alan3, hid->alan4);
+	if (hid->alan_open > 0)
+		dev_WARN(&usbhid->intf->dev, "Stop while open = %d\n",
+				hid->alan_open);
 	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
 		clear_bit(HID_IN_POLLING, &usbhid->iofl);
 		usbhid->intf->needs_remote_wakeup = 0;
Index: usb-devel/drivers/hid/hid-input.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-input.c
+++ usb-devel/drivers/hid/hid-input.c
@@ -1861,6 +1861,7 @@ int hidinput_connect(struct hid_device *
 	unsigned int application;
 	int i, k;
 
+	dev_info(&hid->dev, "In hidinput_connect\n");
 	INIT_LIST_HEAD(&hid->inputs);
 	INIT_WORK(&hid->led_work, hidinput_led_worker);
 
@@ -1960,6 +1961,7 @@ void hidinput_disconnect(struct hid_devi
 {
 	struct hid_input *hidinput, *next;
 
+	++hid->alan3;
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
+//	struct hid_device *hid;
+
+//	hid = evdev->handle.dev->hid;
+//	if (hid)
+//		++hid->alan3;
 
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
 
@@ -1031,6 +1032,10 @@ static int input_attach_handler(struct i
 	if (error && error != -ENODEV)
 		pr_err("failed to attach handler %s to device %s, error: %d\n",
 		       handler->name, kobject_name(&dev->dev.kobj), error);
+	if (!error && dev->hid) {
+		dev_info(&dev->dev, "Attached to handler %s\n", handler->name);
+		dump_stack();
+	}
 
 	return error;
 }
@@ -2157,6 +2162,7 @@ int input_register_device(struct input_d
 	const char *path;
 	int error;
 
+	dev_info(&dev->dev, "In input_register_device\n");
 	if (test_bit(EV_ABS, dev->evbit) && !dev->absinfo) {
 		dev_err(&dev->dev,
 			"Absolute device without dev->absinfo, refusing to register\n");
@@ -2258,6 +2264,11 @@ EXPORT_SYMBOL(input_register_device);
  */
 void input_unregister_device(struct input_dev *dev)
 {
+	struct hid_device *hid;
+
+	hid = dev->hid;
+	if (hid)
+		++hid->alan4;
 	if (dev->devres_managed) {
 		WARN_ON(devres_destroy(dev->dev.parent,
 					devm_input_device_unregister,
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
+	int alan1, alan2, alan3, alan4;
 };
 
 #define to_hid_device(pdev) \
Index: usb-devel/include/linux/input.h
===================================================================
--- usb-devel.orig/include/linux/input.h
+++ usb-devel/include/linux/input.h
@@ -22,6 +22,7 @@
 #include <linux/mod_devicetable.h>
 
 struct input_dev_poller;
+struct hid_device;
 
 /**
  * struct input_value - input value representation
@@ -129,6 +130,7 @@ enum input_clock_type {
  *  by a driver
  */
 struct input_dev {
+	struct hid_device *hid;
 	const char *name;
 	const char *phys;
 	const char *uniq;
Index: usb-devel/drivers/hid/wacom_sys.c
===================================================================
--- usb-devel.orig/drivers/hid/wacom_sys.c
+++ usb-devel/drivers/hid/wacom_sys.c
@@ -2017,6 +2017,7 @@ static struct input_dev *wacom_allocate_
 	if (!input_dev)
 		return NULL;
 
+	input_dev->hid = hdev;
 	input_dev->name = wacom_wac->features.name;
 	input_dev->phys = hdev->phys;
 	input_dev->dev.parent = &hdev->dev;
Index: usb-devel/drivers/hid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-core.c
+++ usb-devel/drivers/hid/hid-core.c
@@ -2001,6 +2001,7 @@ EXPORT_SYMBOL_GPL(hid_connect);
 
 void hid_disconnect(struct hid_device *hdev)
 {
+	++hdev->alan2;
 	device_remove_file(&hdev->dev, &dev_attr_country);
 	if (hdev->claimed & HID_CLAIMED_INPUT)
 		hidinput_disconnect(hdev);
@@ -2050,6 +2051,7 @@ EXPORT_SYMBOL_GPL(hid_hw_start);
  */
 void hid_hw_stop(struct hid_device *hdev)
 {
+	++hdev->alan1;
 	hid_disconnect(hdev);
 	hdev->ll_driver->stop(hdev);
 }

