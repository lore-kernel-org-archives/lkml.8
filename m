Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BB3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509E5206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgGOIjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:39:19 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51267 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbgGOIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:39:18 -0400
Received: by mail-io1-f72.google.com with SMTP id l1so944652ioh.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X50zSFlWOsBbnGGaGGIgEhrXhN4UntpAF5C1oBx9MYs=;
        b=GYxjZvk4TDZ9ACWWS9c71iYVx1eSYR08vSiNwql2naU/QEQabu71vhsSKzhtQhI+ak
         HUsSZYNByGCI7GPGw3up5+v0oFGcH16YhLxlI39ZoUD74mhtQhQlwKnRAVm93JqfzO1L
         V1R61YyzByoBXL7lhuL608luDaWqScO6zP/RgK+d18hbCVlBSDy1LAnrVHsNS3DznclG
         gZJ4gOAU/W6opZDGmH8m7eON7usx9n2M5J3P9E4ltEo4Ky2QLfnvKQOH+ltY01BhUjhH
         HeppSYK+zGRXEH4ZcSCzQAOsIiboCUADqk29nb9dhmgbFQJk9gxiReKHPRZmgvC/nXhN
         kCAg==
X-Gm-Message-State: AOAM530xmbf3pODvJjTQYVkSRAAfsUHXPgesEqeYejOFSkPy0g6T8V6A
        k183fI4AFYUysqpxT+bRAPmRS5yOMVKgHTovgCEgPTYGK/6R
X-Google-Smtp-Source: ABdhPJyFSqYEGOij/2d2gRAgBYTTNAvoJfPacGxhsMgIpHLdOUDDPeG4AeOMpxQVXQBcvyYcDGWpH3dXO8ZI3tqHxnFQj6EqYi7Y
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:682:: with SMTP id o2mr8155784ils.188.1594802357332;
 Wed, 15 Jul 2020 01:39:17 -0700 (PDT)
Date:   Wed, 15 Jul 2020 01:39:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fef5a905aa76dbf9@google.com>
Subject: memory leak in create_pipe_files
From:   syzbot <syzbot+6a137efd811917e8b53c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a581387e Merge tag 'io_uring-5.8-2020-07-10' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ba1967100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13a9cfc3f50ff96
dashboard link: https://syzkaller.appspot.com/bug?extid=6a137efd811917e8b53c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d2004f100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a137efd811917e8b53c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812a6c8800 (size 256):
  comm "syz-execprog", pid 6479, jiffies 4295096411 (age 83.520s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    20 2d 85 2a 81 88 ff ff 80 57 d2 15 81 88 ff ff   -.*.....W......
  backtrace:
    [<00000000057eb446>] kmem_cache_zalloc include/linux/slab.h:659 [inline]
    [<00000000057eb446>] __alloc_file+0x23/0x120 fs/file_table.c:101
    [<0000000046b459a4>] alloc_empty_file+0x4f/0xe0 fs/file_table.c:151
    [<00000000fced1caf>] alloc_file+0x31/0x160 fs/file_table.c:193
    [<0000000079549d8a>] alloc_file_pseudo+0xae/0x120 fs/file_table.c:233
    [<0000000058a70f71>] create_pipe_files+0x127/0x270 fs/pipe.c:931
    [<00000000ad5d09be>] __do_pipe_flags fs/pipe.c:964 [inline]
    [<00000000ad5d09be>] do_pipe2+0x43/0x110 fs/pipe.c:1012
    [<0000000038960906>] __do_sys_pipe2 fs/pipe.c:1030 [inline]
    [<0000000038960906>] __se_sys_pipe2 fs/pipe.c:1028 [inline]
    [<0000000038960906>] __x64_sys_pipe2+0x16/0x20 fs/pipe.c:1028
    [<00000000b1b64f40>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
    [<00000000e3fac4b7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812a7abb80 (size 16):
  comm "syz-execprog", pid 6479, jiffies 4295096411 (age 83.520s)
  hex dump (first 16 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000029e2bcd5>] kmem_cache_zalloc include/linux/slab.h:659 [inline]
    [<0000000029e2bcd5>] lsm_file_alloc security/security.c:567 [inline]
    [<0000000029e2bcd5>] security_file_alloc+0x2e/0xc0 security/security.c:1455
    [<00000000884a9f66>] __alloc_file+0x61/0x120 fs/file_table.c:106
    [<0000000046b459a4>] alloc_empty_file+0x4f/0xe0 fs/file_table.c:151
    [<00000000fced1caf>] alloc_file+0x31/0x160 fs/file_table.c:193
    [<0000000079549d8a>] alloc_file_pseudo+0xae/0x120 fs/file_table.c:233
    [<0000000058a70f71>] create_pipe_files+0x127/0x270 fs/pipe.c:931
    [<00000000ad5d09be>] __do_pipe_flags fs/pipe.c:964 [inline]
    [<00000000ad5d09be>] do_pipe2+0x43/0x110 fs/pipe.c:1012
    [<0000000038960906>] __do_sys_pipe2 fs/pipe.c:1030 [inline]
    [<0000000038960906>] __se_sys_pipe2 fs/pipe.c:1028 [inline]
    [<0000000038960906>] __x64_sys_pipe2+0x16/0x20 fs/pipe.c:1028
    [<00000000b1b64f40>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
    [<00000000e3fac4b7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
