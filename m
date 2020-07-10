Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F89C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A74720720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgGJQOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:14:18 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:37724 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgGJQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:14:17 -0400
Received: by mail-il1-f199.google.com with SMTP id x23so4011350ilk.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=F8ETx0vaYCpDAVW+B9gsHZoXMwniNFuDf+Ol2MGgQZY=;
        b=Hqcowh4NRCE4VmKDxcNrUcmMT5ap7TLFHrxC13AtROnhHnScf6r3z91xZK54MJCAZ0
         k8K8IdkShCTTrGtFYjw1jYyajAFHJTpHZdNFxvDaoYyB/IfBobTVBZ7sXkt+LhJ3qf5K
         NmQJDgE+RhziIYnhA3qNPb+vRCiqasS/l4ln1IWGPMIoHKUG9Q1RCMcKK0TUYMfW50mj
         1emOY5E+hQ8PoodYnxZcIv8mV4wg3Af2jH2G0bEmEmcAh/pVo4u8b2XYCNkCAVm0njn9
         5v92dM09tLvYpcmOCLOwS9gwIBQ6xMW/4nblQkYYmhekSJ/Hw3NxhXvFmlTYuAdcEviP
         tMQQ==
X-Gm-Message-State: AOAM532jl4UPUYTTdbF3tE8K9MhVfIj/32FgVmAEy9wh9YuFjKiVrWAW
        ROCzdTVib0DTx1at9UaLH5d5cs8vvKwmpb3X9LAJmQyOKxNh
X-Google-Smtp-Source: ABdhPJzXe2nBUANY/8YxQUPL62yrEEnagss/tumVtukRFaZx/1qIToxaU9/S5KeN14ViRe2kpFlkFfFsvzC/b9c85rTf7unAc3lF
MIME-Version: 1.0
X-Received: by 2002:a02:10c1:: with SMTP id 184mr76573612jay.135.1594397656071;
 Fri, 10 Jul 2020 09:14:16 -0700 (PDT)
Date:   Fri, 10 Jul 2020 09:14:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebc53005aa18a1a5@google.com>
Subject: WARNING in fat12_ent_blocknr
From:   syzbot <syzbot+756199124937b31a9b7e@syzkaller.appspotmail.com>
To:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1566637b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=756199124937b31a9b7e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+756199124937b31a9b7e@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 9933 at fs/fat/fatent.c:27 fat12_ent_blocknr+0x198/0x1f0 fs/fat/fatent.c:27
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9933 Comm: syz-executor.4 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:fat12_ent_blocknr+0x198/0x1f0 fs/fat/fatent.c:27
Code: ff df 48 c1 ea 03 d3 fb 01 eb 80 3c 02 00 48 63 db 75 4d 49 89 1e 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 58 87 58 ff <0f> 0b e9 0a ff ff ff e8 3c 25 98 ff eb b7 e8 45 25 98 ff eb 83 4c
RSP: 0018:ffffc90007ef7a30 EFLAGS: 00010216
RAX: 00000000000005b2 RBX: 0000000000000003 RCX: ffffc900116c9000
RDX: 0000000000040000 RSI: ffffffff821b7fa8 RDI: 0000000000000006
RBP: 0000000000000002 R08: 0000000000000000 R09: ffff88804d53804f
R10: 0000000000000002 R11: 0000000000000000 R12: ffff88804a232000
R13: ffffc90007ef7ab8 R14: ffffc90007ef7ac8 R15: ffff88804d538000
 fat_ra_init.constprop.0.isra.0+0x1d3/0x3f0 fs/fat/fatent.c:665
 fat_count_free_clusters+0x230/0x950 fs/fat/fatent.c:726
 fat_statfs+0x3ac/0x4c0 fs/fat/inode.c:829
 statfs_by_dentry+0x133/0x210 fs/statfs.c:64
 vfs_statfs fs/statfs.c:88 [inline]
 user_statfs+0xa9/0x160 fs/statfs.c:103
 __do_sys_statfs+0x7a/0xf0 fs/statfs.c:193
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:367
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb29
Code: Bad RIP value.
RSP: 002b:00007f648bab7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 00000000005092e0 RCX: 000000000045cb29
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000020000240
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000bf1 R14: 00000000004c3aaf R15: 00007f648bab86d4
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
