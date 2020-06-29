Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8586DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6541A206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390635AbgF2VOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbgF2S5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:42 -0400
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0946C030F1E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:31:16 -0700 (PDT)
Received: by mail-il1-x148.google.com with SMTP id l11so12713854ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JU0OFYSCf7ip3p9atR+fgYE+seqEE1jACAmxOD6wF2A=;
        b=SLVstluegwFxN+H3NZR+RVoOAWQoousDQsMEhfiFzhYgiK1n/nmn10r5VpwAN2s7VN
         LN+lvj8dFc9vwVMPMonbfpBPLAr7KOmfwtcmobNXDakc/H4uIlXgcdduDHFkl3zr9DAE
         VZdCdsgcl6muep9Xa+2gYWt2HkHbDV9diOy+0d5OEgUuDtcFvsBhrekp9sEnPUdthZcT
         xTsb9+MdahI+OYipG2berwwHusNsPm83+8KvVKCLUWrnJ9MZ6BxuhTs5+c6LjRHvjUna
         InJu/z8AHgueKjlGquOTglMZ9Z2xpUNL8XPI3Ie4097B8iXvchiTaoy5IqcL8zWtj28K
         yCsw==
X-Gm-Message-State: AOAM532H+0e5YnaMEt9LYKnD5fb+AvrKUDndCRuSWyacZOqS403L3dem
        dpKaNc9TSNY870apnUKKi00NDtduzH+muwIoGV4pSdeSpYx9
X-Google-Smtp-Source: ABdhPJzNnzNNZ+8Mo5pKXQj91xaxcAan7cTQ7f7+zQM0bPeqpPjuE0us80Cv7CFUfuu4W9rcc7+1LxiEo0OsurNn8znn+0YqH81w
MIME-Version: 1.0
X-Received: by 2002:a02:6c07:: with SMTP id w7mr18874452jab.33.1593448276148;
 Mon, 29 Jun 2020 09:31:16 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:31:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077c48b05a93b96fa@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in __syscall_return_slowpath
From:   syzbot <syzbot+95910cea1a7ad8850a0f@syzkaller.appspotmail.com>
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

HEAD commit:    4e99b321 Merge tag 'nfs-for-5.8-2' of git://git.linux-nfs...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116abdd3100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=95910cea1a7ad8850a0f
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17020755100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+95910cea1a7ad8850a0f@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 000000000000000f
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8079 Comm: systemd-udevd Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__syscall_return_slowpath+0x0/0x280 arch/x86/entry/common.c:309
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cd7f38 EFLAGS: 00010283
RAX: 000000000000000f RBX: 0000000000000002 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff81bc66f2 RDI: ffffc90004cd7f58
RBP: ffffc90004cd7f58 R08: 0000000000000000 R09: ffff8880ae636cdb
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f934b3b78c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000000f CR3: 000000008ebc4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:368
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 
Oops: 0002 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 8079 Comm: systemd-udevd Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cd7478 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc90004cd7518 RCX: ffffffff8169f800
RDX: ffff888091d90300 RSI: ffffffff8169f82b RDI: 00007f934a4fe840
RBP: 00007f934a4fe840 R08: ffffc90004cd7628 R09: ffffffff8c8c8109
R10: 00007f934a4fe840 R11: 0000000000000000 R12: ffffc90004cd7628
R13: 0000000000000001 R14: 00007f934a4fe840 R15: ffffc90004cd7538
FS:  00007f934b3b78c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000008ebc4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 is_kernel include/linux/kallsyms.h:43 [inline]
 is_ksym_addr include/linux/kallsyms.h:49 [inline]
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
 do_user_addr_fault arch/x86/mm/fault.c:1268 [inline]
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xc29/0x14c0 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:__syscall_return_slowpath+0x0/0x280 arch/x86/entry/common.c:309
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cd7f38 EFLAGS: 00010283
RAX: 000000000000000f RBX: 0000000000000002 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff81bc66f2 RDI: ffffc90004cd7f58
RBP: ffffc90004cd7f58 R08: 0000000000000000 R09: ffff8880ae636cdb
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:368
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 
Oops: 0002 [#3] PREEMPT SMP KASAN
CPU: 0 PID: 8079 Comm: systemd-udevd Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cd6988 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc90004cd6a28 RCX: ffffffff8169f800
RDX: ffff888091d90300 RSI: ffffffff8169f82b RDI: 00007f934a4fe840
RBP: 00007f934a4fe840 R08: ffffc90004cd6b38 R09: ffff8880ae623d52
R10: 00007f934a4fe840 R11: 0000000000000001 R12: ffffc90004cd6b38
R13: 0000000000000001 R14: 00007f934a4fe840 R15: ffffc90004cd6a48
FS:  00007f934b3b78c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000008ebc4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 is_kernel include/linux/kallsyms.h:43 [inline]
 is_ksym_addr include/linux/kallsyms.h:49 [inline]
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
 do_user_addr_fault arch/x86/mm/fault.c:1242 [inline]
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0x946/0x14c0 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cd7478 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc90004cd7518 RCX: ffffffff8169f800
RDX: ffff888091d90300 RSI: ffffffff8169f82b RDI: 00007f934a4fe840
RBP: 00007f934a4fe840 R08: ffffc90004cd7628 R09: ffffffff8c8c8109
R10: 00007f934a4fe840 R11: 0000000000000000 R12: ffffc90004cd7628
R13: 0000000000000001 R14: 00007f934a4fe840 R15: ffffc90004cd7538
 is_kernel include/linux/kallsyms.h:43 [inline]
 is_ksym_addr include/linux/kallsyms.h:49 [inline]
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
 do_user_addr_fault arch/x86/mm/fault.c:1268 [inline]
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xc29/0x14c0 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:__syscall_return_slowpath+0x0/0x280 arch/x86/entry/common.c:309
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 0
Lost 40 message(s)!


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
