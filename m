Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76018C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476D5214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAORQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:16:12 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:35842 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAORQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:16:12 -0500
Received: by mail-io1-f71.google.com with SMTP id 144so10873299iou.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O3YbhnbyZQorKGlqJaF7WScrngDyTF1HNDIoMCSO20A=;
        b=YpQFkcA2unfwEyJw7zLAJmYGQ/jB2Ph2mSRu8//cxrHPVFBPyXEvkFEQ+QJ4980o0E
         ygA5c+wQ9QyXhEDgQGEvCOt8XkgseaSdxroxT4WOxG/l7cPOXtNrZD9Dw/r/A9I1g1s6
         m/H63v1wndkafeKfYm3FTGz+0+XBj+pJ2/B1aABZlOGgSiGVzk0uHC0TTK6bwDDfIQ17
         9JDJRR3XYbynad5d2Epw8l2ee/QHUxgrA5ss26K2jgi0rDVdOpZPBlTYKn7nvcOuWew7
         2vcctncg8iwq9zR2chiFHUUpQdsGguRjKQqTqGvQSqyfOPOSIMC/Gu7xSt+Bpj0yGby5
         NBpA==
X-Gm-Message-State: APjAAAVYp7sGX9Eqv2iE0DsqZ6zBZifNW9a+8mXXNIVsayImvTd6ipy9
        pOXPPMg00lip8QKBa06xftm2J1GucL5KFpp05JJQWs1JNiXV
X-Google-Smtp-Source: APXvYqwOsrIOXD4CEiMYP1hgJ3K2TIfgF7CXZJ/y1TnXfL6D5RtnB3/ct/weWXrmcmAmuvc5UhoxCKBFCHJfE0S+ReBYLhVTgGQH
MIME-Version: 1.0
X-Received: by 2002:a02:7f54:: with SMTP id r81mr25309079jac.121.1579108571189;
 Wed, 15 Jan 2020 09:16:11 -0800 (PST)
Date:   Wed, 15 Jan 2020 09:16:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000729d74059c30ddff@google.com>
Subject: KASAN: use-after-free Read in snd_timer_resolution
From:   syzbot <syzbot+2b2ef983f973e5c40943@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e033e7d4 Merge branch 'dhowells' (patches from DavidH)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f2bb25e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=2b2ef983f973e5c40943
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2b2ef983f973e5c40943@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in snd_timer_resolution+0xf1/0x110  
sound/core/timer.c:441
Read of size 8 at addr ffff888094155800 by task syz-executor.0/18632

CPU: 1 PID: 18632 Comm: syz-executor.0 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  snd_timer_resolution+0xf1/0x110 sound/core/timer.c:441
  snd_seq_info_timer_read+0x95/0x2f1 sound/core/seq/seq_timer.c:480
  snd_info_seq_show+0xcb/0x120 sound/core/info.c:363
  seq_read+0x4ca/0x1170 fs/seq_file.c:229
  proc_reg_read+0x1fc/0x2c0 fs/proc/inode.c:223
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_iter_read+0x4a4/0x660 fs/read_write.c:935
  compat_readv+0x187/0x1f0 fs/read_write.c:1186
  do_compat_preadv64+0x190/0x1c0 fs/read_write.c:1235
  __do_compat_sys_preadv fs/read_write.c:1255 [inline]
  __se_compat_sys_preadv fs/read_write.c:1249 [inline]
  __ia32_compat_sys_preadv+0xc7/0x140 fs/read_write.c:1249
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f6da39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d690cc EFLAGS: 00000296 ORIG_RAX: 000000000000014d
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000200017c0
RDX: 00000000000003da RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 18631:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  snd_timer_instance_new+0x4a/0x300 sound/core/timer.c:96
  snd_seq_timer_open+0x1c0/0x590 sound/core/seq/seq_timer.c:275
  queue_use+0xf1/0x270 sound/core/seq/seq_queue.c:489
  snd_seq_queue_alloc+0x2c5/0x4d0 sound/core/seq/seq_queue.c:176
  snd_seq_ioctl_create_queue+0xb0/0x330 sound/core/seq/seq_clientmgr.c:1548
  snd_seq_kernel_client_ctl+0xf8/0x140 sound/core/seq/seq_clientmgr.c:2353
  alloc_seq_queue.isra.0+0xdc/0x180 sound/core/seq/oss/seq_oss_init.c:357
  snd_seq_oss_open+0x2ff/0x960 sound/core/seq/oss/seq_oss_init.c:215
  odev_open+0x70/0x90 sound/core/seq/oss/seq_oss.c:125
  soundcore_open+0x453/0x610 sound/sound_core.c:593
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3420 [inline]
  path_openat+0x10df/0x4500 fs/namei.c:3537
  do_filp_open+0x1a1/0x280 fs/namei.c:3567
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_compat_sys_openat fs/open.c:1143 [inline]
  __se_compat_sys_openat fs/open.c:1141 [inline]
  __ia32_compat_sys_openat+0x98/0xf0 fs/open.c:1141
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 18630:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  snd_timer_instance_free sound/core/timer.c:120 [inline]
  snd_timer_instance_free+0x7c/0xa0 sound/core/timer.c:114
  snd_seq_timer_close+0x99/0xe0 sound/core/seq/seq_timer.c:319
  queue_delete+0x52/0xb0 sound/core/seq/seq_queue.c:134
  snd_seq_queue_delete+0x4e/0x70 sound/core/seq/seq_queue.c:196
  snd_seq_ioctl_delete_queue+0x6a/0x90 sound/core/seq/seq_clientmgr.c:1570
  snd_seq_kernel_client_ctl+0xf8/0x140 sound/core/seq/seq_clientmgr.c:2353
  delete_seq_queue.part.0+0xb6/0x120 sound/core/seq/oss/seq_oss_init.c:376
  delete_seq_queue sound/core/seq/oss/seq_oss_init.c:372 [inline]
  snd_seq_oss_release+0x116/0x150 sound/core/seq/oss/seq_oss_init.c:421
  odev_release+0x54/0x80 sound/core/seq/oss/seq_oss.c:140
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_32_irqs_on arch/x86/entry/common.c:352 [inline]
  do_fast_syscall_32+0xbbd/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

The buggy address belongs to the object at ffff888094155800
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 0 bytes inside of
  256-byte region [ffff888094155800, ffff888094155900)
The buggy address belongs to the page:
page:ffffea0002505540 refcount:1 mapcount:0 mapping:ffff8880aa4008c0  
index:0x0
raw: 00fffe0000000200 ffffea00024df348 ffffea00024af508 ffff8880aa4008c0
raw: 0000000000000000 ffff888094155000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888094155700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888094155780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff888094155800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff888094155880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888094155900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
