Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B0F206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGHWpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:45:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43220 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgGHWm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:42:26 -0400
Received: by mail-io1-f71.google.com with SMTP id f13so21203iok.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 15:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YAVHDQWX9Zy80Tt5/bk2zqQZXL7ybc6rCSeM/UqaZjQ=;
        b=Oof1eTyQdKmAbqJw6jW9d0/0MdE9pu7671ChWIKhwPH/Xr+/k45E5UNlcqR92f6MR+
         Scw+Ojb2NPDqtt9zL6ZGP4IDEYdh6WRRERKyiSns06zyUrQCE6cTd4N6nJXC2/kxfCW6
         suzTqKXdqiVUwXCxVUcITNN8QO8guG2XrrONRwtv5gxCueVA73wwWUz0sXWlv8Xib4PI
         ku+E7w1fAhcLIPG++6k5vSZ18ZqsdaPckYzagnx36doEnJSPbFYMVSCUfSytufV+5RZQ
         +lBzRe568DenFSy1XYGbavfIaRe4dcO1KUSM6pCQ0skv0OCn3Copwbtc3Erzsipo73KB
         GPtA==
X-Gm-Message-State: AOAM533AT9PtBIggdqcQaHz1NsIxwsd8HbpQJUfITwCzmfRHkLvjOMDq
        nMALaid1GqpLAgOgOyMzmLjoBJGwqpzPx8efgDsXOFs9H1ZR
X-Google-Smtp-Source: ABdhPJz4MV18fZddTUPW7SiO+cL0eoT/vQ9Mkm2FGFzLrmvyiaQCk+of2hIv86TmIEDpQEGGeJq6rXgXAS1KZGOYMAO+VBX2qrYH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d42:: with SMTP id d2mr70749537jak.9.1594248144979;
 Wed, 08 Jul 2020 15:42:24 -0700 (PDT)
Date:   Wed, 08 Jul 2020 15:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d946305a9f5d206@google.com>
Subject: INFO: rcu detected stall in sock_close (3)
From:   syzbot <syzbot+4168fa4c45be33afa73c@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e0a35b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=4168fa4c45be33afa73c
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112223b7100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154793a3100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4168fa4c45be33afa73c@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (1 GPs behind) idle=356/1/0x4000000000000000 softirq=9141/9150 fqs=9 
	(t=10502 jiffies g=6125 q=697)
rcu: rcu_preempt kthread starved for 10435 jiffies! g6125 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
rcu_preempt     I28928    10      2 0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x7d3/0xc40 kernel/sched/core.c:4178
NMI backtrace for cpu 0
CPU: 0 PID: 7615 Comm: syz-executor986 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 nmi_cpu_backtrace+0x9f/0x180 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x199/0x2a0 kernel/rcu/tree_stall.h:320
 print_cpu_stall kernel/rcu/tree_stall.h:553 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
 rcu_pending kernel/rcu/tree.c:3489 [inline]
 rcu_sched_clock_irq+0x1928/0x1eb0 kernel/rcu/tree.c:2504
 update_process_times+0x12c/0x180 kernel/time/timer.c:1726
 tick_sched_handle kernel/time/tick-sched.c:176 [inline]
 tick_sched_timer+0x254/0x410 kernel/time/tick-sched.c:1320
 __run_hrtimer kernel/time/hrtimer.c:1520 [inline]
 __hrtimer_run_queues+0x42d/0x930 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x373/0xd60 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf0/0x260 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xb9/0x130 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:rcu_lock_acquire+0x1a/0x30 include/linux/rcupdate.h:241
Code: 3c 24 e8 49 3c d6 f9 48 8b 14 24 e9 3a fe ff ff e8 eb 3c 97 f9 e8 e6 3c 97 f9 48 c7 c7 90 94 2e 89 31 f6 31 d2 b9 02 00 00 00 <45> 31 c0 45 31 c9 68 25 3f dd 87 e8 06 4c 7c f9 48 83 c4 08 c3 90
RSP: 0018:ffffc90003536fd0 EFLAGS: 00000246
RAX: ffffffff87dd3f2a RBX: ffff8880949f0140 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff892e9490
RBP: 0000000004dad81c R08: dffffc0000000000 R09: fffffbfff12da576
R10: fffffbfff12da576 R11: 0000000000000000 R12: ffff888096d4c000
R13: dffffc0000000000 R14: ffffc9000353702c R15: 0000000004dad81c
 rcu_read_lock include/linux/rcupdate.h:634 [inline]
 tipc_sk_lookup+0x85/0x7c0 net/tipc/socket.c:2970
 tipc_sk_rcv+0x2b8/0x1940 net/tipc/socket.c:2461
 tipc_node_xmit+0x257/0x10d0 net/tipc/node.c:1652
 tipc_node_xmit_skb+0x110/0x150 net/tipc/node.c:1712
 tipc_sk_rcv+0x16f4/0x1940 net/tipc/socket.c:2491
 tipc_node_xmit+0x257/0x10d0 net/tipc/node.c:1652
 tipc_sk_push_backlog net/tipc/socket.c:1303 [inline]
 tipc_sk_filter_connect net/tipc/socket.c:2226 [inline]
 tipc_sk_filter_rcv+0x1660/0x3ca0 net/tipc/socket.c:2335
 tipc_sk_enqueue net/tipc/socket.c:2415 [inline]
 tipc_sk_rcv+0x6e1/0x1940 net/tipc/socket.c:2466
 tipc_node_xmit+0x257/0x10d0 net/tipc/node.c:1652
 tipc_node_xmit_skb net/tipc/node.c:1712 [inline]
 tipc_node_distr_xmit+0x2c7/0x3e0 net/tipc/node.c:1727
 tipc_sk_backlog_rcv+0x12f/0x1b0 net/tipc/socket.c:2383
 sk_backlog_rcv include/net/sock.h:996 [inline]
 __release_sock+0x1b2/0x480 net/core/sock.c:2550
 release_sock+0x5d/0x1c0 net/core/sock.c:3066
 tipc_release+0x1182/0x1440 net/tipc/socket.c:638
 __sock_release net/socket.c:605 [inline]
 sock_close+0xd8/0x260 net/socket.c:1278
 __fput+0x2f0/0x750 fs/file_table.c:281
 task_work_run+0x137/0x1c0 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:216 [inline]
 __prepare_exit_to_usermode+0x14c/0x1e0 arch/x86/entry/common.c:246
 do_syscall_64+0x7f/0xe0 arch/x86/entry/common.c:368
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446b59
Code: Bad RIP value.
RSP: 002b:00007ff651764d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000021
RAX: 0000000000000004 RBX: 00000000006dbc48 RCX: 0000000000446b59
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00000000006dbc40 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc4c
R13: 00007ff651764d90 R14: 0000000000000007 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
