Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9277FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66685217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVCqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 21:46:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:36620 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgAVCqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:46:10 -0500
Received: by mail-io1-f71.google.com with SMTP id d4so803161iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 18:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CnmJ1OM8AajhHelTc4pwqra0mee/T7vjUj19UkyCazU=;
        b=piTaemBWrwrofHsAAz+44GU/KS1zv0OCmC3V8t2L0mliCIFzUnSLu4RR6WAbKMvnIp
         Xsm/KtK0N8YFWam7MOgMeh4+nioj74Bqps1NwEt8u9mLAFVHplGMDrCo8XanJy1WCEQS
         HaOB4T9yysaPWJANX/MAGMXbDs7xZ7RudG6bH4/xI+u0jr7Pz6B3EMQevLnQp0l+KGfh
         waEgLoKSb3ILoNsspYWpugVGnCzT6p7KJhwugIZ4iye7uJd3afcV8TZvftpWiwgmhinR
         j0ETkbLNTJUfHod5Q+YvpLpjpdCtwgGz2AFyOi8p5lI2mF3tqKCLGJdVzhxZoONC+gD/
         TYIA==
X-Gm-Message-State: APjAAAXt6up1cXVz4CEs/MGj/CeJ/sQBjdA4/RFPGFCgxf15wevZ3CpE
        IkSiBqyhu5jC88iY0twKkJgKwtC9sNMcFGZN2Oq/A6eCqvHQ
X-Google-Smtp-Source: APXvYqzO36U1CWiBCZPaztJE39pC7F9i9I9PyYjUT3QIQnf2iRHRU6CRkA6EXnH4+R+StCeRQaqY4ijV4VwkEXsh9UVjRUeF+MmV
MIME-Version: 1.0
X-Received: by 2002:a02:85e8:: with SMTP id d95mr5584594jai.92.1579661169626;
 Tue, 21 Jan 2020 18:46:09 -0800 (PST)
Date:   Tue, 21 Jan 2020 18:46:09 -0800
In-Reply-To: <00000000000044bcb8059a0a577e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1971b059cb18636@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in vc_do_resize
From:   syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13ae7369e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf8e288883e40aba
dashboard link: https://syzkaller.appspot.com/bug?extid=c37a14770d51a085a520
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ab6bd1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [inline]
BUG: KASAN: slab-out-of-bounds in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in vc_do_resize+0x959/0x1460 drivers/tty/vt/vt.c:1250
Read of size 192 at addr ffff8880a3f85940 by task syz-executor.0/9662

CPU: 0 PID: 9662 Comm: syz-executor.0 Not tainted 5.5.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:639
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
 memcpy+0x24/0x50 mm/kasan/common.c:125
 memcpy include/linux/string.h:380 [inline]
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 vc_do_resize+0x959/0x1460 drivers/tty/vt/vt.c:1250
 vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
 fbcon_modechanged+0x367/0x790 drivers/video/fbdev/core/fbcon.c:2980
 fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
 fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
 do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
 vfs_ioctl fs/ioctl.c:47 [inline]
 file_ioctl fs/ioctl.c:545 [inline]
 do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
 ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
 __do_sys_ioctl fs/ioctl.c:756 [inline]
 __se_sys_ioctl fs/ioctl.c:754 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b349
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8865c72c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8865c736d4 RCX: 000000000045b349
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000002cd R14: 00000000004c3dc6 R15: 000000000075bf2c

Allocated by task 9662:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:513 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x163/0x770 mm/slab.c:3665
 kmalloc include/linux/slab.h:561 [inline]
 kzalloc include/linux/slab.h:670 [inline]
 vc_do_resize+0x262/0x1460 drivers/tty/vt/vt.c:1187
 vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
 fbcon_modechanged+0x367/0x790 drivers/video/fbdev/core/fbcon.c:2980
 fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
 fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
 fbcon_resize+0x6b1/0x780 drivers/video/fbdev/core/fbcon.c:2222
 resize_screen drivers/tty/vt/vt.c:1126 [inline]
 vc_do_resize+0x440/0x1460 drivers/tty/vt/vt.c:1205
 vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
 fbcon_modechanged+0x367/0x790 drivers/video/fbdev/core/fbcon.c:2980
 fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
 fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
 do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
 vfs_ioctl fs/ioctl.c:47 [inline]
 file_ioctl fs/ioctl.c:545 [inline]
 do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
 ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
 __do_sys_ioctl fs/ioctl.c:756 [inline]
 __se_sys_ioctl fs/ioctl.c:754 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9469:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:335 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 skb_free_head+0x93/0xb0 net/core/skbuff.c:591
 skb_release_data+0x551/0x8d0 net/core/skbuff.c:611
 skb_release_all+0x4d/0x60 net/core/skbuff.c:665
 __kfree_skb net/core/skbuff.c:679 [inline]
 consume_skb net/core/skbuff.c:838 [inline]
 consume_skb+0xfb/0x410 net/core/skbuff.c:832
 unix_stream_read_generic+0x18ec/0x1de0 net/unix/af_unix.c:2363
 unix_stream_recvmsg+0xc3/0x100 net/unix/af_unix.c:2421
 sock_recvmsg_nosec net/socket.c:873 [inline]
 sock_recvmsg net/socket.c:891 [inline]
 sock_recvmsg+0xce/0x110 net/socket.c:887
 sock_read_iter+0x2f8/0x420 net/socket.c:969
 call_read_iter include/linux/fs.h:1896 [inline]
 new_sync_read+0x680/0x800 fs/read_write.c:414
 __vfs_read+0xe1/0x110 fs/read_write.c:427
 vfs_read+0x1f0/0x440 fs/read_write.c:461
 ksys_read+0x220/0x290 fs/read_write.c:587
 __do_sys_read fs/read_write.c:597 [inline]
 __se_sys_read fs/read_write.c:595 [inline]
 __x64_sys_read+0x73/0xb0 fs/read_write.c:595
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a3f85800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 320 bytes inside of
 512-byte region [ffff8880a3f85800, ffff8880a3f85a00)
The buggy address belongs to the page:
page:ffffea00028fe140 refcount:1 mapcount:0 mapping:ffff8880aa400a80 index:0x0
raw: 00fffe0000000200 ffffea00029f71c8 ffffea00029463c8 ffff8880aa400a80
raw: 0000000000000000 ffff8880a3f85000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a3f85880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880a3f85900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880a3f85980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff8880a3f85a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880a3f85a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

