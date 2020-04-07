Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E9DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60882072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDGAZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:25:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54962 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgDGAZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:25:16 -0400
Received: by mail-io1-f70.google.com with SMTP id f20so1554446iof.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 17:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0/Zw3Cm40v/yReO1PkWdNIXFrDRikiWQ1dPh7Fa3G9g=;
        b=B+O2pDwqrApw9e7UU7NqSQ9D6/wsbKvccYHmYQuBTJNQXsS4C/8mcFm8td4CMIB4Wf
         dHsl8gntrg88rm3ugMTqMR9ahgdyTk3OIp0YvChDt9WNbAU8RzjlXx9vJNvwKIyaEAR+
         FQ4lV4fww1LOW8H+D83ho/INVuW7cFHSb4AZZimrVjkF6oAthkFJn9zKOG1m+PdVVNHa
         81hjKgulcWcEoscIJAqydXECJu8SckN7HKaGoxYPCwUQct3vPUiGF9q/PWdhIJWtuKSE
         n6jEpaoPayv829Ks/5RQbYhPdAvxwvXpaU6UNvya669r6NYjsiCmy0CI9K8c9iG2dXLx
         8vlA==
X-Gm-Message-State: AGi0PuYtkDfCaNiY1J1VylVlbKfFWC/6uVQn5vTuB7+/sInePL7wlig0
        wn2+q1pLVqyyQeTLr8Xhxnil7IG7Wo8LSzXSRcf57xtxcEqo
X-Google-Smtp-Source: APiQypLt55MtZ7SZMNlZxUiqtxm3NgctQF05quGJgTjVzBqXTMCzyDfTpMeLfB4iRzkJnSwjJWWrMLB8m5Q1a8tO7dJqyQ07l9UY
MIME-Version: 1.0
X-Received: by 2002:a02:55c5:: with SMTP id e188mr1955677jab.57.1586219113675;
 Mon, 06 Apr 2020 17:25:13 -0700 (PDT)
Date:   Mon, 06 Apr 2020 17:25:13 -0700
In-Reply-To: <000000000000e9fbaa05a028e759@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce86c705a2a86a37@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 do_syscall_64 (2)
From:   syzbot <syzbot+d6d57d324860c94d5836@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b2e2a818 Add linux-next specific files for 20200406
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14022a57e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595413e7170f444b
dashboard link: https://syzkaller.appspot.com/bug?extid=d6d57d324860c94d5836
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14873543e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ea05cde00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d6d57d324860c94d5836@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 962b6067 P4D 962b6067 PUD 9441e067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7058 Comm: syz-executor367 Not tainted 5.6.0-next-20200406-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 7d 50 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80
RSP: 0018:ffffc90001657f28 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000023 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8163ea3d RDI: 0000000000000282
RBP: ffffc90001657f58 R08: ffff8880a9156440 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff89949570 R14: 0000000000000000 R15: 0000000000000000
FS:  00000000015f5940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000962b7000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4464b0
Code: c0 5b 5d c3 66 0f 1f 44 00 00 8b 04 24 48 83 c4 18 5b 5d c3 66 0f 1f 44 00 00 83 3d 61 cb 29 00 00 75 14 b8 23 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 84 20 fc ff c3 48 83 ec 08 e8 5a 43 00 00
RSP: 002b:00007fffeb3290d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 00007fffeb329140 RCX: 00000000004464b0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fffeb3290e0
RBP: 0000000000000002 R08: 0000000000000001 R09: 00000000015f5940
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000fb38
R13: 0000000000408a50 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 0000000000000000
---[ end trace 07b78701f72ec477 ]---
RIP: 0010:do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 7d 50 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80
RSP: 0018:ffffc90001657f28 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000023 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8163ea3d RDI: 0000000000000282
RBP: ffffc90001657f58 R08: ffff8880a9156440 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff89949570 R14: 0000000000000000 R15: 0000000000000000
FS:  00000000015f5940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000962b7000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

