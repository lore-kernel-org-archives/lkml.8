Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EB4C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21EF20775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgD3O6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:58:36 -0400
Received: from netrider.rowland.org ([192.131.102.5]:45709 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726436AbgD3O6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:58:34 -0400
Received: (qmail 32428 invoked by uid 500); 30 Apr 2020 10:58:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Apr 2020 10:58:33 -0400
Date:   Thu, 30 Apr 2020 10:58:33 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
In-Reply-To: <000000000000927dcc05a476bb41@google.com>
Message-ID: <Pine.LNX.4.44L0.2004301050190.27217-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> WARNING in usbhid_raw_request/usb_submit_urb

Ugh.  I forgot that usbhid also uses usb_control_msg() and 
usb_interrupt_msg().  Those things can't be protected by a spinlock; 
I'll have to add a semaphore.  (A mutex won't work either, because it 
has to be locked in hid_pre_reset() and unlocked in hid_post_reset().)

Alan Stern

#syz test: https://github.com/google/kasan.git 0fa84af8

Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -87,6 +87,7 @@ static int hid_start_in(struct hid_devic
 	if (test_bit(HID_IN_POLLING, &usbhid->iofl) &&
 	    !test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
 	    !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+	    !test_bit(HID_RESET_PENDING, &usbhid->iofl) &&
 	    !test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0) {
@@ -339,6 +340,9 @@ static int hid_submit_out(struct hid_dev
 	struct usbhid_device *usbhid = hid->driver_data;
 	int r;
 
+	if (test_bit(HID_RESET_PENDING, &usbhid->iofl))
+		return -EAGAIN;
+
 	report = usbhid->out[usbhid->outtail].report;
 	raw_report = usbhid->out[usbhid->outtail].raw_report;
 
@@ -370,6 +374,9 @@ static int hid_submit_ctrl(struct hid_de
 	int len, r;
 	struct usbhid_device *usbhid = hid->driver_data;
 
+	if (test_bit(HID_RESET_PENDING, &usbhid->iofl))
+		return -EAGAIN;
+
 	report = usbhid->ctrl[usbhid->ctrltail].report;
 	raw_report = usbhid->ctrl[usbhid->ctrltail].raw_report;
 	dir = usbhid->ctrl[usbhid->ctrltail].dir;
@@ -654,26 +661,37 @@ static int usbhid_wait_io(struct hid_dev
 	return 0;
 }
 
-static int hid_set_idle(struct usb_device *dev, int ifnum, int report, int idle)
+static int hid_set_idle(struct hid_device *hid,
+		struct usb_device *dev, int ifnum, int report, int idle)
 {
-	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+	struct usbhid_device *usbhid = hid->driver_data;
+	int rc;
+
+	down(&usbhid->sem);
+	rc = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 		HID_REQ_SET_IDLE, USB_TYPE_CLASS | USB_RECIP_INTERFACE, (idle << 8) | report,
 		ifnum, NULL, 0, USB_CTRL_SET_TIMEOUT);
+	up(&usbhid->sem);
+	return rc;
 }
 
-static int hid_get_class_descriptor(struct usb_device *dev, int ifnum,
+static int hid_get_class_descriptor(struct hid_device *hid,
+		struct usb_device *dev, int ifnum,
 		unsigned char type, void *buf, int size)
 {
+	struct usbhid_device *usbhid = hid->driver_data;
 	int result, retries = 4;
 
 	memset(buf, 0, size);
 
+	down(&usbhid->sem);
 	do {
 		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
 				USB_REQ_GET_DESCRIPTOR, USB_RECIP_INTERFACE | USB_DIR_IN,
 				(type << 8), ifnum, buf, size, USB_CTRL_GET_TIMEOUT);
 		retries--;
 	} while (result < size && retries);
+	up(&usbhid->sem);
 	return result;
 }
 
@@ -682,16 +700,21 @@ static int usbhid_open(struct hid_device
 	struct usbhid_device *usbhid = hid->driver_data;
 	int res;
 
+	mutex_lock(&usbhid->mutex);
+
 	set_bit(HID_OPENED, &usbhid->iofl);
 
-	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
-		return 0;
+	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
+		res = 0;
+		goto Done;
+	}
 
 	res = usb_autopm_get_interface(usbhid->intf);
 	/* the device must be awake to reliably request remote wakeup */
 	if (res < 0) {
 		clear_bit(HID_OPENED, &usbhid->iofl);
-		return -EIO;
+		res = -EIO;
+		goto Done;
 	}
 
 	usbhid->intf->needs_remote_wakeup = 1;
@@ -725,6 +748,9 @@ static int usbhid_open(struct hid_device
 		msleep(50);
 
 	clear_bit(HID_RESUME_RUNNING, &usbhid->iofl);
+
+ Done:
+	mutex_unlock(&usbhid->mutex);
 	return res;
 }
 
@@ -732,6 +758,8 @@ static void usbhid_close(struct hid_devi
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 
+	mutex_lock(&usbhid->mutex);
+
 	/*
 	 * Make sure we don't restart data acquisition due to
 	 * a resumption we no longer care about by avoiding racing
@@ -743,12 +771,13 @@ static void usbhid_close(struct hid_devi
 		clear_bit(HID_IN_POLLING, &usbhid->iofl);
 	spin_unlock_irq(&usbhid->lock);
 
-	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
-		return;
+	if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL)) {
+		hid_cancel_delayed_stuff(usbhid);
+		usb_kill_urb(usbhid->urbin);
+		usbhid->intf->needs_remote_wakeup = 0;
+	}
 
-	hid_cancel_delayed_stuff(usbhid);
-	usb_kill_urb(usbhid->urbin);
-	usbhid->intf->needs_remote_wakeup = 0;
+	mutex_unlock(&usbhid->mutex);
 }
 
 /*
@@ -877,12 +906,14 @@ static int usbhid_get_raw_report(struct
 		count--;
 		skipped_report_id = 1;
 	}
+	down(&usbhid->sem);
 	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
 		HID_REQ_GET_REPORT,
 		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
 		((report_type + 1) << 8) | report_number,
 		interface->desc.bInterfaceNumber, buf, count,
 		USB_CTRL_SET_TIMEOUT);
+	up(&usbhid->sem);
 
 	/* count also the report id */
 	if (ret > 0 && skipped_report_id)
@@ -914,12 +945,14 @@ static int usbhid_set_raw_report(struct
 		skipped_report_id = 1;
 	}
 
+	down(&usbhid->sem);
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			HID_REQ_SET_REPORT,
 			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
 			((rtype + 1) << 8) | reportnum,
 			interface->desc.bInterfaceNumber, buf, count,
 			USB_CTRL_SET_TIMEOUT);
+	up(&usbhid->sem);
 	/* count also the report id, if this was a numbered report. */
 	if (ret > 0 && skipped_report_id)
 		ret++;
@@ -943,9 +976,11 @@ static int usbhid_output_report(struct h
 		skipped_report_id = 1;
 	}
 
+	down(&usbhid->sem);
 	ret = usb_interrupt_msg(dev, usbhid->urbout->pipe,
 				buf, count, &actual_length,
 				USB_CTRL_SET_TIMEOUT);
+	up(&usbhid->sem);
 	/* return the number of bytes transferred */
 	if (ret == 0) {
 		ret = actual_length;
@@ -1024,9 +1059,10 @@ static int usbhid_parse(struct hid_devic
 	if (!rdesc)
 		return -ENOMEM;
 
-	hid_set_idle(dev, interface->desc.bInterfaceNumber, 0, 0);
+	hid_set_idle(hid, dev, interface->desc.bInterfaceNumber, 0, 0);
 
-	ret = hid_get_class_descriptor(dev, interface->desc.bInterfaceNumber,
+	ret = hid_get_class_descriptor(hid, dev,
+			interface->desc.bInterfaceNumber,
 			HID_DT_REPORT, rdesc, rsize);
 	if (ret < 0) {
 		dbg_hid("reading report descriptor failed\n");
@@ -1057,6 +1093,8 @@ static int usbhid_start(struct hid_devic
 	unsigned int n, insize = 0;
 	int ret;
 
+	mutex_lock(&usbhid->mutex);
+
 	clear_bit(HID_DISCONNECTED, &usbhid->iofl);
 
 	usbhid->bufsize = HID_MIN_BUFFER_SIZE;
@@ -1177,6 +1215,8 @@ static int usbhid_start(struct hid_devic
 		usbhid_set_leds(hid);
 		device_set_wakeup_enable(&dev->dev, 1);
 	}
+
+	mutex_unlock(&usbhid->mutex);
 	return 0;
 
 fail:
@@ -1187,6 +1227,7 @@ fail:
 	usbhid->urbout = NULL;
 	usbhid->urbctrl = NULL;
 	hid_free_buffers(dev, hid);
+	mutex_unlock(&usbhid->mutex);
 	return ret;
 }
 
@@ -1202,6 +1243,8 @@ static void usbhid_stop(struct hid_devic
 		usbhid->intf->needs_remote_wakeup = 0;
 	}
 
+	mutex_lock(&usbhid->mutex);
+
 	clear_bit(HID_STARTED, &usbhid->iofl);
 	spin_lock_irq(&usbhid->lock);	/* Sync with error and led handlers */
 	set_bit(HID_DISCONNECTED, &usbhid->iofl);
@@ -1222,6 +1265,8 @@ static void usbhid_stop(struct hid_devic
 	usbhid->urbout = NULL;
 
 	hid_free_buffers(hid_to_usb_dev(hid), hid);
+
+	mutex_unlock(&usbhid->mutex);
 }
 
 static int usbhid_power(struct hid_device *hid, int lvl)
@@ -1279,7 +1324,7 @@ static int usbhid_idle(struct hid_device
 	if (reqtype != HID_REQ_SET_IDLE)
 		return -EINVAL;
 
-	return hid_set_idle(dev, ifnum, report, idle);
+	return hid_set_idle(hid, dev, ifnum, report, idle);
 }
 
 struct hid_ll_driver usb_hid_driver = {
@@ -1382,6 +1427,8 @@ static int usbhid_probe(struct usb_inter
 	INIT_WORK(&usbhid->reset_work, hid_reset);
 	timer_setup(&usbhid->io_retry, hid_retry_timeout, 0);
 	spin_lock_init(&usbhid->lock);
+	mutex_init(&usbhid->mutex);
+	sema_init(&usbhid->sem, 1);
 
 	ret = hid_add_device(hid);
 	if (ret) {
@@ -1470,6 +1517,8 @@ static int hid_pre_reset(struct usb_inte
 	spin_unlock_irq(&usbhid->lock);
 	hid_cease_io(usbhid);
 
+	down(&usbhid->sem);	/* released in hid_post_reset */
+
 	return 0;
 }
 
@@ -1483,6 +1532,8 @@ static int hid_post_reset(struct usb_int
 	int status;
 	char *rdesc;
 
+	up(&usbhid->sem);	/* acquired in hid_pre_reset */
+
 	/* Fetch and examine the HID report descriptor. If this
 	 * has changed, then rebind. Since usbcore's check of the
 	 * configuration descriptors passed, we already know that
@@ -1492,7 +1543,7 @@ static int hid_post_reset(struct usb_int
 	if (!rdesc)
 		return -ENOMEM;
 
-	status = hid_get_class_descriptor(dev,
+	status = hid_get_class_descriptor(hid, dev,
 				interface->desc.bInterfaceNumber,
 				HID_DT_REPORT, rdesc, hid->dev_rsize);
 	if (status < 0) {
@@ -1512,7 +1563,7 @@ static int hid_post_reset(struct usb_int
 	clear_bit(HID_RESET_PENDING, &usbhid->iofl);
 	clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
 	spin_unlock_irq(&usbhid->lock);
-	hid_set_idle(dev, intf->cur_altsetting->desc.bInterfaceNumber, 0, 0);
+	hid_set_idle(hid, dev, intf->cur_altsetting->desc.bInterfaceNumber, 0, 0);
 
 	hid_restart_io(hid);
 
Index: usb-devel/drivers/hid/usbhid/usbhid.h
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/usbhid.h
+++ usb-devel/drivers/hid/usbhid/usbhid.h
@@ -19,6 +19,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/input.h>
+#include <linux/semaphore.h>
 
 /*  API provided by hid-core.c for USB HID drivers */
 void usbhid_init_reports(struct hid_device *hid);
@@ -80,6 +81,9 @@ struct usbhid_device {
 	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
 	unsigned long last_out;							/* record of last output for timeouts */
 
+	struct mutex mutex;						/* start/stop/open/close */
+	struct semaphore sem;						/* submit/pre_reset/post_reset */
+
 	spinlock_t lock;						/* fifo spinlock */
 	unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
 	struct timer_list io_retry;                                     /* Retry timer */

