Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A429C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B69A21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgGaT4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:56:22 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55088 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgGaT4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:56:21 -0400
Received: by mail-io1-f72.google.com with SMTP id z25so13959599ioh.21
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 12:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6Y6odJ2rAMTPxXEnFqUO1LeqhGdIijbCt/dMGVjMyOs=;
        b=KxwvnE5XniOqlhwg++flwpucmY3kitVqvd5vzabCVc7Rbr4P+frE2jy4joCrFDiiUW
         HnW2hzmNFJgzV9X5e4Nixez702NJX7unW5DAREJEclMkb2UDYgrS+QOwPfJblZ5356qg
         ulHI9rDY7LoOtTElpMUXT+cxAPCY8EJZ+wtoJfrMVjH3WoX0FP/vx2zaCfaFK0ZDChIK
         ylioJJ17iCgU7cN/WqooHtDNggN9GET5Z0D8wB9k7y6Gs5OXlbIVVBRT/4D+3zr1/mBt
         jjDE1IB9s18PAqY3p4GeWs67jCZsp9Y+0lXes7fXMZWAk5pdPJx+XK/3Lewd0tdNKvXN
         mplQ==
X-Gm-Message-State: AOAM533bLn02/0VQT5y0S645PBBv5eQx7x5G6ePms/Qg9xGBdNHG6S7W
        meou2TFdIyZWWE6WYdvsqjXDlN6PHEIkSlY5qLKdQ0BmOkrE
X-Google-Smtp-Source: ABdhPJwnZ/AWEsPM90xPYSvJdkqfQYCctbFhZseETNWXRp3PqrrGMpEOA7ZVeYvxx8VPqV/UFA/fy70vVWf4vTvAGe3EfQ9Shzwv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e10:: with SMTP id a16mr5619127ilk.204.1596225379998;
 Fri, 31 Jul 2020 12:56:19 -0700 (PDT)
Date:   Fri, 31 Jul 2020 12:56:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1a41205abc22eb2@google.com>
Subject: BUG: stack guard page was hit in pvclock_clocksource_read (2)
From:   syzbot <syzbot+3f7cb4585b3335f0f5d1@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vincenzo.frascino@arm.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92ed3019 Linux 5.8-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1344d302900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
dashboard link: https://syzkaller.appspot.com/bug?extid=3f7cb4585b3335f0f5d1
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f7cb4585b3335f0f5d1@syzkaller.appspotmail.com

BUG: stack guard page was hit at 000000005b13312d (stack is 00000000a1a685f7..00000000fe4e891f)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 30212 Comm: syz-executor.3 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:pvclock_clocksource_read+0x21/0x510 arch/x86/kernel/pvclock.c:68
Code: 2e 0f 1f 84 00 00 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 f8 41 57 48 c1 e8 03 41 56 41 55 41 54 4c 8d 67 03 55 4c 89 e1 <53> 48 c1 e9 03 48 89 fb 48 83 ec 58 0f b6 04 10 0f b6 14 11 48 89
RSP: 0018:ffffc90007208000 EFLAGS: 00010806
RAX: 1ffffffff17cf200 RBX: ffff8880ae620dc0 RCX: ffffffff8be79003
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffffffff8be79000
RBP: ffff8880506e8480 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8be79003
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9566ff4700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90007207ff8 CR3: 0000000218765000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kvm_clock_read arch/x86/kernel/kvmclock.c:90 [inline]
 kvm_sched_clock_read+0x14/0x40 arch/x86/kernel/kvmclock.c:102
 paravirt_sched_clock arch/x86/include/asm/paravirt.h:22 [inline]
 sched_clock+0x2a/0x40 arch/x86/kernel/tsc.c:252
 sched_clock_cpu+0x18/0x1b0 kernel/sched/clock.c:371
 irqtime_account_irq+0x63/0x280 kernel/sched/cputime.c:60
 account_irq_enter_time include/linux/vtime.h:109 [inline]
 irq_enter_rcu+0x61/0x140 kernel/softirq.c:356
 sysvec_apic_timer_interrupt+0x13/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
RIP: 0010:unwind_next_frame+0x950/0x1f90 arch/x86/kernel/unwind_orc.c:472
Code: fc ff df 48 8b 14 24 48 c1 ea 03 80 3c 02 00 0f 85 98 13 00 00 4c 89 c0 49 8b 57 38 48 be 00 00 00 00 00 fc ff df 48 c1 e8 03 <0f> b6 3c 30 49 8d 40 01 49 89 c3 49 c1 eb 03 41 0f b6 34 33 4d 89
RSP: 0018:ffffc90007208198 EFLAGS: 00000a02
RAX: 1ffffffff16f2516 RBX: 1ffff92000e4103b RCX: ffffffff8b7928b5
RDX: ffffc90007209af8 RSI: dffffc0000000000 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffff8b7928b0 R09: ffffffff8b7928b4
R10: 000000000007201e R11: 0000000000110224 R12: ffffc900072082b8
R13: ffffc900072082a5 R14: ffffc900072082c0 R15: ffffc90007208270
 arch_stack_walk+0x81/0xf0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc_node mm/slab.c:3263 [inline]
 kmem_cache_alloc_node_trace+0x140/0x400 mm/slab.c:3593
 __do_kmalloc_node mm/slab.c:3615 [inline]
 __kmalloc_node_track_caller+0x38/0x60 mm/slab.c:3630
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0xae/0x550 net/core/skbuff.c:210
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
 team_compute_features drivers/net/team/team.c:1026 [inline]
 team_device_event+0x860/0xab6 drivers/net/team/team.c:3006
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 team_compute_features drivers/net/team/team.c:1026 [inline]
 team_device_event+0x860/0xab6 drivers/net/team/team.c:3006
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 team_compute_features drivers/net/team/team.c:1026 [inline]
 team_device_event+0x860/0xab6 drivers/net/team/team.c:3006
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 team_compute_features drivers/net/team/team.c:1026 [inline]
 team_device_event+0x860/0xab6 drivers/net/team/team.c:3006
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 team_compute_features drivers/net/team/team.c:1026 [inline]
 team_device_event+0x860/0xab6 drivers/net/team/team.c:3006
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 team_compute_features drivers/net/team/team.c:1026 [inline]
 team_device_event+0x860/0xab6 drivers/net/team/team.c:3006
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 team_compute_features drivers/net/team/team.c:1026 [inline]
 team_device_event+0x860/0xab6 drivers/net/team/team.c:3006
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
 netdev_change_features+0x61/0xb0 net/core/dev.c:9259
 team_compute_features drivers/net/team/team.c:1026 [inline]
 team_device_event+0x860/0xab6 drivers/net/team/team.c:3006
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers net/core/dev.c:2053 [inline]
 netdev_features_change net/core/dev.c:1443 [inline]
 netdev_sync_lower_features net/core/dev.c:9056 [inline]
 __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
Lost 482 message(s)!
---[ end trace 2db25564313cfad5 ]---
RIP: 0010:pvclock_clocksource_read+0x21/0x510 arch/x86/kernel/pvclock.c:68
Code: 2e 0f 1f 84 00 00 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 f8 41 57 48 c1 e8 03 41 56 41 55 41 54 4c 8d 67 03 55 4c 89 e1 <53> 48 c1 e9 03 48 89 fb 48 83 ec 58 0f b6 04 10 0f b6 14 11 48 89
RSP: 0018:ffffc90007208000 EFLAGS: 00010806
RAX: 1ffffffff17cf200 RBX: ffff8880ae620dc0 RCX: ffffffff8be79003
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffffffff8be79000
RBP: ffff8880506e8480 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8be79003
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9566ff4700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90007207ff8 CR3: 0000000218765000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
