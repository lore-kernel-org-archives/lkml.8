Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC12C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1E520828
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCALUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 06:20:13 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43282 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCALUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:20:13 -0500
Received: by mail-il1-f198.google.com with SMTP id o13so8242021ilf.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 03:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=65OnynFSjOmtQMIac/FTTTX4yDBFQ88yOpqC92JdH08=;
        b=DmeHTlo+90WnKq2aCKJ2lIk/UggGxnRcTXrCT579Txt2vwK+QV7heVV2wOrey1P6HM
         eIVwgSj+TNzkgU6iKN3W6QxpBFmsBhecRJ5IrzOwhrJeRc1MLeKcwksxSlKFV+aS3tH9
         FoZjwLSsJTHKe+Vb3/oLZ3a8i21RRXvk8Mdi2O9T9mffmYv108Dp4WVlQuhJsZMGYPAD
         NxGPIulzwOZM2Xedz2CpCcXOqUF9sBAcgZci0Cu/9LUq3k014nBMZbLgOpL5h5AaN7nt
         BPoKXIcCQ7j65OMNYT1D0rjk8bWFAAfLvgXjN9noDdYN6psfgvklhaa9+sxsaJgkwPJG
         YBJw==
X-Gm-Message-State: APjAAAVrEMGVzTwp0SR1gWuL0k1hsnlUl1ILUbjyjCUqYX2b/QHn0ABC
        xyoTi1UOhvNHEjmLAumF+PFbxwa9plsLohjzZ2X7wW6BAzVX
X-Google-Smtp-Source: APXvYqx5KNVvRS8b8Ll7jiWLv2ac4h2LHyaVkAkz2O2IQ4oAfBF0eM08g0Yu/3aKiKIQYUssku0mayJ0HC0zgsDesymTX0PKxFaX
MIME-Version: 1.0
X-Received: by 2002:a6b:ea0e:: with SMTP id m14mr9307164ioc.135.1583061612643;
 Sun, 01 Mar 2020 03:20:12 -0800 (PST)
Date:   Sun, 01 Mar 2020 03:20:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000144d79059fc9415d@google.com>
Subject: WARNING in srp_remove_one
From:   syzbot <syzbot+687bc62a84a6a2a3555a@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c1ad29e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=687bc62a84a6a2a3555a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+687bc62a84a6a2a3555a@syzkaller.appspotmail.com

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'srp-syz0-1'
WARNING: CPU: 1 PID: 9946 at fs/sysfs/group.c:278 sysfs_remove_group fs/sysfs/group.c:278 [inline]
WARNING: CPU: 1 PID: 9946 at fs/sysfs/group.c:278 sysfs_remove_group+0x15b/0x1b0 fs/sysfs/group.c:269
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9946 Comm: kworker/u4:6 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound ib_unregister_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x3e kernel/panic.c:582
 report_bug+0x289/0x300 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:sysfs_remove_group fs/sysfs/group.c:278 [inline]
RIP: 0010:sysfs_remove_group+0x15b/0x1b0 fs/sysfs/group.c:269
Code: 48 89 d9 49 8b 55 00 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 41 48 8b 33 48 c7 c7 20 9f 59 88 e8 b4 a9 5b ff <0f> 0b eb 92 e8 bc fd c9 ff e9 d0 fe ff ff 48 89 df e8 af fd c9 ff
RSP: 0018:ffffc90007d9fa98 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff88b136a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815eae46 RDI: fffff52000fb3f45
RBP: ffffc90007d9fac0 R08: ffff88809bbaa340 R09: ffffed1015d26659
R10: ffffed1015d26658 R11: ffff8880ae9332c7 R12: 0000000000000000
R13: ffff88809b4c6010 R14: ffffffff88b13c40 R15: ffffffff8a5fef80
 dpm_sysfs_remove+0x9f/0xb0 drivers/base/power/sysfs.c:741
 device_del+0x197/0xda0 drivers/base/core.c:2641
 device_unregister+0x16/0x40 drivers/base/core.c:2696
 srp_remove_one+0xad/0x250 drivers/infiniband/ulp/srp/ib_srp.c:4232
 remove_client_context+0xc7/0x120 drivers/infiniband/core/device.c:724
 disable_device+0x14c/0x230 drivers/infiniband/core/device.c:1268
 __ib_unregister_device+0x9c/0x190 drivers/infiniband/core/device.c:1435
 ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1545
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
