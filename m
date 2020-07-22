Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE31C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8B7206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgGVEGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:06:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49914 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgGVEGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:06:10 -0400
Received: by mail-io1-f69.google.com with SMTP id l7so972899ioq.16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Owb9IwFQyEhlVcf9dWP5KUWd0T8KeX4hhSQrT09WLVM=;
        b=CP81L087Bc4iKfWzTxZyMbI+tGM9Xd0Ypk7EYlCn0nlj2CAaLnuru79te8u2g0vPh+
         EJW4rOV0Km4sM7IXokH/w5locy7ocMbvVtIddc2QoybGjWeN/Wi5nvcudF/URX+hmhCP
         LGxf0jk6wx4HyUKiI5rsjehIvj4LZtvA1tYXPZh//3YKHWJW6Xau8Pwp0kBjpy26tdxh
         bAqmyV1hwknMbjGTqgLW4iczZUoz8bduBKeoaChUIt+J4cr+mdoocViXj5Ldazqahd/W
         IndvcLioU4Ex8lARBbjWs5ol/RSaYxOGmAdCpE0sej8GBzzrregKimTvYLvbMO9uUbTs
         caCA==
X-Gm-Message-State: AOAM5309fdsMwU6TLrDmcySVn0M10J7PwbYpe59tBcfriGDywG4CH/K2
        1E3DnHwLuq6EV44T88zZu07fa5jc20fe+evYaxe7hkRyUq34
X-Google-Smtp-Source: ABdhPJxKpX5QgCSXASidAUn4JI3ECIT+TNoa9CsBVnxXzDo3xE1LrhnckTuw5OGA3oXZjUbSGH9HOco+uX28Ij1pPBz+qD8v0bh9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a:: with SMTP id z26mr9254802jao.15.1595390770006;
 Tue, 21 Jul 2020 21:06:10 -0700 (PDT)
Date:   Tue, 21 Jul 2020 21:06:10 -0700
In-Reply-To: <20200722031640.nobv2bfgex46sngo@pesu.pes.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fd19405aaffdc0a@google.com>
Subject: Re: WARNING in pvr2_i2c_core_done
From:   syzbot <syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, andreyknvl@google.com,
        bkkarthik@pesu.pes.edu, dan.carpenter@oracle.com,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in kernfs_find_ns

pvrusb2: Invalid write control endpoint
pvrusb2: Invalid write control endpoint
pvrusb2: Invalid write control endpoint
pvrusb2: Invalid write control endpoint
general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 0 PID: 78 Comm: pvrusb2-context Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kernfs_find_ns+0x31/0x370 fs/kernfs/dir.c:829
Code: 49 89 d6 41 55 41 54 55 48 89 fd 53 48 83 ec 08 e8 f4 61 af ff 48 8d 7d 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 03 00 00 48 8d bd 98 00 00 00 48 8b 5d 70 48
RSP: 0018:ffff8881d419f938 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff863789c0 RCX: ffffffff85a79ba7
RDX: 000000000000000e RSI: ffffffff81901d1c RDI: 0000000000000070
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff873ed1e7
R10: fffffbfff0e7da3c R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff863790e0
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3a7e248000 CR3: 00000001d2224000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kernfs_find_and_get_ns+0x2f/0x60 fs/kernfs/dir.c:906
 kernfs_find_and_get include/linux/kernfs.h:548 [inline]
 sysfs_unmerge_group+0x5d/0x160 fs/sysfs/group.c:366
 dpm_sysfs_remove+0x62/0xb0 drivers/base/power/sysfs.c:790
 device_del+0x18b/0xd20 drivers/base/core.c:2834
 device_unregister+0x22/0xc0 drivers/base/core.c:2889
 i2c_unregister_device include/linux/err.h:41 [inline]
 i2c_client_dev_release+0x39/0x50 drivers/i2c/i2c-core-base.c:465
 device_release+0x71/0x200 drivers/base/core.c:1559
 kobject_cleanup lib/kobject.c:693 [inline]
 kobject_release lib/kobject.c:722 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x245/0x540 lib/kobject.c:739
 put_device drivers/base/core.c:2779 [inline]
 device_unregister+0x34/0xc0 drivers/base/core.c:2890
 i2c_unregister_device+0x38/0x40 include/linux/err.h:41
 v4l2_i2c_new_subdev_board+0x159/0x2c0 drivers/media/v4l2-core/v4l2-i2c.c:114
 v4l2_i2c_new_subdev+0xb8/0xf0 drivers/media/v4l2-core/v4l2-i2c.c:135
 pvr2_hdw_load_subdev drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2023 [inline]
 pvr2_hdw_load_modules drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2075 [inline]
 pvr2_hdw_setup_low drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2156 [inline]
 pvr2_hdw_setup drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2262 [inline]
 pvr2_hdw_initialize+0xc8d/0x3600 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2339
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:109 [inline]
 pvr2_context_thread_func+0x250/0x850 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351
Modules linked in:
---[ end trace a2576a16aa8e791c ]---
RIP: 0010:kernfs_find_ns+0x31/0x370 fs/kernfs/dir.c:829
Code: 49 89 d6 41 55 41 54 55 48 89 fd 53 48 83 ec 08 e8 f4 61 af ff 48 8d 7d 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 03 00 00 48 8d bd 98 00 00 00 48 8b 5d 70 48
RSP: 0018:ffff8881d419f938 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff863789c0 RCX: ffffffff85a79ba7
RDX: 000000000000000e RSI: ffffffff81901d1c RDI: 0000000000000070
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff873ed1e7
R10: fffffbfff0e7da3c R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff863790e0
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3a7e248000 CR3: 00000001d2224000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         b791d1bd Merge tag 'locking-kcsan-2020-06-11' of git://git..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1208f437100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccf1899337a6e343
dashboard link: https://syzkaller.appspot.com/bug?extid=e74a998ca8f1df9cc332
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d56430900000

