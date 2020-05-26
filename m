Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B11AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC9F20787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbgEZDyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 23:54:18 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43653 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgEZDyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:54:18 -0400
Received: by mail-io1-f70.google.com with SMTP id 184so13651635iow.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WKIr+TucPsON9szJo+WazjJgT1BlLKj7KY36LZC5zpo=;
        b=qm0Ldi19Up5rCObsgsChr7mBS1FeVUvCS3hIElHWawvRR8+NVSKke6aLlEjjQJrBn0
         5kYYyX3iPDkbwA+kUE0OVdN58qLlk8Mpa7Cy3sVFaO/Hw7r4h6vib0zG4o5Hzrj1aEqA
         /0SQuOUOxBFeNr6enV/37rS1epJgM9MNmINVw3EPAdxdllSxuvdBDLvFBv+NzSTJzL5U
         iod1jvWQNdidv+lJZp3qPkfmLp5O7cXPDg+qaVyPHAGODuoBuIO6ZAc4mPwFqu15mP2g
         he0RfznsUKJpnG7KN/6cRgkgY5RKDEI+BWGosX0nvHWm5zrxTfURZ0y+cRIh+r3ZLh5T
         tZvw==
X-Gm-Message-State: AOAM530fVg/QrKaA7+7H28HOyilik9wv03i2No61+HA5W6kVeEoSNt1w
        3tX4s4pZfgPT60v/IUfnUVYCjxoKNTcN4cS0lkEzVmKXNNGG
X-Google-Smtp-Source: ABdhPJxap8xtXaMzCShC+NS8/GCMXynVaDAv01L/U3yaDH+yUKKcNeUfP3CAyMCLdaVtMrMVAA9ksKbPbrC+155Phq8VYzxxs27K
MIME-Version: 1.0
X-Received: by 2002:a02:212c:: with SMTP id e44mr21249599jaa.109.1590465254393;
 Mon, 25 May 2020 20:54:14 -0700 (PDT)
Date:   Mon, 25 May 2020 20:54:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000840d4d05a6850c73@google.com>
Subject: WARNING: suspicious RCU usage in idtentry_exit
From:   syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7b4cb0a4 Add linux-next specific files for 20200525
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13356016100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae5eaae0809ee311e75
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.7.0-rc7-next-20200525-syzkaller #0 Not tainted
-----------------------------
kernel/rcu/tree.c:715 RCU dynticks_nesting counter underflow/zero!!

other info that might help us debug this:


RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by syz-executor.5/24641.

stack backtrace:
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 rcu_irq_exit_preempt+0x1fa/0x250 kernel/rcu/tree.c:715
 idtentry_exit+0x9e/0xc0 arch/x86/entry/common.c:583
 exc_general_protection+0x23d/0x520 arch/x86/kernel/traps.c:506
 asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:353
RIP: 0010:kvm_fastop_exception+0xb68/0xfe8
Code: f2 ff ff ff 48 31 db e9 fb c9 2a f9 b8 f2 ff ff ff 48 31 f6 e9 ff c9 2a f9 31 c0 e9 ec 2c 2b f9 b8 fb ff ff ff e9 13 a9 31 f9 <b9> fb ff ff ff 31 c0 31 d2 e9 33 a9 31 f9 31 db e9 2a 0b 42 f9 31
RSP: 0018:ffffc90004a87a30 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88809cca4080 RCX: 0000000000000122
RDX: 00000000000063ff RSI: ffffc90004a87a98 RDI: 0000000000000122
RBP: 0000000000000122 R08: ffff888058486480 R09: fffffbfff131f481
R10: ffffffff898fa403 R11: fffffbfff131f480 R12: 0000000000000122
R13: 0000000000000078 R14: 0000000000000006 R15: ffffffff88244b5c
 paravirt_read_msr_safe arch/x86/include/asm/paravirt.h:178 [inline]
 vmx_create_vcpu+0x184/0x2b40 arch/x86/kvm/vmx/vmx.c:6827
 kvm_arch_vcpu_create+0x6a8/0xb30 arch/x86/kvm/x86.c:9427
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3043 [inline]
 kvm_vm_ioctl+0x15b7/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4

=============================
WARNING: suspicious RCU usage
5.7.0-rc7-next-20200525-syzkaller #0 Not tainted
-----------------------------
kernel/rcu/tree.c:717 RCU in extended quiescent state!!

other info that might help us debug this:


RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by syz-executor.5/24641.

stack backtrace:
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 idtentry_exit+0x9e/0xc0 arch/x86/entry/common.c:583
 exc_general_protection+0x23d/0x520 arch/x86/kernel/traps.c:506
 asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:353
RIP: 0010:kvm_fastop_exception+0xb68/0xfe8
Code: f2 ff ff ff 48 31 db e9 fb c9 2a f9 b8 f2 ff ff ff 48 31 f6 e9 ff c9 2a f9 31 c0 e9 ec 2c 2b f9 b8 fb ff ff ff e9 13 a9 31 f9 <b9> fb ff ff ff 31 c0 31 d2 e9 33 a9 31 f9 31 db e9 2a 0b 42 f9 31
RSP: 0018:ffffc90004a87a30 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88809cca4080 RCX: 0000000000000122
RDX: 00000000000063ff RSI: ffffc90004a87a98 RDI: 0000000000000122
RBP: 0000000000000122 R08: ffff888058486480 R09: fffffbfff131f481
R10: ffffffff898fa403 R11: fffffbfff131f480 R12: 0000000000000122
R13: 0000000000000078 R14: 0000000000000006 R15: ffffffff88244b5c
 paravirt_read_msr_safe arch/x86/include/asm/paravirt.h:178 [inline]
 vmx_create_vcpu+0x184/0x2b40 arch/x86/kvm/vmx/vmx.c:6827
 kvm_arch_vcpu_create+0x6a8/0xb30 arch/x86/kvm/x86.c:9427
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3043 [inline]
 kvm_vm_ioctl+0x15b7/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4

=============================
WARNING: suspicious RCU usage
5.7.0-rc7-next-20200525-syzkaller #0 Not tainted
-----------------------------
include/trace/events/rcu.h:27 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by syz-executor.5/24641.

stack backtrace:
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 trace_rcu_utilization include/trace/events/rcu.h:27 [inline]
 trace_rcu_utilization include/trace/events/rcu.h:27 [inline]
 rcu_note_context_switch+0x113d/0x1b20 kernel/rcu/tree_plugin.h:293
 __schedule+0x22b/0x1f70 kernel/sched/core.c:4058
 preempt_schedule_irq+0xb0/0x150 kernel/sched/core.c:4380
 idtentry_exit+0xb9/0xc0 arch/x86/entry/common.c:585
 exc_general_protection+0x23d/0x520 arch/x86/kernel/traps.c:506
 asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:353
RIP: 0010:kvm_fastop_exception+0xb68/0xfe8
Code: f2 ff ff ff 48 31 db e9 fb c9 2a f9 b8 f2 ff ff ff 48 31 f6 e9 ff c9 2a f9 31 c0 e9 ec 2c 2b f9 b8 fb ff ff ff e9 13 a9 31 f9 <b9> fb ff ff ff 31 c0 31 d2 e9 33 a9 31 f9 31 db e9 2a 0b 42 f9 31
RSP: 0018:ffffc90004a87a30 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88809cca4080 RCX: 0000000000000122
RDX: 00000000000063ff RSI: ffffc90004a87a98 RDI: 0000000000000122
RBP: 0000000000000122 R08: ffff888058486480 R09: fffffbfff131f481
R10: ffffffff898fa403 R11: fffffbfff131f480 R12: 0000000000000122
R13: 0000000000000078 R14: 0000000000000006 R15: ffffffff88244b5c
 paravirt_read_msr_safe arch/x86/include/asm/paravirt.h:178 [inline]
 vmx_create_vcpu+0x184/0x2b40 arch/x86/kvm/vmx/vmx.c:6827
 kvm_arch_vcpu_create+0x6a8/0xb30 arch/x86/kvm/x86.c:9427
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3043 [inline]
 kvm_vm_ioctl+0x15b7/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4

=============================
WARNING: suspicious RCU usage
5.7.0-rc7-next-20200525-syzkaller #0 Not tainted
-----------------------------
include/trace/events/sched.h:629 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 0
RCU used illegally from extended quiescent state!
1 lock held by syz-executor.5/24641:
 #0: ffff8880ae737d58 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1263 [inline]
 #0: ffff8880ae737d58 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x233/0x1f70 kernel/sched/core.c:4068

stack backtrace:
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 trace_pelt_se_tp include/trace/events/sched.h:629 [inline]
 trace_pelt_se_tp include/trace/events/sched.h:629 [inline]
 __update_load_avg_se+0x75a/0xc90 kernel/sched/pelt.c:321
 update_load_avg+0x178/0x1c60 kernel/sched/fair.c:3786
 set_next_entity+0x295/0x880 kernel/sched/fair.c:4387
 pick_next_task_fair+0x66f/0xc70 kernel/sched/fair.c:7045
 pick_next_task kernel/sched/core.c:3975 [inline]
 __schedule+0x375/0x1f70 kernel/sched/core.c:4090
 preempt_schedule_irq+0xb0/0x150 kernel/sched/core.c:4380
 idtentry_exit+0xb9/0xc0 arch/x86/entry/common.c:585
 exc_general_protection+0x23d/0x520 arch/x86/kernel/traps.c:506
 asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:353
RIP: 0010:kvm_fastop_exception+0xb68/0xfe8
Code: f2 ff ff ff 48 31 db e9 fb c9 2a f9 b8 f2 ff ff ff 48 31 f6 e9 ff c9 2a f9 31 c0 e9 ec 2c 2b f9 b8 fb ff ff ff e9 13 a9 31 f9 <b9> fb ff ff ff 31 c0 31 d2 e9 33 a9 31 f9 31 db e9 2a 0b 42 f9 31
RSP: 0018:ffffc90004a87a30 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88809cca4080 RCX: 0000000000000122
RDX: 00000000000063ff RSI: ffffc90004a87a98 RDI: 0000000000000122
RBP: 0000000000000122 R08: ffff888058486480 R09: fffffbfff131f481
R10: ffffffff898fa403 R11: fffffbfff131f480 R12: 0000000000000122
R13: 0000000000000078 R14: 0000000000000006 R15: ffffffff88244b5c
 paravirt_read_msr_safe arch/x86/include/asm/paravirt.h:178 [inline]
 vmx_create_vcpu+0x184/0x2b40 arch/x86/kvm/vmx/vmx.c:6827
 kvm_arch_vcpu_create+0x6a8/0xb30 arch/x86/kvm/x86.c:9427
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3043 [inline]
 kvm_vm_ioctl+0x15b7/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4
check_preemption_disabled: 3 callbacks suppressed
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor.5/24641
caller is rcu_nmi_enter+0x19/0x200 kernel/rcu/tree.c:823
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 rcu_nmi_enter+0x19/0x200 kernel/rcu/tree.c:823
 kernel_text_address+0x99/0xe0 kernel/extable.c:143
 __kernel_text_address+0x9/0x30 kernel/extable.c:105
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:317 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:312
 arch_stack_walk+0x97/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x11b/0x740 mm/slab.c:3484
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 anon_inode_getfile fs/anon_inodes.c:91 [inline]
 anon_inode_getfile+0xc8/0x1f0 fs/anon_inodes.c:74
 anon_inode_getfd+0x4c/0xa0 fs/anon_inodes.c:136
 create_vcpu_fd arch/x86/kvm/../../../virt/kvm/kvm_main.c:2983 [inline]
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3058 [inline]
 kvm_vm_ioctl+0x1ab5/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor.5/24641
caller is rcu_dynticks_curr_cpu_in_eqs kernel/rcu/tree.c:299 [inline]
caller is rcu_nmi_enter+0x7b/0x200 kernel/rcu/tree.c:838
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 rcu_dynticks_curr_cpu_in_eqs kernel/rcu/tree.c:299 [inline]
 rcu_nmi_enter+0x7b/0x200 kernel/rcu/tree.c:838
 kernel_text_address+0x99/0xe0 kernel/extable.c:143
 __kernel_text_address+0x9/0x30 kernel/extable.c:105
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:317 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:312
 arch_stack_walk+0x97/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x11b/0x740 mm/slab.c:3484
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 anon_inode_getfile fs/anon_inodes.c:91 [inline]
 anon_inode_getfile+0xc8/0x1f0 fs/anon_inodes.c:74
 anon_inode_getfd+0x4c/0xa0 fs/anon_inodes.c:136
 create_vcpu_fd arch/x86/kvm/../../../virt/kvm/kvm_main.c:2983 [inline]
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3058 [inline]
 kvm_vm_ioctl+0x1ab5/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor.5/24641
caller is rcu_dynticks_eqs_enter+0x11/0x70 kernel/rcu/tree.c:236
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 rcu_dynticks_eqs_enter+0x11/0x70 kernel/rcu/tree.c:236
 rcu_nmi_enter+0x185/0x200 kernel/rcu/tree.c:844
 kernel_text_address+0x99/0xe0 kernel/extable.c:143
 __kernel_text_address+0x9/0x30 kernel/extable.c:105
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:317 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:312
 arch_stack_walk+0x97/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x11b/0x740 mm/slab.c:3484
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 anon_inode_getfile fs/anon_inodes.c:91 [inline]
 anon_inode_getfile+0xc8/0x1f0 fs/anon_inodes.c:74
 anon_inode_getfd+0x4c/0xa0 fs/anon_inodes.c:136
 create_vcpu_fd arch/x86/kvm/../../../virt/kvm/kvm_main.c:2983 [inline]
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3058 [inline]
 kvm_vm_ioctl+0x1ab5/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor.5/24641
caller is rcu_nmi_exit+0x19/0x2c0 kernel/rcu/tree.c:634
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 rcu_nmi_exit+0x19/0x2c0 kernel/rcu/tree.c:634
 kernel_text_address+0xb3/0xe0 kernel/extable.c:156
 __kernel_text_address+0x9/0x30 kernel/extable.c:105
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:317 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:312
 arch_stack_walk+0x97/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x11b/0x740 mm/slab.c:3484
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 anon_inode_getfile fs/anon_inodes.c:91 [inline]
 anon_inode_getfile+0xc8/0x1f0 fs/anon_inodes.c:74
 anon_inode_getfd+0x4c/0xa0 fs/anon_inodes.c:136
 create_vcpu_fd arch/x86/kvm/../../../virt/kvm/kvm_main.c:2983 [inline]
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3058 [inline]
 kvm_vm_ioctl+0x1ab5/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor.5/24641
caller is rcu_dynticks_curr_cpu_in_eqs kernel/rcu/tree.c:299 [inline]
caller is rcu_nmi_exit+0x7b/0x2c0 kernel/rcu/tree.c:642
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 rcu_dynticks_curr_cpu_in_eqs kernel/rcu/tree.c:299 [inline]
 rcu_nmi_exit+0x7b/0x2c0 kernel/rcu/tree.c:642
 kernel_text_address+0xb3/0xe0 kernel/extable.c:156
 __kernel_text_address+0x9/0x30 kernel/extable.c:105
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:317 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:312
 arch_stack_walk+0x97/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x11b/0x740 mm/slab.c:3484
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 anon_inode_getfile fs/anon_inodes.c:91 [inline]
 anon_inode_getfile+0xc8/0x1f0 fs/anon_inodes.c:74
 anon_inode_getfd+0x4c/0xa0 fs/anon_inodes.c:136
 create_vcpu_fd arch/x86/kvm/../../../virt/kvm/kvm_main.c:2983 [inline]
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3058 [inline]
 kvm_vm_ioctl+0x1ab5/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor.5/24641
caller is rcu_dynticks_eqs_enter+0x11/0x70 kernel/rcu/tree.c:236
CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 rcu_dynticks_eqs_enter+0x11/0x70 kernel/rcu/tree.c:236
 rcu_nmi_exit+0x214/0x2c0 kernel/rcu/tree.c:670
 kernel_text_address+0xb3/0xe0 kernel/extable.c:156
 __kernel_text_address+0x9/0x30 kernel/extable.c:105
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:317 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:312
 arch_stack_walk+0x97/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x11b/0x740 mm/slab.c:3484
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 anon_inode_getfile fs/anon_inodes.c:91 [inline]
 anon_inode_getfile+0xc8/0x1f0 fs/anon_inodes.c:74
 anon_inode_getfd+0x4c/0xa0 fs/anon_inodes.c:136
 create_vcpu_fd arch/x86/kvm/../../../virt/kvm/kvm_main.c:2983 [inline]
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3058 [inline]
 kvm_vm_ioctl+0x1ab5/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
