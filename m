Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12438C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B3A21D1A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgIHHcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:32:36 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:46679 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgIHHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:32:24 -0400
Received: by mail-io1-f80.google.com with SMTP id c22so2330607iom.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lOlyfhahYs6/L5AwmyUXKM8XGv3jZMcGEniCSrR6SP4=;
        b=t2ohb3aZExS6VDD3sLDRrZ8cMetMms0oT1tC1AtQTRJgbAk0M2F/MoiwWudAs73sEt
         OCNSg1HStGM3sL9kweLohxp8hY4RGVg7ee5d5ET9wCbCtA6aRDj8q/XmEWWaK9JRPC0B
         msnfZQdVJV1/QDu0J3B/1Gmrw8/G35N1+hk5W8lDRyFcKAHrUGp3Ncu98+X4ZVnFhhXn
         BsZcAsCUh3+BaFqNln5OfjEv3NbhdnhFnL0o3/jQSFC5IG6dSFxKu7VDhi5OIPR3T/k7
         5CTSpPcSUbvsgWyTeEgt/mFpnFByps2HhJMgcYHCXzD4CK2ZC0mXgUnqYyDJj0kngc2n
         OWVg==
X-Gm-Message-State: AOAM532d2Y4P1bvGU9XC8S+gbw7w3t3sCMGx48bK5fM8VYuNg26Y9yhz
        xLqKqONtBBzdRfkVoNKEHT7lRdMEFsBqAXNA7QyP1yf+eb86
X-Google-Smtp-Source: ABdhPJyZYiNu6GwZpuOrRS1rAR/sZ9tIPJUCZuurIg9PNiGfqGcVTVcL64VyimeR6S1zJyehjbQx4l0sAKZ8TvL3twhsrHl52NIJ
MIME-Version: 1.0
X-Received: by 2002:a92:d48e:: with SMTP id p14mr23282855ilg.259.1599550343103;
 Tue, 08 Sep 2020 00:32:23 -0700 (PDT)
Date:   Tue, 08 Sep 2020 00:32:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000049a305aec856c6@google.com>
Subject: general protection fault in page_mkclean_one
From:   syzbot <syzbot+4d44c88e23baffecc385@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e28f0104 Merge tag 'fixes-2020-09-03' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1702c9e1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=4d44c88e23baffecc385
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d44c88e23baffecc385@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000a02191d: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x000000005010c8e8-0x000000005010c8ef]
CPU: 1 PID: 8540 Comm: kworker/u4:0 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:mm_has_notifiers include/linux/mmu_notifier.h:277 [inline]
RIP: 0010:mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:451 [inline]
RIP: 0010:page_mkclean_one+0x271/0x6c0 mm/rmap.c:916
Code: 89 41 b8 01 00 00 00 e8 fd b9 b1 ff 48 8b 5c 24 68 58 48 b8 00 00 00 00 00 fc ff df 48 8d bb a8 05 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f9 03 00 00 48 83 bb a8 05 00 00 00 0f 85 37 03
RSP: 0018:ffffc9001875ee60 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 000000005010c340 RCX: ffffffff815a184b
RDX: 000000000a02191d RSI: 0000000000000001 RDI: 000000005010c8e8
RBP: ffffea00017a7740 R08: 0000000000000000 R09: ffffffff8c5f49ff
R10: fffffbfff18be93f R11: 000000000000016e R12: 0000001b30823000
R13: 0000000000001000 R14: ffff88800017c420 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000746918 CR3: 00000002026b8000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rmap_walk_file+0x562/0xbf0 mm/rmap.c:1928
 rmap_walk+0x105/0x190 mm/rmap.c:1946
 page_mkclean+0x21c/0x2b0 mm/rmap.c:998
 clear_page_dirty_for_io+0x31f/0x920 mm/page-writeback.c:2698
 mpage_submit_page+0x80/0x2c0 fs/ext4/inode.c:2061
 mpage_process_page_bufs+0x656/0x780 fs/ext4/inode.c:2195
 mpage_prepare_extent_to_map+0x8fa/0xde0 fs/ext4/inode.c:2607
 ext4_writepages+0x90f/0x3960 fs/ext4/inode.c:2735
 do_writepages+0xec/0x290 mm/page-writeback.c:2352
 __writeback_single_inode+0x125/0x1400 fs/fs-writeback.c:1461
 writeback_sb_inodes+0x53d/0xf40 fs/fs-writeback.c:1721
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1790
 wb_writeback+0x8bb/0xd40 fs/fs-writeback.c:1896
 wb_check_old_data_flush fs/fs-writeback.c:1998 [inline]
 wb_do_writeback fs/fs-writeback.c:2051 [inline]
 wb_workfn+0x8f5/0x13e0 fs/fs-writeback.c:2080
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace aa72a7d82af80156 ]---
RIP: 0010:mm_has_notifiers include/linux/mmu_notifier.h:277 [inline]
RIP: 0010:mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:451 [inline]
RIP: 0010:page_mkclean_one+0x271/0x6c0 mm/rmap.c:916
Code: 89 41 b8 01 00 00 00 e8 fd b9 b1 ff 48 8b 5c 24 68 58 48 b8 00 00 00 00 00 fc ff df 48 8d bb a8 05 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f9 03 00 00 48 83 bb a8 05 00 00 00 0f 85 37 03
RSP: 0018:ffffc9001875ee60 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 000000005010c340 RCX: ffffffff815a184b
RDX: 000000000a02191d RSI: 0000000000000001 RDI: 000000005010c8e8
RBP: ffffea00017a7740 R08: 0000000000000000 R09: ffffffff8c5f49ff
R10: fffffbfff18be93f R11: 000000000000016e R12: 0000001b30823000
R13: 0000000000001000 R14: ffff88800017c420 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbc5e0b6d70 CR3: 00000000a3ffa000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
