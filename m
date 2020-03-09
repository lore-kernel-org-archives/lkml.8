Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A625CC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB8820665
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgCIFhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 01:37:12 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38447 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIFhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 01:37:12 -0400
Received: by mail-io1-f72.google.com with SMTP id x2so5970596iog.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 22:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qR7L3Mw/sXzOkxDD0WkoV3TAHZKs07cskY4mOVvSiC4=;
        b=ZRTaC0aClt5+rvVR/ugkXQT2t89Ns3B1S6hmp4flidyueqf3wOonZbLj6ux91LzInP
         StI3sNIhUnSJV9S61Hulo1jk3e5BAvWPfUVwV6rVCEZCuz7fxk+gwXMHykaRU+SOTS39
         Bbnpin67jCSuah9FCqq0CXcX7etq9PLvqH7kHNgCLdFzBD0S7lKqw23RXWi0ML/kQKFO
         tukq3P9LLqiu5lBCqjcOsFWI2WWw5Q8dDud1Fwzc84Va9B7URzHtPSFpITJIy3FOppLm
         cdeNNIH0mJdK/Q690LcNbVpkhKrVIFhV/m7FRqlWlU4OeFPShD8JGl0xnlNZZPToZllh
         E6Bw==
X-Gm-Message-State: ANhLgQ31dHZWne+klbSIju5VMz+yLN6wIWBKcdQbOK0FNLn0qj5np8T9
        447r2tlRC3kSLgxqw2tkS+bFVfxdFhGIiusbEw3njs6GMlzm
X-Google-Smtp-Source: ADFU+vum+r6hRGIYt4ee1APtBeB4MVtQKk1JWlXqJ8GrRMI4bdCX+pxHtkPSBAfALZTkbW8753D9sBQticAPB86qvseGjVvTv+5S
MIME-Version: 1.0
X-Received: by 2002:a05:6638:68c:: with SMTP id i12mr6476138jab.95.1583732231265;
 Sun, 08 Mar 2020 22:37:11 -0700 (PDT)
Date:   Sun, 08 Mar 2020 22:37:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010600905a06565a7@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in
 do_fast_syscall_32 (2)
From:   syzbot <syzbot+7f0cd10fb4b63c9e7046@syzkaller.appspotmail.com>
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

HEAD commit:    fb279f4e Merge branch 'i2c/for-current-fixed' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d84f31e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=751a68849f797e8b
dashboard link: https://syzkaller.appspot.com/bug?extid=7f0cd10fb4b63c9e7046
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7f0cd10fb4b63c9e7046@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 95be5067 P4D 95be5067 PUD a6eaf067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9527 Comm: syz-executor.3 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
RIP: 0010:do_fast_syscall_32+0x289/0xdfb arch/x86/entry/common.c:408
Code: 00 0f 85 a7 0a 00 00 48 89 ef ff 14 dd a0 79 00 88 48 8d 7d 50 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 11 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90002207f18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000000a2 RCX: 1ffff92000440ff5
RDX: dffffc0000000000 RSI: ffffffff8162df47 RDI: ffffc90002207fa8
RBP: ffffc90002207f58 R08: ffff8880613b2140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000f7f3be39
R13: ffffffff8973b288 R14: ffffc90002207fd8 R15: ffffc90002207fd0
FS:  0000000000000000(0000) GS:ffff8880ae700000(0063) knlGS:00000000096ba900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a70f6000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
Modules linked in:
CR2: 0000000000000000
---[ end trace e097d86a02851000 ]---
RIP: 0010:do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
RIP: 0010:do_fast_syscall_32+0x289/0xdfb arch/x86/entry/common.c:408
Code: 00 0f 85 a7 0a 00 00 48 89 ef ff 14 dd a0 79 00 88 48 8d 7d 50 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 11 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90002207f18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000000a2 RCX: 1ffff92000440ff5
RDX: dffffc0000000000 RSI: ffffffff8162df47 RDI: ffffc90002207fa8
RBP: ffffc90002207f58 R08: ffff8880613b2140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000f7f3be39
R13: ffffffff8973b288 R14: ffffc90002207fd8 R15: ffffc90002207fd0
FS:  0000000000000000(0000) GS:ffff8880ae700000(0063) knlGS:00000000096ba900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a70f6000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
