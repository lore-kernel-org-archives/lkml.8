Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1898C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9326B214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDSP2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:28:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52246 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgDSP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:28:16 -0400
Received: by mail-io1-f70.google.com with SMTP id c15so8360956iom.19
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aXXV3SFj3hgHux/6ledulds9vegKt1BXt2kwM/ILLhk=;
        b=slVLcYDvDmbnEdhbY0rnw/iLcpyzNmgaVf/p6O+xTnplQOGEiM5u8Zntv9jlD+MSw9
         vOY6rPT6MqjIooxgerbyAd3TWO0E2H2j/BygY2mWUs6e2kPby2U+88fcAO4p3B31+ZIQ
         NFvfdQS6Gh5JzArbz/u5o9zfkknP5tGmWjnVvXskfSTPMo/K91zDn5/GMBuNQevGfhGR
         UFqClOhhq5e+kNElxGpLCQmWZhftPx9qoddQcN9baDQ4wKeGqjoJ8MqKbaNPHx8NanM6
         QTS1fpUe3POLst2EK7YbA88UYRttWf1hsngQMV9TcoUTh3b9f3kXTQanLfBR+L7TAB0C
         a0Xg==
X-Gm-Message-State: AGi0Pub4sH4b7eSLkRNNOpbja0j2V4bDNVy3BU556QOdpn+XPrgu6uxP
        gukvOzT/7IK+v0qXgchrY9jvgnvVH/GrRqbSfKa1o71zQpQ5
X-Google-Smtp-Source: APiQypIVKMNUP4URoq1+rY8dcOGeSGObs+cIsuX3h1SfmbfDBhRQGnVz1FsW8Ab2bJGoD3yX+TTbo1/coqGkwqwgGJIyd51qWYec
MIME-Version: 1.0
X-Received: by 2002:a92:48cb:: with SMTP id j72mr11932307ilg.162.1587310094253;
 Sun, 19 Apr 2020 08:28:14 -0700 (PDT)
Date:   Sun, 19 Apr 2020 08:28:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005103e405a3a66ecd@google.com>
Subject: kernel BUG at include/linux/mm.h:LINE! (6)
From:   syzbot <syzbot+a923008018a2d298247b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8632e9b5 Merge tag 'hyperv-fixes-signed' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ac6be0100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d351a1019ed81a2
dashboard link: https://syzkaller.appspot.com/bug?extid=a923008018a2d298247b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a923008018a2d298247b@syzkaller.appspotmail.com

raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:699!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 14511 Comm: syz-executor.4 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:put_page_testzero include/linux/mm.h:699 [inline]
RIP: 0010:put_page_testzero include/linux/mm.h:697 [inline]
RIP: 0010:release_pages+0x799/0x19b0 mm/swap.c:823
Code: c7 f9 ff ff e8 38 9d dd ff 48 89 ef e8 20 ac ff ff e9 96 fe ff ff e8 26 9d dd ff 48 c7 c6 c0 44 33 88 48 89 ef e8 87 86 09 00 <0f> 0b e8 10 9d dd ff 49 8d 6c 24 ff e9 c5 f9 ff ff 4c 8d 6d 08 31
RSP: 0018:ffffc90007fb7640 EFLAGS: 00010293
RAX: ffff8880a19f4280 RBX: 0000000000000000 RCX: ffffffff819f2d28
RDX: 0000000000000000 RSI: ffffffff819596e9 RDI: ffffea0000000038
RBP: ffffea0000000000 R08: ffff8880a19f4280 R09: ffffed1015cc66a9
R10: ffff8880ae633547 R11: ffffed1015cc66a8 R12: ffffea0000000034
R13: 0000000000000000 R14: dffffc0000000000 R15: 00000000000000c6
FS:  00007fc0946fc700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2142ba1db8 CR3: 000000008859f000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x8d/0x610 mm/mmu_gather.c:249
 zap_pte_range mm/memory.c:1158 [inline]
 zap_pmd_range mm/memory.c:1196 [inline]
 zap_pud_range mm/memory.c:1225 [inline]
 zap_p4d_range mm/memory.c:1246 [inline]
 unmap_page_range+0x198d/0x25d0 mm/memory.c:1267
 unmap_single_vma+0x196/0x300 mm/memory.c:1312
 unmap_vmas+0x16f/0x2f0 mm/memory.c:1344
 exit_mmap+0x2aa/0x510 mm/mmap.c:3150
 __mmput kernel/fork.c:1085 [inline]
 mmput+0x168/0x4b0 kernel/fork.c:1106
 exit_mm kernel/exit.c:479 [inline]
 do_exit+0xa51/0x2dd0 kernel/exit.c:782
 do_group_exit+0x125/0x340 kernel/exit.c:893
 get_signal+0x47b/0x24e0 kernel/signal.c:2739
 do_signal+0x81/0x2240 arch/x86/kernel/signal.c:784
 exit_to_usermode_loop+0x26c/0x360 arch/x86/entry/common.c:161
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c6f7
Code: 48 83 c4 08 48 89 d8 5b 5d c3 66 0f 1f 84 00 00 00 00 00 48 89 e8 48 f7 d8 48 39 c3 0f 92 c0 eb 92 66 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 0d b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc0946fa068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000045c6f7
RDX: 00007fc0946fa510 RSI: 000000004020ae46 RDI: 0000000000000004
RBP: 0000000020000000 R08: 00007fc0946fa070 R09: 000000000076bfa0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000fec00000
R13: 0000000000000004 R14: 00000000004cdf60 R15: 000000000076bfac
Modules linked in:
---[ end trace 56c4701a85e32af3 ]---
RIP: 0010:put_page_testzero include/linux/mm.h:699 [inline]
RIP: 0010:put_page_testzero include/linux/mm.h:697 [inline]
RIP: 0010:release_pages+0x799/0x19b0 mm/swap.c:823
Code: c7 f9 ff ff e8 38 9d dd ff 48 89 ef e8 20 ac ff ff e9 96 fe ff ff e8 26 9d dd ff 48 c7 c6 c0 44 33 88 48 89 ef e8 87 86 09 00 <0f> 0b e8 10 9d dd ff 49 8d 6c 24 ff e9 c5 f9 ff ff 4c 8d 6d 08 31
RSP: 0018:ffffc90007fb7640 EFLAGS: 00010293
RAX: ffff8880a19f4280 RBX: 0000000000000000 RCX: ffffffff819f2d28
RDX: 0000000000000000 RSI: ffffffff819596e9 RDI: ffffea0000000038
RBP: ffffea0000000000 R08: ffff8880a19f4280 R09: ffffed1015cc66a9
R10: ffff8880ae633547 R11: ffffed1015cc66a8 R12: ffffea0000000034
R13: 0000000000000000 R14: dffffc0000000000 R15: 00000000000000c6
FS:  00007fc0946fc700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9347e2b000 CR3: 000000004d8bb000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
