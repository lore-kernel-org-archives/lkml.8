Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB43EC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C23E21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgBZJ3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:29:12 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:49664 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBZJ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:29:11 -0500
Received: by mail-io1-f72.google.com with SMTP id v2so888944ioq.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Vm/TT9xYGSYah7fGRG9CZBA6qsgVzGUKHCfd/eSxAK8=;
        b=DMOldb+7b+FBTvBGvLbk33U4mJRHZTJajs7BkojZfA+ZV0BHKHwvAQsVKCsQA81I0E
         mYmtWGpHo4DZJuQGZB3/JK5FSvloh2fv+HhrfNXDiCcuJznhCT2vqfZ91V06aBqOvdAY
         7LDJMVoLD/1e8jSvkowdEj2tQCnB9Otb9ABWjN80FpbgeGtUHNWbxU7vFs2MlfWfmckA
         VFAFkfM78IBzNWuAxSuze5dH4LBNhb5PI5Ik+0Gw5GxEoRVilEFv9ZK6VtXmifMRPO7b
         0I6uZrw52wBmdWrjUiucFnQcWYRB2tbnshvq9J99SIoxQUC/7ZDBhZswGanfdB2XLMun
         soaA==
X-Gm-Message-State: APjAAAVefWmc8jHkUce+GiH7w1/ZdI4gcPIuqDljXWTM2gXxgDJgWuhK
        vml1EO94afJj2SHDY0P+3ifKBHBdOuxGWbsHoBDyXXIF/FGI
X-Google-Smtp-Source: APXvYqzN2if73zWL+24svvUU8yS9zO8kDiNYqQlcFkaA0gUIcZUvVRymAIU2KSvAtPPQSHW8Xw3pFRlhpCeYQE+HmwCWWnIM5+84
MIME-Version: 1.0
X-Received: by 2002:a02:cc14:: with SMTP id n20mr3132663jap.138.1582709349590;
 Wed, 26 Feb 2020 01:29:09 -0800 (PST)
Date:   Wed, 26 Feb 2020 01:29:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090aa43059f773ca7@google.com>
Subject: KMSAN: uninit-value in do_update_region
From:   syzbot <syzbot+fd9351b459a0a1e53f37@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com, glider@google.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        maarten.lankhorst@linux.intel.com, okash.khawaja@gmail.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8bbbc5cf kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10a3e891e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=fd9351b459a0a1e53f37
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fd9351b459a0a1e53f37@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in do_update_region+0x6ef/0xb80 drivers/tty/vt/vt.c:665
CPU: 1 PID: 26865 Comm: syz-executor.3 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 do_update_region+0x6ef/0xb80 drivers/tty/vt/vt.c:665
 invert_screen+0x1088/0x1210 drivers/tty/vt/vt.c:794
 set_selection_kernel+0x2583/0x3400 drivers/tty/vt/selection.c:53
 set_selection_user+0x10a/0x150 drivers/tty/vt/selection.c:177
 tioclinux+0x589/0xc40 drivers/tty/vt/vt.c:3039
 vt_ioctl+0x1db1/0x5790 drivers/tty/vt/vt_ioctl.c:364
 vt_compat_ioctl+0x6f3/0x10c0 drivers/tty/vt/vt_ioctl.c:1232
 tty_compat_ioctl+0xa29/0x1850 drivers/tty/tty_io.c:2849
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f2cd99
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d270cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000000541c
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 vgacon_invert_region+0x1f3/0x240 drivers/video/console/vgacon.c:675
 invert_screen+0x362/0x1210 drivers/tty/vt/vt.c:763
 set_selection_kernel+0x2583/0x3400 drivers/tty/vt/selection.c:53
 set_selection_user+0x10a/0x150 drivers/tty/vt/selection.c:177
 tioclinux+0x589/0xc40 drivers/tty/vt/vt.c:3039
 vt_ioctl+0x1db1/0x5790 drivers/tty/vt/vt_ioctl.c:364
 vt_compat_ioctl+0x6f3/0x10c0 drivers/tty/vt/vt_ioctl.c:1232
 tty_compat_ioctl+0xa29/0x1850 drivers/tty/tty_io.c:2849
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 vgacon_invert_region+0x1f3/0x240 drivers/video/console/vgacon.c:675
 invert_screen+0x362/0x1210 drivers/tty/vt/vt.c:763
 set_selection_kernel+0x2583/0x3400 drivers/tty/vt/selection.c:53
 set_selection_user+0x10a/0x150 drivers/tty/vt/selection.c:177
 tioclinux+0x589/0xc40 drivers/tty/vt/vt.c:3039
 vt_ioctl+0x1db1/0x5790 drivers/tty/vt/vt_ioctl.c:364
 vt_compat_ioctl+0x6f3/0x10c0 drivers/tty/vt/vt_ioctl.c:1232
 tty_compat_ioctl+0xa29/0x1850 drivers/tty/tty_io.c:2849
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
 slab_alloc_node mm/slub.c:2793 [inline]
 slab_alloc mm/slub.c:2802 [inline]
 __kmalloc_track_caller+0x8ce/0xef0 mm/slub.c:4371
 kmemdup+0x95/0x140 mm/util.c:127
 ipv4_sysctl_init_net+0xa7/0x640 net/ipv4/sysctl_net_ipv4.c:1350
 ops_init+0x2d3/0x730 net/core/net_namespace.c:137
 setup_net+0x286/0x12b0 net/core/net_namespace.c:327
 copy_net_ns+0x551/0xa70 net/core/net_namespace.c:468
 create_new_namespaces+0x9a8/0x11e0 kernel/nsproxy.c:108
 unshare_nsproxy_namespaces+0x25e/0x340 kernel/nsproxy.c:229
 ksys_unshare+0x8d5/0x1120 kernel/fork.c:2957
 __do_sys_unshare kernel/fork.c:3025 [inline]
 __se_sys_unshare kernel/fork.c:3023 [inline]
 __ia32_sys_unshare+0x58/0x80 kernel/fork.c:3023
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
