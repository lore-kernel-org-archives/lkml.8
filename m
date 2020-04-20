Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74900C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525C02078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDTFfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:35:15 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42744 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgDTFfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:35:14 -0400
Received: by mail-io1-f71.google.com with SMTP id e6so8884592iol.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=h/BvHvMfds32NfgtE98V2KP6Bs++QvZcaliDj82Cs0E=;
        b=gTs9h4IUvlAtFJdcKcw4GFQK5PJe8uGdtW+hXjgxJuIylmMCogMV+zjeSaHJ2CpYDZ
         mrH4MUT+mzYZbWLsV6EWYipovsXoyj/GiiYZxNnh79LNACRRETwwfcoDYBiETGL/mEp8
         uZ3CF26oTkFL/nLLX2xrVLdGJvjVGMuS1I5xBugTiUgpHUQUpRRPv9HhcXciKd+o41xv
         4Z3jTcOP3NGduqc8tpTRaE3QSYTt/JMx5xMM4jo8MPRkmbzF4cHwQ0AjPYKA14C8WPwb
         fAy/RA9HYeDAil7k2CIdYagfsbAgwg6Fjf9AaTBPpoq9CDesnFDf/tT+sdoD+RgPN0km
         j9rg==
X-Gm-Message-State: AGi0Pua5GmpezgpGCQTCUKRPy/E3lnm4033CrOq2KrzX49fiTssEC5SF
        wyCTckVhaeOnRpgFrz5ZOgo69NRFDki3hw7fMSyZnHAwDyZ3
X-Google-Smtp-Source: APiQypLbMNCAg8juI7DU5HhW3a6QLULnSLinXE3REp1inSW17hBXgpxyQyOzwzcnKgTIuhgyGKBF8HWyhClxQa95esEk7KAEOrVS
MIME-Version: 1.0
X-Received: by 2002:a92:5d5b:: with SMTP id r88mr14510816ilb.206.1587360913748;
 Sun, 19 Apr 2020 22:35:13 -0700 (PDT)
Date:   Sun, 19 Apr 2020 22:35:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064f6e505a3b243aa@google.com>
Subject: KMSAN: uninit-value in audit_log_vformat (2)
From:   syzbot <syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com>
To:     eparis@redhat.com, glider@google.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5356842d [EXPERIMENTAL] kmsan: eagerly allocate shadow at ..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12f06720100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5915107b3106aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=49e69b4d71a420ceda3e
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133b5dabe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143e1610100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:608 [inline]
BUG: KMSAN: uninit-value in string+0x522/0x690 lib/vsprintf.c:689
CPU: 1 PID: 8854 Comm: syz-executor694 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 string_nocheck lib/vsprintf.c:608 [inline]
 string+0x522/0x690 lib/vsprintf.c:689
 vsnprintf+0x207d/0x31b0 lib/vsprintf.c:2574
 audit_log_vformat+0x583/0xcd0 kernel/audit.c:1858
 audit_log_format+0x220/0x260 kernel/audit.c:1892
 audit_receive_msg kernel/audit.c:1344 [inline]
 audit_receive+0x18a4/0x6d50 kernel/audit.c:1515
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2345
 ___sys_sendmsg net/socket.c:2399 [inline]
 __sys_sendmsg+0x451/0x5f0 net/socket.c:2432
 __compat_sys_sendmsg net/compat.c:642 [inline]
 __do_compat_sys_sendmsg net/compat.c:649 [inline]
 __se_compat_sys_sendmsg net/compat.c:646 [inline]
 __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fa0d99
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffb27c7c EFLAGS: 00000246 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200002c0
RDX: 0000000000000000 RSI: 00000000080ea078 RDI: 00000000ffb27cd0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
 slab_alloc_node mm/slub.c:2801 [inline]
 __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4420
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1081 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1175 [inline]
 netlink_sendmsg+0x7d3/0x14d0 net/netlink/af_netlink.c:1893
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2345
 ___sys_sendmsg net/socket.c:2399 [inline]
 __sys_sendmsg+0x451/0x5f0 net/socket.c:2432
 __compat_sys_sendmsg net/compat.c:642 [inline]
 __do_compat_sys_sendmsg net/compat.c:649 [inline]
 __se_compat_sys_sendmsg net/compat.c:646 [inline]
 __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
