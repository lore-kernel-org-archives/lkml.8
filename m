Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B861218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgIHHgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:36:35 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:44089 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgIHHgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:36:32 -0400
Received: by mail-io1-f80.google.com with SMTP id l8so9190501ioa.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5JKUPzK1itskA7QURXOapetLZFhUX0JOxSIJaXgDtFk=;
        b=boI1yoZ7q3C6ZV2G5c/1x/1ppT5C9BFqLSMRhjbipsoh0xxmoFNQ8vgViEWP4gCSRl
         i12c++jNvn2IPXAxilzB4SWInSLCsIcMheq1ytIthm+J0rU3zN1ctkQQsQfYh/cS3U4n
         wyeBh11Jwe7Lve4A2MSaGSl4XbCv8J3X+PC2eNWuJlyfoB8mM0nkFWClnYgH84ZX9r23
         6kL98szE4PLGadqUC2zDH/CSXw0McZTqzZD9Yfaj/VUEJDH1jV++vK4BZ4rx9MpXXtW3
         Peu7koMBzGI57Iu5Ua9YHrNJ63X+DOv5L8dA+FcRJF1vfzf3RbmJ48+QUU8eiWyCE1Fe
         MqxA==
X-Gm-Message-State: AOAM531oH/VnEg4skBoy2h/MMn58ecpf5itGc5r6nUbuV7IRpNqoC0LG
        OydUko0O5G5X4a2cDpakXaMrtkPnVkIgKa+c/HrWl9wo9tHM
X-Google-Smtp-Source: ABdhPJyXDk1ga3lY3fs5bz72ZU2vP9zWEb1bOw0a68Zg+ljHY1y/o2B8TNdfLZ3NPRaT62XK9CBC28X1X+qlcq9QvKoCSoD5dAqi
MIME-Version: 1.0
X-Received: by 2002:a92:5213:: with SMTP id g19mr21658457ilb.297.1599550590408;
 Tue, 08 Sep 2020 00:36:30 -0700 (PDT)
Date:   Tue, 08 Sep 2020 00:36:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bddf8a05aec8644d@google.com>
Subject: KASAN: use-after-free Read in task_work_run
From:   syzbot <syzbot+4b87ce204f0f200f214c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d012a719 Linux 5.9-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c0f046900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=4b87ce204f0f200f214c
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b87ce204f0f200f214c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in task_work_run+0x116/0x190 kernel/task_work.c:140
Read of size 8 at addr ffff888064be5cc0 by task syz-executor.4/18932

CPU: 0 PID: 18932 Comm: syz-executor.4 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 task_work_run+0x116/0x190 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d579
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9e22616c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: 0000000000000000 RBX: 0000000000002ac0 RCX: 000000000045d579
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000005
RBP: 000000000118cf88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffc50988d1f R14: 00007f9e226179c0 R15: 000000000118cf4c

Allocated by task 18946:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc mm/slab.c:3312 [inline]
 kmem_cache_alloc+0x138/0x3a0 mm/slab.c:3482
 kmem_cache_zalloc include/linux/slab.h:656 [inline]
 __alloc_file+0x21/0x350 fs/file_table.c:101
 alloc_empty_file+0x6d/0x170 fs/file_table.c:151
 alloc_file+0x5e/0x5a0 fs/file_table.c:193
 alloc_file_pseudo+0x165/0x250 fs/file_table.c:233
 sock_alloc_file+0x4f/0x190 net/socket.c:411
 sock_map_fd net/socket.c:435 [inline]
 __sys_socket+0x13d/0x200 net/socket.c:1524
 __do_sys_socket net/socket.c:1529 [inline]
 __se_sys_socket net/socket.c:1527 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1527
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 18942:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 rcu_do_batch kernel/rcu/tree.c:2428 [inline]
 rcu_core+0x5c7/0x1190 kernel/rcu/tree.c:2656
 __do_softirq+0x2de/0xa24 kernel/softirq.c:298

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2894 [inline]
 call_rcu+0x14f/0x7e0 kernel/rcu/tree.c:2968
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Second to last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2894 [inline]
 call_rcu+0x14f/0x7e0 kernel/rcu/tree.c:2968
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888064be5cc0
 which belongs to the cache filp of size 488
The buggy address is located 0 bytes inside of
 488-byte region [ffff888064be5cc0, ffff888064be5ea8)
The buggy address belongs to the page:
page:000000004592002e refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x64be5
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000250bd88 ffffea000288a788 ffff8880aa241800
raw: 0000000000000000 ffff888064be5040 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888064be5b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888064be5c00: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
>ffff888064be5c80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                           ^
 ffff888064be5d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888064be5d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
