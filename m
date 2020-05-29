Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D92C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BB6206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgE2N6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:58:19 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:53713 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgE2N6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:58:18 -0400
Received: by mail-il1-f197.google.com with SMTP id c29so2321160ilf.20
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zal96WvhZ4Y64ZDn42UwH9q1veeepmKtxZlobQ1d74c=;
        b=GUL2Uj2/i4AI8QGb85Ms6bqw6Dt+wrZAyqbWFHkZMU220ssi7o8LbTGPzvO9kedEub
         ffLKySgnisIVxiK2JzIPpTB9xYFpw2t18gdoMmeX4k9m5rIRzU8eARj0lWGSHGZpy/Zs
         7ea2AnpdNlH+dxlwZfwTtEUAi8k799wW6smFY1y1pRiXvYWyGUx1qRnGhNMWWpaualYU
         Xdr605IxnHOpMVMk+sgzr9PRXh5NBTQl6JNdUJY9JZh2UfOkb9UClLs9QwS2TeEXzNaD
         hQxHxNC+a5TiBtFQkHjUENoStGIWTHzIIOfFKBCxrxRdmDa7wvY+qavld46sHTv0yP1F
         jGBg==
X-Gm-Message-State: AOAM531lrhBaOw/fuPpKFjiQy//kWafg4yYpZdCbWLE1+/jgGxRHMLtk
        My0smDRXlZu35Nmc15lKL/tt3ml6J2byUKU+WFIaR63RSK1n
X-Google-Smtp-Source: ABdhPJx0rCS9HjY0n/9AtnTDROfO9dRJdonZHXB5FryLyxbsqf2xO4QoPn3VveL0Eao+nOTY6wRWnJfCfUEPD4AS9DM0SmEPQ4UN
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:be8:: with SMTP id d8mr7301784ilu.32.1590760696535;
 Fri, 29 May 2020 06:58:16 -0700 (PDT)
Date:   Fri, 29 May 2020 06:58:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d5d7105a6c9d65d@google.com>
Subject: general protection fault in free_pages_and_swap_cache
From:   syzbot <syzbot+06f6ed6b0ea3f5d95cd1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b0c3ba31 Merge tag 'fsnotify_for_v5.7-rc8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ebe5e2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cca7550d53ffa599
dashboard link: https://syzkaller.appspot.com/bug?extid=06f6ed6b0ea3f5d95cd1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+06f6ed6b0ea3f5d95cd1@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc00003d1339: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000001e899c8-0x0000000001e899cf]
CPU: 0 PID: 29767 Comm: syz-executor.0 Not tainted 5.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
RIP: 0010:PageSwapCache include/linux/page-flags.h:391 [inline]
RIP: 0010:free_swap_cache mm/swap_state.c:267 [inline]
RIP: 0010:free_pages_and_swap_cache+0x94/0x3f0 mm/swap_state.c:295
Code: 00 00 e8 af 3c c9 ff 4c 89 e8 48 c1 e8 03 80 3c 18 00 0f 85 e8 02 00 00 4d 8b 65 00 49 8d 44 24 08 48 89 44 24 20 48 c1 e8 03 <80> 3c 18 00 0f 85 e7 02 00 00 4d 8b 7c 24 08 31 ff 4c 89 e5 4c 89
RSP: 0018:ffffc9001610f6c0 EFLAGS: 00010206
RAX: 00000000003d1339 RBX: dffffc0000000000 RCX: ffffffff81aa01e3
RDX: 0000000000000000 RSI: ffffffff81aa01f1 RDI: 0000000000000004
RBP: ffffea0001e89980 R08: ffff88803dc0a3c0 R09: fffff940003d1331
R10: ffffea0001e89987 R11: fffff940003d1330 R12: 0000000001e899c0
R13: ffff8880001a6898 R14: 0000000000000111 R15: 00000000000001fe
FS:  00007f0a0e9c6700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33326000 CR3: 00000000799e0000 CR4: 00000000001426f0
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
 exit_mm kernel/exit.c:480 [inline]
 do_exit+0xa51/0x2dd0 kernel/exit.c:783
 do_group_exit+0x125/0x340 kernel/exit.c:894
 get_signal+0x47b/0x24e0 kernel/signal.c:2739
 do_signal+0x81/0x2240 arch/x86/kernel/signal.c:784
 exit_to_usermode_loop+0x26c/0x360 arch/x86/entry/common.c:161
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0a0e9c5cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000078bf08 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000078bf08
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
R13: 0000000000c9fb6f R14: 00007f0a0e9c69c0 R15: 000000000078bf0c
Modules linked in:
---[ end trace 5b99197ed4464cc6 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
RIP: 0010:PageSwapCache include/linux/page-flags.h:391 [inline]
RIP: 0010:free_swap_cache mm/swap_state.c:267 [inline]
RIP: 0010:free_pages_and_swap_cache+0x94/0x3f0 mm/swap_state.c:295
Code: 00 00 e8 af 3c c9 ff 4c 89 e8 48 c1 e8 03 80 3c 18 00 0f 85 e8 02 00 00 4d 8b 65 00 49 8d 44 24 08 48 89 44 24 20 48 c1 e8 03 <80> 3c 18 00 0f 85 e7 02 00 00 4d 8b 7c 24 08 31 ff 4c 89 e5 4c 89
RSP: 0018:ffffc9001610f6c0 EFLAGS: 00010206
RAX: 00000000003d1339 RBX: dffffc0000000000 RCX: ffffffff81aa01e3
RDX: 0000000000000000 RSI: ffffffff81aa01f1 RDI: 0000000000000004
RBP: ffffea0001e89980 R08: ffff88803dc0a3c0 R09: fffff940003d1331
R10: ffffea0001e89987 R11: fffff940003d1330 R12: 0000000001e899c0
R13: ffff8880001a6898 R14: 0000000000000111 R15: 00000000000001fe
FS:  00007f0a0e9c6700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 000000009d47f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
