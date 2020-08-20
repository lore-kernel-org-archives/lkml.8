Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D146DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53B12072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHTE4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:56:21 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:54206 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHTE4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 00:56:15 -0400
Received: by mail-il1-f197.google.com with SMTP id o18so732419ill.20
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IV+LyH+BPu5J+Dtv08XtTCzIg9KfbMGVvqfxRyaesJ0=;
        b=QKUui3vsnTQm0/Z+fnOEIuHs0CzD+2znzAG+i4RUCL2jUheXJ9CnxXezc061VCjWrj
         QMlkO5n//bYVdxsAjGBOIaUkKkhNDHAlikNPVAXVeP5vl+Q0EbLhnEsl+whIr4u93zZl
         vp/GwLkTnQsapTLXlFRQCZJfNhZ8LBcWYUTBWmh7Iq9LYlwhc6VM8Le8PA0QbHtgXO+0
         iSPbh6cO9bDw5ZL7ymBTQbhiFKnq0prj5Q7TZLUoab5uwhJhj63Gecbb8dcvbk9dcYcM
         52E5ikBjvWGmAkyd99fRLv6Q97skMZndK/qcx/xTPaibhJ1/RO4QE3qOIm00FuAw/OkF
         zQeQ==
X-Gm-Message-State: AOAM532sVyGLf+o4En16hz9MQMBm5ki9Gip9zGfvFpM6aTaoLn6yh8ML
        wh2b5vgZt9VzXDNtkTQbl4q6DifzohEbo0N/RXXDzsbL6/hn
X-Google-Smtp-Source: ABdhPJzvndFcEzOxi42FfsPZucM5ZTRPrmX++CIV+o19zD4YzElcu7VQEdDp9jZRR2wIDznxF50kvGcjvyJefBVZTcytpRGmI6Nz
MIME-Version: 1.0
X-Received: by 2002:a02:9307:: with SMTP id d7mr1628969jah.71.1597899374117;
 Wed, 19 Aug 2020 21:56:14 -0700 (PDT)
Date:   Wed, 19 Aug 2020 21:56:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094c57905ad47f05e@google.com>
Subject: KMSAN: uninit-value in soft_cursor
From:   syzbot <syzbot+2741e4d93bff16ad8d4d@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        glider@google.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14dcd116900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extid=2741e4d93bff16ad8d4d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103f7891900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2741e4d93bff16ad8d4d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in soft_cursor+0xa89/0x13f0 drivers/video/fbdev/core/softcursor.c:61
CPU: 0 PID: 12272 Comm: syz-executor.2 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 soft_cursor+0xa89/0x13f0 drivers/video/fbdev/core/softcursor.c:61
 bit_cursor+0x38c6/0x3a40 drivers/video/fbdev/core/bitblit.c:386
 fbcon_cursor+0x195e/0x1a60 drivers/video/fbdev/core/fbcon.c:1411
 set_cursor drivers/tty/vt/vt.c:915 [inline]
 redraw_screen+0x28ee/0x2980 drivers/tty/vt/vt.c:1031
 vc_do_resize+0x36a8/0x38f0 drivers/tty/vt/vt.c:1314
 vc_resize+0xc3/0xe0 drivers/tty/vt/vt.c:1334
 fbcon_modechanged+0xdc1/0x1320 drivers/video/fbdev/core/fbcon.c:2990
 fbcon_update_vcs+0x86/0xa0 drivers/video/fbdev/core/fbcon.c:3048
 fb_set_var+0x1420/0x1850 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0xc00/0x1150 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0x1e4/0x210 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0x319/0x4d0 fs/ioctl.c:760
 __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:760
 do_syscall_64+0xad/0x160 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d239
Code: Bad RIP value.
RSP: 002b:00007ff9aafacc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000d580 RCX: 000000000045d239
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 000000000169fb6f R14: 00007ff9aafad9c0 R15: 000000000118cf4c

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 soft_cursor+0x44d/0x13f0 drivers/video/fbdev/core/softcursor.c:50
 bit_cursor+0x38c6/0x3a40 drivers/video/fbdev/core/bitblit.c:386
 fbcon_cursor+0x195e/0x1a60 drivers/video/fbdev/core/fbcon.c:1411
 set_cursor drivers/tty/vt/vt.c:915 [inline]
 redraw_screen+0x28ee/0x2980 drivers/tty/vt/vt.c:1031
 vc_do_resize+0x36a8/0x38f0 drivers/tty/vt/vt.c:1314
 vc_resize+0xc3/0xe0 drivers/tty/vt/vt.c:1334
 fbcon_modechanged+0xdc1/0x1320 drivers/video/fbdev/core/fbcon.c:2990
 fbcon_update_vcs+0x86/0xa0 drivers/video/fbdev/core/fbcon.c:3048
 fb_set_var+0x1420/0x1850 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0xc00/0x1150 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0x1e4/0x210 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0x319/0x4d0 fs/ioctl.c:760
 __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:760
 do_syscall_64+0xad/0x160 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Local variable ----cursor@bit_cursor created at:
 bit_cursor+0xe3/0x3a40 drivers/video/fbdev/core/bitblit.c:239
 bit_cursor+0xe3/0x3a40 drivers/video/fbdev/core/bitblit.c:239
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
