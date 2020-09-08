Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B84C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0BB21D42
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgIHHbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:31:25 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:36479 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbgIHHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:31:22 -0400
Received: by mail-il1-f205.google.com with SMTP id f20so11440469ilg.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IJOPpIRaZs1d0MvAE3obMnuyMQEjL1jl1jR+FaOGLc4=;
        b=k2x+ofN1ji0MSvKOvXR7Q8+xWJLdhtWwshgrVbVLfs4Zjq12dFfjT6F1bftE2Tgy5g
         xHtHEppwXBxMp+UAYJwLuQBdeXjYNxOk6dHRlM1tsdAKhpXUzipIAe/IWhSihxfdchsg
         6LtzGBjofqkwePh3uobMU+4px5GS1z2OvmyIWY8HYlTsGqYfb19FUclRK/PEjq0tALI5
         Mi7f0+OVT2dIvzpXK7/qfDD9bHiNLY8JS4SCh3Zdq3anyFotIbYyHiRoFbrP1hWqBRUv
         sbIVmyACIS0CvcdPX3FfeewlEp4dW/L0QvOjzQKnfl5L2FBVL+GFBEZqXdOPE1NViNrQ
         w2IQ==
X-Gm-Message-State: AOAM532YZ2PD+uCJbXMVDdcefkFs/XkCuHOHWTK4Exmm5RC5OcPZdOXe
        BADuSdT6iNFdyQj4zlmcV1Dpakr/66oJDwLwGeSlORi8TOYD
X-Google-Smtp-Source: ABdhPJy9zGcwaMQ98Wf5LDSpJjEnkQAnAuQZNjeafJa+GQ0BlnDmIZjouBKUtUQ3cXB6ht2bngI3XbczrgXjatdeAQwIf7tKTAg5
MIME-Version: 1.0
X-Received: by 2002:a02:a1d3:: with SMTP id o19mr23254300jah.90.1599550281745;
 Tue, 08 Sep 2020 00:31:21 -0700 (PDT)
Date:   Tue, 08 Sep 2020 00:31:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000580a2905aec852c7@google.com>
Subject: BUG: unable to handle kernel paging request in preempt_schedule_notrace_thunk
From:   syzbot <syzbot+b1b5cc92a1a394387cbe@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e28f0104 Merge tag 'fixes-2020-09-03' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155d7031900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=b1b5cc92a1a394387cbe
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1b5cc92a1a394387cbe@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 0000000080004000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 5f997067 P4D 5f997067 PUD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 23933 Comm: syz-executor.4 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:preempt_schedule_notrace_thunk+0x18/0x31 arch/x86/entry/thunk_64.S:48
Code: 52 51 50 41 50 41 51 41 52 41 53 e8 f3 77 f5 06 eb 18 55 48 89 e5 57 77 00 00 00 77 00 70 07 77 77 77 77 00 00 00 00 77 00 00 <00> 00 00 70 07 00 00 70 07 00 00 00 00 77 77 77 77 00 70 07 00 00
RSP: 0018:ffffc900010a7720 EFLAGS: 00010246
RAX: 0000000080004000 RBX: 0000000000000000 RCX: ffffffff87f5ede9
RDX: ffffed1013c24851 RSI: 0000000000000008 RDI: ffff88809e124280
RBP: ffffc900010a7768 R08: 0000000000000000 R09: ffff88809e124287
R10: ffffed1013c24850 R11: 0000000000000000 R12: ffff88804e0a3c90
R13: 0000000000000000 R14: dffffc0000000000 R15: 00007f2bc63d4000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000080004000 CR3: 000000005f996000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock+0x36/0x40 kernel/locking/spinlock.c:183
 spin_unlock include/linux/spinlock.h:394 [inline]
 zap_pte_range mm/memory.c:1147 [inline]
 zap_pmd_range mm/memory.c:1195 [inline]
 zap_pud_range mm/memory.c:1224 [inline]
 zap_p4d_range mm/memory.c:1245 [inline]
 unmap_page_range+0x1602/0x2b20 mm/memory.c:1266
 unmap_single_vma+0x198/0x300 mm/memory.c:1311
 unmap_vmas+0x168/0x2e0 mm/memory.c:1343
 exit_mmap+0x2b1/0x530 mm/mmap.c:3183
 __mmput+0x122/0x470 kernel/fork.c:1076
 mmput+0x53/0x60 kernel/fork.c:1097
 exit_mm kernel/exit.c:483 [inline]
 do_exit+0xa8b/0x29f0 kernel/exit.c:793
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: Bad RIP value.
RSP: 002b:00007f2bc43d7cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000118cfe8 RCX: 000000000045d5b9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000118cfe8
RBP: 000000000118cfe0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
R13: 00007ffcd1e5e63f R14: 00007f2bc43d89c0 R15: 000000000118cfec
Modules linked in:
CR2: 0000000080004000
---[ end trace 6167aebb95222551 ]---
RIP: 0010:preempt_schedule_notrace_thunk+0x18/0x31 arch/x86/entry/thunk_64.S:48
Code: 52 51 50 41 50 41 51 41 52 41 53 e8 f3 77 f5 06 eb 18 55 48 89 e5 57 77 00 00 00 77 00 70 07 77 77 77 77 00 00 00 00 77 00 00 <00> 00 00 70 07 00 00 70 07 00 00 00 00 77 77 77 77 00 70 07 00 00
RSP: 0018:ffffc900010a7720 EFLAGS: 00010246
RAX: 0000000080004000 RBX: 0000000000000000 RCX: ffffffff87f5ede9
RDX: ffffed1013c24851 RSI: 0000000000000008 RDI: ffff88809e124280
RBP: ffffc900010a7768 R08: 0000000000000000 R09: ffff88809e124287
R10: ffffed1013c24850 R11: 0000000000000000 R12: ffff88804e0a3c90
R13: 0000000000000000 R14: dffffc0000000000 R15: 00007f2bc63d4000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000080004000 CR3: 000000005f996000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
