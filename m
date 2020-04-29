Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD0EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9352072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgD2XlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:41:05 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47261 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726481AbgD2XlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:41:05 -0400
Received: (qmail 7909 invoked by uid 500); 29 Apr 2020 19:41:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Apr 2020 19:41:03 -0400
Date:   Wed, 29 Apr 2020 19:41:03 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
In-Reply-To: <0000000000001aa0e705a473d05c@google.com>
Message-ID: <Pine.LNX.4.44L0.2004291940080.7441-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com

Good.  Here's an improved version of the patch.

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

