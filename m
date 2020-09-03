Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3332C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AE820C09
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgICTJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:09:26 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33923 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICTJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:09:24 -0400
Received: by mail-il1-f197.google.com with SMTP id m1so3086591ilg.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 12:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uBpBVzNEbGOirS4mN6gzFgGQyv3QijJgsotogQt7CMY=;
        b=rs9MAT+Di4ta4D+5glm/LvhJe9iNMVxS+m3w9YkNv91I0x7b4Uh7Zv7SvG0TlNNTn0
         Qxis1XXn+Y8HHNFJWGzFwy3wrs9qnoCrfIROfQtcNCRwgpbmG7xsyk514n7ZmfxzlE+U
         RWrYYlsxRDCCjXu74UlsMuHn86LOPpu5AMFCl2OuoW2fqZbkOb+oABaYpMQGpgoFnhsE
         CCoLL6CVkfBdjmdPpGtfXq6Aa5q9m3dhqmd/i5okNWP8myc3wdRA2Gr1xAcfyQ0SRzB2
         mdDB1aKoYlZ30q0uLUW8BSB+JqJGT9eRS3nA+lORWI8dLmLG90yiLHMRXEtwSG3N4w5Q
         gcFA==
X-Gm-Message-State: AOAM531PtHV2+MixJUKzb2e/dpwfqI0N4HgkmDcE9a88R7Siw9dHaRNF
        cOPfOFlmju27y+A2RI402E2taqJ3kNIKyMubFVJM+czxpdmO
X-Google-Smtp-Source: ABdhPJwebxKrtAoIt0X2/l6P1mBqaKwli0ZcJtLMZ+adp72mZiHonV3mZ+GimBk+dQhl+X8gIB1H8RrEil7X6B61mzVeL2419bcS
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168a:: with SMTP id s10mr2096516iow.46.1599160163022;
 Thu, 03 Sep 2020 12:09:23 -0700 (PDT)
Date:   Thu, 03 Sep 2020 12:09:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074bbdd05ae6d7d35@google.com>
Subject: kernel BUG at mm/mmap.c:LINE!
From:   syzbot <syzbot+721b657f8f01708b291b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1127b219 Merge tag 'fallthrough-fixes-5.9-rc3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136d098e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=721b657f8f01708b291b
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+721b657f8f01708b291b@syzkaller.appspotmail.com

start_brk 558decf56000 brk 558ded160000 start_stack 7ffd20847a70
arg_start 7ffd20847e89 arg_end 7ffd20847ea4 env_start 7ffd20847ea4 env_end 7ffd20847fdd
binfmt ffffffff89cdcb60 flags 200cd core_state 0000000000000000
ioctx_table 0000000000000000
------------[ cut here ]------------
kernel BUG at mm/mmap.c:427!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 28867 Comm: systemd-udevd Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:validate_mm+0x617/0x800 mm/mmap.c:427
Code: cf f5 cd ff 44 89 e6 bf ff ff ff ff e8 42 f2 cd ff 41 83 fc ff 0f 85 86 1b 01 00 e8 b3 f5 cd ff 48 8b 7c 24 18 e8 d9 59 fc ff <0f> 0b e8 a2 f5 cd ff 48 8b 54 24 28 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90015d6fd98 EFLAGS: 00010286
RAX: 000000000000038d RBX: 000000000000004f RCX: 0000000000000000
RDX: ffff8880475ac380 RSI: ffffffff815dafc7 RDI: fffff52002badf52
RBP: 0000000000000000 R08: 000000000000038d R09: ffff8880ae6318e7
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fb1b935a8c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd20959990 CR3: 0000000217691000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 remove_vma_list mm/mmap.c:2616 [inline]
 __do_munmap+0x899/0x1170 mm/mmap.c:2869
 __vm_munmap+0xe6/0x180 mm/mmap.c:2889
 __do_sys_munmap mm/mmap.c:2915 [inline]
 __se_sys_munmap mm/mmap.c:2911 [inline]
 __x64_sys_munmap+0x62/0x80 mm/mmap.c:2911
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fb1b81d66e7
Code: c7 c0 ff ff ff ff eb 8d 48 8b 15 ac 47 2b 00 f7 d8 64 89 02 e9 5b ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 47 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd20846cd8 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000558decf56100 RCX: 00007fb1b81d66e7
RDX: 0000000000000080 RSI: 000000000080ccec RDI: 00007fb1b7064000
RBP: 0000558debda4d18 R08: 0000558decf6a3c0 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 0000558decf560e0
R13: 0000000000000000 R14: 0000000000000003 R15: 000000000000000e
Modules linked in:
---[ end trace 76a00ebdfa09cc52 ]---
RIP: 0010:validate_mm+0x617/0x800 mm/mmap.c:427
Code: cf f5 cd ff 44 89 e6 bf ff ff ff ff e8 42 f2 cd ff 41 83 fc ff 0f 85 86 1b 01 00 e8 b3 f5 cd ff 48 8b 7c 24 18 e8 d9 59 fc ff <0f> 0b e8 a2 f5 cd ff 48 8b 54 24 28 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90015d6fd98 EFLAGS: 00010286
RAX: 000000000000038d RBX: 000000000000004f RCX: 0000000000000000
RDX: ffff8880475ac380 RSI: ffffffff815dafc7 RDI: fffff52002badf52
RBP: 0000000000000000 R08: 000000000000038d R09: ffff8880ae6318e7
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fb1b935a8c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fad09fed000 CR3: 0000000217691000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
