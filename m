Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A904EC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0E120B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDUIgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:36:13 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41024 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:36:13 -0400
Received: by mail-io1-f71.google.com with SMTP id p20so15613254iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n4GIc7ay92pYpnCiYvL6JSGGcyn+glJttmMl8OXerYQ=;
        b=GogTqXnMYNblL6llbbhh4zqx6FlFx+WPiFKjeZ8XMG0Jzct6Ny/Q/k5FEK79/pV3nI
         HuqgeXsxyxQtBHTru97Hv17dvkrkeHHmdkabvOXQHOdmcFRPAcDURv44uYsrt8jwXKBz
         D173UufqFNkdL0e6cKGTRW9q6lgZ1IwJD2cwToqSieZ5lUXN1q65jjIDO6Zu1vLsN6BF
         WvUJa+1EbxccmbqUsUz5qagBmGRNsWNcN9kHx74I9JhQo0301IFvxzlaUMWu+EHQnW1K
         cGz/MD6ZGHkTJJfRGv9hz0w/VkzOy/NBGKBH2favXYQWxjIQ3vgdijEoATaXw22bSXZr
         vFdA==
X-Gm-Message-State: AGi0PuZbaQ9CeAay6yiSA0d/m7bU6eiwCSA2TzBkaYDmgeyFZ1dHYaAn
        FiKQBkc/MLBE4k/CHwZ+TZVP4OMfx6n9HiT7GYNFlxGPcAtq
X-Google-Smtp-Source: APiQypK+C8MtiOEb06rizwafTUmRRWvT1BO+siXa7cqj/jln8LTAHMeAJvWlWpDlEiVs+uWzxX3rGGlzxz/QcVmvTbrwdb/a0SFs
MIME-Version: 1.0
X-Received: by 2002:a92:ba87:: with SMTP id t7mr20020312ill.287.1587458170647;
 Tue, 21 Apr 2020 01:36:10 -0700 (PDT)
Date:   Tue, 21 Apr 2020 01:36:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b7ac705a3c8e8b1@google.com>
Subject: KASAN: use-after-free Read in mem_cgroup_throttle_swaprate
From:   syzbot <syzbot+25aae20a3d0192870dd5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    95988fbc Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12de165fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11f10cc27c63cade
dashboard link: https://syzkaller.appspot.com/bug?extid=25aae20a3d0192870dd5
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+25aae20a3d0192870dd5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:199 [inline]
BUG: KASAN: use-after-free in arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
BUG: KASAN: use-after-free in blk_cgroup_congested include/linux/blk-cgroup.h:288 [inline]
BUG: KASAN: use-after-free in mem_cgroup_throttle_swaprate+0x2a9/0x4a0 mm/swapfile.c:3755
Read of size 4 at addr ffff888097c78cd8 by task syz-executor.3/19679

CPU: 1 PID: 19679 Comm: syz-executor.3 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:382
 __kasan_report+0x103/0x1a0 mm/kasan/report.c:511
 kasan_report+0x4d/0x80 mm/kasan/common.c:625

Allocated by task 1:
 save_stack mm/kasan/common.c:49 [inline]
 set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc+0x114/0x160 mm/kasan/common.c:495
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 cgroup1_root_to_use kernel/cgroup/cgroup-v1.c:1183 [inline]
 cgroup1_get_tree+0x747/0xae0 kernel/cgroup/cgroup-v1.c:1207
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2816 [inline]
 do_mount+0x17ec/0x2900 fs/namespace.c:3141
 __do_sys_mount fs/namespace.c:3350 [inline]
 __se_sys_mount+0xd3/0x100 fs/namespace.c:3327
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 8747:
 save_stack mm/kasan/common.c:49 [inline]
 set_track mm/kasan/common.c:57 [inline]
 kasan_set_free_info mm/kasan/common.c:317 [inline]
 __kasan_slab_free+0x125/0x190 mm/kasan/common.c:456
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff888097c78000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 3288 bytes inside of
 8192-byte region [ffff888097c78000, ffff888097c7a000)
The buggy address belongs to the page:
page:ffffea00025f1e00 refcount:1 mapcount:0 mapping:000000006ff58934 index:0x0 head:ffffea00025f1e00 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea00025f1408 ffffea00025f2708 ffff8880aa4021c0
raw: 0000000000000000 ffff888097c78000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888097c78b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888097c78c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888097c78c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888097c78d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888097c78d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
