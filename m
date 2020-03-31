Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0BCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64693207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GhnxmH2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgCaJ5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:57:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42880 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iOKElgmkO7oC+ndGm2kOhGae8J3RZLJOYtpE5DlQ7Tc=; b=GhnxmH2v4xs6HeVqibsU//Qus8
        HHcERa/r0hxFhrSPffCRqR3ExQACaXp4XksYvwq3fAIlkK9wfl1ydB2+BULoeFY+uLBMbkBrqwwk7
        EXo/EV9zlA1cGi8oKBSIobst9kQSFCe04i6J4UOaHbgm9vsI1qA+qPmLML/tBp+1FvCns/lNImPL+
        nKEmoU9D9Nl8FmPqZotmU344Vb9SeTkpVMieQRlTN+EP9FDUn4IBWXvzIV2y90KRjHi72FVYMCMJh
        f7yUQaTcNIFhS7eT9zT4c+9zZ2manT/pjouyjMKRx8G6gN1jHLrlEYPMzADTzbY/C5NZhgeTZhuKz
        pc/5OX+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJDeN-0005Ta-MN; Tue, 31 Mar 2020 09:57:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 304603012D8;
        Tue, 31 Mar 2020 11:57:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A70A29C6922A; Tue, 31 Mar 2020 11:57:37 +0200 (CEST)
Date:   Tue, 31 Mar 2020 11:57:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: INFO: trying to register non-static key in try_to_wake_up
Message-ID: <20200331095737.GO20730@hirez.programming.kicks-ass.net>
References: <000000000000ec257905a21f7415@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ec257905a21f7415@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:01:12PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9420e8ad Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1206ed4be00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
> dashboard link: https://syzkaller.appspot.com/bug?extid=e84d7ebd1361da13c356
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com
> 
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
> CPU: 1 PID: 1014 Comm: syz-executor.0 Not tainted 5.6.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  assign_lock_key kernel/locking/lockdep.c:880 [inline]
>  register_lock_class+0x14c4/0x1540 kernel/locking/lockdep.c:1189
>  __lock_acquire+0xfc/0x3ca0 kernel/locking/lockdep.c:3836
>  lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
>  try_to_wake_up+0x9f/0x17c0 kernel/sched/core.c:2547

That's p->pi_lock, which gets initialized in rt_mutex_init_task() in
copy_process(). This should be impossible. Very odd.

>  wake_up_worker kernel/workqueue.c:836 [inline]
>  insert_work+0x2ad/0x3a0 kernel/workqueue.c:1337
>  __queue_work+0x50d/0x1280 kernel/workqueue.c:1488
>  call_timer_fn+0x195/0x760 kernel/time/timer.c:1404
>  expire_timers kernel/time/timer.c:1444 [inline]
>  __run_timers kernel/time/timer.c:1773 [inline]
>  __run_timers kernel/time/timer.c:1740 [inline]
>  run_timer_softirq+0x412/0x1600 kernel/time/timer.c:1786
>  __do_softirq+0x26c/0x99d kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0x192/0x1d0 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
>  smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1146
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>  </IRQ>
