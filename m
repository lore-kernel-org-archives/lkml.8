Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD635C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88A12067D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHASJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:09:23 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35190 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgHASJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:09:23 -0400
Received: by mail-io1-f71.google.com with SMTP id s5so18220692iow.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 11:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9llcT2pZnOMv9DmqWx1s87LJ9KxajrFrlns8As6qYn4=;
        b=J6vHVXZLfXX8NdHIUC0R3GZiZtyxxfW1vJtJIfYRGoDXGrNa+Y/fEQIa/E/TNnso7v
         LrlysIkebcRL6s5zLJ1T5Z1anX9BfojzUhW86feXYHRk3q5bgkUbyrADA4DIoHjkBv/m
         ot4gKlRT5FfUobwzG8Aj0WU+8h4hozQeWNrKUA/epBZqgI1Dl96es5Y/dlBUAEArqSPg
         JXhtsMjbMWJ72B1nIq49knbjysGr8MhROWjQPv/PRotfhKaOwajn7zbiUtLbI5doRbBa
         m7p8OAGxJo6ZVheyCjP5Fv2wSYk9/Sf3YgaEWU9HnUpqp7oQ78o9BJ7o84gaqgLbRtEL
         CapQ==
X-Gm-Message-State: AOAM533bw0YSIdTNP82DRSEKXr/V64Hxh36En41EF3vIBZw3a/jVP0EU
        UaR6WLoIhChisoFJlC9OtI/yAtsptUEq1s7a4v+XkF0UJyhR
X-Google-Smtp-Source: ABdhPJwZY41qdL6lAPlUlIIEbJ8qJKoijkJWYbJe99sdAjGGzLqVhG0xUBKL0siVk2LBBMJwyEDRlAhAIP3p5hbwuIAp2ZfiLZAz
MIME-Version: 1.0
X-Received: by 2002:a02:ce4b:: with SMTP id y11mr11547711jar.144.1596305361638;
 Sat, 01 Aug 2020 11:09:21 -0700 (PDT)
Date:   Sat, 01 Aug 2020 11:09:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000897ba05abd4ce25@google.com>
Subject: BUG: stack guard page was hit in arch_stack_walk
From:   syzbot <syzbot+c05e6eff86f7a430fa73@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92ed3019 Linux 5.8-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c98f28900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
dashboard link: https://syzkaller.appspot.com/bug?extid=c05e6eff86f7a430fa73
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c05e6eff86f7a430fa73@syzkaller.appspotmail.com

BUG: stack guard page was hit at 000000009157a0b1 (stack is 000000007cb00dab..0000000055f9d23d)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13871 Comm: syz-executor.4 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:arch_stack_walk+0x0/0xf0 arch/x86/kernel/stacktrace.c:17
Code: 8b eb c0 e6 82 89 fa ee ee 8d 57 01 ee ee eb cd e6 81 eb f1 e6 87 eb ed e6 83 eb e9 cc cc cc cc cc cc cc cc cc cc cc cc cc cc <55> 48 89 e5 41 56 49 89 d6 41 55 49 89 cd 41 54 49 89 f4 53 48 89
RSP: 0018:ffffc90008b18000 EFLAGS: 00010246
RAX: 0000000000000000 RBX: fffff52001163001 RCX: 0000000000000000
RDX: ffff88802b30e480 RSI: ffffc90008b18028 RDI: ffffffff8162c090
RBP: 0000000000000cc0 R08: ffffed1006f83078 R09: ffffed1006f83094
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000cc0
R13: 0000000000000000 R14: ffff88821b77f8c0 R15: 00000000000000e0
FS:  00007f7369ba8700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90008b17ff8 CR3: 00000000a21ec000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc_node mm/slab.c:3263 [inline]
 kmem_cache_alloc_node+0x130/0x3c0 mm/slab.c:3575
 __alloc_skb+0x71/0x550 net/core/skbuff.c:198
 alloc_skb include/linux/skbuff.h:1083 [inline]
 nlmsg_new include/net/netlink.h:940 [inline]
 rtmsg_ifinfo_build_skb+0x72/0x1a0 net/core/rtnetlink.c:3702
 rtmsg_ifinfo_event net/core/rtnetlink.c:3738 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:3729 [inline]
 rtnetlink_event+0x123/0x1d0 net/core/rtnetlink.c:5512
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
 bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
 bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
 bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
 bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
 bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
 bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
 bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
Lost 536 message(s)!
---[ end trace 00f7ed0d29de9cad ]---
RIP: 0010:arch_stack_walk+0x0/0xf0 arch/x86/kernel/stacktrace.c:17
Code: 8b eb c0 e6 82 89 fa ee ee 8d 57 01 ee ee eb cd e6 81 eb f1 e6 87 eb ed e6 83 eb e9 cc cc cc cc cc cc cc cc cc cc cc cc cc cc <55> 48 89 e5 41 56 49 89 d6 41 55 49 89 cd 41 54 49 89 f4 53 48 89
RSP: 0018:ffffc90008b18000 EFLAGS: 00010246
RAX: 0000000000000000 RBX: fffff52001163001 RCX: 0000000000000000
RDX: ffff88802b30e480 RSI: ffffc90008b18028 RDI: ffffffff8162c090
RBP: 0000000000000cc0 R08: ffffed1006f83078 R09: ffffed1006f83094
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000cc0
R13: 0000000000000000 R14: ffff88821b77f8c0 R15: 00000000000000e0
FS:  00007f7369ba8700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90008b17ff8 CR3: 00000000a21ec000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
