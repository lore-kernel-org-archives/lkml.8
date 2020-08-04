Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E235C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D0F207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgHDPfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:35:32 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51538 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbgHDPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:35:32 -0400
Received: by mail-io1-f71.google.com with SMTP id l1so29318391ioh.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0mPnjUUuN3ds2LVQMSGunGLdZdt70gHEdjnpz4HRJfM=;
        b=gvynSeCP8C8fiDDMx85o3DNOMkJ9efObcfkvEw/d2obCFaEmxl5kIG5IiD+I6tKYzF
         rXR8Ggkl/vBZSXdGviviMEwCQK/l1RfVXahHm8rDn+dL7sM+aHFe7aPFhiusKsazSq8J
         fxSuutKYDT3sija0lu4nAKf54qBNIdmjFAEmWeOBTmUdZtDMv7wH+IdcxLUHjqRFBy7F
         XkiGUQM+DJ+FX3ugF1HaeYTFah5nvsS18p8pxAlrMJemCjBZA63bZ1eTRdEs+xNgzUxF
         62TM37LUAPRT8cX8IymjBqFHQ/Qa2UVjbDBz7yNPngz1s0tcsNtF4OK4fxl8CGr6ia8U
         x/mA==
X-Gm-Message-State: AOAM531OgwMuiGvzU/prM41jA027Z3m3Icjn5nnPXnBX1TBO8s6On7FA
        FPVJTGAYgAwivyR3R+DXCL0p0tbVnS6G9JbPPOsIWgTOXihB
X-Google-Smtp-Source: ABdhPJwthYKqwD7lg4/N0+Gzk2jLwwTK3ieOdfqC9/iF/tSjNJDptXV9jjCw8IhzYLb6AIAjH9QItWIS8Sdbd6VBN3n8wKDdLnva
MIME-Version: 1.0
X-Received: by 2002:a92:85d6:: with SMTP id f205mr5664062ilh.238.1596555330420;
 Tue, 04 Aug 2020 08:35:30 -0700 (PDT)
Date:   Tue, 04 Aug 2020 08:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055881a05ac0f0122@google.com>
Subject: WARNING: suspicious RCU usage in ovs_flow_tbl_destroy
From:   syzbot <syzbot+c0eb9e7cdde04e4eb4be@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dev@openvswitch.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pshelar@ovn.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2f631133 net: Pass NULL to skb_network_protocol() when we ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12daae2a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91a13b78c7dc258d
dashboard link: https://syzkaller.appspot.com/bug?extid=c0eb9e7cdde04e4eb4be
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172cd3d4900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fbd342900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0eb9e7cdde04e4eb4be@syzkaller.appspotmail.com

netlink: 'syz-executor399': attribute type 2 has an invalid length.
=============================
WARNING: suspicious RCU usage
5.8.0-rc7-syzkaller #0 Not tainted
-----------------------------
net/openvswitch/flow_table.c:521 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor399/6802:
 #0: ffffffff8a8319b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40 net/netlink/genetlink.c:741

stack backtrace:
CPU: 0 PID: 6802 Comm: syz-executor399 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 ovs_flow_tbl_destroy+0x1d6/0x210 net/openvswitch/flow_table.c:521
 ovs_dp_cmd_new+0x8ca/0xea0 net/openvswitch/datapath.c:1747
 genl_family_rcv_msg_doit net/netlink/genetlink.c:669 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:714 [inline]
 genl_rcv_msg+0x61d/0x980 net/netlink/genetlink.c:731
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:742
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2359
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2413
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2446
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdfda722f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402d9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ae0
R13: 0000000000401b70 R14: 0000000000000000 R15: 0000000000000000

=============================
WARNING: suspicious RCU usage
5.8.0-rc7-syzkaller #0 Not tainted
-----------------------------
net/openvswitch/flow_table.c:522 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor399/6802:
 #0: ffffffff8a8319b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40 net/netlink/genetlink.c:741

stack backtrace:
CPU: 0 PID: 6802 Comm: syz-executor399 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 ovs_flow_tbl_destroy+0x190/0x210 net/openvswitch/flow_table.c:522
 ovs_dp_cmd_new+0x8ca/0xea0 net/openvswitch/datapath.c:1747
 genl_family_rcv_msg_doit net/netlink/genetlink.c:669 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:714 [inline]
 genl_rcv_msg+0x61d/0x980 net/netlink/genetlink.c:731
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:742
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2359
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2413
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2446
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdfda722f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402d9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
