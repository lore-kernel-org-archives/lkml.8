Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8232EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557FB21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgGaDOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:14:23 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40199 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbgGaDOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 23:14:22 -0400
Received: by mail-il1-f199.google.com with SMTP id z16so20633461ill.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 20:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aDbaOWBAHLaPkmTLRxLNNFk54PZMakuGLolLviyvaOM=;
        b=oIlb0I3roqF8abe/Zv+MTk+VS/KNB9iPgixAqcqD6zpAjWmWubp3of7Xgcim6xhkEB
         qmZiavXSutt4PL7bWzO6cHYoma3Ne6hmQRVx5WCmp3lhSe5goZoWtUUMKKLlqINaiv9k
         HCxp/X5ZAzsghhz/cbB2e3AeVbw2toOCjOJac7+UqfefOrFWL2/GwgSj1J91aSB5JUlM
         UpDNx0+PWVMbJ8NmNuhbTHmd9AA7cez/+Gmk8H31CBSKwNS2D/uWXSROBquXqmmvCXIn
         p3rMjXdthzqDTB3mlLfwMTf1+78rBUNowQLlpWbLSDumdc9NaphI0XxYXlYRH+c5wNYk
         K44w==
X-Gm-Message-State: AOAM533C9PQtvBI6OGFfoHMLjAY+PBXk/E4pUO1M2xnzk9OfkGDRhTtd
        s69pn89G2/uA+K2JqeD0B8t2wW5UMfFjbknAapMEGgyr3a5t
X-Google-Smtp-Source: ABdhPJx2p7JdBX5VB0joXmWL8838/GUAMNmi05HfnYEoTY6BqlqnspQji0WH9S5Vlsqzaxs8Mf1tRKrbO3Q6wOBr6ZNfu7pOYcqd
MIME-Version: 1.0
X-Received: by 2002:a02:3b10:: with SMTP id c16mr2684440jaa.128.1596165260837;
 Thu, 30 Jul 2020 20:14:20 -0700 (PDT)
Date:   Thu, 30 Jul 2020 20:14:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000600a5c05abb42f03@google.com>
Subject: BUG: unable to handle kernel paging request in __syscall_return_slowpath
From:   syzbot <syzbot+8c37a0f3f00cf0dc8cfd@syzkaller.appspotmail.com>
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

HEAD commit:    04300d66 Merge tag 'riscv-for-linus-5.8-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e6fb64900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=8c37a0f3f00cf0dc8cfd
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c88a9c900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1101b8a8900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1301b8a8900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1501b8a8900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c37a0f3f00cf0dc8cfd@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffffffffffffe
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9a7c067 P4D 9a7c067 PUD 9a7e067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3892 Comm: systemd-udevd Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__syscall_return_slowpath+0x0/0x280 arch/x86/entry/common.c:332
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900015b7f38 EFLAGS: 00010283
RAX: fffffffffffffffe RBX: 0000000000000015 RCX: 1ffff920002b6fd5
RDX: ffff88809d834000 RSI: ffffffff81bcb65f RDI: ffffc900015b7f58
RBP: ffffc900015b7f58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f0863b0d8c0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffffe CR3: 000000009a278000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 
Oops: 0002 [#2] PREEMPT SMP KASAN
CPU: 1 PID: 3892 Comm: systemd-udevd Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900015b74a0 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900015b7540 RCX: ffffffff816a6330
RDX: ffff88809d834000 RSI: ffffffff816a635b RDI: 00007f08629809c7
RBP: 00007f08629809c7 R08: ffffc900015b7650 R09: ffffffff8c8d7109
R10: 00007f08629809c7 R11: 0000000000000000 R12: ffffc900015b7650
R13: 0000000000000001 R14: 00007f08629809c7 R15: ffffc900015b7560
FS:  00007f0863b0d8c0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000009a278000 CR4: 00000000001406e0
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
 show_ip+0x22/0x30 arch/x86/kernel/dumpstack.c:131
 show_iret_regs+0x10/0x32 arch/x86/kernel/dumpstack.c:138
 __show_regs+0x18/0x50 arch/x86/kernel/process_64.c:72
 show_trace_log_lvl+0x255/0x2b4 arch/x86/kernel/dumpstack.c:281
 show_regs arch/x86/kernel/dumpstack.c:454 [inline]
 __die_body arch/x86/kernel/dumpstack.c:400 [inline]
 __die+0x51/0x90 arch/x86/kernel/dumpstack.c:414
 no_context+0x56b/0x9f0 arch/x86/mm/fault.c:695
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_kern_addr_fault+0x5b/0x6f arch/x86/mm/fault.c:1130
 handle_page_fault arch/x86/mm/fault.c:1363 [inline]
 exc_page_fault+0x14c/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:542
RIP: 0010:__syscall_return_slowpath+0x0/0x280 arch/x86/entry/common.c:332
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900015b7f38 EFLAGS: 00010283
RAX: fffffffffffffffe RBX: 0000000000000015 RCX: 1ffff920002b6fd5
RDX: ffff88809d834000 RSI: ffffffff81bcb65f RDI: ffffc900015b7f58
RBP: ffffc900015b7f58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 
Oops: 0002 [#3] PREEMPT SMP KASAN
CPU: 1 PID: 3892 Comm: systemd-udevd Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900015b6990 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900015b6a30 RCX: ffffffff816a6330
RDX: ffff88809d834000 RSI: ffffffff816a635b RDI: 00007f08629809c7
RBP: 00007f08629809c7 R08: ffffc900015b6b40 R09: ffff8880ae723d62
R10: 00007f08629809c7 R11: 0000000000000001 R12: ffffc900015b6b40
R13: 0000000000000001 R14: 00007f08629809c7 R15: ffffc900015b6a50
FS:  00007f0863b0d8c0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000009a278000 CR4: 00000000001406e0
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
 show_ip+0x22/0x30 arch/x86/kernel/dumpstack.c:131
 show_iret_regs+0x10/0x32 arch/x86/kernel/dumpstack.c:138
 __show_regs+0x18/0x50 arch/x86/kernel/process_64.c:72
 show_trace_log_lvl+0x255/0x2b4 arch/x86/kernel/dumpstack.c:281
 show_regs arch/x86/kernel/dumpstack.c:454 [inline]
 __die_body arch/x86/kernel/dumpstack.c:400 [inline]
 __die+0x51/0x90 arch/x86/kernel/dumpstack.c:414
 no_context+0x56b/0x9f0 arch/x86/mm/fault.c:695
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:542
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900015b74a0 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900015b7540 RCX: ffffffff816a6330
RDX: ffff88809d834000 RSI: ffffffff816a635b RDI: 00007f08629809c7
RBP: 00007f08629809c7 R08: ffffc900015b7650 R09: ffffffff8c8d7109
R10: 00007f08629809c7 R11: 0000000000000000 R12: ffffc900015b7650
R13: 0000000000000001 R14: 00007f08629809c7 R15: ffffc900015b7560
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
 show_ip+0x22/0x30 arch/x86/kernel/dumpstack.c:131
 show_iret_regs+0x10/0x32 arch/x86/kernel/dumpstack.c:138
 __show_regs+0x18/0x50 arch/x86/kernel/process_64.c:72
 show_trace_log_lvl+0x255/0x2b4 arch/x86/kernel/dumpstack.c:281
 show_regs arch/x86/kernel/dumpstack.c:454 [inline]
 __die_body arch/x86/kernel/dumpstack.c:400 [inline]
 __die+0x51/0x90 arch/x86/kernel/dumpstack.c:414
 no_context+0x56b/0x9f0 arch/x86/mm/fault.c:695
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_kern_addr_fault+0x5b/0x6f arch/x86/mm/fault.c:1130
 handle_page_fault arch/x86/mm/fault.c:1363 [inline]
 exc_page_fault+0x14c/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:542
RIP: 0010:__syscall_return_slowpath+0x0/0x280 arch/x86/entry/common.c:332
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
Lost 40 message(s)!


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
