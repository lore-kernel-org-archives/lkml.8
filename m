Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06709C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BD22075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405138AbgE1QoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:44:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53693 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405081AbgE1QoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:44:19 -0400
Received: by mail-io1-f72.google.com with SMTP id g3so8348501ioc.20
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nXeTsOxAOjhohuCjiG+Zpl5W621XxmhGmR88GhqtUGU=;
        b=rmskzU3qFBmU71QKZThEnpVcifZuw7jGDBwyYib9DvS/7IlAjqhDPM8a/z9StzSxMF
         lJdTa9O46x1KZigYE+Gy24zAFSXSwufaP9CvX96q0xINIvhaUOb2HbdNpjoD5aP5qlrN
         0Gwp08R+ZqiSN6HMgi0NZCr7hRMa6KFJ4HoUdlhIg1/Rvz+p6OPfz2o1i2H4e/MAbZT8
         acEUe79IFDFmvWpXZtpqlNkO0REHuAyhGIhNGVfRe45fk898iVzQfs5PQtoAV17vj+Xv
         wQeMEoP3Tu3ebqWMcTNQSFUEnYNv/UhB2imQCouBg42XK47Nl7pWbGcnUt8DNDaqhO5W
         NVWw==
X-Gm-Message-State: AOAM530EMpo6X2Cw0TrFvxPBIhTfeUEb+NA4mX0zZEms4qnViuBi+qPH
        O5AHbGX4VlDZ2VU2WnB0i51/tHsGUn7q1SNtod/J+ihmZMUI
X-Google-Smtp-Source: ABdhPJwmk4ZfCkhx6ExlSFl1+41gALUwVLkbFg7KQHQ0+L6mVik2gmoMMDRR/+CTuwKKNQdb5LlPN1+eyF8t5kJ2Plbp3bb0xkDH
MIME-Version: 1.0
X-Received: by 2002:a02:a899:: with SMTP id l25mr3366912jam.101.1590684257147;
 Thu, 28 May 2020 09:44:17 -0700 (PDT)
Date:   Thu, 28 May 2020 09:44:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018e1d305a6b80a73@google.com>
Subject: general protection fault in inet_unhash
From:   syzbot <syzbot+3610d489778b57cc8031@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, davem@davemloft.net, guro@fb.com,
        kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    dc0f3ed1 net: phy: at803x: add cable diagnostics support f..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17289cd2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1bc97341edbea6
dashboard link: https://syzkaller.appspot.com/bug?extid=3610d489778b57cc8031
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f237aa100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1553834a100000

The bug was bisected to:

commit af6eea57437a830293eab56246b6025cc7d46ee7
Author: Andrii Nakryiko <andriin@fb.com>
Date:   Mon Mar 30 02:59:58 2020 +0000

    bpf: Implement bpf_link-based cgroup BPF program attachment

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1173cd7e100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1373cd7e100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1573cd7e100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3610d489778b57cc8031@syzkaller.appspotmail.com
Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 7063 Comm: syz-executor654 Not tainted 5.7.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:inet_unhash+0x11f/0x770 net/ipv4/inet_hashtables.c:600
Code: 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e dd 04 00 00 48 8d 7d 08 44 8b 73 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 55 05 00 00 48 8d 7d 14 4c 8b 6d 08 48 b8 00 00
RSP: 0018:ffffc90001777d30 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88809a6df940 RCX: ffffffff8697c242
RDX: 0000000000000001 RSI: ffffffff8697c251 RDI: 0000000000000008
RBP: 0000000000000000 R08: ffff88809f3ae1c0 R09: fffffbfff1514cc1
R10: ffffffff8a8a6607 R11: fffffbfff1514cc0 R12: ffff88809a6df9b0
R13: 0000000000000007 R14: 0000000000000000 R15: ffffffff873a4d00
FS:  0000000001d2b880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cd090 CR3: 000000009403a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 sk_common_release+0xba/0x370 net/core/sock.c:3210
 inet_create net/ipv4/af_inet.c:390 [inline]
 inet_create+0x966/0xe00 net/ipv4/af_inet.c:248
 __sock_create+0x3cb/0x730 net/socket.c:1428
 sock_create net/socket.c:1479 [inline]
 __sys_socket+0xef/0x200 net/socket.c:1521
 __do_sys_socket net/socket.c:1530 [inline]
 __se_sys_socket net/socket.c:1528 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1528
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x441e29
Code: e8 fc b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdce184148 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441e29
RDX: 0000000000000073 RSI: 0000000000000002 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000402c30 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 23b6578228ce553e ]---
RIP: 0010:inet_unhash+0x11f/0x770 net/ipv4/inet_hashtables.c:600
Code: 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e dd 04 00 00 48 8d 7d 08 44 8b 73 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 55 05 00 00 48 8d 7d 14 4c 8b 6d 08 48 b8 00 00
RSP: 0018:ffffc90001777d30 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88809a6df940 RCX: ffffffff8697c242
RDX: 0000000000000001 RSI: ffffffff8697c251 RDI: 0000000000000008
RBP: 0000000000000000 R08: ffff88809f3ae1c0 R09: fffffbfff1514cc1
R10: ffffffff8a8a6607 R11: fffffbfff1514cc0 R12: ffff88809a6df9b0
R13: 0000000000000007 R14: 0000000000000000 R15: ffffffff873a4d00
FS:  0000000001d2b880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cd090 CR3: 000000009403a000 CR4: 00000000001406f0
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
