Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05084C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79B620658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG2UEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:04:22 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:39799 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgG2UEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:04:22 -0400
Received: by mail-il1-f199.google.com with SMTP id i66so8981850ile.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9ELpaWYTQuDDVWi9r+nQFpE4UEigiAPgZolmhMlqcc0=;
        b=CverRH3ufAQq9DD+etvHPw+WXvn0El8AlgL7PeAHTrcEYUdb0cZMlNcHbb0v/bu4a/
         YOzARGmyph4X1fQ2Rqet6Ry0a42AhVI96RPU13upEeergVWxGa1H4QmSvrNvahYSioNr
         pf4JqJI/F1mxbA544tDogWN0XcCFvWV7hluS9rDncrv+Q02mUXEiQXPKHc8ackfo3PBy
         991R6LoAyYs9crmnsBChO/7obPGH92ys9UOTcI8U+28cgdnDjzdv6QfxsFcIQXKmWPJj
         JuHHEwCA9cVfzxazX7wHftYpOeh6KD8CHtU/NSlLOOwUkxNqnx1farnKu15g36PnfHlT
         2TuQ==
X-Gm-Message-State: AOAM532qhxCQBXd8z7BD/EWl4RsH2yCR6ycHBL5uaY3UwdjOeOXeNyjc
        4uOogqGw5WWqq4bBvaBSt965iRjk44wANQ9I6gDrcNCq2WR4
X-Google-Smtp-Source: ABdhPJysL7TJsm+E3XdoV4Sa+36Gfnnyww9VQA9atn99N1sIxMXlnW77gf+oW+SBTg+yz4QHTthIxDcvq0DJur69RdbGX3t1RWuC
MIME-Version: 1.0
X-Received: by 2002:a92:9892:: with SMTP id a18mr33750922ill.60.1596053061267;
 Wed, 29 Jul 2020 13:04:21 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:04:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c276c005ab9a0fb1@google.com>
Subject: kernel BUG at mm/internal.h:LINE! (2)
From:   syzbot <syzbot+f62749569eab36774dc5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    68845a55 Merge branch 'akpm' into master (patches from And..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c86c54900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=f62749569eab36774dc5
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f62749569eab36774dc5@syzkaller.appspotmail.com

vma ffff888000153210 start 0007700000077000 end 0000000000077000
next 0007700000000000 prev 0000000007070707 mm 0007700000000000
prot 77700000077000 anon_vma 0000000000000000 vm_ops ffffffff885cecc0
pgoff 0 file ffff88809e09a7c0 private_data 0000000000000000
flags: 0x0()
------------[ cut here ]------------
kernel BUG at mm/internal.h:401!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1676 Comm: kswapd0 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vma_address mm/internal.h:401 [inline]
RIP: 0010:vma_address mm/internal.h:393 [inline]
RIP: 0010:rmap_walk_file+0x6a4/0xbf0 mm/rmap.c:1921
Code: e8 91 20 cc ff 48 83 eb 01 48 89 e8 48 29 d8 48 c1 f8 06 48 01 44 24 18 e9 1a fb ff ff e8 74 20 cc ff 4c 89 e7 e8 95 e3 f9 ff <0f> 0b e8 65 20 cc ff 48 8b 44 24 10 4c 8d 68 78 4c 89 ef e8 b4 8a
RSP: 0018:ffffc90006987598 EFLAGS: 00010287
RAX: 000000000000010f RBX: 000770000019e000 RCX: 0000000000000000
RDX: ffff8880a425e540 RSI: ffffffff815d4eb7 RDI: fffff52000d30e8e
RBP: ffffea00021eac40 R08: 000000000000010f R09: ffff8880ae6318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888000153210
R13: dffffc0000000000 R14: 0007700000077000 R15: 0000000000077000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000788070 CR3: 000000020b00c000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rmap_walk+0x105/0x190 mm/rmap.c:1946
 page_referenced+0x417/0x4b0 mm/rmap.c:888
 shrink_active_list+0x3a6/0x1350 mm/vmscan.c:2061
 shrink_list mm/vmscan.c:2167 [inline]
 shrink_lruvec+0x842/0x10f0 mm/vmscan.c:2467
 shrink_node_memcgs mm/vmscan.c:2656 [inline]
 shrink_node+0x4b0/0x1b60 mm/vmscan.c:2770
 kswapd_shrink_node mm/vmscan.c:3517 [inline]
 balance_pgdat+0x72f/0x10d0 mm/vmscan.c:3675
 kswapd+0x5a5/0xe70 mm/vmscan.c:3932
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Modules linked in:
---[ end trace aecaf7276f5d1d16 ]---
RIP: 0010:vma_address mm/internal.h:401 [inline]
RIP: 0010:vma_address mm/internal.h:393 [inline]
RIP: 0010:rmap_walk_file+0x6a4/0xbf0 mm/rmap.c:1921
Code: e8 91 20 cc ff 48 83 eb 01 48 89 e8 48 29 d8 48 c1 f8 06 48 01 44 24 18 e9 1a fb ff ff e8 74 20 cc ff 4c 89 e7 e8 95 e3 f9 ff <0f> 0b e8 65 20 cc ff 48 8b 44 24 10 4c 8d 68 78 4c 89 ef e8 b4 8a
RSP: 0018:ffffc90006987598 EFLAGS: 00010287
RAX: 000000000000010f RBX: 000770000019e000 RCX: 0000000000000000
RDX: ffff8880a425e540 RSI: ffffffff815d4eb7 RDI: fffff52000d30e8e
RBP: ffffea00021eac40 R08: 000000000000010f R09: ffff8880ae6318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888000153210
R13: dffffc0000000000 R14: 0007700000077000 R15: 0000000000077000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000788070 CR3: 000000020b00c000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
