Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73896C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B14C20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgF3TwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:52:19 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:54466 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgF3TwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:52:17 -0400
Received: by mail-il1-f197.google.com with SMTP id d18so15415840ill.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2UW3kzwQXekArjjXmSjKLJfqtm9cYPuQnGL3I/oYzcU=;
        b=DqG7KnOuGq/6QSvCry2s/9K9zfAFyHs7/UxE62AMVzxylq5SR/ocWD6YMBngOno5EF
         wKd6BDN3AwhVQ5M8NT9AGJCnlrb7BFCWVwUmKRKpTBF0hFwNbImlMAMO2OnzyQydhW7x
         eN+1LcgbtL5jhjSo70RpxSjdQov8kndGpDDNbSpSC8p2GXcDj+uU2weIlWPjJlA8qIl8
         BlCsu5KoZG7ctALRD0cZoNtC6t3jQNeIPPU9af15PfEEk365neW7OHxkdwhia71zJfZE
         Xvk/dyeAGOmhB7Nw3yXMdyzZT4ZsS92gyCJmdTPa4MUKAO5U7KVIp3TUkW9f4r7xJefT
         pldw==
X-Gm-Message-State: AOAM532AXVDcJVLonRn1ziv4WfJRRZ8x4/GQB8BhJPnWOwAEw5Itv6hs
        vno5PTfOhr7RwHLl3U1nJM5dXaltWzbasymDRAXCtGU69IAC
X-Google-Smtp-Source: ABdhPJyceJ1gZcZZON3cjs2DmuzmdZ7im/EpPc8uleuoe1fkLeLSdthZJCOZBkFaNT5Yd5rZzAoIt117JGNYUW+UgRgIratPqeLu
MIME-Version: 1.0
X-Received: by 2002:a5e:d90c:: with SMTP id n12mr23194781iop.144.1593546735219;
 Tue, 30 Jun 2020 12:52:15 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:52:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015fb9405a95283ce@google.com>
Subject: BUG: sleeping function called from invalid context in exc_page_fault
From:   syzbot <syzbot+aa5151cc1c8abcfa8568@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15ef589d100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=aa5151cc1c8abcfa8568
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aa5151cc1c8abcfa8568@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1253
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 6825, name: syz-fuzzer
1 lock held by syz-fuzzer/6825:
 #0: ffff888098514ba8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 #0: ffff888098514ba8 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault arch/x86/mm/fault.c:1236 [inline]
 #0: ffff888098514ba8 (&mm->mmap_lock#2){++++}-{3:3}, at: handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 #0: ffff888098514ba8 (&mm->mmap_lock#2){++++}-{3:3}, at: exc_page_fault+0x3af/0x14c0 arch/x86/mm/fault.c:1418
irq event stamp: 206142
hardirqs last  enabled at (206141): [<ffffffff81a2080b>] count_memcg_events include/linux/memcontrol.h:739 [inline]
hardirqs last  enabled at (206141): [<ffffffff81a2080b>] count_memcg_event_mm.part.0+0x23b/0x3c0 include/linux/memcontrol.h:760
hardirqs last disabled at (206142): [<ffffffff87e49959>] handle_page_fault arch/x86/mm/fault.c:1373 [inline]
hardirqs last disabled at (206142): [<ffffffff87e49959>] exc_page_fault+0x8b9/0x14c0 arch/x86/mm/fault.c:1418
softirqs last  enabled at (206072): [<ffffffff88200748>] __do_softirq+0x748/0xa60 kernel/softirq.c:319
softirqs last disabled at (206061): [<ffffffff88000f0f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
CPU: 0 PID: 6825 Comm: syz-fuzzer Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 ___might_sleep.cold+0x1ef/0x235 kernel/sched/core.c:6875
 do_user_addr_fault arch/x86/mm/fault.c:1253 [inline]
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0x3dc/0x14c0 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:__prepare_exit_to_usermode+0x0/0x1f0 arch/x86/entry/common.c:234
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0000:ffffc900016a7ec8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff888096bca000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900016a7f58
RBP: ffffc900016a7f58 R08: 0000000000000001 R09: ffff888098514b3f
R10: 0000000000000000 R11: 1ffff11015139d91 R12: 00007f3c0a2e70a0
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
 prepare_exit_to_usermode+0x5/0x30 arch/x86/entry/common.c:277
 exc_page_fault+0x8cb/0x14c0 arch/x86/mm/fault.c:1421
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0033:0x42716c
Code: Bad RIP value.
RSP: 002b:000000c000234eb0 EFLAGS: 00010283
RAX: 00007f3c0a2e6020 RBX: 00007f3c0a2e6020 RCX: 00007f3c0a2e7098
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000240
RBP: 000000c000234ed8 R08: 00000000008e70e0 R09: 0000000000000000
R10: 0000000000000034 R11: 0003ffffffffffff R12: 0000000000000000
R13: 000000000000000e R14: 000000000000000e R15: 000000000000000e
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9f5d0067 P4D 9f5d0067 PUD 96864067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6825 Comm: syz-fuzzer Tainted: G        W         5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__prepare_exit_to_usermode+0x0/0x1f0 arch/x86/entry/common.c:234
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0000:ffffc900016a7ec8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff888096bca000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900016a7f58
RBP: ffffc900016a7f58 R08: 0000000000000001 R09: ffff888098514b3f
R10: 0000000000000000 R11: 1ffff11015139d91 R12: 00007f3c0a2e70a0
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
FS:  000000c000043210(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a8c32000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 prepare_exit_to_usermode+0x5/0x30 arch/x86/entry/common.c:277
 exc_page_fault+0x8cb/0x14c0 arch/x86/mm/fault.c:1421
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9f5d0067 P4D 9f5d0067 PUD 96864067 PMD 0 
Oops: 0002 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 6825 Comm: syz-fuzzer Tainted: G        W         5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0000:ffffc900016a7408 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900016a74a8 RCX: ffffffff8169f800
RDX: ffff888096bca000 RSI: ffffffff8169f82b RDI: 000000000042716c
RBP: 000000000042716c R08: ffffc900016a75b8 R09: ffffffff8c8c8109
R10: 000000000042716c R11: 0000000000000000 R12: ffffc900016a75b8
R13: 0000000000000001 R14: 000000000042716c R15: ffffc900016a74c8
FS:  000000c000043210(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a8c32000 CR4: 00000000001426f0
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
RIP: 0010:__prepare_exit_to_usermode+0x0/0x1f0 arch/x86/entry/common.c:234
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0000:ffffc900016a7ec8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff888096bca000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900016a7f58
RBP: ffffc900016a7f58 R08: 0000000000000001 R09: ffff888098514b3f
R10: 0000000000000000 R11: 1ffff11015139d91 R12: 00007f3c0a2e70a0
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
 prepare_exit_to_usermode+0x5/0x30 arch/x86/entry/common.c:277
 exc_page_fault+0x8cb/0x14c0 arch/x86/mm/fault.c:1421
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9f5d0067 P4D 9f5d0067 PUD 96864067 PMD 0 
Oops: 0002 [#3] PREEMPT SMP KASAN
CPU: 0 PID: 6825 Comm: syz-fuzzer Tainted: G        W         5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:in_gate_area_no_mm+0x0/0x6a arch/x86/entry/vsyscall/vsyscall_64.c:343
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0000:ffffc900016a6918 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900016a69b8 RCX: ffffffff8169f800
RDX: ffff888096bca000 RSI: ffffffff8169f82b RDI: 000000000042716c
RBP: 000000000042716c R08: ffffc900016a6ac8 R09: ffff8880ae623da2
R10: 000000000042716c R11: 0000000000000001 R12: ffffc900016a6ac8
R13: 0000000000000001 R14: 000000000042716c R15: ffffc900016a69d8
FS:  000000c000043210(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a8c32000 CR4: 00000000001426f0
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
RSP: 0000:ffffc900016a7408 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900016a74a8 RCX: ffffffff8169f800
RDX: ffff888096bca000 RSI: ffffffff8169f82b RDI: 000000000042716c
RBP: 000000000042716c R08: ffffc900016a75b8 R09: ffffffff8c8c8109
R10: 000000000042716c R11: 0000000000000000 R12: ffffc900016a75b8
R13: 0000000000000001 R14: 000000000042716c R15: ffffc900016a74c8
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
RIP: 0010:__prepare_exit_to_usermode+0x0/0x1f0 arch/x86/entry/common.c:234
Code: 00 00 00 00 00 00 00 
Lost 41 message(s)!


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
