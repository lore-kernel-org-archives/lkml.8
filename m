Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B7020738
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGZIDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:03:21 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:44335 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgGZIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:03:21 -0400
Received: by mail-il1-f198.google.com with SMTP id y82so1774528ilk.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 01:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Vzx3Ae9/OKZUIVyhcdjCsJEgykS+XJVRo/HJWYwNn0c=;
        b=O4wa4txLEufdBRF6WU+TB8zZ6nVt+XAOWIBq8y0LUAUl9c7JHYn1023+3T6IrWj6gb
         tAxMKwSV//gaX8LaAwd6uhbHkAPj1sYQW4J9UdKdbBeq3Lf0nYQxiOSATr//i8mAm0cr
         715d97lQJWlnKjnXLZDw77eOPIGIyd766ei9MHpLqdgKlq3QtIdlhWbUseFu0uDA4eEf
         kJ6puEra03z6+BwTtQnTt4CSy8pW23w5VhaPcG71BQey/T1aBBH0UYqCBU8bSNHiByHf
         ZejS/37xrnRYf8iJhr60vo24d3fNkaFk2IPlQSJvnkFGB1/K2VZtOtorsg5NfzYW+i34
         Hgiw==
X-Gm-Message-State: AOAM5328ZLQ4V2EY0JR1XI7jRSU4N53covrQZPHxbWctSqYZvSs+m42o
        2SWjN0fecoPJPe/GzKh8tHTQ7buK0VN4OPtqen+T24pSemwt
X-Google-Smtp-Source: ABdhPJyi8O3bSeVgBhBiyzTHOQA1womaP/ydKSMkLJjl+ttianezluYJSQqmHth5i5DlsaLO3419bG8a8D9MWQRiwBL+x360ICcc
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2411:: with SMTP id z17mr19637232jat.50.1595750599648;
 Sun, 26 Jul 2020 01:03:19 -0700 (PDT)
Date:   Sun, 26 Jul 2020 01:03:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a46a7505ab53a387@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in do_syscall_32_irqs_on
From:   syzbot <syzbot+0e3a50ab9ac2fdf9ffc6@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    23ee3e4e Merge tag 'pci-v5.8-fixes-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a4c7d8900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=0e3a50ab9ac2fdf9ffc6
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168fe3a0900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e3a50ab9ac2fdf9ffc6@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 94d49067 P4D 94d49067 PUD a1c93067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6854 Comm: syz-executor.3 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:428
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900017b7f28 EFLAGS: 00010296
RAX: 0000000000000000 RBX: ffffc900017b7f58 RCX: 1ffff920002f6fd2
RDX: ffff888098bb4240 RSI: ffffffff81c214b2 RDI: 0000000000000005
RBP: ffffc900017b7f58 R08: 0000000000000001 R09: ffff888098bb4b08
R10: 00000000ffffff8c R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:000000000a292900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a1b88000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __do_fast_syscall_32 arch/x86/entry/common.c:475 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:503
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 94d49067 P4D 94d49067 PUD a1c93067 PMD 0 
Oops: 0002 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 6854 Comm: syz-executor.3 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900017b7440 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900017b74e0 RCX: ffffffff816a62f0
RDX: ffff888098bb4240 RSI: ffffffff816a631b RDI: 00000000f7f83569
RBP: 00000000f7f83569 R08: ffffc900017b75f0 R09: ffffffff8c8d7109
R10: 00000000f7f83569 R11: 0000000000000000 R12: ffffc900017b75f0
R13: 0000000000000001 R14: 00000000f7f83569 R15: ffffc900017b7500
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:000000000a292900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a1b88000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 is_kernel include/linux/kallsyms.h:44 [inline]
 is_ksym_addr include/linux/kallsyms.h:50 [inline]
 kallsyms_lookup+0xc3/0x2e0 kernel/kallsyms.c:290
 __sprint_symbol+0x9c/0x1c0 kernel/kallsyms.c:363
 symbol_string+0x14c/0x370 lib/vsprintf.c:969
 pointer+0x185/0x970 lib/vsprintf.c:2226
 vsnprintf+0x5b2/0x14f0 lib/vsprintf.c:2624
 vscnprintf+0x29/0x80 lib/vsprintf.c:2723
 vprintk_store+0x44/0x4a0 kernel/printk/printk.c:1942
 vprintk_emit+0x139/0x770 kernel/printk/printk.c:2003
 vprintk_func+0x8f/0x1a6 kernel/printk/printk_safe.c:393
 printk+0xba/0xed kernel/printk/printk.c:2070
 show_ip+0x22/0x30 arch/x86/kernel/dumpstack.c:124
 show_iret_regs+0x10/0x32 arch/x86/kernel/dumpstack.c:131
 __show_regs+0x18/0x50 arch/x86/kernel/process_64.c:72
 show_trace_log_lvl+0x255/0x2b4 arch/x86/kernel/dumpstack.c:274
 show_regs arch/x86/kernel/dumpstack.c:447 [inline]
 __die_body arch/x86/kernel/dumpstack.c:393 [inline]
 __die+0x51/0x90 arch/x86/kernel/dumpstack.c:407
 no_context+0x56b/0x9f0 arch/x86/mm/fault.c:695
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x8ce/0xd00 arch/x86/mm/fault.c:1258
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:542
RIP: 0010:do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:428
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900017b7f28 EFLAGS: 00010296
RAX: 0000000000000000 RBX: ffffc900017b7f58 RCX: 1ffff920002f6fd2
RDX: ffff888098bb4240 RSI: ffffffff81c214b2 RDI: 0000000000000005
RBP: ffffc900017b7f58 R08: 0000000000000001 R09: ffff888098bb4b08
R10: 00000000ffffff8c R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 __do_fast_syscall_32 arch/x86/entry/common.c:475 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:503
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 94d49067 P4D 94d49067 PUD a1c93067 PMD 0 
Oops: 0002 [#3] PREEMPT SMP KASAN
CPU: 0 PID: 6854 Comm: syz-executor.3 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900017b6930 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900017b69d0 RCX: ffffffff816a62f0
RDX: ffff888098bb4240 RSI: ffffffff816a631b RDI: 00000000f7f83569
RBP: 00000000f7f83569 R08: ffffc900017b6ae0 R09: ffff8880ae623dcd
R10: 00000000f7f83569 R11: 0000000000000001 R12: ffffc900017b6ae0
R13: 0000000000000001 R14: 00000000f7f83569 R15: ffffc900017b69f0
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:000000000a292900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a1b88000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 is_kernel include/linux/kallsyms.h:44 [inline]
 is_ksym_addr include/linux/kallsyms.h:50 [inline]
 kallsyms_lookup+0xc3/0x2e0 kernel/kallsyms.c:290
 __sprint_symbol+0x9c/0x1c0 kernel/kallsyms.c:363
 symbol_string+0x14c/0x370 lib/vsprintf.c:969
 pointer+0x185/0x970 lib/vsprintf.c:2226
 vsnprintf+0x5b2/0x14f0 lib/vsprintf.c:2624
 vscnprintf+0x29/0x80 lib/vsprintf.c:2723
 printk_safe_log_store+0xf5/0x250 kernel/printk/printk_safe.c:94
 vprintk_safe kernel/printk/printk_safe.c:347 [inline]
 vprintk_func+0xef/0x1a6 kernel/printk/printk_safe.c:390
 printk+0xba/0xed kernel/printk/printk.c:2070
 show_ip+0x22/0x30 arch/x86/kernel/dumpstack.c:124
 show_iret_regs+0x10/0x32 arch/x86/kernel/dumpstack.c:131
 __show_regs+0x18/0x50 arch/x86/kernel/process_64.c:72
 show_trace_log_lvl+0x255/0x2b4 arch/x86/kernel/dumpstack.c:274
 show_regs arch/x86/kernel/dumpstack.c:447 [inline]
 __die_body arch/x86/kernel/dumpstack.c:393 [inline]
 __die+0x51/0x90 arch/x86/kernel/dumpstack.c:407
 no_context+0x56b/0x9f0 arch/x86/mm/fault.c:695
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:542
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900017b7440 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900017b74e0 RCX: ffffffff816a62f0
RDX: ffff888098bb4240 RSI: ffffffff816a631b RDI: 00000000f7f83569
RBP: 00000000f7f83569 R08: ffffc900017b75f0 R09: ffffffff8c8d7109
R10: 00000000f7f83569 R11: 0000000000000000 R12: ffffc900017b75f0
R13: 0000000000000001 R14: 00000000f7f83569 R15: ffffc900017b7500
 is_kernel include/linux/kallsyms.h:44 [inline]
 is_ksym_addr include/linux/kallsyms.h:50 [inline]
 kallsyms_lookup+0xc3/0x2e0 kernel/kallsyms.c:290
 __sprint_symbol+0x9c/0x1c0 kernel/kallsyms.c:363
 symbol_string+0x14c/0x370 lib/vsprintf.c:969
 pointer+0x185/0x970 lib/vsprintf.c:2226
 vsnprintf+0x5b2/0x14f0 lib/vsprintf.c:2624
 vscnprintf+0x29/0x80 lib/vsprintf.c:2723
 vprintk_store+0x44/0x4a0 kernel/printk/printk.c:1942
 vprintk_emit+0x139/0x770 kernel/printk/printk.c:2003
 vprintk_func+0x8f/0x1a6 kernel/printk/printk_safe.c:393
 printk+0xba/0xed kernel/printk/printk.c:2070
 show_ip+0x22/0x30 arch/x86/kernel/dumpstack.c:124
 show_iret_regs+0x10/0x32 arch/x86/kernel/dumpstack.c:131
 __show_regs+0x18/0x50 arch/x86/kernel/process_64.c:72
 show_trace_log_lvl+0x255/0x2b4 arch/x86/kernel/dumpstack.c:274
 show_regs arch/x86/kernel/dumpstack.c:447 [inline]
 __die_body arch/x86/kernel/dumpstack.c:393 [inline]
 __die+0x51/0x90 arch/x86/kernel/dumpstack.c:407
 no_context+0x56b/0x9f0 arch/x86/mm/fault.c:695
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x8ce/0xd00 arch/x86/mm/fault.c:1258
Lost 45 message(s)!


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
