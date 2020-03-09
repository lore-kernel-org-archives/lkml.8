Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53339C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DFC2464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCIQPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:15:09 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42100 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgCIQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:15:08 -0400
Received: by mail-il1-f200.google.com with SMTP id j88so4533119ilg.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9zzUUBsjKr6KczX9uzbph8LOVH6gXDITomJHnUFNSaA=;
        b=CBR9bN+U67PZhsQyF1k5N9bwnIpX9WAC9sr6pHEuLmxjV956B6qEpFAouPH1CXv5zq
         foVUYXXn0sWhJeS9lb3kTv1DTaP2d8kazcmTroZ+7QVP1wb6ZEAP6A4NZupfNiUSUFYv
         sHPcOmoqis7w90pgvMv0XeDbX+hsdKhPssW37dCHjaAwQZigqNAMMgi6EqnexsaShPm0
         IEFGZ+CbCpBtgSIAH0vrf6lbeqhEMjU8E3XvVFs8pRWqGODi6QyIe3LkzffWKGicjheB
         mQSrZywv/KGfNnvDJXXAwaJI6uJ51mmwUXC4rMxuGsODqxQd6LmJnlnEvoAj76sYJC3l
         PfUw==
X-Gm-Message-State: ANhLgQ2EGdVBFPoklv7qcMfojwG6WB+r+kGw+16M292oscwA0NycpvQ/
        swTktkswdoUHyU+F0YFBsFc14t4gQNd7m+wRV6t+9JBr75Uj
X-Google-Smtp-Source: ADFU+vt618OQJ2LFPvn7dX8T7ihvg7FA7SSZCsv3MCTEuY4SqVYq688PvuRjK2SS6uWJz260s2Omp3ZpUcGvtTW3RcVQrg5h0UjO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cf:: with SMTP id r15mr4237237ilq.260.1583770508152;
 Mon, 09 Mar 2020 09:15:08 -0700 (PDT)
Date:   Mon, 09 Mar 2020 09:15:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b571005a06e4e2c@google.com>
Subject: BUG: corrupted list in __uwb_rc_neh_rm
From:   syzbot <syzbot+fac5fdfd55355c99284a@syzkaller.appspotmail.com>
To:     alexios.zavras@intel.com, allison@lohutok.net,
        andreyknvl@google.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rfontana@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d6ff8147 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=15e35181e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90a3d9bed5648419
dashboard link: https://syzkaller.appspot.com/bug?extid=fac5fdfd55355c99284a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1162e81de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e3aa2de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fac5fdfd55355c99284a@syzkaller.appspotmail.com

list_del corruption, ffff8881d5809070->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:45!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__list_del_entry_valid.cold+0x23/0x55 lib/list_debug.c:45
Code: e8 e0 b4 3e ff 0f 0b 48 89 ee 48 c7 c7 40 28 fc 85 e8 cf b4 3e ff 0f 0b 4c 89 ea 48 89 ee 48 c7 c7 80 27 fc 85 e8 bb b4 3e ff <0f> 0b 4c 89 e2 48 89 ee 48 c7 c7 e0 27 fc 85 e8 a7 b4 3e ff 0f 0b
RSP: 0018:ffff8881da266cd8 EFLAGS: 00010086
RAX: 000000000000004e RBX: ffff8881d5809000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812977dd RDI: ffffed103b44cd8d
RBP: ffff8881d5809070 R08: 000000000000004e R09: ffffed103b66439f
R10: ffffed103b66439e R11: ffff8881db321cf3 R12: dead000000000122
R13: dead000000000100 R14: ffff8881cde645d8 R15: 00000000ffffffb9
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa54a51f518 CR3: 0000000007021000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del include/linux/list.h:146 [inline]
 __uwb_rc_neh_rm+0x6b/0x2a0 drivers/staging/uwb/neh.c:243
 uwb_rc_neh_rm+0x30/0x60 drivers/staging/uwb/neh.c:259
 uwb_rc_cmd_async+0x29a/0x310 drivers/staging/uwb/reset.c:93
 __uwb_rc_cmd+0x10f/0x1e0 drivers/staging/uwb/reset.c:171
 uwb_rc_cmd+0xc2/0x130 drivers/staging/uwb/reset.c:220
 uwb_rc_reset+0x15e/0x218 drivers/staging/uwb/reset.c:292
 uwb_rc_setup+0x84/0x320 drivers/staging/uwb/lc-rc.c:282
 uwb_rc_add+0x246/0x42f drivers/staging/uwb/lc-rc.c:351
 hwarc_probe+0x3ce/0xb40 drivers/staging/uwb/hwa-rc.c:843
 usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2487
 usb_set_configuration+0xe47/0x17d0 drivers/usb/core/message.c:2023
 usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:241
 usb_probe_device+0xd9/0x230 drivers/usb/core/driver.c:272
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2487
 usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2544
 hub_port_connect drivers/usb/core/hub.c:5191 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5331 [inline]
 port_event drivers/usb/core/hub.c:5477 [inline]
 hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5559
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2264
 worker_thread+0x96/0xe20 kernel/workqueue.c:2410
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 861748268a9035e2 ]---
RIP: 0010:__list_del_entry_valid.cold+0x23/0x55 lib/list_debug.c:45
Code: e8 e0 b4 3e ff 0f 0b 48 89 ee 48 c7 c7 40 28 fc 85 e8 cf b4 3e ff 0f 0b 4c 89 ea 48 89 ee 48 c7 c7 80 27 fc 85 e8 bb b4 3e ff <0f> 0b 4c 89 e2 48 89 ee 48 c7 c7 e0 27 fc 85 e8 a7 b4 3e ff 0f 0b
RSP: 0018:ffff8881da266cd8 EFLAGS: 00010086
RAX: 000000000000004e RBX: ffff8881d5809000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812977dd RDI: ffffed103b44cd8d
RBP: ffff8881d5809070 R08: 000000000000004e R09: ffffed103b66439f
R10: ffffed103b66439e R11: ffff8881db321cf3 R12: dead000000000122
R13: dead000000000100 R14: ffff8881cde645d8 R15: 00000000ffffffb9
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa54a51f518 CR3: 0000000007021000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
