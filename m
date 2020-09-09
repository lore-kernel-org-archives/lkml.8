Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D16C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DF3218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgIIIuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:50:10 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:44302 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgIIItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:49:24 -0400
Received: by mail-il1-f208.google.com with SMTP id j11so1495241ilr.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JfkNq80Dk3uc55OgtR+0hbcYPp7gH6wqCqGFt13tHpE=;
        b=I7fZu6E+EPvz/c/jfktk3AkhM5Xm9nZAe7o9NKwlZ9/fT9H+yA6Zos3Jck1dKeTfqw
         R1tZ4Twxb0V0B+Xmh0tugKD/RakOFF/yUYXZVPlWsZ7xVOZQVmmV5Ygtvvn8z/inv1A7
         KEnnwcZGqoPK/KlNLxib6PUlwe/uFK4Wwd/1C2RCrSlYpZjkE42OcSCtox3DJwe9Ef/g
         LVtQwGx1nmtzLeqQurVmjvQdJdJIG3YeZXDvCfZRq4ccuJIAtEVtg5N9jfS/7f3BylPV
         R+qPVae6ABc9LoWHx4M4pkpEaeoaFcygHWgOWGCKcIN3FiUnno1E+lI3LBGElZoDlnzm
         yz4A==
X-Gm-Message-State: AOAM532b8Mxy7bT1WG7Y31J/ht5ZNPI9UmuQR85fOpzbmTRpKfq93N97
        OV3qDE9/6wnGCrAuYHaqKjUMok/c/nRQk85rbo+MmVy2WVFG
X-Google-Smtp-Source: ABdhPJwGDYCjc3BNVRzVSBEYj9H9ZEb0Y7IRhOc9DulIibz7/t3OPUadHKyAOf3O1ddKCLTIDoa6/5z+6uPn2guyo6jkw5aGqY/A
MIME-Version: 1.0
X-Received: by 2002:a5d:8e14:: with SMTP id e20mr2502023iod.119.1599641362896;
 Wed, 09 Sep 2020 01:49:22 -0700 (PDT)
Date:   Wed, 09 Sep 2020 01:49:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000341a4705aedd87e0@google.com>
Subject: INFO: rcu detected stall in sys_mount (5)
From:   syzbot <syzbot+dc8c077c7091175cbdb1@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    612ab8ad Merge tag 'livepatching-for-5.9-rc5' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147538dd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=dc8c077c7091175cbdb1
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11851c29900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140807ae900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc8c077c7091175cbdb1@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
------------[ cut here ]------------
WARNING: CPU: 0 PID: 19741 at kernel/sched/core.c:3013 rq_unlock kernel/sched/sched.h:1326 [inline]
WARNING: CPU: 0 PID: 19741 at kernel/sched/core.c:3013 try_invoke_on_locked_down_task+0x214/0x2c0 kernel/sched/core.c:3019
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 19741 Comm: syz-executor018 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x347/0x7c0 kernel/panic.c:231
 __warn.cold+0x20/0x46 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:try_invoke_on_locked_down_task+0x214/0x2c0 kernel/sched/core.c:3013
Code: 45 31 f6 49 39 c0 74 3a 8b 74 24 38 49 8d 78 18 4c 89 04 24 e8 ad 9a 08 00 4c 8b 04 24 4c 89 c7 e8 01 20 a6 06 e9 29 ff ff ff <0f> 0b e9 86 fe ff ff 4c 89 ee 48 89 ef 41 ff d4 41 89 c6 e9 11 ff
RSP: 0018:ffffc90000007bd8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff92000000f7d RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff81612ed0 RDI: ffff8880a71dc200
RBP: ffff8880a71dc200 R08: 0000000000000033 R09: ffffffff89bcb4a3
R10: 00000000000005a1 R11: 0000000000000001 R12: ffffffff81612ed0
R13: ffffc90000007d00 R14: ffff8880a71dc580 R15: ffff8880ae636c00
 rcu_print_task_stall kernel/rcu/tree_stall.h:267 [inline]
 print_other_cpu_stall kernel/rcu/tree_stall.h:475 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:634 [inline]
 rcu_pending kernel/rcu/tree.c:3637 [inline]
 rcu_sched_clock_irq.cold+0x92e/0xccd kernel/rcu/tree.c:2519
 update_process_times+0x25/0xa0 kernel/time/timer.c:1710
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:176
 tick_sched_timer+0x1d1/0x2a0 kernel/time/tick-sched.c:1328
 __run_hrtimer kernel/time/hrtimer.c:1524 [inline]
 __hrtimer_run_queues+0x1d5/0xfc0 kernel/time/hrtimer.c:1588
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1650
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xb2/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:strncasecmp lib/string.c:52 [inline]
RIP: 0010:strncasecmp+0x5c/0x240 lib/string.c:43
Code: 03 01 00 00 40 38 ce 0f 85 ec 01 00 00 4c 39 e2 0f 84 11 01 00 00 4c 89 fe 4c 89 e7 49 83 c4 01 48 89 f8 48 89 f9 48 c1 e8 03 <83> e1 07 42 0f b6 04 28 38 c8 7f 08 84 c0 0f 85 0f 01 00 00 41 0f
RSP: 0018:ffffc9000c78f9f8 EFLAGS: 00000a02
RAX: 1ffff110144aa638 RBX: dffffc0000000000 RCX: ffff8880a25531c0
RDX: ffff8880a25531c8 RSI: ffff8880a7b974c1 RDI: ffff8880a25531c0
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff88809fa908ab
R10: 0000000000000000 R11: 0000000000000007 R12: ffff8880a25531c1
R13: dffffc0000000000 R14: 0000000000000008 R15: ffff88809fa90a10
 afs_lookup_cell_rcu+0x313/0x720 fs/afs/cell.c:88
 afs_lookup_cell+0x2ee/0x1440 fs/afs/cell.c:249
 afs_parse_source fs/afs/super.c:290 [inline]
 afs_parse_param+0x404/0x8c0 fs/afs/super.c:326
 vfs_parse_fs_param fs/fs_context.c:117 [inline]
 vfs_parse_fs_param+0x203/0x550 fs/fs_context.c:98
 vfs_parse_fs_string+0xe6/0x150 fs/fs_context.c:161
 do_new_mount fs/namespace.c:2869 [inline]
 path_mount+0x5de/0x2070 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446889
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0c0657cdb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446889
RDX: 0000000020000040 RSI: 0000000020000180 RDI: 0000000020000000
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007ffdd19d1b1f R14: 00007f0c0657d9c0 R15: 0000000000000001
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
