Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22880C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023B420722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCTRgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:36:15 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52912 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTRgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:36:15 -0400
Received: by mail-io1-f72.google.com with SMTP id e21so5196691ios.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=f6YMHfjGnTP/8tpRuBlv/1UcczrHhE1lvW3GQCZN6jo=;
        b=a8gkH+swzDFZkIhgKzDr80gWmXWN60EkLZvpC7qcgfPi78py54NnsVZbITiuuNOgXs
         hH62EIkhZNFs6wye+CEgGzTNG/7vkBgbThw0/ZcNYmu63/IGuuiKkOWJf1OvQoFPR4Yt
         6EXHyi7WmFIIoU3WNPgNdBnrODEM5W1CaI0lr+Z7akLuiYrTNUScFaSWGHb/DyMMhb9b
         6eMRpfp1rxaf1txFcOktHBzWuNeMonh2WbPuO+rzwXfxSqTSjpiW+VWeFcGX7PY/5ZzF
         V4M/j7EBWY6hI33pP/VcUTMCx1146fv0PONuTh2XcAdpn6vqMiWZNcFS//XJD1jKuGJj
         AFnw==
X-Gm-Message-State: ANhLgQ0o/tezVWgRyo8PBxcY7DhWdI4wxfxrrM9UmKDGXp6PHZ3qvyw4
        KYPeApMDL1cSplQX7o1hjchMy0avvBsnwviyVc1+Nj9/Kyka
X-Google-Smtp-Source: ADFU+vuWnrKmg+t9ZBYrg60qhMerqd32AYFr+T07WRSMw35JqJhGd5CPwXr27RVuXtxbj83tAYf8K+0/wMtfoFvjkF6+J2OnDyJw
MIME-Version: 1.0
X-Received: by 2002:a92:2911:: with SMTP id l17mr9927998ilg.166.1584725772967;
 Fri, 20 Mar 2020 10:36:12 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:36:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3a75205a14cb8c9@google.com>
Subject: WARNING in ib_uverbs_remove_one
From:   syzbot <syzbot+d3f37b9458fe8281d078@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5076190d mm: slub: be more careful about the double cmpxch..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1601ab55e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
dashboard link: https://syzkaller.appspot.com/bug?extid=d3f37b9458fe8281d078
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d3f37b9458fe8281d078@syzkaller.appspotmail.com

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'uverbs0'
WARNING: CPU: 0 PID: 73 at fs/sysfs/group.c:278 sysfs_remove_group fs/sysfs/group.c:278 [inline]
WARNING: CPU: 0 PID: 73 at fs/sysfs/group.c:278 sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 73 Comm: kworker/u4:3 Not tainted 5.6.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound ib_unregister_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:sysfs_remove_group fs/sysfs/group.c:278 [inline]
RIP: 0010:sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 41 48 8b 33 48 c7 c7 60 a8 19 88 e8 c3 0d 61 ff <0f> 0b eb 95 e8 92 ba cb ff e9 d2 fe ff ff 48 89 df e8 85 ba cb ff
RSP: 0018:ffffc90001057ad0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff887145e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815c06c1 RDI: fffff5200020af4c
RBP: 0000000000000000 R08: ffff8880a9330580 R09: ffffed1015cc6659
R10: ffffed1015cc6658 R11: ffff8880ae6332c7 R12: ffff8880905fc058
R13: ffffffff88714b80 R14: ffff88804d598558 R15: ffffffff8a1df3e0
 dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:741
 device_del+0x18b/0xd30 drivers/base/core.c:2654
 cdev_device_del+0x15/0x80 fs/char_dev.c:570
 ib_uverbs_remove_one drivers/infiniband/core/uverbs_main.c:1207 [inline]
 ib_uverbs_remove_one+0x3f/0x540 drivers/infiniband/core/uverbs_main.c:1199
 remove_client_context+0xbe/0x110 drivers/infiniband/core/device.c:724
 disable_device+0x13b/0x230 drivers/infiniband/core/device.c:1268
 __ib_unregister_device+0x91/0x180 drivers/infiniband/core/device.c:1435
 ib_unregister_work+0x15/0x30 drivers/infiniband/core/device.c:1545
 process_one_work+0x94b/0x1690 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x357/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
