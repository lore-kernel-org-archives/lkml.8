Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD03C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F73E2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgDUKqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:46:19 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55770 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgDUKqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:46:12 -0400
Received: by mail-io1-f72.google.com with SMTP id f4so15956121iov.22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 03:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sa7Y5R2sGhGJ3qXxP5E7lP4PFHiYpnlo3ykudnVt4nE=;
        b=cEbMAipSzw/W9EP9nT4WYq6Q2TgRs7ZbWEWu9iWs16MT6wFGgqpXGs8lfMhi9X6AlR
         3EDvzo6xoVeA2YnkQ0BvFhUVuVBJ0jEFOzmkp6GAoIFXruojkBd+PethYpNRuxg/FgKS
         8xNu/9n75c6HEvXuxFkDpG1BbHVhkl14FjzUzrsfuls1dzfKf/3wWjOoHc6W5sTEedQ1
         kQUh2F/iBChQwFBqgBsYNJfe7DmVz/++fKiZZjOKVw9eYbU2kCW88Lt1ZYbmV+3uzqVC
         dTjGcou1T5YVk9Vm3TfYvWQuW/BI6hRiZzlPVEFp00oFc1oEgab1V7FD1a0DUi6uhrre
         mZOQ==
X-Gm-Message-State: AGi0PuZ0bVs0XXD8UTsaQsu8kHOlP6sNCUsmr6KnYFJGEhMHzw4cjyt7
        Sys+0l2p+VzZXLSTS05PnxrmOQcGBNMwjqA6913skEZGyCqh
X-Google-Smtp-Source: APiQypIs+V/4TWNR8NDKHxupXyvu26FjAAQ85NasPOBXB3O1bUokJQI2sNv5SdTbW9dkO5i0E40tXq3H+wj8HMRwMPRGbfvvHHfq
MIME-Version: 1.0
X-Received: by 2002:a02:3341:: with SMTP id k1mr20413258jak.74.1587465971226;
 Tue, 21 Apr 2020 03:46:11 -0700 (PDT)
Date:   Tue, 21 Apr 2020 03:46:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ede4505a3cab90e@google.com>
Subject: linux-next test error: WARNING: suspicious RCU usage in ipmr_device_event
From:   syzbot <syzbot+21f82f61c24a7295edf5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    39a314cd Add linux-next specific files for 20200421
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=127ede73e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ef80c3f5d43f5bd
dashboard link: https://syzkaller.appspot.com/bug?extid=21f82f61c24a7295edf5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+21f82f61c24a7295edf5@syzkaller.appspotmail.com

tipc: TX() has been purged, node left!
=============================
WARNING: suspicious RCU usage
5.7.0-rc2-next-20200421-syzkaller #0 Not tainted
-----------------------------
net/ipv4/ipmr.c:1757 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
4 locks held by kworker/u4:0/7:
 #0: ffff8880a9772138 ((wq_completion)netns){+.+.}-{0:0}, at: __write_once_size include/linux/compiler.h:250 [inline]
 #0: ffff8880a9772138 ((wq_completion)netns){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880a9772138 ((wq_completion)netns){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8880a9772138 ((wq_completion)netns){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8880a9772138 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8880a9772138 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8880a9772138 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x844/0x16a0 kernel/workqueue.c:2239
 #1: ffffc90000cdfdc0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x878/0x16a0 kernel/workqueue.c:2243
 #2: ffffffff8a5a2b70 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x9b/0xa50 net/core/net_namespace.c:565
 #3: ffffffff8a5aeae8 (rtnl_mutex){+.+.}-{3:3}, at: ip6gre_exit_batch_net+0x88/0x700 net/ipv6/ip6_gre.c:1602

stack backtrace:
CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.7.0-rc2-next-20200421-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 ipmr_device_event+0x240/0x2b0 net/ipv4/ipmr.c:1757
 notifier_call_chain+0xc0/0x230 kernel/notifier.c:83
 call_netdevice_notifiers_info net/core/dev.c:1948 [inline]
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1933
 call_netdevice_notifiers_extack net/core/dev.c:1960 [inline]
 call_netdevice_notifiers net/core/dev.c:1974 [inline]
 rollback_registered_many+0x75c/0xe70 net/core/dev.c:8828
 unregister_netdevice_many.part.0+0x16/0x1e0 net/core/dev.c:9993
 unregister_netdevice_many+0x36/0x50 net/core/dev.c:9992
 ip6gre_exit_batch_net+0x4e8/0x700 net/ipv6/ip6_gre.c:1605
 ops_exit_list.isra.0+0x103/0x150 net/core/net_namespace.c:189
 cleanup_net+0x511/0xa50 net/core/net_namespace.c:603
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2268
 worker_thread+0x96/0xe20 kernel/workqueue.c:2414
 kthread+0x38b/0x470 kernel/kthread.c:274
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
