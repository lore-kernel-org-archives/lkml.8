Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C052C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAD32177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHGHQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:16:25 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48918 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHGHQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:16:24 -0400
Received: by mail-io1-f70.google.com with SMTP id k10so971507iow.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OO3Q8CrVHRBuOi/YH4CBh0Wwl12/N/j2vjuXZ553ypI=;
        b=Ro+b9zuv/tjsGjOKDhOxRPaZExQUyZbXVDPvUyfX33NW84VoCwZsBbcEiMdzWgRWB2
         DniyI2p5LC05ca2E0HUH3WHG1EOc7Rmb4/rg74IYc6yvro8ODDwYj/LoYDK6wXYZ76Ok
         drc7mnfrVqZ7HAwRT+BAvVL7KCgCn1Tsubgq1Xr6vPytylRqiV9WJTS9dIF9z2bbvxmb
         c5EOavwyq4Y7qmG2wxjTXtb/QeYILIgYctNsbKNSJevMt2Jy7uNH8AZPTwzhmL+YJJZK
         seQm0ET36N6d0JKOpzoPZGws3UiKQPZU6KNURzrPxHfxB1gwArN4jctLzXr15jj9cM9u
         pzRg==
X-Gm-Message-State: AOAM532sDUc0F4NHvlVMGR9LlSbOre4OTBECbSTJldkaeV4+GPFEbCsp
        /nrrRftlCfJ562oWbc5MA9zZLXzBLtjSTyofaXSkaRiM8axj
X-Google-Smtp-Source: ABdhPJwEIVuxGhXN9XBU+72Oqwehxi/aQnjzwAa7mc9utApu36Le+7G9OqhYyrqGjB5wKOnma3Rh22T/vpSIEhtceZUEhd14Nbal
MIME-Version: 1.0
X-Received: by 2002:a92:9116:: with SMTP id t22mr3026831ild.305.1596784583029;
 Fri, 07 Aug 2020 00:16:23 -0700 (PDT)
Date:   Fri, 07 Aug 2020 00:16:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dabdc805ac4461b5@google.com>
Subject: INFO: trying to register non-static key in l2cap_chan_close
From:   syzbot <syzbot+3ae233f384d5b0aaa9e0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    01830e6c Add linux-next specific files for 20200731
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171e3dc6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e226b2d1364112c
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae233f384d5b0aaa9e0
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e18fec900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ae233f384d5b0aaa9e0@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 6982 Comm: kworker/0:1 Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894 [inline]
 register_lock_class+0x157d/0x1630 kernel/locking/lockdep.c:1206
 __lock_acquire+0xf9/0x5640 kernel/locking/lockdep.c:4303
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5003
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:359 [inline]
 lock_sock_nested+0x3b/0x110 net/core/sock.c:3048
 l2cap_sock_teardown_cb+0x88/0x400 net/bluetooth/l2cap_sock.c:1520
 l2cap_chan_close+0x2cc/0xb10 net/bluetooth/l2cap_core.c:832
 l2cap_chan_timeout+0x173/0x450 net/bluetooth/l2cap_core.c:436
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
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
