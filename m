Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC65C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5814D206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgCQGaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:30:16 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47316 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCQGaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:30:15 -0400
Received: by mail-il1-f200.google.com with SMTP id a4so15951557ili.14
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 23:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IBjySOjASwP1HAeGLAmKjuR6Sszw/8/rfGZg7/AIW8U=;
        b=bIvUswonPRW6YXi1pL4Rp2NTcGR39zSasEBAs4L3md/AsJqICy3Fk1e9lvkubeQFqY
         Op+f+dDxINW8y6G1EoaLDiAENMBpNAP/q43cxL1k7S+iihOSjqOZWx+/oLSnBI1/TbPA
         B6GzsmHfCqEdFsJpJylsVC6pC5TaoIWY8dqosWU2oLHMqf7nfB70UBR1ZHg+hf2/sZAJ
         mY2GRG+gVFymRWJ5VaRQVXpZGcM+bGscQk+ZP473a+1n4V1PBjT0whruTW+v7n6oivjd
         SDy48B9H+X/YK2ff7zLSgCLq6vq0ANYGjAM10ePrgX8FHRAwglTwoXxR3FuAlNUOU+ya
         /gkQ==
X-Gm-Message-State: ANhLgQ2V7eWLO6uxrQPNUzQAjFF9jXAprqUgn1XKDsHZU8qzwJSmbXf9
        JLn9WPPdNe2UjcorchTJoucIPXPMhKWzgOEfLra4oKnzLDa9
X-Google-Smtp-Source: ADFU+vtctqJa2ci30A1tXJi8ZER7c6LMuPD2GpcAyOk3z+431izTKcqTGPW/dl7Qg/XuI9S3w673aeicvLypp6E/vOhavzYBNo+k
MIME-Version: 1.0
X-Received: by 2002:a6b:e70e:: with SMTP id b14mr2553817ioh.1.1584426614327;
 Mon, 16 Mar 2020 23:30:14 -0700 (PDT)
Date:   Mon, 16 Mar 2020 23:30:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000850ef705a10711f6@google.com>
Subject: WARNING: locking bug in ktime_get
From:   syzbot <syzbot+24ab7a09b640e90e9550@syzkaller.appspotmail.com>
To:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fb33c651 Linux 5.6-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17452275e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
dashboard link: https://syzkaller.appspot.com/bug?extid=24ab7a09b640e90e9550
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+24ab7a09b640e90e9550@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 16068 at kernel/locking/lockdep.c:167 hlock_class kernel/locking/lockdep.c:167 [inline]
WARNING: CPU: 0 PID: 16068 at kernel/locking/lockdep.c:167 hlock_class kernel/locking/lockdep.c:156 [inline]
WARNING: CPU: 0 PID: 16068 at kernel/locking/lockdep.c:167 check_deadlock kernel/locking/lockdep.c:2394 [inline]
WARNING: CPU: 0 PID: 16068 at kernel/locking/lockdep.c:167 validate_chain kernel/locking/lockdep.c:2954 [inline]
WARNING: CPU: 0 PID: 16068 at kernel/locking/lockdep.c:167 __lock_acquire+0x2aed/0x3ca0 kernel/locking/lockdep.c:3954
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 16068 Comm: syz-executor.5 Not tainted 5.6.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:hlock_class kernel/locking/lockdep.c:167 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:156 [inline]
RIP: 0010:check_deadlock kernel/locking/lockdep.c:2394 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:2954 [inline]
RIP: 0010:__lock_acquire+0x2aed/0x3ca0 kernel/locking/lockdep.c:3954
Code: 08 84 d2 0f 85 db 0f 00 00 8b 05 5e 87 0d 09 85 c0 0f 85 a8 fc ff ff 48 c7 c6 e0 71 0b 88 48 c7 c7 20 72 0b 88 e8 8b b9 eb ff <0f> 0b e9 8e fc ff ff 48 c7 c0 a0 03 3e 8c 48 c1 e8 03 42 0f b6 14
RSP: 0018:ffffc90001e2f270 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000ae3 RCX: 0000000000000000
RDX: 0000000040000002 RSI: ffffffff815c06c1 RDI: fffff520003c5e40
RBP: ffff88804e6ced40 R08: ffff88804e6ce480 R09: fffffbfff12f43ad
R10: fffffbfff12f43ac R11: ffffffff897a1d63 R12: dffffc0000000000
R13: 0000000000000001 R14: ffffffff8a6603d0 R15: ffff88804e6cede0
 lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
 seqcount_lockdep_reader_access include/linux/seqlock.h:81 [inline]
 read_seqcount_begin include/linux/seqlock.h:164 [inline]
 ktime_get kernel/time/timekeeping.c:757 [inline]
 ktime_get+0xd0/0x2f0 kernel/time/timekeeping.c:747
 __hrtimer_start_range_ns kernel/time/hrtimer.c:1094 [inline]
 hrtimer_start_range_ns+0x18b/0xc30 kernel/time/hrtimer.c:1133
 perf_swevent_start_hrtimer kernel/events/core.c:9837 [inline]
 cpu_clock_event_start+0x8e/0xb0 kernel/events/core.c:9907
 cpu_clock_event_add+0x46/0x50 kernel/events/core.c:9919
 event_sched_in kernel/events/core.c:2383 [inline]
 event_sched_in.isra.0+0x366/0xbe0 kernel/events/core.c:2347
 group_sched_in+0xda/0x3b0 kernel/events/core.c:2419
 flexible_sched_in kernel/events/core.c:3464 [inline]
 flexible_sched_in+0x610/0xa40 kernel/events/core.c:3453
 visit_groups_merge+0x2f5/0x550 kernel/events/core.c:3412
 ctx_flexible_sched_in kernel/events/core.c:3501 [inline]
 ctx_sched_in+0x2f7/0x7a0 kernel/events/core.c:3546
 perf_event_sched_in+0x69/0xa0 kernel/events/core.c:2528
 perf_event_context_sched_in kernel/events/core.c:3586 [inline]
 __perf_event_task_sched_in+0x5cb/0x7c0 kernel/events/core.c:3625
 perf_event_task_sched_in include/linux/perf_event.h:1179 [inline]
 finish_task_switch+0x2a8/0x750 kernel/sched/core.c:3217
 context_switch kernel/sched/core.c:3383 [inline]
 __schedule+0x93c/0x1f90 kernel/sched/core.c:4080
 preempt_schedule_irq+0xb0/0x150 kernel/sched/core.c:4337
 retint_kernel+0x1b/0x2b
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:759 [inline]
RIP: 0010:lock_acquire+0x209/0x420 kernel/locking/lockdep.c:4487
Code: 94 08 00 00 00 00 00 00 48 c1 e8 03 80 3c 10 00 0f 85 de 01 00 00 48 83 3d a3 0f 1b 08 00 0f 84 5a 01 00 00 48 8b 3c 24 57 9d <0f> 1f 44 00 00 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 65 8b
RSP: 0018:ffffc90001e2fb18 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff12e7698 RBX: ffff88804e6ce480 RCX: ffffffff8158752b
RDX: dffffc0000000000 RSI: 1ffff920003c5f4c RDI: 0000000000000286
RBP: ffff8880883d7928 R08: 0000000000000004 R09: fffffbfff1873821
R10: fffffbfff1873820 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 flush_workqueue+0x126/0x14c0 kernel/workqueue.c:2777
 hci_dev_open+0xdb/0x280 net/bluetooth/hci_core.c:1626
 hci_sock_bind+0x427/0x1140 net/bluetooth/hci_sock.c:1200
 __sys_bind+0x20e/0x250 net/socket.c:1662
 __do_sys_bind net/socket.c:1673 [inline]
 __se_sys_bind net/socket.c:1671 [inline]
 __x64_sys_bind+0x6f/0xb0 net/socket.c:1671
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1a88a17c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007f1a88a186d4 RCX: 000000000045c849
RDX: 0000000000000006 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000002c R14: 00000000004c2ce6 R15: 000000000076bf0c
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
