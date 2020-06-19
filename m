Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFAEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D414208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392517AbgFSR0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:26:19 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40691 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgFSR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:26:18 -0400
Received: by mail-io1-f69.google.com with SMTP id f25so396684ioh.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tR2yYPPktGqajADULWKW8tHmDKw+CVU6CAUOLEhmI4k=;
        b=QlD3jlDWeQnyDE+3+Vyp6bQJ3RXoMBK3DVq7zmyRnWVk/sBVPIgzWIgA12e+cLSvCJ
         c1bbwrRm7sr0iaSA7z+zZ7MVtM9BWH14giJntEdxTccA46rh7eDjU93gv8YV5EZmBwMV
         IcCfBAwgQFBATypjq9z+vm/LOxOkrNkNbTpB+3S0hhAOI4w8q7mIfMJHdhBjXLCNcpVP
         GXV8VmaejymGvBb+07yf1PhDXiJ8KXBncGbnrCd71hbL9qTrSVKGLvRfBkIhE4CsfHQT
         MiLRxEcKmnRn5MkrxXmG/mYyKmTJJqpKz0Pb3fF0AOB8uQGK2k86vkhzE4fuara3VN13
         PZMA==
X-Gm-Message-State: AOAM530yQSV9uuOidMcnFuYbJYvkpYh+f7VSu7aw/tqAewp/1A3F+dRR
        dP3DHQE4ONxgd4zjtw2iHUYa7IrAGPHgQ+wK3E8esgTG+yms
X-Google-Smtp-Source: ABdhPJzoVgyUDEnm4wX3f1qRD4ln78TRrbFCLR0KpQIedxkhqZsfT1gy2AKMa2c6rw/noXZmZ2g/bzDczOvieRHleg1/gDV8KJRd
MIME-Version: 1.0
X-Received: by 2002:a6b:7516:: with SMTP id l22mr5525888ioh.18.1592587575754;
 Fri, 19 Jun 2020 10:26:15 -0700 (PDT)
Date:   Fri, 19 Jun 2020 10:26:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba030f05a87330b6@google.com>
Subject: WARNING in ath9k_hif_usb_alloc_urbs/usb_submit_urb
From:   syzbot <syzbot+d625c772c7814faabef9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b3a9e3b9 Linux 5.8-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=134f82b9100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=517257c0c3ef89af
dashboard link: https://syzkaller.appspot.com/bug?extid=d625c772c7814faabef9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1695e621100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1393f8b9100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d625c772c7814faabef9@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 57 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 57 Comm: kworker/1:2 Not tainted 5.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 panic+0x2aa/0x6e1 kernel/panic.c:231
 __warn.cold+0x2f/0x35 kernel/panic.c:600
 report_bug+0x271/0x2f0 lib/bug.c:198
 exc_invalid_op+0x1e4/0x370 arch/x86/kernel/traps.c:235
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Code: 4d 85 ed 74 46 e8 48 96 d0 fd 4c 89 f7 e8 a0 02 16 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 80 b3 3d 86 e8 3a ac a4 fd <0f> 0b e9 20 f4 ff ff e8 1c 96 d0 fd 0f 1f 44 00 00 e8 12 96 d0 fd
RSP: 0018:ffff8881d8ab7b50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81298423 RDI: ffffed103b156f5c
RBP: ffff8881c8c7e450 R08: ffff8881d8aa1900 R09: ffffed103b665ea2
R10: ffff8881db32f50f R11: ffffed103b665ea1 R12: 0000000000000003
R13: ffff8881c700adc8 R14: ffff8881d8e250a0 R15: ffff8881d54c7700
 ath9k_hif_usb_alloc_rx_urbs drivers/net/wireless/ath/ath9k/hif_usb.c:880 [inline]
 ath9k_hif_usb_alloc_urbs+0x7be/0x1050 drivers/net/wireless/ath/ath9k/hif_usb.c:991
 ath9k_hif_usb_dev_init drivers/net/wireless/ath/ath9k/hif_usb.c:1081 [inline]
 ath9k_hif_usb_firmware_cb+0x148/0x510 drivers/net/wireless/ath/ath9k/hif_usb.c:1214
 request_firmware_work_func+0x126/0x242 drivers/base/firmware_loader/main.c:1001
 process_one_work+0x965/0x1620 kernel/workqueue.c:2269
 worker_thread+0x96/0xe10 kernel/workqueue.c:2415
 kthread+0x352/0x460 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Kernel Offset: disabled


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
