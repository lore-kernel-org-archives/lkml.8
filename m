Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF1AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E5520658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgGOPQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:16:27 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48838 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgGOPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:16:26 -0400
Received: by mail-il1-f198.google.com with SMTP id q9so1557403ilt.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cvzvEzl5SbyaMRIX3vQSoIRBxHeTQZefDXQaKYTW9rI=;
        b=XmpBjfMKstbuTmktLBFh+7z3IZ4NFZXbHv55vXq2rzuCadwi/UlNeamEHjRikeKMw0
         ffutbUjrWhH7kIu4nM0zN3IqYv/qivG1MebWMxjF6YlPFMJZzN+3+0os7USCg9/Xk+bG
         N5+ZkLTwLFVJgc2J6MoWf+VD3T56PCxvAL09SUpNYUzzPn2JndeAa8hWiuJ6Q2c5OSXp
         uDV9XysR4qVZW7A0UEezEX0Gcuhi+JbTJSKFEbzhX98/hEL8InFZDrpo/QPUmo1IDbGO
         Bt0JrPR9d6auivALOMSfR/dkiljeow5TEOJLWWtjzEH3F3Q434bn6bZzFCiidvaXcrMz
         GJUA==
X-Gm-Message-State: AOAM530UiPTATj25+iqDPvqN8lfwO0OFsVTrjrLJm3Y53VXXJLAPWNih
        t9mWDaJ0W+S1/Q5xrQSc2CvN3FLtybYxvOJWXqqBSOawpkdQ
X-Google-Smtp-Source: ABdhPJwC0mdxUOHsM6MvCiMdRNKmmAyUq+MPH5KWDmm4HFnGek8r/02UfjDmkpHKDSm0VN4H1xi76E/vw1TQm4/oydZchA+LGqXu
MIME-Version: 1.0
X-Received: by 2002:a6b:ce01:: with SMTP id p1mr10506515iob.19.1594826185918;
 Wed, 15 Jul 2020 08:16:25 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:16:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a4d6505aa7c688a@google.com>
Subject: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read
From:   syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1217a83b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=570eb530a65cd98e
dashboard link: https://syzkaller.appspot.com/bug?extid=0f1e470df6a4316e0a11
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read

write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
 generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246
 generic_file_read_iter+0x7d/0x3e0 mm/filemap.c:2326
 ext4_file_read_iter+0x2d6/0x420 fs/ext4/file.c:74
 call_read_iter include/linux/fs.h:1902 [inline]
 generic_file_splice_read+0x22a/0x310 fs/splice.c:312
 do_splice_to fs/splice.c:870 [inline]
 splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
 do_splice_direct+0xf2/0x170 fs/splice.c:1059
 do_sendfile+0x562/0xb10 fs/read_write.c:1540
 __do_sys_sendfile64 fs/read_write.c:1601 [inline]
 __se_sys_sendfile64 fs/read_write.c:1587 [inline]
 __x64_sys_sendfile64+0xf2/0x130 fs/read_write.c:1587
 do_syscall_64+0x51/0xb0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff8880968747b0 of 8 bytes by task 6334 on cpu 1:
 generic_file_buffered_read+0x11e/0x19e0 mm/filemap.c:2011
 generic_file_read_iter+0x7d/0x3e0 mm/filemap.c:2326
 ext4_file_read_iter+0x2d6/0x420 fs/ext4/file.c:74
 call_read_iter include/linux/fs.h:1902 [inline]
 generic_file_splice_read+0x22a/0x310 fs/splice.c:312
 do_splice_to fs/splice.c:870 [inline]
 splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
 do_splice_direct+0xf2/0x170 fs/splice.c:1059
 do_sendfile+0x562/0xb10 fs/read_write.c:1540
 __do_sys_sendfile64 fs/read_write.c:1601 [inline]
 __se_sys_sendfile64 fs/read_write.c:1587 [inline]
 __x64_sys_sendfile64+0xf2/0x130 fs/read_write.c:1587
 do_syscall_64+0x51/0xb0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 6334 Comm: syz-executor.0 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
