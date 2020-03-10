Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9797C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B205524677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgCJHtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:49:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33765 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:49:10 -0400
Received: by mail-io1-f71.google.com with SMTP id b4so5483798iok.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 00:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eaturhJ16kaJm++qJp1mIVeqFVJCJSmt10U2umeg0KM=;
        b=e0nuIGTzuAyyZMkXGUCW5HZFfU+AP3MPmLJ/fHOHon4G9i5s6ONDiD8JT8jSX49eCz
         0C17T0CNe9C+UjD7LxqIwW1NVwv48xTVnOZFKsk2xwCndH38Xc+cpL7E38GaxTzuO0ib
         7zp0FuMfA/D8yLGIV7OwR/+b3TfxH1lfkZG0y/MVYbcmIp2NvZZZU8Sqr8PYT/wpzO2X
         1brczN4xozeaHrdeenrLoVb/JSMOCWQSOLkX2cD7fCtcFhlAQ4G/MuaXP0rMDUemK7L3
         DzNWPLfNTSSkSGrZBMf/iNfLXbpWfp7ZxoGf6UPjBZqaBG8jbW90iSXmKwaBAc1aB+9I
         1phg==
X-Gm-Message-State: ANhLgQ0YVQDW/I+sehcmrredyK5W5+9x+PDWVzFIi5CMoNoadI51Iju/
        xGltVi36JvIhrPBrdvKogyRJs467029qmViKtTg7xWVIc7bA
X-Google-Smtp-Source: ADFU+vtiWH9J6epiZiTLsXgcO4BnHTsr2hErdiBLIW+q7S5kwYy8vM2XQ6sjlGbT8dZx0ieUpgMD4H8Ly3weeB5YPqyHo8CuxH8Z
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ea8:: with SMTP id u8mr20231955ilj.0.1583826550064;
 Tue, 10 Mar 2020 00:49:10 -0700 (PDT)
Date:   Tue, 10 Mar 2020 00:49:10 -0700
In-Reply-To: <0000000000005c66c305a0121be1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e70cfb05a07b5a52@google.com>
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

HEAD commit:    30bb5572 Merge tag 'ktest-v5.6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12000075e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=7f59c1e54e5ce4d95cf7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16657709e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c39c3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7f59c1e54e5ce4d95cf7@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1400
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 9434, name: syz-executor278
1 lock held by syz-executor278/9434:
 #0: ffff88808d27c2d8 (&mm->mmap_sem#2){++++}, at: do_user_addr_fault arch/x86/mm/fault.c:1383 [inline]
 #0: ffff88808d27c2d8 (&mm->mmap_sem#2){++++}, at: do_page_fault+0x34c/0x12da arch/x86/mm/fault.c:1517
irq event stamp: 17432
hardirqs last  enabled at (17431): [<ffffffff83926883>] __free_object+0x8b3/0xee0 lib/debugobjects.c:360
hardirqs last disabled at (17432): [<ffffffff8100b376>] syscall_return_slowpath arch/x86/entry/common.c:277 [inline]
hardirqs last disabled at (17432): [<ffffffff8100b376>] do_syscall_32_irqs_on arch/x86/entry/common.c:352 [inline]
hardirqs last disabled at (17432): [<ffffffff8100b376>] do_fast_syscall_32+0x386/0xe8f arch/x86/entry/common.c:408
softirqs last  enabled at (14944): [<ffffffff8129cd63>] memcpy include/linux/string.h:381 [inline]
softirqs last  enabled at (14944): [<ffffffff8129cd63>] fpu__copy+0x173/0x8b0 arch/x86/kernel/fpu/core.c:195
softirqs last disabled at (14942): [<ffffffff8129cc91>] fpu__copy+0xa1/0x8b0 arch/x86/kernel/fpu/core.c:183
CPU: 1 PID: 9434 Comm: syz-executor278 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 ___might_sleep.cold+0x1f4/0x23d kernel/sched/core.c:6798
 do_user_addr_fault arch/x86/mm/fault.c:1400 [inline]
 do_page_fault+0x379/0x12da arch/x86/mm/fault.c:1517
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_32_irqs_on arch/x86/entry/common.c:352 [inline]
RIP: 0010:do_fast_syscall_32+0x4d1/0xe8f arch/x86/entry/common.c:408
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 f6 08 00 00 4c 8b 3b 31 ff 45 89 fd 41 81 e5 0e 38 00 00 44 89 ee e8 22 60 71 00 45 85 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020d7f18 EFLAGS: 00010006
RAX: 0000000000000000 RBX: ffff88808e8fc380 RCX: ffffffff8100b4be
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffffc900020d7f58 R08: ffff88808e8fc380 R09: ffffed1011d1f871
R10: ffffed1011d1f870 R11: ffff88808e8fc387 R12: 00000000f7f3ce39
R13: 0000000000000000 R14: ffffc900020d7fd8 R15: 0000000020024000
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 97284067 P4D 97284067 PUD 91391067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9434 Comm: syz-executor278 Tainted: G        W         5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_32_irqs_on arch/x86/entry/common.c:352 [inline]
RIP: 0010:do_fast_syscall_32+0x4d1/0xe8f arch/x86/entry/common.c:408
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 f6 08 00 00 4c 8b 3b 31 ff 45 89 fd 41 81 e5 0e 38 00 00 44 89 ee e8 22 60 71 00 45 85 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020d7f18 EFLAGS: 00010006
RAX: 0000000000000000 RBX: ffff88808e8fc380 RCX: ffffffff8100b4be
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffffc900020d7f58 R08: ffff88808e8fc380 R09: ffffed1011d1f871
R10: ffffed1011d1f870 R11: ffff88808e8fc387 R12: 00000000f7f3ce39
R13: 0000000000000000 R14: ffffc900020d7fd8 R15: 0000000020024000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0063) knlGS:00000000092e5840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000096341000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
Modules linked in:
CR2: 0000000000000000
---[ end trace 8c5506cbd0e3ecc5 ]---
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_32_irqs_on arch/x86/entry/common.c:352 [inline]
RIP: 0010:do_fast_syscall_32+0x4d1/0xe8f arch/x86/entry/common.c:408
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 f6 08 00 00 4c 8b 3b 31 ff 45 89 fd 41 81 e5 0e 38 00 00 44 89 ee e8 22 60 71 00 45 85 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900020d7f18 EFLAGS: 00010006
RAX: 0000000000000000 RBX: ffff88808e8fc380 RCX: ffffffff8100b4be
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffffc900020d7f58 R08: ffff88808e8fc380 R09: ffffed1011d1f871
R10: ffffed1011d1f870 R11: ffff88808e8fc387 R12: 00000000f7f3ce39
R13: 0000000000000000 R14: ffffc900020d7fd8 R15: 0000000020024000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0063) knlGS:00000000092e5840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000096341000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

