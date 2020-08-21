Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F822C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3979C20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHURD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:03:28 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54277 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgHUQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:58:21 -0400
Received: by mail-io1-f70.google.com with SMTP id z25so1577073ioh.21
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gvkLz5dzgj1Xs3C8zHNPerRdzstr3VouB003XUDpp48=;
        b=q667U8ICIA+YAwPUfNooVgwEwMzMpOp0AVEIEGoagwPhldRPJeianlCtC/iATyLpku
         4XwgM2Mqc6Tot8GSVCSsXbyKBiFIhj3um2xXXJzpO+VtZGo4DwwlGGxK5qdGAzBakURl
         aWdTSeqcV4gJVubdKq4sa1faWsQ5nCxAsrTJM2IRbav0lpxV0cFn//brDmI2msX1JNMF
         I5j1nGRY0Gnj33nHbqiGxiKRAaKKtCkF6Bcdm7TCqrwZps+NjJJy2/he/lihPJ7tFAtH
         qdsbFDsc0qJw/+coWAnsGe5meRIkBytR/bvYRKMErd8jRwGsH2bYeDS1a1wM91q+4SAD
         3aPQ==
X-Gm-Message-State: AOAM530HYxkB639i5zSz+MRo91UavdDiokP+eRxG1FsMmJTTeXuT/7vf
        wrmLAjdwgrGh0eBqs2MZ7UEar5GRZ/bKVlx4qBMoUWiZvzVU
X-Google-Smtp-Source: ABdhPJxMasKYj9Oz3HoZsV6aunnGxcIx1amxb0uuzw34kSXUZET6kHfukAxH14JmtOAIbtEcJLgupBqeoDaG7+0pXivMqaEndXY4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dcc:: with SMTP id l12mr3153325ilj.282.1598029100762;
 Fri, 21 Aug 2020 09:58:20 -0700 (PDT)
Date:   Fri, 21 Aug 2020 09:58:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e44b7d05ad6624df@google.com>
Subject: KASAN: use-after-free Read in do_madvise
From:   syzbot <syzbot+b90df26038d1d5d85c97@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    da2968ff Merge tag 'pci-v5.9-fixes-1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1339995a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=b90df26038d1d5d85c97
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1225d919900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b90df26038d1d5d85c97@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in madvise_willneed mm/madvise.c:293 [inline]
BUG: KASAN: use-after-free in madvise_vma mm/madvise.c:942 [inline]
BUG: KASAN: use-after-free in do_madvise.part.0+0x1c8b/0x1cf0 mm/madvise.c:1145
Read of size 8 at addr ffff8880a6163eb0 by task syz-executor.0/9996

CPU: 0 PID: 9996 Comm: syz-executor.0 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 madvise_willneed mm/madvise.c:293 [inline]
 madvise_vma mm/madvise.c:942 [inline]
 do_madvise.part.0+0x1c8b/0x1cf0 mm/madvise.c:1145
 do_madvise mm/madvise.c:1169 [inline]
 __do_sys_madvise mm/madvise.c:1171 [inline]
 __se_sys_madvise mm/madvise.c:1169 [inline]
 __x64_sys_madvise+0xd9/0x110 mm/madvise.c:1169
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d4d9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f04f7464c78 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000020800 RCX: 000000000045d4d9
RDX: 0000000000000003 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 000000000118d020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
R13: 00007ffc579cce7f R14: 00007f04f74659c0 R15: 000000000118cfec

Allocated by task 9992:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc mm/slab.c:3312 [inline]
 kmem_cache_alloc+0x138/0x3a0 mm/slab.c:3482
 vm_area_alloc+0x1c/0x110 kernel/fork.c:347
 mmap_region+0x8e5/0x1780 mm/mmap.c:1743
 do_mmap+0xcf9/0x11d0 mm/mmap.c:1545
 vm_mmap_pgoff+0x195/0x200 mm/util.c:506
 ksys_mmap_pgoff+0x43a/0x560 mm/mmap.c:1596
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 9992:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 remove_vma+0x132/0x170 mm/mmap.c:184
 remove_vma_list mm/mmap.c:2613 [inline]
 __do_munmap+0x743/0x1170 mm/mmap.c:2869
 do_munmap mm/mmap.c:2877 [inline]
 mmap_region+0x257/0x1780 mm/mmap.c:1716
 do_mmap+0xcf9/0x11d0 mm/mmap.c:1545
 vm_mmap_pgoff+0x195/0x200 mm/util.c:506
 ksys_mmap_pgoff+0x43a/0x560 mm/mmap.c:1596
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880a6163eb0
 which belongs to the cache vm_area_struct of size 200
The buggy address is located 0 bytes inside of
 200-byte region [ffff8880a6163eb0, ffff8880a6163f78)
The buggy address belongs to the page:
page:00000000dc1e014c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa6163
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002494bc8 ffffea0002a5ad88 ffff8880aa06f500
raw: 0000000000000000 ffff8880a6163040 000000010000000f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a6163d80: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
 ffff8880a6163e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
>ffff8880a6163e80: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880a6163f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
 ffff8880a6163f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
