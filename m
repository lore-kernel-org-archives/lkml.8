Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A16C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1F620725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgGKNEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:04:21 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42653 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgGKNEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:04:20 -0400
Received: by mail-il1-f200.google.com with SMTP id d3so5682133ilq.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 06:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eCXMSGgT1Enymkedn2+djY3z54jhZl0rPUIbe5jrd5c=;
        b=NVq+kq76FY2s1Pum2Gg4abtgG30ONpiJNo/sDimVMUQEIeNLM4oNmTtsMEAdGkivgm
         mh4FhF6s9cFbSBnUPBwk484PqRelqXcbV4YIvExRAa23rgMnJrQS13KXZI5mFW6bACSk
         xIUWkEKsTY7RHX+nBkesHWGHA2084+NCzjB8aFHXVL5FBijWC8dZSMVnn8Fr91eBouTH
         7o4eGEI/8yVes0zaD5+SMmV8jBIdsgU4gghIWiB6iH2ELyag5+h3rpQxezMvpumNh2f7
         kayfU0fVK26m0JbvSMyAZ5YzrzTV4QATy3MDV6TvZLoFkWkl0ykmKYhuhB3y39Z/RLPQ
         4jKg==
X-Gm-Message-State: AOAM531h5DimqadNjqL2BPWIKsiipiTRmmwNOOFWs+gcZqWHHlqI3eGv
        +ps0s5kOcoEjQiLFHCGbAAn8jiYhjPe2CIzGYuyR9AHJ0w7S
X-Google-Smtp-Source: ABdhPJz0KY4/CNUXD0tHvOu0J3MW8EXeEONAcXRxW3ooFoDauyGqYNGcd4xi6N4bJsD1rzoMs3AmQ8Fin7amfuMWjMYTH+J6asvC
MIME-Version: 1.0
X-Received: by 2002:a92:d2c6:: with SMTP id w6mr53207955ilg.24.1594472659347;
 Sat, 11 Jul 2020 06:04:19 -0700 (PDT)
Date:   Sat, 11 Jul 2020 06:04:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076ef3605aa2a188b@google.com>
Subject: WARNING in disable_device
From:   syzbot <syzbot+eb4b29a7ddcec62914e9@syzkaller.appspotmail.com>
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

HEAD commit:    e44f65fd xen-netfront: remove redundant assignment to vari..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ff23a3100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=829871134ca5e230
dashboard link: https://syzkaller.appspot.com/bug?extid=eb4b29a7ddcec62914e9
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eb4b29a7ddcec62914e9@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 271 at fs/sysfs/group.c:279 sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:279
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 271 Comm: kworker/u4:5 Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound ib_unregister_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 exc_invalid_op+0x24d/0x400 arch/x86/kernel/traps.c:235
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:279
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 37 48 8b 33 48 c7 c7 c0 5a 5a 88 e8 7c 50 5d ff <0f> 0b eb 98 e8 d1 5d cb ff e9 01 ff ff ff 48 89 df e8 c4 5d cb ff
RSP: 0018:ffffc90001c67b48 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff88b45640 RCX: 0000000000000000
RDX: ffff8880a849c300 RSI: ffffffff815ce8d7 RDI: fffff5200038cf5b
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880ae6318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88808b0a0000
R13: ffffffff88b45be0 R14: ffffc90001c67c70 R15: ffff8880aa034800
 dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:794
 device_del+0x18b/0xd20 drivers/base/core.c:2834
 remove_one_compat_dev drivers/infiniband/core/device.c:952 [inline]
 remove_compat_devs drivers/infiniband/core/device.c:963 [inline]
 disable_device+0x1e1/0x270 drivers/infiniband/core/device.c:1294
 __ib_unregister_device+0x91/0x190 drivers/infiniband/core/device.c:1450
 ib_unregister_work+0x15/0x30 drivers/infiniband/core/device.c:1561
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Kernel Offset: disabled


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
