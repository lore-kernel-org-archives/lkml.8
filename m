Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0107C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10CB20768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="uGhj/C0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHNTDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHNTDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:03:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C84C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:03:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so3026564plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=FxfL4nNBtn83VJwRlrrSOfWZbqLm3WkoDXTSi56b1Aw=;
        b=uGhj/C0dfHB7n5e7xIx5kV1OYPEWOvCViVjH30qdyFEu7Bh7oHsXyeSLflm05F+MiD
         hz3uOPsd+7OG0nCIJ5YtqKQ5qquqtwieHcotkrFWEWXuMqMGg0bC5wYD2gr9cgz+0+gx
         ltMGaxOdARbFUgW8w6/3/PBMn244tPeUbOM+6W00xWphbtgyx2c6GeVHaupzcsUdqwEF
         z8ktfTCjuEr5Mv4VxgqjF9dfSd/laFDWbu9vM+LcXQXCv/Xic27/jVnZntuzq872sDJq
         /JUGYIGCerRplUGPcue1ruBDhR06qfs5++fA0YCEc04E9I6ZGMSrUSDOxc+CMhz2VZma
         NNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FxfL4nNBtn83VJwRlrrSOfWZbqLm3WkoDXTSi56b1Aw=;
        b=Fnut16nVsMszoXBTQPwoDvowxjUtP3kRnxaU4uxsJ8kbHT9q7scPhYtZNJgFRr7suB
         XM2fTjPu6ErqYesDCs9CKnICa9xJlHd56ZUFEmg6jdTH0UywssWyPgrBPipwmkbFo3LM
         ZXRPr5U2J6n9SXhASLie7fH0IFMrt0raIEzr98aeghHlVl0VoTUhBDVRQ2MkcWZkAEjH
         DqPFblMDbZu2MTqwIRkiKpD5hE72tdx1iMC92vn88K+/hJJJI2KTCO0LdwZQIyT1VrGG
         BSA1qLFlpWvEdB4U7SXt7PPaHt3HFcmhhG0NFVMlwfqQYF2//ZVNNQ9Xq6C287m5gn86
         +Bzw==
X-Gm-Message-State: AOAM5318A/rVHDMy9pZXSE+cb3pb2wSPyra0hEfXzpnhEm3o4m5bjCK7
        P/FeQWbGBizjolS1kj+E/hwQ2A==
X-Google-Smtp-Source: ABdhPJylDMIU7c7fblv3DX/ADsvr6mkOI92HT1s4lS9GCbfOUWAsJAg3CP5ak5yfTOSRfHFLZ+glsg==
X-Received: by 2002:a17:902:a404:: with SMTP id p4mr3105916plq.35.1597431809200;
        Fri, 14 Aug 2020 12:03:29 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3949:6711:2d80:a044? ([2601:646:c200:1ef2:3949:6711:2d80:a044])
        by smtp.gmail.com with ESMTPSA id bv17sm8718663pjb.0.2020.08.14.12.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 12:03:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task
Date:   Fri, 14 Aug 2020 12:03:26 -0700
Message-Id: <784A8221-8E96-4C81-B218-4BC4960AA34A@amacapital.net>
References: <20200814181617.442787-1-edumazet@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20200814181617.442787-1-edumazet@google.com>
To:     Eric Dumazet <edumazet@google.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 14, 2020, at 11:16 AM, Eric Dumazet <edumazet@google.com> wrote:
>=20
> =EF=BB=BFsyzbot found its way in 86_fsgsbase_read_task() [1]
>=20
> Fix is to make sure ldt pointer is not NULL

Acked-by: Andy Lutomirski <luto@kernel.org>

Maybe add something like this to the changelog:

This can happen if ptrace() or sigreturn() pokes an LDT selector into FS or G=
S for a task with no LDT and something tries to read the base before a retur=
n to usermode notices the bad selector and fixes it.

I=E2=80=99ll see if I can whip up a test case too.

>=20
> [1]
> general protection fault, probably for non-canonical address 0xdffffc00000=
00001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 6866 Comm: syz-executor262 Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Go=
ogle 01/01/2011
> RIP: 0010:x86_fsgsbase_read_task+0x16d/0x310 arch/x86/kernel/process_64.c:=
393
> Code: 3c 02 00 0f 85 7c 01 00 00 4c 8b a5 80 04 00 00 44 0f b7 eb 48 b8 00=
 00 00 00 00 fc ff df 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c=
0 74 08 3c 03 0f 8e 30 01 00 00 45 3b 6c 24 08 0f
> RSP: 0018:ffffc90001677db8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000008
> RBP: ffff88809eaf9780 R08: 0000000000000000 R09: ffff88809eaf9c17
> R10: ffffed1013d5f382 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020000080
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:0000000009cf48=
40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 000000009fa0d000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> putreg32+0x3ab/0x530 arch/x86/kernel/ptrace.c:876
> genregs32_set arch/x86/kernel/ptrace.c:1026 [inline]
> genregs32_set+0xa4/0x100 arch/x86/kernel/ptrace.c:1006
> copy_regset_from_user include/linux/regset.h:326 [inline]
> ia32_arch_ptrace arch/x86/kernel/ptrace.c:1061 [inline]
> compat_arch_ptrace+0x36c/0xd90 arch/x86/kernel/ptrace.c:1198
> __do_compat_sys_ptrace kernel/ptrace.c:1420 [inline]
> __se_compat_sys_ptrace kernel/ptrace.c:1389 [inline]
> __ia32_compat_sys_ptrace+0x220/0x2f0 kernel/ptrace.c:1389
> do_syscall_32_irqs_on arch/x86/entry/common.c:84 [inline]
> __do_fast_syscall_32+0x57/0x80 arch/x86/entry/common.c:126
> do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:149
> entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> RIP: 0023:0xf7fe9569
> Code: 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8=
 01 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 9=
0 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000ffd99e7c EFLAGS: 00000217 ORIG_RAX: 000000000000001a
> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 0000000000001ad1
> RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000001ad1
> RBP: 000000000000003c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace f79c8042700af7c5 ]---
> RIP: 0010:x86_fsgsbase_read_task+0x16d/0x310 arch/x86/kernel/process_64.c:=
393
> Code: 3c 02 00 0f 85 7c 01 00 00 4c 8b a5 80 04 00 00 44 0f b7 eb 48 b8 00=
 00 00 00 00 fc ff df 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c=
0 74 08 3c 03 0f 8e 30 01 00 00 45 3b 6c 24 08 0f
> RSP: 0018:ffffc90001677db8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000008
> RBP: ffff88809eaf9780 R08: 0000000000000000 R09: ffff88809eaf9c17
> R10: ffffed1013d5f382 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020000080
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:0000000009cf48=
40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 000000009fa0d000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>=20
> Fixes: 07e1d88adaae ("x86/fsgsbase/64: Fix ptrace() to read the FS/GS base=
 accurately")
> Co-developed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Markus T Metzger <markus.t.metzger@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ravi Shankar <ravi.v.shankar@intel.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
> arch/x86/kernel/process_64.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index d6f946707270e41d4aa04e4069b1b4eb82afd687..8393ee1aa9c89b3712b7aef510=
149d73762ef314 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -390,7 +390,7 @@ unsigned long x86_fsgsbase_read_task(struct task_struc=
t *task,
>         */
>        mutex_lock(&task->mm->context.lock);
>        ldt =3D task->mm->context.ldt;
> -        if (unlikely(idx >=3D ldt->nr_entries))
> +        if (unlikely(ldt =3D=3D NULL || idx >=3D ldt->nr_entries))
>            base =3D 0;
>        else
>            base =3D get_desc_base(ldt->entries + idx);
> --=20
> 2.28.0.220.ged08abb693-goog
>=20
