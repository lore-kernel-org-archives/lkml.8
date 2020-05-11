Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F51BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B2620708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEKGVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:21:17 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:38049 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKGVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:21:16 -0400
Received: by mail-il1-f198.google.com with SMTP id u11so8225269ilg.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VvWJCJza9CikxqiLzUjc8qOYtlTdHjJ65BiKfOU51fo=;
        b=fjfmMej5YURhbxPH5eNzvnlvQ9QKYOKJcAxyYvxuwHA3hWbOmdlyQJPG52D2fBodVM
         wP4nUAZkFInhrc9vZwZLC2+RofoCxScIcOm39Z+g2Hyf14QSrw/oT/uLM3HutvBSruje
         4HM/+elwen2GvwEG6R6+Fu9fW6LlUJzyKqmIfT7oiEBDL2sV7UAmh9YSRxEOJrQzZ9n2
         2cnGRSheQbg0Omezp0rxQ7ARfP/TEod5/bzzPASzlNjMaxT7xHGF/KeB4UUgClVHJwq9
         EErQY8gtPeWKBUqfwFGJ4yV9ed8lobOHO0bYoRVMu4PA8qpCppBgvEVW63UMCEl1u0nc
         0Lww==
X-Gm-Message-State: AGi0PuaxEV6X5tOpQgSAnpIht3IzaJX0OJzqZajNOfXHhIwQqCJUt/Yx
        srffRV7j0qGK8gdbx2ngyfjH0/T+PJ2adpDR8xOatSPrslrf
X-Google-Smtp-Source: APiQypIA+3v6A6XZ4t1TBCS+XG2Ey8rNsVyaOKSU4/qjcFkQTn2bZ4K7wUSsxKSv129H75KqS+qknyvdugAr5x43CSB9Bf/2y9ii
MIME-Version: 1.0
X-Received: by 2002:a92:3603:: with SMTP id d3mr14901342ila.264.1589178075496;
 Sun, 10 May 2020 23:21:15 -0700 (PDT)
Date:   Sun, 10 May 2020 23:21:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000accada05a5595a10@google.com>
Subject: KASAN: use-after-free Read in vc_do_resize
From:   syzbot <syzbot+3c9716daab4ea34d814f@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org, nico@fluxnic.net,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ac935d22 Add linux-next specific files for 20200415
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b5fd32100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
dashboard link: https://syzkaller.appspot.com/bug?extid=3c9716daab4ea34d814f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3c9716daab4ea34d814f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/string.h:381 [inline]
BUG: KASAN: use-after-free in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: use-after-free in vc_do_resize+0x888/0x1340 drivers/tty/vt/vt.c:1274
Read of size 2 at addr ffff888097b3f7c0 by task syz-executor.5/15215

CPU: 0 PID: 15215 Comm: syz-executor.5 Not tainted 5.7.0-rc1-next-20200415-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 check_memory_region_inline mm/kasan/generic.c:187 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:193
 memcpy+0x20/0x60 mm/kasan/common.c:106
 memcpy include/linux/string.h:381 [inline]
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 vc_do_resize+0x888/0x1340 drivers/tty/vt/vt.c:1274
 fbcon_modechanged+0x36e/0x790 drivers/video/fbdev/core/fbcon.c:2989
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:3047
 fb_set_var+0xad0/0xd40 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0x390/0x6e0 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c829
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f135cd66c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e4860 RCX: 000000000045c829
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000002f2 R14: 00000000004c54c8 R15: 00007f135cd676d4

Allocated by task 7295:
 save_stack+0x1b/0x40 mm/kasan/common.c:49
 set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc mm/kasan/common.c:495 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:468
 kmalloc_node include/linux/slab.h:578 [inline]
 kvmalloc_node+0x61/0xf0 mm/util.c:574
 kvmalloc include/linux/mm.h:757 [inline]
 alloc_fdtable+0x139/0x280 fs/file.c:120
 dup_fd+0x785/0xb80 fs/file.c:310
 copy_files kernel/fork.c:1469 [inline]
 copy_process+0x1e89/0x7110 kernel/fork.c:2073
 _do_fork+0x12d/0x1010 kernel/fork.c:2430
 __do_sys_clone+0xec/0x140 kernel/fork.c:2585
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 14235:
 save_stack+0x1b/0x40 mm/kasan/common.c:49
 set_track mm/kasan/common.c:57 [inline]
 kasan_set_free_info mm/kasan/common.c:317 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:456
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 kvfree+0x42/0x50 mm/util.c:603
 __free_fdtable+0x51/0x70 fs/file.c:32
 put_files_struct fs/file.c:420 [inline]
 put_files_struct+0x248/0x2e0 fs/file.c:413
 exit_files+0x7e/0xa0 fs/file.c:445
 do_exit+0xb24/0x2e10 kernel/exit.c:790
 do_group_exit+0x125/0x340 kernel/exit.c:893
 __do_sys_exit_group kernel/exit.c:904 [inline]
 __se_sys_exit_group kernel/exit.c:902 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:902
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff888097b3f780
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 64 bytes inside of
 96-byte region [ffff888097b3f780, ffff888097b3f7e0)
The buggy address belongs to the page:
page:ffffea00025ecfc0 refcount:1 mapcount:0 mapping:000000003f6982aa index:0xffff888097b3f600
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000230f108 ffffea00024eed48 ffff8880aa000540
raw: ffff888097b3f600 ffff888097b3f000 000000010000001b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888097b3f680: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888097b3f700: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff888097b3f780: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                           ^
 ffff888097b3f800: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888097b3f880: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
