Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3A2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14408207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFECCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 22:02:20 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49892 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgFECCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:02:19 -0400
Received: by mail-io1-f71.google.com with SMTP id h17so4773007ior.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 19:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=szPEl64cpoHvhxXlR5lo+T/AwMKKhjIH6u2ObmlDQ8E=;
        b=ucIOsIBvwG1r28OmENYjOt+Zt15brxvFFUPmVH3H/YklLpCNhBAvPICpN4kwKHNcMi
         8imHRP3SwgKKNiDLByjo2DKcDpj+fdPfZClg2h8sGCAJY81Ls771Vov0cFv2XSguFuR8
         INiGJgQ3qd/kHIl2Uqh30if/dTAGd98XcpQ20xy0hF7p09qBuOZt5BUY2hTAG/XOCb0A
         VvL/TVaMR7zzpXNJ1wqo3HCg9Pk6Vidmwz18Z74HXHOMUtNGhwnB6sbJAzjw+xvYGmQg
         4CaskrCdAhLS4WT2MLa68HIoWWIZQiLyA85peXGHgmYJKXYC/abQtEtmk65dLhNOo/I0
         hOaw==
X-Gm-Message-State: AOAM533rksifp208t6+HzdP0Z+dsxxmihMby2GonJ37ok0t1zZYuEory
        etPUqrhsBozWXL5Wv7pTnMvJXXWPCEwB/vgQIg5Gqrevbn2q
X-Google-Smtp-Source: ABdhPJy35sGcsK5T99oV/Miqd0MTFmMIRGWwz7NG7KYR7p84q6J2DjC+KVRxWgwyPqvZlI1/vg6BarUMynCMXcFO+QudDyc1gEy4
MIME-Version: 1.0
X-Received: by 2002:a92:cc4e:: with SMTP id t14mr4239598ilq.138.1591322538629;
 Thu, 04 Jun 2020 19:02:18 -0700 (PDT)
Date:   Thu, 04 Jun 2020 19:02:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a363b205a74ca6a2@google.com>
Subject: BUG: using smp_processor_id() in preemptible code in radix_tree_node_alloc
From:   syzbot <syzbot+3eec59e770685e3dc879@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    acf25aa6 Merge tag 'Smack-for-5.8' of git://github.com/csc..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d6307a100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5263d9b5bce03c67
dashboard link: https://syzkaller.appspot.com/bug?extid=3eec59e770685e3dc879
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd4c1e100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1520c9de100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3eec59e770685e3dc879@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00007ffdf01d56d0 RCX: 00000000004406c9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 0000000000000005 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401f50
R13: 0000000000401fe0 R14: 0000000000000000 R15: 0000000000000000
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor036/6796
caller is radix_tree_node_alloc.constprop.0+0x200/0x330 lib/radix-tree.c:262
CPU: 0 PID: 6796 Comm: syz-executor036 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 check_preemption_disabled lib/smp_processor_id.c:47 [inline]
 debug_smp_processor_id.cold+0x88/0x9b lib/smp_processor_id.c:57
 radix_tree_node_alloc.constprop.0+0x200/0x330 lib/radix-tree.c:262
 radix_tree_extend+0x256/0x4e0 lib/radix-tree.c:424
 idr_get_free+0x60c/0x8e0 lib/radix-tree.c:1492
 idr_alloc_u32+0x170/0x2d0 lib/idr.c:46
 idr_alloc+0xc2/0x130 lib/idr.c:87
 qrtr_port_assign net/qrtr/qrtr.c:703 [inline]
 __qrtr_bind.isra.0+0x12e/0x5c0 net/qrtr/qrtr.c:756
 qrtr_autobind net/qrtr/qrtr.c:787 [inline]
 qrtr_autobind+0xaf/0xf0 net/qrtr/qrtr.c:775
 qrtr_sendmsg+0x1d6/0x770 net/qrtr/qrtr.c:895
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e6/0x810 net/socket.c:2352
 ___sys_sendmsg+0x100/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4406c9
Code: 25 02 00 85 c0 b8 00 00 00 00 48 0f 44 c3 5b c3 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdf01d56c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffdf01d56d0 RCX: 00000000004406c9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 0000000000000005 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401f50
R13: 0000000000401fe0 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
