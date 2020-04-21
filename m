Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D76FC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36971206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDUPfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:35:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:46924 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgDUPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:35:21 -0400
Received: by mail-il1-f198.google.com with SMTP id g17so14846915iln.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6TusJOBvP6hD2r5soFkPAtdu3XdSa2vDgc3SfxPy5ss=;
        b=UvOKdSF28rIDdF5ZDVrUozs7gy1uz/Hi+xR+N9/S76AWMtX4JXUMl/iSxCdzdLBnIP
         AZKr80D+lizYt88hLv4U8jT7QDkfFx/FMynxPq2Z5TDoIyJkiAhx18rS40/LtvFQ3Yur
         x40E7PgyJrPWaHNhi6pETqJKFsV6hoOf3cpNYnrxmo+wtOAe/eTlmxaW/S2E8Z5l2DZr
         xL0x5MNXjTEx2u/SnpiOBL9ZLPfGXoDlQ4L3rZ+q50vt+PXyza/VonphQn2IJUrGvnXs
         8J2qjy5IUHuI26bgNYJ42+ux7HK/ult9ZfafJZtM2ckeq0ANvN9YWK17lUcCyKvT/xio
         jmNQ==
X-Gm-Message-State: AGi0PuZ5ZYWTlu9q7Flh/fEKvGwjWqi9QBcoc8ZN4hZ2du2xRp3bvAlQ
        PDfokXNnRQQEyWLnvQsbwiNY2171rCwxaIvXGpjkuEEhh3n/
X-Google-Smtp-Source: APiQypLBUoxSlbmqIf/wQqiEpVc0wJWHWVe7AJASYdY7aGRe3L5wzMLLoRxT1CNOhqkR7SbhlczNTITyKyK14vmRQdEatDyRIG3/
MIME-Version: 1.0
X-Received: by 2002:a02:8666:: with SMTP id e93mr21469444jai.0.1587483318621;
 Tue, 21 Apr 2020 08:35:18 -0700 (PDT)
Date:   Tue, 21 Apr 2020 08:35:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b22f405a3cec353@google.com>
Subject: general protection fault in release_nodes
From:   syzbot <syzbot+14b86b62abea65294f35@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=16d56d5fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=14b86b62abea65294f35
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+14b86b62abea65294f35@syzkaller.appspotmail.com

usb 5-1: ath9k_htc: USB layer deinitialized
general protection fault, probably for non-canonical address 0xdffffc00a0000000: 0000 [#1] SMP KASAN
KASAN: probably user-memory-access in range [0x0000000500000000-0x0000000500000007]
CPU: 0 PID: 3105 Comm: kworker/0:4 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:remove_nodes drivers/base/devres.c:437 [inline]
RIP: 0010:release_nodes+0x1e2/0x910 drivers/base/devres.c:498
Code: 1f e8 e2 26 c4 fe 83 44 24 14 01 e8 d8 26 c4 fe 4c 39 6c 24 08 0f 84 a8 00 00 00 4c 89 eb e8 c5 26 c4 fe 48 89 d8 48 c1 e8 03 <80> 3c 28 00 0f 85 29 05 00 00 48 8d 7b 10 4c 8b 2b 48 89 f8 48 c1
RSP: 0018:ffff8881d99af920 EFLAGS: 00010006
RAX: 00000000a0000000 RBX: 0000000500000000 RCX: ffffc9000eb33000
RDX: 000000000000efcd RSI: ffffffff827b315b RDI: ffff8881c7125010
RBP: dffffc0000000000 R08: 0000000000000004 R09: ffffed103b335f2d
R10: ffffed103b335f2c R11: 0000000000000003 R12: 0000000500000000
R13: ffffffff87430cc0 R14: ffff8881d8e0dca8 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb1e2e2d710 CR3: 00000001d2102000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 devres_release_all+0x74/0xc3 drivers/base/devres.c:529
 device_release+0x39/0x200 drivers/base/core.c:1364
 kobject_cleanup lib/kobject.c:693 [inline]
 kobject_release lib/kobject.c:722 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x256/0x550 lib/kobject.c:739
 put_device drivers/base/core.c:2599 [inline]
 device_unregister+0x34/0xc0 drivers/base/core.c:2710
 usb_remove_ep_devs+0x3e/0x80 drivers/usb/core/endpoint.c:215
 usb_disconnect+0x4bb/0x900 drivers/usb/core/hub.c:2230
 hub_port_connect drivers/usb/core/hub.c:5046 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5335 [inline]
 port_event drivers/usb/core/hub.c:5481 [inline]
 hub_event+0x1a1d/0x4300 drivers/usb/core/hub.c:5563
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace c49c493fba95a78f ]---
RIP: 0010:remove_nodes drivers/base/devres.c:437 [inline]
RIP: 0010:release_nodes+0x1e2/0x910 drivers/base/devres.c:498
Code: 1f e8 e2 26 c4 fe 83 44 24 14 01 e8 d8 26 c4 fe 4c 39 6c 24 08 0f 84 a8 00 00 00 4c 89 eb e8 c5 26 c4 fe 48 89 d8 48 c1 e8 03 <80> 3c 28 00 0f 85 29 05 00 00 48 8d 7b 10 4c 8b 2b 48 89 f8 48 c1
RSP: 0018:ffff8881d99af920 EFLAGS: 00010006
RAX: 00000000a0000000 RBX: 0000000500000000 RCX: ffffc9000eb33000
RDX: 000000000000efcd RSI: ffffffff827b315b RDI: ffff8881c7125010
RBP: dffffc0000000000 R08: 0000000000000004 R09: ffffed103b335f2d
R10: ffffed103b335f2c R11: 0000000000000003 R12: 0000000500000000
R13: ffffffff87430cc0 R14: ffff8881d8e0dca8 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb1e2e2d710 CR3: 00000001d2102000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
