Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80604C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6934520706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgHYGDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:03:25 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39588 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbgHYGDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:03:21 -0400
Received: by mail-io1-f72.google.com with SMTP id v10so7932655iot.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 23:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=17xNZ3vnGxrE2hDz45jTCe7zoYPZXJ1dqr7yf+KWimw=;
        b=JJXkxOVvQtoqK0xyqzWK6yGAfhHjrMD4N8W8hCLBvYC2TfEp6pPnXCPCet1U4HjGhM
         n0RABbvM6G2dzWl0S/jTd/zm1+XG6UHTCWUYRLgaOc2DSWeLass9syRI3ZKKV2r20HMx
         Lwi21uJfbPqH4+O5dUfgS7IK5aqDCsmzbF8zCeQENhciVu3lhaP+nM+EqlJKH9SMHCve
         RrpV2RpDmMmUiL/TNw/tCVP2JNPxzgKLt8YwvTcsnPjjJd05KAUG5o56L57VJkB1t+hp
         xvy9a8qnAAZiKXtd+isUJ/iKD5vzez5Hki8gd4j80kIwofciDa/b9RT1AUBzJaYLv8py
         miJg==
X-Gm-Message-State: AOAM532pC3ou5qmPqjH6ObH0WWy6gNfUPJQhgn9ZKfKFQx7jQbCAWoWZ
        C1EeUPASBXfSG+D7nH03JbiOVDfjF4KfkqVtA15EdJgpDAol
X-Google-Smtp-Source: ABdhPJxZYqtuRP/BYxt/Fz6d80GNgy8Vw7ytoc/4EptZSHYEDB2g7sQpdAHgh4PMv2XnkLKhxpvlxmGCoqG47Esid1JtefV/KLUp
MIME-Version: 1.0
X-Received: by 2002:a6b:15c1:: with SMTP id 184mr7620531iov.130.1598335400096;
 Mon, 24 Aug 2020 23:03:20 -0700 (PDT)
Date:   Mon, 24 Aug 2020 23:03:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c139e505adad7558@google.com>
Subject: KASAN: slab-out-of-bounds Read in read_descriptors (2)
From:   syzbot <syzbot+256e56ddde8b8957eabd@syzkaller.appspotmail.com>
To:     chenqiwu@xiaomi.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    da2968ff Merge tag 'pci-v5.9-fixes-1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153afba6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=256e56ddde8b8957eabd
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+256e56ddde8b8957eabd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in read_descriptors+0x25f/0x280 drivers/usb/core/sysfs.c:903
Read of size 8 at addr ffff88809100b848 by task systemd-udevd/22769

CPU: 1 PID: 22769 Comm: systemd-udevd Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 read_descriptors+0x25f/0x280 drivers/usb/core/sysfs.c:903
 sysfs_kf_bin_read+0x196/0x270 fs/sysfs/file.c:99
 kernfs_file_direct_read fs/kernfs/file.c:213 [inline]
 kernfs_fop_read+0x2eb/0x590 fs/kernfs/file.c:253
 vfs_read+0x1df/0x5a0 fs/read_write.c:479
 ksys_read+0x12d/0x250 fs/read_write.c:607
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f6f8ba80210
Code: 73 01 c3 48 8b 0d 98 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d b9 c1 20 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e fc ff ff 48 89 04 24
RSP: 002b:00007ffecd2e3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005600a56b04a0 RCX: 00007f6f8ba80210
RDX: 0000000000010011 RSI: 00007ffecd2e3190 RDI: 0000000000000007
RBP: 0000000000000000 R08: 00005600a56b5d00 R09: 0000000000000001
R10: 0000000000000073 R11: 0000000000000246 R12: 00005600a56a6690
R13: 0000000000000007 R14: 00007ffecd2e3190 R15: 0000000000000000

Allocated by task 29772:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3655 [inline]
 __kmalloc+0x1a8/0x320 mm/slab.c:3664
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 usb_get_configuration+0x186/0x3840 drivers/usb/core/config.c:887
 usb_enumerate_device drivers/usb/core/hub.c:2387 [inline]
 usb_new_device+0x387/0x6d0 drivers/usb/core/hub.c:2523
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2033/0x3e40 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff88809100b840
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
 32-byte region [ffff88809100b840, ffff88809100b860)
The buggy address belongs to the page:
page:00000000227ef938 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88809100bfc1 pfn:0x9100b
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00015c1948 ffffea00007fcd88 ffff8880aa040100
raw: ffff88809100bfc1 ffff88809100b000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809100b700: 05 fc fc fc fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88809100b780: 05 fc fc fc fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88809100b800: 06 fc fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
                                              ^
 ffff88809100b880: 00 00 00 fc fc fc fc fc 00 04 fc fc fc fc fc fc
 ffff88809100b900: 00 05 fc fc fc fc fc fc 05 fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
