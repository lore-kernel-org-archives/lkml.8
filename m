Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92481C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7991720724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgFWFqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:46:20 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47346 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgFWFqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:46:19 -0400
Received: by mail-il1-f199.google.com with SMTP id o2so3617867ilg.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=m3fj29Hs58+7AJZSVhbEzcUdtIghVdXbW0kkcD6cJMw=;
        b=unSI+FGvh66uMkci/ABs6hBX1BORQaIFcLOivujroxkjWtZjVM5ZcUSe7IgUBKBqVf
         v9sWXEdD2nm52soAT3HprFlNKs9dVihQxAbX7ni4SaZno8l2sf6MzP7DFdSbYpYmjUe0
         /tI9Fh3gzD5833QrAeIWZ+sJTGmYHJXZu05KFwV3zBqXPPRgXoR1p5lTaRTyeU1APjOy
         Ezz0PiBs8EebXe/aIl8Uci1O8PLVFZzEmwyMA/sFYZypLFRt5h6Klw78RiYyaTu8bDU1
         HWEd5CXok/7juPQOpIOkDkdPys+suf2sUNP+1DItenM7pp0fawxhdnfqHqrLIJAj6SkK
         WnJQ==
X-Gm-Message-State: AOAM5329Y4+oBPCyCjjsp4ZHvwPps37wNB+gD6QkqNmBoVTKZ4nA9jiw
        MGwHlbL9W666hnfZGRaVIUEo4AgkQO+On4hR8rYaaRuzSfFY
X-Google-Smtp-Source: ABdhPJytbN2b/hOnOd5tvITNLHZFKw8hcLIq5M8TQMQQd6lPi8rwbi6zbmyoLU1FW/1zA8BQ6rLYNk0EcJRtO/SNHtyadB0OzwIv
MIME-Version: 1.0
X-Received: by 2002:a92:d151:: with SMTP id t17mr22649482ilg.197.1592891177312;
 Mon, 22 Jun 2020 22:46:17 -0700 (PDT)
Date:   Mon, 22 Jun 2020 22:46:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca280205a8b9e060@google.com>
Subject: KASAN: use-after-free Read in cgroup_throttle_swaprate
From:   syzbot <syzbot+5e421ac7ea78f893184b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d65615100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=5e421ac7ea78f893184b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5e421ac7ea78f893184b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in blk_cgroup_congested include/linux/blk-cgroup.h:288 [inline]
BUG: KASAN: use-after-free in cgroup_throttle_swaprate+0x268/0x4f0 mm/swapfile.c:3799
Read of size 4 at addr ffff888098690d80 by task syz-executor.1/11017

CPU: 0 PID: 11017 Comm: syz-executor.1 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:183 [inline]
 check_memory_region+0x2b5/0x2f0 mm/kasan/generic.c:192
 atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
 blk_cgroup_congested include/linux/blk-cgroup.h:288 [inline]
 cgroup_throttle_swaprate+0x268/0x4f0 mm/swapfile.c:3799
 wp_page_copy+0x29c/0x1ff0 mm/memory.c:2680
 do_wp_page+0x750/0x1810 mm/memory.c:2919
 handle_pte_fault mm/memory.c:4233 [inline]
 __handle_mm_fault mm/memory.c:4347 [inline]
 handle_mm_fault+0x23fc/0x2910 mm/memory.c:4384
 faultin_page mm/gup.c:888 [inline]
 __get_user_pages+0xbf5/0x16f0 mm/gup.c:1114
 __get_user_pages_locked mm/gup.c:1307 [inline]
 __get_user_pages_remote+0x130/0x680 mm/gup.c:1858
 process_vm_rw_single_vec mm/process_vm_access.c:108 [inline]
 process_vm_rw_core+0x458/0x990 mm/process_vm_access.c:218
 process_vm_rw+0x1b7/0x270 mm/process_vm_access.c:286
 __do_sys_process_vm_writev mm/process_vm_access.c:308 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
 __x64_sys_process_vm_writev+0xdc/0xf0 mm/process_vm_access.c:303
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca59
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f34c4af9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000137
RAX: ffffffffffffffda RBX: 00000000004fb1a0 RCX: 000000000045ca59
RDX: 1000000000000005 RSI: 0000000020000000 RDI: 0000000000000108
RBP: 000000000078bfa0 R08: 000000000000023a R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000087c R14: 00000000004cb674 R15: 00007f34c4afa6d4

Allocated by task 1:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 cgroup1_root_to_use kernel/cgroup/cgroup-v1.c:1183 [inline]
 cgroup1_get_tree+0x747/0xae0 kernel/cgroup/cgroup-v1.c:1207
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2874 [inline]
 do_mount+0x17e8/0x2900 fs/namespace.c:3199
 __do_sys_mount fs/namespace.c:3409 [inline]
 __se_sys_mount+0xd3/0x100 fs/namespace.c:3386
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 17:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351

The buggy address belongs to the object at ffff888098690000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 3456 bytes inside of
 8192-byte region [ffff888098690000, ffff888098692000)
The buggy address belongs to the page:
page:ffffea000261a400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea000261a400 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0002619a08 ffffea000261ae08 ffff8880aa4021c0
raw: 0000000000000000 ffff888098690000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888098690c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888098690d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888098690d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888098690e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888098690e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
