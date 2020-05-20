Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A75D20671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgETSXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:23:25 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52636 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgETSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:23:20 -0400
Received: by mail-il1-f199.google.com with SMTP id m7so3430329ill.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=js33CUT4XnRIZOm90eNZcjQKW6NWOvJIuehYuO//P8o=;
        b=NuHhr59VRmj6zVUGSbn3UPOw5T2ZlxxlJ8OkCP7SN+1rxA/ToI8bJuE5RHtLQ25XMS
         P6oCzYIEs3D6fYATS4iOLNI6xvJhx8Q0+v5fAyMJfg+NdsPGUH85ggSA5TcZTcRLxI3W
         EdMXW4J4lr2P6sK6xBGRQ4LJUvckPh0Nb93tfJ2T8nV+8tjEAMlloNNwh9spTixsobcR
         AqgwGME2akkZUr3krnvuIIravAJpg8akvwqsTCK/Tb8KpGh3e2mEYz6U6f13j/JpJ+FA
         l8gCry2QJf7Gdky9T0CMhCojcPyn7ohQlhaWW0peoN/DDl2hyU8wGVxSV0HOUp9ryz0C
         jQAg==
X-Gm-Message-State: AOAM530PJatD8ZKnhcWjXwfbE7+zzHf87j5wNtbyBA/xV9TjOLrEbL+J
        E38SFgyFYPpsseV2NTu0dOKq5Bx9Mb/6w/2TMKFkb2yXKhYL
X-Google-Smtp-Source: ABdhPJz4zPiUSFpJk91dEYRih4mjctRv2kKa+VSCIYraXxlXbfOFj3dM1oy1fFmaZmbS6reJLRRj+DisYui10qKw7Ig+rxwsPDx4
MIME-Version: 1.0
X-Received: by 2002:a02:a904:: with SMTP id n4mr319666jam.105.1589998997373;
 Wed, 20 May 2020 11:23:17 -0700 (PDT)
Date:   Wed, 20 May 2020 11:23:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e87c405a6187d76@google.com>
Subject: KMSAN: uninit-value in get_block
From:   syzbot <syzbot+6e056ee473568865f3e6@syzkaller.appspotmail.com>
To:     aeb@cwi.nl, akpm@linux-foundation.org, danarag@gmail.com,
        glider@google.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8b97c627 kmsan: drop the opportunity to ignore pages
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17f2e73a100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f048d804e1a47a0
dashboard link: https://syzkaller.appspot.com/bug?extid=6e056ee473568865f3e6
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cd424a100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1213334e100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6e056ee473568865f3e6@syzkaller.appspotmail.com

Process accounting resumed
=====================================================
BUG: KMSAN: uninit-value in get_branch fs/minix/itree_common.c:54 [inline]
BUG: KMSAN: uninit-value in get_block+0xa00/0x1f80 fs/minix/itree_common.c:160
CPU: 0 PID: 8783 Comm: syz-executor148 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 get_branch fs/minix/itree_common.c:54 [inline]
 get_block+0xa00/0x1f80 fs/minix/itree_common.c:160
 V1_minix_get_block+0xb5/0xd0 fs/minix/itree_v1.c:56
 minix_get_block+0x13e/0x1f0 fs/minix/inode.c:376
 __block_write_begin_int+0xb05/0x2ad0 fs/buffer.c:2013
 __block_write_begin fs/buffer.c:2063 [inline]
 block_write_begin+0x16c/0x340 fs/buffer.c:2122
 minix_write_begin+0x119/0x3d0 fs/minix/inode.c:412
 generic_perform_write+0x3d4/0x9a0 mm/filemap.c:3302
 __generic_file_write_iter+0x44e/0xa50 mm/filemap.c:3431
 generic_file_write_iter+0x770/0xad0 mm/filemap.c:3463
 call_write_iter include/linux/fs.h:1907 [inline]
 new_sync_write fs/read_write.c:484 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:497
 __kernel_write+0x205/0x600 fs/read_write.c:516
 do_acct_process+0x1b6a/0x1fb0 kernel/acct.c:522
 acct_pin_kill+0x54/0x250 kernel/acct.c:174
 pin_kill+0x1c8/0x5d0 fs/fs_pin.c:44
 acct_on kernel/acct.c:254 [inline]
 __do_sys_acct kernel/acct.c:286 [inline]
 __se_sys_acct+0xbcd/0xdd0 kernel/acct.c:273
 __ia32_sys_acct+0x32/0x50 kernel/acct.c:273
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3bf/0x6d0 arch/x86/entry/common.c:398
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fb7dd9
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f9112c EFLAGS: 00000292 ORIG_RAX: 0000000000000033
RAX: ffffffffffffffda RBX: 0000000020000480 RCX: 0000000000000081
RDX: 00000000000f4240 RSI: 0000000000000000 RDI: 00000000080fbff0
RBP: 00000000080fbffc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 add_chain fs/minix/itree_common.c:14 [inline]
 get_branch fs/minix/itree_common.c:52 [inline]
 get_block+0xa4d/0x1f80 fs/minix/itree_common.c:160
 V1_minix_get_block+0xb5/0xd0 fs/minix/itree_v1.c:56
 minix_get_block+0x13e/0x1f0 fs/minix/inode.c:376
 __block_write_begin_int+0xb05/0x2ad0 fs/buffer.c:2013
 __block_write_begin fs/buffer.c:2063 [inline]
 block_write_begin+0x16c/0x340 fs/buffer.c:2122
 minix_write_begin+0x119/0x3d0 fs/minix/inode.c:412
 generic_perform_write+0x3d4/0x9a0 mm/filemap.c:3302
 __generic_file_write_iter+0x44e/0xa50 mm/filemap.c:3431
 generic_file_write_iter+0x770/0xad0 mm/filemap.c:3463
 call_write_iter include/linux/fs.h:1907 [inline]
 new_sync_write fs/read_write.c:484 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:497
 __kernel_write+0x205/0x600 fs/read_write.c:516
 do_acct_process+0x1b6a/0x1fb0 kernel/acct.c:522
 acct_pin_kill+0x54/0x250 kernel/acct.c:174
 pin_kill+0x1c8/0x5d0 fs/fs_pin.c:44
 acct_on kernel/acct.c:254 [inline]
 __do_sys_acct kernel/acct.c:286 [inline]
 __se_sys_acct+0xbcd/0xdd0 kernel/acct.c:273
 __ia32_sys_acct+0x32/0x50 kernel/acct.c:273
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3bf/0x6d0 arch/x86/entry/common.c:398
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:144
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:269 [inline]
 kmsan_alloc_page+0xb9/0x180 mm/kmsan/kmsan_shadow.c:293
 __alloc_pages_nodemask+0x56a2/0x5dc0 mm/page_alloc.c:4848
 alloc_pages_current+0x67d/0x990 mm/mempolicy.c:2295
 alloc_pages include/linux/gfp.h:540 [inline]
 __page_cache_alloc+0x95/0x310 mm/filemap.c:959
 pagecache_get_page+0xab7/0x1250 mm/filemap.c:1645
 find_or_create_page include/linux/pagemap.h:308 [inline]
 grow_dev_page fs/buffer.c:983 [inline]
 grow_buffers fs/buffer.c:1052 [inline]
 __getblk_slow fs/buffer.c:1079 [inline]
 __getblk_gfp+0x4bb/0xfc0 fs/buffer.c:1356
 __bread_gfp+0xb9/0x670 fs/buffer.c:1401
 sb_bread include/linux/buffer_head.h:309 [inline]
 get_branch fs/minix/itree_common.c:46 [inline]
 get_block+0x73e/0x1f80 fs/minix/itree_common.c:160
 V1_minix_get_block+0xb5/0xd0 fs/minix/itree_v1.c:56
 minix_get_block+0x13e/0x1f0 fs/minix/inode.c:376
 __block_write_begin_int+0xb05/0x2ad0 fs/buffer.c:2013
 __block_write_begin fs/buffer.c:2063 [inline]
 block_write_begin+0x16c/0x340 fs/buffer.c:2122
 minix_write_begin+0x119/0x3d0 fs/minix/inode.c:412
 generic_perform_write+0x3d4/0x9a0 mm/filemap.c:3302
 __generic_file_write_iter+0x44e/0xa50 mm/filemap.c:3431
 generic_file_write_iter+0x770/0xad0 mm/filemap.c:3463
 call_write_iter include/linux/fs.h:1907 [inline]
 new_sync_write fs/read_write.c:484 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:497
 __kernel_write+0x205/0x600 fs/read_write.c:516
 do_acct_process+0x1b6a/0x1fb0 kernel/acct.c:522
 acct_pin_kill+0x54/0x250 kernel/acct.c:174
 pin_kill+0x1c8/0x5d0 fs/fs_pin.c:44
 acct_on kernel/acct.c:254 [inline]
 __do_sys_acct kernel/acct.c:286 [inline]
 __se_sys_acct+0xbcd/0xdd0 kernel/acct.c:273
 __ia32_sys_acct+0x32/0x50 kernel/acct.c:273
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3bf/0x6d0 arch/x86/entry/common.c:398
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
