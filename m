Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13158C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 00:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFC2206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 00:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585442259;
	bh=Qlp6BZ4t5XQH9C8jwKsJerUmPblT2TiEfFWsOARzxZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wqKjn0Xcs5QyTtedpS5OAkq80RQukkeaMcKX+6CG+HQx966E14sfjfAoGlQJB/3qq
	 qXO6KUAUHBqLAonxbXY0Opcnb7vs1eBzHpe43RzYLFVcnMpZtyRwxyrrqAG5VQscZH
	 ppwalvL3ysoFYQB9oJYvaT66FiUuwNgDtsUp47Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgC2Ahi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 20:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbgC2Ahh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 20:37:37 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB982076E
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 00:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585442256;
        bh=Qlp6BZ4t5XQH9C8jwKsJerUmPblT2TiEfFWsOARzxZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NgCXivyvkn8UwbtGnZXrue2/vpMxe7MI1ssZ9c7wzzkxxBeFvrGLl3dRf18cJvULj
         TxIdfQTtXX4jXJWsgWEiiuLQ3+HlTNtxwo7BK7b389kvVVtxZevU3h3acUtWiJZ1HO
         wUg3cXQveat/9ahOR4hsM0Ac7lDLSiq5cxxOaB0M=
Received: by mail-wm1-f43.google.com with SMTP id d198so15857034wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 17:37:36 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2yW2ij1xKWfCUkBP2iTl0BCJJCG19YOeRUkLntaFxs76YI+BiV
        KwCql5Ki1tnfku0w1hG+4kgU8XDYXADZ6WTVTBpQbg==
X-Google-Smtp-Source: ADFU+vu7ohbD1F++3/l1oonpWI/O7Y/x7HTLga+w/7WcQZ+TQ37tVQLWtyjq0lFNZ2riZY1yh9je0TJyqg/gpbxmwUU=
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr5917421wmm.176.1585442254786;
 Sat, 28 Mar 2020 17:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000960ee605a1ef4d4e@google.com>
In-Reply-To: <000000000000960ee605a1ef4d4e@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Mar 2020 17:37:23 -0700
X-Gmail-Original-Message-ID: <CALCETrVR_qcUPpi2=5QYUVu8VugouYcJ_j4R2jsG4QzggowGsA@mail.gmail.com>
Message-ID: <CALCETrVR_qcUPpi2=5QYUVu8VugouYcJ_j4R2jsG4QzggowGsA@mail.gmail.com>
Subject: framebuffer bug (Re: general protection fault in do_syscall_64)
To:     syzbot <syzbot+f9b2c53f55a9270fc778@syzkaller.appspotmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 12:34 PM syzbot
<syzbot+f9b2c53f55a9270fc778@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    69c5eea3 Merge branch 'parisc-5.6-2' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14d3517be00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
> dashboard link: https://syzkaller.appspot.com/bug?extid=f9b2c53f55a9270fc778
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15059d05e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e5d5a3e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f9b2c53f55a9270fc778@syzkaller.appspotmail.com

Hi framebuffer people-

Somewhere in the framebuffer code is a horrible bug that spews zeros
over kernel memory (including text, suggesting a *physical* memory
overrun).  My suspicion is that there is insufficient validation in
the ioctls that set font parameters.

Could someone who is actually familiar with this code take a look?

--Andy

>
> general protection fault, probably for non-canonical address 0x1ffffffff1215a85: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 7207 Comm: syz-executor045 Not tainted 5.6.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:do_syscall_64+0x5f/0x1b0 arch/x86/entry/common.c:289
> Code: 48 c7 c7 28 d4 0a 89 e8 bf 5d b0 00 48 83 3d af 5b 0a 08 00 0f 84 58 01 00 00 fb 66 0f 1f 44 00 00 65 48 8b 1c 25 c0 1d 02 00 <48> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 0018:ffffc90001617f28 EFLAGS: 00010282
> RAX: 1ffffffff1215a85 RBX: ffff888095530380 RCX: ffff888095530380
> RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888095530bc4
> RBP: 0000000000000000 R08: ffffffff817a2210 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000023
> R13: dffffc0000000000 R14: ffffc90001617f58 R15: 0000000000000000
> FS:  0000000001333880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f87bf9aae78 CR3: 00000000a6a3f000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4454e1
> Code: 75 14 b8 23 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 64 1f fc ff c3 48 83 ec 08 e8 9a 42 00 00 48 89 04 24 b8 23 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 e3 42 00 00 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffd72d164b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00000000004454e1
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd72d164c0
> RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffd72d164e0 R11: 0000000000000293 R12: 0000000000000000
> R13: 00000000006dbc2c R14: 000000000000000a R15: 0000000000000000
> Modules linked in:
> ---[ end trace 3da67f82bf6bae14 ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:do_syscall_64+0x5f/0x1b0 arch/x86/entry/common.c:289
> Code: 48 c7 c7 28 d4 0a 89 e8 bf 5d b0 00 48 83 3d af 5b 0a 08 00 0f 84 58 01 00 00 fb 66 0f 1f 44 00 00 65 48 8b 1c 25 c0 1d 02 00 <48> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 0018:ffffc90001617f28 EFLAGS: 00010282
> RAX: 1ffffffff1215a85 RBX: ffff888095530380 RCX: ffff888095530380
> RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888095530bc4
> RBP: 0000000000000000 R08: ffffffff817a2210 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000023
> R13: dffffc0000000000 R14: ffffc90001617f58 R15: 0000000000000000
> FS:  0000000001333880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f87bf9aae78 CR3: 00000000a6a3f000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
