Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FDF206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFBNVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:21:20 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51183 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgFBNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:21:19 -0400
Received: by mail-il1-f199.google.com with SMTP id u4so11702743ilq.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PRBEhWaKBWG1cJOwUL7YxX+kYEVPVn2VxjNUNiRQOkI=;
        b=HeugJxivAtsQ9XH74D6ogGEkIe+3agmY7WACXWLsIJw0+MPtN2m4r6XE5zbx/BXEa/
         7RLGKpc+1vzIBiwH659SreMaanb5n+GsSZALiC2LnKLvo3e6pw05pTu5We6H+MFCdS8O
         z8Bi3RUOFUydmCIHV8RMd8SJts5Dg/nghJJZ+By4VpgBKCiVWNAG2wDpKZPppstzQxA8
         FB4yow6fxJF9UYefARhv24llcMjG4PnUNUHS3Da6mqLAiXdWHuGl3c7ta77/QRIN9OKe
         C4JbzV2petNHvqmZIfU/KMmUWbSx5jsvqt4TjfF5uPdxY0aStySUgcGkxgWGMsUY7+Wg
         cBSw==
X-Gm-Message-State: AOAM533sCTPJB+pYq2u7pkBeShkPWLurpsiPd5Ck+AgmjosK9GJitBnv
        QCWOMW1u4w0hCVPKzGBgJbuf10KGq7PlJPvSqzQ0YZEIhHxR
X-Google-Smtp-Source: ABdhPJyQyEfY9dpOxpP2ufEZ88YDFZp0LlOzNmTauRkCJh2Fr6r4qZtJgrESVs7nwl+Ygt1TRAZDwM1UguhDcTHe9y8PG8MgM1Dv
MIME-Version: 1.0
X-Received: by 2002:a92:5c41:: with SMTP id q62mr19419184ilb.72.1591104076898;
 Tue, 02 Jun 2020 06:21:16 -0700 (PDT)
Date:   Tue, 02 Jun 2020 06:21:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004de90405a719c951@google.com>
Subject: KASAN: use-after-free Read in usb_udc_uevent
From:   syzbot <syzbot+b0de012ceb1e2a97891b@syzkaller.appspotmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rogerq@ti.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, zhengdejin5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ffeb595d Merge tag 'powerpc-5.7-6' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f7f2b1100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ac87c7c2ba15abf
dashboard link: https://syzkaller.appspot.com/bug?extid=b0de012ceb1e2a97891b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b0de012ceb1e2a97891b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in usb_udc_uevent+0xac/0x120 drivers/usb/gadget/udc/core.c:1593
Read of size 8 at addr ffff888091a7c050 by task systemd-udevd/14223

CPU: 1 PID: 14223 Comm: systemd-udevd Not tainted 5.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:382
 __kasan_report+0x103/0x1a0 mm/kasan/report.c:511
 kasan_report+0x4d/0x80 mm/kasan/common.c:625

Allocated by task 14178:
 save_stack mm/kasan/common.c:49 [inline]
 set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc+0x114/0x160 mm/kasan/common.c:495
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 dev_new drivers/usb/gadget/legacy/raw_gadget.c:182 [inline]
 raw_open+0x87/0x500 drivers/usb/gadget/legacy/raw_gadget.c:372
 misc_open+0x346/0x3c0 drivers/char/misc.c:141
 chrdev_open+0x498/0x580 fs/char_dev.c:414
 do_dentry_open+0x82e/0x10b0 fs/open.c:797
 do_open fs/namei.c:3229 [inline]
 path_openat+0x2790/0x38b0 fs/namei.c:3346
 do_filp_open+0x191/0x3a0 fs/namei.c:3373
 do_sys_openat2+0x463/0x770 fs/open.c:1148
 do_sys_open fs/open.c:1164 [inline]
 ksys_open include/linux/syscalls.h:1386 [inline]
 __do_sys_open fs/open.c:1170 [inline]
 __se_sys_open fs/open.c:1168 [inline]
 __x64_sys_open+0x1af/0x1e0 fs/open.c:1168
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 14174:
 save_stack mm/kasan/common.c:49 [inline]
 set_track mm/kasan/common.c:57 [inline]
 kasan_set_free_info mm/kasan/common.c:317 [inline]
 __kasan_slab_free+0x125/0x190 mm/kasan/common.c:456
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 raw_release+0x130/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:411
 __fput+0x2ed/0x750 fs/file_table.c:280
 task_work_run+0x147/0x1d0 kernel/task_work.c:123
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x5ef/0x1f80 kernel/exit.c:796
 do_group_exit+0x15e/0x2c0 kernel/exit.c:894
 get_signal+0x13cf/0x1d60 kernel/signal.c:2739
 do_signal+0x33/0x610 arch/x86/kernel/signal.c:784
 exit_to_usermode_loop arch/x86/entry/common.c:161 [inline]
 prepare_exit_to_usermode+0x32a/0x600 arch/x86/entry/common.c:196
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff888091a7c000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 80 bytes inside of
 4096-byte region [ffff888091a7c000, ffff888091a7d000)
The buggy address belongs to the page:
page:ffffea0002469f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea0002469f00 order:1 compound_mapcount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0001043588 ffffea0001258b88 ffff8880aa402000
raw: 0000000000000000 ffff888091a7c000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888091a7bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888091a7bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888091a7c000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888091a7c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888091a7c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
