Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEFAC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5711F2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pxLEzOmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBXWbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:31:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46305 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgBXWbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:31:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id p14so13817143edy.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1+xf/91VEGcnGcVJFtk+JLwutL06o8ZnFL54+b0xTQ=;
        b=pxLEzOmJ2sIlEPMEgymJngKHYjP9h+cdYWqUoUQRz9QzkAhU0R1gOxcMHBIl9K96gO
         6ZjPjMpyDR7NU2Jh9QDYTeNQUTV8rymrIHJSltOCLnygfP7bYtK/BMu5tWY2daUSBW6B
         TgJQb3kty9KTJtRH4qTQ9jxj6jBHxHAF6GuTPbHe6HP6QG3W4i/bMr+iejXUm7VHTNo3
         z16p3/YBmMbvBfFMxcaTfWKi3w1l0QElyXwCxWpeAQ8/sRW/OFmV4Z3UohioZhwwP+dO
         eOQW3vK7SP+m18mN/TbtqqJLJeqbm+CxLIM6jg8WGWuDtHxpzbPNLQkxdJ14Pl/T1I7D
         HPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1+xf/91VEGcnGcVJFtk+JLwutL06o8ZnFL54+b0xTQ=;
        b=Bb9U9zlPgy+p1BQ70w282qSPJiPl9Zg8K3YfjDifc8WuLZZFtRIpt71NOhHrQWegP7
         uqBcJEHgqm4ppHDjtNVQopruy6K1ySlRlgwhemewlaEfcCxj3CKvcbVkZpgEgvPJeALM
         kTmxQre7kYef+zyWQlKLrYVY9zRljAeMukaTlm/PGqrtGKVwhgvD7hf56sDd4KQ0EBGb
         HMBkMmTYF/c+WlrPERbfjd2t96TY6KNXFaicFlJnc9RO58fVNZRADTE5TIRHfhhsbmDr
         UE5JkrFzOmGdq014riUs94khWBMrRPQCIr2gRbYFvYpennxXr+j3of0Hnd96keRHjiJu
         EEdg==
X-Gm-Message-State: APjAAAVSBpON6G6MJMG6euszJtQb3fMVdMruB96sND2vV5+JL4+vMrez
        5QIeYaDplhqFXsgS9n0p2srOr3K3JXLDxS9zLBIR
X-Google-Smtp-Source: APXvYqyBneNBBzfUR07VIESGO2wz3HrjOgPWUq5aInT2EWIsajlWwC7ntX7qFMXz0aqfABaj6c/xmcTmVbIiiirgNCU=
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr47885489ejb.308.1582583471733;
 Mon, 24 Feb 2020 14:31:11 -0800 (PST)
MIME-Version: 1.0
References: <000000000000fac9a5059f4e266d@google.com>
In-Reply-To: <000000000000fac9a5059f4e266d@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Feb 2020 17:31:00 -0500
Message-ID: <CAHC9VhSejmXqHLEPQVOqyr5agUNVJ+V5SQJnbSuZ6WPSEox6KQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in audit_log_vformat
To:     syzbot <syzbot+e4b12d8d202701f08b6d@syzkaller.appspotmail.com>
Cc:     Eric Paris <eparis@redhat.com>, glider@google.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 3:28 AM syzbot
<syzbot+e4b12d8d202701f08b6d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8bbbc5cf kmsan: don't compile memmove
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d7c109e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4b12d8d202701f08b6d
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1287fdd9e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ffec81e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e4b12d8d202701f08b6d@syzkaller.appspotmail.com
>
> =====================================================
> BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:608 [inline]
> BUG: KMSAN: uninit-value in string+0x522/0x690 lib/vsprintf.c:689
> CPU: 1 PID: 12069 Comm: syz-executor170 Not tainted 5.6.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
>  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
>  string_nocheck lib/vsprintf.c:608 [inline]
>  string+0x522/0x690 lib/vsprintf.c:689
>  vsnprintf+0x207d/0x31b0 lib/vsprintf.c:2574
>  audit_log_vformat+0x583/0xcd0 kernel/audit.c:1856
>  audit_log_format+0x220/0x260 kernel/audit.c:1890
>  audit_receive_msg kernel/audit.c:1338 [inline]
>  audit_receive+0x3688/0x6be0 kernel/audit.c:1513
>  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
>  netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1328
>  netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1917
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg net/socket.c:672 [inline]
>  ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2343
>  ___sys_sendmsg net/socket.c:2397 [inline]
>  __sys_sendmsg+0x451/0x5f0 net/socket.c:2430
>  __compat_sys_sendmsg net/compat.c:642 [inline]
>  __do_compat_sys_sendmsg net/compat.c:649 [inline]
>  __se_compat_sys_sendmsg net/compat.c:646 [inline]
>  __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
>  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
>  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
>  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f12d99
> Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000ffadf8ac EFLAGS: 00000246 ORIG_RAX: 0000000000000172
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000200
> RDX: 0000000000000000 RSI: 00000000080ea080 RDI: 00000000ffadf900
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
>  kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
>  kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
>  slab_alloc_node mm/slub.c:2793 [inline]
>  __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4401
>  __kmalloc_reserve net/core/skbuff.c:142 [inline]
>  __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
>  alloc_skb include/linux/skbuff.h:1051 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1174 [inline]
>  netlink_sendmsg+0x7d3/0x14d0 net/netlink/af_netlink.c:1892
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg net/socket.c:672 [inline]
>  ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2343
>  ___sys_sendmsg net/socket.c:2397 [inline]
>  __sys_sendmsg+0x451/0x5f0 net/socket.c:2430
>  __compat_sys_sendmsg net/compat.c:642 [inline]
>  __do_compat_sys_sendmsg net/compat.c:649 [inline]
>  __se_compat_sys_sendmsg net/compat.c:646 [inline]
>  __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
>  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
>  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
>  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> =====================================================

I found and fixed this while fixing the other audit uninit var problem
found by syzbot.

-- 
paul moore
www.paul-moore.com
