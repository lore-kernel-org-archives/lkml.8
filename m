Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_12_24,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC87C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8B220578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCODhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:37:11 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69]:55159 "EHLO
        mail-qv1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCODhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:37:11 -0400
Received: by mail-qv1-f69.google.com with SMTP id s7so12627487qvl.21
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 20:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pprWkeLcDDK7OkQ2Y9iXM9XZrZXSn7f3XX4nhoo6rSw=;
        b=oLPbRMyELsIqn2H5B3V8RWcWr04VuLI37tyyglk1Yr/CuGqOsmdrjzjR3viPLBhUm6
         7hjMx0quK7Dys/gRPG3e09vnLbu4Jg4gjKRPlWy7hmG52MdxnXZ1Oc+AK4WWo2AGOktm
         gOloyPtw0by3lAkvjLRKuxLlz4UDXoW5agreMHU4c51WwEMIl9fllc+vKUisX04cTuyK
         1gHwYGQ3Iz28ik7i1YkMoRitx8R/U4ohz/HQaGR8dmG5JjXLXDH38LSv4RjzwnaN488q
         RMLCqwzqLsV1CjERsRKplTf57HMt7t5byaPpZpByc3XEDXv3XmJUh27UEnXTUCTGY1WQ
         05dg==
X-Gm-Message-State: ANhLgQ0DbrRe22aEZv6C2/dMfO/vg2da1M6DGVGiITsGsPVYFxVBB7Ca
        UxlivwZU3XYdhwIZzc8WA5dcgYl3ZvtLf7c+n+5QpRmV1dIi
X-Google-Smtp-Source: ADFU+vu2SXA/dKpQ43odLnhOnSlKUPuNIrM34J+wCtnsfBmqnncXyUprk3FWCWZot0YxZl1vOGPZQCGFQ14BqT55KcFyz/7xGn41
MIME-Version: 1.0
X-Received: by 2002:a02:8645:: with SMTP id e63mr14230111jai.14.1584172630425;
 Sat, 14 Mar 2020 00:57:10 -0700 (PDT)
Date:   Sat, 14 Mar 2020 00:57:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e642a905a0cbee6e@google.com>
Subject: linux-next test error: WARNING: suspicious RCU usage in ovs_ct_exit
From:   syzbot <syzbot+7ef50afd3a211f879112@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dev@openvswitch.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pshelar@ovn.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2e602db7 Add linux-next specific files for 20200313
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16669919e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf2879fc1055b886
dashboard link: https://syzkaller.appspot.com/bug?extid=7ef50afd3a211f879112
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7ef50afd3a211f879112@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.6.0-rc5-next-20200313-syzkaller #0 Not tainted
-----------------------------
net/openvswitch/conntrack.c:1898 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u4:3/127:
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: __write_once_size include/linux/compiler.h:250 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: process_one_work+0x82a/0x1690 kernel/workqueue.c:2237
 #1: ffffc900013a7dd0 (net_cleanup_work){+.+.}, at: process_one_work+0x85e/0x1690 kernel/workqueue.c:2241
 #2: ffffffff8a54df08 (pernet_ops_rwsem){++++}, at: cleanup_net+0x9b/0xa50 net/core/net_namespace.c:551

stack backtrace:
CPU: 0 PID: 127 Comm: kworker/u4:3 Not tainted 5.6.0-rc5-next-20200313-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 ovs_ct_limit_exit net/openvswitch/conntrack.c:1898 [inline]
 ovs_ct_exit+0x3db/0x558 net/openvswitch/conntrack.c:2295
 ovs_exit_net+0x1df/0xba0 net/openvswitch/datapath.c:2469
 ops_exit_list.isra.0+0xa8/0x150 net/core/net_namespace.c:172
 cleanup_net+0x511/0xa50 net/core/net_namespace.c:589
 process_one_work+0x94b/0x1690 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x357/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
tipc: TX() has been purged, node left!

=============================
WARNING: suspicious RCU usage
5.6.0-rc5-next-20200313-syzkaller #0 Not tainted
-----------------------------
net/ipv4/ipmr.c:1757 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
4 locks held by kworker/u4:3/127:
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: __write_once_size include/linux/compiler.h:250 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8880a9771d28 ((wq_completion)netns){+.+.}, at: process_one_work+0x82a/0x1690 kernel/workqueue.c:2237
 #1: ffffc900013a7dd0 (net_cleanup_work){+.+.}, at: process_one_work+0x85e/0x1690 kernel/workqueue.c:2241
 #2: ffffffff8a54df08 (pernet_ops_rwsem){++++}, at: cleanup_net+0x9b/0xa50 net/core/net_namespace.c:551
 #3: ffffffff8a559c80 (rtnl_mutex){+.+.}, at: ip6gre_exit_batch_net+0x88/0x700 net/ipv6/ip6_gre.c:1602

stack backtrace:
CPU: 1 PID: 127 Comm: kworker/u4:3 Not tainted 5.6.0-rc5-next-20200313-syzkaller #0
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
 rollback_registered_many+0x75c/0xe70 net/core/dev.c:8810
 unregister_netdevice_many.part.0+0x16/0x1e0 net/core/dev.c:9966
 unregister_netdevice_many+0x36/0x50 net/core/dev.c:9965
 ip6gre_exit_batch_net+0x4e8/0x700 net/ipv6/ip6_gre.c:1605
 ops_exit_list.isra.0+0x103/0x150 net/core/net_namespace.c:175
 cleanup_net+0x511/0xa50 net/core/net_namespace.c:589
 process_one_work+0x94b/0x1690 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x357/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
