Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B31C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7040020721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403977AbgDCMfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:35:16 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35684 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403965AbgDCMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:35:14 -0400
Received: by mail-io1-f72.google.com with SMTP id c10so5907968ioc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9i6KFf8WUAlZJA8NaxnAVF5EgcrymN6UAh6zvSpVWlU=;
        b=VlLULW3+MNtgQ+xQQEuGYWFGrQyPuLOm/gzkvqPi+4Z7pFj5eF/YxyYGjGM2Ka+5bO
         n76lto/WKiCC3c5QWNzcMwjV9dBlSCQLg2lwniHnLFR9Z++J2YphGzdeR9nthOSt9o4k
         aw15hd5vatsxOsNWPJIrwe1cjYgxWVb9EnvDx0VOWzgaHYXTA0OaCp3YZ7yYqAiCI6lR
         zgkZc3CkTwG3DLvSA2Iu9NknJ2kzosLNv4+c9oMiHMace7hiwZ3jr8rh8U5V4gZEOwdJ
         8BKPu3yGRxyCE2FYMWGD94dsEWXFtTHPm5K3w9HaCiofRFPRtolix57QK0ClEx8jM3Dh
         1zVw==
X-Gm-Message-State: AGi0PuY5OTyji57+GTOElQgs0erxrAaTe2mV6ExhrYkpAKlKutYzNfbD
        sdYU6vRd4kw4sphFh43jpIh5xBivyPAkWZSQRWkBsuZbDVc3
X-Google-Smtp-Source: APiQypKXPAosbIPldoa5yp5n5oDNa/0NJcZ/JuFc+bCwocwk/C4fvhskYbi+ZTbJyJC4peWtusiAOlVC9sGWh8CnEB7ZfZ5M1JRF
MIME-Version: 1.0
X-Received: by 2002:a5e:8a4d:: with SMTP id o13mr7561447iom.31.1585917312640;
 Fri, 03 Apr 2020 05:35:12 -0700 (PDT)
Date:   Fri, 03 Apr 2020 05:35:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000102ba005a2622624@google.com>
Subject: KCSAN: data-race in binder_dec_node_nilocked / binder_state_show
From:   syzbot <syzbot+71f39766a98dddab97b5@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        elver@google.com, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, syzkaller-bugs@googlegroups.com,
        tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    245a4300 Merge branch 'rcu/kcsan' into tip/locking/kcsan
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=106b67f1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4b9db179318d21f
dashboard link: https://syzkaller.appspot.com/bug?extid=71f39766a98dddab97b5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+71f39766a98dddab97b5@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in binder_dec_node_nilocked / binder_state_show

write to 0xffff88809f276954 of 4 bytes by task 1408 on cpu 0:
 binder_state_show+0xd8/0x260 drivers/android/binder.c:5938
 seq_read+0x350/0x9d0 fs/seq_file.c:229
 full_proxy_read+0xbd/0x100 fs/debugfs/file.c:220
 do_loop_readv_writev fs/read_write.c:714 [inline]
 do_loop_readv_writev fs/read_write.c:701 [inline]
 do_iter_read+0x357/0x3d0 fs/read_write.c:935
 vfs_readv+0x9c/0xf0 fs/read_write.c:997
 do_preadv+0x131/0x1d0 fs/read_write.c:1089
 __do_sys_preadv fs/read_write.c:1139 [inline]
 __se_sys_preadv fs/read_write.c:1134 [inline]
 __x64_sys_preadv+0x61/0x80 fs/read_write.c:1134
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff88809f276954 of 4 bytes by task 1416 on cpu 1:
 binder_dec_node_nilocked+0x382/0x610 drivers/android/binder.c:1261
 binder_dec_node_tmpref+0xa3/0x120 drivers/android/binder.c:1379
 binder_put_node drivers/android/binder.c:1387 [inline]
 binder_state_show+0x1aa/0x260 drivers/android/binder.c:5950
 seq_read+0x350/0x9d0 fs/seq_file.c:229
 full_proxy_read+0xbd/0x100 fs/debugfs/file.c:220
 do_loop_readv_writev fs/read_write.c:714 [inline]
 do_loop_readv_writev fs/read_write.c:701 [inline]
 do_iter_read+0x357/0x3d0 fs/read_write.c:935
 vfs_readv+0x9c/0xf0 fs/read_write.c:997
 do_preadv+0x131/0x1d0 fs/read_write.c:1089
 __do_sys_preadv fs/read_write.c:1139 [inline]
 __se_sys_preadv fs/read_write.c:1134 [inline]
 __x64_sys_preadv+0x61/0x80 fs/read_write.c:1134
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 1416 Comm: syz-executor.1 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
