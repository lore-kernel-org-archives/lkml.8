Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8DC38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE4520857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pqBfSEt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgDTQlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgDTQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:40:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB1AC02548C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:29:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rh22so8421136ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADwP4J7IK4ZO4/FeXMdsiZ7Oi0mA5szLvM9bZ/wIlVw=;
        b=pqBfSEt6rHfX3RSfPLPKS8QqwY5eOMyYYA83fHsUZhTYeXGqbfZGc1ytRP83CaviLN
         o3MDlzJ5uPi24g91wqSTFBsSqEeN8SNVlXiHUOSAFDNbglu75TGjwQNF+eHyYfwr2Tue
         2KSre4gydb3PyUUsiDGPjF7lNCDMunFdllXFRfBKmD/1DTRgalBCwmQi8Yee0tyZfwfB
         Sg94o0QWzHAdDjVL6aGPDeYNW1qPGDvc40bm1Ug1mr/taumLv5zMqIgJUphkp6zZ2zbE
         LDt5DWaVfEPAM0v540kK7qKId3Ra/GvyJ2Fd7+wn23bqOprHuya4O+QsaEnq+KApW9+y
         nTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADwP4J7IK4ZO4/FeXMdsiZ7Oi0mA5szLvM9bZ/wIlVw=;
        b=doauWenQhqUVfXRmoNY0Jjvmf143qxlmtTEKH2sFmFniawym5YUaIPj1VK2Lt0uraR
         LFaimitjW5Xjr4Z0dql9qOUJQUYXZy8nblCC9MEpff3Qn6DOY+00fR6vvi1dCvR6PaMX
         1UvpBnoaE0NzvMhPU8PlpiWDJwoENUgv+MOQQcPHBlbHU5IgdY0B1r1EUtHSXzuFlFRz
         7MoVjVLOOX1979+b/jnAUTLuBLv6JR31SiRvlacyrYL8xDpc1RsgM/+KoHWE+ifJlk0S
         S9dRXWFKLbOSHJnQL317eru0ruxQbzSOR6QbDta3UmcHY5ZtHzil3h6gjyUzBmfOL3Ks
         tjqQ==
X-Gm-Message-State: AGi0PubPHfzO6NcN5TkDi3nERqVdyoU7lAl3cRGMFMozi+NKDSNIa7oR
        IHCUyAFMOqyoND1jASmaxybiWtCAJQ6NX/ZL085o
X-Google-Smtp-Source: APiQypJOx+QtGHpApXq7StDWqtb3Dbw0rrRBcAGyacI+MqeDDQUA9BY0GHvvNTbAXh33CNXa72AcAyfbaf4xknqsC7I=
X-Received: by 2002:a17:906:29c4:: with SMTP id y4mr16892261eje.95.1587400152394;
 Mon, 20 Apr 2020 09:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000064f6e505a3b243aa@google.com>
In-Reply-To: <00000000000064f6e505a3b243aa@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Apr 2020 12:29:01 -0400
Message-ID: <CAHC9VhTZ_itetT4cx32vW3A79tb76dzjaBC_0S8Y_=DcEBL2nw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in audit_log_vformat (2)
To:     syzbot <syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com>
Cc:     Eric Paris <eparis@redhat.com>, glider@google.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:35 AM syzbot
<syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    5356842d [EXPERIMENTAL] kmsan: eagerly allocate shadow at ..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=12f06720100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a5915107b3106aaa
> dashboard link: https://syzkaller.appspot.com/bug?extid=49e69b4d71a420ceda3e
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133b5dabe00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143e1610100000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com
>
> =====================================================
> BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:608 [inline]
> BUG: KMSAN: uninit-value in string+0x522/0x690 lib/vsprintf.c:689
> CPU: 1 PID: 8854 Comm: syz-executor694 Not tainted 5.6.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
>  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
>  string_nocheck lib/vsprintf.c:608 [inline]
>  string+0x522/0x690 lib/vsprintf.c:689
>  vsnprintf+0x207d/0x31b0 lib/vsprintf.c:2574

Are there any ongoing problems with [vsn]printf() in the kernel at the
moment with syzbot?

I ask because on first look I'm not seeing any obvious problems in the
audit portion of this code path.

>  audit_log_vformat+0x583/0xcd0 kernel/audit.c:1858
>  audit_log_format+0x220/0x260 kernel/audit.c:1892
>  audit_receive_msg kernel/audit.c:1344 [inline]
>  audit_receive+0x18a4/0x6d50 kernel/audit.c:1515
>  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
>  netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1329
>  netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1918
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg net/socket.c:672 [inline]
>  ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2345
>  ___sys_sendmsg net/socket.c:2399 [inline]
>  __sys_sendmsg+0x451/0x5f0 net/socket.c:2432
>  __compat_sys_sendmsg net/compat.c:642 [inline]
>  __do_compat_sys_sendmsg net/compat.c:649 [inline]
>  __se_compat_sys_sendmsg net/compat.c:646 [inline]
>  __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
>  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
>  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
>  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7fa0d99
> Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000ffb27c7c EFLAGS: 00000246 ORIG_RAX: 0000000000000172
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200002c0
> RDX: 0000000000000000 RSI: 00000000080ea078 RDI: 00000000ffb27cd0
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
>  kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
>  kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
>  slab_alloc_node mm/slub.c:2801 [inline]
>  __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4420
>  __kmalloc_reserve net/core/skbuff.c:142 [inline]
>  __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
>  alloc_skb include/linux/skbuff.h:1081 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1175 [inline]
>  netlink_sendmsg+0x7d3/0x14d0 net/netlink/af_netlink.c:1893
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg net/socket.c:672 [inline]
>  ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2345
>  ___sys_sendmsg net/socket.c:2399 [inline]
>  __sys_sendmsg+0x451/0x5f0 net/socket.c:2432
>  __compat_sys_sendmsg net/compat.c:642 [inline]
>  __do_compat_sys_sendmsg net/compat.c:649 [inline]
>  __se_compat_sys_sendmsg net/compat.c:646 [inline]
>  __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
>  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
>  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
>  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> =====================================================

-- 
paul moore
www.paul-moore.com
