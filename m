Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B9F22206
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGNKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:53:23 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:35949 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgGNKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:53:20 -0400
Received: by mail-il1-f200.google.com with SMTP id t19so11714510ili.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 03:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iRs24tcD1P4dlY+zcNJWn0VqS3RZ4LbVY2WFSI+Y6xc=;
        b=iiqQeLBQnd1+mMyJfyXOEaJWQxTFR/OlkCVSX0VMn9S5zYmgkcHhEahPJ/HL6JXNNu
         mPN/+QwWdIJ3j5IcWEVxa79cH/9RKzNkLPjukM1SMf9ESY/5kxJhoACQZTSx813wkapq
         +8qVPDEjgI/lZL7qW4P3/haK68WDWQP5VgfamR9FyWK5ZvwXpSlp1b0v67SKy8p9/2tl
         x31SeMz0kYRETKIb0ay9+/EZkD3FcG0ANbVjsVG5ehqWeXxk3ovB4i7BAi2xD6Vv9Xjz
         S1r5F3wWBfPUKJUf89vmOlM28T8TtIo6KBQZwnoXvE/JTfLk5rPVOPdW8SEm5IgDpAV0
         2iWA==
X-Gm-Message-State: AOAM533vnIA4JO2Rq1FMzaVvYNYWoSthkuGCxIod27Sh8P52xrzWzDIT
        F3KmOetR+dt7IwVEbqc8sX166SNJtDsV+wjZXONQLP2CcjMj
X-Google-Smtp-Source: ABdhPJwurBsquextw7rry73ghyCAVuIgIu9Qc3oa/TRRUiTW9R9R2Gz4oYUpgos3+N9mcUNp8D/B7euU8IghL5Hqe8pkEyJcAwKB
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d52:: with SMTP id d18mr5442820jak.21.1594723999495;
 Tue, 14 Jul 2020 03:53:19 -0700 (PDT)
Date:   Tue, 14 Jul 2020 03:53:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081412705aa649deb@google.com>
Subject: INFO: rcu detected stall in pfkey_sendmsg (2)
From:   syzbot <syzbot+1ffacdc3e8cc60303b4e@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    be978f8f Add linux-next specific files for 20200713
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c5468b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f90bd54d8a9a6104
dashboard link: https://syzkaller.appspot.com/bug?extid=1ffacdc3e8cc60303b4e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1ffacdc3e8cc60303b4e@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (1 GPs behind) idle=84a/1/0x4000000000000000 softirq=24372/24373 fqs=5236 
	(t=10502 jiffies g=37585 q=10697)
NMI backtrace for cpu 1
CPU: 1 PID: 13505 Comm: syz-executor.0 Not tainted 5.8.0-rc4-next-20200713-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:165 [inline]
 rcu_dump_cpu_stacks+0x194/0x1cf kernel/rcu/tree_stall.h:318
 print_cpu_stall kernel/rcu/tree_stall.h:551 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:625 [inline]
 rcu_pending kernel/rcu/tree.c:3626 [inline]
 rcu_sched_clock_irq.cold+0x5b3/0xcbd kernel/rcu/tree.c:2509
 update_process_times+0x25/0x60 kernel/time/timer.c:1726
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:176
 tick_sched_timer+0x108/0x290 kernel/time/tick-sched.c:1328
 __run_hrtimer kernel/time/hrtimer.c:1520 [inline]
 __hrtimer_run_queues+0x1d5/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1079 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1096
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1090
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:587
RIP: 0010:ipv6_addr_equal include/net/ipv6.h:579 [inline]
RIP: 0010:xfrm6_addr_equal include/net/xfrm.h:1699 [inline]
RIP: 0010:__xfrm6_tunnel_spi_lookup+0x23f/0x3b0 net/ipv6/xfrm6_tunnel.c:82
Code: 4d 85 e4 74 53 e8 01 78 7b fa 49 8d 7c 24 20 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 2d 01 00 00 4d 8b 7c 24 20 49 8d 7c 24 28 <48> 89 f8 48 c1 e8 03 4d 31 f7 80 3c 28 00 0f 85 05 01 00 00 49 8b
RSP: 0018:ffffc9000d5a7580 EFLAGS: 00000246
RAX: 1ffff1101347618e RBX: cc5e8ead76490000 RCX: ffffc90001db9000
RDX: 0000000000040000 RSI: ffffffff86f8b96f RDI: ffff88809a3b0c78
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880a86a2990
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88809a3b0c50
R13: cc5e8ead06000000 R14: 0000000074490000 R15: 0000000000000000
 xfrm6_tunnel_spi_lookup+0x8a/0x1d0 net/ipv6/xfrm6_tunnel.c:95
 ipcomp6_tunnel_attach net/ipv6/ipcomp6.c:119 [inline]
 ipcomp6_init_state net/ipv6/ipcomp6.c:159 [inline]
 ipcomp6_init_state+0x1de/0x700 net/ipv6/ipcomp6.c:139
 __xfrm_init_state+0x9a6/0x14b0 net/xfrm/xfrm_state.c:2498
 xfrm_init_state+0x1a/0x70 net/xfrm/xfrm_state.c:2525
 pfkey_msg2xfrm_state net/key/af_key.c:1291 [inline]
 pfkey_add+0x1a10/0x2b70 net/key/af_key.c:1508
 pfkey_process+0x66d/0x7a0 net/key/af_key.c:2834
 pfkey_sendmsg+0x42d/0x800 net/key/af_key.c:3673
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x331/0x810 net/socket.c:2363
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2417
 __sys_sendmmsg+0x195/0x480 net/socket.c:2507
 __do_sys_sendmmsg net/socket.c:2536 [inline]
 __se_sys_sendmmsg net/socket.c:2533 [inline]
 __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2533
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cba9
Code: Bad RIP value.
RSP: 002b:00007f108b804c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00000000004fe340 RCX: 000000000045cba9
RDX: 0000000000000393 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000919 R14: 00000000004cbed9 R15: 00007f108b8056d4


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
