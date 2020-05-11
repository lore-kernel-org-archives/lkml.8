Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A409EC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 05:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D7E2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 05:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEKF6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 01:58:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38433 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgEKF6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 01:58:14 -0400
Received: by mail-io1-f72.google.com with SMTP id j17so8392919iow.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 22:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7HmtHDrDQRyCrTM7049liGEJqpLTeS0kM+LgJa7QGJ0=;
        b=QOIqU5kTljEhiZbN2JwjAu/mZo6Cd68OIMxI9xPmzuFndlWvGO3L2DfMkX/McbcQaF
         8qaLQITQMcDxASjZirxcslynz5+xLTYvOk6OglNSF3sJ3vbINuzvm8B2DMuBSXFaal3D
         G6jsElXMUlyH4Zy/riKNpkYJxXMhpoVQsLMqnekX53iNuJdvrCVLZ9t7VyRks9V8kft0
         UIWvrMeIH9LLYXPAqvh/DVCa5uNGWvuocLz/+FU5CMEauEe01/5BcGPpRIOk2+XC/Ztb
         AaMYrSVYw1NKEBa3JH35nGFyic32766oslVp04572eYqHS+dlubVXpA5OqwfdJSXFD7l
         Gotg==
X-Gm-Message-State: AGi0PuZE48QgApNCLBW9zPjJSKxl23VZYgyhN1/PgBccjnqUW2NBLyjf
        CLScTpykOJqzOWnWgvVOn10t9fZsvdGP/z+boo2GwZHvzS6f
X-Google-Smtp-Source: APiQypJIs7OdVM1+rko2myKyXkEEkqBC/jBGw9mcdwhfq4042Q/9EQBWGSNLtGnJhQtu5/Yrj82IXWtrGUae7VfxRwQuAWuP6pew
MIME-Version: 1.0
X-Received: by 2002:a92:dd09:: with SMTP id n9mr15125602ilm.132.1589176693193;
 Sun, 10 May 2020 22:58:13 -0700 (PDT)
Date:   Sun, 10 May 2020 22:58:13 -0700
In-Reply-To: <00000000000043ed6f059d1944bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048839b05a55908b2@google.com>
Subject: Re: INFO: task hung in do_read_cache_page (3)
From:   syzbot <syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    e99332e7 gcc-10: mark more functions __init to avoid secti..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1344fb14100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a96cf498e199d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=518c54e255b5031adde4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146e45ec100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164444a4100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com

INFO: task syz-executor928:7064 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor928 D26720  7064   7053 0x00004004
Call Trace:
 schedule+0xd0/0x2a0 kernel/sched/core.c:4158
 io_schedule+0x17/0x60 kernel/sched/core.c:5801
 wait_on_page_bit_common mm/filemap.c:1153 [inline]
 wait_on_page_bit mm/filemap.c:1202 [inline]
 wait_on_page_locked include/linux/pagemap.h:528 [inline]
 do_read_cache_page+0x648/0x1810 mm/filemap.c:2814
 read_mapping_page include/linux/pagemap.h:397 [inline]
 read_part_sector+0xf6/0x600 block/partitions/core.c:643
 adfspart_check_ICS+0x9d/0xc80 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:140 [inline]
 blk_add_partitions+0x474/0xe50 block/partitions/core.c:571
 bdev_disk_changed+0x1fb/0x380 fs/block_dev.c:1543
 __blkdev_get+0x130c/0x1530 fs/block_dev.c:1681
 blkdev_get+0x41/0x2b0 fs/block_dev.c:1748
 blkdev_open+0x21d/0x2b0 fs/block_dev.c:1887
 do_dentry_open+0x4ba/0x1290 fs/open.c:797
 do_open fs/namei.c:3229 [inline]
 path_openat+0x1e59/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1148
 do_sys_open+0xc3/0x140 fs/open.c:1164
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x405a71
Code: Bad RIP value.
RSP: 002b:00007f26eda2b830 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000405a71
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f26eda2b8d0
RBP: 00000000006dbc40 R08: 000000000000000f R09: 00007f26eda2c700
R10: 00007f26eda2c9d0 R11: 0000000000000293 R12: 00000000006dbc4c
R13: 00007ffcaf21940f R14: 00007f26eda2c9c0 R15: 20c49ba5e353f7cf

Showing all locks held in the system:
1 lock held by khungtaskd/1139:
 #0: ffffffff899bebc0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5754
2 locks held by in:imklog/6726:
 #0: ffff88809eddc3f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
 #1: ffff8880aa001818 (&parent->list_lock){-.-.}-{2:2}, at: syslog_print kernel/printk/printk.c:1392 [inline]
 #1: ffff8880aa001818 (&parent->list_lock){-.-.}-{2:2}, at: do_syslog kernel/printk/printk.c:1557 [inline]
 #1: ffff8880aa001818 (&parent->list_lock){-.-.}-{2:2}, at: do_syslog+0x632/0x16d0 kernel/printk/printk.c:1531
1 lock held by syz-executor928/7064:
 #0: ffff888088cbb380 (&bdev->bd_mutex){+.+.}-{3:3}, at: __blkdev_get+0x179/0x1530 fs/block_dev.c:1600

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1139 Comm: khungtaskd Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x231/0x27e lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xa8c/0x1010 kernel/hung_task.c:289
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60

