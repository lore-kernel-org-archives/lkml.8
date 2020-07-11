Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A18C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CB7206F0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGKH2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 03:28:16 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52685 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgGKH2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 03:28:15 -0400
Received: by mail-io1-f70.google.com with SMTP id k12so5037519iom.19
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 00:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ro9NGofy110fHuz5uaPTYTtP8tsNRZe+rg3uoLQHroo=;
        b=qGq/dLm6TJA8Jt86PhURprMYAuPZNscnrM9lMi5RjjH5K+eeqmgEgfmi2XWHR1MwYM
         6lkkalO3vuSHQMe3h6dxVwj5VghlAwVBq2NoiXzLyrgpVUVUfNb8345jBDpi2Ubzilol
         cJ/hiEPUe22y7J6Z0xPF3IIyymXuONo3wubBtw4/K/SdFc7GeCMaqduVI+7RlB8jCASM
         MpN3+A72OHEhqrm+KHyYK8ImxD5LJp7sspAvO1SyZL7/PJFkpL3Hw49p9j/4mnLbQi9X
         l6OeViBcnvINLrdE9EIXAaErjEZJvuQyat66OOtyf/zcxdpMUQNlqGfX8ak8CtqAspnL
         74cA==
X-Gm-Message-State: AOAM532uveAKbu5J5Bg/m6bFOedbARnuvThEqRqlA4e43HXczeWSUyzd
        krUkes4iHxuCs9tcNvhnQTMlmoT0/B3r8GjIr8mCj1jnmeju
X-Google-Smtp-Source: ABdhPJwltAeiPEOi+P5aRMVtDG2gkmbcItDPTBsuewZXfP7nWROJflcJ6Ix9EQheI9cmBaMupwL0c+7ISPlsQy/rXE0sFp4olRdb
MIME-Version: 1.0
X-Received: by 2002:a92:b6d4:: with SMTP id m81mr5516156ill.72.1594452494756;
 Sat, 11 Jul 2020 00:28:14 -0700 (PDT)
Date:   Sat, 11 Jul 2020 00:28:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fd44a05aa2566ee@google.com>
Subject: general protection fault in rb_erase (3)
From:   syzbot <syzbot+ffc5097bd34e69106658@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14a5cbcb100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=ffc5097bd34e69106658
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ffc5097bd34e69106658@syzkaller.appspotmail.com

device veth1_macvtap left promiscuous mode
device veth0_macvtap left promiscuous mode
device veth1_vlan left promiscuous mode
device veth0_vlan left promiscuous mode
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 2809 Comm: kworker/u4:2 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:266 [inline]
RIP: 0010:rb_erase+0xb7/0x1210 lib/rbtree.c:443
Code: 5e 10 4c 89 f5 48 ba 00 00 00 00 00 fc ff df 48 85 db 75 0b e9 9f 04 00 00 48 89 dd 48 89 c3 4c 8d 63 10 4c 89 e0 48 c1 e8 03 <80> 3c 10 00 0f 85 f3 0b 00 00 48 8b 43 10 48 85 c0 75 dc 48 8d 7b
RSP: 0018:ffffc90017aff6c8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000001 RCX: 1ffff11000022949
RDX: dffffc0000000000 RSI: ffff888000114e08 RDI: ffff888000114a48
RBP: ffff888000110000 R08: 0000000000000000 R09: ffffffff89cdc267
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000011
R13: ffff888000114c08 R14: ffff888000114a38 R15: ffff888000114e08
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000caa008 CR3: 00000000a7aa1000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kernfs_unlink_sibling fs/kernfs/dir.c:398 [inline]
 __kernfs_remove+0x623/0xa30 fs/kernfs/dir.c:1331
 kernfs_remove_by_name_ns+0x51/0xb0 fs/kernfs/dir.c:1516
 kernfs_remove_by_name include/linux/kernfs.h:593 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:289
 sysfs_remove_groups fs/sysfs/group.c:313 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:305
 device_remove_groups drivers/base/core.c:1790 [inline]
 device_remove_attrs+0xa9/0x150 drivers/base/core.c:1972
 device_del+0x474/0xd20 drivers/base/core.c:2856
 rollback_registered_many+0xa07/0xf60 net/core/dev.c:9004
 unregister_netdevice_many.part.0+0x1a/0x2f0 net/core/dev.c:10122
 unregister_netdevice_many net/core/dev.c:10121 [inline]
 default_device_exit_batch+0x30c/0x3d0 net/core/dev.c:10605
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:189
 cleanup_net+0x4ea/0xa00 net/core/net_namespace.c:603
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 85e16a2eaea866a0 ]---
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:266 [inline]
RIP: 0010:rb_erase+0xb7/0x1210 lib/rbtree.c:443
Code: 5e 10 4c 89 f5 48 ba 00 00 00 00 00 fc ff df 48 85 db 75 0b e9 9f 04 00 00 48 89 dd 48 89 c3 4c 8d 63 10 4c 89 e0 48 c1 e8 03 <80> 3c 10 00 0f 85 f3 0b 00 00 48 8b 43 10 48 85 c0 75 dc 48 8d 7b
RSP: 0018:ffffc90017aff6c8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000001 RCX: 1ffff11000022949
RDX: dffffc0000000000 RSI: ffff888000114e08 RDI: ffff888000114a48
RBP: ffff888000110000 R08: 0000000000000000 R09: ffffffff89cdc267
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000011
R13: ffff888000114c08 R14: ffff888000114a38 R15: ffff888000114e08
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000caa008 CR3: 00000000a2764000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
