Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8392BC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C6124682
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCJI3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:29:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39416 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJI3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:29:10 -0400
Received: by mail-io1-f71.google.com with SMTP id v1so8470086ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 01:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0FgBXE7PAb7uDp915satuPjIwbrNJA32cUNG0KVfHS0=;
        b=WCu499+bAPitpfLKehIM+5TOatWQSpGkw6m/dMGcD8PQFEi+ioW2YoxLvYubZTWwwq
         oMjfPzc6r3GjMoz3Lxkrd/w/ASdlkwY6pBvR93gyocOiPxvaXaRt30Jv3mcmTmRZxBza
         C6VCeML0ZoMC5uOON9cMq3QuwlFJ5oYfMGO/e8PxbTvfJh0FOqrvqveJzSIOzUnsAwCL
         48IB1/bPhR6X2YoAubFyQA/u06MaiIa24L08yhjZ5AOz9Vjdla6ts4JLJE7PR3+f911d
         tkivBS1+eGEAGSEVhq+AnwRHsnIEkGEtOA9SbP9lGRbbE0d4A0O23AttRhT/nd4aAlWz
         kc3Q==
X-Gm-Message-State: ANhLgQ0JBuMnuxAfnLHyAmwt44EzpvPloedGgHizT8nsLtpVrHKzTg60
        iYj4ZhNPaeVMBfJ2S4Np8gcrsDI9hVB/zErjNn9E18m1XIiR
X-Google-Smtp-Source: ADFU+vvYAllLcoRD5/dza8kqalZ5ZYAzGDIZw+7QxoUAVmnq1THBc7eyAo4J5Tx0umfqnhqRiKyOMQ8ril2A4UmvZk2SdYDbpVgc
MIME-Version: 1.0
X-Received: by 2002:a92:9edc:: with SMTP id s89mr19087599ilk.229.1583828949268;
 Tue, 10 Mar 2020 01:29:09 -0700 (PDT)
Date:   Tue, 10 Mar 2020 01:29:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8001905a07be9de@google.com>
Subject: general protection fault in list_lru_del
From:   syzbot <syzbot+34c3a8c021ca80c808b0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1492da55e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=34c3a8c021ca80c808b0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+34c3a8c021ca80c808b0@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 11205 Comm: kworker/u4:4 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: krdsd rds_tcp_accept_worker
RIP: 0010:__list_del_entry_valid+0x85/0xf5 lib/list_debug.c:51
Code: 0f 84 e1 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 53 49 8b 14 24 4c 39 f2 0f 85 99 00 00 00 49 8d 7d
RSP: 0018:ffffc90001b27af0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888020040c60 RCX: ffffffff81a1dda6
RDX: 0000000000000000 RSI: ffffffff81a1dba1 RDI: ffff888020040c68
RBP: ffffc90001b27b08 R08: ffff88809f18e280 R09: fffff52000364f51
R10: fffff52000364f50 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888020040c60 R15: ffff888020040c68
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78a44de000 CR3: 000000008c993000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000006920 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 list_lru_del+0x11d/0x620 mm/list_lru.c:158
 inode_lru_list_del fs/inode.c:450 [inline]
 iput_final fs/inode.c:1568 [inline]
 iput+0x52c/0x900 fs/inode.c:1597
 __sock_release+0x20e/0x280 net/socket.c:617
 sock_release+0x18/0x20 net/socket.c:625
 rds_tcp_accept_one+0x5a9/0xc00 net/rds/tcp_listen.c:251
 rds_tcp_accept_worker+0x56/0x80 net/rds/tcp.c:525
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 424f0561ef9bfe17 ]---
RIP: 0010:__list_del_entry_valid+0x85/0xf5 lib/list_debug.c:51
Code: 0f 84 e1 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 53 49 8b 14 24 4c 39 f2 0f 85 99 00 00 00 49 8d 7d
RSP: 0018:ffffc90001b27af0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888020040c60 RCX: ffffffff81a1dda6
RDX: 0000000000000000 RSI: ffffffff81a1dba1 RDI: ffff888020040c68
RBP: ffffc90001b27b08 R08: ffff88809f18e280 R09: fffff52000364f51
R10: fffff52000364f50 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888020040c60 R15: ffff888020040c68
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78a44de000 CR3: 000000008c993000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000006920 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
