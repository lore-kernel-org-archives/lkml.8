Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5ABC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24D52072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgDHNgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:36:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49847 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbgDHNgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:36:52 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jMAsn-0006xe-Kp; Wed, 08 Apr 2020 15:36:45 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 178F610069D; Wed,  8 Apr 2020 15:36:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, bgeffon@google.com,
        dvhart@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterx@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: general protection fault in get_futex_key
In-Reply-To: <0000000000008250f105a2c4ade1@google.com>
References: <0000000000008250f105a2c4ade1@google.com>
Date:   Wed, 08 Apr 2020 15:36:45 +0200
Message-ID: <87mu7mayky.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com> writes:
> syzbot found the following crash on:
>
> HEAD commit:    763dede1 Merge tag 'for-linus-5.7-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136a055de00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
> dashboard link: https://syzkaller.appspot.com/bug?extid=a95c7753605c9d219466
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1578287de00000
>
> The bug was bisected to:
>
> commit 4426e945df588f2878affddf88a51259200f7e29
> Author: Peter Xu <peterx@redhat.com>
> Date:   Thu Apr 2 04:08:49 2020 +0000
>
>     mm/gup: allow VM_FAULT_RETRY for multiple times
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1707878fe00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1487878fe00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1087878fe00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com
> Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
>
> general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 1 PID: 8869 Comm: syz-executor.1 Not tainted 5.6.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:compound_head include/linux/page-flags.h:174 [inline]
> RIP: 0010:get_futex_key+0x2cd/0x1670 kernel/futex.c:574

This means that

     get_user_pages_fast(address, 1, FOLL_WRITE, &page)

returned 0, which is breaking the interface:

 * Returns number of pages pinned. This may be fewer than the number requested.
 * If nr_pages is 0 or negative, returns 0. If no pages were pinned, returns
 * -errno.

nr_pages is clearly 1. So if the call fails, the number of pinned pages
is 0 and it should return a proper error number. It did before.

From a quick look at the commit in question I assume it's the

+               if (fatal_signal_pending(current))
+                       break;

which can cause that to happen.

Thanks,

        tglx




