Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1305C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB2020723
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593881127;
	bh=HGwVR1+Rt+My58aR0BObQ8X0y+JOyNAjSNB4lSDQEaU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mXoY09Zvhua1KZHKtDTDyoCwGeB9CY4VGhDnc2VGWrfil/1VslHTpj2TQksUrjUlX
	 0fpbKAbfnLLDlmkWwp+iHJnpn35HtLS4zLOCJowRUiWLsh7kF/18Fw62ajTEu2+r8h
	 +gBU/YPNgAenH7yZmVioEk7zPQ5DyDw2oCEOcAtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGDQpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 12:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgGDQpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 12:45:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4FCA20723;
        Sat,  4 Jul 2020 16:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593881122;
        bh=HGwVR1+Rt+My58aR0BObQ8X0y+JOyNAjSNB4lSDQEaU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tsuczAJRgNh3zSmLzZ0IS6vyP8dDcQdcJGycYdRd+3dfWTxICBITLcFSFTmrlZbu0
         GqJvwimgd6OTUBtshS9C+90VDcnUsqjz3ReavYSe0jSR3Ejg0l2c9qdV2wBwB47Q0C
         DuIDkF7S1Hqd8liX0jV3xK2JbUQKylEKMECb+jKU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A3D2B352265B; Sat,  4 Jul 2020 09:45:22 -0700 (PDT)
Date:   Sat, 4 Jul 2020 09:45:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     syzbot <syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: KASAN: stack-out-of-bounds Read in csd_lock_record
Message-ID: <20200704164522.GO9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <00000000000042f21905a991ecea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000042f21905a991ecea@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 04:31:22PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9e50b94b Add linux-next specific files for 20200703
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1024b405100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
> dashboard link: https://syzkaller.appspot.com/bug?extid=0f719294463916a3fc0e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc490f100000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com

Good catch!  A call to csd_lock_record() was on the wrong side of a
call to csd_unlock().

But is folded into another commit for bisectability reasons, so
"Reported-by" would not make sense.  I have instead added this to the
commit log:

[ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com

							Thanx, Paul

> ==================================================================
> BUG: KASAN: stack-out-of-bounds in csd_lock_record+0xcb/0xe0 kernel/smp.c:118
> Read of size 8 at addr ffffc90001727710 by task syz-executor.0/10721
> 
> CPU: 1 PID: 10721 Comm: syz-executor.0 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
>  csd_lock_record+0xcb/0xe0 kernel/smp.c:118
>  flush_smp_call_function_queue+0x285/0x730 kernel/smp.c:391
>  __sysvec_call_function_single+0x98/0x490 arch/x86/kernel/smp.c:248
>  asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
>  </IRQ>
>  __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
>  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
>  sysvec_call_function_single+0xe0/0x120 arch/x86/kernel/smp.c:243
>  asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:604
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x8c/0xe0 kernel/locking/spinlock.c:191
> Code: 48 c7 c0 00 ff b4 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 37 48 83 3d 9b 74 c8 01 00 74 22 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 95 fb 62 f9 65 8b 05 fe 73 15 78
> RSP: 0018:ffffc900016e7558 EFLAGS: 00000282
> RAX: 1ffffffff1369fe0 RBX: 0000000000000282 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000282
> RBP: ffffffff8cb02508 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 1ffffffff19604a0
> R13: 0000000000000000 R14: dead000000000100 R15: dffffc0000000000
>  __debug_check_no_obj_freed lib/debugobjects.c:977 [inline]
>  debug_check_no_obj_freed+0x20c/0x41c lib/debugobjects.c:998
>  free_pages_prepare mm/page_alloc.c:1219 [inline]
>  __free_pages_ok+0x20b/0xc90 mm/page_alloc.c:1471
>  release_pages+0x5ec/0x17a0 mm/swap.c:880
>  tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
>  tlb_flush_mmu+0xe9/0x6b0 mm/mmu_gather.c:249
>  zap_pte_range mm/memory.c:1155 [inline]
>  zap_pmd_range mm/memory.c:1193 [inline]
>  zap_pud_range mm/memory.c:1222 [inline]
>  zap_p4d_range mm/memory.c:1243 [inline]
>  unmap_page_range+0x1e22/0x2b20 mm/memory.c:1264
>  unmap_single_vma+0x198/0x300 mm/memory.c:1309
>  unmap_vmas+0x16f/0x2f0 mm/memory.c:1341
>  exit_mmap+0x2b1/0x530 mm/mmap.c:3165
>  __mmput+0x122/0x470 kernel/fork.c:1075
>  mmput+0x53/0x60 kernel/fork.c:1096
>  exit_mm kernel/exit.c:483 [inline]
>  do_exit+0xa8f/0x2a40 kernel/exit.c:793
>  do_group_exit+0x125/0x310 kernel/exit.c:904
>  get_signal+0x40b/0x1ee0 kernel/signal.c:2743
>  do_signal+0x82/0x2520 arch/x86/kernel/signal.c:810
>  exit_to_usermode_loop arch/x86/entry/common.c:218 [inline]
>  __prepare_exit_to_usermode+0x156/0x1f0 arch/x86/entry/common.c:252
>  do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:376
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45cb29
> Code: Bad RIP value.
> RSP: 002b:00007fb154b96cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: 0000000000000001 RBX: 000000000078bf08 RCX: 000000000045cb29
> RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000000000078bf0c
> RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
> R13: 00007ffd3933f26f R14: 00007fb154b979c0 R15: 000000000078bf0c
> 
> 
> Memory state around the buggy address:
>  ffffc90001727600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90001727680: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
> >ffffc90001727700: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>                          ^
>  ffffc90001727780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90001727800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
