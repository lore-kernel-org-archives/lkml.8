Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EED2206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGWGdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:33:23 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38807 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWGdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:33:22 -0400
Received: by mail-io1-f70.google.com with SMTP id l13so3441757ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9ZNQFolZjTGuo5fpV5ljOshyZjm9Tk6Te/pbR0610OU=;
        b=fHk7b5r90C91EXf2sIGlWTT1mkSKIiNtpigzOvgjbBRFsTlfow0LznfaIr0Tkg9yjj
         /3ysBHolnLVlGUqBvoE5C5C8X6H4uNVgyHUCI2pUHtkAYvmtN+kcCkEUysW/g4LSNuQw
         ZTk2LRn0DjvYZTYEtT3e1eklvBUKozXadz+fLO8PUb6Ot6wtUH4qq/KX2a4/1nIHuPNS
         2+wozzlrWytUeLpzLJCd6TAuK1Mv1AdexbWhtadVEOhyP+pf4n+ogvBn9Umdq8GmQ4cl
         yKooIHjg4Rq6IW3qr8yLJ78xBm31hfZAzvgZqJETdK4Iap0Gh/xATm4A9V51YXJ5ZY4v
         ZX5w==
X-Gm-Message-State: AOAM5332o3khoGCigI1GxKZXlRX/SPYcbHf8BE1WuYf6sF+hv0NAvirH
        kaKBUXas3SgO5WnPhc4rsJGy5sMs7GdSlW8d0ai7rXYYeq5n
X-Google-Smtp-Source: ABdhPJzmAmYO5ua3dlQDHr0vNi/zN2JhnbKgbWmdXnsCjwttw2UiMCpmfJ2DvslWrxM7wdZsqchk2PIo8sH/shQmR5CMNvtQUDTy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:80b:: with SMTP id u11mr3734479ilm.178.1595486001806;
 Wed, 22 Jul 2020 23:33:21 -0700 (PDT)
Date:   Wed, 22 Jul 2020 23:33:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061c43305ab160810@google.com>
Subject: KMSAN: uninit-value in vcs_read (2)
From:   syzbot <syzbot+ed5a476d9404e07b9165@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    14525656 compiler.h: reinstate missing KMSAN_INIT
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=176de9d7100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c534a9fad6323722
dashboard link: https://syzkaller.appspot.com/bug?extid=ed5a476d9404e07b9165
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed5a476d9404e07b9165@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10 mm/kmsan/kmsan_hooks.c:428
CPU: 0 PID: 20988 Comm: syz-executor.2 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1df/0x240 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 kmsan_internal_check_memory+0x358/0x3d0 mm/kmsan/kmsan.c:457
 kmsan_check_memory+0xd/0x10 mm/kmsan/kmsan_hooks.c:428
 instrument_copy_to_user include/linux/instrumented.h:91 [inline]
 _copy_to_user+0x100/0x1d0 lib/usercopy.c:30
 copy_to_user include/linux/uaccess.h:161 [inline]
 vcs_read+0x17db/0x2340 drivers/tty/vt/vc_screen.c:424
 do_loop_readv_writev fs/read_write.c:734 [inline]
 do_iter_read+0xb84/0xdb0 fs/read_write.c:955
 vfs_readv fs/read_write.c:1073 [inline]
 do_preadv+0x3aa/0x5a0 fs/read_write.c:1165
 __do_sys_preadv fs/read_write.c:1215 [inline]
 __se_sys_preadv+0xc6/0xe0 fs/read_write.c:1210
 __x64_sys_preadv+0x62/0x80 fs/read_write.c:1210
 do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c1d9
Code: Bad RIP value.
RSP: 002b:00007f2e7c998c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000023a40 RCX: 000000000045c1d9
RDX: 00000000000001a2 RSI: 00000000200017c0 RDI: 0000000000000005
RBP: 000000000078bf48 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
R13: 0000000000c9fb6f R14: 00007f2e7c9999c0 R15: 000000000078bf0c

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 vc_uniscr_copy_line+0x49b/0x730 drivers/tty/vt/vt.c:572
 vcs_read+0xc72/0x2340 drivers/tty/vt/vc_screen.c:332
 do_loop_readv_writev fs/read_write.c:734 [inline]
 do_iter_read+0xb84/0xdb0 fs/read_write.c:955
 vfs_readv fs/read_write.c:1073 [inline]
 do_preadv+0x3aa/0x5a0 fs/read_write.c:1165
 __do_sys_preadv fs/read_write.c:1215 [inline]
 __se_sys_preadv+0xc6/0xe0 fs/read_write.c:1210
 __x64_sys_preadv+0x62/0x80 fs/read_write.c:1210
 do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:144
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:269 [inline]
 kmsan_alloc_page+0xb9/0x180 mm/kmsan/kmsan_shadow.c:293
 __alloc_pages_nodemask+0x56a2/0x5dc0 mm/page_alloc.c:4889
 alloc_pages_current+0x672/0x990 mm/mempolicy.c:2292
 alloc_pages include/linux/gfp.h:545 [inline]
 __vmalloc_area_node mm/vmalloc.c:2489 [inline]
 __vmalloc_node_range+0x875/0x11f0 mm/vmalloc.c:2555
 __vmalloc_node mm/vmalloc.c:2598 [inline]
 vmalloc+0x117/0x130 mm/vmalloc.c:2631
 vc_uniscr_alloc drivers/tty/vt/vt.c:354 [inline]
 vc_do_resize+0x632/0x3290 drivers/tty/vt/vt.c:1222
 vt_resize+0x10e/0x170 drivers/tty/vt/vt.c:1355
 tty_ioctl+0x2ad4/0x2f00 drivers/tty/tty_io.c:2502
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0x2e9/0x410 fs/ioctl.c:760
 __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:760
 do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Bytes 0-127 of 128 are uninitialized
Memory access of size 128 starts at ffff96eeb1987000
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
