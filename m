Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C4FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D8A20768
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgHLH0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:26:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:47785 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHLH0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:26:22 -0400
Received: by mail-il1-f198.google.com with SMTP id e12so1175218ile.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RZp10viMzg/+BaClxoZpPO/2GSkXEmSSRCiPzxZC4d4=;
        b=pyN9z373R0EZ106OnTpXCvYXXiIBDwGD66ZZmVYX287FjdAttYlu4ajh+AMqwF2bag
         f+M3EZ8KwPUKWdsohwVimMe6x+z/ko6f3HikRCGk/qVRG60GRzwGE1LPWXLXrIXN0W4r
         cRHgLILQgic9Z1gWLdriwwnnbmdprB08jZI7WzSN71Ln/5m8IN8uFzVFpB/+95bfym0j
         XZ/oAMUVN/6DRbjaLzVaQ/X7vuCwUNkiDbocxmJCduXmln/3NE45bS7D/gAO2U+F3FyW
         HS6bFfN74uPMMiGLbAdIeFLdlx+O6pSwatD+yOkv/eETpgmxXnl50IihpDqBtfBUREHH
         2qeA==
X-Gm-Message-State: AOAM5338qdp/jIN15oUrKDe9dYKjU/5gf47zRErAVaWzObnxt8EJnIQ/
        Qbj4Eq6geKvPV+wOrwQjKmjJN1J+qmvOEjBqIXcujW0Lhf+H
X-Google-Smtp-Source: ABdhPJzLQnciRrQ6exAdPueUn+u+KQ1UnQ5MqKi9vZOdjfol90tZiEi3KJZfyj5Uw9iR6IITGiFVCyMQyWsucr8CpfuWnrq6goia
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a7:: with SMTP id b7mr29385067jaq.1.1597217181038;
 Wed, 12 Aug 2020 00:26:21 -0700 (PDT)
Date:   Wed, 12 Aug 2020 00:26:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b48d9205aca91a5a@google.com>
Subject: upstream boot error: KASAN: global-out-of-bounds Read in internal_create_group
From:   syzbot <syzbot+1cf0ffe61aecf46f588f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fb893de3 Merge tag 'tag-chrome-platform-for-v5.9' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1323384a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4f36703531c4ada
dashboard link: https://syzkaller.appspot.com/bug?extid=1cf0ffe61aecf46f588f
compiler:       gcc (GCC) 10.1.0-syz 20200507

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1cf0ffe61aecf46f588f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in create_files fs/sysfs/group.c:43 [inline]
BUG: KASAN: global-out-of-bounds in internal_create_group+0x9d8/0xb20 fs/sysfs/group.c:149
Read of size 8 at addr ffffffff8a2e4cf0 by task kworker/u17:10/959

CPU: 2 PID: 959 Comm: kworker/u17:10 Not tainted 5.8.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 create_files fs/sysfs/group.c:43 [inline]
 internal_create_group+0x9d8/0xb20 fs/sysfs/group.c:149
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:185 [inline]
 sysfs_create_groups+0x25/0x50 fs/sysfs/group.c:215
 device_add_groups drivers/base/core.c:2024 [inline]
 device_add_attrs drivers/base/core.c:2178 [inline]
 device_add+0x7fd/0x1c40 drivers/base/core.c:2881
 nd_async_device_register+0x12/0x80 drivers/nvdimm/bus.c:506
 async_run_entry_fn+0x121/0x530 kernel/async.c:123
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the variable:
 nvdimm_firmware_attributes+0x10/0x40

Memory state around the buggy address:
 ffffffff8a2e4b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8a2e4c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff8a2e4c80: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 f9 f9
                                                             ^
 ffffffff8a2e4d00: f9 f9 f9 f9 00 00 00 00 00 00 00 f9 f9 f9 f9 f9
 ffffffff8a2e4d80: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
