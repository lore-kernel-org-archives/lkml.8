Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A0FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F23920737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbgDBPfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:35:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:55419 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2389328AbgDBPfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:35:25 -0400
Received: (qmail 21183 invoked by uid 500); 2 Apr 2020 11:35:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Apr 2020 11:35:24 -0400
Date:   Thu, 2 Apr 2020 11:35:23 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
In-Reply-To: <0000000000001873a005a240d114@google.com>
Message-ID: <Pine.LNX.4.44L0.2004021133440.13377-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=12aa8567e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
> dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1342740be00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 2-1: BOGUS urb xfer, pipe 2 != type 2
> WARNING: CPU: 0 PID: 9241 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478

At last!  Let's get some more information about this...

Alan Stern

#syz test: https://github.com/google/kasan.git 0fa84af8

Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -475,8 +475,9 @@ int usb_submit_urb(struct urb *urb, gfp_
 
 	/* Check that the pipe's type matches the endpoint's type */
 	if (usb_urb_ep_type_check(urb))
-		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
-			usb_pipetype(urb->pipe), pipetypes[xfertype]);
+		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x, ep addr 0x%02x, pipe 0x%x, xfertype %d\n",
+			usb_pipetype(urb->pipe), pipetypes[xfertype],
+			ep->desc.bEndpointAddress, urb->pipe, xfertype);
 
 	/* Check against a simple/standard policy */
 	allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |

