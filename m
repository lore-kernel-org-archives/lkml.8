Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98803C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB3C206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594139173;
	bh=ZvUrfcm60ZHaW+qZX/r/NNe6UN5DDwjnLORsrUs42uk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=adjCNEBj9zjwhllLLiQu8czicqgmZa3bH4SOW5CQTzbD1D9rbvgIkUzkU00J9sHml
	 EIgbygTE2DawRmQpQZeI5hNBtz9U5mv4v8sEuHG33TUFjIQB4YezeqsAClkBXQE2e2
	 udpEcD8PwwEQW5CdLFDn1zIGhEJ6hQ0juDiIqlAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGGQ0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgGGQ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:26:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB5520675;
        Tue,  7 Jul 2020 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594139170;
        bh=ZvUrfcm60ZHaW+qZX/r/NNe6UN5DDwjnLORsrUs42uk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VuZ3/QkLFQiNXS+Cgh9V50n3cJcE1L1l2DN2vBzuE405iWRanidX29OOvjY2HM4G0
         U7YlP1SsYDLvKNULKxEldcsPg9S4OsH5RvKV4xOZ8MYh3HJ5upoba3LsPZUALwdnXM
         Az4jrhoeY/znkusETstblT2GgulYjlHFCkcve3Kw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 575F23523339; Tue,  7 Jul 2020 09:26:10 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:26:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: KASAN: stack-out-of-bounds Read in csd_lock_record
Message-ID: <20200707162610.GY9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <00000000000042f21905a991ecea@google.com>
 <20200704164522.GO9247@paulmck-ThinkPad-P72>
 <CACT4Y+Zs4TO9-XSZ7cRXFZVqRakS8WuSno2=dac6Gv2XmExbkA@mail.gmail.com>
 <CACT4Y+aMJRwQANQZ5Fr1RPZ6EOZ2zEPaZwMTndKJ+mTJ8o6b7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aMJRwQANQZ5Fr1RPZ6EOZ2zEPaZwMTndKJ+mTJ8o6b7Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:51:48PM +0200, Dmitry Vyukov wrote:
> On Sat, Jul 4, 2020 at 8:34 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Sat, Jul 4, 2020 at 6:45 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Jul 03, 2020 at 04:31:22PM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    9e50b94b Add linux-next specific files for 20200703
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1024b405100000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0f719294463916a3fc0e
> > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc490f100000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com
> > >
> > > Good catch!  A call to csd_lock_record() was on the wrong side of a
> > > call to csd_unlock().
> >
> > Thanks for taking a look.
> >
> > > But is folded into another commit for bisectability reasons, so
> > > "Reported-by" would not make sense.  I have instead added this to the
> > > commit log:
> > >
> > > [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
> > > Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
> > > Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
> >
> > This should work, as far as I remember sybot looks for the email+hash
> > anywhere in the commit.
> > FWIW Tested-by can make sense as well.
> 
> Paul, there is also some spike of stalls in smp_call_function,
> if you look at the top ones at:
> https://syzkaller.appspot.com/upstream#open
> 
> Can these be caused by the same root cause?
> I am not sure what trees the bug was/is present... This seems to only
> happen on linux-next and nowhere else. But these stalls equally happen
> on mainline...

I would be surprised, given that the csd_unlock() was before the faulting
reference.  But then again, I have been surprised before.

You aren't running scftorture with its longwait parameter set to a
non-zero value, are you?  In that case, stalls are expected behavior.
This is to support test the CSD lock diagnostics in -rcu.  Which isn't
in mainline yet, so maybe I am asking a stupid question.

If these are repeatable, one thing to try is to build the kernel with
CSD_LOCK_WAIT_DEBUG=y.  This requires c6c67d89c059 ("smp: Add source and
destination CPUs to __call_single_data") and 216d15e0d870 ("kernel/smp:
Provide CSD lock timeout diagnostics") from the -rcu tree's "dev" branch.
This will dump out the smp_call_function() function that was to be
invoked, on the off-chance that the problem is something like lock
contention in that function.

							Thanx, Paul

> > > > ==================================================================
> > > > BUG: KASAN: stack-out-of-bounds in csd_lock_record+0xcb/0xe0 kernel/smp.c:118
> > > > Read of size 8 at addr ffffc90001727710 by task syz-executor.0/10721
> > > >
> > > > CPU: 1 PID: 10721 Comm: syz-executor.0 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > Call Trace:
> > > >  <IRQ>
> > > >  __dump_stack lib/dump_stack.c:77 [inline]
> > > >  dump_stack+0x18f/0x20d lib/dump_stack.c:118
> > > >  print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
> > > >  __kasan_report mm/kasan/report.c:513 [inline]
> > > >  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
> > > >  csd_lock_record+0xcb/0xe0 kernel/smp.c:118
> > > >  flush_smp_call_function_queue+0x285/0x730 kernel/smp.c:391
> > > >  __sysvec_call_function_single+0x98/0x490 arch/x86/kernel/smp.c:248
> > > >  asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
> > > >  </IRQ>
> > > >  __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
> > > >  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
> > > >  sysvec_call_function_single+0xe0/0x120 arch/x86/kernel/smp.c:243
> > > >  asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:604
> > > > RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
> > > > RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
> > > > RIP: 0010:_raw_spin_unlock_irqrestore+0x8c/0xe0 kernel/locking/spinlock.c:191
> > > > Code: 48 c7 c0 00 ff b4 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 37 48 83 3d 9b 74 c8 01 00 74 22 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 95 fb 62 f9 65 8b 05 fe 73 15 78
> > > > RSP: 0018:ffffc900016e7558 EFLAGS: 00000282
> > > > RAX: 1ffffffff1369fe0 RBX: 0000000000000282 RCX: 0000000000000000
> > > > RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000282
> > > > RBP: ffffffff8cb02508 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000001 R11: 0000000000000000 R12: 1ffffffff19604a0
> > > > R13: 0000000000000000 R14: dead000000000100 R15: dffffc0000000000
> > > >  __debug_check_no_obj_freed lib/debugobjects.c:977 [inline]
> > > >  debug_check_no_obj_freed+0x20c/0x41c lib/debugobjects.c:998
> > > >  free_pages_prepare mm/page_alloc.c:1219 [inline]
> > > >  __free_pages_ok+0x20b/0xc90 mm/page_alloc.c:1471
> > > >  release_pages+0x5ec/0x17a0 mm/swap.c:880
> > > >  tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
> > > >  tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
> > > >  tlb_flush_mmu+0xe9/0x6b0 mm/mmu_gather.c:249
> > > >  zap_pte_range mm/memory.c:1155 [inline]
> > > >  zap_pmd_range mm/memory.c:1193 [inline]
> > > >  zap_pud_range mm/memory.c:1222 [inline]
> > > >  zap_p4d_range mm/memory.c:1243 [inline]
> > > >  unmap_page_range+0x1e22/0x2b20 mm/memory.c:1264
> > > >  unmap_single_vma+0x198/0x300 mm/memory.c:1309
> > > >  unmap_vmas+0x16f/0x2f0 mm/memory.c:1341
> > > >  exit_mmap+0x2b1/0x530 mm/mmap.c:3165
> > > >  __mmput+0x122/0x470 kernel/fork.c:1075
> > > >  mmput+0x53/0x60 kernel/fork.c:1096
> > > >  exit_mm kernel/exit.c:483 [inline]
> > > >  do_exit+0xa8f/0x2a40 kernel/exit.c:793
> > > >  do_group_exit+0x125/0x310 kernel/exit.c:904
> > > >  get_signal+0x40b/0x1ee0 kernel/signal.c:2743
> > > >  do_signal+0x82/0x2520 arch/x86/kernel/signal.c:810
> > > >  exit_to_usermode_loop arch/x86/entry/common.c:218 [inline]
> > > >  __prepare_exit_to_usermode+0x156/0x1f0 arch/x86/entry/common.c:252
> > > >  do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:376
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > RIP: 0033:0x45cb29
> > > > Code: Bad RIP value.
> > > > RSP: 002b:00007fb154b96cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > > > RAX: 0000000000000001 RBX: 000000000078bf08 RCX: 000000000045cb29
> > > > RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000000000078bf0c
> > > > RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
> > > > R13: 00007ffd3933f26f R14: 00007fb154b979c0 R15: 000000000078bf0c
> > > >
> > > >
> > > > Memory state around the buggy address:
> > > >  ffffc90001727600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >  ffffc90001727680: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
> > > > >ffffc90001727700: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
> > > >                          ^
> > > >  ffffc90001727780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >  ffffc90001727800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > ==================================================================
> > > >
> > > >
> > > > ---
> > > > This bug is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this bug report. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > syzbot can test patches for this bug, for details see:
> > > > https://goo.gl/tpsmEJ#testing-patches
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200704164522.GO9247%40paulmck-ThinkPad-P72.
