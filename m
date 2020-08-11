Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A178EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CA92076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgHKQ4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:56:17 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:53808 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgHKQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:56:16 -0400
Received: by mail-il1-f197.google.com with SMTP id o18so3980325ill.20
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GedL4rxZJZbKBBmJ7qPKl8QjPTnq5TDLPqmyY44QahQ=;
        b=PcdiAXcUTwAFU7pcjK5C6xXipcRwQopcznynG9tT29SHJB1D4AhgzLCj0cpLZpCFM/
         TvFVirV1yTQe46mSfv5jY3yCp0y/GXvCx9vjEe3XLaPE2V/2IvKpESAmQKBs4/WVcjcv
         IJHf4Nen6oRgY8p3D+Z18zLdQPCUuOfR1bf72pnhXdM95csf7qO/j6+UQKoPzS9z7HMC
         2hpklq+LL7iJ+IQtShYNy4LXoTgMxdLT8IZh0jIcGjwkVHGmpZ3DloQUn8PyqpRNFVvy
         b0hisdg8Ps/Im4lWnmOML+EmhlM7/LE/pbA9HPZiG65iUR4mnWvOR3iqnb09C+Gz66C/
         Czsw==
X-Gm-Message-State: AOAM532bcFwEJqBFRshz7jpoKEjyX+u100nTJoMMq/iJE9lTTzTxG3rd
        Wz3PYUlPvpKWa5tS1zW2MdjvvSUzB7TUoLXd003UnB+KcS5Y
X-Google-Smtp-Source: ABdhPJwCFCGTIWj2rJgIhbS2RJkrN7WGLOJDvati0u7f8I1cEjnSTN5GeK1wjz7bMfT/dB6nZQB4ePJbZ5eupKkbfv6lsJUSwVFS
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2409:: with SMTP id s9mr21785827ioa.98.1597164975060;
 Tue, 11 Aug 2020 09:56:15 -0700 (PDT)
Date:   Tue, 11 Aug 2020 09:56:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc7a3705ac9cf2e7@google.com>
Subject: KMSAN: uninit-value in tda8083_attach
From:   syzbot <syzbot+909a91e75919efd2b557@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13095584900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extid=909a91e75919efd2b557
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+909a91e75919efd2b557@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in tda8083_attach+0x55a/0x6d0 drivers/media/dvb-frontends/tda8083.c:428
CPU: 1 PID: 8650 Comm: kworker/1:1 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 tda8083_attach+0x55a/0x6d0 drivers/media/dvb-frontends/tda8083.c:428
 frontend_init drivers/media/usb/ttusb-budget/dvb-ttusb-budget.c:1574 [inline]
 ttusb_probe+0x4238/0x5040 drivers/media/usb/ttusb-budget/dvb-ttusb-budget.c:1739
 usb_probe_interface+0xece/0x1550 drivers/usb/core/driver.c:374
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_set_configuration+0x380f/0x3f10 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:241
 usb_probe_device+0x311/0x490 drivers/usb/core/driver.c:272
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x5e7b/0x8a70 drivers/usb/core/hub.c:5576
 process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
 worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
 kthread+0x551/0x590 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Local variable ----reg1.addr.i.i@tda8083_attach created at:
 tda8083_readregs drivers/media/dvb-frontends/tda8083.c:425 [inline]
 tda8083_readreg drivers/media/dvb-frontends/tda8083.c:83 [inline]
 tda8083_attach+0x1af/0x6d0 drivers/media/dvb-frontends/tda8083.c:428
 tda8083_readregs drivers/media/dvb-frontends/tda8083.c:425 [inline]
 tda8083_readreg drivers/media/dvb-frontends/tda8083.c:83 [inline]
 tda8083_attach+0x1af/0x6d0 drivers/media/dvb-frontends/tda8083.c:428
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
