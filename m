Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7364BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:50:19 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480E1206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480E1206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgDMHuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:50:14 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1CDC008651
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:50:12 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o9so9906389ila.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tQceCnQqY/aLl6gDcc2Z8ka0DsHJea8y/PyAYUwdDBo=;
        b=F9Vcfmh2HyTtmStoooa5T+exLM+P1JeKcFL2QYM/GD9sRHnzM9NOG7S19JCdWSRyKI
         0CBLnaXbwZgyt11lc0z8P6gsbutm85LvTehGd4hlxRq56CqjUBLbmFtXvFekjAJ8dnnk
         us/jfZ7EqbKM/lsRi2Wq1xDJ8nA1qyKtshwoJYSV3gk1NeGJmrikA2sAEENx8X5Yf5hZ
         SU83oPJc9Qypl3lJjLlLiDlWwh3QU4RZl3ZzgRhgZU3yWRWq0JyTMt3Q1wQw/+Ww9rC1
         WsyJ5VVJt4l7Qv3M6dlkLmqUbHTVXOgK/DOdVJH+t5I3wxxISLdlNzpSLhLlHLWKYriu
         kstg==
X-Gm-Message-State: AGi0PuY0eudDXZ26LKM7lS9LUPqAvPOi5ENoY5c4FzATPccAjdKgTvOM
        Fry5VN5Mzf/P2H33wPVMhYOgapSTW1qbm6LRZF/Xom2yj3Uy
X-Google-Smtp-Source: APiQypISXdqIE1ACm9Pt4Gp4cIPdcjo8s87kQ9UckHNBghw8x2QbCK3u34EouEW1uUL7J09ZNzZaOG8xQTmvvtzo0S+ce2PGrtz1
MIME-Version: 1.0
X-Received: by 2002:a02:1444:: with SMTP id 65mr15475150jag.84.1586764211610;
 Mon, 13 Apr 2020 00:50:11 -0700 (PDT)
Date:   Mon, 13 Apr 2020 00:50:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ce79705a3275559@google.com>
Subject: WARNING in unaccount_page_cache_page (2)
From:   syzbot <syzbot+2854d22c7dd957a6519a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae46d2aa mm/gup: Let __get_user_pages_locked() return -EIN..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b60343e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca75979eeebf06c2
dashboard link: https://syzkaller.appspot.com/bug?extid=2854d22c7dd957a6519a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2854d22c7dd957a6519a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8402 at mm/filemap.c:222 unaccount_page_cache_page+0x631/0xd60 mm/filemap.c:222
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8402 Comm: syz-executor.4 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:unaccount_page_cache_page+0x631/0xd60 mm/filemap.c:222
Code: 02 00 0f 85 3a 06 00 00 48 8b 1b 31 ff 48 c1 eb 03 83 e3 01 48 89 de e8 9d 01 e2 ff 48 85 db 0f 84 d9 fb ff ff e8 ff ff e1 ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02
RSP: 0018:ffffc90001287688 EFLAGS: 00010012
RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc90011a34000
RDX: 000000000000ec1b RSI: ffffffff81913191 RDI: 0000000000000007
RBP: ffffea0001165dc0 R08: ffff88804a3ce240 R09: fffff9400022cbb9
R10: ffffea0001165dc7 R11: fffff9400022cbb8 R12: 0000000000000000
R13: ffff8880a3f6bbe0 R14: ffffea0001165dc0 R15: ffffea00022cd088
 delete_from_page_cache_batch+0x1a6/0xec0 mm/filemap.c:355
 truncate_inode_pages_range+0x58b/0x1760 mm/truncate.c:366
 kill_bdev+0xd1/0x100 fs/block_dev.c:87
 loop_set_status+0x315/0x1370 drivers/block/loop.c:1272
 loop_set_status_old+0x223/0x310 drivers/block/loop.c:1468
 lo_ioctl+0x308/0x1410 drivers/block/loop.c:1612
 __blkdev_driver_ioctl block/ioctl.c:322 [inline]
 blkdev_ioctl+0x25b/0x660 block/ioctl.c:718
 block_ioctl+0xf9/0x140 fs/block_dev.c:1996
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f83d100ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f83d100b6d4 RCX: 000000000045c889
RDX: 0000000020000440 RSI: 0000000000004c02 RDI: 0000000000000003
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000003f4 R14: 00000000004c6902 R15: 000000000076bf0c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
