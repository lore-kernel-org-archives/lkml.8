Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E892AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADD020724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgGFPNN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:13:13 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:54595 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgGFPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:12:24 -0400
Received: by mail-il1-f200.google.com with SMTP id d18so28032791ill.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=ctAYq16hPcWvuyiEeS5FsLH4JX7ZkLpLcd5Nukl4ddo=;
        b=XkKPQrr8Yseo8N/tE0Q9sYPZPAdjDNkna6WPp2Qk/jNUbzVYhDgjPr+LMBpWgVOYnj
         fNsTuwtCwYwcVEOP3mb2hJ/fSIEIula7UjYl9q/pUPUvxA2TvgJmhQrgc+hyWas1sYCu
         +COShqnz4EeK8p9EXii/zUNTBygSJhp8iCM66hd2pD8WQZUunWbUVN7CB7/CXP1s/a3s
         SKr9oFRcaEnjed5bCSxksMNVGbw22n8eXXgKrL1oFICNTKjfzvDSt8mWsjzVPfRibHEt
         8WpyUNuUN0VlasQ9t+5bo3gvyzYpiTKAgxtni2OVMW1TIE7N82sW/TRA2OZLDfHahq7F
         Ok7A==
X-Gm-Message-State: AOAM533wCk1L2d9KNzndj6wBxkKm5+FEbkgkRq57qb8DqYxyT1D/ZIKC
        kbSLfw60uEwZMpLnmLHJOPsnLTbxQz1yGOVq4IKHMHfus8Ly
X-Google-Smtp-Source: ABdhPJwjcTKy/Mza1luKTq45c1/O+hD8FkVxQI2965n8hxGJPQPt2IakjY7zTlJON9WqvIoAAQBgqFjdOEXrNu68/7NZRRqxa4MB
MIME-Version: 1.0
X-Received: by 2002:a6b:c910:: with SMTP id z16mr25532524iof.120.1594048341973;
 Mon, 06 Jul 2020 08:12:21 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:12:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002da9cd05a9c74d87@google.com>
Subject: INFO: rcu detected stall in input_repeat_key
From:   syzbot <syzbot+33510b19568e6f5f59c9@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cd77006e Merge tag 'hyperv-fixes-signed' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cab5e3100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=33510b19568e6f5f59c9
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+33510b19568e6f5f59c9@syzkaller.appspotmail.com

Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (1 GPs behind) idle=dce/1/0x4000000000000000 softirq=17877/17879 fqs=281 
	(t=10527 jiffies g=25105 q=17491)
NMI backtrace for cpu 1
CPU: 1 PID: 11062 Comm: systemd-udevd Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x194/0x1cf kernel/rcu/tree_stall.h:320
 print_cpu_stall kernel/rcu/tree_stall.h:553 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
 rcu_pending kernel/rcu/tree.c:3489 [inline]
 rcu_sched_clock_irq.cold+0x5b3/0xccc kernel/rcu/tree.c:2504
 update_process_times+0x25/0x60 kernel/time/timer.c:1726
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:176
 tick_sched_timer+0x108/0x290 kernel/time/tick-sched.c:1320
 __run_hrtimer kernel/time/hrtimer.c:1520 [inline]
 __hrtimer_run_queues+0x1d5/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:50 [inline]
 sysvec_apic_timer_interrupt+0x4f/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x8c/0xe0 kernel/locking/spinlock.c:191
Code: 48 c7 c0 40 e0 b4 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 37 48 83 3d fb a6 cd 01 00 74 22 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 f5 38 68 f9 65 8b 05 5e c5 1a 78
RSP: 0018:ffffc90000da8c78 EFLAGS: 00000282
RAX: 1ffffffff1369c08 RBX: 0000000000000282 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000282
RBP: ffff88805ae58218 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000282
R13: ffff88805ae58218 R14: 0000000000000021 R15: ffff88805ae58108
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 input_repeat_key+0x118/0x380 drivers/input/input.c:201
 call_timer_fn+0x1ac/0x760 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers.part.0+0x54c/0xa20 kernel/time/timer.c:1773
 __run_timers kernel/time/timer.c:1745 [inline]
 run_timer_softirq+0xae/0x1a0 kernel/time/timer.c:1786
 __do_softirq+0x34c/0xa60 kernel/softirq.c:292
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 do_softirq_own_stack+0x111/0x170 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:387 [inline]
 __irq_exit_rcu kernel/softirq.c:417 [inline]
 irq_exit_rcu+0x229/0x270 kernel/softirq.c:429
 sysvec_apic_timer_interrupt+0x54/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x0/0x20 kernel/kcov.c:270
Code: 66 2e 0f 1f 84 00 00 00 00 00 48 8b 0c 24 48 89 f2 48 89 fe bf 06 00 00 00 e9 0c ff ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 00 <48> 8b 0c 24 40 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 e9 ea fe ff ff
RSP: 0018:ffffc900019178f8 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff83626447
RDX: ffff888094b54380 RSI: 0000000000000005 RDI: 0000000000000010
RBP: ffff8880a1c04b80 R08: 0000000000000001 R09: ffffffff8cab9727
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000026
R13: 00000000000003bb R14: dffffc0000000000 R15: 0000000000000000
 tomoyo_domain_quota_is_ok+0x32a/0x550 security/tomoyo/util.c:1070
 tomoyo_supervisor+0x2d4/0xeb0 security/tomoyo/common.c:2089
 tomoyo_audit_path_number_log security/tomoyo/file.c:235 [inline]
 tomoyo_path_number_perm+0x3ed/0x4d0 security/tomoyo/file.c:734
 security_path_chmod+0xe0/0x150 security/security.c:1151
 chmod_common+0x156/0x3f0 fs/open.c:588
 ksys_fchmod+0xc4/0x130 fs/open.c:612
 __do_sys_fchmod fs/open.c:620 [inline]
 __se_sys_fchmod fs/open.c:618 [inline]
 __x64_sys_fchmod+0x53/0x80 fs/open.c:618
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7efc9d4b05c7
Code: Bad RIP value.
RSP: 002b:00007ffe166a5b38 EFLAGS: 00000206 ORIG_RAX: 000000000000005b
RAX: ffffffffffffffda RBX: 0000555da3989660 RCX: 00007efc9d4b05c7
RDX: 0000000000000000 RSI: 00000000000001a4 RDI: 000000000000000f
RBP: 00007ffe166a5c00 R08: 0000555da397a470 R09: 0000000000000230
R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffe166a5b40
R13: 0000000000000001 R14: 0000000000000000 R15: 000000000000000e
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52748 isolated_file:0
 unevictable:0 dirty:84 writeback:1307
 slab_reclaimable:19170 slab_unreclaimable:125559
 mapped:63669 shmem:7246 pagetables:1018 bounce:0
 free:1120796 free_pcp:315 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:210992kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254676kB dirty:332kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:702036kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:210992kB unevictable:0kB writepending:5556kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1312kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7207*4kB (UME) 605*8kB (UME) 67*16kB (UME) 178*32kB (UME) 62*64kB (UME) 18*128kB (UM) 8*256kB (UME) 6*512kB (UM) 5*1024kB (ME) 17*2048kB (UM) 149*4096kB (M) = 702068kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54643 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52748 isolated_file:0
 unevictable:0 dirty:84 writeback:1307
 slab_reclaimable:19170 slab_unreclaimable:125809
 mapped:63669 shmem:7246 pagetables:1018 bounce:0
 free:1120547 free_pcp:322 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254744kB dirty:404kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:701780kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB writepending:5628kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1280kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7207*4kB (UME) 619*8kB (UME) 45*16kB (UME) 178*32kB (UME) 63*64kB (UME) 20*128kB (UM) 7*256kB (ME) 6*512kB (UM) 5*1024kB (ME) 17*2048kB (UM) 149*4096kB (M) = 701892kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54658 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52763 isolated_file:0
 unevictable:0 dirty:102 writeback:1307
 slab_reclaimable:19171 slab_unreclaimable:125877
 mapped:63686 shmem:7246 pagetables:1018 bounce:0
 free:1120483 free_pcp:314 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254744kB dirty:404kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:701572kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB writepending:5628kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1220kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7207*4kB (UME) 630*8kB (UME) 31*16kB (UME) 179*32kB (UME) 62*64kB (UME) 19*128kB (UM) 7*256kB (ME) 6*512kB (UM) 5*1024kB (ME) 17*2048kB (UM) 149*4096kB (M) = 701596kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54658 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52763 isolated_file:0
 unevictable:0 dirty:102 writeback:1307
 slab_reclaimable:19171 slab_unreclaimable:125920
 mapped:63686 shmem:7246 pagetables:1018 bounce:0
 free:1120431 free_pcp:300 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254744kB dirty:404kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:701260kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB writepending:5628kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1156kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7207*4kB (UME) 605*8kB (UME) 26*16kB (ME) 177*32kB (UME) 61*64kB (ME) 20*128kB (UM) 7*256kB (ME) 6*512kB (UM) 5*1024kB (ME) 17*2048kB (UM) 149*4096kB (M) = 701316kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54658 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52763 isolated_file:0
 unevictable:0 dirty:102 writeback:1307
 slab_reclaimable:19171 slab_unreclaimable:126018
 mapped:63686 shmem:7246 pagetables:1018 bounce:0
 free:1120353 free_pcp:283 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254792kB dirty:452kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:701756kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB writepending:5676kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1104kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7207*4kB (UME) 648*8kB (UME) 27*16kB (UME) 176*32kB (ME) 61*64kB (ME) 18*128kB (UM) 7*256kB (ME) 6*512kB (UM) 5*1024kB (ME) 17*2048kB (UM) 149*4096kB (M) = 701388kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54670 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52763 isolated_file:0
 unevictable:0 dirty:114 writeback:1307
 slab_reclaimable:19172 slab_unreclaimable:125878
 mapped:63698 shmem:7246 pagetables:1018 bounce:0
 free:1120434 free_pcp:319 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254792kB dirty:452kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:701168kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB writepending:5676kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1260kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7081*4kB (UME) 641*8kB (UME) 31*16kB (UME) 180*32kB (UME) 62*64kB (UME) 17*128kB (M) 7*256kB (ME) 5*512kB (M) 5*1024kB (ME) 17*2048kB (UM) 149*4096kB (M) = 700444kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54670 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52763 isolated_file:0
 unevictable:0 dirty:114 writeback:1307
 slab_reclaimable:19172 slab_unreclaimable:125892
 mapped:63698 shmem:7246 pagetables:1018 bounce:0
 free:1120363 free_pcp:361 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254792kB dirty:452kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:700884kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB writepending:5676kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1428kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7081*4kB (UME) 642*8kB (UME) 27*16kB (UME) 177*32kB (UME) 63*64kB (UME) 20*128kB (UM) 8*256kB (UME) 6*512kB (UM) 6*1024kB (UME) 16*2048kB (M) 149*4096kB (M) = 700484kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54670 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52763 isolated_file:0
 unevictable:0 dirty:114 writeback:1307
 slab_reclaimable:19172 slab_unreclaimable:126012
 mapped:63698 shmem:7246 pagetables:1018 bounce:0
 free:1120259 free_pcp:342 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254792kB dirty:452kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:700468kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211052kB unevictable:0kB writepending:5676kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1356kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7081*4kB (UME) 616*8kB (UME) 30*16kB (UME) 181*32kB (UME) 63*64kB (UME) 19*128kB (UM) 7*256kB (ME) 6*512kB (UM) 6*1024kB (UME) 16*2048kB (M) 149*4096kB (M) = 700068kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54670 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52788 isolated_file:0
 unevictable:0 dirty:114 writeback:1307
 slab_reclaimable:19172 slab_unreclaimable:126080
 mapped:63698 shmem:7246 pagetables:1018 bounce:0
 free:1120207 free_pcp:327 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211152kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254792kB dirty:452kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:700260kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211152kB unevictable:0kB writepending:5676kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1288kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7081*4kB (UME) 665*8kB (UME) 28*16kB (UME) 178*32kB (UME) 62*64kB (UME) 18*128kB (UM) 8*256kB (UME) 5*512kB (M) 6*1024kB (UME) 16*2048kB (M) 149*4096kB (M) = 699884kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54670 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52788 isolated_file:0
 unevictable:0 dirty:114 writeback:1307
 slab_reclaimable:19172 slab_unreclaimable:126178
 mapped:63698 shmem:7246 pagetables:1018 bounce:0
 free:1120129 free_pcp:310 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211152kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254792kB dirty:452kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:699844kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211152kB unevictable:0kB writepending:5676kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1228kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7081*4kB (UME) 604*8kB (ME) 47*16kB (UME) 179*32kB (UME) 61*64kB (ME) 18*128kB (UM) 7*256kB (ME) 5*512kB (M) 6*1024kB (UME) 16*2048kB (M) 149*4096kB (M) = 699412kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54695 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52788 isolated_file:0
 unevictable:0 dirty:139 writeback:1307
 slab_reclaimable:19172 slab_unreclaimable:126296
 mapped:63698 shmem:7246 pagetables:1018 bounce:0
 free:1119980 free_pcp:355 free_cma:0
Node 0 active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211152kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254792kB dirty:552kB writeback:5224kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:699248kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657412kB inactive_anon:28096kB active_file:24468kB inactive_file:211152kB unevictable:0kB writepending:5824kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1404kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7018*4kB (UME) 604*8kB (ME) 30*16kB (UME) 179*32kB (UME) 63*64kB (UME) 18*128kB (UM) 8*256kB (UME) 6*512kB (UM) 5*1024kB (ME) 16*2048kB (M) 149*4096kB (M) = 698760kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54695 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164353 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52788 isolated_file:0
 unevictable:0 dirty:139 writeback:1307
 slab_reclaimable:19172 slab_unreclaimable:126550
 mapped:63698 shmem:7246 pagetables:1018 bounce:0
 free:1119746 free_pcp:348 free_cma:0
Node 0 active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254888kB dirty:344kB writeback:5448kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:698432kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB writepending:5792kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1340kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7018*4kB (UME) 604*8kB (ME) 37*16kB (UME) 177*32kB (UME) 64*64kB (UME) 17*128kB (M) 7*256kB (ME) 6*512kB (UM) 5*1024kB (ME) 16*2048kB (M) 149*4096kB (M) = 698488kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54699 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164354 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52804 isolated_file:0
 unevictable:0 dirty:87 writeback:1363
 slab_reclaimable:19173 slab_unreclaimable:126183
 mapped:63722 shmem:7246 pagetables:1018 bounce:0
 free:1120088 free_pcp:331 free_cma:0
Node 0 active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254888kB dirty:344kB writeback:5448kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:699992kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB writepending:5792kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1288kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7018*4kB (UME) 741*8kB (UME) 33*16kB (UME) 179*32kB (UME) 66*64kB (UME) 18*128kB (UM) 8*256kB (UME) 6*512kB (UM) 5*1024kB (ME) 16*2048kB (M) 149*4096kB (M) = 700096kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54699 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164354 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52804 isolated_file:0
 unevictable:0 dirty:87 writeback:1363
 slab_reclaimable:19173 slab_unreclaimable:126254
 mapped:63722 shmem:7246 pagetables:1018 bounce:0
 free:1120036 free_pcp:317 free_cma:0
Node 0 active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254888kB dirty:344kB writeback:5448kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:699784kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB writepending:5792kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1236kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7018*4kB (UME) 670*8kB (UME) 51*16kB (UME) 179*32kB (UME) 66*64kB (UME) 18*128kB (UM) 8*256kB (UME) 6*512kB (UM) 5*1024kB (ME) 16*2048kB (M) 149*4096kB (M) = 699816kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54699 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164354 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52804 isolated_file:0
 unevictable:0 dirty:87 writeback:1363
 slab_reclaimable:19173 slab_unreclaimable:126324
 mapped:63722 shmem:7246 pagetables:1018 bounce:0
 free:1119984 free_pcp:303 free_cma:0
Node 0 active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254920kB dirty:412kB writeback:5448kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:699504kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB writepending:5860kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1188kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7018*4kB (UME) 616*8kB (UME) 40*16kB (UME) 179*32kB (UME) 67*64kB (UME) 18*128kB (UM) 9*256kB (UME) 6*512kB (UM) 5*1024kB (ME) 16*2048kB (M) 149*4096kB (M) = 699528kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54713 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164354 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52804 isolated_file:0
 unevictable:0 dirty:104 writeback:1363
 slab_reclaimable:19174 slab_unreclaimable:126433
 mapped:63730 shmem:7246 pagetables:1018 bounce:0
 free:1119888 free_pcp:294 free_cma:0
Node 0 active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254920kB dirty:412kB writeback:5448kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:699192kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB writepending:5860kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1124kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 7018*4kB (UME) 687*8kB (UME) 39*16kB (UME) 178*32kB (UME) 62*64kB (UME) 18*128kB (UM) 7*256kB (ME) 6*512kB (UM) 5*1024kB (ME) 16*2048kB (M) 149*4096kB (M) = 699216kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54713 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164354 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52804 isolated_file:0
 unevictable:0 dirty:104 writeback:1363
 slab_reclaimable:19174 slab_unreclaimable:126478
 mapped:63730 shmem:7246 pagetables:1018 bounce:0
 free:1119836 free_pcp:276 free_cma:0
Node 0 active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254920kB dirty:412kB writeback:5448kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:698716kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB writepending:5860kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1320kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6955*4kB (UME) 652*8kB (UME) 40*16kB (UME) 178*32kB (UME) 62*64kB (UME) 18*128kB (UM) 7*256kB (ME) 6*512kB (UM) 5*1024kB (ME) 16*2048kB (M) 149*4096kB (M) = 698700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 1 Normal: 87*4kB (UM) 227*8kB (UME) 179*16kB (UME) 90*32kB (UME) 44*64kB (UME) 22*128kB (UME) 6*256kB (U) 3*512kB (U) 2*1024kB (ME) 3*2048kB (UME) 913*4096kB (M) = 3764452kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
54713 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1965979 pages RAM
0 pages HighMem/MovableOnly
349903 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:164354 inactive_anon:7024 isolated_anon:0
 active_file:6152 inactive_file:52804 isolated_file:0
 unevictable:0 dirty:104 writeback:1363
 slab_reclaimable:19174 slab_unreclaimable:126548
 mapped:63730 shmem:7246 pagetables:1018 bounce:0
 free:1119691 free_pcp:324 free_cma:0
Node 0 active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:254920kB dirty:412kB writeback:5448kB shmem:28984kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 544768kB writeback_tmp:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:4kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
Node 0 DMA free:15908kB min:220kB low:272kB high:324kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2515 2515 2515 2515
Node 0 DMA32 free:698612kB min:35916kB low:44892kB high:53868kB reserved_highatomic:0KB active_anon:657416kB inactive_anon:28096kB active_file:24468kB inactive_file:211216kB unevictable:0kB writepending:5860kB present:3129332kB managed:2578196kB mlocked:0kB kernel_stack:8688kB pagetables:4072kB bounce:0kB free_pcp:1260kB local_pcp:856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:786432kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3764452kB min:53972kB low:67464kB high:80956kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:140kB inactive_file:0kB unevictable:0kB writepending:8kB present:3932160kB managed:3870200kB mlocked:0kB kernel_stack:16kB pagetables:0kB bounce:0kB free_pcp:

---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
