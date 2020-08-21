Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36082C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AE220702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgHUGKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:10:37 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42543 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgHUGKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:10:23 -0400
Received: by mail-il1-f199.google.com with SMTP id z1so756842ilz.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IxFD2LeFV9lhBKwLRF4hOPpykT3iCEC0QBcV1jPgu38=;
        b=oHAftcrh8V+GJXMdU9UYRbtCts0dgMLUoM+T6n4p/2b6UT6UtOv2CkMpUDNRXgZsRE
         sWkVAsQw3OA09TTb16F9++UFuYypA8Jdnhf/BVtfrxXviznY437k2iaCcHw+b/Dn5p2x
         Ow7hopGqXgXFofioTH5A7AlJNia0Y+vFF4yWejKctyg5yWMNOnSYzCUH62j4p0Pp0uVh
         bG/XW7kdHy+Bu/6DYGPH9pyMOItWDhC2p8TRucjFIRlMo8K0/cB8slN/BgadbGgqG9wT
         BUsh1i2sDNlXqUzVPGGh4cMrzreY9aQUUCdmt1upjG6T5gx8un6sZbZpuACeLivK3mUB
         WKNA==
X-Gm-Message-State: AOAM531wpzdB0kGfzwx+eoXgrSyFB1u6BFREKrdLW8ZksD9qffUGNnYP
        FW9/RpuugaxR85F9wnsTGm5FMLZzfAAIxOzSgVc8QB+QiNxd
X-Google-Smtp-Source: ABdhPJxKHmX+9FsrPazIeU1DH/usAm1x+76LJLhB6hFoElErsD/Ghpq4L8j1ReUpXrANYS4p/87LevImetzbXbLvxP0J1xwR69lz
MIME-Version: 1.0
X-Received: by 2002:a6b:bd45:: with SMTP id n66mr1136428iof.121.1597990222356;
 Thu, 20 Aug 2020 23:10:22 -0700 (PDT)
Date:   Thu, 20 Aug 2020 23:10:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ee6f205ad5d1779@google.com>
Subject: general protection fault in afs_dynroot_depopulate
From:   syzbot <syzbot+c1eff8205244ae7e11a6@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    18445bf4 Merge tag 'spi-fix-v5.9-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ff6f29900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=c1eff8205244ae7e11a6
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1eff8205244ae7e11a6@syzkaller.appspotmail.com

RSP: 002b:00007fd9b2daca88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fd9b2dacb20 RCX: 000000000045ff2a
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 00007fd9b2dacae0 R08: 00007fd9b2dacb20 R09: 0000000020000040
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000040
R13: 0000000020000080 R14: 0000000000000000 R15: 0000000020000000
general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 0 PID: 26047 Comm: syz-executor.3 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:afs_dynroot_depopulate+0x25f/0x529 fs/afs/dynroot.c:385
Code: 00 00 0f 84 5c 01 00 00 e8 2e a5 ae fe 4d 8d 7e 68 48 89 ef e8 02 70 2f 05 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 02 00 00 49 8b 46 68 4d 8d ae 18 01 00 00 48
RSP: 0018:ffffc90015fa7ca0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88809edfc000 RCX: 1ffff92002bf4f81
RDX: 000000000000000d RSI: 0000000000000008 RDI: ffff88809dd392c0
RBP: ffff88809dd392c0 R08: 0000000000000001 R09: ffff88809dd392c7
R10: ffffed1013ba7258 R11: 0000000000000001 R12: ffff88809dd39000
R13: ffff8880a650b800 R14: 0000000000000000 R15: 0000000000000068
FS:  00007fd9b2dad700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000016a1000 CR3: 000000008eb1d000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 afs_kill_super+0x13b/0x180 fs/afs/super.c:535
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 afs_get_tree+0x1124/0x1460 fs/afs/super.c:598
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x2070 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ff2a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fd9b2daca88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fd9b2dacb20 RCX: 000000000045ff2a
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 00007fd9b2dacae0 R08: 00007fd9b2dacb20 R09: 0000000020000040
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000040
R13: 0000000020000080 R14: 0000000000000000 R15: 0000000020000000
Modules linked in:
---[ end trace d330bd77c4cff0f5 ]---
RIP: 0010:afs_dynroot_depopulate+0x25f/0x529 fs/afs/dynroot.c:385
Code: 00 00 0f 84 5c 01 00 00 e8 2e a5 ae fe 4d 8d 7e 68 48 89 ef e8 02 70 2f 05 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 02 00 00 49 8b 46 68 4d 8d ae 18 01 00 00 48
RSP: 0018:ffffc90015fa7ca0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88809edfc000 RCX: 1ffff92002bf4f81
RDX: 000000000000000d RSI: 0000000000000008 RDI: ffff88809dd392c0
RBP: ffff88809dd392c0 R08: 0000000000000001 R09: ffff88809dd392c7
R10: ffffed1013ba7258 R11: 0000000000000001 R12: ffff88809dd39000
R13: ffff8880a650b800 R14: 0000000000000000 R15: 0000000000000068
FS:  00007fd9b2dad700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000016a1000 CR3: 000000008eb1d000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
