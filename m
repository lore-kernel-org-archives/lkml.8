Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9712C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF089246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgB1HuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:50:13 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:46458 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgB1HuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:50:13 -0500
Received: by mail-il1-f199.google.com with SMTP id a2so2508355ill.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sqb+kBFaVcnqS1+ka6U9zi/aGo+LcCATSInRv7QLX3U=;
        b=QdBDpVvgO/aXBwNf8XYIUV52gchfocxoR/pdrTtXtYjjAmzwfYU+FO9tR0t1zxCy+j
         fqOzZN+duHByPFGwrXSfskWFiTDUsZjqEYUdIU+gUfN7j4LTjF4LIkacG9uPi4HI1flM
         yHNubGL4l6VJkUQ7Wkc2OAOje/WnfetwXnDAZHtZ8Gxw3kf1vnWI2NR72CHmlk2cPuLs
         ldHNJCW/Xhws0AXao1y3cD46JqVomYwVi2OVNEB5q1EGmh2iXIf9eJNwePH9c6D1OqCK
         k2Yqgixg5q/EmMPWyFPSLVWCqEmO993ai9ZAaCmxZ2vbZ2b86pv4GQifLqbiMjMk76Is
         ByUw==
X-Gm-Message-State: APjAAAXWyCEh/sxOCAY665Bo01RCfp8/c8JINGg4Ov7xcF3bJMX7vn3w
        YvMRag95VEUfpDqVfclkIA90NnQ0bGI+3b2fL5npEZ/1yD8k
X-Google-Smtp-Source: APXvYqzrmwHB2zLOQ3UfvfkqMLC/S5rS+sxJT2w8dSjSq+3B7VVeICxfBNLC3Q5LFPdhLSZG9ka676TMHtbV2nMJ27jGozwLC53S
MIME-Version: 1.0
X-Received: by 2002:a92:3f0f:: with SMTP id m15mr3235802ila.164.1582876211859;
 Thu, 27 Feb 2020 23:50:11 -0800 (PST)
Date:   Thu, 27 Feb 2020 23:50:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055e1a9059f9e169f@google.com>
Subject: KASAN: use-after-free Write in refcount_warn_saturate
From:   syzbot <syzbot+7dd7f2f77a7a01d1dc14@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13005fd9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=7dd7f2f77a7a01d1dc14
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e3ebede00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a9f8f9e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7dd7f2f77a7a01d1dc14@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_set include/asm-generic/atomic-instrumented.h:44 [inline]
BUG: KASAN: use-after-free in refcount_set include/linux/refcount.h:123 [inline]
BUG: KASAN: use-after-free in refcount_warn_saturate+0x1f/0x1f0 lib/refcount.c:15
Write of size 4 at addr ffff888090eb4018 by task kworker/1:24/2888

CPU: 1 PID: 2888 Comm: kworker/1:24 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events do_enable_set
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
 __kasan_check_write+0x14/0x20 mm/kasan/common.c:101
 atomic_set include/asm-generic/atomic-instrumented.h:44 [inline]
 refcount_set include/linux/refcount.h:123 [inline]
 refcount_warn_saturate+0x1f/0x1f0 lib/refcount.c:15
 refcount_sub_and_test include/linux/refcount.h:261 [inline]
 refcount_dec_and_test include/linux/refcount.h:281 [inline]
 kref_put include/linux/kref.h:64 [inline]
 l2cap_chan_put+0x1d9/0x240 net/bluetooth/l2cap_core.c:498
 do_enable_set+0x54b/0x960 net/bluetooth/6lowpan.c:1075
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 2888:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 l2cap_chan_create+0x45/0x3a0 net/bluetooth/l2cap_core.c:446
 chan_create+0x10/0xe0 net/bluetooth/6lowpan.c:640
 bt_6lowpan_listen net/bluetooth/6lowpan.c:959 [inline]
 do_enable_set+0x583/0x960 net/bluetooth/6lowpan.c:1078
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 2975:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 l2cap_chan_destroy net/bluetooth/l2cap_core.c:484 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_chan_put+0x1b7/0x240 net/bluetooth/l2cap_core.c:498
 do_enable_set+0x54b/0x960 net/bluetooth/6lowpan.c:1075
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff888090eb4000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 24 bytes inside of
 2048-byte region [ffff888090eb4000, ffff888090eb4800)
The buggy address belongs to the page:
page:ffffea000243ad00 refcount:1 mapcount:0 mapping:ffff8880aa400e00 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002694048 ffffea000241e648 ffff8880aa400e00
raw: 0000000000000000 ffff888090eb4000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888090eb3f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888090eb3f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888090eb4000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888090eb4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888090eb4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
