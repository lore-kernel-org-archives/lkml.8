Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88320C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B18B2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgG2VeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:34:23 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46845 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:34:22 -0400
Received: by mail-io1-f69.google.com with SMTP id n1so3669746ion.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SBci7a5McQ4HLstQc3jrus8wwIympT0MXoOHI9RYxPM=;
        b=KY5WjWuhTmdrG/vtjh2cMYzyyDEw9/QNTHQM08Vrzk7/A1J6oSdJaUJh5phXLJozSa
         vGWl4N/2qbas2kcsRTGM0g9RZL8+VKWZXKEo8TQe/BItFA3wh2me8QkeU6h0EukTC7c9
         q12IL0NA9gSytBLotvyyA+jML9y78BY7O1x6Qd0NqUea4UGXuHqCax1+CwNiPIQi970R
         hnZBz149/4rTOu7ldGZ+/g9C0B3nLUTU8YqNrZ776tTboJb6PabWC00l/W2F9zWY31Pb
         nLa1eqNgC4V7TJa7xfwAQK2Cr/fMqU/3fb1I3q5/91WUPSFFtIHlwNg/lYZryZMFuozV
         UUsw==
X-Gm-Message-State: AOAM530Mt5tbpjI9tQCsOkTp2Q0ZIGvpoylyyWjutWGkB2TXJN6I8ogE
        WifQRULg2zyl1zx+dQD84WZm39VdWiH+BDvLn/T8buSrDa7a
X-Google-Smtp-Source: ABdhPJzhWG6qKoEvK5UQnZJrfoEPA690PyPZfKLPaeZUtrOmC+VXn9PLvCylYCQfXHYTqiIjB9yXAhS8qwhyQSSq3pm5jhE5dA3/
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c01:: with SMTP id w1mr36279869iov.130.1596058462261;
 Wed, 29 Jul 2020 14:34:22 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af1b3b05ab9b51c2@google.com>
Subject: kernel BUG at arch/x86/mm/physaddr.c:LINE! (6)
From:   syzbot <syzbot+dfb45ba0aafa4329fd19@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    23ee3e4e Merge tag 'pci-v5.8-fixes-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c45f78900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=dfb45ba0aafa4329fd19
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfb45ba0aafa4329fd19@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 15249 Comm: syz-executor.4 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__phys_addr+0xa7/0x110 arch/x86/mm/physaddr.c:28
Code: 61 7a 09 4c 89 e3 31 ff 48 d3 eb 48 89 de e8 90 60 3f 00 48 85 db 75 0d e8 e6 63 3f 00 4c 89 e0 5b 5d 41 5c c3 e8 d9 63 3f 00 <0f> 0b e8 d2 63 3f 00 48 c7 c0 10 10 a8 89 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90015be7c18 EFLAGS: 00010216
RAX: 0000000000003629 RBX: 0000000000077000 RCX: ffffc900116ea000
RDX: 0000000000040000 RSI: ffffffff813458b7 RDI: 0000000000000006
RBP: 0000000080077000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080077000 R11: 0000000000000000 R12: 0000778000077000
R13: ffffc90015be7c70 R14: 0000000000000000 R15: 0000000000000286
FS:  0000000000000000(0000) GS:ffff8880ae700000(0063) knlGS:00000000f5db6b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000055bcdd3fe588 CR3: 0000000070105000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 virt_to_head_page include/linux/mm.h:841 [inline]
 qlink_to_cache mm/kasan/quarantine.c:128 [inline]
 qlist_free_all+0xbb/0x140 mm/kasan/quarantine.c:164
 quarantine_reduce+0x17e/0x200 mm/kasan/quarantine.c:260
 __kasan_kmalloc.constprop.0+0x9e/0xd0 mm/kasan/common.c:475
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x12c/0x3b0 mm/slab.c:3484
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 sock_alloc_file+0x4f/0x190 net/socket.c:411
 sock_map_fd net/socket.c:435 [inline]
 __sys_socket+0x13d/0x200 net/socket.c:1525
 __do_sys_socket net/socket.c:1530 [inline]
 __se_sys_socket net/socket.c:1528 [inline]
 __ia32_sys_socket+0x6f/0xb0 net/socket.c:1528
 do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:428
 __do_fast_syscall_32 arch/x86/entry/common.c:475 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:503
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fbb569
Code: Bad RIP value.
RSP: 002b:00000000f5db60cc EFLAGS: 00000296 ORIG_RAX: 0000000000000167
RAX: ffffffffffffffda RBX: 000000000000000a RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
