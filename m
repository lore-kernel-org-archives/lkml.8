Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474B1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7302071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgIAR70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:59:26 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45828 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgIAR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:59:24 -0400
Received: by mail-io1-f70.google.com with SMTP id q5so1503127ion.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nZLkmS+xZx8+jzu46vFdG46awGaN/cvwGNUAIfRPZ/w=;
        b=bErCmz4roaOh7y3hOMqlgu4UJRZj/ll5Ln7miMtaFWIbRT08LjDCZFQvaudTlr7DnN
         pPqZBWrBJO1bbP7NqK+3/WVXPwQJVMgE1tPsmL+UfFxD5ik0EIxW+s8gtYScaBVMpFxG
         tka03KHo3Fg7uti1TwoCqU4YdsUy1MweH39bNkIi36DLEBH/zAuemmaok8YW/BHEtFT5
         AvWU48AnjeT7dj1//Orcd+23mqk7NNwCzk4zxx+CE4NvR1dMGLi2DQygNkCqwC3D4yeR
         Jg++9ILOdhPmv3jnAvqfdQ0LhONfR64OX1wN0eia78/WXLdYSuF5Uz1Y/K7qqIKDAML+
         2oRQ==
X-Gm-Message-State: AOAM531vL68zIGWL3dKCOtpStKu7/AqczrQYwXaz5Xqvwg7sjrKufFBW
        ghHR+iQYLo80v8TWkJnjvFvqkUHANYxW72tbiylB1gDxgJpt
X-Google-Smtp-Source: ABdhPJzOLLXElESGbYVDbjp0rrW7e7TzzKRRGzu3yO+Tn0qvwcah9P+5PLNviPSZl2KIUKbYRDFCch4vzJb0JFjYw1W/wcgbK1JZ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d95:: with SMTP id l21mr2394825jaj.98.1598983162854;
 Tue, 01 Sep 2020 10:59:22 -0700 (PDT)
Date:   Tue, 01 Sep 2020 10:59:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c834505ae44475b@google.com>
Subject: INFO: task can't die in irqentry_exit
From:   syzbot <syzbot+c4af95386364bc59b13e@syzkaller.appspotmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b36c9697 Add linux-next specific files for 20200828
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=118ca625900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e3cf99580b5542c
dashboard link: https://syzkaller.appspot.com/bug?extid=c4af95386364bc59b13e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4af95386364bc59b13e@syzkaller.appspotmail.com

INFO: task syz-executor.0:5956 can't die for more than 143 seconds.
task:syz-executor.0  state:R  running task     stack:25424 pid: 5956 ppid: 14284 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 preempt_schedule_irq+0xb0/0x150 kernel/sched/core.c:4785
 irqentry_exit_cond_resched kernel/entry/common.c:333 [inline]
 irqentry_exit_cond_resched kernel/entry/common.c:325 [inline]
 irqentry_exit+0x65/0x90 kernel/entry/common.c:363
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:653 [inline]
RIP: 0010:lock_acquire+0x27b/0xad0 kernel/locking/lockdep.c:5008
Code: 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 f8 06 00 00 48 83 3d 6a d1 5b 08 00 0f 84 a6 05 00 00 48 8b 7c 24 08 57 9d <0f> 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 48 03 44 24 10 48 c7
RSP: 0018:ffffc900088477c0 EFLAGS: 00000286
RAX: 1ffffffff136c7d9 RBX: ffff88808766c200 RCX: 000000005603e267
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000286
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8c6a59e7
R10: fffffbfff18d4b3c R11: 0000000000000001 R12: 0000000000000002
R13: ffffffff89c67640 R14: 0000000000000000 R15: ffff88808766c200
 rcu_lock_acquire include/linux/rcupdate.h:248 [inline]
 rcu_read_lock include/linux/rcupdate.h:641 [inline]
 inet_twsk_purge+0x112/0x7c0 net/ipv4/inet_timewait_sock.c:268
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:189
 setup_net+0x508/0x850 net/core/net_namespace.c:364
 copy_net_ns+0x31e/0x760 net/core/net_namespace.c:482
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 copy_namespaces+0x385/0x470 kernel/nsproxy.c:179
 copy_process+0x293d/0x6bf0 kernel/fork.c:2090
 _do_fork+0xe8/0xb10 kernel/fork.c:2448
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2565
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: Bad RIP value.
RSP: 002b:00007fda8e0a3c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000001f40 RCX: 000000000045d5b9
RDX: 9999999999999999 RSI: 0000000000000000 RDI: 00000000e1004d7c
RBP: 000000000118cf90 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffe7d457dcf R14: 00007fda8e0a49c0 R15: 000000000118cf4c

Showing all locks held in the system:
1 lock held by khungtaskd/1169:
 #0: ffffffff89c67640 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5825
1 lock held by in:imklog/6579:
 #0: ffff8880a166e430 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
3 locks held by kworker/u4:2/15395:
1 lock held by syz-executor.0/5956:
3 locks held by syz-executor.1/12814:
 #0: ffff8880ae635f98 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #0: ffff8880ae635f98 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x232/0x21e0 kernel/sched/core.c:4445
 #1: ffff8880ae620ec8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2fb/0x400 kernel/sched/psi.c:833
 #2: ffff888090a82438 (&sig->wait_chldexit){....}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:122

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
