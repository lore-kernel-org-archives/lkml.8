Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF03C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882822065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGXTXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:23:21 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:32843 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXTXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:23:20 -0400
Received: by mail-il1-f199.google.com with SMTP id c1so6362962ilr.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZFrCqHnU0jwNxTDbdv/+Y2rg6p740vaEs4B70N81Dt4=;
        b=SaPUUPe/EgX9rpu1kyUykLGmqVGxvzUD/aGDyyjUeiA+oBrGGVyn8w13wObGO7MxNj
         cE3oWguIjWmvdvMLfJ+fMO6Dv/gDsFgth1ntXWyI24ZW/8c8DJDr3hBrjc2s/6th9frw
         j2bwVfnLIuJeetESGFXyFxLJtNIDpvfWwFe8Eu11RCK2m3nJ50l2uzKFCMcqNcjFf7qN
         d8m/UAIgE9x+J12sDEgMzIo1W9qxQYbuaiyYAduYKeJESDOb91Mt74JOQl/pkwSUqQo1
         YZzZxwNHIQWMMpWzg2so/7Vw/4PKkPJR0QVNppJ5kKyj5E0G0Sm9vy1hVmGlBvFlk09e
         45uA==
X-Gm-Message-State: AOAM530nLVwqS2NuUBIJ0l3B9r4Gp3FA8wspPjpxPRw+RMwXTXeb8l8n
        IjNaaYE0jWUHqxCD+MiM6IuvxJXSTJf226zfp2r1eBJdI0Qk
X-Google-Smtp-Source: ABdhPJyiYXjAP74BUXo+JnuBfzva/JGy5CbxHrAyHoIncs1sRsBfWvnbytqgEz6PFEJXocWOxcfcQm7LxFbAA6279YCi4QFgfP3a
MIME-Version: 1.0
X-Received: by 2002:a92:c205:: with SMTP id j5mr12051519ilo.137.1595618599068;
 Fri, 24 Jul 2020 12:23:19 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:23:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb6afe05ab34e77e@google.com>
Subject: BUG: stack guard page was hit in unwind_next_frame (2)
From:   syzbot <syzbot+5bdf123b3320cc241813@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, mingo@redhat.com,
        peterz@infradead.org, shile.zhang@linux.alibaba.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5714ee50 copy_xstate_to_kernel: Fix typo which caused GDB ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116964c8900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=5bdf123b3320cc241813
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5bdf123b3320cc241813@syzkaller.appspotmail.com

BUG: stack guard page was hit at 00000000e936347d (stack is 00000000047987e0..00000000cd28eac3)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 24253 Comm: syz-executor.5 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:unwind_next_frame+0x1e/0x1f90 arch/x86/kernel/unwind_orc.c:424
Code: 48 8b 0c 24 e9 72 ff ff ff 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 41 57 49 89 ff 41 56 41 55 41 54 55 53 48 81 ec a0 00 00 00 <48> c7 44 24 40 b3 8a b5 41 48 8d 5c 24 40 48 c7 44 24 48 98 a5 67
RSP: 0018:ffffc90008367f68 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: ffffc90008368118 RCX: ffffc90008368120
RDX: ffffc90008370000 RSI: 1ffff9200106d014 RDI: ffffc90008368090
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffc90008368090
R10: fffff5200106d01d R11: 0000000000000000 R12: fffff5200106d014
R13: fffff5200106d013 R14: ffffc900083680c8 R15: ffffc90008368090
FS:  0000000000000000(0000) GS:ffff8880ae700000(0063) knlGS:00000000f5cfeb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffc90008367f58 CR3: 00000000524e1000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __unwind_start+0x4dd/0x7c0 arch/x86/kernel/unwind_orc.c:698
 unwind_start arch/x86/include/asm/unwind.h:60 [inline]
 arch_stack_walk+0x5e/0xf0 arch/x86/kernel/stacktrace.c:24
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
 rtmsg_ifinfo_build_skb+0x72/0x1a0 net/core/rtnetlink.c:3701
 rtmsg_ifinfo_event net/core/rtnetlink.c:3737 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:3728 [inline]
 rtnetlink_event+0x123/0x1d0 net/core/rtnetlink.c:5511
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
Lost 528 message(s)!
---[ end trace 2343dddd6fe8f1bd ]---
RIP: 0010:unwind_next_frame+0x1e/0x1f90 arch/x86/kernel/unwind_orc.c:424
Code: 48 8b 0c 24 e9 72 ff ff ff 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 41 57 49 89 ff 41 56 41 55 41 54 55 53 48 81 ec a0 00 00 00 <48> c7 44 24 40 b3 8a b5 41 48 8d 5c 24 40 48 c7 44 24 48 98 a5 67
RSP: 0018:ffffc90008367f68 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: ffffc90008368118 RCX: ffffc90008368120
RDX: ffffc90008370000 RSI: 1ffff9200106d014 RDI: ffffc90008368090
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffc90008368090
R10: fffff5200106d01d R11: 0000000000000000 R12: fffff5200106d014
R13: fffff5200106d013 R14: ffffc900083680c8 R15: ffffc90008368090
FS:  0000000000000000(0000) GS:ffff8880ae700000(0063) knlGS:00000000f5cfeb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffc90008367f58 CR3: 00000000524e1000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
