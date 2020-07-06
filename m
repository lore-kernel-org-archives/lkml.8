Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC821C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9212F20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgGFLMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:12:20 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33433 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgGFLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:12:19 -0400
Received: by mail-io1-f72.google.com with SMTP id x2so23364707iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 04:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=h1YpK10W3aeduo3q7tBUxEMa5S5Rp2GyfLzRDjpjFQ4=;
        b=dMvYpytUViGS1I6TBKONOHHWnhLMHLY25xysbQ4wdNcRaXGwCQFh6fA97pjR/QfIDF
         OLrlZCmcxJieKlpvDhKALHA2uTEJ5F/jLxg+uCxVPa10WytQylqQTtRrKzHhh5O0Mu4p
         kR41U2EtedrjJpc7umQYZySpoVuIOaR1J22h2/+fFywIyPgEmF2CTG4omMQQn5fUwqTw
         bU6Z4NRX5XUT0PeaSyfo0++dlDn8dHrmZQusKhRAvfb8n7eJTup9BUQ7v5/nHQmAoGNU
         DmuD306sm90qnw8HJpNZs9qDtWRYYm98Lh9uuhHa+CCxWAIDHIWmI6z/gLdZMCvT0DDr
         407Q==
X-Gm-Message-State: AOAM533PXmrmO7YbMcq25mOz8WqQyHQNuulKJ935JGueI9hGNMs0j4A1
        m/Hn5kDAx3xfylT0EEl0spk56ZlPXiKEZmth7Deruy2v9yeN
X-Google-Smtp-Source: ABdhPJyCWm4ddGjWDMb6KBkIOfKZ2jMBruKcBYY/+myqjOGXT+1Csag2VXa8UU9Zx5XOic37CgKlU+RRFdYDqQGkIdCDii1+Ndkj
MIME-Version: 1.0
X-Received: by 2002:a92:58d1:: with SMTP id z78mr29218378ilf.276.1594033938293;
 Mon, 06 Jul 2020 04:12:18 -0700 (PDT)
Date:   Mon, 06 Jul 2020 04:12:18 -0700
In-Reply-To: <000000000000735f5205a5b02279@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6ebe005a9c3f210@google.com>
Subject: Re: BUG: unable to handle kernel paging request in fl_dump_key
From:   syzbot <syzbot+9c1be56e9317b795e874@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    1ca0fafd tcp: md5: allow changing MD5 keys in all socket s..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15ec52b7100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=9c1be56e9317b795e874
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1062a40b100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9c1be56e9317b795e874@syzkaller.appspotmail.com

batman_adv: Cannot find parent device
BUG: unable to handle page fault for address: fffffbfffa2f173f
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 21ffe5067 P4D 21ffe5067 PUD 21ffe4067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2591 Comm: syz-executor.2 Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fl_dump_key+0x8d/0x22a0 net/sched/cls_flower.c:2769
Code: 04 f2 04 f2 c7 40 0c 04 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 00 01 00 00 31 c0 e8 1a 32 0d fb 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 74 08 3c 03 0f 8e a8 1f 00 00 45 8b 2f 31 ff
RSP: 0018:ffffc900035e72c8 EFLAGS: 00010a06
RAX: 1ffffffffa2f173f RBX: ffffffffd178b819 RCX: ffffffffd178b9f9
RDX: ffff88806c8d2140 RSI: ffffffff86662036 RDI: ffff88809fa14800
RBP: ffff88809fa14800 R08: 0000000000000000 R09: ffff8880953a203c
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888087ce0040
R13: dffffc0000000000 R14: ffff88809fa148b8 R15: ffffffffd178b9f9
FS:  00007f7df9322700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfffa2f173f CR3: 000000006c49a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 fl_tmplt_dump+0xc9/0x250 net/sched/cls_flower.c:3081
 tc_chain_fill_node+0x48d/0x7c0 net/sched/cls_api.c:2679
 tc_chain_notify+0x187/0x2e0 net/sched/cls_api.c:2705
 tc_ctl_chain+0xb30/0x1000 net/sched/cls_api.c:2891
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5460
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2469
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2352
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb29
Code: Bad RIP value.
RSP: 002b:00007f7df9321c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000005027a0 RCX: 000000000045cb29
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000009
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000a44 R14: 00000000004cd2b2 R15: 00007f7df93226d4
Modules linked in:
CR2: fffffbfffa2f173f
---[ end trace aa31af5515bd8e77 ]---
RIP: 0010:fl_dump_key+0x8d/0x22a0 net/sched/cls_flower.c:2769
Code: 04 f2 04 f2 c7 40 0c 04 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 00 01 00 00 31 c0 e8 1a 32 0d fb 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 74 08 3c 03 0f 8e a8 1f 00 00 45 8b 2f 31 ff
RSP: 0018:ffffc900035e72c8 EFLAGS: 00010a06
RAX: 1ffffffffa2f173f RBX: ffffffffd178b819 RCX: ffffffffd178b9f9
RDX: ffff88806c8d2140 RSI: ffffffff86662036 RDI: ffff88809fa14800
RBP: ffff88809fa14800 R08: 0000000000000000 R09: ffff8880953a203c
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888087ce0040
R13: dffffc0000000000 R14: ffff88809fa148b8 R15: ffffffffd178b9f9
FS:  00007f7df9322700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfffa2f173f CR3: 000000006c49a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

