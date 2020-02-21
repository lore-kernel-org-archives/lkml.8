Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D441DC3565B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21CB2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgBUS6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:58:13 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35237 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgBUS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:58:13 -0500
Received: by mail-il1-f198.google.com with SMTP id h18so3519122ilc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RSR+XBpx2umkfeEIUMi7Fdb2MSEsJ/pg1NVQPzIoIEY=;
        b=b5JHdflrZy/fy+L8j3JoavEHBo0/Rz4znU/O9kXddoQ9l2BzPuUvt/lLMUL96qk7Ok
         gPRipbBRjaIMUg148HGscZHz/5BskOmfngCYGcBJBNPMqZ7Q+M/L+QtgHh0UCuogqjks
         Ln91f35u1LoCmCIY4+OZCGeapIUQ0UPd7T0jQv9l3ccvUH4etSGCaSnUKhu1dVypCKRN
         pO/aa/B5fF3uUOhvzg5GDTEb8zN4JcQtDcMV4WSKS97wg8O/+3EG4af8AQ7KqZjqic0o
         /5M/klWJZCQjyMpsjnyWKEaxgAAzMpoEwHHnSFOA0d5z1tVAeSsSVvJsEsL6Lk1uXuWE
         H0oQ==
X-Gm-Message-State: APjAAAUOfSIZQyy8ZOfQDN7TiIdQ67fP0kt1gcqNyHEj4wazStvkPTSZ
        FYqqnZgqvL6iEzQlDiGKK1eH3lv2+/ZWHpUFCnVokKxzF+d2
X-Google-Smtp-Source: APXvYqw9Gl03DdWuZ6TXedr4GmEaD/Z5gdcl8pUeZRZ57LaCt9kP8YY1xkIIZkUoqsSv8BSmhN8sKm0W0/zIeh7xsSJOcapmoIWw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:149:: with SMTP id y9mr33571077jao.132.1582311492218;
 Fri, 21 Feb 2020 10:58:12 -0800 (PST)
Date:   Fri, 21 Feb 2020 10:58:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006af836059f1a9aa5@google.com>
Subject: KASAN: use-after-free Read in get_work_pool_id
From:   syzbot <syzbot+1024a649601aa4214ff6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    11a48a5a Linux 5.6-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16554ee6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1248cc89e4dba4
dashboard link: https://syzkaller.appspot.com/bug?extid=1024a649601aa4214ff6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112d5aa1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f739d9e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cbc36ee00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12cbc36ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14cbc36ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1024a649601aa4214ff6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic64_read include/asm-generic/atomic-instrumented.h:836 [inline]
BUG: KASAN: use-after-free in atomic_long_read include/asm-generic/atomic-long.h:28 [inline]
BUG: KASAN: use-after-free in get_work_pool_id+0x1c/0xe0 kernel/workqueue.c:732
Read of size 8 at addr ffff8880a2d36008 by task syz-executor507/9562

CPU: 1 PID: 9562 Comm: syz-executor507 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
 __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
 atomic64_read include/asm-generic/atomic-instrumented.h:836 [inline]
 atomic_long_read include/asm-generic/atomic-long.h:28 [inline]
 get_work_pool_id+0x1c/0xe0 kernel/workqueue.c:732
 mark_work_canceling kernel/workqueue.c:743 [inline]
 __cancel_work_timer+0xfa/0x540 kernel/workqueue.c:3120
 cancel_work_sync+0x18/0x20 kernel/workqueue.c:3164
 tty_buffer_cancel_work+0x16/0x20 drivers/tty/tty_buffer.c:613
 release_tty+0x261/0x470 drivers/tty/tty_io.c:1520
 tty_release_struct+0x3c/0x50 drivers/tty/tty_io.c:1629
 tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1789
 __fput+0x2ff/0x890 fs/file_table.c:280
 ____fput+0x16/0x20 fs/file_table.c:313
 task_work_run+0x145/0x1c0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0xba9/0x2f50 kernel/exit.c:801
 do_group_exit+0x135/0x360 kernel/exit.c:899
 __do_sys_exit_group kernel/exit.c:910 [inline]
 __se_sys_exit_group kernel/exit.c:908 [inline]
 __x64_sys_exit_group+0x44/0x50 kernel/exit.c:908
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ff38
Code: Bad RIP value.
RSP: 002b:00007fff706d7d78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ff38
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf950 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9562:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 vc_allocate drivers/tty/vt/vt.c:1085 [inline]
 vc_allocate+0x1fc/0x760 drivers/tty/vt/vt.c:1066
 con_install+0x52/0x410 drivers/tty/vt/vt.c:3229
 tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
 tty_init_dev drivers/tty/tty_io.c:1341 [inline]
 tty_init_dev+0xf9/0x470 drivers/tty/tty_io.c:1318
 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
 tty_open+0x4a5/0xbb0 drivers/tty/tty_io.c:2035
 chrdev_open+0x245/0x6b0 fs/char_dev.c:414
 do_dentry_open+0x4e6/0x1380 fs/open.c:797
 vfs_open+0xa0/0xd0 fs/open.c:914
 do_last fs/namei.c:3490 [inline]
 path_openat+0x12ee/0x3490 fs/namei.c:3607
 do_filp_open+0x192/0x260 fs/namei.c:3637
 do_sys_openat2+0x5eb/0x7e0 fs/open.c:1149
 do_sys_open+0xf2/0x180 fs/open.c:1165
 ksys_open include/linux/syscalls.h:1386 [inline]
 __do_sys_open fs/open.c:1171 [inline]
 __se_sys_open fs/open.c:1169 [inline]
 __x64_sys_open+0x7e/0xc0 fs/open.c:1169
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9566:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 vt_disallocate_all+0x2bd/0x3e0 drivers/tty/vt/vt_ioctl.c:323
 vt_ioctl+0xc38/0x26d0 drivers/tty/vt/vt_ioctl.c:816
 tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a2d36000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 8 bytes inside of
 2048-byte region [ffff8880a2d36000, ffff8880a2d36800)
The buggy address belongs to the page:
page:ffffea00028b4d80 refcount:1 mapcount:0 mapping:ffff8880aa400e00 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00028bcbc8 ffffea0002915c88 ffff8880aa400e00
raw: 0000000000000000 ffff8880a2d36000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a2d35f00: 00 fc fc 00 00 00 00 00 fc fc 00 00 00 00 00 fc
 ffff8880a2d35f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880a2d36000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff8880a2d36080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a2d36100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
