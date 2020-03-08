Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB5DC18E5F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 07:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A07220828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 07:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCHHpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 03:45:13 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:54075 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCHHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 03:45:12 -0400
Received: by mail-il1-f199.google.com with SMTP id f6so2669303ilj.20
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 23:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rXVgJarrdoSR3NHBGQMZ4LqLFQZND5a4wuYZA5WPnKA=;
        b=UkHhMOHUJEuoV9hBwr0svbnqb573GbrWuDNIlbRF2jb2JpAP6A7Uimu7ekwevDOdZA
         Lj/rv/+axlr11wkCQs6Jee+JMsJZBVbp5jU3NmNOIv+TrqkGRIZBoXhlJ53miMvDhj57
         k6slKdNdBCEc1xcTD5VaXueIUvWJ8i6ULXwnURGB11ko4a6lLK3cGJ6idOIsyeUvEKnu
         kZQcQJStJHxsjXVpY8v5Px7SIzKBk5+wczTTPGNcH2nTRaKrNNvpCbVx5JeFWub9D0zM
         N0NG5kHsjVkN5vgxN1twTGYWm2TIUoxqaL56dp05YuKX3NKdx1VZezFQfr4hhE4Q6Ndj
         lOvA==
X-Gm-Message-State: ANhLgQ178gKwM3i8cuMJnRajd0xhuaF6MfsRnsRxXdod0Ea5PfB51Bw6
        MyJ+qd4NEyItVDsSTEdvbViZMaZjRjU2igKVpX5wEoOL+Wz1
X-Google-Smtp-Source: ADFU+vuOuKWqnqg3RG0lg631/Hp1OzWCX6MXaCG/LWMkhXGq3qaUkO2U1pvHn07Ei8ZKQLWBR3frS+ETsIAilRfIADTGIy/ehuAW
MIME-Version: 1.0
X-Received: by 2002:a02:c7c2:: with SMTP id s2mr10105748jao.124.1583653511441;
 Sat, 07 Mar 2020 23:45:11 -0800 (PST)
Date:   Sat, 07 Mar 2020 23:45:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff323f05a053100c@google.com>
Subject: general protection fault in syscall_return_slowpath
From:   syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>
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

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cfeac3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0x1ffffffff1255a6b: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/paravirt.h:757 [inline]
RIP: 0010:syscall_return_slowpath+0xeb/0x4a0 arch/x86/entry/common.c:277
Code: 00 10 0f 85 de 00 00 00 e8 b2 a3 76 00 48 c7 c0 58 d3 2a 89 48 c1 e8 03 80 3c 18 00 74 0c 48 c7 c7 58 d3 2a 89 e8 05 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020a7ed0 EFLAGS: 00010246
RAX: 1ffffffff1255a6b RBX: dffffc0000000000 RCX: ffff88808c512380
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900020a7f10 R08: ffffffff810075bb R09: fffffbfff14d9182
R10: fffffbfff14d9182 R11: 0000000000000000 R12: 1ffff110118a2470
R13: 0000000000004000 R14: ffff88808c512380 R15: ffff88808c512380
FS:  000000000154f940(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000076c000 CR3: 00000000a6b05000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 8fecc067 P4D 8fecc067 PUD 97953067 PMD 0 
Oops: 0002 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x60 arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020a7598 EFLAGS: 00010003
RAX: 0000000000000000 RBX: ffffffff81000000 RCX: ffff88808c512380
RDX: ffff88808c512380 RSI: ffffffff8b026000 RDI: 000000000045a920
RBP: ffffc900020a75e8 R08: ffffffff816dd391 R09: ffffffff88150d5e
R10: ffff88808c512380 R11: 0000000000000002 R12: ffffffff8b026000
R13: 000000000045a920 R14: ffffc900020a7610 R15: ffffc900020a7608
FS:  000000000154f940(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a6b05000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __sprint_symbol+0x4c/0x1b0 kernel/kallsyms.c:365
 sprint_symbol+0x24/0x30 kernel/kallsyms.c:396
 symbol_string+0xb3/0x210 lib/vsprintf.c:961
 pointer+0x388/0x7c0 lib/vsprintf.c:2188
 vsnprintf+0xd4c/0x1bc0 lib/vsprintf.c:2578
 vscnprintf+0x2d/0x80 lib/vsprintf.c:2677
 vprintk_store+0x4b/0x6a0 kernel/printk/printk.c:1917
 vprintk_emit+0x12a/0x3a0 kernel/printk/printk.c:1978
 vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
 vprintk_func+0x158/0x170 kernel/printk/printk_safe.c:386
 printk+0x62/0x8d kernel/printk/printk.c:2056
 show_ip arch/x86/kernel/dumpstack.c:124 [inline]
 show_iret_regs+0x40/0x100 arch/x86/kernel/dumpstack.c:131
 __show_regs+0x26/0x760 arch/x86/kernel/process_64.c:74
 show_regs_if_on_stack arch/x86/kernel/dumpstack.c:149 [inline]
 show_trace_log_lvl+0x2e0/0x3e0 arch/x86/kernel/dumpstack.c:274
 show_regs arch/x86/kernel/dumpstack.c:447 [inline]
 __die_body+0x5f/0xa0 arch/x86/kernel/dumpstack.c:392
 die_addr+0xa9/0xe0 arch/x86/kernel/dumpstack.c:432
 do_general_protection+0x325/0x570 arch/x86/kernel/traps.c:564
 general_protection+0x2d/0x40 arch/x86/entry/entry_64.S:1202
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/paravirt.h:757 [inline]
RIP: 0010:syscall_return_slowpath+0xeb/0x4a0 arch/x86/entry/common.c:277
Code: 00 10 0f 85 de 00 00 00 e8 b2 a3 76 00 48 c7 c0 58 d3 2a 89 48 c1 e8 03 80 3c 18 00 74 0c 48 c7 c7 58 d3 2a 89 e8 05 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020a7ed0 EFLAGS: 00010246
RAX: 1ffffffff1255a6b RBX: dffffc0000000000 RCX: ffff88808c512380
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900020a7f10 R08: ffffffff810075bb R09: fffffbfff14d9182
R10: fffffbfff14d9182 R11: 0000000000000000 R12: 1ffff110118a2470
R13: 0000000000004000 R14: ffff88808c512380 R15: ffff88808c512380
 do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 8fecc067 P4D 8fecc067 PUD 97953067 PMD 0 
Oops: 0002 [#3] PREEMPT SMP KASAN
CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x60 arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020a6bf8 EFLAGS: 00010003
RAX: 0000000000000000 RBX: ffffffff81000000 RCX: ffff88808c512380
RDX: ffff88808c512380 RSI: ffffffff8b026000 RDI: 000000000045a920
RBP: ffffc900020a6c48 R08: ffffffff816dd391 R09: ffffffff88150d5e
R10: ffff88808c512380 R11: 0000000000000002 R12: ffffffff8b026000
R13: 000000000045a920 R14: ffffc900020a6c70 R15: ffffc900020a6c68
FS:  000000000154f940(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a6b05000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __sprint_symbol+0x4c/0x1b0 kernel/kallsyms.c:365
 sprint_symbol+0x24/0x30 kernel/kallsyms.c:396
 symbol_string+0xb3/0x210 lib/vsprintf.c:961
 pointer+0x388/0x7c0 lib/vsprintf.c:2188
 vsnprintf+0xd4c/0x1bc0 lib/vsprintf.c:2578
 vscnprintf+0x2d/0x80 lib/vsprintf.c:2677
 printk_safe_log_store+0xda/0x1c0 kernel/printk/printk_safe.c:93
 vprintk_func+0x146/0x170 kernel/printk/printk_safe.c:292
 printk+0x62/0x8d kernel/printk/printk.c:2056
 show_ip arch/x86/kernel/dumpstack.c:124 [inline]
 show_iret_regs+0x40/0x100 arch/x86/kernel/dumpstack.c:131
 __show_regs+0x26/0x760 arch/x86/kernel/process_64.c:74
 show_regs_if_on_stack arch/x86/kernel/dumpstack.c:149 [inline]
 show_trace_log_lvl+0x2e0/0x3e0 arch/x86/kernel/dumpstack.c:274
 show_regs arch/x86/kernel/dumpstack.c:447 [inline]
 __die_body+0x5f/0xa0 arch/x86/kernel/dumpstack.c:392
 __die+0x80/0x90 arch/x86/kernel/dumpstack.c:406
 no_context+0xaee/0xd60 arch/x86/mm/fault.c:821
 __bad_area_nosemaphore+0x108/0x470 arch/x86/mm/fault.c:913
 bad_area_nosemaphore+0x2d/0x40 arch/x86/mm/fault.c:920
 do_user_addr_fault+0x7e1/0xaf0 arch/x86/mm/fault.c:1327
 do_page_fault+0x13b/0x250 arch/x86/mm/fault.c:1517
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:in_gate_area_no_mm+0x0/0x60 arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020a7598 EFLAGS: 00010003
RAX: 0000000000000000 RBX: ffffffff81000000 RCX: ffff88808c512380
RDX: ffff88808c512380 RSI: ffffffff8b026000 RDI: 000000000045a920
RBP: ffffc900020a75e8 R08: ffffffff816dd391 R09: ffffffff88150d5e
R10: ffff88808c512380 R11: 0000000000000002 R12: ffffffff8b026000
R13: 000000000045a920 R14: ffffc900020a7610 R15: ffffc900020a7608
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 8fecc067 P4D 8fecc067 PUD 97953067 PMD 0 
Oops: 0002 [#4] PREEMPT SMP KASAN
CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x60 arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020a6338 EFLAGS: 00010087
RAX: 0000000000000000 RBX: ffffffff81000000 RCX: ffff88808c512380
RDX: ffff88808c512380 RSI: ffffffff8b026000 RDI: ffffffff80ffffff
RBP: ffffc900020a6388 R08: ffffffff816dd391 R09: ffffffff88150d5e
R10: ffff88808c512380 R11: 0000000000000002 R12: ffffffff8b026000
R13: ffffffff80ffffff R14: ffffc900020a63b0 R15: ffffc900020a63a8
FS:  000000000154f940(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a6b05000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 8fecc067 P4D 8fecc067 PUD 97953067 PMD 0 
Oops: 0002 [#5] PREEMPT SMP KASAN
CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x60 arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020a5a78 EFLAGS: 00010087
RAX: 0000000000000000 RBX: ffffffff81000000 RCX: ffff88808c512380
RDX: ffff88808c512380 RSI: ffffffff8b026000 RDI: ffffffff80ffffff
RBP: ffffc900020a5ac8 R08: ffffffff816dd391 R09: ff
Lost 226 message(s)!


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
