Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A49C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4A52080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgIHS00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:26:26 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:35386 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbgIHSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:19:18 -0400
Received: by mail-io1-f80.google.com with SMTP id e83so159036ioa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=S2Mb4SpI/h8mBKwfqNQOF/3SVg/YbSciUKr7OdV2gqg=;
        b=lnEGeT8Lc9acW5Ep4itwGAgph3mquKAD3Ey+AKArbKfLhU1SwmuW0Sd/qgd98VuXwt
         mD6VMApy26YlCR4AeCdXvhFSNfm/aNY/hPTEH6lUX4hmcNZ9IEJvyK3PKIrSfc5JSl68
         ycR1ToFH44zHPJlgvNwWSdO55ZvVrxTJH3qCVCiJDgcowi0CKfPw7uO3hzKxC6vDlbzY
         o2HNHptM/nOPzfvVp0LZbYnEboF1Bk+93Vz/vEJkhn8i3y3FcnnqSZPZstI1bPfMjV0e
         10NlG8ISdg2DWm6dXuf027gMv0qSudGzMG0MeIojxg7mZqCAx81OzeIg2bBZdJAAzvBx
         ZMmQ==
X-Gm-Message-State: AOAM533C04WjyYHkqLpolRsHqKHkVlnQ6id6mMYQJi+s+YEDXLkhiGZQ
        Y2YdXuq6/4+pme8wyvPJtFBd0Vm3XseIFgzFjrLBNYzD+khY
X-Google-Smtp-Source: ABdhPJx9M5+HihZdGwu/IgxjDQQsDseb/wY7biF2itXpwP5ccXwPlp+Nchh5g+4RR2atVE+t0SpSjQTRuyeiMO03oureXiOo9zYw
MIME-Version: 1.0
X-Received: by 2002:a92:aa54:: with SMTP id j81mr24598587ili.291.1599589157820;
 Tue, 08 Sep 2020 11:19:17 -0700 (PDT)
Date:   Tue, 08 Sep 2020 11:19:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089e09f05aed15fb9@google.com>
Subject: WARNING in kernfs_get (2)
From:   syzbot <syzbot+d41ab07507be715b63f5@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7a695657 Add linux-next specific files for 20200903
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14089ff5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39134fcec6c78e33
dashboard link: https://syzkaller.appspot.com/bug?extid=d41ab07507be715b63f5
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d41ab07507be715b63f5@syzkaller.appspotmail.com

tipc: TX() has been purged, node left!
------------[ cut here ]------------
WARNING: CPU: 1 PID: 12334 at fs/kernfs/dir.c:494 kernfs_get.part.0+0x69/0x80 fs/kernfs/dir.c:494
Modules linked in:
CPU: 1 PID: 12334 Comm: kworker/u4:0 Not tainted 5.9.0-rc3-next-20200903-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:kernfs_get.part.0+0x69/0x80 fs/kernfs/dir.c:494
Code: 31 ff 89 ee e8 38 14 8b ff 85 ed 74 18 e8 af 17 8b ff be 04 00 00 00 48 89 df e8 22 5e cb ff f0 ff 03 5b 5d c3 e8 97 17 8b ff <0f> 0b eb df 48 89 df e8 eb 8b cb ff eb c6 66 0f 1f 84 00 00 00 00
RSP: 0018:ffffc9001579f730 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88800018bb20 RCX: ffffffff81e9cb48
RDX: ffff888054612200 RSI: ffffffff81e9cb69 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88800018bb23
R10: 0000000000000000 R11: 000000000000016e R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88800018bb20
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055594cc40180 CR3: 000000005d64c000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kernfs_get fs/kernfs/dir.c:493 [inline]
 __kernfs_remove+0x299/0xa30 fs/kernfs/dir.c:1314
 kernfs_remove_by_name_ns+0x51/0xb0 fs/kernfs/dir.c:1516
 kernfs_remove_by_name include/linux/kernfs.h:593 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:289
 sysfs_remove_groups fs/sysfs/group.c:313 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:305
 device_remove_groups drivers/base/core.c:2033 [inline]
 device_remove_attrs+0xba/0x160 drivers/base/core.c:2224
 device_del+0x479/0xd90 drivers/base/core.c:3108
 rollback_registered_many+0xb16/0x1210 net/core/dev.c:9311
 unregister_netdevice_many.part.0+0x1a/0x2f0 net/core/dev.c:10429
 unregister_netdevice_many+0x36/0x50 net/core/dev.c:10428
 ip_tunnel_delete_nets+0x3da/0x580 net/ipv4/ip_tunnel.c:1125
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:189
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:603
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
