Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D02C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6757A206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgFDOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:42:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40386 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgFDOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:42:19 -0400
Received: by mail-il1-f198.google.com with SMTP id s4so4115087ilc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ty3XY6GL9r1bw8IROJoQjoG/PwaIJU5wQYUR1R0AF9E=;
        b=evjuT3UjUEOQVSP6F6kebBCDpQQyB/7SosBhBrMV6jt/NvPMMRDLxuMB+veONfliwG
         Qu/LWvRsiJY3lNOof/jlTa8nu93jK2W+GhI8ZbW7dLOgHQ3qQkYFD/x5XzoS6mj6vbSV
         CWSS7kMV+N+xoyaK9vvHjZbouBQQ4oOuRagXMaWQQytl1bpC1+y5veDfhXN9oWW2LwjA
         Blq8Ue3b+xxVdexUAdxDz1AVgjNdjP4AaV4bIU2Ey51EJZzBczQiCmST0K5voKbave9N
         tg4vbdcAiAGBprBO+kuGgdw6aNH0dc2ASwcWaWarC6UING54BBXlXURTKsdUS8SBBSCK
         ejag==
X-Gm-Message-State: AOAM5315suSm/UDBxo/QriBu/H+XGfsPk95fjUDLxphfmOxVRIoFCf5T
        qgeOYXvB2A2g+P+pCVc8ZM3eTYGnTGrGobwqKIRpzSzxhzS9
X-Google-Smtp-Source: ABdhPJzVkH0XgWUDVL0NQdNqdP6kI3aHVAOGVvYm/VtUnXmD5vmefM3RowqsYWjLFMeFWhHkqMhfRabPFQGMnkJdG4V8HtcDsfcB
MIME-Version: 1.0
X-Received: by 2002:a92:5b99:: with SMTP id c25mr4404840ilg.42.1591281738622;
 Thu, 04 Jun 2020 07:42:18 -0700 (PDT)
Date:   Thu, 04 Jun 2020 07:42:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4abec05a7432666@google.com>
Subject: BUG: using smp_processor_id() in preemptible code in debug_smp_processor_id
From:   syzbot <syzbot+9e0b179ae55eaf7a307a@syzkaller.appspotmail.com>
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

HEAD commit:    065fcfd4 selftests: net: ip_defrag: ignore EPERM
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c3e516100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d89141553e61b775
dashboard link: https://syzkaller.appspot.com/bug?extid=9e0b179ae55eaf7a307a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131b5cf2100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176dfcf2100000

The bug was bisected to:

commit e42671084361302141a09284fde9bbc14fdd16bf
Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Thu May 7 12:53:06 2020 +0000

    net: qrtr: Do not depend on ARCH_QCOM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1295eb91100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1195eb91100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1695eb91100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9e0b179ae55eaf7a307a@syzkaller.appspotmail.com
Fixes: e42671084361 ("net: qrtr: Do not depend on ARCH_QCOM")

RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00000000006cb018 R08: 0000000000000001 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401e90
R13: 0000000000401f20 R14: 0000000000000000 R15: 0000000000000000
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor013/7182
caller is radix_tree_node_alloc.constprop.0+0x200/0x330 lib/radix-tree.c:264
CPU: 0 PID: 7182 Comm: syz-executor013 Not tainted 5.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 check_preemption_disabled lib/smp_processor_id.c:47 [inline]
 debug_smp_processor_id.cold+0x88/0x9b lib/smp_processor_id.c:57
 radix_tree_node_alloc.constprop.0+0x200/0x330 lib/radix-tree.c:264
 radix_tree_extend+0x234/0x4a0 lib/radix-tree.c:426
 idr_get_free+0x60c/0x8e0 lib/radix-tree.c:1494
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
RIP: 0033:0x4405a9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe905331b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004a1bd8 RCX: 00000000004405a9
RDX: 0000000000000000 RSI: 00000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
