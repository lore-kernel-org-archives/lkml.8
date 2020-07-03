Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3691C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5A520724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGCXbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 19:31:36 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37434 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgGCXbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 19:31:23 -0400
Received: by mail-io1-f70.google.com with SMTP id 63so14618774ioy.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 16:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Zg/KjGKrgLl4/rcCACz51UBoJr9BArkr1+G+mT4xy+o=;
        b=fS9FHvyzVqyxJlmCxd9Q6Fmq3aLey8pylRVGvpyAd2dbVFsty/HZ/ZhomvywwHK092
         D5lpvxnnYw4XzXWWu7dlMKA56lKCFxxsAmGomUjKYQY86w3AgI7kppuISth4saUGvMAW
         BK21YxKk6hqU1wqRKiUMBPpZmEdjzbzZl5Z06U2L9d96Db41Lsbcq6oD7CIo22hhR68O
         4PMtAUF7ub8FfLuy+rGdQqoxNGHUnpU33zdrTGOOPEftBmn/qAvhJAfFfniqsk1pex5p
         It7uWnifaEdtcz/dzKw+s4hrgiT2zoynENa4yKOPf+O2TL28m6rBZjJ3YjFVEz/mFPo4
         laAA==
X-Gm-Message-State: AOAM53079tNylLn59rAi4Ol3K9xZ7Bi5tQ6pPvLddHm2xx4C0VfckCnc
        ulr6IxCwtG81xldY/5eAXrap7ueTJqfksQlOGKxh46+lhylp
X-Google-Smtp-Source: ABdhPJyOmOgJOHY7W3x/7bq65ZTvpa8JHDSssd9Dl41U82690Gd125TsTSN1BrEg+twfFIznmXvlgtDlJK9zy1jA8ploYPQ72k5z
MIME-Version: 1.0
X-Received: by 2002:a5d:80d2:: with SMTP id h18mr14619903ior.73.1593819082714;
 Fri, 03 Jul 2020 16:31:22 -0700 (PDT)
Date:   Fri, 03 Jul 2020 16:31:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042f21905a991ecea@google.com>
Subject: KASAN: stack-out-of-bounds Read in csd_lock_record
From:   syzbot <syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1024b405100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=0f719294463916a3fc0e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc490f100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in csd_lock_record+0xcb/0xe0 kernel/smp.c:118
Read of size 8 at addr ffffc90001727710 by task syz-executor.0/10721

CPU: 1 PID: 10721 Comm: syz-executor.0 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 csd_lock_record+0xcb/0xe0 kernel/smp.c:118
 flush_smp_call_function_queue+0x285/0x730 kernel/smp.c:391
 __sysvec_call_function_single+0x98/0x490 arch/x86/kernel/smp.c:248
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_call_function_single+0xe0/0x120 arch/x86/kernel/smp.c:243
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:604
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x8c/0xe0 kernel/locking/spinlock.c:191
Code: 48 c7 c0 00 ff b4 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 37 48 83 3d 9b 74 c8 01 00 74 22 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 95 fb 62 f9 65 8b 05 fe 73 15 78
RSP: 0018:ffffc900016e7558 EFLAGS: 00000282
RAX: 1ffffffff1369fe0 RBX: 0000000000000282 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000282
RBP: ffffffff8cb02508 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 1ffffffff19604a0
R13: 0000000000000000 R14: dead000000000100 R15: dffffc0000000000
 __debug_check_no_obj_freed lib/debugobjects.c:977 [inline]
 debug_check_no_obj_freed+0x20c/0x41c lib/debugobjects.c:998
 free_pages_prepare mm/page_alloc.c:1219 [inline]
 __free_pages_ok+0x20b/0xc90 mm/page_alloc.c:1471
 release_pages+0x5ec/0x17a0 mm/swap.c:880
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0xe9/0x6b0 mm/mmu_gather.c:249
 zap_pte_range mm/memory.c:1155 [inline]
 zap_pmd_range mm/memory.c:1193 [inline]
 zap_pud_range mm/memory.c:1222 [inline]
 zap_p4d_range mm/memory.c:1243 [inline]
 unmap_page_range+0x1e22/0x2b20 mm/memory.c:1264
 unmap_single_vma+0x198/0x300 mm/memory.c:1309
 unmap_vmas+0x16f/0x2f0 mm/memory.c:1341
 exit_mmap+0x2b1/0x530 mm/mmap.c:3165
 __mmput+0x122/0x470 kernel/fork.c:1075
 mmput+0x53/0x60 kernel/fork.c:1096
 exit_mm kernel/exit.c:483 [inline]
 do_exit+0xa8f/0x2a40 kernel/exit.c:793
 do_group_exit+0x125/0x310 kernel/exit.c:904
 get_signal+0x40b/0x1ee0 kernel/signal.c:2743
 do_signal+0x82/0x2520 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop arch/x86/entry/common.c:218 [inline]
 __prepare_exit_to_usermode+0x156/0x1f0 arch/x86/entry/common.c:252
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:376
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb29
Code: Bad RIP value.
RSP: 002b:00007fb154b96cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 000000000078bf08 RCX: 000000000045cb29
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000000000078bf0c
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
R13: 00007ffd3933f26f R14: 00007fb154b979c0 R15: 000000000078bf0c


Memory state around the buggy address:
 ffffc90001727600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001727680: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
>ffffc90001727700: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
                         ^
 ffffc90001727780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001727800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
