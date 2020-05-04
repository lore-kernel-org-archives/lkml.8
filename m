Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4A1C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B8020757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEDKyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:54:21 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42757 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEDKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:54:19 -0400
Received: by mail-io1-f71.google.com with SMTP id d188so12738564iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 03:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FO4xDaIfxTwn2pEyGinZgotdJaQt7RptE2NYxBRHOvw=;
        b=b2ufw38hELjNcGma8w49wgZmo6lYkBJ5bioMMChUhatUMCKUqHmmMRc8hOm+bgkeK2
         5VQVTf3r9OX03DbtoCsVXI8tNncmXlQLhZOtFFnoqgKjwTyLsty76ERMANSLk8wVlnJk
         V0FdS8UkL5MrZ4FS4B8uBVZU6hPrnKUVRVCRdsFTS7yGy1HpZkcehtVlHth7YG10sauk
         eDdpDx7vBNuNRrcSNkBPDoDm8cAPuz9ZeeoPkc8b2moe7sa1nno6ObTN2GPjgpn5rHnF
         q11VxHtOWmdCXDluU4GEV8Pm/oEAOWT7piY/mYxHzth3KpLYtaSry0j31ZpiT3NBhM9q
         khmg==
X-Gm-Message-State: AGi0PubzPORrK6i/tE2y8eLPRXMKjFwk0lNzC7Cjw/4Bz+XxXLxx2J4c
        nwR9xRfIN0pxl+kOLVNhO1myzENWGST7Kkq2Ktci3pw3x1eB
X-Google-Smtp-Source: APiQypKNUiYkaUkrIbkJdG+jJows/ANxR6UAiChp+yhND1WSnh3QJQIkbTt9WpdpD2z79dSG79EbzrBWIs9odt5neWXrrKmTWlvs
MIME-Version: 1.0
X-Received: by 2002:a02:cbba:: with SMTP id v26mr13967781jap.14.1588589658332;
 Mon, 04 May 2020 03:54:18 -0700 (PDT)
Date:   Mon, 04 May 2020 03:54:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047642c05a4d05ae5@google.com>
Subject: BUG: unable to handle kernel paging request in syscall_return_slowpath
From:   syzbot <syzbot+3231e7d48f1538976553@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f66ed1eb Merge tag 'iomap-5.7-fixes-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140f6e60100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ac152749c11ca54
dashboard link: https://syzkaller.appspot.com/bug?extid=3231e7d48f1538976553
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1415e23fe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146bbc3fe00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12955ee4100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11955ee4100000
console output: https://syzkaller.appspot.com/x/log.txt?x=16955ee4100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3231e7d48f1538976553@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffffff8778570
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 927c067 P4D 927c067 PUD 927e067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7070 Comm: syz-executor231 Not tainted 5.7.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0xfffffffff8778570
Code: Bad RIP value.
RSP: 0018:ffffc90001627f00 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000004000 RCX: ffff888092d64280
RDX: ffff888092d64280 RSI: 0000000000000200 RDI: 0000000000000000
RBP: 0000000000000200 R08: ffffffff8100848d R09: fffffbfff16e6e11
R10: fffffbfff16e6e11 R11: 0000000000000000 R12: 1ffff110125ac850
R13: dffffc0000000000 R14: ffff888092d64280 R15: ffff888092d64280
FS:  0000000001be0880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffff8778546 CR3: 00000000a82d6000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 syscall_return_slowpath+0x9b/0x420 arch/x86/entry/common.c:266
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
Modules linked in:
CR2: fffffffff8778570
---[ end trace 8e914c2fec746223 ]---
RIP: 0010:0xfffffffff8778570
Code: Bad RIP value.
RSP: 0018:ffffc90001627f00 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000004000 RCX: ffff888092d64280
RDX: ffff888092d64280 RSI: 0000000000000200 RDI: 0000000000000000
RBP: 0000000000000200 R08: ffffffff8100848d R09: fffffbfff16e6e11
R10: fffffbfff16e6e11 R11: 0000000000000000 R12: 1ffff110125ac850
R13: dffffc0000000000 R14: ffff888092d64280 R15: ffff888092d64280
FS:  0000000001be0880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffff8778546 CR3: 00000000a82d6000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
