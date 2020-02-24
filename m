Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB5AC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E96B2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgBXJSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:18:16 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56921 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBXJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:18:14 -0500
Received: by mail-io1-f70.google.com with SMTP id d13so14338268ioo.23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 01:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Mf+jlK9KZr8krnerxo+HMUq0lwL4/YXg+aLzSPa1uSo=;
        b=b+8z42aJeGxOkzzlPu0sCX+3mcRJkBGhLuZshNkDBu2KeuT5eUQEnkHeBWOuLkhweg
         RdeJABnH3WPX4llVJ60M0ORffuVW3TQJAIFqLnqLqHiyBA9kstjT7tojZZdZqmQTJnjB
         hbHh5qy76w3aJ8aZdiB4kNIh5PPuN3FCEw28kxC+ntfSp0DDYHdKBswrOKWwI6ap6CKM
         r0rQMsE4nQLAuhmuIkZeior7nA35Mt51KcnG3k3jPGTo5fKP8d6T5v6GaDHwTAy1C2ku
         c+rfsT39jm4o2L6vBAruAPm/qN7IeO6kmCBzg8nFB0t0CWvuGrIeF8QGd/cLRySi+W7f
         pDhw==
X-Gm-Message-State: APjAAAUHpW4z0wFeDp4fB67cLNgqWi/5smduK19cshOh9wbBIgmoO3F9
        ApEGVHZzJUovP13ZEV03kEEabwjQ0v1uPwHhA9lH6gbwK/xZ
X-Google-Smtp-Source: APXvYqwwUHoOiTOqYw1Z4Rj4yUORcLtd3JosVaujD6a0RENc1EnfPrfxO/lVu+Nyd4TO4+o5xEPX3erXgcxmCWYyWyiNYH2H0L3A
MIME-Version: 1.0
X-Received: by 2002:a92:1a12:: with SMTP id a18mr57454946ila.10.1582535894205;
 Mon, 24 Feb 2020 01:18:14 -0800 (PST)
Date:   Mon, 24 Feb 2020 01:18:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d18d83059f4ed9ad@google.com>
Subject: KASAN: use-after-free Read in vt_do_kdgkb_ioctl
From:   syzbot <syzbot+a58bfd517766aef83043@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org, rei4dan@gmail.com,
        slyfox@gentoo.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    54dedb5b Merge tag 'for-linus-5.6-rc3-tag' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100403d9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b8906eb6a7d6028
dashboard link: https://syzkaller.appspot.com/bug?extid=a58bfd517766aef83043
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a58bfd517766aef83043@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in vt_do_kdgkb_ioctl+0xb24/0xb50 drivers/tty/vt/keyboard.c:2025
Read of size 1 at addr ffff8880a4a8c801 by task syz-executor.4/27890

CPU: 1 PID: 27890 Comm: syz-executor.4 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 vt_do_kdgkb_ioctl+0xb24/0xb50 drivers/tty/vt/keyboard.c:2025
 vt_ioctl+0x47e/0x26c0 drivers/tty/vt/vt_ioctl.c:549
 tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c429
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0f2868cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0f2868d6d4 RCX: 000000000045c429
RDX: 0000000020000200 RSI: 0000000000004b48 RDI: 0000000000000003
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000041a R14: 00000000004c676d R15: 000000000076bf2c

Allocated by task 1548:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x163/0x770 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 vt_do_kdgkb_ioctl+0x3d1/0xb50 drivers/tty/vt/keyboard.c:2078
 vt_ioctl+0x47e/0x26c0 drivers/tty/vt/vt_ioctl.c:549
 tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 27892:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 vt_do_kdgkb_ioctl+0x5b4/0xb50 drivers/tty/vt/keyboard.c:2104
 vt_ioctl+0x47e/0x26c0 drivers/tty/vt/vt_ioctl.c:549
 tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a4a8c800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 1 bytes inside of
 1024-byte region [ffff8880a4a8c800, ffff8880a4a8cc00)
The buggy address belongs to the page:
page:ffffea000292a300 refcount:1 mapcount:0 mapping:ffff8880aa400c40 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00026aa6c8 ffffea000210b1c8 ffff8880aa400c40
raw: 0000000000000000 ffff8880a4a8c000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a4a8c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880a4a8c780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880a4a8c800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880a4a8c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a4a8c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
