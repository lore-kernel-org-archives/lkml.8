Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7778720866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHGOWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:22:05 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60657 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725815AbgHGOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:22:04 -0400
Received: (qmail 228067 invoked by uid 1000); 7 Aug 2020 10:22:03 -0400
Date:   Fri, 7 Aug 2020 10:22:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+bb9cb5f2cd814f87212a@syzkaller.appspotmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.szyprowski@samsung.com,
        noring@nocrew.org, syzkaller-bugs@googlegroups.com,
        tweek@google.com
Subject: Re: KASAN: use-after-free Read in __usb_hcd_giveback_urb
Message-ID: <20200807142203.GD226516@rowland.harvard.edu>
References: <0000000000004a381905ac444162@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004a381905ac444162@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 12:07:16AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fffe3ae0 Merge tag 'for-linus-hmm' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b22fda900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=226c7a97d80bec54
> dashboard link: https://syzkaller.appspot.com/bug?extid=bb9cb5f2cd814f87212a
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bb9cb5f2cd814f87212a@syzkaller.appspotmail.com
> 
> xpad 3-1:0.65: xpad_irq_in - usb_submit_urb failed with result -19
> xpad 3-1:0.65: xpad_irq_out - usb_submit_urb failed with result -19
> ==================================================================
> BUG: KASAN: use-after-free in register_lock_class+0x12a8/0x1520 kernel/locking/lockdep.c:1250
> Read of size 2 at addr ffff8880a1f5c092 by task systemd-udevd/1571
> 
> CPU: 0 PID: 1571 Comm: systemd-udevd Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
>  print_address_description+0x66/0x5a0 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>  register_lock_class+0x12a8/0x1520 kernel/locking/lockdep.c:1250
>  __lock_acquire+0xfa/0x2ab0 kernel/locking/lockdep.c:4305
>  lock_acquire+0x160/0x730 kernel/locking/lockdep.c:5005
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:159
>  __wake_up_common_lock kernel/sched/wait.c:122 [inline]
>  __wake_up+0xb8/0x150 kernel/sched/wait.c:142
>  __usb_hcd_giveback_urb+0x340/0x4b0 drivers/usb/core/hcd.c:1653

It looks like xpad_disconnect() fails to call xpad_stop_input() if the 
hardware isn't an Xbox 360W.

Alan Stern
