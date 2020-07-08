Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF56C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE03520774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGHBnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:43:22 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:49341 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgGHBnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:43:22 -0400
Received: by mail-il1-f200.google.com with SMTP id w10so23559308ilm.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 18:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0NTrAf+pEMjlV6Xv2ifwmFFXw6VXjE6A98kcSeFtJiY=;
        b=Ox3FJisIVvPi6wx87um4e1kAADp92LLcsUqVPXNs40/PqANt8OMJfZzzfNdZPdXA3Q
         STkElXSQ87lOQESZ18KE7rSzZVPsguwfRIVZm/ehvnspPdake7UJU7uE4MsTRbxV/kM4
         hnF7Ah7Y4hkLaA1uQRjhyUqDNLQVVQ/ffazq0qgOm+kP7adE+i/wzc5SK71hIilDEaq4
         N2cbYdWPMcMtczy7aFqAnltRb0goILa11OUHnGzauFALX3Q5Zls93zeq5skxqU95jhqO
         7b+DYCLvWJu5Xw7IfxTKDdmktgs9ZNTKx1SAXL1qOzn8mGxgsoOQP8EpzQL9z34L7HrW
         2iig==
X-Gm-Message-State: AOAM532H/AtiyJLNi1Q86RBnlCP+vmYQTDLr8yoFvz9nZ8bGTte32FBO
        cxVX//HfOlTaIjsJJPxY55WS+sqPa9uqalkVvidDqxSKrHMX
X-Google-Smtp-Source: ABdhPJwFoXDqjYEyfm/RyYF2jVWY/ysqHnAgWW4txPuO0JVErrGIMtix7yYN6OCkK83q7DSmq1uyR0RQ7B6zCE7tNYDjfXDlHGv2
MIME-Version: 1.0
X-Received: by 2002:a6b:3985:: with SMTP id g127mr19244869ioa.107.1594172600851;
 Tue, 07 Jul 2020 18:43:20 -0700 (PDT)
Date:   Tue, 07 Jul 2020 18:43:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095a5f205a9e43b69@google.com>
Subject: KASAN: slab-out-of-bounds Read in hci_extended_inquiry_result_evt
From:   syzbot <syzbot+d8489a79b781849b9c46@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10261e7b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=d8489a79b781849b9c46
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d62e6d100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1061f66d100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d8489a79b781849b9c46@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:406 [inline]
BUG: KASAN: slab-out-of-bounds in bacpy include/net/bluetooth/bluetooth.h:274 [inline]
BUG: KASAN: slab-out-of-bounds in hci_extended_inquiry_result_evt.isra.0+0x1be/0x5e0 net/bluetooth/hci_event.c:4394
Read of size 6 at addr ffff88809f0ec404 by task kworker/u5:2/6794

CPU: 0 PID: 6794 Comm: kworker/u5:2 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_rx_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x20/0x60 mm/kasan/common.c:105
 memcpy include/linux/string.h:406 [inline]
 bacpy include/net/bluetooth/bluetooth.h:274 [inline]
 hci_extended_inquiry_result_evt.isra.0+0x1be/0x5e0 net/bluetooth/hci_event.c:4394
 hci_event_packet+0x2828/0x86f5 net/bluetooth/hci_event.c:6115
 hci_rx_work+0x22e/0xb10 net/bluetooth/hci_core.c:4705
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Allocated by task 6797:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0xae/0x550 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1083 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:377 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:165 [inline]
 vhci_write+0xbd/0x450 drivers/bluetooth/hci_vhci.c:285
 call_write_iter include/linux/fs.h:1907 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:484
 __vfs_write+0xc9/0x100 fs/read_write.c:497
 vfs_write+0x268/0x5d0 fs/read_write.c:559
 ksys_write+0x12d/0x250 fs/read_write.c:612
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 4786:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3757
 skb_free_head net/core/skbuff.c:590 [inline]
 skb_release_data+0x6d9/0x910 net/core/skbuff.c:610
 skb_release_all net/core/skbuff.c:664 [inline]
 __kfree_skb+0x46/0x60 net/core/skbuff.c:678
 sk_wmem_free_skb include/net/sock.h:1532 [inline]
 tcp_rtx_queue_unlink_and_free include/net/tcp.h:1849 [inline]
 tcp_clean_rtx_queue net/ipv4/tcp_input.c:3152 [inline]
 tcp_ack+0x1bea/0x58f0 net/ipv4/tcp_input.c:3688
 tcp_rcv_established+0x1820/0x1e70 net/ipv4/tcp_input.c:5712
 tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1629
 tcp_v4_rcv+0x2cef/0x3760 net/ipv4/tcp_ipv4.c:2011
 ip_protocol_deliver_rcu+0x5c/0x880 net/ipv4/ip_input.c:204
 ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
 dst_input include/net/dst.h:441 [inline]
 ip_sublist_rcv_finish+0x9a/0x2c0 net/ipv4/ip_input.c:550
 ip_list_rcv_finish.constprop.0+0x514/0x6e0 net/ipv4/ip_input.c:600
 ip_sublist_rcv net/ipv4/ip_input.c:608 [inline]
 ip_list_rcv+0x34e/0x488 net/ipv4/ip_input.c:643
 __netif_receive_skb_list_ptype net/core/dev.c:5324 [inline]
 __netif_receive_skb_list_core+0x549/0x8e0 net/core/dev.c:5372
 __netif_receive_skb_list net/core/dev.c:5424 [inline]
 netif_receive_skb_list_internal+0x777/0xd70 net/core/dev.c:5531
 gro_normal_list net/core/dev.c:5642 [inline]
 gro_normal_list net/core/dev.c:5638 [inline]
 napi_complete_done+0x1f1/0x860 net/core/dev.c:6367
 virtqueue_napi_complete+0x2c/0xc0 drivers/net/virtio_net.c:329
 virtnet_poll+0xae0/0xd76 drivers/net/virtio_net.c:1455
 napi_poll net/core/dev.c:6684 [inline]
 net_rx_action+0x4a1/0xe60 net/core/dev.c:6752
 __do_softirq+0x34c/0xa60 kernel/softirq.c:292

The buggy address belongs to the object at ffff88809f0ec000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 4 bytes to the right of
 1024-byte region [ffff88809f0ec000, ffff88809f0ec400)
The buggy address belongs to the page:
page:ffffea00027c3b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002587dc8 ffffea00027c8e08 ffff8880aa000c40
raw: 0000000000000000 ffff88809f0ec000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809f0ec300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88809f0ec380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88809f0ec400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88809f0ec480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88809f0ec500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
