Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F685C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7507D20781
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgDXTOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:14:16 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39615 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727021AbgDXTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:14:16 -0400
Received: (qmail 24942 invoked by uid 500); 24 Apr 2020 15:14:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2020 15:14:15 -0400
Date:   Fri, 24 Apr 2020 15:14:15 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
In-Reply-To: <000000000000535b2805a40b1847@google.com>
Message-ID: <Pine.LNX.4.44L0.2004241456070.17162-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> INFO: task hung in usb_disable_device

That wasn't what I expected.  Still, the important information was
present: The reset was instigated by hid_io_error(), because of some 
sort of communication error.

Note that the hid_submit_out, hid_submit_ctrl, and so on don't test the
RESET_PENDING flag.  At least, not with any proper synchronization.  
That's why we got an URB submitted while the device was being reset.

Nevertheless, the USB core should be able to handle such things without 
a big WARNing, particularly for ep0.  The patch below tries to do this.

Alan Stern

#syz test: https://github.com/google/kasan.git 0fa84af8

Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -204,8 +204,17 @@ int usb_urb_ep_type_check(const struct u
 	const struct usb_host_endpoint *ep;
 
 	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
-	if (!ep)
-		return -EINVAL;
+	if (!ep) {
+		/*
+		 * Special case: The pointers for ep0 are temporarily cleared
+		 * during device resets.  We won't count this as an error;
+		 * drivers can reasonably expect that ep0 always exists.
+		 */
+		if (usb_pipeendpoint(urb->pipe) == 0)
+			ep = &urb->dev->ep0;
+		else
+			return -EINVAL;
+	}
 	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
 		return -EINVAL;
 	return 0;

