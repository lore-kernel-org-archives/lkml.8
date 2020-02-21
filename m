Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38842C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B02824650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgBUQl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:41:29 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:54178 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726758AbgBUQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:41:29 -0500
Received: (qmail 4340 invoked by uid 2102); 21 Feb 2020 11:41:28 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Feb 2020 11:41:28 -0500
Date:   Fri, 21 Feb 2020 11:41:28 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+55ae006e0a1feae5aeab@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <balbi@kernel.org>,
        <chunfeng.yun@mediatek.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in dummy_free_request
In-Reply-To: <000000000000058a87059f1882b9@google.com>
Message-ID: <Pine.LNX.4.44L0.2002211138300.1488-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7f0cd6c7 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b58e5ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f10b12ae04e03319
> dashboard link: https://syzkaller.appspot.com/bug?extid=55ae006e0a1feae5aeab
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+55ae006e0a1feae5aeab@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 19332 at drivers/usb/gadget/udc/dummy_hcd.c:679 dummy_free_request+0x6c/0x80 drivers/usb/gadget/udc/dummy_hcd.c:679
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 19332 Comm: syz-executor.5 Not tainted 5.6.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xef/0x16e lib/dump_stack.c:118
>  panic+0x2aa/0x6e1 kernel/panic.c:221
>  __warn.cold+0x2f/0x30 kernel/panic.c:582
>  report_bug+0x27b/0x2f0 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
>  fixup_bug arch/x86/kernel/traps.c:169 [inline]
>  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
>  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:dummy_free_request+0x6c/0x80 drivers/usb/gadget/udc/dummy_hcd.c:679
> Code: c5 75 22 e8 26 06 96 fd 48 89 ef e8 3e 54 be fd 5b 5d e9 17 06 96 fd e8 12 06 96 fd 0f 0b 5b 5d e9 09 06 96 fd e8 04 06 96 fd <0f> 0b eb d5 48 89 ef e8 08 ae be fd eb c2 66 0f 1f 44 00 00 41 56
> RSP: 0018:ffff8881c9eafdd8 EFLAGS: 00010016
> RAX: 0000000000040000 RBX: ffff8881d0d5aa10 RCX: ffffc900012a0000
> RDX: 000000000000012f RSI: ffffffff83a95c1c RDI: ffff8881d4d501c8
> RBP: ffff8881d0d5aa00 R08: ffff8881d0f9b100 R09: ffffed103b666a84
> R10: ffffed103b666a83 R11: ffff8881db33541b R12: 0000000000000212
> R13: ffff8881ca832008 R14: 0000000000000000 R15: ffff8881ca832180
>  raw_ioctl_ep_disable drivers/usb/gadget/legacy/raw_gadget.c:814 [inline]
>  raw_ioctl+0x1281/0x19e0 drivers/usb/gadget/legacy/raw_gadget.c:1031

Andrey:

This could be a bug in your raw_gadget driver.  This particular WARN is
triggered when a gadget driver tries to call usb_ep_free_request() for
a request that is still in flight.

Alan Stern

