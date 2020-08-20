Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8124EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECA12072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgHTFfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:35:20 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49460 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgHTFfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:35:16 -0400
Received: by mail-io1-f69.google.com with SMTP id c1so581106ioh.16
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 22:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yD7MI1JGQtczkbJQBV7QYmOBcKMlevUe8LY67kKIiqI=;
        b=Nqx+srwB5f0NH/6aQ6VrOBNl10hrzeREGL4vohrmN8c5dhTcavTFue2oslCDh6xHPN
         V/MFib0LwAHILA/Hx7mWZhGlyXBJRRp7xH2BGBb0p38r1TCsCwFjoNcef/58UhEw7dSW
         0tsllQo4h5aBxEE3RxJJ1yoWqa/RKV4tvYmnvB0DLqh12MABejVAnjEZWvZlsyH84QSU
         y5k+nl+UqJHlT3d2+4UvuClX3iUpB8piecS9XwUrAgF/t58VLyrpa3UztLV7RPcDKFWF
         91OUui6naD/7rDBE314++NAWXeJVkIfZoe2PD+yxr4jiiw28uOycX2cZGc65vVdkGoAx
         w+YQ==
X-Gm-Message-State: AOAM532ZYa4awRK207dPd0iJr/x/y9z8Is5cPCCMGBO4n45iSpIq8zHf
        KeZ4U9iwsQcMvoBoT7X6uERo664Zs8az5Gtz6Uk+rLrTALX0
X-Google-Smtp-Source: ABdhPJzp2vXqVfB03OO5G2QrOVXEaldP2QyG/UjOVc4fKagkcLYqKaxfs21p25Aa8JixLOOebRHmONstJxAl4aqiygDvupgHLpY9
MIME-Version: 1.0
X-Received: by 2002:a92:9996:: with SMTP id t22mr1295081ilk.216.1597901715584;
 Wed, 19 Aug 2020 22:35:15 -0700 (PDT)
Date:   Wed, 19 Aug 2020 22:35:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024be1505ad487cbb@google.com>
Subject: KASAN: global-out-of-bounds Read in fbcon_resize
From:   syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, george.kennedy@oracle.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8eb858df Add linux-next specific files for 20200819
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1158a00e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd187ef624ef7f02
dashboard link: https://syzkaller.appspot.com/bug?extid=b38b1ef6edf0c74a8d97
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146a5589900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165aa636900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in fbcon_resize+0x781/0x810 drivers/video/fbdev/core/fbcon.c:2206
Read of size 4 at addr ffffffff8896d418 by task syz-executor732/6868

CPU: 0 PID: 6868 Comm: syz-executor732 Not tainted 5.9.0-rc1-next-20200819-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 fbcon_resize+0x781/0x810 drivers/video/fbdev/core/fbcon.c:2206
 resize_screen drivers/tty/vt/vt.c:1175 [inline]
 vc_do_resize+0x535/0x1150 drivers/tty/vt/vt.c:1246
 vt_ioctl+0x11d2/0x2cc0 drivers/tty/vt/vt_ioctl.c:1025
 tty_ioctl+0x1019/0x15f0 drivers/tty/tty_io.c:2656
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440329
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc8ff997d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440329
RDX: 0000000020000040 RSI: 0000000000005609 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b90
R13: 0000000000401c20 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the variable:
 font_vga_8x16+0x58/0x60

Memory state around the buggy address:
 ffffffff8896d300: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
 ffffffff8896d380: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9
>ffffffff8896d400: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
                            ^
 ffffffff8896d480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8896d500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
