Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C9BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB0320674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgCLVrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:47:15 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54648 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgCLVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:47:15 -0400
Received: by mail-io1-f70.google.com with SMTP id r8so4929548ioj.21
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 14:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RHtneNZtey88S86E96ZMBHzZqJ04cKFcU/exnbgNbj0=;
        b=eQfNVuYUDUDrc+cpg90p7MttNXvN1ewDfvR3hDkHjiyBxH+CK7l1nDIE7ZPV0U9Vus
         WVPhVuo9ZtWC/e+oFtmffqO2rQ9VykiTZhYbJbLt855JakE3BgfET8MKMTuFQj/Rm10z
         +d9Z/qzVYAswqbEAZsVU7o55imuEJzY5x8lj0NWb7pask0ZLvV+yeuMYovVPHHU8SFTd
         EScobYqur+W5KKZuESsp9hLwCY5/gZZ+8xq3tKyliP8WZfhfeykfD0hscJDsS9+gnhMU
         jl3RJNKR3cVuCa8ywqZaFEaTwknKE+R8l6h59tVtdNfPiuNVCtdcg2p9EnBvCal9LfP4
         KWeA==
X-Gm-Message-State: ANhLgQ08rOaomFYYmJ9LKwm4HJXSKV8aAMtdzE9gwqxGST1XnAcnszw6
        zNfV+zU5ppunIERJL3J23TdNcmrcHXxBnJXXwuEfRPtLGc4c
X-Google-Smtp-Source: ADFU+vtNAsdEJDvFkjaw8aVDv5RzmoW8j/BlKR98t67Ky5vYATxmRKbTnCsVID5kEOVBaLwLwSuY/K1Eb6bdPvN2aplooJvHSXvo
MIME-Version: 1.0
X-Received: by 2002:a92:5cd4:: with SMTP id d81mr10136452ilg.57.1584049632451;
 Thu, 12 Mar 2020 14:47:12 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:47:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a622f205a0af4b31@google.com>
Subject: KMSAN: uninit-value in set_selection_kernel
From:   syzbot <syzbot+0b81ae727db96ee52ca8@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, okash.khawaja@gmail.com,
        samuel.thibault@ens-lyon.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8bbbc5cf kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1056f41de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=0b81ae727db96ee52ca8
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0b81ae727db96ee52ca8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in store_utf8 drivers/tty/vt/selection.c:128 [inline]
BUG: KMSAN: uninit-value in set_selection_kernel+0x2c0b/0x3400 drivers/tty/vt/selection.c:319
CPU: 1 PID: 12961 Comm: syz-executor.5 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 store_utf8 drivers/tty/vt/selection.c:128 [inline]
 set_selection_kernel+0x2c0b/0x3400 drivers/tty/vt/selection.c:319
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
RIP: 0023:0xf7f85d99
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d800cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000000541c
RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:144
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:307 [inline]
 kmsan_alloc_page+0x12a/0x310 mm/kmsan/kmsan_shadow.c:336
 __alloc_pages_nodemask+0x5712/0x5e80 mm/page_alloc.c:4775
 alloc_pages_current+0x67d/0x990 mm/mempolicy.c:2211
 alloc_pages include/linux/gfp.h:534 [inline]
 kmalloc_order mm/slab_common.c:1324 [inline]
 kmalloc_order_trace+0x8d/0x450 mm/slab_common.c:1340
 kmalloc_large include/linux/slab.h:484 [inline]
 __kmalloc+0x305/0x450 mm/slub.c:3828
 kmalloc include/linux/slab.h:560 [inline]
 vc_uniscr_alloc+0x95/0x730 drivers/tty/vt/vt.c:353
 vc_do_resize+0x5e7/0x2bd0 drivers/tty/vt/vt.c:1192
 vc_resize+0xc3/0xe0 drivers/tty/vt/vt.c:1304
 vt_ioctl+0x5622/0x5790 drivers/tty/vt/vt_ioctl.c:887
 vt_compat_ioctl+0x6f3/0x10c0 drivers/tty/vt/vt_ioctl.c:1232
 tty_compat_ioctl+0xa29/0x1850 drivers/tty/tty_io.c:2849
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
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
