Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B1C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 04:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C67D20757
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 04:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgIFEES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 00:04:18 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56868 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIFEER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 00:04:17 -0400
Received: by mail-il1-f197.google.com with SMTP id w82so7672905ila.23
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 21:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D9RWBKnDcRHR+i0Ivp0wxR/5XlJ0oZvRXxI49VlJIYg=;
        b=KxL4wxhj+OlTQQGvWq4Lnb1Yz0xEWhOFSzUL6tbT1u46RCgM3jvP7mqBz886IgFjaj
         ODeRJTMcQFRRv9fVOTcGB+9p97kC4OxY1Ug3zIleMWtlTqIuy3oo0VeFYSSL7W4CtpkC
         DBuSuoxPz4lDSwz0KmSUScZqaq/Vl2xTdZu43afSgO12xAuI8+O6kUsHdqOaItktw7xG
         fSlwF9P5z5B97y323G6CV8JSAOrSgUSBkgqzbaIUv5qQA0d2/ZNyF0HhdZ9JT97Fs4xe
         kgvpSckQkJVOh9v2qgvXBVVY0tymtau4yyfeHWAS/nBcU2cXFV2phCMwZLgJqjIE69Pe
         zT8A==
X-Gm-Message-State: AOAM530kUQS+B0Hc4CsAfh7e+61tsSdJ4kYcKzZ8o1aAvAQP6WaL9Uxd
        YOBwI/eJsoVZNcHWa4RmgxEBcJ3lcv/iLGKiRSJvQd+TUHQo
X-Google-Smtp-Source: ABdhPJwZn7/sWbmkHfRo8NAPWpx/t3no2HxLODcbRjjFX/ltZYG9P/zUwWjOlSJrV5ISuiYshULJAuc1jcfwrNSj1l3PO8ke19vc
MIME-Version: 1.0
X-Received: by 2002:a92:cb91:: with SMTP id z17mr10363003ilo.200.1599365056286;
 Sat, 05 Sep 2020 21:04:16 -0700 (PDT)
Date:   Sat, 05 Sep 2020 21:04:16 -0700
In-Reply-To: <000000000000eca3eb0598e26a3d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bd4d405ae9d32a4@google.com>
Subject: Re: KMSAN: kernel-infoleak in vcs_read (2)
From:   syzbot <syzbot+31a641689d43387f05d3@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        jwilk@jwilk.net, linux-kernel@vger.kernel.org, nico@fluxnic.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3b3ea602 x86: add failure injection to get/put/clear_user
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13232335900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extid=31a641689d43387f05d3
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b2a1a5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139ce245900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31a641689d43387f05d3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
CPU: 0 PID: 8471 Comm: syz-executor446 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 kmsan_internal_check_memory+0x19d/0x3d0 mm/kmsan/kmsan.c:443
 kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
 instrument_copy_to_user include/linux/instrumented.h:91 [inline]
 _copy_to_user+0x18e/0x260 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:170 [inline]
 vcs_read+0x1c6f/0x2920 drivers/tty/vt/vc_screen.c:424
 vfs_read+0x577/0x14d0 fs/read_write.c:479
 ksys_read+0x275/0x500 fs/read_write.c:607
 __do_sys_read fs/read_write.c:617 [inline]
 __se_sys_read+0x92/0xb0 fs/read_write.c:615
 __x64_sys_read+0x4a/0x70 fs/read_write.c:615
 do_syscall_64+0xad/0x160 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4453c9
Code: Bad RIP value.
RSP: 002b:00007fffa3c8af98 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004453c9
RDX: 0000000000002020 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000022239 R08: 00000000004002e0 R09: 00000000004002e0
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000402590
R13: 0000000000402620 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 vc_uniscr_copy_line+0x545/0x800 drivers/tty/vt/vt.c:572
 vcs_read+0x107d/0x2920 drivers/tty/vt/vc_screen.c:332
 vfs_read+0x577/0x14d0 fs/read_write.c:479
 ksys_read+0x275/0x500 fs/read_write.c:607
 __do_sys_read fs/read_write.c:617 [inline]
 __se_sys_read+0x92/0xb0 fs/read_write.c:615
 __x64_sys_read+0x4a/0x70 fs/read_write.c:615
 do_syscall_64+0xad/0x160 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:144
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:269 [inline]
 kmsan_alloc_page+0xc5/0x1a0 mm/kmsan/kmsan_shadow.c:293
 __alloc_pages_nodemask+0xdf0/0x1030 mm/page_alloc.c:4889
 alloc_pages_current+0x685/0xb50 mm/mempolicy.c:2292
 alloc_pages include/linux/gfp.h:545 [inline]
 __vmalloc_area_node mm/vmalloc.c:2489 [inline]
 __vmalloc_node_range+0x989/0x1400 mm/vmalloc.c:2555
 __vmalloc_node mm/vmalloc.c:2598 [inline]
 vmalloc+0xe0/0xf0 mm/vmalloc.c:2631
 vc_uniscr_alloc drivers/tty/vt/vt.c:354 [inline]
 vc_do_resize+0x73e/0x38f0 drivers/tty/vt/vt.c:1222
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

Bytes 0-319 of 640 are uninitialized
Memory access of size 640 starts at ffff8880bbb25000
Data copied to user address 0000000020000100
=====================================================

