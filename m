Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2426C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0F4206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFJKDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:03:13 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:52774 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:03:12 -0400
Received: by mail-il1-f198.google.com with SMTP id v14so1105282ilo.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=s9Ndse2lGRmxdIH/Ktmx8GJZm0pgFE0UOBytpQ6Yd5s=;
        b=lI1kXvxrjgCF3q2Gy8pBsQAx/2wiHdYDNWjNxHoaxQQgcLotN15AAX9HZIvRPR/O+a
         NmTVQ/pUup4dnGsPJXACC1tqztWNJaOpmI41lYsLBta6XJe94CbbQuGf39dtJGZm3usb
         AV6P5EwzDU6gqm5yta1ARinrV0PuJlvGUhnZZijA2k4dArjem3COUyxKijautuG7OT1v
         IaiLPr9VIyEC49KoSeU2dTsVy2PKekUUpqvNpmdu+nqaTbhko25zdRBpEW+WJLWfGI44
         VZdcsgre/NDquTWqJIBnVfKilQKsro8OdkGsl7CneySh2B0BOVzRUOLXscLE5qHhaZxZ
         9hyw==
X-Gm-Message-State: AOAM530R+t5fC7R/gE+X+kKZ6WLjF6vcFh6sL67DZG7hR5ZHguq+yc2y
        vHoNxeDuX/0oSMt93mG+NlEH6IbUzrZgwP+wnwK1rJLn57iZ
X-Google-Smtp-Source: ABdhPJyRm3ZJ+GrgzL9055X5DC2K7DQFskv/mtEdmnUqg4xUShMl1IESaXEP6mUzvKyoMXx54kwxBK+0kuWuNo0kE+F08Yvp9BpV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dc5:: with SMTP id l5mr2186591ilj.216.1591783391613;
 Wed, 10 Jun 2020 03:03:11 -0700 (PDT)
Date:   Wed, 10 Jun 2020 03:03:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dd95205a7b7f3bf@google.com>
Subject: general protection fault in __switch_to_asm
From:   syzbot <syzbot+fe6eeea133f070606074@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, mhiramat@kernel.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e7b08814 Add linux-next specific files for 20200529
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14a1f451100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e62421a5de6da96
dashboard link: https://syzkaller.appspot.com/bug?extid=fe6eeea133f070606074
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1524ea96100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fab432100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fe6eeea133f070606074@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc7-next-20200529-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__switch_to_asm+0x0/0x40 arch/x86/entry/entry_64.S:228
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffffff89a07cd8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88809fce2b40 RCX: 1ffffffff1350dc9
RDX: 1ffff11015cc6fc2 RSI: ffff88809489e280 RDI: ffffffff89a86580
RBP: ffffffff89a07da8 R08: 0000000000000000 R09: fffffbfff155b432
R10: ffffffff8aada18f R11: fffffbfff155b431 R12: ffffffff89a86580
R13: ffff8880ae637e00 R14: ffff88809489e280 R15: ffff8880ae637e18
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563f12be20f8 CR3: 000000009a876000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 context_switch kernel/sched/core.c:3430 [inline]
 __schedule+0x8f3/0x1f80 kernel/sched/core.c:4155
 schedule_idle+0x53/0x90 kernel/sched/core.c:4258
 do_idle+0x327/0x690 kernel/sched/idle.c:297
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:365
 start_kernel+0x9be/0x9fb init/main.c:1043
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
Modules linked in:
---[ end trace 7e4004b4996f54a3 ]---
RIP: 0010:__switch_to_asm+0x0/0x40 arch/x86/entry/entry_64.S:228
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffffff89a07cd8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88809fce2b40 RCX: 1ffffffff1350dc9
RDX: 1ffff11015cc6fc2 RSI: ffff88809489e280 RDI: ffffffff89a86580
RBP: ffffffff89a07da8 R08: 0000000000000000 R09: fffffbfff155b432
R10: ffffffff8aada18f R11: fffffbfff155b431 R12: ffffffff89a86580
R13: ffff8880ae637e00 R14: ffff88809489e280 R15: ffff8880ae637e18
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563f12be20f8 CR3: 000000009a876000 CR4: 00000000001406f0
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
