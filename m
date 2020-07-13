Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C76C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1092068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGMI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:58:21 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:45613 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgGMI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:58:20 -0400
Received: by mail-il1-f199.google.com with SMTP id c1so9065242ilk.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8B3vMHbPo4VKoNt1QGmUK9ewUHDX7Q5MCfd6Wc4GsAc=;
        b=Et5dAhZdBWKXG05lN1O9WkPIS3TmIHvGXCBAodkDOkmy3zZKzN7qB8OL+C6bSZe/TF
         BZqHSjudOxp1+EAyfhcuyeC/dVgO2zAYdciwkvN7DreX3zKxnhIKSfAys/rm9UlhvZuX
         FkcFsUgh472j3+r2//HGRXCpN080cvGDlJk0XoGPoKY0NthF2yh4UYVsy5V5XmH2raqm
         r9BlJt99SyPszFf/DAk4SwHQtKb1o4P/U/5dZJCHYhCspSlJ0rxAZoW6CiFbSORvSTLa
         Q8yQ7SahmgC9RrPCD01WG7xHhCiXeh3d2XhViu/6o5B4riwCK662L7iFT3cvf909vaar
         yl0w==
X-Gm-Message-State: AOAM5324AWkykVmFLa2UBeLv7QyuG2GF/s7blGFyNLlUDow3GLBQOeQ1
        mMbjJwJdXuxkk/P5UhbWWmqame9XTkBw6FnygmnWvotIIZAK
X-Google-Smtp-Source: ABdhPJxibwMYTn8HfA3GEQ6PS4cPJyQ7BfkyoOyGbeZJ4xu90QorI6xrMAF4EBFZztPPAewc8A3FxPPSUKDU5yC6nUWZydWy2Naz
MIME-Version: 1.0
X-Received: by 2002:a92:c0c9:: with SMTP id t9mr67617115ilf.82.1594630699291;
 Mon, 13 Jul 2020 01:58:19 -0700 (PDT)
Date:   Mon, 13 Jul 2020 01:58:19 -0700
In-Reply-To: <000000000000080a5f05aa4691a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000611e4f05aa4ee40f@google.com>
Subject: Re: BUG: soft lockup in smp_call_function
From:   syzbot <syzbot+cce3691658bef1b12ac9@syzkaller.appspotmail.com>
To:     bp@alien8.de, dvyukov@google.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    4437dd6e Merge tag 'io_uring-5.8-2020-07-12' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15998b47100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=cce3691658bef1b12ac9
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a160bf100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d2bd77100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cce3691658bef1b12ac9@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 123s! [syz-executor644:6902]
Modules linked in:
irq event stamp: 173384
hardirqs last  enabled at (173383): [<ffffffff88000c42>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:587
hardirqs last disabled at (173384): [<ffffffff87e4f2ed>] idtentry_enter_cond_rcu+0x1d/0x50 arch/x86/entry/common.c:649
softirqs last  enabled at (172872): [<ffffffff88200748>] __do_softirq+0x748/0xa60 kernel/softirq.c:319
softirqs last disabled at (172863): [<ffffffff88000f0f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
CPU: 1 PID: 6902 Comm: syz-executor644 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
RIP: 0010:smp_call_function_single+0x192/0x4f0 kernel/smp.c:382
Code: 10 8b 7c 24 1c 48 8d 74 24 40 48 89 44 24 50 48 8b 44 24 08 48 89 44 24 58 e8 fa f9 ff ff 41 89 c5 eb 07 e8 90 00 0b 00 f3 90 <44> 8b 64 24 48 31 ff 41 83 e4 01 44 89 e6 e8 fb fc 0a 00 45 85 e4
RSP: 0018:ffffc900023a7a60 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff92000474f50 RCX: ffffffff8168b985
RDX: ffff8880955564c0 RSI: ffffffff8168b970 RDI: 0000000000000005
RBP: ffffc900023a7b28 R08: 0000000000000001 R09: ffff8880ae636dc7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000040
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c8aa8 CR3: 0000000009a79000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 smp_call_function_many_cond+0x1a4/0x990 kernel/smp.c:518
 __flush_tlb_others arch/x86/include/asm/paravirt.h:74 [inline]
 flush_tlb_others arch/x86/mm/tlb.c:856 [inline]
 flush_tlb_mm_range+0x295/0x4d0 arch/x86/mm/tlb.c:943
 tlb_flush arch/x86/include/asm/tlb.h:24 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:425 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:415 [inline]
 tlb_flush_mmu mm/mmu_gather.c:248 [inline]
 tlb_finish_mmu+0x3e7/0x8c0 mm/mmu_gather.c:328
 exit_mmap+0x2d1/0x510 mm/mmap.c:3152
 __mmput+0x122/0x470 kernel/fork.c:1093
 mmput+0x53/0x60 kernel/fork.c:1114
 exit_mm kernel/exit.c:482 [inline]
 do_exit+0xa8f/0x2a40 kernel/exit.c:792
 do_group_exit+0x125/0x310 kernel/exit.c:903
 __do_sys_exit_group kernel/exit.c:914 [inline]
 __se_sys_exit_group kernel/exit.c:912 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:912
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x442478
Code: Bad RIP value.
RSP: 002b:00007ffeb3621f28 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000442478
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00000000004c8a70 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000001bbbbbb R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006dba40 R14: 0000000000000000 R15: 0000000000000000
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 7110 Comm: kworker/0:0 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: wg-crypt-wg1 wg_packet_tx_worker
RIP: 0010:__lock_is_held kernel/locking/lockdep.c:4733 [inline]
RIP: 0010:lock_is_held_type+0x72/0xe0 kernel/locking/lockdep.c:4996
Code: 00 00 85 c0 7f 0d eb 72 83 c3 01 3b 9d c8 08 00 00 7d 67 48 63 c3 4c 89 e6 48 8d 04 80 4d 8d 74 c5 00 4c 89 f7 e8 1e fe ff ff <85> c0 74 da 8b 4c 24 04 41 bc 01 00 00 00 83 f9 ff 74 11 41 0f b6
RSP: 0018:ffffc90000007d38 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000006 RCX: ffffffff86626577
RDX: dffffc0000000000 RSI: ffff888093ce4300 RDI: ffff888094a20c00
RBP: ffff888094a20240 R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888093ce4300
R13: ffff888094a20b10 R14: ffff888094a20c00 R15: 0000000000000082
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000610 CR3: 000000009e49a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 lock_is_held include/linux/lockdep.h:425 [inline]
 advance_sched+0x638/0x990 net/sched/sch_taprio.c:702
 __run_hrtimer kernel/time/hrtimer.c:1520 [inline]
 __hrtimer_run_queues+0x6a9/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:587
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:seqcount_lockdep_reader_access include/linux/seqlock.h:99 [inline]
RIP: 0010:read_seqcount_begin.constprop.0+0x110/0x1f0 include/linux/seqlock.h:182
Code: 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 d0 00 00 00 48 83 3d 90 ff 44 03 00 0f 84 92 00 00 00 e8 05 d9 03 fb 48 89 df 57 9d <0f> 1f 44 00 00 e8 f6 d8 03 fb 44 8b 25 6f 4a 3f 04 31 ff 44 89 e3
RSP: 0018:ffffc90001b67630 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000293 RCX: 0000000000000003
RDX: ffff888094a20240 RSI: ffffffff866fe0fb RDI: 0000000000000293
RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880941ed2c0
R13: 0000000011108e1c R14: 0000000000000000 R15: dffffc0000000000
 nf_conntrack_get_ht include/net/netfilter/nf_conntrack.h:300 [inline]
 ____nf_conntrack_find net/netfilter/nf_conntrack_core.c:740 [inline]
 __nf_conntrack_find_get+0xcb/0xf30 net/netfilter/nf_conntrack_core.c:778
 resolve_normal_ct net/netfilter/nf_conntrack_core.c:1684 [inline]
 nf_conntrack_in+0x484/0x12a0 net/netfilter/nf_conntrack_core.c:1846
 ipv4_conntrack_local+0x11c/0x220 net/netfilter/nf_conntrack_proto.c:200
 nf_hook_entry_hookfn include/linux/netfilter.h:135 [inline]
 nf_hook_slow+0xc5/0x1e0 net/netfilter/core.c:512
 nf_hook+0x2b8/0x540 include/linux/netfilter.h:262
 __ip_local_out+0x26e/0x530 net/ipv4/ip_output.c:114
 ip_local_out+0x26/0x1a0 net/ipv4/ip_output.c:123
 iptunnel_xmit+0x5a0/0x9b0 net/ipv4/ip_tunnel_core.c:81
 send4+0x4c6/0xd70 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0x192/0x220 drivers/net/wireguard/socket.c:174
 wg_packet_create_data_done drivers/net/wireguard/send.c:252 [inline]
 wg_packet_tx_worker+0x2f9/0x980 drivers/net/wireguard/send.c:280
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 0.000 msecs

