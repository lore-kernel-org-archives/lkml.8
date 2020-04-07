Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5EC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C4F20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDGVsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:48:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42650 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:48:13 -0400
Received: by mail-io1-f71.google.com with SMTP id a16so4362544ios.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NnS8vCZT1QvIiL3CCvnp1oqlk6d3Wrv2CkF9MiyL0vg=;
        b=Ln5iiKlfEFkB00mjDIN9gc4qNDmyfvqpH6XK7+NVH82an2oEiVJp5gcGUlEiYu6Z3v
         yXhglv0UBUK7anqmNJsYdP6GQLgyQz8Tbpb2QTEBRwoOyY0RAkPugCl7FfxDNkzqBwUf
         Ea8MV3UM0iswYZM5y2OniyY/HuUBy/FZLV+i505P/4k8CsV+UeDxxY0ZhpiebH/N64Ii
         KDgr+iReBQkwgwyYaYUC1ZS7/UqWNhSZSHm7URYE2uLxh+hCwlbW4tx/ByOZIxTgeujv
         wfBx5jZp3JewWKccLD1jXq/+bwNv5n1R0nJgcREmhkglxbJWJ6kblg3PV7CeHOqJnaj4
         dNmw==
X-Gm-Message-State: AGi0Pub8YX+wTK4VtiYaKLKeDQFN+rIroAMKZ+wrtPPEdfZXO49fdyob
        +YM4nHAAWv0+JBb1yk8GPjsy+lp7FhzE1dB9P7lHM+WqHzyW
X-Google-Smtp-Source: APiQypJNFg1DUL3yZpa64aMYloyhiUN/HLSUqpyctBn7oP1PgCl8VW6rAztTPmwjuG1UQu5QLhAGvHI248qEj5+BKurxbq8BBcrH
MIME-Version: 1.0
X-Received: by 2002:a5e:8515:: with SMTP id i21mr3943816ioj.96.1586296092402;
 Tue, 07 Apr 2020 14:48:12 -0700 (PDT)
Date:   Tue, 07 Apr 2020 14:48:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018a92305a2ba57e0@google.com>
Subject: BUG: unable to handle kernel paging request in get_pfnblock_flags_mask
From:   syzbot <syzbot+18638e81a805a2d96682@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterx@redhat.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1685901be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
dashboard link: https://syzkaller.appspot.com/bug?extid=18638e81a805a2d96682
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11379efbe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10172c5de00000

The bug was bisected to:

commit 4426e945df588f2878affddf88a51259200f7e29
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Apr 2 04:08:49 2020 +0000

    mm/gup: allow VM_FAULT_RETRY for multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16122ac7e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15122ac7e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11122ac7e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+18638e81a805a2d96682@syzkaller.appspotmail.com
Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")

BUG: unable to handle page fault for address: fffff11043f9c809
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7170 Comm: syz-executor720 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__nr_to_section include/linux/mmzone.h:1256 [inline]
RIP: 0010:__pfn_to_section include/linux/mmzone.h:1335 [inline]
RIP: 0010:get_pageblock_bitmap mm/page_alloc.c:452 [inline]
RIP: 0010:__get_pfnblock_flags_mask mm/page_alloc.c:487 [inline]
RIP: 0010:get_pfnblock_flags_mask+0x5b/0x190 mm/page_alloc.c:501
Code: 0d ea e0 be 0a 48 85 c9 0f 84 aa 00 00 00 48 89 f7 48 c1 ef 16 48 8d 2c f9 48 b9 00 00 00 00 00 fc ff df 49 89 e8 49 c1 e8 03 <41> 80 3c 08 00 0f 85 87 00 00 00 48 8b 7d 00 48 85 ff 74 7a 83 e3
RSP: 0000:ffffc90001697d40 EFLAGS: 00010a06
RAX: 0000000000000007 RBX: 0001fffffcf404f2 RCX: dffffc0000000000
RDX: 0000000000000002 RSI: fffffe7a02793d05 RDI: 000003fffff9e809
RBP: ffffa8821fce4048 R08: 1ffff51043f9c809 R09: ffffed1013c9e829
R10: ffff88809e4f4147 R11: ffffed1013c9e828 R12: ffff88809e4f4140
R13: ffff88809e4f4148 R14: 0000000000000000 R15: ffff88809e4f4140
FS:  000000000268a940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff11043f9c809 CR3: 000000009f94c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __dump_page+0x122/0x1a40 mm/debug.c:57
 put_page_testzero include/linux/mm.h:675 [inline]
 put_page include/linux/mm.h:1136 [inline]
 lookup_node mm/mempolicy.c:907 [inline]
 do_get_mempolicy mm/mempolicy.c:970 [inline]
 kernel_get_mempolicy+0xe3f/0xfb0 mm/mempolicy.c:1615
 __do_sys_get_mempolicy mm/mempolicy.c:1633 [inline]
 __se_sys_get_mempolicy mm/mempolicy.c:1629 [inline]
 __x64_sys_get_mempolicy+0xba/0x150 mm/mempolicy.c:1629
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x441789
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe6d5ec848 EFLAGS: 00000246 ORIG_RAX: 00000000000000ef
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441789
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000021c9b R08: 0000000000000003 R09: 0000000000402590
R10: 000000002073b000 R11: 0000000000000246 R12: 0000000000402500
R13: 0000000000402590 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: fffff11043f9c809
---[ end trace bdfbd15c6d2a525e ]---
RIP: 0010:__nr_to_section include/linux/mmzone.h:1256 [inline]
RIP: 0010:__pfn_to_section include/linux/mmzone.h:1335 [inline]
RIP: 0010:get_pageblock_bitmap mm/page_alloc.c:452 [inline]
RIP: 0010:__get_pfnblock_flags_mask mm/page_alloc.c:487 [inline]
RIP: 0010:get_pfnblock_flags_mask+0x5b/0x190 mm/page_alloc.c:501
Code: 0d ea e0 be 0a 48 85 c9 0f 84 aa 00 00 00 48 89 f7 48 c1 ef 16 48 8d 2c f9 48 b9 00 00 00 00 00 fc ff df 49 89 e8 49 c1 e8 03 <41> 80 3c 08 00 0f 85 87 00 00 00 48 8b 7d 00 48 85 ff 74 7a 83 e3
RSP: 0000:ffffc90001697d40 EFLAGS: 00010a06
RAX: 0000000000000007 RBX: 0001fffffcf404f2 RCX: dffffc0000000000
RDX: 0000000000000002 RSI: fffffe7a02793d05 RDI: 000003fffff9e809
RBP: ffffa8821fce4048 R08: 1ffff51043f9c809 R09: ffffed1013c9e829
R10: ffff88809e4f4147 R11: ffffed1013c9e828 R12: ffff88809e4f4140
R13: ffff88809e4f4148 R14: 0000000000000000 R15: ffff88809e4f4140
FS:  000000000268a940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff11043f9c809 CR3: 000000009f94c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
