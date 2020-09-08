Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3680AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102AC20658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgIHUFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:05:17 -0400
Received: from mail-pj1-f79.google.com ([209.85.216.79]:40894 "EHLO
        mail-pj1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgIHPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:22:04 -0400
Received: by mail-pj1-f79.google.com with SMTP id a8so2765257pjk.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EenMjJDQD4l521BSE22aNFMR8cwBrKLtkVf6ykDlNRE=;
        b=Hg3LevgYpCzuA2mXYvmuZEZfdWgr+dPKsIQcNDJKj3XdOw9kNAlbZkW43lUHVK6ois
         CLhSJQ91eQ9Sx91LassQ0dnw+AJNQpbaUc4U8SCdY0jBw2jfMwkzIbtmecOoXw5JrgJd
         +l1Md+lsj9XgOsr22o3QURbjfNY1Pdq+kQ/a9QoswNDw3S9C+s3CycpU56oeo1B4wck4
         UhSfk4sIIDdt3BErRRCp48+LtJwBD19bpdn/lGxj1la6zvb/+RlwG4b0OwlKSjlliMXU
         2C5BXol9brZxvfQH1NG5i+m9cy/YFgMsoDBhHzrHJQefP4f2gqNkmlQUo6OY7BOUThdo
         FRbg==
X-Gm-Message-State: AOAM530/u/PCoXdODUbWuiM0Gogzozx8XpGxh9XbKgoQzRtJqzLgy8IX
        L2DL7HSBAp0RfcX1pcFK1kBdyhAfo3uAEr62uZQCKJLAPJDZ
X-Google-Smtp-Source: ABdhPJyf2KV/84UB4xhbQpYyo8oE42Hq7mhrdDmRkbRD1GE42RXW2mA/+3uu+7/RemX/IgzU6FCLCzkrR9bLx6pvtccOxQ7ODCJH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1602:: with SMTP id x2mr6329273iow.22.1599571764913;
 Tue, 08 Sep 2020 06:29:24 -0700 (PDT)
Date:   Tue, 08 Sep 2020 06:29:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7327005aecd52f4@google.com>
Subject: kernel BUG at mm/huge_memory.c:LINE! (2)
From:   syzbot <syzbot+2200e21ff920b6b08faa@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1252b7fe900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=2200e21ff920b6b08faa
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2200e21ff920b6b08faa@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/huge_memory.c:1654!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 25918 Comm: syz-executor.5 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:zap_huge_pmd+0x8cb/0xfa0 mm/huge_memory.c:1654
Code: 24 1c 0f 84 c9 03 00 00 e8 42 2a bd ff 8b 34 24 bf 1d 00 00 00 e8 b5 26 bd ff 48 83 3c 24 1d 0f 84 ac 03 00 00 e8 25 2a bd ff <0f> 0b e8 1e 2a bd ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc90004ac7730 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0770000000000000 RCX: ffffffff81b720cb
RDX: ffff8880985c0200 RSI: ffffffff81b720db RDI: 0000000000000005
RBP: ffffc90004ac7a50 R08: 0000000000000001 R09: ffff888000183827
R10: 000000000000001d R11: 0000000000000000 R12: ffff888000183820
R13: ffff88804d29b900 R14: ffffffff89b63d70 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000016a3b73 CR3: 000000009b476000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 zap_pmd_range mm/memory.c:1182 [inline]
 zap_pud_range mm/memory.c:1224 [inline]
 zap_p4d_range mm/memory.c:1245 [inline]
 unmap_page_range+0x107b/0x2b20 mm/memory.c:1266
 unmap_single_vma+0x198/0x300 mm/memory.c:1311
 unmap_vmas+0x168/0x2e0 mm/memory.c:1343
 exit_mmap+0x2b1/0x530 mm/mmap.c:3183
 __mmput+0x122/0x470 kernel/fork.c:1076
 mmput+0x53/0x60 kernel/fork.c:1097
 exit_mm kernel/exit.c:483 [inline]
 do_exit+0xa8b/0x29f0 kernel/exit.c:793
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: Bad RIP value.
RSP: 002b:00007f290f37fcf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 000000000118cfe8 RCX: 000000000045d5b9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000000000118cfec
RBP: 000000000118cfe0 R08: 000000000000000e R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
R13: 00007ffc935c909f R14: 00007f290f3809c0 R15: 000000000118cfec
Modules linked in:
---[ end trace 9c85984f4836a6e7 ]---
RIP: 0010:zap_huge_pmd+0x8cb/0xfa0 mm/huge_memory.c:1654
Code: 24 1c 0f 84 c9 03 00 00 e8 42 2a bd ff 8b 34 24 bf 1d 00 00 00 e8 b5 26 bd ff 48 83 3c 24 1d 0f 84 ac 03 00 00 e8 25 2a bd ff <0f> 0b e8 1e 2a bd ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc90004ac7730 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0770000000000000 RCX: ffffffff81b720cb
RDX: ffff8880985c0200 RSI: ffffffff81b720db RDI: 0000000000000005
RBP: ffffc90004ac7a50 R08: 0000000000000001 R09: ffff888000183827
R10: 000000000000001d R11: 0000000000000000 R12: ffff888000183820
R13: ffff88804d29b900 R14: ffffffff89b63d70 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000016a3b73 CR3: 000000009b476000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
