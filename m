Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B77EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23E32065C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSkDfGRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLLtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:49:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28412C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:49:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so9432843wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pwTj7/MvX3JGzDpMDfm+azC8Rd5H8H49BAN8154oFlU=;
        b=qSkDfGRJcjyH8mePvinYu26CXJbH2v95UHxdVM9/ZPdLCbVpC0n8sv1tGB98U2xK3n
         986Yxon49VgIxiG94yFGXYwL6mWKd75a/g+5/VFJLzLx3oOm2YGsqjmHjg458Mc6hFni
         ZvWd8sgpiPgJh66+E/loXkN1TzpWiMYOnVN3GCPViCb8fk0o7jhDh+hbcW7/MSc+Jc6v
         a5piESXE1w+WXIt+xqRVX4WR2XdkaTaR+e3V5blmOIe/YnzGAQKXBwTowYEryReIFkob
         Ley7EZ0Em34M7iq0KBiCrVcDY1N5Fd/ro1S8RzYAPQnj2Pt28oqmzO66I9FXMTpHAkrL
         XY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwTj7/MvX3JGzDpMDfm+azC8Rd5H8H49BAN8154oFlU=;
        b=pIuq/qHPemqFDS1KTF0/g/WMFvz9AUbkQmMmsPikGyql0Dd1XonSf1cfBdJHf+ACBU
         wnE3G7I18uT/fKYzzOctbLkMoO9acYN+PqPZ3M02q7g/SQhPG1YhKImnFw+yxsqdOLdy
         0FlR++xkw97EqEiJS1SgfHZiQf28+g/Q15vBJ9uTVS/My4lrWIr6QhwIgDyU+eiXWSDJ
         Uskx3awSmff6Pl9tAR/LDjlQp+awK68Ozu9fK5mEp0U3s0SdKrYrrGTUlUvmslR5tbgD
         Lnv3r67t4dtYd/c7393qLpdx5djiPlA1krUthStIN6p4QoTdsQn6VjVl9wGqanADrnRo
         fFOQ==
X-Gm-Message-State: AOAM530APMYm3sW4oOPE0ZKZkR8McBr/Q0+MXxp9CpBhCPrPzgoe1bJ0
        rrZi2kwi9fMWQ8r+vzlaNiS54Q==
X-Google-Smtp-Source: ABdhPJyWzX5t2kxQYROMAAQr69iV4RZeLAdWRQJedrSK70UL4trbvkdfMC6J4gtnFKWoqLqh7uIB/Q==
X-Received: by 2002:a5d:54c3:: with SMTP id x3mr14208973wrv.312.1591962546505;
        Fri, 12 Jun 2020 04:49:06 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id z25sm8451339wmf.10.2020.06.12.04.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 04:49:05 -0700 (PDT)
Date:   Fri, 12 Jun 2020 13:49:00 +0200
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
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
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200612114900.GA187027@google.com>
References: <20200605082839.226418-1-elver@google.com>
 <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
 <20200605120352.GJ3976@hirez.programming.kicks-ass.net>
 <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
 <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com>
 <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
 <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net>
 <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jun 2020, Dmitry Vyukov wrote:

> On Thu, Jun 11, 2020 at 11:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jun 08, 2020 at 01:01:08PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 08, 2020 at 09:57:39AM +0200, Dmitry Vyukov wrote:
> > >
> > > > As a crazy idea: is it possible to employ objtool (linker script?) to
> > > > rewrite all coverage calls to nops in the noinstr section? Or relocate
> > > > to nop function?
> > > > What we are trying to do is very static, it _should_ have been done
> > > > during build. We don't have means in existing _compilers_ to do this,
> > > > but maybe we could do it elsewhere during build?...
> > >
> > > Let me try and figure out how to make objtool actually rewrite code.
> >
> > The below is quite horrific but seems to sorta work.
> >
> > It turns this:
> >
> >   12:   e8 00 00 00 00          callq  17 <lockdep_hardirqs_on+0x17>
> >                         13: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4
> >
> > Into this:
> >
> >   12:   90                      nop
> >   13:   90                      nop
> >                         13: R_X86_64_NONE       __sanitizer_cov_trace_pc-0x4
> >   14:   90                      nop
> >   15:   90                      nop
> >   16:   90                      nop
> >
> >
> > I'll have to dig around a little more to see if I can't get rid of the
> > relocation entirely. Also, I need to steal better arch_nop_insn() from
> > the kernel :-)
> 
> Wow! Cool!
> Thanks for resolving this. I guess this can be used to wipe more
> unwanted things in future :)
> 
> Marco double checked and his patch did not actually fix the existing
> crash under KCSAN. The call itself was the problem or something,
> returning early did not really help. This should hopefully fix it.
> Marco, please double check.
> 
> Re better nop insn, I don't know how much work it is (or how much you
> are striving for perfection :)). But from KCOV point of view, I think
> we can live with more or less any nop insn. The main thing was
> removing overhead from all other (not noinstr) cases, I would assume
> the noinstr cases where we use nops are very rare. I mean don't spend
> too much time on it, if it's not needed for something else.
> 
> Thanks again!

This is great, thanks! To make noinstr not call into KCOV, this
definitely seems to do the job.

Though sadly it doesn't fix the problem I'm seeing. The problem occurs
when I compile using Clang, and enable either KASAN or KCSAN together
with KCOV. Actually, turning off KCOV also shows this... a stacktrace is
below.

The repro is this one: https://syzkaller.appspot.com/x/repro.c?x=1017ef06100000

I don't quite understand what's going on here. Maybe the inserted
instrumentation causes the compiler to spill more things onto the stack
and somehow blow that? The nops obviously won't help with that. :-/

I'll try to debug and understand this some more. Also this is of course
on top of:
https://lore.kernel.org/lkml/20200604102241.466509982@infradead.org/

But, again, for disabling KCOV instrumentation in noinstr, I believe
your patch does what we want. In future, when we get compiler support
for __no_sanitize_coverage, the logic you're adding to objtool can
probably stay but shouldn't be invoked if the compiler is doing its job.

Thanks,
-- Marco

------ >8 ------

traps: PANIC: double fault, error_code: 0x0
double fault: 0000 [#1] PREEMPT SMP PTI
CPU: 3 PID: 513 Comm: a.out Not tainted 5.7.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:79 [inline]
RIP: 0010:check_preemption_disabled+0x60/0x120 lib/smp_processor_id.c:19
Code: 7f 74 27 90 90 90 90 90 65 48 8b 04 25 28 00 00 00 48 3b 44 24 08 0f 85 c6 00 00 00 89 d8 48 83 c4 10 5b 41 5c 41 5e 41 5f c3 <9c> 8f 04 24 f7 04 24 00 02 00 00 75 07 90 90 90 90 90 eb ca 65 4c
RSP: 0018:fffffe0000094ff8 EFLAGS: 00010046
RAX: 0000000080000000 RBX: 0000000000000003 RCX: ffffffffacc00ef7
RDX: 0000000000000000 RSI: ffffffffad29c4f2 RDI: ffffffffad21fe08
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffffad29c4f2 R15: ffffffffad21fe08
FS:  0000000001d26880(0000) GS:ffffa16e5fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffe0000094fe8 CR3: 00000008147bc002 CR4: 0000000000760ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <ENTRY_TRAMPOLINE>
 __this_cpu_preempt_check+0x18/0x1a lib/smp_processor_id.c:65
 fixup_bad_iret+0x2e/0xe0 arch/x86/kernel/traps.c:678
 error_entry+0xd5/0xe0 arch/x86/entry/entry_64.S:937
RIP: 0010:native_irq_return_iret+0x0/0x2
Code: 5d 41 5c 5d 5b 41 5b 41 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4 08 eb 0b 66 66 2e 0f 1f 84 00 00 00 00 00 f6 44 24 20 04 75 02 <48> cf 57 0f 01 f8 66 90 0f 20 df 48 0f ba ef 3f 48 81 e7 ff e7 ff
RSP: 0018:fffffe00000951d8 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
RIP: 0033:0x3bfd19e0df38d197
Code: Bad RIP value.
RSP: 002b:00007ffd10c4c948 EFLAGS: 00000313 </ENTRY_TRAMPOLINE>
Modules linked in:
---[ end trace df1b33281490ebc3 ]---
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:79 [inline]
RIP: 0010:check_preemption_disabled+0x60/0x120 lib/smp_processor_id.c:19
Code: 7f 74 27 90 90 90 90 90 65 48 8b 04 25 28 00 00 00 48 3b 44 24 08 0f 85 c6 00 00 00 89 d8 48 83 c4 10 5b 41 5c 41 5e 41 5f c3 <9c> 8f 04 24 f7 04 24 00 02 00 00 75 07 90 90 90 90 90 eb ca 65 4c
RSP: 0018:fffffe0000094ff8 EFLAGS: 00010046
RAX: 0000000080000000 RBX: 0000000000000003 RCX: ffffffffacc00ef7
RDX: 0000000000000000 RSI: ffffffffad29c4f2 RDI: ffffffffad21fe08
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffffad29c4f2 R15: ffffffffad21fe08
FS:  0000000001d26880(0000) GS:ffffa16e5fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffe0000094fe8 CR3: 00000008147bc002 CR4: 0000000000760ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
