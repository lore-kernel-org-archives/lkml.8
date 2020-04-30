Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05891C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E002720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD3PL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:11:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34861 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726620AbgD3PL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:11:56 -0400
Received: (qmail 1363 invoked by uid 500); 30 Apr 2020 11:11:55 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Apr 2020 11:11:55 -0400
Date:   Thu, 30 Apr 2020 11:11:55 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <zaitcev@redhat.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
In-Reply-To: <1588238283.16510.11.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.2004301103500.27217-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, Oliver Neukum wrote:

> Am Dienstag, den 21.04.2020, 08:35 -0700 schrieb syzbot:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=126f75d7e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=be5b5f86a162a6c281e6
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com
> > 
> > usblp0: nonzero read bulk status received: -71
> 
> OK, we have this report and nobody understands it. If I may summarize:
> 
> 1. We do not conclusively know how the URB was submitted
> 2. We are clear about which memory was freed and accessed
> 3. We agree that the URB should have been unlinked

Or should not have been submitted.

> Do we agree on what we agree on?
> 
> Theories:
> 
> A. There is a race that would allow disconnect() and resume() to run
> concurrently
> 
> B. There is a race in usblp which affects 'used'
> 
> C. There is a bug in the virtual driver that can make unlinking an URB
> fail
> 
> What do you think? How to investigate this further and is it worth it?
> Do we have documentation on what KASAN does?

KASAN is documented.  The difficulty is that this race is obviously 
hard to trigger, and without the ability to reproduce it we can't run 
diagnostics to find the underlying cause.

We can't even ask syzbot to try running tests for us; without a valid 
reproducer it won't agree to rerun the original test program.

Alan Stern

