Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8CFC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BAA20732
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBCXiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:38:14 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:55542 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:38:14 -0500
Received: by mail-io1-f71.google.com with SMTP id z21so10514319iob.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5bLCzaGpzVRbIJHfXRJ9uPpJCj2xoJL+P+aQ/IaVVFY=;
        b=QriiwUCv98uEgzAkrCbvXNXbfS2KSRG2oVqi9IyXFE92OILS1/nUw5JhLUw/UA1Ru+
         lyLrYGzv9lEfE1vaMV+ih7LRdNKkBWl3DWpy2wR4iLhnzONFxligACq4waV38si2RVS0
         xlvCu/Ojdh3jyW9e8dh90Gls1h0cIFEjQNCg1kzvXn6nhta8qHhXsMAHmir2Qu5hkAP7
         +w7Hqe86yac8/n63+Khk0/Qe8oWqyifEbU4Q6puz51rBb6c9Xh/fNZmPYVFA+hu5Itk7
         yQFd+du+HzW/sH6ddGEeZ2gYqgWxZ1Q1CUkDuC1X4w7ahly3w6rNzDqxBUBYfMRLuXZn
         AzzQ==
X-Gm-Message-State: APjAAAWGbfvvfK32nFI4Ai67WlWjQOGD4D5gHW5r6n5h1+/3CRTGlzHX
        n61G8I7tItrun6qm/ZpZcKU23bFwjB84MAVPJZ5iOW0GAwdR
X-Google-Smtp-Source: APXvYqyKnKTG4g/Mbca4V/PeZQI4pOgBcuSnYNmLX4Iol6+G16I643WmAuhKz2gXF8JBOHfBveGBBMIMebbE3hoB+7N1cc/wGVuB
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3:: with SMTP id z3mr21850227jao.65.1580773093375;
 Mon, 03 Feb 2020 15:38:13 -0800 (PST)
Date:   Mon, 03 Feb 2020 15:38:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b38376059db46aea@google.com>
Subject: possible deadlock in peer_remove_after_dead
From:   syzbot <syzbot+b5ae9f38893979e71173@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    754beeec Merge tag 'char-misc-5.6-rc1-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f684e9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99db4e42d047be3
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ae9f38893979e71173
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b5ae9f38893979e71173@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.5.0-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u4:1/21 is trying to acquire lock:
ffffc90000dd7dc0 ((work_completion)(&peer->transmit_handshake_work)){+.+.}, at: process_one_work+0x917/0x17a0 kernel/workqueue.c:2239

but task is already holding lock:
ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: process_one_work+0x8dd/0x17a0 kernel/workqueue.c:2235

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((wq_completion)wg-kex-wireguard1#2){+.+.}:
       flush_workqueue+0x126/0x14c0 kernel/workqueue.c:2775
       peer_remove_after_dead+0x16b/0x230 drivers/net/wireguard/peer.c:141
       wg_peer_remove+0x244/0x340 drivers/net/wireguard/peer.c:176
       wg_set_device+0xf76/0x1350 drivers/net/wireguard/netlink.c:575
       genl_family_rcv_msg_doit net/netlink/genetlink.c:672 [inline]
       genl_family_rcv_msg net/netlink/genetlink.c:717 [inline]
       genl_rcv_msg+0x67d/0xea0 net/netlink/genetlink.c:734
       netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
       genl_rcv+0x29/0x40 net/netlink/genetlink.c:745
       netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
       netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1328
       netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1917
       sock_sendmsg_nosec net/socket.c:652 [inline]
       sock_sendmsg+0xd7/0x130 net/socket.c:672
       ____sys_sendmsg+0x753/0x880 net/socket.c:2343
       ___sys_sendmsg+0x100/0x170 net/socket.c:2397
       __sys_sendmsg+0x105/0x1d0 net/socket.c:2430
       __do_sys_sendmsg net/socket.c:2439 [inline]
       __se_sys_sendmsg net/socket.c:2437 [inline]
       __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2437
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&wg->static_identity.lock){++++}:
       down_read+0x95/0x430 kernel/locking/rwsem.c:1495
       wg_noise_handshake_create_initiation+0xc0/0x670 drivers/net/wireguard/noise.c:499
       wg_packet_send_handshake_initiation+0x185/0x250 drivers/net/wireguard/send.c:34
       wg_packet_handshake_send_worker+0x1d/0x30 drivers/net/wireguard/send.c:51
       process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
       worker_thread+0x98/0xe40 kernel/workqueue.c:2410
       kthread+0x361/0x430 kernel/kthread.c:255
       ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

-> #0 ((work_completion)(&peer->transmit_handshake_work)){+.+.}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain kernel/locking/lockdep.c:2970 [inline]
       __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
       lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
       process_one_work+0x972/0x17a0 kernel/workqueue.c:2240
       worker_thread+0x98/0xe40 kernel/workqueue.c:2410
       kthread+0x361/0x430 kernel/kthread.c:255
       ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

other info that might help us debug this:

Chain exists of:
  (work_completion)(&peer->transmit_handshake_work) --> &wg->static_identity.lock --> (wq_completion)wg-kex-wireguard1#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((wq_completion)wg-kex-wireguard1#2);
                               lock(&wg->static_identity.lock);
                               lock((wq_completion)wg-kex-wireguard1#2);
  lock((work_completion)(&peer->transmit_handshake_work));

 *** DEADLOCK ***

1 lock held by kworker/u4:1/21:
 #0: ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff88808fe11528 ((wq_completion)wg-kex-wireguard1#2){+.+.}, at: process_one_work+0x8dd/0x17a0 kernel/workqueue.c:2235

stack backtrace:
CPU: 1 PID: 21 Comm: kworker/u4:1 Not tainted 5.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: wg-kex-wireguard1 wg_packet_handshake_send_worker
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1684
 check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1808
 check_prev_add kernel/locking/lockdep.c:2475 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain kernel/locking/lockdep.c:2970 [inline]
 __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
 process_one_work+0x972/0x17a0 kernel/workqueue.c:2240
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
nf_conntrack: default automatic helper assignment has been turned off for security reasons and CT-based  firewall rule not found. Use the iptables CT target to attach helpers instead.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
