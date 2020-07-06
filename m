Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941F2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7381720771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgGFPMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:12:40 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48859 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgGFPM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:12:26 -0400
Received: by mail-il1-f199.google.com with SMTP id q9so3020274ilt.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JkU0lao4/IkSsyRhcYdB51wFLxb5ARkkIuBwGmS7HmU=;
        b=BHoDtt+jsFWIWCnyYNofSoGzEb1p6AqG6PPIJyN9pCyVyw0JN+F3p2XIjdjDd4BSzH
         mY0R6STIgVRMeuTZ9pJiXqght7Z2pQL9Aj+4nGuQltnkmp+TpFKjWwb6KBjD0tAJLK+W
         tjDZJDyl1spFMMbxQ95Scp1jq9+90OJ8Ty6NvwIc7oFqupQRnEDSPZWTcqE/KUY7buLf
         wgZq/KY3QuBDhZHue5IsJOWXe0dI2YoFGiXbtGi9zgMZ0GF4LiJHZlftYSqQvpYrdddb
         ppgVmOGhb2d//LBRPVa/AGRRNaPJO2IgrikHmXxbDGZb3jxpgqQ9jtfsaUM32dry/loX
         cO5Q==
X-Gm-Message-State: AOAM5317yHEeX9/dHnsWpav+sO2XYIxeB8gdwXUX5Q5c21sQ+OwYPEOR
        +RSuhg+18gsnZm2srYUHhUMtKByWO/0Tr3cJ1601/HlmlAbK
X-Google-Smtp-Source: ABdhPJz6azTDG/zGsriMjg6uGeHR36klZjSmNl60RHO8fB+5sy25NdJd8FhdytzdW1yHtbMOu3370WC7/vpvFs7RiCDMMWgx2oLV
MIME-Version: 1.0
X-Received: by 2002:a92:d186:: with SMTP id z6mr32769691ilz.227.1594048344507;
 Mon, 06 Jul 2020 08:12:24 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:12:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000544c3105a9c74dc4@google.com>
Subject: INFO: rcu detected stall in run_timer_softirq (3)
From:   syzbot <syzbot+8878cb4b6ee2945a51a6@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0a679e13 Merge branch 'for-5.6-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f70aa1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=735296e4dd620b10
dashboard link: https://syzkaller.appspot.com/bug?extid=8878cb4b6ee2945a51a6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8878cb4b6ee2945a51a6@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (1 GPs behind) idle=18e/1/0x4000000000000004 softirq=258758/258759 fqs=0 
	(t=10501 jiffies g=344461 q=14)
rcu: rcu_preempt kthread starved for 10502 jiffies! g344461 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29264    10      2 0x80004000
Call Trace:
 context_switch kernel/sched/core.c:3386 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4082
 schedule+0xdc/0x2b0 kernel/sched/core.c:4156
 schedule_timeout+0x486/0xc50 kernel/time/timer.c:1895
 rcu_gp_fqs_loop kernel/rcu/tree.c:1658 [inline]
 rcu_gp_kthread+0xa10/0x1940 kernel/rcu/tree.c:1818
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 0
CPU: 0 PID: 14248 Comm: syz-executor.4 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
 arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x183/0x1cf kernel/rcu/tree_stall.h:254
 print_cpu_stall kernel/rcu/tree_stall.h:475 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:549 [inline]
 rcu_pending kernel/rcu/tree.c:3030 [inline]
 rcu_sched_clock_irq.cold+0x51a/0xc37 kernel/rcu/tree.c:2276
 update_process_times+0x2d/0x70 kernel/time/timer.c:1726
 tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:171
 tick_sched_timer+0x53/0x140 kernel/time/tick-sched.c:1314
 __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
 __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1579
 hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1641
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1119 [inline]
 smp_apic_timer_interrupt+0x160/0x610 arch/x86/kernel/apic/apic.c:1144
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
RIP: 0010:expire_timers kernel/time/timer.c:1450 [inline]
RIP: 0010:__run_timers kernel/time/timer.c:1773 [inline]
RIP: 0010:__run_timers kernel/time/timer.c:1740 [inline]
RIP: 0010:run_timer_softirq+0x6cd/0x1790 kernel/time/timer.c:1786
Code: ff e8 57 49 10 00 4c 89 f7 e8 7f 8d 89 06 48 8b 95 10 ff ff ff 48 89 de 4c 89 e7 e8 fd c1 ff ff 48 8b 85 20 ff ff ff 80 38 00 <0f> 85 3e 0e 00 00 49 c7 46 38 00 00 00 00 4c 89 f7 e8 1d 8f 89 06
RSP: 0018:ffffc90000007de8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffffed1015d04e87 RBX: ffffffff86511890 RCX: ffffffff81650902
RDX: 0000000000000100 RSI: ffffffff81650960 RDI: 0000000000000004
RBP: ffffc90000007f08 R08: ffff8880326f60c0 R09: ffff8880326f6950
R10: fffffbfff154b438 R11: ffffffff8aa5a1c7 R12: ffff8880a7a00c10
R13: ffff8880a7a00c18 R14: ffff8880ae827400 R15: dffffc0000000000
 __do_softirq+0x262/0x98c kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x19b/0x1e0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1146
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:153 [inline]
RIP: 0010:write_comp_data+0x9/0x70 kernel/kcov.c:208
Code: 13 00 00 8b 80 84 13 00 00 48 8b 11 48 83 c2 01 48 39 d0 76 07 48 89 34 d1 48 89 11 5d c3 0f 1f 00 65 4c 8b 04 25 c0 1e 02 00 <65> 8b 05 28 90 8c 7e a9 00 01 1f 00 75 51 41 8b 80 80 13 00 00 83
RSP: 0018:ffffc9000614f180 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000002 RBX: 0000000000000002 RCX: ffffffff86707f51
RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000005
RBP: ffffc9000614f1a0 R08: ffff8880326f60c0 R09: fffffbfff16a3382
R10: fffffbfff16a3381 R11: ffffffff8b519c0f R12: ffffffff88fdcfc0
R13: 0000000000000003 R14: ffff88808941bdc0 R15: dffffc0000000000
 nf_hook_slow+0xd1/0x1e0 net/netfilter/core.c:513
 nf_hook include/linux/netfilter.h:262 [inline]
 __ip_local_out+0x403/0x870 net/ipv4/ip_output.c:114
 ip_local_out+0x2d/0x1b0 net/ipv4/ip_output.c:123
 __ip_queue_xmit+0x878/0x1c20 net/ipv4/ip_output.c:530
 sctp_v4_xmit+0x1a8/0x200 net/sctp/protocol.c:981
 sctp_packet_transmit+0x1ba6/0x3740 net/sctp/output.c:629
 sctp_outq_flush_transports net/sctp/outqueue.c:1147 [inline]
 sctp_outq_flush+0x2b8/0x2780 net/sctp/outqueue.c:1195
 sctp_outq_uncork+0x6c/0x80 net/sctp/outqueue.c:758
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1793 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1185 [inline]
 sctp_do_sm+0x50d/0x5330 net/sctp/sm_sideeffect.c:1156
 sctp_primitive_REQUESTHEARTBEAT+0xa0/0xd0 net/sctp/primitive.c:185
 sctp_apply_peer_addr_params+0x114/0x1f20 net/sctp/socket.c:2430
 sctp_setsockopt_peer_addr_params+0x4c7/0x590 net/sctp/socket.c:2684
 sctp_setsockopt net/sctp/socket.c:4716 [inline]
 sctp_setsockopt+0x2321/0x7350 net/sctp/socket.c:4655
 sock_common_setsockopt+0x94/0xd0 net/core/sock.c:3149
 __sys_setsockopt+0x261/0x4c0 net/socket.c:2130
 __do_sys_setsockopt net/socket.c:2146 [inline]
 __se_sys_setsockopt net/socket.c:2143 [inline]
 __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2143
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b3b9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6fef7b7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f6fef7b86d4 RCX: 000000000045b3b9
RDX: 0000000000000009 RSI: 0000000000000084 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 000000000000009c R09: 0000000000000000
R10: 0000000020000300 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000a9f R14: 00000000004d5208 R15: 000000000075bfd4


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
