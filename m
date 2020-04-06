Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3399AC2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBFF2074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgDFGhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 02:37:16 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48173 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 02:37:16 -0400
Received: by mail-il1-f198.google.com with SMTP id h26so14156291ilf.15
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 23:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=REYiK+7eusy3KWKKVM8TsRgN2VQoTnNYfSIMQAP2BNQ=;
        b=bCCmiVgISlE4JZXh+LP8zQOX5rcA4Cri4Jb+/I7KMQ97Sw98SJEGlE4yyqqfOD/u36
         UNLw9ixan4UN59SGv6QPeYTp7+X+v0V+06bxtBQNSGd+rUFT+OlZ8STITTxU/thebJsm
         GadhnaaaVGVDgBpMwzR4byrihDYUuB/4K9Zdc+8NZ6PLdgr+9Tq0sa3jq3egRFwfQw1W
         YsdmUl52PTbS2kARCUPbJh5+TRnvyWvrG23sxJQkyYW7z9gNmKrRGVxKPgQ1w+Tp4khT
         OTKctTYIj1ZTKNmcaFn+xJEl2fbtLGbmL/yWpvexAqpOGu/DAmr5yhG38zr9MJPzleip
         ChJw==
X-Gm-Message-State: AGi0PuZMiEidfMY7urulX2rq8MwwLkGa6A8JcSlAtgOqCjqFqIdCrTCE
        26cp7MHvksCYS19fPAjDPszigkmMEuiHik0J6NtBcJkaMUB8
X-Google-Smtp-Source: APiQypJCZkW5iYovJG/5/zzATnUDAFp/gTMvM4IYOf9NrLkH3liqJY8hC6Dc0rFwDBDK+zvwXO0T4U6QcU0VdWJ1gCkcl6zZjYL7
MIME-Version: 1.0
X-Received: by 2002:a92:3d49:: with SMTP id k70mr18622985ila.122.1586155035630;
 Sun, 05 Apr 2020 23:37:15 -0700 (PDT)
Date:   Sun, 05 Apr 2020 23:37:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075245205a2997f68@google.com>
Subject: WARNING in ib_umad_kill_port
From:   syzbot <syzbot+9627a92b1f9262d5d30c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    304e0242 net_sched: add a temporary refcnt for struct tcin..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=119dd16de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1e98458335a7d1
dashboard link: https://syzkaller.appspot.com/bug?extid=9627a92b1f9262d5d30c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9627a92b1f9262d5d30c@syzkaller.appspotmail.com

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'umad1'
WARNING: CPU: 1 PID: 31308 at fs/sysfs/group.c:279 sysfs_remove_group fs/sysfs/group.c:279 [inline]
WARNING: CPU: 1 PID: 31308 at fs/sysfs/group.c:279 sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:270
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 31308 Comm: kworker/u4:10 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound ib_unregister_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:sysfs_remove_group fs/sysfs/group.c:279 [inline]
RIP: 0010:sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:270
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 41 48 8b 33 48 c7 c7 60 c3 39 88 e8 93 c3 5f ff <0f> 0b eb 95 e8 22 62 cb ff e9 d2 fe ff ff 48 89 df e8 15 62 cb ff
RSP: 0018:ffffc90001d97a60 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff88915620 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ca861 RDI: fffff520003b2f3e
RBP: 0000000000000000 R08: ffff8880a78fc2c0 R09: ffffed1015ce66a1
R10: ffffed1015ce66a0 R11: ffff8880ae733507 R12: ffff88808e5ba070
R13: ffffffff88915bc0 R14: ffff88808e5ba008 R15: dffffc0000000000
 dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:794
 device_del+0x18b/0xd30 drivers/base/core.c:2687
 cdev_device_del+0x15/0x80 fs/char_dev.c:570
 ib_umad_kill_port+0x45/0x250 drivers/infiniband/core/user_mad.c:1327
 ib_umad_remove_one+0x18a/0x220 drivers/infiniband/core/user_mad.c:1409
 remove_client_context+0xbe/0x110 drivers/infiniband/core/device.c:724
 disable_device+0x13b/0x230 drivers/infiniband/core/device.c:1270
 __ib_unregister_device+0x91/0x180 drivers/infiniband/core/device.c:1437
 ib_unregister_work+0x15/0x30 drivers/infiniband/core/device.c:1547
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
