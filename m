Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20EEC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AE520828
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBVBNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:13:16 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50061 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgBVBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:13:15 -0500
Received: by mail-io1-f70.google.com with SMTP id v11so3696133iop.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 17:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6eLAPqtZ8c5EdwJf7EVWvvnHhrg/3kPG4gMqHFy5v4A=;
        b=oCmny8Een3xZKkj3LSd0+ZbSPyFQldhIzLbGo768Tg18ZiGzbShjEyECqdyx7jhGe+
         lxEfGXJYzY1e94CaGVnw9Y8BajXwtsQrSB6tzDihLDpIX4iRGDLbWw6EIk+iPV6mwi88
         RgGQD7t0inwPpFWZqGOO5O7QUvo/SQEKUppP5R/ZOCstYUkhKG8H2bA63f2ruKoKhrVq
         TmDa5VC+/mfxJToadGtReSZN4ahUxCWGj2vSpQihX/UUKRdQXLwqn1Yg/uXGZStGpdIo
         unaC1I9HJ/s6IR4XOh+Yt5NTThw4Aq1KRIFCt8AP+tZm74+JWrEpplu23aaG0nWtIMcm
         tbCA==
X-Gm-Message-State: APjAAAU5jiGdk2yKOFo/XYsP7LXVVQu48rdE3KlbFLOFoax3MjTyzn9H
        P1Wmzr3dQLLqI/SDasZVXyTiOsCkx+XdX++HAfJxnmxT9Y2K
X-Google-Smtp-Source: APXvYqzbaMogp/HG01MNtFex4blRaUgwqV4zRTvObvGHWAiNFmsEDRlx2xNtXRh0TW9qSQF6PSZLllmHa9ms9GXF7vKm0O5NRTl6
MIME-Version: 1.0
X-Received: by 2002:a6b:740c:: with SMTP id s12mr36894580iog.108.1582333992768;
 Fri, 21 Feb 2020 17:13:12 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:13:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e18fb059f1fd725@google.com>
Subject: kernel BUG at arch/x86/mm/physaddr.c:LINE! (4)
From:   syzbot <syzbot+1f4d90ead370d72e450b@syzkaller.appspotmail.com>
To:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    36a44bcd Merge branch 'bnxt_en-shutdown-and-kexec-kdump-re..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12524265e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=768cc3d3e277cc16
dashboard link: https://syzkaller.appspot.com/bug?extid=1f4d90ead370d72e450b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123d9de9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1648fe09e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f4d90ead370d72e450b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9873 Comm: syz-executor039 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__phys_addr+0xb3/0x120 arch/x86/mm/physaddr.c:28
Code: 09 4c 89 e3 31 ff 48 d3 eb 48 89 de e8 36 e2 40 00 48 85 db 75 0f e8 8c e0 40 00 4c 89 e0 5b 41 5c 41 5d 5d c3 e8 7d e0 40 00 <0f> 0b e8 76 e0 40 00 48 c7 c0 10 50 a7 89 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90005b47490 EFLAGS: 00010093
RAX: ffff8880944f4600 RBX: 0000000002777259 RCX: ffffffff8134ad32
RDX: 0000000000000000 RSI: ffffffff8134ad93 RDI: 0000000000000006
RBP: ffffc90005b474a8 R08: ffff8880944f4600 R09: ffffed1015d2707c
R10: ffffed1015d2707b R11: ffff8880ae9383db R12: 0000778002777259
R13: 0000000082777259 R14: ffff88809a765000 R15: 0000000000000010
FS:  0000000001436880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200004c0 CR3: 0000000096da8000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 virt_to_head_page include/linux/mm.h:721 [inline]
 virt_to_cache mm/slab.h:472 [inline]
 kfree+0x7b/0x2c0 mm/slab.c:3749
 audit_free_lsm_field kernel/auditfilter.c:76 [inline]
 audit_free_rule kernel/auditfilter.c:91 [inline]
 audit_data_to_entry+0xb7b/0x25f0 kernel/auditfilter.c:603
 audit_rule_change+0x6b5/0x1130 kernel/auditfilter.c:1130
 audit_receive_msg+0xda5/0x28b0 kernel/audit.c:1368
 audit_receive+0x114/0x230 kernel/audit.c:1513
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:672
 ____sys_sendmsg+0x753/0x880 net/socket.c:2343
 ___sys_sendmsg+0x100/0x170 net/socket.c:2397
 __sys_sendmsg+0x105/0x1d0 net/socket.c:2430
 __do_sys_sendmsg net/socket.c:2439 [inline]
 __se_sys_sendmsg net/socket.c:2437 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2437
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401a9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd66553d28 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401a9
RDX: 0000000000000000 RSI: 00000000200004c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a30
R13: 0000000000401ac0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 1e4db35053a9d748 ]---
RIP: 0010:__phys_addr+0xb3/0x120 arch/x86/mm/physaddr.c:28
Code: 09 4c 89 e3 31 ff 48 d3 eb 48 89 de e8 36 e2 40 00 48 85 db 75 0f e8 8c e0 40 00 4c 89 e0 5b 41 5c 41 5d 5d c3 e8 7d e0 40 00 <0f> 0b e8 76 e0 40 00 48 c7 c0 10 50 a7 89 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90005b47490 EFLAGS: 00010093
RAX: ffff8880944f4600 RBX: 0000000002777259 RCX: ffffffff8134ad32
RDX: 0000000000000000 RSI: ffffffff8134ad93 RDI: 0000000000000006
RBP: ffffc90005b474a8 R08: ffff8880944f4600 R09: ffffed1015d2707c
R10: ffffed1015d2707b R11: ffff8880ae9383db R12: 0000778002777259
R13: 0000000082777259 R14: ffff88809a765000 R15: 0000000000000010
FS:  0000000001436880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200004c0 CR3: 0000000096da8000 CR4: 00000000001406e0
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
