Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70077C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E8A2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406280AbgDPFOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:14:21 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:34954 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405672AbgDPFOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:14:18 -0400
Received: by mail-il1-f200.google.com with SMTP id r5so7873194ilq.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+tkq2PWqHihCPJd5MYmRAanWWTaoTF3iEkZiM1luTJs=;
        b=NwY8WviYGnP9OSNXROAh+Xo4LCfXPbeh89S0gkcbDFT+2Gu3sZfOBTOHm7fcbsBtV4
         qFwe6buGTJxG3wBRUH5wZK2hlAr2bt+ROk/l6m6qMmGEUBbgT03tY/+HUoYLTycYd0h5
         i7vONcgDDOYWhBweiEFZsabCuuZAPGsZoBIvxEk3ndF+aoKPDPIAZLRsuNJRrTHxml05
         TW3Fh7nTjQfWP+JgFB264alHKxRcPjWDXt7zdrxyJYSgpHIhO+vtHQO3LZA0BE9AXv1I
         fOs1S7Gi6b/GeteTKntGey4jt+6DjxE65K8zglrCqvFTqaaIAL4GMn06b4Gsi28j3cvi
         Dqgg==
X-Gm-Message-State: AGi0PuaB7bIu/aDuFZjlVEWLtCxYaOukTJsYiWa5cWHZrACRYyjWZoW4
        zLY0KykF9GWkS+RxlSZUlLzGLxl+/d4yPY0JIRTRSUJtXI6D
X-Google-Smtp-Source: APiQypIIkgaSS5KxsJxxZtoeThLQCgvaHrVQa1u2/INEiSzn8u/kI7a/migeVb+kDw86QSsjZU4CrWeMwBbZkDhIO5+OvGDk4gT7
MIME-Version: 1.0
X-Received: by 2002:a92:5aca:: with SMTP id b71mr9047035ilg.56.1587014055309;
 Wed, 15 Apr 2020 22:14:15 -0700 (PDT)
Date:   Wed, 15 Apr 2020 22:14:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005382805a36181b9@google.com>
Subject: WARNING in add_one_compat_dev
From:   syzbot <syzbot+283a75171cb87a7acb0e@syzkaller.appspotmail.com>
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

HEAD commit:    9d859289 docs: networking: add full DIM API
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11230b2be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94a7f1dec460ee83
dashboard link: https://syzkaller.appspot.com/bug?extid=283a75171cb87a7acb0e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+283a75171cb87a7acb0e@syzkaller.appspotmail.com

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'syz1'
WARNING: CPU: 1 PID: 23343 at fs/sysfs/group.c:279 sysfs_remove_group fs/sysfs/group.c:279 [inline]
WARNING: CPU: 1 PID: 23343 at fs/sysfs/group.c:279 sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:270
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 23343 Comm: syz-executor.4 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:sysfs_remove_group fs/sysfs/group.c:279 [inline]
RIP: 0010:sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:270
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 41 48 8b 33 48 c7 c7 a0 e5 39 88 e8 13 b2 5e ff <0f> 0b eb 95 e8 f2 26 cb ff e9 d2 fe ff ff 48 89 df e8 e5 26 cb ff
RSP: 0018:ffffc90004a57a80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff889256e0 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815ce2b1 RDI: fffff5200094af42
RBP: 0000000000000000 R08: ffff88808e0100c0 R09: ffffed1015ce66a9
R10: ffff8880ae733547 R11: ffffed1015ce66a8 R12: ffff88803efdb000
R13: ffffffff88925c80 R14: ffff888088b68e88 R15: ffff88803efdb518
 dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:794
 device_del+0x18b/0xd30 drivers/base/core.c:2687
 add_one_compat_dev drivers/infiniband/core/device.c:921 [inline]
 add_one_compat_dev+0x59f/0x800 drivers/infiniband/core/device.c:857
 rdma_dev_init_net+0x2dc/0x480 drivers/infiniband/core/device.c:1122
 ops_init+0xaf/0x420 net/core/net_namespace.c:151
 setup_net+0x2de/0x860 net/core/net_namespace.c:341
 copy_net_ns+0x293/0x590 net/core/net_namespace.c:482
 create_new_namespaces+0x3fb/0xb30 kernel/nsproxy.c:108
 unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:229
 ksys_unshare+0x43d/0x8e0 kernel/fork.c:2960
 __do_sys_unshare kernel/fork.c:3028 [inline]
 __se_sys_unshare kernel/fork.c:3026 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3026
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f65f7741c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f65f77426d4 RCX: 000000000045c889
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000c40 R14: 00000000004ce690 R15: 000000000076bf0c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
