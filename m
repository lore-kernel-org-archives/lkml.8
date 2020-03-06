Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C67BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE832072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgCFF1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 00:27:17 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:37731 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgCFF1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 00:27:17 -0500
Received: by mail-il1-f197.google.com with SMTP id c3so96947ilm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 21:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XpNzTvzq5EHM5WEsacHC/1juJjuwUn9CLnulicmybuc=;
        b=GV1aWBmiMHcBC5kwf9U+RWwqR6WgcCl6SSr2+FWdfPRXWEcJTZeykSdxOWSlC4Clp4
         Zx8EfRnZf41beTZMXyKdb3iThddeA885xmd/m0TKpMLdrYc70saTkyOJIeq1kvcigV3+
         9/JlHxsl06CikqXQhe3K3hMvoGc79CGGt3rr+U4jzu3Dj5+1DBVTAyRZup+uTo2GW0DC
         KEFecEh0tuGsRE35IJJGfgXNt4QYIdAhOYnjlEh0QbSYcNZ9MoE+HnagmgJAt8oRcNyR
         9cU6qduqZl+zIc1fcbBQ6KG8L1dj6GArdf29txaG2Yq8JBiQHE5aTljhogdWwWtdNXGM
         9I7g==
X-Gm-Message-State: ANhLgQ3okt2z/ZOaY+mUIeSZE7KAa/eF+GeWpVRPxwGXdh3/leC9fG95
        vTw+WpDtAD9u5Yn5zp2Sr8NvEpa1vzjrSB5nspJhIEeFBvoi
X-Google-Smtp-Source: ADFU+vuha1tM16qQIo8iZp2i8jMWDrpAwS/MsWYB+cNdZz7WlQhBQsCtlwgaOjvqAY80jW+hFsFH2MiSpPJNqP0UjbWkRnlkETaf
MIME-Version: 1.0
X-Received: by 2002:a02:85cc:: with SMTP id d70mr1359122jai.107.1583472433557;
 Thu, 05 Mar 2020 21:27:13 -0800 (PST)
Date:   Thu, 05 Mar 2020 21:27:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9fbaa05a028e759@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in
 do_syscall_64 (2)
From:   syzbot <syzbot+d6d57d324860c94d5836@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11813529e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=d6d57d324860c94d5836
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d6d57d324860c94d5836@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 464fa067 P4D 464fa067 PUD 94e6f067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 410 Comm: syz-executor.3 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:189 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_64+0x2c9/0x790 arch/x86/entry/common.c:304
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900073cff20 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888054c1e200 RCX: ffffffff8100a857
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc900073cff48 R08: ffff888054c1e200 R09: ffffed100a983c41
R10: ffffed100a983c40 R11: ffff888054c1e207 R12: ffffc900073cff58
R13: 0000000000000000 R14: 0000000000004000 R15: 0000000000000000
FS:  000000000285a940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000047f4e000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
invalid opcode: 0000 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 410 Comm: syz-executor.3 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x3a/0x70 arch/x86/entry/vsyscall/vsyscall_64.c:344
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <60> ff 48 89 de e8 7c b7 74 00 48 81 fb 00 00 60 ff 74 10 e8 ce b5
RSP: 0018:ffffc900073cf398 EFLAGS: 00010046
RAX: ffff888054c1e200 RBX: 0000000000000000 RCX: ffffffff816c3c90
RDX: 0000000000000000 RSI: ffffffff816c3cbb RDI: 000000000045a941
RBP: ffffc900073cf3d8 R08: ffff888054c1e200 R09: fffffbfff1708c62
R10: fffffbfff1708c61 R11: ffffffff8b846309 R12: 000000000045a941
R13: ffffc900073cf458 R14: ffffc900073cf538 R15: ffffc900073cf438
FS:  000000000285a940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000047f4e000 CR4: 00000000001426f0
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
 show_regs arch/x86/kernel/dumpstack.c:447 [inline]
 show_regs.cold+0x1a/0x1f arch/x86/kernel/dumpstack.c:437
 __die_body+0x1b/0x60 arch/x86/kernel/dumpstack.c:392
 __die+0x26/0x37 arch/x86/kernel/dumpstack.c:406
 no_context+0x596/0xa30 arch/x86/mm/fault.c:821
 __bad_area_nosemaphore+0xae/0x420 arch/x86/mm/fault.c:913
 __bad_area arch/x86/mm/fault.c:934 [inline]
 bad_area+0x69/0x80 arch/x86/mm/fault.c:940
 do_user_addr_fault arch/x86/mm/fault.c:1405 [inline]
 do_page_fault+0xc17/0x12e1 arch/x86/mm/fault.c:1517
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:189 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_64+0x2c9/0x790 arch/x86/entry/common.c:304
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900073cff20 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888054c1e200 RCX: ffffffff8100a857
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc900073cff48 R08: ffff888054c1e200 R09: ffffed100a983c41
R10: ffffed100a983c40 R11: ffff888054c1e207 R12: ffffc900073cff58
R13: 0000000000000000 R14: 0000000000004000 R15: 0000000000000000
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
invalid opcode: 0000 [#3] PREEMPT SMP KASAN
CPU: 0 PID: 410 Comm: syz-executor.3 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x3a/0x70 arch/x86/entry/vsyscall/vsyscall_64.c:344
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <60> ff 48 89 de e8 7c b7 74 00 48 81 fb 00 00 60 ff 74 10 e8 ce b5
RSP: 0018:ffffc900073ce920 EFLAGS: 00010046
RAX: ffff888054c1e200 RBX: 0000000000000000 RCX: ffffffff816c3c90
RDX: 0000000000000000 RSI: ffffffff816c3cbb RDI: 000000000045a941
RBP: ffffc900073ce960 R08: ffff888054c1e200 R09: ffffed1015d04b78
R10: ffffed1015d04b77 R11: ffff8880ae825bb9 R12: 000000000045a941
R13: ffffc900073ce9e0 R14: ffffc900073ceac0 R15: ffffc900073ce9c0
FS:  000000000285a940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000047f4e000 CR4: 00000000001426f0
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
RSP: 0018:ffffc900073cf398 EFLAGS: 00010046
RAX: ffff888054c1e200 RBX: 0000000000000000 RCX: ffffffff816c3c90
RDX: 0000000000000000 RSI: ffffffff816c3cbb RDI: 000000000045a941
RBP: ffffc900073cf3d8 R08: ffff888054c1e200 R09: fffffbfff1708c62
R10: fffffbfff1708c61 R11: ffffffff8b846309 R12: 000000000045a941
R13: ffffc900073cf458 R14: ffffc900073cf538 R15: ffffc900073cf438
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
 show_regs arch/x86/kernel/dumpstack.c:447 [inline]
 show_regs.cold+0x1a/0x1f arch/x86/kernel/dumpstack.c:437
 __die_body+0x1b/0x60 arch/x86/kernel/dumpstack.c:392
 __die+0x26/0x37 arch/x86/kernel/dumpstack.c:406
 no_context+0x596/0xa30 arch/x86/mm/fault.c:821
 __bad_area_nosemaphore+0xae/0x420 arch/x86/mm/fault.c:913
 bad_a
Lost 42 message(s)!


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
