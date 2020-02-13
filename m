Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BBC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F7E2468D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgBMShS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:37:18 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:47219 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgBMShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:37:16 -0500
Received: by mail-il1-f198.google.com with SMTP id x69so5403460ill.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YuPsOWJwIe7j4ErfOTb4wvXqjMiulfvWkaoJ9fXFBIQ=;
        b=qdU7K4t5cJVmv2CFaG7Dn1RWfUZe912BvIPWeeYh3YisBwOZ4ZB3kmdW0TXR5MzaU8
         qBD5Al8b/hTfZwL5AzR4U0TrD3ad+MyppAuPpLMgMMHj5XxFAHvMltBu+6PhXN24tPI2
         AupLBiR6Su2ajrChbA0XMlCgI1c5i3FgtAlfdTf5gLkrtpRm6coQk0X+dqxKal+EqdCT
         Ua2bO35uECpJ9eSX3KZ928/IbXcEUrl6dVwbGh6kGWhc0Y1wQqkno5oQ7EjkL7lwpGdn
         MM7LQt8ZTOu9RxqYYgCU6mbYMWKJB7kMx/MX/vHsyM4ls7a3ViGjExHq3HvfoGdJKwlM
         SNuA==
X-Gm-Message-State: APjAAAVfcKtCNY12+FY9dbGejLfTrRVJNqplzqRTaNde4dFayF/lLB7h
        NrQc4e+h/Swkr06nq+kUYWE2/AuFMU7NkPdkY5dkcuRDdKEi
X-Google-Smtp-Source: APXvYqz89wKEGmaLK6G5YFczowofcRv6LajhASBZD2WVu+tUgjtZe8UMk3YhcJPuKgKKpzWvhZoxXF5tlFlpgkIR6nAbhxPAdw4c
MIME-Version: 1.0
X-Received: by 2002:a92:508:: with SMTP id q8mr17057457ile.187.1581619034187;
 Thu, 13 Feb 2020 10:37:14 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:37:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3eccd059e7960d5@google.com>
Subject: KASAN: null-ptr-deref Read in do_con_trol
From:   syzbot <syzbot+70b2d05eec48639a904e@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        okash.khawaja@gmail.com, oleksandr@redhat.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f2850dd5 Merge tag 'kbuild-fixes-v5.6' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16afe07ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=735296e4dd620b10
dashboard link: https://syzkaller.appspot.com/bug?extid=70b2d05eec48639a904e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154ac65ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d296b5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+70b2d05eec48639a904e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in memcpy include/linux/string.h:381 [inline]
BUG: KASAN: null-ptr-deref in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: null-ptr-deref in delete_char drivers/tty/vt/vt.c:852 [inline]
BUG: KASAN: null-ptr-deref in csi_P drivers/tty/vt/vt.c:1985 [inline]
BUG: KASAN: null-ptr-deref in do_con_trol+0x3b9/0x61b0 drivers/tty/vt/vt.c:2379
Read of size 4294967294 at addr 0000000000000012 by task syz-executor841/9673

CPU: 0 PID: 9673 Comm: syz-executor841 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 __kasan_report.cold+0x5/0x32 mm/kasan/report.c:510
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
 memcpy+0x24/0x50 mm/kasan/common.c:127
 memcpy include/linux/string.h:381 [inline]
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 delete_char drivers/tty/vt/vt.c:852 [inline]
 csi_P drivers/tty/vt/vt.c:1985 [inline]
 do_con_trol+0x3b9/0x61b0 drivers/tty/vt/vt.c:2379
 do_con_write.part.0+0xfd9/0x1ef0 drivers/tty/vt/vt.c:2797
 do_con_write drivers/tty/vt/vt.c:2565 [inline]
 con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
 __vfs_write+0x8a/0x110 fs/read_write.c:494
 vfs_write+0x268/0x5d0 fs/read_write.c:558
 ksys_write+0x14f/0x290 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:620
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4404f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffefa71b898 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404f9
RDX: 0000000000000078 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
