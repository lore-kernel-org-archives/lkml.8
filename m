Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99E7206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGPGsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:48:23 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47133 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgGPGsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:48:22 -0400
Received: by mail-io1-f69.google.com with SMTP id d22so2972066iom.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OFifGj1bpxyVFH3Z5htoU+/Cya+UEwRA7ahquxGsdCc=;
        b=PgJIHkKPXUqSa/1LUqlrtfeNDRkOPASDnY0RkwV4I+hHVAAUQTPyNIIjNBri7JmwKV
         und/d+mvH4ZsrDwNz7zWngfuMiouWbDhITDCWsgn57dLtTeull3T+80vUOM13eX0ekod
         gggHjsMr/tsVvSqdRuIpfFlcwZX0YQNYgpgSnza8504ZaMn65mL1K25TqN+TzRMMFluo
         TOcJAXlzw3mEgSMylM+C0IyDtvMGy9dcMsxXYajKLp4dLQxu8KN8AoIqLZcz8xn1/hxf
         Wx0zu7OITvvxwXcBlMYxycx9YgqIpjsW4kEA7eAHnlXxhuL9yxf4lSIcBmPIcTxapldQ
         JB2Q==
X-Gm-Message-State: AOAM530dTsIzLnG5v/OfsP9nxu13kQYzFC1KXtDKJtB9ss7DRQK45v9a
        gC0kkb2nlewHmrpbJDfaL1IuX5dlXS/keOdCDOZErI5vFlY1
X-Google-Smtp-Source: ABdhPJwdwOV3nh2DmNOY5EuQZIHehLf6enFoJyxNsl9XErw63EENc4tI6Gc7/776/Yk8aQ0NXgcwmm9t4X3aE0TOVNN0aZ2JqUR1
MIME-Version: 1.0
X-Received: by 2002:a5e:8a03:: with SMTP id d3mr3175234iok.38.1594882101542;
 Wed, 15 Jul 2020 23:48:21 -0700 (PDT)
Date:   Wed, 15 Jul 2020 23:48:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f045905aa896d03@google.com>
Subject: general protection fault in idr_remove (2)
From:   syzbot <syzbot+57e2087e595b699e856e@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a581387e Merge tag 'io_uring-5.8-2020-07-10' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1135d463100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=57e2087e595b699e856e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57e2087e595b699e856e@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 0 PID: 32496 Comm: systemd-udevd Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:idr_remove+0x22/0x50 lib/idr.c:154
Code: 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 48 89 f3 e8 13 1e c6 fd 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 04 3c 03 7e 15 8b 45 50 48 89 ef 31 d2 48 29
RSP: 0018:ffffc90016eef540 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000025411 RCX: ffffffff815afc00
RDX: 000000000000000c RSI: ffffffff83ad997d RDI: 0000000000000060
RBP: 0000000000000010 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52002ddde9d R11: 0000000000000000 R12: ffff88809125a488
R13: ffff88801f6243e0 R14: ffff88809125a4c0 R15: 0000000080000001
FS:  00007fdae029e8c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdadf1a006c CR3: 00000000a2028000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kernfs_put.part.0+0x294/0x540 fs/kernfs/dir.c:535
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:511
 evict+0x2ed/0x750 fs/inode.c:576
 iput_final fs/inode.c:1652 [inline]
 iput.part.0+0x424/0x850 fs/inode.c:1678
 iput+0x58/0x70 fs/inode.c:1668
 dentry_unlink_inode+0x2b1/0x3d0 fs/dcache.c:374
 __dentry_kill+0x3c0/0x640 fs/dcache.c:579
 shrink_dentry_list+0x144/0x480 fs/dcache.c:1141
 shrink_dcache_parent+0x219/0x3c0 fs/dcache.c:1568
 d_invalidate fs/dcache.c:1677 [inline]
 d_invalidate+0x13f/0x280 fs/dcache.c:1662
 lookup_fast+0x3ca/0x6c0 fs/namei.c:1509
 walk_component+0xc6/0x6a0 fs/namei.c:1856
 link_path_walk.part.0+0x6b8/0xc20 fs/namei.c:2183
 link_path_walk fs/namei.c:2112 [inline]
 path_openat+0x25a/0x2750 fs/namei.c:3356
 do_filp_open+0x17e/0x3c0 fs/namei.c:3387
 do_sys_openat2+0x16f/0x3b0 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 ksys_open include/linux/syscalls.h:1388 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1199
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fdadf1116f0
Code: Bad RIP value.
RSP: 002b:00007ffcb6cea898 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000556042e587c0 RCX: 00007fdadf1116f0
RDX: 00000000000001b6 RSI: 0000000000080000 RDI: 00007ffcb6ceaa40
RBP: 0000000000000008 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000080000 R11: 0000000000000246 R12: 0000556042d0f68a
R13: 0000000000000001 R14: 0000556042e58370 R15: 00007ffcb6ceaad0
Modules linked in:
---[ end trace 62f52bf15222f667 ]---
RIP: 0010:idr_remove+0x22/0x50 lib/idr.c:154
Code: 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 48 89 f3 e8 13 1e c6 fd 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 04 3c 03 7e 15 8b 45 50 48 89 ef 31 d2 48 29
RSP: 0018:ffffc90016eef540 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000025411 RCX: ffffffff815afc00
RDX: 000000000000000c RSI: ffffffff83ad997d RDI: 0000000000000060
RBP: 0000000000000010 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52002ddde9d R11: 0000000000000000 R12: ffff88809125a488
R13: ffff88801f6243e0 R14: ffff88809125a4c0 R15: 0000000080000001
FS:  00007fdae029e8c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdadf1a006c CR3: 00000000a2028000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
