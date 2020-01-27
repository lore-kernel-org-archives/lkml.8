Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B68BC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4798721734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgA0GcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:32:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:52228 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgA0GcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 01:32:09 -0500
Received: by mail-il1-f200.google.com with SMTP id o5so4143286ilg.19
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 22:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iO6O/FgCOf0bXG5HF+i2dBXp41Z5woScotWQb1U/cfI=;
        b=aJ5iA/3GrhlicvOZHxnpYHrpDWYac0sec1GbJRnBw1b+x7pJeoSGhtp39KT7sGOdj5
         cU+XUkaWr8GDAaYhfLrH6OYx44cH5d4U/n+JOH/oR+CVxj/GjQlVomGJUH+Vgc9mwwRK
         5e0Yh0rOp3VyDYNWT1KYwNDbWErzp1kNJvr4x6A3YVRrenYO4MZYIjC69HqYqok8hDjU
         99vbn2nlCqjIvghv0yeqj7x3izz1itiJtw9oJWZK88YoMfUxvPWlfRpvFL/cWDPSUaZz
         15hLQGoXaojazF8XL77z+RGx0ZwDIhBP8OaYgEV9hp/rI8X5fg5Rw9t07kN+Hga3Azrb
         d8dQ==
X-Gm-Message-State: APjAAAUZope6foZK/RIm42s+/fm0HwI36POPljqstu8MLUOS/JacMo7X
        MTSvAJ5HuYvrCbyn/SjndQpSb7AaPBd+dfjYJ4Tz6SFADHjm
X-Google-Smtp-Source: APXvYqxlz4Wdvp8MqcxjBVzusbec5Bj7oHOV3enMQ6tI2WMNoZXIi7WYrs2JeWdpjDcj1foHglYiIqF+3jxk4Vdhem/9NkXm4iBR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr13371571ils.54.1580106728758;
 Sun, 26 Jan 2020 22:32:08 -0800 (PST)
Date:   Sun, 26 Jan 2020 22:32:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046634b059d19447e@google.com>
Subject: KASAN: user-memory-access Read in do_con_write
From:   syzbot <syzbot+d322a47d68f7864e920a@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        ghalat@redhat.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net,
        okash.khawaja@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a45ea48e afs: Fix characters allowed into cell names
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a62e01e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=708fe207b84027b3
dashboard link: https://syzkaller.appspot.com/bug?extid=d322a47d68f7864e920a
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d322a47d68f7864e920a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in scr_memmovew include/linux/vt_buffer.h:68 [inline]
BUG: KASAN: user-memory-access in insert_char drivers/tty/vt/vt.c:839 [inline]
BUG: KASAN: user-memory-access in csi_at drivers/tty/vt/vt.c:1964 [inline]
BUG: KASAN: user-memory-access in do_con_trol drivers/tty/vt/vt.c:2431 [inline]
BUG: KASAN: user-memory-access in do_con_write+0x89dd/0xf360 drivers/tty/vt/vt.c:2797
Read of size 2 at addr 000000010000000c by task syz-executor.5/22173

CPU: 1 PID: 22173 Comm: syz-executor.5 Not tainted 5.5.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 __kasan_report+0x167/0x1c0 mm/kasan/report.c:510
 kasan_report+0x26/0x50 mm/kasan/common.c:639
 check_memory_region_inline mm/kasan/generic.c:182 [inline]
 check_memory_region+0x2b6/0x2f0 mm/kasan/generic.c:192
 memmove+0x28/0x60 mm/kasan/common.c:116
 scr_memmovew include/linux/vt_buffer.h:68 [inline]
 insert_char drivers/tty/vt/vt.c:839 [inline]
 csi_at drivers/tty/vt/vt.c:1964 [inline]
 do_con_trol drivers/tty/vt/vt.c:2431 [inline]
 do_con_write+0x89dd/0xf360 drivers/tty/vt/vt.c:2797
 con_write+0x25/0x40 drivers/tty/vt/vt.c:3135
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0xd0c/0x1200 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x5a1/0x950 drivers/tty/tty_io.c:1046
 __vfs_write+0xb8/0x740 fs/read_write.c:494
 vfs_write+0x270/0x580 fs/read_write.c:558
 ksys_write+0x117/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x7b/0x90 fs/read_write.c:620
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b349
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9bb5dedc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9bb5dee6d4 RCX: 000000000045b349
RDX: 0000000000000007 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000c99 R14: 00000000004cd78a R15: 000000000075bf2c
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
