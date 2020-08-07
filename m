Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8954E22CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgHGHQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:16:24 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:50861 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:16:23 -0400
Received: by mail-il1-f199.google.com with SMTP id t20so820630ill.17
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vP7y425X/e3dttg0Y04CfXmUMZIfljf60qLrufoziwE=;
        b=FJsFCbA4WSQi+LJSNs1QtO8fTk+O/+8kjmpWYMERpQVZONhDpLEecdCZUCwph/lIhy
         SdunUBdT9DVXK+Dp07RNLKU9W62H0hd4K+EEztdtrMVLACJSFIpgJNRD44d+j2TdAhmI
         f2l85SS0mks5K1Hv4fAQybocxaX1oivBw+cG3m2xawKyAalulRDDXcsstaYUIH8ALRyQ
         bTMplyI5rhw9lWBtvbM7xYkDGTP4NARn6Om6SdKMm8xIsIx+KLRnnpiYaAHnFrWo3LSA
         0HZ7lXMytWponp5TyYIaUaJYKZkR/MAmExxk0BmJdKV4xTSodpxm45TFCwx7mo0ZMyOf
         1pCw==
X-Gm-Message-State: AOAM533dDvWrBDZpiTFlukGZNKBXyfuEKmayOdiSbVyD9SNCMbGYETTC
        nywOfh5BW4/WCCF4MZXWTHYCUgdUl08twKdAi7ct3yXeDaUu
X-Google-Smtp-Source: ABdhPJzWojrw47YKDG2LTE2cx7+xXLQH4qoGmka0n2U1BaZwNSvi0j8HXjSOyEbfHWW9KRHojJ1/i+sKxdJVpvk2cHoE+NIkpZY8
MIME-Version: 1.0
X-Received: by 2002:a5e:d80e:: with SMTP id l14mr3144294iok.65.1596784582188;
 Fri, 07 Aug 2020 00:16:22 -0700 (PDT)
Date:   Fri, 07 Aug 2020 00:16:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cde53e05ac446157@google.com>
Subject: WARNING: ODEBUG bug in put_device
From:   syzbot <syzbot+a9290936c6e87b3dc3c2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    47ec5303 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d8d3c6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bb894f55faf8242
dashboard link: https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b69a52900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9290936c6e87b3dc3c2@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint: hci_conn_timeout+0x0/0x2a0 net/bluetooth/hci_conn.c:1499
WARNING: CPU: 1 PID: 8156 at lib/debugobjects.c:485 debug_print_object+0x160/0x250 lib/debugobjects.c:485
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8156 Comm: kworker/u5:3 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci5 hci_rx_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:485
Code: dd e0 cf 93 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 14 dd e0 cf 93 88 48 c7 c7 40 c5 93 88 e8 42 e4 a8 fd <0f> 0b 83 05 23 3c 15 07 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
RSP: 0018:ffffc9000a26f858 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff88809eac6380 RSI: ffffffff815d8eb7 RDI: fffff5200144defd
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff8880ae720fcb
R10: 0000000000000000 R11: 0000000035313854 R12: ffffffff89ba3300
R13: ffffffff814b53c0 R14: dead000000000100 R15: dffffc0000000000
 __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
 debug_check_no_obj_freed+0x301/0x41c lib/debugobjects.c:998
 kfree+0xf0/0x2c0 mm/slab.c:3756
 device_release+0x71/0x200 drivers/base/core.c:1800
 kobject_cleanup lib/kobject.c:704 [inline]
 kobject_release lib/kobject.c:735 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x171/0x270 lib/kobject.c:752
 put_device+0x1b/0x30 drivers/base/core.c:3029
 hci_conn_del+0x27e/0x6a0 net/bluetooth/hci_conn.c:645
 hci_sco_setup+0x3a1/0x440 net/bluetooth/hci_conn.c:400
 hci_conn_complete_evt net/bluetooth/hci_event.c:2657 [inline]
 hci_event_packet+0x5e0b/0x87a8 net/bluetooth/hci_event.c:6058
 hci_rx_work+0x22e/0xb50 net/bluetooth/hci_core.c:4889
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
