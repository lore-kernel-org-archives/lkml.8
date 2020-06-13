Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F2AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991EC2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="my06dzPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgFMRYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 13:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFMRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 13:24:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E897C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:24:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w1so12038490qkw.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cf1LQ5fNlVaS52D8jPent3DcteJDu/0EEO4v1tjBzHI=;
        b=my06dzPhSSbEIyu5q/KzRxPqhmV7g7X6HZGQBthISEXHHGHLCR8KIrJQAB4GNZxZXZ
         Ap/Mz7zT4ISl2+gLiBgKrXbMoyRETtR5K9qbBYL4GfeSSmllrCxU8dNTTJ87l3bRyKvH
         Jha795Cg9jSari6tNgWU9nMoNhii+6/4XfcCoMIdKjCI1rBtGSfMPWrtur4v0Eceo6/w
         16JrAIts0+el7dVKrA8ky4MjlvSHfacRUwj/A8rPRUrWDnN1ZC8274g8pufnnySy+7Tj
         B4q9ZtzdKTZTJa9qDxkVx7LDVsigREOQS1WhPPqgonvrqQcJjbl4nWb+hKKD5N6dRBsp
         sT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cf1LQ5fNlVaS52D8jPent3DcteJDu/0EEO4v1tjBzHI=;
        b=Y/koniKUDhKaqXHNUfuFnC0uSX6ec66Kynm1xdHgeHjK7lrG/CA7dlrmS3mqg+hl1p
         RDiNJ37XID/9DvPRLstQA3D40moQx7fDIzNv306AuoVuDXNr8wHy2VwwV632VeS35/aT
         gISVKRwu30lLdRyCHA5qzQgiOoLjQT3z2NErCjB/yAbRCKEh5C/jrJ1jTfLR83K+mbBO
         0syNd5Zd1cfh5AXnm2cuXOyvysEZ5PVtkZnVFCfG0tszd+X8ryKlKGFTGcgKgQZlWxdP
         vLSmHlNbO/Nof5a8WiOh+DPfi0DMACu0pWLDXBF9zLOqjWwoof6XJGh0hgtxBdIJvKcV
         VR/w==
X-Gm-Message-State: AOAM530tBUhOn8xO1QPsbWsszR74ipz4ksF+9Ke/Uc35kAcH7/6G0LMm
        wJEU0lwty1cOyC5lQzc1M7tgaB8Aw6n76v5arIxEFQ==
X-Google-Smtp-Source: ABdhPJyr9IfH4ZqXCZiXBGF+CQKhbBDxwxJAG4HNVAlf3CKvr2ON0HnODB6AzngpptCE+B+m+al+NAqogqzbrO96sLI=
X-Received: by 2002:a05:620a:786:: with SMTP id 6mr7223882qka.407.1592069081942;
 Sat, 13 Jun 2020 10:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200605082839.226418-1-elver@google.com> <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
 <20200605120352.GJ3976@hirez.programming.kicks-ass.net> <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
 <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com>
 <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
 <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net> <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com> <20200612114900.GA187027@google.com>
In-Reply-To: <20200612114900.GA187027@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 13 Jun 2020 19:24:29 +0200
Message-ID: <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions noinstr-compatible
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 1:49 PM Marco Elver <elver@google.com> wrote:
> On Fri, 12 Jun 2020, Dmitry Vyukov wrote:
>
> > On Thu, Jun 11, 2020 at 11:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Jun 08, 2020 at 01:01:08PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Jun 08, 2020 at 09:57:39AM +0200, Dmitry Vyukov wrote:
> > > >
> > > > > As a crazy idea: is it possible to employ objtool (linker script?) to
> > > > > rewrite all coverage calls to nops in the noinstr section? Or relocate
> > > > > to nop function?
> > > > > What we are trying to do is very static, it _should_ have been done
> > > > > during build. We don't have means in existing _compilers_ to do this,
> > > > > but maybe we could do it elsewhere during build?...
> > > >
> > > > Let me try and figure out how to make objtool actually rewrite code.
> > >
> > > The below is quite horrific but seems to sorta work.
> > >
> > > It turns this:
> > >
> > >   12:   e8 00 00 00 00          callq  17 <lockdep_hardirqs_on+0x17>
> > >                         13: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4
> > >
> > > Into this:
> > >
> > >   12:   90                      nop
> > >   13:   90                      nop
> > >                         13: R_X86_64_NONE       __sanitizer_cov_trace_pc-0x4
> > >   14:   90                      nop
> > >   15:   90                      nop
> > >   16:   90                      nop
> > >
> > >
> > > I'll have to dig around a little more to see if I can't get rid of the
> > > relocation entirely. Also, I need to steal better arch_nop_insn() from
> > > the kernel :-)
> >
> > Wow! Cool!
> > Thanks for resolving this. I guess this can be used to wipe more
> > unwanted things in future :)
> >
> > Marco double checked and his patch did not actually fix the existing
> > crash under KCSAN. The call itself was the problem or something,
> > returning early did not really help. This should hopefully fix it.
> > Marco, please double check.
> >
> > Re better nop insn, I don't know how much work it is (or how much you
> > are striving for perfection :)). But from KCOV point of view, I think
> > we can live with more or less any nop insn. The main thing was
> > removing overhead from all other (not noinstr) cases, I would assume
> > the noinstr cases where we use nops are very rare. I mean don't spend
> > too much time on it, if it's not needed for something else.
> >
> > Thanks again!
>
> This is great, thanks! To make noinstr not call into KCOV, this
> definitely seems to do the job.
>
> Though sadly it doesn't fix the problem I'm seeing. The problem occurs
> when I compile using Clang, and enable either KASAN or KCSAN together
> with KCOV. Actually, turning off KCOV also shows this... a stacktrace is
> below.

I can't reproduce this after tuning off KCOV. Just KASAN works for me.
Also the following helps (at least for my config):

diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b9..8514519bc5bcb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -17,6 +17,7 @@ KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 KCOV_INSTRUMENT_fault-inject.o := n
+KCOV_INSTRUMENT_smp_processor_id.o := n


Btw, do you use inline instrumentation for KASAN or outline?
I use inline KASAN, so maybe it's a function call that's the problem.
KCOV uses calls and KCSAN also uses calls.

And it's not that we are getting that "BUG:", right? Otherwise we
would see it in non-KCOV builds as well. So it must be something in
the very beginning of the function...




> The repro is this one: https://syzkaller.appspot.com/x/repro.c?x=1017ef06100000
>
> I don't quite understand what's going on here. Maybe the inserted
> instrumentation causes the compiler to spill more things onto the stack
> and somehow blow that? The nops obviously won't help with that. :-/
>
> I'll try to debug and understand this some more. Also this is of course
> on top of:
> https://lore.kernel.org/lkml/20200604102241.466509982@infradead.org/
>
> But, again, for disabling KCOV instrumentation in noinstr, I believe
> your patch does what we want. In future, when we get compiler support
> for __no_sanitize_coverage, the logic you're adding to objtool can
> probably stay but shouldn't be invoked if the compiler is doing its job.
>
> Thanks,
> -- Marco
>
> ------ >8 ------
>
> traps: PANIC: double fault, error_code: 0x0
> double fault: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 513 Comm: a.out Not tainted 5.7.0+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
> RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:79 [inline]
> RIP: 0010:check_preemption_disabled+0x60/0x120 lib/smp_processor_id.c:19
> Code: 7f 74 27 90 90 90 90 90 65 48 8b 04 25 28 00 00 00 48 3b 44 24 08 0f 85 c6 00 00 00 89 d8 48 83 c4 10 5b 41 5c 41 5e 41 5f c3 <9c> 8f 04 24 f7 04 24 00 02 00 00 75 07 90 90 90 90 90 eb ca 65 4c
> RSP: 0018:fffffe0000094ff8 EFLAGS: 00010046
> RAX: 0000000080000000 RBX: 0000000000000003 RCX: ffffffffacc00ef7
> RDX: 0000000000000000 RSI: ffffffffad29c4f2 RDI: ffffffffad21fe08
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffffad29c4f2 R15: ffffffffad21fe08
> FS:  0000000001d26880(0000) GS:ffffa16e5fcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffe0000094fe8 CR3: 00000008147bc002 CR4: 0000000000760ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <ENTRY_TRAMPOLINE>
>  __this_cpu_preempt_check+0x18/0x1a lib/smp_processor_id.c:65
>  fixup_bad_iret+0x2e/0xe0 arch/x86/kernel/traps.c:678
>  error_entry+0xd5/0xe0 arch/x86/entry/entry_64.S:937
> RIP: 0010:native_irq_return_iret+0x0/0x2
> Code: 5d 41 5c 5d 5b 41 5b 41 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4 08 eb 0b 66 66 2e 0f 1f 84 00 00 00 00 00 f6 44 24 20 04 75 02 <48> cf 57 0f 01 f8 66 90 0f 20 df 48 0f ba ef 3f 48 81 e7 ff e7 ff
> RSP: 0018:fffffe00000951d8 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> RIP: 0033:0x3bfd19e0df38d197
> Code: Bad RIP value.
> RSP: 002b:00007ffd10c4c948 EFLAGS: 00000313 </ENTRY_TRAMPOLINE>
> Modules linked in:
> ---[ end trace df1b33281490ebc3 ]---
> RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
> RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:79 [inline]
> RIP: 0010:check_preemption_disabled+0x60/0x120 lib/smp_processor_id.c:19
> Code: 7f 74 27 90 90 90 90 90 65 48 8b 04 25 28 00 00 00 48 3b 44 24 08 0f 85 c6 00 00 00 89 d8 48 83 c4 10 5b 41 5c 41 5e 41 5f c3 <9c> 8f 04 24 f7 04 24 00 02 00 00 75 07 90 90 90 90 90 eb ca 65 4c
> RSP: 0018:fffffe0000094ff8 EFLAGS: 00010046
> RAX: 0000000080000000 RBX: 0000000000000003 RCX: ffffffffacc00ef7
> RDX: 0000000000000000 RSI: ffffffffad29c4f2 RDI: ffffffffad21fe08
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffffad29c4f2 R15: ffffffffad21fe08
> FS:  0000000001d26880(0000) GS:ffffa16e5fcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffe0000094fe8 CR3: 00000008147bc002 CR4: 0000000000760ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
