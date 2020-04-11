Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFBAC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9118C20936
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgDKFkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 01:40:16 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49355 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgDKFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 01:40:16 -0400
Received: by mail-il1-f197.google.com with SMTP id r17so1494352ila.16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 22:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8JDQ5U8UVLv002wFo+eytZYgTb48Ga4EUOnZfo48eJ0=;
        b=ena/81NsFGDoI//xdEktabROjTZl5XEIBVhtwr10zSC/TNIor+CCi0Oh4tJibzl4vI
         iqrjltPqKmr6tWYnkNFnuZON0S0oLeh+IKSS1i43MOHN9r6080dybWvx3uLBXZi2AmGL
         8lho1S4IhuDCqaSHRdc9FF4auJo1dz05H0a8IBldtQcyT2L0lbKnU8WsiWPL5BJhTMOE
         ReR0jCnqp8K9KFjrmTHJ/rasKvnqNF8lnujq6VupQ2xLciYoM2E3hQr0QuqiEQ9Jrwr6
         vJhniL7pVY8K4zusj2giUkQEn+u4Hn18YS7kgQqEe+ywzoDq1urvdgL/AwRwDvI7uWam
         g/UA==
X-Gm-Message-State: AGi0PuYQh73QgKXROH7ZCYK59C9uucVJjyO93Q0CcvZIeIpCs80v6YEX
        dKGwhFIdS/RiGGn0qwutrTIwgL+uLKXJMs+m0vASz5YeyDCa
X-Google-Smtp-Source: APiQypJcxw8RNRO8vv7uAUFgyV0CIt7YmvDKpA2ROqAQGhaCG5xd//xXmcDbnpQ7pHv7zL9kHxTDVKU2mWvOf36ta/5F3p9Ce2pN
MIME-Version: 1.0
X-Received: by 2002:a92:d08e:: with SMTP id h14mr306982ilh.208.1586583614152;
 Fri, 10 Apr 2020 22:40:14 -0700 (PDT)
Date:   Fri, 10 Apr 2020 22:40:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba65ba05a2fd48d9@google.com>
Subject: kernel BUG at net/core/dev.c:LINE! (3)
From:   syzbot <syzbot+af23e7f3e0a7e10c8b67@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    aa81700c macsec: fix NULL dereference in macsec_upd_offloa..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14f97c9fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1e98458335a7d1
dashboard link: https://syzkaller.appspot.com/bug?extid=af23e7f3e0a7e10c8b67
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+af23e7f3e0a7e10c8b67@syzkaller.appspotmail.com

bond11 (unregistering): Released all slaves
bond10 (unregistering): Released all slaves
bond9 (unregistering): Released all slaves
bond8 (unregistering): (slave xfrm1): Releasing backup interface
bond8 (unregistering): Destroying bond
------------[ cut here ]------------
kernel BUG at net/core/dev.c:8797!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 208 Comm: kworker/u4:6 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:rollback_registered_many+0x2b3/0xe70 net/core/dev.c:8797
Code: 48 89 e8 48 c1 e8 03 42 80 3c 30 00 0f 85 19 0b 00 00 48 b8 22 01 00 00 00 00 ad de 48 89 43 70 e9 bc fe ff ff e8 cd 57 62 fb <0f> 0b 4c 8d 7b 68 48 8d 6b 70 eb a5 e8 bc 57 62 fb 49 8b 04 24 48
RSP: 0018:ffffc90000e27718 EFLAGS: 00010293
RAX: ffff8880a933a340 RBX: ffff888088188000 RCX: ffffffff86109040
RDX: 0000000000000000 RSI: ffffffff86109193 RDI: 0000000000000001
RBP: ffff888088188068 R08: ffff8880a933a340 R09: fffffbfff14accf1
R10: fffffbfff14accf0 R11: ffffffff8a566787 R12: ffffc90000e27860
R13: ffffc90000e277f8 R14: dffffc0000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfa2811000 CR3: 0000000093d8c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rollback_registered+0xf2/0x1c0 net/core/dev.c:8871
 unregister_netdevice_queue net/core/dev.c:9967 [inline]
 unregister_netdevice_queue+0x1d7/0x2b0 net/core/dev.c:9960
 unregister_netdevice include/linux/netdevice.h:2725 [inline]
 bond_release_and_destroy drivers/net/bonding/bond_main.c:2091 [inline]
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3164 [inline]
 bond_netdev_event.cold+0xd1/0x128 drivers/net/bonding/bond_main.c:3277
 notifier_call_chain+0xc0/0x230 kernel/notifier.c:83
 call_netdevice_notifiers_info net/core/dev.c:1948 [inline]
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1933
 call_netdevice_notifiers_extack net/core/dev.c:1960 [inline]
 call_netdevice_notifiers net/core/dev.c:1974 [inline]
 rollback_registered_many+0x75c/0xe70 net/core/dev.c:8826
 unregister_netdevice_many.part.0+0x16/0x1e0 net/core/dev.c:9986
 unregister_netdevice_many net/core/dev.c:9985 [inline]
 default_device_exit_batch+0x311/0x3d0 net/core/dev.c:10469
 ops_exit_list.isra.0+0x103/0x150 net/core/net_namespace.c:189
 cleanup_net+0x511/0xa50 net/core/net_namespace.c:603
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 8b2af7c1d8b87378 ]---
RIP: 0010:rollback_registered_many+0x2b3/0xe70 net/core/dev.c:8797
Code: 48 89 e8 48 c1 e8 03 42 80 3c 30 00 0f 85 19 0b 00 00 48 b8 22 01 00 00 00 00 ad de 48 89 43 70 e9 bc fe ff ff e8 cd 57 62 fb <0f> 0b 4c 8d 7b 68 48 8d 6b 70 eb a5 e8 bc 57 62 fb 49 8b 04 24 48
RSP: 0018:ffffc90000e27718 EFLAGS: 00010293
RAX: ffff8880a933a340 RBX: ffff888088188000 RCX: ffffffff86109040
RDX: 0000000000000000 RSI: ffffffff86109193 RDI: 0000000000000001
RBP: ffff888088188068 R08: ffff8880a933a340 R09: fffffbfff14accf1
R10: fffffbfff14accf0 R11: ffffffff8a566787 R12: ffffc90000e27860
R13: ffffc90000e277f8 R14: dffffc0000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfa2816028 CR3: 0000000093d8c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
