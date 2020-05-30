Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3755D207D5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgE3RFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 13:05:16 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:44592 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3RFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 13:05:15 -0400
Received: by mail-il1-f200.google.com with SMTP id b8so5071014ilr.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 10:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/hsI8GvxQQtajApFw9zLytd5w2edfOHy7b6Mtyz48Fs=;
        b=XomqxpfSub+9RuYvC8/myPSfn4HvybBzIjO1AxmCUGA2rKIY1SPp3LE5aRzfaih8HJ
         JExnoElG9uo4kMV9TNAoKV6dhTP8kEKKJzw3Q/W3IH+jUhi2CyXh8hDr013EcOwwVXv5
         AFDAJscNxZxNkgSa36D9Z33G+7N7jk5HHXaMXscAbTA1yiU/HlFmNYsE2hVB/O8CJ3Fi
         mxWMBYdNZxaLzHeGfwj1UX/7V3xa0L3PfD/I9tq2TVZ9vQ7my82Y4pCA+ScsVnRE8yC5
         TPrrdhRJrEwHMX6SpdKXJLLjppeumxsKwamEovDPJJ0gSLN70Wu4MibohLB/Y8aIiTIL
         o8xw==
X-Gm-Message-State: AOAM531ccSzW39cgs9DL5Xs/mj4PlzwgScWqTTd9IF//XMKm6x/ymQZI
        cWVtW0ghmm5wpdON06QMuHUDDjAvvhvc4x3NjTRjz2KC7OAt
X-Google-Smtp-Source: ABdhPJxf6uF+kPqDGcGxxcIYjKQjMkKHX68upb8GBSKpU5bXRmK1OXwefprV/2P/lBEc74dGsWoHyNQgWmJxvkbKNn63VGulRn9j
MIME-Version: 1.0
X-Received: by 2002:a5e:c318:: with SMTP id a24mr11646847iok.166.1590858314697;
 Sat, 30 May 2020 10:05:14 -0700 (PDT)
Date:   Sat, 30 May 2020 10:05:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc4fd705a6e090e2@google.com>
Subject: kernel BUG at include/linux/swapops.h:LINE!
From:   syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9cb1fd0e Linux 5.7-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1788a54a100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cca7550d53ffa599
dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/swapops.h:197!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 30075 Comm: syz-executor.0 Not tainted 5.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:migration_entry_to_page include/linux/swapops.h:197 [inline]
RIP: 0010:migration_entry_to_page include/linux/swapops.h:190 [inline]
RIP: 0010:pmd_migration_entry_wait+0x5b4/0x660 mm/migrate.c:368
Code: 32 e8 10 9f c0 ff 48 c7 c6 e0 a4 35 88 4c 89 e7 e8 81 a1 ec ff 0f 0b e8 fa 9e c0 ff 4d 8d 66 ff e9 1c fe ff ff e8 ec 9e c0 ff <0f> 0b e8 e5 9e c0 ff 0f 0b e8 de 9e c0 ff 4c 8d 65 ff eb c3 48 89
RSP: 0000:ffffc90015fffc70 EFLAGS: 00010293
RAX: ffff8880544f4180 RBX: 0000000000000000 RCX: ffffffff81b29e18
RDX: 0000000000000000 RSI: ffffffff81b29fc4 RDI: 0000000000000001
RBP: ffffea0000d40080 R08: ffff8880544f4180 R09: fffff940001a8001
R10: ffffea0000d40007 R11: fffff940001a8000 R12: ffffea0000d40000
R13: 1ffff92002bfff90 R14: ffffea0001230f08 R15: ffff8880503e11e0
FS:  00007fdb7a134700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 00000000a703c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __handle_mm_fault+0x1c0e/0x3c90 mm/memory.c:4327
 handle_mm_fault+0x1a5/0x660 mm/memory.c:4382
 do_user_addr_fault arch/x86/mm/fault.c:1464 [inline]
 do_page_fault+0x55b/0x13da arch/x86/mm/fault.c:1535
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0033:0x45ca35
Code: 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 0f 83 db b6 fb ff <c3> 66 2e 0f 1f 84 00 00 00 00 00 48 85 ff 41 57 4d 89 cf 41 56 41
RSP: 002b:00000000200001c0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00000000004dabc0 RCX: 000000000045ca29
RDX: 0000000020000140 RSI: 00000000200001c0 RDI: 0000000000000000
RBP: 000000000078bfa0 R08: 0000000020000300 R09: 0000000000000000
R10: 00000000200002c0 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000076 R14: 00000000004c331e R15: 00007fdb7a1346d4
Modules linked in:
---[ end trace 5096692b6266afca ]---
RIP: 0010:migration_entry_to_page include/linux/swapops.h:197 [inline]
RIP: 0010:migration_entry_to_page include/linux/swapops.h:190 [inline]
RIP: 0010:pmd_migration_entry_wait+0x5b4/0x660 mm/migrate.c:368
Code: 32 e8 10 9f c0 ff 48 c7 c6 e0 a4 35 88 4c 89 e7 e8 81 a1 ec ff 0f 0b e8 fa 9e c0 ff 4d 8d 66 ff e9 1c fe ff ff e8 ec 9e c0 ff <0f> 0b e8 e5 9e c0 ff 0f 0b e8 de 9e c0 ff 4c 8d 65 ff eb c3 48 89
RSP: 0000:ffffc90015fffc70 EFLAGS: 00010293
RAX: ffff8880544f4180 RBX: 0000000000000000 RCX: ffffffff81b29e18
RDX: 0000000000000000 RSI: ffffffff81b29fc4 RDI: 0000000000000001
RBP: ffffea0000d40080 R08: ffff8880544f4180 R09: fffff940001a8001
R10: ffffea0000d40007 R11: fffff940001a8000 R12: ffffea0000d40000
R13: 1ffff92002bfff90 R14: ffffea0001230f08 R15: ffff8880503e11e0
FS:  00007fdb7a134700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 00000000a703c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
