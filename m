Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784A2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EA92073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCFIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:48:17 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:50085 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgCFIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:48:16 -0500
Received: by mail-il1-f200.google.com with SMTP id b72so1043335ilg.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 00:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OTQdRDj2JWY9baXNooWD/ie2gXjmFa8rLDSyD+l5ZmY=;
        b=dIj61MB3nulwGeWDoeLM7qP1j1I6s8ygxerdHLoPBGS1ZmYNb63VAUrh9lvoAmKx8V
         hgQ4ubgncbOiaDDo1huA6M4UlB9m93gNR55/c3jBk7kIR3hJdATpwERu7lBV3D6ksPJH
         xfbT0TS8GQ+FWiaQwMQcf5sE92OGPcSxIzaWILQ6pN3pmh6zfmG8kpKjlDyahB8Iysgl
         i7a1q+ZHAkLhq1od6iBeDeRwq8gintLA/03NaaiBudM5gMUfrS12kokAyu388vsgfkZv
         SVBee7S9E8XC/dd7j//fsPYFrQ3yUTGGrNPsgi7QO4JsrdoIrZ/hYqNZyuclgq3QSc/0
         iXnw==
X-Gm-Message-State: ANhLgQ1HlL6JEEWuQ7n2r+iaE9tjOSEsDpr+skLOyBTfITgu3rj4B+hW
        LbPWJ/Y08yDKrnHG5KcZsK6mcUC5CGjDfxRk7bi9TAavJvUq
X-Google-Smtp-Source: ADFU+vvmm+XV99KvoarD7nXbV7SIItB6Ba3oC1BCeBp6oa9JGcVm/0Y09P+AlIre91yZrDAO8fBFCIV4L7cst7vhA7gdhq/6l3Lo
MIME-Version: 1.0
X-Received: by 2002:a02:a882:: with SMTP id l2mr1933199jam.102.1583484494216;
 Fri, 06 Mar 2020 00:48:14 -0800 (PST)
Date:   Fri, 06 Mar 2020 00:48:13 -0800
In-Reply-To: <0000000000005c66c305a0121be1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9032b05a02bb65c@google.com>
Subject: Re: BUG: sleeping function called from invalid context in do_page_fault
From:   syzbot <syzbot+7f59c1e54e5ce4d95cf7@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1274ee2de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=7f59c1e54e5ce4d95cf7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1664b01de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7f59c1e54e5ce4d95cf7@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1400
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 9745, name: syz-executor.2
1 lock held by syz-executor.2/9745:
 #0: ffff8880976b9898 (&mm->mmap_sem#2){++++}, at: do_user_addr_fault arch/x86/mm/fault.c:1383 [inline]
 #0: ffff8880976b9898 (&mm->mmap_sem#2){++++}, at: do_page_fault+0x34b/0x12e1 arch/x86/mm/fault.c:1517
irq event stamp: 171752
hardirqs last  enabled at (171751): [<ffffffff83a6991b>] __free_object+0x93b/0x10d0 lib/debugobjects.c:360
hardirqs last disabled at (171752): [<ffffffff8100a81a>] syscall_return_slowpath arch/x86/entry/common.c:277 [inline]
hardirqs last disabled at (171752): [<ffffffff8100a81a>] do_syscall_64+0x20a/0x790 arch/x86/entry/common.c:304
softirqs last  enabled at (163232): [<ffffffff882006cd>] __do_softirq+0x6cd/0x98c kernel/softirq.c:319
softirqs last disabled at (163157): [<ffffffff8147a08b>] invoke_softirq kernel/softirq.c:373 [inline]
softirqs last disabled at (163157): [<ffffffff8147a08b>] irq_exit+0x19b/0x1e0 kernel/softirq.c:413
CPU: 1 PID: 9745 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6798
 __might_sleep+0x95/0x190 kernel/sched/core.c:6751
 do_user_addr_fault arch/x86/mm/fault.c:1400 [inline]
 do_page_fault+0x378/0x12e1 arch/x86/mm/fault.c:1517
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:189 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_64+0x2c9/0x790 arch/x86/entry/common.c:304
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc9000224ff20 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88809b036480 RCX: ffffffff8100a857
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc9000224ff48 R08: ffff88809b036480 R09: ffffed1013606c91
R10: ffffed1013606c90 R11: ffff88809b036487 R12: ffffc9000224ff58
R13: 0000000000000000 R14: 0000000000004000 R15: 0000000000000000
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9745 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x3a/0x70 arch/x86/entry/vsyscall/vsyscall_64.c:344
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <60> ff 48 89 de e8 7c b7 74 00 48 81 fb 00 00 60 ff 74 10 e8 ce b5
RSP: 0018:ffffc9000224f4d8 EFLAGS: 00010082
RAX: ffff88809b036480 RBX: 0000000000000000 RCX: ffffffff816c3c90
RDX: 0000000000000000 RSI: ffffffff816c3cbb RDI: 000000000045a920
RBP: ffffc9000224f518 R08: ffff88809b036480 R09: fffffbfff1708c62
R10: fffffbfff1708c61 R11: ffffffff8b846309 R12: 000000000045a920
R13: ffffc9000224f598 R14: ffffc9000224f678 R15: ffffc9000224f578
FS:  0000000001d56940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a06a5000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __sprint_symbol+0xb7/0x1e0 kernel/kallsyms.c:365
 sprint_symbol+0x25/0x30 kernel/kallsyms.c:396
 symbol_string+0x16f/0x230 lib/vsprintf.c:961
 pointer+0x17b/0x740 lib/vsprintf.c:2188
 vsnprintf+0x6b6/0x19a0 lib/vsprintf.c:2578
 vscnprintf+0x2d/0x80 lib/vsprintf.c:2677
 vprintk_store+0x44/0x4a0 kernel/printk/printk.c:1917
 vprintk_emit+0x135/0x700 kernel/printk/printk.c:1978
 vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
 vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:386
 printk+0xba/0xed kernel/printk/printk.c:2056
 show_ip+0x27/0x38 arch/x86/kernel/dumpstack.c:124
 show_iret_regs+0x14/0x38 arch/x86/kernel/dumpstack.c:131
 __show_regs+0x1c/0x60 arch/x86/kernel/process_64.c:74
 show_regs_if_on_stack.constprop.0+0x39/0x3c arch/x86/kernel/dumpstack.c:149
 show_trace_log_lvl+0x25d/0x28c arch/x86/kernel/dumpstack.c:274
 show_stack+0x39/0x3b arch/x86/kernel/dumpstack.c:293
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6798
 __might_sleep+0x95/0x190 kernel/sched/core.c:6751
 do_user_addr_fault arch/x86/mm/fault.c:1400 [inline]
 do_page_fault+0x378/0x12e1 arch/x86/mm/fault.c:1517
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:189 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_64+0x2c9/0x790 arch/x86/entry/common.c:304
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc9000224ff20 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88809b036480 RCX: ffffffff8100a857
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc9000224ff48 R08: ffff88809b036480 R09: ffffed1013606c91
R10: ffffed1013606c90 R11: ffff88809b036487 R12: ffffc9000224ff58
R13: 0000000000000000 R14: 0000000000004000 R15: 0000000000000000
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
invalid opcode: 0000 [#2] PREEMPT SMP KASAN
CPU: 1 PID: 9745 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x3a/0x70 arch/x86/entry/vsyscall/vsyscall_64.c:344
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <60> ff 48 89 de e8 7c b7 74 00 48 81 fb 00 00 60 ff 74 10 e8 ce b5
RSP: 0018:ffffc9000224ea60 EFLAGS: 00010847
RAX: ffff88809b036480 RBX: 0000000000000000 RCX: ffffffff816c3c90
RDX: 0000000000000000 RSI: ffffffff816c3cbb RDI: 000000000045a920
RBP: ffffc9000224eaa0 R08: ffff88809b036480 R09: ffffed1015d24b6e
R10: ffffed1015d24b6d R11: ffff8880ae925b6f R12: 000000000045a920
R13: ffffc9000224eb20 R14: ffffc9000224ec00 R15: ffffc9000224eb00
FS:  0000000001d56940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a06a5000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __sprint_symbol+0xb7/0x1e0 kernel/kallsyms.c:365
 sprint_symbol+0x25/0x30 kernel/kallsyms.c:396
 symbol_string+0x16f/0x230 lib/vsprintf.c:961
 pointer+0x17b/0x740 lib/vsprintf.c:2188
 vsnprintf+0x6b6/0x19a0 lib/vsprintf.c:2578
 vscnprintf+0x2d/0x80 lib/vsprintf.c:2677
 printk_safe_log_store+0x106/0x270 kernel/printk/printk_safe.c:93
 vprintk_safe kernel/printk/printk_safe.c:346 [inline]
 vprintk_func+0x131/0x189 kernel/printk/printk_safe.c:383
 printk+0xba/0xed kernel/printk/printk.c:2056
 show_ip+0x27/0x38 arch/x86/kernel/dumpstack.c:124
 show_iret_regs+0x14/0x38 arch/x86/kernel/dumpstack.c:131
 __show_regs+0x1c/0x60 arch/x86/kernel/process_64.c:74
 show_regs_if_on_stack.constprop.0+0x39/0x3c arch/x86/kernel/dumpstack.c:149
 show_trace_log_lvl+0x25d/0x28c arch/x86/kernel/dumpstack.c:274
 show_regs arch/x86/kernel/dumpstack.c:447 [inline]
 show_regs.cold+0x1a/0x1f arch/x86/kernel/dumpstack.c:437
 __die_body+0x1b/0x60 arch/x86/kernel/dumpstack.c:392
 __die+0x26/0x37 arch/x86/kernel/dumpstack.c:406
 die+0x2b/0x50 arch/x86/kernel/dumpstack.c:419
 do_trap_no_signal arch/x86/kernel/traps.c:207 [inline]
 do_trap+0x101/0x230 arch/x86/kernel/traps.c:246
 do_error_trap+0xd6/0x200 arch/x86/kernel/traps.c:273
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:in_gate_area_no_mm+0x3a/0x70 arch/x86/entry/vsyscall/vsyscall_64.c:344
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <60> ff 48 89 de e8 7c b7 74 00 48 81 fb 00 00 60 ff 74 10 e8 ce b5
RSP: 0018:ffffc9000224f4d8 EFLAGS: 00010082
RAX: ffff88809b036480 RBX: 0000000000000000 RCX: ffffffff816c3c90
RDX: 0000000000000000 RSI: ffffffff816c3cbb RDI: 000000000045a920
RBP: ffffc9000224f518 R08: ffff88809b036480 R09: fffffbfff1708c62
R10: fffffbfff1708c61 R11: ffffffff8b846309 R12: 000000000045a920
R13: ffffc9000224f598 R14: ffffc9000224f678 R15: ffffc9000224f578
 __sprint_symbol+0xb7/0x1e0 kernel/kallsyms.c:365
 sprint_symbol+0x25/0x30 kernel/kallsyms.c:396
 symbol_string+0x16f/0x230 lib/vsprintf.c:961
 pointer+0x17b/0x740 lib/vsprintf.c:2188
 vsnprintf+0x6b6/0x19a0 lib/vsprintf.c:2578
 vscnprintf+0x2d/0x80 lib/vsprintf.c:2677
 vprintk_store+0x44/0x4a0 kernel/printk/printk.c:1917
 vprintk_emit+0x135/0x700 kernel/printk/printk.c:1978
 vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
 vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:386
 printk+0xba/0xed kernel/printk/printk.c:2056
 show_ip+0x27/0x38 arch/x86/kernel/dumpstack.c:124
 show_iret_regs+0x14/0x38 arch/x86/kernel/dumpstack.c:131
 __show_regs+0x1c/0x60 arch/x86/kernel/process_64.c:74
 show_regs_if_on_stack.constprop.0+0x39/0x3c arch/x86/kernel/dumpstack.c:149
 show_trace_log_lvl+0x25d/0x28c arch/x86/kernel/dumpstack.c:274
 show_stack+0x39/0x3b arch/x86/kernel/dumpstack.c:293
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6798
 __might_sleep+0x95/0x190 kernel/sched/core.c:6751
 do_user_addr_fault arch/x86/mm/fault.c:1400 [inline]
 do_page_fault+0x378/0x12e1 arch/x86/mm/fault.c:1517
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:189 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_64+0x2c9/0x790 arch/x86/entry/common.c:304
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
Lost 37 message(s)!

