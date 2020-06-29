Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54BBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89F02076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390168AbgF2VCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730965AbgF2TMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:52 -0400
Received: from mail-io1-xd46.google.com (mail-io1-xd46.google.com [IPv6:2607:f8b0:4864:20::d46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC8DC08E6DC
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:56:16 -0700 (PDT)
Received: by mail-io1-xd46.google.com with SMTP id i5so1458875iow.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7UR4veMVO94msNsRyMPSIg+uNPusi34riys9/+FERgY=;
        b=VZhPmg8jqDG5M8N3/MB5JLBV0kClow3VV9DoU5jNh7Gn+tPuPBN5uvjfwcf97gD4nB
         U2xNejSsRHy40pMomq6GB6tQ8nSfKmZ8lvj6h6rY1lLUHeBq8d4+TdBEwJJk9UCeC5Ww
         pCbaBRBo7IXHTzq5mW1m53c8hp+nbHZ39H/uJtTwfqGf5yfMRD9/Rh6FCFL6S7IWymUH
         MDM54geImed+MEDR2aNxq50Hcsj1+fkZ65DuEWB3PncbQkDqA3gQ1/nqOHmnFJp1x/34
         J6ZZNng5gqKP6Hel7vs1/5eugmfTBQtfDjVC2nDR+SY76k4IbmnRiiRDfNqKNjVM3fRz
         ThmQ==
X-Gm-Message-State: AOAM533uLAcxgLz3wD841EbZRa4qyrlZvmj6SABIjsQ0nh71igWRkEyj
        o8gJpKADJl+mYi+IE0RUzlQEPrqC/QaYts40ST8dtGzkYc4V
X-Google-Smtp-Source: ABdhPJxcCO85VG9jOjxVOCCibWirWcudltftil7cwcErqtjR0I74qEPPMjqadEUKLw5tmalZI83D6VWFASuSqo7TOlDHTTfabJgb
MIME-Version: 1.0
X-Received: by 2002:a92:c0c8:: with SMTP id t8mr3168667ilf.229.1593406576031;
 Sun, 28 Jun 2020 21:56:16 -0700 (PDT)
Date:   Sun, 28 Jun 2020 21:56:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f27eba05a931e09d@google.com>
Subject: KASAN: user-memory-access Read in do_con_write (2)
From:   syzbot <syzbot+63ca998c125cfe13c6a5@syzkaller.appspotmail.com>
To:     ebiggers@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4e99b321 Merge tag 'nfs-for-5.8-2' of git://git.linux-nfs...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14747dc5100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=63ca998c125cfe13c6a5
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+63ca998c125cfe13c6a5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in memcpy include/linux/string.h:406 [inline]
BUG: KASAN: user-memory-access in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: user-memory-access in delete_char drivers/tty/vt/vt.c:858 [inline]
BUG: KASAN: user-memory-access in csi_P drivers/tty/vt/vt.c:2013 [inline]
BUG: KASAN: user-memory-access in do_con_trol drivers/tty/vt/vt.c:2407 [inline]
BUG: KASAN: user-memory-access in do_con_write+0x6f90/0x7400 drivers/tty/vt/vt.c:2823
Read of size 118 at addr 00000000ffffff9a by task syz-executor.4/10580

CPU: 0 PID: 10580 Comm: syz-executor.4 Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x20/0x60 mm/kasan/common.c:105
 memcpy include/linux/string.h:406 [inline]
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 delete_char drivers/tty/vt/vt.c:858 [inline]
 csi_P drivers/tty/vt/vt.c:2013 [inline]
 do_con_trol drivers/tty/vt/vt.c:2407 [inline]
 do_con_write+0x6f90/0x7400 drivers/tty/vt/vt.c:2823
 con_write+0x22/0xb0 drivers/tty/vt/vt.c:3159
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x3ce/0xf80 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x4d9/0x870 drivers/tty/tty_io.c:1046
 __vfs_write+0x76/0x100 fs/read_write.c:495
 vfs_write+0x268/0x5d0 fs/read_write.c:559
 ksys_write+0x12d/0x250 fs/read_write.c:612
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb19
Code: Bad RIP value.
RSP: 002b:00007fcc7ee74c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000050e080 RCX: 000000000045cb19
RDX: 0000000000000320 RSI: 00000000200001c0 RDI: 0000000000000007
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000d2a R14: 00000000004cf845 R15: 00007fcc7ee756d4
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
