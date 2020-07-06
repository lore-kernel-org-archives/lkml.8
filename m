Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A71C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C605206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgGFPM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:12:27 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39497 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgGFPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:12:22 -0400
Received: by mail-io1-f72.google.com with SMTP id r19so23723766iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bbivP/yGFggX5iHVp3nG11qK97t01sd4KjSPDzR1zD8=;
        b=oMNbK2sJG87L8SHLbh8XTaqcCOgIfRqUXr7z5vpzC9WK9sAFIKDfHQIpzRcN38H1sW
         I+Hlkd4MMD2HJYMgS2YexWxtE9klvw9MizUnWQ2SG7Bna1NjKf+s03KAlPcg0Wo8GxSK
         ipNd2PjGTLO2keTmH7tIcn3+14PW4q1OEuqZyavCMNMYCb/B2AKKuWPwK1EIZGWFRj7K
         T/oUznXXsNcOelHcUxlh8n5HUaop3bPWky+mm8QZgFG/8lKZDOXDoH+ByGVr9XprS+bP
         PCVO58Uy6XVWYDUqUSGgcVkeqGRhIy87F03zcfhP7bqq4Tnt2TFDdUUCIP2AcYPMs5Yx
         yCfA==
X-Gm-Message-State: AOAM530xnYjMbeUwPgd3jO4f0XI4Y9B6LAqGvflUsZhfvs+wQgoD9hnF
        WfxgD/PfwaEQJRM9uvp9CnHCEs8zwqAeklF94nFJvDLSEPkn
X-Google-Smtp-Source: ABdhPJwIflZhmfHUyV8+uLIZecs7Ss1Bs4SY+IFQQCmbDHhOmIYBx5YiFuYuw63bEmQTTAafYWKvEi+UwX7HMr05f6QlsIpJPiUG
MIME-Version: 1.0
X-Received: by 2002:a92:154a:: with SMTP id v71mr16885248ilk.23.1594048341493;
 Mon, 06 Jul 2020 08:12:21 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:12:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000264c6305a9c74d9b@google.com>
Subject: INFO: rcu detected stall in tipc_release
From:   syzbot <syzbot+3654c027d861c6df4b06@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1018035b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=3654c027d861c6df4b06
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12948233100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11344c05100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3654c027d861c6df4b06@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (1 GPs behind) idle=2c6/1/0x4000000000000000 softirq=8594/8600 fqs=12 
	(t=10501 jiffies g=7945 q=771)
rcu: rcu_preempt kthread starved for 10429 jiffies! g7945 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
rcu_preempt     I29120    10      2 0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x8e1/0x1eb0 kernel/sched/core.c:4178
 schedule+0xd0/0x2a0 kernel/sched/core.c:4253
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1897
 rcu_gp_fqs_loop kernel/rcu/tree.c:1874 [inline]
 rcu_gp_kthread+0xae5/0x1b50 kernel/rcu/tree.c:2044
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
NMI backtrace for cpu 1
CPU: 1 PID: 6855 Comm: syz-executor167 Not tainted 5.8.0-rc3-syzkaller #0
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
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:lock_release+0x481/0x8d0 kernel/locking/lockdep.c:4980
Code: 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 7f 03 00 00 48 83 3d 2b d7 5a 08 00 0f 84 a9 01 00 00 48 8b 3c 24 57 9d <0f> 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 48 01 c5 48 c7 45 00
RSP: 0018:ffffc90001776cd0 EFLAGS: 00000282
RAX: 1ffffffff1369c08 RBX: ffff8880972f25c0 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff89bc1180 RDI: 0000000000000282
RBP: 1ffff920002eed9c R08: 0000000000000001 R09: ffff8880972f2e88
R10: fffffbfff155cb29 R11: 0000000000000000 R12: 0000000000000003
R13: ffffffff87a707d5 R14: 0000000000000004 R15: ffff8880972f25c0
 rcu_lock_release include/linux/rcupdate.h:246 [inline]
 rcu_read_unlock include/linux/rcupdate.h:688 [inline]
 tipc_sk_lookup+0x607/0xab0 net/tipc/socket.c:2974
 tipc_sk_rcv+0x27a/0x1ec0 net/tipc/socket.c:2461
 tipc_node_xmit+0x2b0/0xce0 net/tipc/node.c:1652
 tipc_node_xmit_skb+0xd5/0x140 net/tipc/node.c:1712
 tipc_sk_rcv+0x1754/0x1ec0 net/tipc/socket.c:2491
 tipc_node_xmit+0x2b0/0xce0 net/tipc/node.c:1652
 tipc_sk_push_backlog+0x324/0x790 net/tipc/socket.c:1303
 tipc_sk_filter_connect net/tipc/socket.c:2226 [inline]
 tipc_sk_filter_rcv+0xafe/0x3250 net/tipc/socket.c:2335
 tipc_sk_enqueue net/tipc/socket.c:2415 [inline]
 tipc_sk_rcv+0xd1a/0x1ec0 net/tipc/socket.c:2466
 tipc_node_xmit+0x2b0/0xce0 net/tipc/node.c:1652
 tipc_node_xmit_skb net/tipc/node.c:1712 [inline]
 tipc_node_distr_xmit+0x15c/0x3a0 net/tipc/node.c:1727
 tipc_sk_backlog_rcv+0x155/0x1c0 net/tipc/socket.c:2383
 sk_backlog_rcv include/net/sock.h:996 [inline]
 __release_sock+0x134/0x3a0 net/core/sock.c:2550
 release_sock+0x54/0x1b0 net/core/sock.c:3066
 tipc_release+0xbb1/0x1a70 net/tipc/socket.c:638
 __sock_release+0xcd/0x280 net/socket.c:605
 sock_close+0x18/0x20 net/socket.c:1278
 __fput+0x33c/0x880 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:216 [inline]
 __prepare_exit_to_usermode+0x1e9/0x1f0 arch/x86/entry/common.c:246
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:368
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446df9
Code: Bad RIP value.
RSP: 002b:00007f4766792cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000021
RAX: 0000000000000005 RBX: 00007f4766792cc0 RCX: 0000000000446df9
RDX: 0000000000000001 RSI: 0000000000000005 RDI: 0000000000000003
RBP: 0000000000000006 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dcc5c
R13: 00007fff2c969dbf R14: 00007f47667939c0 R15: 20c49ba5e353f7cf


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
