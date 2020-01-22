Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72549C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DCB217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAVPvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:51:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:55004 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:51:08 -0500
Received: by mail-io1-f72.google.com with SMTP id k25so2105550ios.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 07:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oz0aXsHCjOMbmBxnBtJQMdHjycwqcbJ4fyUnOhk08pU=;
        b=XJKMnIeH5/lO97l3kdZqqVeH9q4CocyLVyklRW/MmF9VYe/tH4jKJeVsTjK7uUpEHi
         qj9CcE6NsVhGLfIjidLw7c86uPOE7k2kFF+U7BmycKtk9kneeYAIJWFoGUr++V9Wr3DM
         zG/M2EzE4YoljD9rNtYNyMxnyOkVOQRuOKugCv5TV7tGjf+OZDNawqMssfyk5PA29prM
         hEJ30xrFWioWNHRIOq0s8Hldw//KIGvOPI/dpSTTtth3QhVm+UbKqLBtwhEO72Dsq2u3
         3JdcpLIJ9u+TN8ljwf75u1QOaHd+dreX6iVgacoqZI7DV0M/jbJjoDo2BO2J8iSwJBht
         JB8g==
X-Gm-Message-State: APjAAAVohZXI7Jlf89c04pu6SBHKtfFh0OKrwouHNXKbOSQbE6egK522
        9C6VFjMI23+9TjIX8hN3UDt6VOYyzr6mbr3i2qqmU8rvE7x2
X-Google-Smtp-Source: APXvYqwdMy7d9a8ubm5HisAzrL47OSq5SbRP4K6fvnj7jb3vxthnOBm3uYooNMcMWTi9WQKkSoPu+uDGsxTaC1RVB/dDH/yrtrnB
MIME-Version: 1.0
X-Received: by 2002:a92:b744:: with SMTP id c4mr8082698ilm.34.1579708268100;
 Wed, 22 Jan 2020 07:51:08 -0800 (PST)
Date:   Wed, 22 Jan 2020 07:51:08 -0800
In-Reply-To: <00000000000044bcb8059a0a577e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b41f0059cbc7e2b@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in vc_do_resize
From:   syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        ghalat@redhat.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net,
        okash.khawaja@gmail.com, oleksandr@redhat.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11554d85e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=c37a14770d51a085a520
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1659a721e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aa59c9e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in vc_do_resize+0xb5e/0x1af0 drivers/tty/vt/vt.c:1250
Read of size 192 at addr ffff888095d34540 by task syz-executor536/9034

CPU: 1 PID: 9034 Comm: syz-executor536 Not tainted 5.5.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:374
 __kasan_report+0x149/0x1c0 mm/kasan/report.c:506
 kasan_report+0x26/0x50 mm/kasan/common.c:639
 check_memory_region_inline mm/kasan/generic.c:182 [inline]
 check_memory_region+0x2b6/0x2f0 mm/kasan/generic.c:192
 memcpy+0x28/0x60 mm/kasan/common.c:125
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 vc_do_resize+0xb5e/0x1af0 drivers/tty/vt/vt.c:1250
 vc_resize+0x4f/0x60 drivers/tty/vt/vt.c:1304
 fbcon_modechanged+0x701/0xdf0 drivers/video/fbdev/core/fbcon.c:2980
 fbcon_update_vcs+0x31/0x40 drivers/video/fbdev/core/fbcon.c:3038
 fb_set_var+0x8f5/0xdc0 drivers/video/fbdev/core/fbmem.c:1051
 do_fb_ioctl+0x55e/0x780 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xb9/0xf0 drivers/video/fbdev/core/fbmem.c:1180
 do_vfs_ioctl+0x6e2/0x19b0 fs/ioctl.c:47
 ksys_ioctl fs/ioctl.c:749 [inline]
 __do_sys_ioctl fs/ioctl.c:756 [inline]
 __se_sys_ioctl fs/ioctl.c:754 [inline]
 __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:754
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446d49
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc010171db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc48 RCX: 0000000000446d49
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000004
RBP: 00000000006dbc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc4c
R13: 00007ffc8ab7313f R14: 00007fc0101729c0 R15: 0000000000000001

Allocated by task 9034:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc+0x118/0x1c0 mm/kasan/common.c:513
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x254/0x340 mm/slab.c:3665
 kmalloc include/linux/slab.h:561 [inline]
 kzalloc+0x21/0x40 include/linux/slab.h:670
 vc_do_resize+0x2af/0x1af0 drivers/tty/vt/vt.c:1187
 vc_resize+0x4f/0x60 drivers/tty/vt/vt.c:1304
 fbcon_modechanged+0x701/0xdf0 drivers/video/fbdev/core/fbcon.c:2980
 fbcon_update_vcs+0x31/0x40 drivers/video/fbdev/core/fbcon.c:3038
 fb_set_var+0x8f5/0xdc0 drivers/video/fbdev/core/fbmem.c:1051
 fbcon_resize+0x819/0x11f0 drivers/video/fbdev/core/fbcon.c:2222
 resize_screen drivers/tty/vt/vt.c:1126 [inline]
 vc_do_resize+0x478/0x1af0 drivers/tty/vt/vt.c:1205
 vc_resize+0x4f/0x60 drivers/tty/vt/vt.c:1304
 fbcon_modechanged+0x701/0xdf0 drivers/video/fbdev/core/fbcon.c:2980
 fbcon_update_vcs+0x31/0x40 drivers/video/fbdev/core/fbcon.c:3038
 fb_set_var+0x8f5/0xdc0 drivers/video/fbdev/core/fbmem.c:1051
 do_fb_ioctl+0x55e/0x780 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xb9/0xf0 drivers/video/fbdev/core/fbmem.c:1180
 do_vfs_ioctl+0x6e2/0x19b0 fs/ioctl.c:47
 ksys_ioctl fs/ioctl.c:749 [inline]
 __do_sys_ioctl fs/ioctl.c:756 [inline]
 __se_sys_ioctl fs/ioctl.c:754 [inline]
 __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:754
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8579:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:335 [inline]
 __kasan_slab_free+0x12e/0x1e0 mm/kasan/common.c:474
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10d/0x220 mm/slab.c:3757
 load_elf_binary+0x2c82/0x36d0 fs/binfmt_elf.c:1085
 search_binary_handler+0x190/0x5e0 fs/exec.c:1658
 exec_binprm fs/exec.c:1701 [inline]
 __do_execve_file+0x1565/0x1cc0 fs/exec.c:1821
 do_execveat_common fs/exec.c:1867 [inline]
 do_execve fs/exec.c:1884 [inline]
 __do_sys_execve fs/exec.c:1960 [inline]
 __se_sys_execve fs/exec.c:1955 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:1955
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888095d34400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 320 bytes inside of
 512-byte region [ffff888095d34400, ffff888095d34600)
The buggy address belongs to the page:
page:ffffea0002574d00 refcount:1 mapcount:0 mapping:ffff8880aa800a80 index:0x0
raw: 00fffe0000000200 ffffea0002741f88 ffffea0002846a48 ffff8880aa800a80
raw: 0000000000000000 ffff888095d34000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888095d34480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888095d34500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888095d34580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888095d34600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888095d34680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

