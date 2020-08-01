Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A6BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2448E206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 20:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHAU7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 16:59:24 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45865 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAU7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 16:59:22 -0400
Received: by mail-il1-f198.google.com with SMTP id 65so3085675ilb.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 13:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jJGl04pK2rdlUldgXOc31dPrj58tNKkPbOTHsrpEPXo=;
        b=Z2P6nsBYuYIxurxr3dy8JXDtjqVwPDhQhH5h1z9k4IKXh+5E+VhHyBVa/0gRzURmO5
         o/iY1RBdyS0KRwoFh4CIch5gVpPscGQix+79lZz+sQ4qr3cfDx7F/tn3sjaIzCNr2Y/J
         COj2xW7wFoD1k9kQw9MhfNvgZ6H+5v4lUZc4+LTjgGr5heYwdBE2evbs6u64M91hiINe
         t4eFCe9KSEARDmvm0DyuJ9W26+BQKQlBnbFJN0g4bxstSN2N4tVp43u/u/GvzgyIohu1
         rujpHvbsomp1vxEjTAZe1aNjJ70CdK5KId9POilw9pEMudB4ZdrIQIJcYNNiZ++50f1F
         5slA==
X-Gm-Message-State: AOAM533uWnHKpED41AMiv56eGnAYTXDGhzJzV8LiRvdIwxk34jVSZAUC
        0GAAGZDLokRzgo3fytonSYf2+NzXD3v77AmpHZQiN8SgVNef
X-Google-Smtp-Source: ABdhPJznOcPuu9nOmVnipi1Ta4mNlXEKFi2qkvHRws+DqW7rou106guKjyHDl3IfNxujzEJTNniXym6FYAF/bqIekQ6f58lBVNNn
MIME-Version: 1.0
X-Received: by 2002:a92:48da:: with SMTP id j87mr10635157ilg.197.1596315561883;
 Sat, 01 Aug 2020 13:59:21 -0700 (PDT)
Date:   Sat, 01 Aug 2020 13:59:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003ff0605abd72e21@google.com>
Subject: general protection fault in free_swap_cache
From:   syzbot <syzbot+10e0e0681594086f6872@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92ed3019 Linux 5.8-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15702138900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
dashboard link: https://syzkaller.appspot.com/bug?extid=10e0e0681594086f6872
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10e0e0681594086f6872@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000043a5d1: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x00000000021d2e88-0x00000000021d2e8f]
CPU: 1 PID: 31709 Comm: syz-executor.1 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
RIP: 0010:PageSwapCache include/linux/page-flags.h:391 [inline]
RIP: 0010:free_swap_cache+0x28/0x300 mm/swap_state.c:266
Code: c3 90 41 57 41 56 41 55 41 54 49 89 fc 55 4d 8d 6c 24 08 53 e8 49 b3 c7 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 85 02 00 00 4d 8b 74 24 08 31 ff 4c 89 e5 4c 89
RSP: 0018:ffffc9001831f900 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888000163028 RCX: ffffffff81ac3992
RDX: 000000000043a5d1 RSI: ffffffff81ac0987 RDI: 00000000021d2e80
RBP: 0000000000000003 R08: 0000000000000000 R09: ffffea00021d2e47
R10: 00000000000001fe R11: 0000000000000000 R12: 00000000021d2e80
R13: 00000000021d2e88 R14: dffffc0000000000 R15: ffffc9001831fcb0
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000008157854 CR3: 0000000092a01000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 free_pages_and_swap_cache+0x58/0x90 mm/swap_state.c:294
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0xe9/0x6b0 mm/mmu_gather.c:249
 zap_pte_range mm/memory.c:1155 [inline]
 zap_pmd_range mm/memory.c:1193 [inline]
 zap_pud_range mm/memory.c:1222 [inline]
 zap_p4d_range mm/memory.c:1243 [inline]
 unmap_page_range+0x1bd4/0x2940 mm/memory.c:1264
 unmap_single_vma+0x198/0x300 mm/memory.c:1309
 unmap_vmas+0x16f/0x2f0 mm/memory.c:1341
 exit_mmap+0x2b1/0x510 mm/mmap.c:3162
 __mmput+0x122/0x470 kernel/fork.c:1093
 mmput+0x53/0x60 kernel/fork.c:1114
 exit_mm kernel/exit.c:482 [inline]
 do_exit+0xa8f/0x2a40 kernel/exit.c:792
 do_group_exit+0x125/0x310 kernel/exit.c:903
 __do_sys_exit_group kernel/exit.c:914 [inline]
 __se_sys_exit_group kernel/exit.c:912 [inline]
 __ia32_sys_exit_group+0x3a/0x50 kernel/exit.c:912
 do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:428
 __do_fast_syscall_32 arch/x86/entry/common.c:475 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:503
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fec569
Code: Bad RIP value.
RSP: 002b:00000000086afd7c EFLAGS: 00000202 ORIG_RAX: 00000000000000fc
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000805a92b
RBP: 00000000fffffff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 58b8e3320e616211 ]---
RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
RIP: 0010:PageSwapCache include/linux/page-flags.h:391 [inline]
RIP: 0010:free_swap_cache+0x28/0x300 mm/swap_state.c:266
Code: c3 90 41 57 41 56 41 55 41 54 49 89 fc 55 4d 8d 6c 24 08 53 e8 49 b3 c7 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 85 02 00 00 4d 8b 74 24 08 31 ff 4c 89 e5 4c 89
RSP: 0018:ffffc9001831f900 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888000163028 RCX: ffffffff81ac3992
RDX: 000000000043a5d1 RSI: ffffffff81ac0987 RDI: 00000000021d2e80
RBP: 0000000000000003 R08: 0000000000000000 R09: ffffea00021d2e47
R10: 00000000000001fe R11: 0000000000000000 R12: 00000000021d2e80
R13: 00000000021d2e88 R14: dffffc0000000000 R15: ffffc9001831fcb0
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002ef2a000 CR3: 00000000932f4000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
