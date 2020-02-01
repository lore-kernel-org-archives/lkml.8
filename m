Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E020DC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 04:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB0206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 04:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgBAEsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 23:48:12 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56637 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgBAEsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 23:48:12 -0500
Received: by mail-il1-f200.google.com with SMTP id p67so7025535ili.23
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 20:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SEeNty7ieQYVMzdwLC9UXgnfqQzHbN2HZfwCJjtdhx8=;
        b=C13u3hYjV1qmpWZJQ9TIugroF0dU4pE7D0OuAtyw1dFoerhBT3B00aYYINDpwZct6H
         g7nF0QZeVzz7cY4ZY2tBA+Fp2LOMftAekFzZkCS2ndvl+Y42T2Mxd69jMcY+6ElvPudj
         c+Wh1OTgaxDhLjyEh5oLPFWnOTlQ9ya3SyyJgRzwuT+c/ZqJ9Qgs31Pz+yYVkUVHvY4n
         JN1RAtnSvmKfxJZOW0K3NJ4I8q3ZruPjKy/X8AuOdEnykAjpw58mJW7rxvYR1aasc0HH
         T6PjqQ8/RBdSHAkmCFUdiEo5XC43SjRs7AdczuFXtQuslDrdJKrSRXOFiaFoVlEOKRi5
         aOHw==
X-Gm-Message-State: APjAAAW720YebWH5wa9eLhHQUe5KVgqmBAayiGX9ywf/OyOdNmJl0+aj
        eDG7nm3wh9n9o5Geu0y7d1EnLGX5vG83v/oTIJJRREWQT0vo
X-Google-Smtp-Source: APXvYqzUWL70AJeBQVsw6MmzT03qoz0Obt/Dw//TSkPQfW+rJleld2ThxEeYbJzUQC25k/pwWjC653oBplWnbHyBmezlrgfxalch
MIME-Version: 1.0
X-Received: by 2002:a92:8311:: with SMTP id f17mr6066224ild.82.1580532491690;
 Fri, 31 Jan 2020 20:48:11 -0800 (PST)
Date:   Fri, 31 Jan 2020 20:48:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b926cf059d7c6552@google.com>
Subject: general protection fault in path_openat
From:   syzbot <syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ccaaaf6f Merge tag 'mpx-for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115bda4ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=879390c6b09ccf66
dashboard link: https://syzkaller.appspot.com/bug?extid=190005201ced78a74ad6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1674c776e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1565e101e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3515 Comm: modprobe Not tainted 5.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:do_last fs/namei.c:3336 [inline]
RIP: 0010:path_openat+0x281/0x3460 fs/namei.c:3607
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 76 29 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5c 24 58 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 28
RSP: 0018:ffffc90003c37a40 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c24369
RDX: 0000000000000000 RSI: ffffffff81c24376 RDI: 0000000000000004
RBP: ffffc90003c37b90 R08: ffff88809dca63c0 R09: ffffed1015416ca2
R10: ffffed1015416ca1 R11: ffff8880aa0b6508 R12: ffff8880aa0b64a0
R13: ffff88809dca63c0 R14: ffffc90003c37d98 R15: ffffc90003c37bd0
FS:  00007f70d677c700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000009a184000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_filp_open+0x192/0x260 fs/namei.c:3637
 do_sys_openat2+0x5eb/0x7e0 fs/open.c:1149
 do_sys_open+0xf2/0x180 fs/open.c:1165
 ksys_open include/linux/syscalls.h:1386 [inline]
 __do_sys_open fs/open.c:1171 [inline]
 __se_sys_open fs/open.c:1169 [inline]
 __x64_sys_open+0x7e/0xc0 fs/open.c:1169
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f70d6094120
Code: 48 8b 15 1b 4d 2b 00 f7 d8 64 89 02 83 c8 ff c3 90 90 90 90 90 90 90 90 90 90 83 3d d5 a4 2b 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 5e 8c 01 00 48 89 04 24
RSP: 002b:00007ffdbe2762c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000558ff35f3240 RCX: 00007f70d6094120
RDX: 00007ffdbe2764fc RSI: 0000000000080000 RDI: 00007ffdbe2764e0
RBP: 00007f70d6564300 R08: 0000000000000000 R09: 0000558ff35f3219
R10: 0000000000000000 R11: 0000000000000246 R12: 0000558ff35eb210
R13: 0000558ff35f3210 R14: 0000558ff35eb210 R15: 00007ffdbe2764e0
Modules linked in:
---[ end trace bdc3fba9ce9969a3 ]---
RIP: 0010:do_last fs/namei.c:3336 [inline]
RIP: 0010:path_openat+0x281/0x3460 fs/namei.c:3607
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 76 29 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5c 24 58 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 28
RSP: 0018:ffffc90003c37a40 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c24369
RDX: 0000000000000000 RSI: ffffffff81c24376 RDI: 0000000000000004
RBP: ffffc90003c37b90 R08: ffff88809dca63c0 R09: ffffed1015416ca2
R10: ffffed1015416ca1 R11: ffff8880aa0b6508 R12: ffff8880aa0b64a0
R13: ffff88809dca63c0 R14: ffffc90003c37d98 R15: ffffc90003c37bd0
FS:  00007f70d677c700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdd12577518 CR3: 000000009a184000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
