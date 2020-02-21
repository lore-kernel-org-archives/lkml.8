Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B65EC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57473207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBULIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:08:13 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:42374 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBULIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:08:12 -0500
Received: by mail-il1-f199.google.com with SMTP id s13so2212550ili.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 03:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MgE+DMKK7w/A58UKfkHZtfe87ipUHMsp/YUFmat9gu8=;
        b=h+llU8AUPyFjaLFC3cUkRKy1alL6rIQSDcAFpfaIITzzZHDCOsrHDC2ivvip2H8BEa
         n4VCB0w1Ll2SGOY/5keKQsnkuGZP9koUwVOjELWdr2NkCinpRx4Chx+z7jLT7yu8gvXC
         McDrRKnte9TbEzZXyv9SFkxVPaOflU6uogrxamAvVjAjvnyqE6N/sDUelL3BUBXovpJk
         Q6gTnxD2DzAOUDuge4Qm6XdgPKsXK8yy6XlZvGQG7LCLKceR4Ciwr7d+YvgqR9h1voBi
         Acr8Wy00ONFy00SCp1bL6vFTjzGwfgUjv7QArlgMMFqEh4LY17v6g0nqyosFszvA15Cz
         muZg==
X-Gm-Message-State: APjAAAXzUEl/s+d4uemnoMGBxzkg/dP+RzjgBf4GoF72m/JHlwi6Wf3S
        pQabG0UBWyI9Q6PCFkxRCJhe0BRTC18DeloJYVTQBGqJ7raF
X-Google-Smtp-Source: APXvYqwfhAiQy6u9q+a28BToR9ZBWwQNx+Jk4d+Tz+/6yivLC4zlgoY+44Gl9dWXocBdR9gFh9+0tNkPYYzv0cCsMcS1CT5le+PW
MIME-Version: 1.0
X-Received: by 2002:a6b:39c4:: with SMTP id g187mr30018851ioa.271.1582283291793;
 Fri, 21 Feb 2020 03:08:11 -0800 (PST)
Date:   Fri, 21 Feb 2020 03:08:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a9e79059f1409f1@google.com>
Subject: KMSAN: uninit-value in fat_evict_inode
From:   syzbot <syzbot+9d82b8de2992579da5d0@syzkaller.appspotmail.com>
To:     glider@google.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8bbbc5cf kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12c5fdede00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=9d82b8de2992579da5d0
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d82b8de2992579da5d0@syzkaller.appspotmail.com

FAT-fs (loop2): Invalid FSINFO signature: 0x00000000, 0x00000000 (sector = 1)
FAT-fs (loop2): error, fat_get_cluster: invalid start cluster (i_pos 1, start bb1414ac)
FAT-fs (loop2): Filesystem has been set read-only
=====================================================
BUG: KMSAN: uninit-value in fat_free_eofblocks fs/fat/inode.c:628 [inline]
BUG: KMSAN: uninit-value in fat_evict_inode+0x2f4/0x920 fs/fat/inode.c:658
CPU: 0 PID: 9035 Comm: syz-executor.2 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 fat_free_eofblocks fs/fat/inode.c:628 [inline]
 fat_evict_inode+0x2f4/0x920 fs/fat/inode.c:658
 evict+0x4ab/0xe10 fs/inode.c:575
 iput_final fs/inode.c:1571 [inline]
 iput+0xa70/0xe10 fs/inode.c:1597
 fat_fill_super+0x7b5c/0x89b0 fs/fat/inode.c:1865
 vfat_fill_super+0xa6/0xc0 fs/fat/namei_vfat.c:1050
 mount_bdev+0x654/0x880 fs/super.c:1417
 vfat_mount+0xc9/0xe0 fs/fat/namei_vfat.c:1057
 legacy_get_tree+0x169/0x2e0 fs/fs_context.c:622
 vfs_get_tree+0xdd/0x580 fs/super.c:1547
 do_new_mount fs/namespace.c:2822 [inline]
 do_mount+0x365c/0x4ac0 fs/namespace.c:3107
 __do_compat_sys_mount fs/compat.c:122 [inline]
 __se_compat_sys_mount+0x3a8/0xa10 fs/compat.c:89
 __ia32_compat_sys_mount+0x157/0x1b0 fs/compat.c:89
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f11d99
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d0bef0 EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f5d0bf8c RCX: 0000000020000380
RDX: 00000000f5d0bf6c RSI: 0000000000000000 RDI: 00000000f5d0bfcc
RBP: 00000000f5d0c168 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:144
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:307 [inline]
 kmsan_alloc_page+0x12a/0x310 mm/kmsan/kmsan_shadow.c:336
 __alloc_pages_nodemask+0x5712/0x5e80 mm/page_alloc.c:4775
 alloc_pages_current+0x67d/0x990 mm/mempolicy.c:2211
 alloc_pages include/linux/gfp.h:534 [inline]
 alloc_slab_page+0x111/0x12f0 mm/slub.c:1530
 allocate_slab mm/slub.c:1675 [inline]
 new_slab+0x2bc/0x1130 mm/slub.c:1741
 new_slab_objects mm/slub.c:2492 [inline]
 ___slab_alloc+0x1533/0x1f30 mm/slub.c:2643
 __slab_alloc mm/slub.c:2683 [inline]
 slab_alloc_node mm/slub.c:2757 [inline]
 slab_alloc mm/slub.c:2802 [inline]
 kmem_cache_alloc+0xb23/0xd70 mm/slub.c:2807
 fat_alloc_inode+0x58/0x120 fs/fat/inode.c:748
 alloc_inode fs/inode.c:231 [inline]
 new_inode_pseudo+0xb1/0x590 fs/inode.c:927
 new_inode+0x5a/0x3d0 fs/inode.c:956
 fat_fill_super+0x634b/0x89b0 fs/fat/inode.c:1844
 vfat_fill_super+0xa6/0xc0 fs/fat/namei_vfat.c:1050
 mount_bdev+0x654/0x880 fs/super.c:1417
 vfat_mount+0xc9/0xe0 fs/fat/namei_vfat.c:1057
 legacy_get_tree+0x169/0x2e0 fs/fs_context.c:622
 vfs_get_tree+0xdd/0x580 fs/super.c:1547
 do_new_mount fs/namespace.c:2822 [inline]
 do_mount+0x365c/0x4ac0 fs/namespace.c:3107
 __do_compat_sys_mount fs/compat.c:122 [inline]
 __se_compat_sys_mount+0x3a8/0xa10 fs/compat.c:89
 __ia32_compat_sys_mount+0x157/0x1b0 fs/compat.c:89
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
