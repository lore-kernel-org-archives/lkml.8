Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F773C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5686B21D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIIF32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:29:28 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:55129 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgIIF3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:29:22 -0400
Received: by mail-io1-f80.google.com with SMTP id o18so1247196ioa.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 22:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lf/iCucPg6SfDlrGHl/iTTZeT934TiCXG+T295vuy1E=;
        b=pjy4ZrEnb5C4piM0fMpOEs4B3haLwS6ajhccKHtRy5zCx2bGsOqDreVgGVXWxKgoql
         1yvniSm9VhtBwWdzKX1s2W0EQcmNwLwUMNZMGF2P8CPLnLERkl6CJAiVMHWd1+mnhiAg
         HttRfCzS0VROMWZn4qZuR+MiS5BSxoC+6qxlmonjxnNqEOMfn5uyplVKKHGQJHlILMyp
         SnQSfVeScnkr8SAJ4J4EBdAYVfN+YiExFSBVXC/pnw46YNfpm3uc7LWK1rMlMP/QlOLi
         CFQaVDiw3dVymw6/uMtHM+uVLa2OC6LW60Urb1Ga80BjSYABA7ov3yoJAOMpBhqWHYbu
         u2dQ==
X-Gm-Message-State: AOAM531e7rEzwT0vtyBxv2pIqkj6AueQs/T33QWTFVu+0eFdXzQxhFst
        Lp8DTXo7S1YQCU4+kvuru2sVDR1fJXH0ErqqnGRfhK8m/6oU
X-Google-Smtp-Source: ABdhPJyFVf+WCW5Ssgeylwh74E+PzsiOEJGtEJSJFgmW3tHe9EnVCQ7FSsvVEjwcSQm/YOvdinNJ049B14quSXcuCBEaIBBhwQT0
MIME-Version: 1.0
X-Received: by 2002:a6b:d606:: with SMTP id w6mr2058861ioa.89.1599629361378;
 Tue, 08 Sep 2020 22:29:21 -0700 (PDT)
Date:   Tue, 08 Sep 2020 22:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db78de05aedabb5a@google.com>
Subject: INFO: rcu detected stall in cleanup_net (4)
From:   syzbot <syzbot+8267241609ae8c23b248@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    59126901 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-03' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12edb935900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=8267241609ae8c23b248
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157c7aa5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c92ef9900000

The issue was bisected to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f24245900000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f24245900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8267241609ae8c23b248@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...0: (1 GPs behind) idle=2e2/1/0x4000000000000000 softirq=8639/8646 fqs=5250 
	(detected by 0, t=10502 jiffies, g=10573, q=113)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2516 Comm: kworker/u4:4 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:201 [inline]
RIP: 0010:rb_erase+0x0/0x1210 lib/rbtree.c:443
Code: 08 4c 8b 04 24 e9 1f f6 ff ff e8 fb f1 00 fe 48 8b 54 24 08 4c 8b 04 24 e9 f7 f5 ff ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <48> b8 00 00 00 00 00 fc ff df 41 57 49 89 f7 41 56 41 55 49 89 fd
RSP: 0018:ffffc90000da8db8 EFLAGS: 00000046
RAX: 0000000000010002 RBX: ffff88808ed3fb40 RCX: 1ffff11015ce4f13
RDX: ffff88809fb66540 RSI: ffff8880ae727890 RDI: ffff88808ed3fb40
RBP: ffff8880ae727890 R08: 0000000000000000 R09: ffffffff8ab2640f
R10: ffff888099a68400 R11: 0000000000000001 R12: ffff8880ae727898
R13: ffff8880ae727840 R14: ffff88808ed3fb40 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000610 CR3: 0000000009a8d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rb_erase_cached include/linux/rbtree.h:149 [inline]
 timerqueue_del+0x7f/0x140 lib/timerqueue.c:67
 __remove_hrtimer kernel/time/hrtimer.c:1001 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1504 [inline]
 __hrtimer_run_queues+0x518/0xfc0 kernel/time/hrtimer.c:1588
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1650
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xb2/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
RIP: 0010:console_unlock+0xb4a/0xe60 kernel/printk/printk.c:2509
Code: 89 48 c1 e8 03 42 80 3c 38 00 0f 85 18 03 00 00 48 83 3d a0 f8 58 08 00 0f 84 90 01 00 00 e8 4d 07 17 00 48 8b 7c 24 30 57 9d <0f> 1f 44 00 00 8b 5c 24 64 31 ff 89 de e8 b4 03 17 00 85 db 0f 84
RSP: 0018:ffffc90008797280 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000006
RDX: ffff88809fb66540 RSI: ffffffff815d43b3 RDI: 0000000000000293
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8c5f49e7
R10: fffffbfff18be93c R11: 00000000000808e8 R12: ffffffff84c29820
R13: 0000000000000073 R14: ffffffff8a3cb4b0 R15: dffffc0000000000
 vprintk_emit+0x2ff/0x740 kernel/printk/printk.c:2029
 dev_vprintk_emit+0x3eb/0x436 drivers/base/core.c:4133
 dev_printk_emit+0xba/0xf1 drivers/base/core.c:4144
 __netdev_printk+0x1c6/0x27a net/core/dev.c:10749
 netdev_info+0xd7/0x109 net/core/dev.c:10804
 nsim_udp_tunnel_unset_port.cold+0x179/0x1c8 drivers/net/netdevsim/udp_tunnels.c:59
 udp_tunnel_nic_device_sync_one net/ipv4/udp_tunnel_nic.c:224 [inline]
 udp_tunnel_nic_device_sync_by_port net/ipv4/udp_tunnel_nic.c:245 [inline]
 __udp_tunnel_nic_device_sync.part.0+0xa50/0xcb0 net/ipv4/udp_tunnel_nic.c:288
 __udp_tunnel_nic_device_sync net/ipv4/udp_tunnel_nic.c:282 [inline]
 udp_tunnel_nic_flush+0x24c/0x560 net/ipv4/udp_tunnel_nic.c:665
 udp_tunnel_nic_unregister net/ipv4/udp_tunnel_nic.c:791 [inline]
 udp_tunnel_nic_netdevice_event+0x7c5/0xfcf net/ipv4/udp_tunnel_nic.c:833
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2033
 call_netdevice_notifiers_extack net/core/dev.c:2045 [inline]
 call_netdevice_notifiers net/core/dev.c:2059 [inline]
 rollback_registered_many+0x768/0x1210 net/core/dev.c:9284
 rollback_registered net/core/dev.c:9329 [inline]
 unregister_netdevice_queue+0x2dd/0x570 net/core/dev.c:10410
 unregister_netdevice include/linux/netdevice.h:2774 [inline]
 nsim_destroy+0x35/0x70 drivers/net/netdevsim/netdev.c:339
 __nsim_dev_port_del+0x144/0x1e0 drivers/net/netdevsim/dev.c:946
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:959 [inline]
 nsim_dev_reload_destroy+0xff/0x1e0 drivers/net/netdevsim/dev.c:1135
 nsim_dev_reload_down+0x6e/0xd0 drivers/net/netdevsim/dev.c:712
 devlink_reload+0xc1/0x3a0 net/core/devlink.c:2974
 devlink_pernet_pre_exit+0xfb/0x190 net/core/devlink.c:9618
 ops_pre_exit_list net/core/net_namespace.c:176 [inline]
 cleanup_net+0x451/0xa00 net/core/net_namespace.c:591
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 0.000 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
