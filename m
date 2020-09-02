Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6401EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B1520767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599065373;
	bh=XR0ioxTHhgnmW+APV6MJ8653PvIb+IbdXMJ/L262yIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o3yGz+IigstY/UZbxs0UYQpLuf9NHWNTIWzbUzJwOUuoJJB24Sair57eIz803vR1E
	 fnO+a619KRhEu2SXYjVPv24iR/FwKdyX8lUy2PnoxDJYPPN5XCUUJLO1to9rmtRFgh
	 P34XnnD9DR7rB3ND+RVAzifxymqDX8xwswZWb6mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgIBQtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIBQt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:49:28 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3F0214D8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599065365;
        bh=XR0ioxTHhgnmW+APV6MJ8653PvIb+IbdXMJ/L262yIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yCKm0wrVB74qj3jw82cs0MgZUIlwGzPQXQFP6ZuO40pNawuw4cIufN3xECk17Q68D
         +XJK88TBkbspRcpkaD+qfTrn1Yj8kN01YzDEIW+cTtdjW9IQd/vWVAcNf2HS+YpAQw
         Qub36Ra1vc8yn5M1Qyepr+GdktruN1W9YMf13gzM=
Received: by mail-wr1-f46.google.com with SMTP id e16so158202wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:49:25 -0700 (PDT)
X-Gm-Message-State: AOAM5334kjAcKw8vwuEEAhFalvA7h7eROJ/wpssVGHhIp+or6YLGiAVZ
        nz13E7oOjR94el9xQTnt/ON1ZwdD7ysb/1Nssi/DUA==
X-Google-Smtp-Source: ABdhPJzuKT0sfcowI/nWvlApJfMvKhzeXclG1LZhrt0Xb8lws/Eopixjlgz5qHcNlR7RUw8PQzrZUHdg4O8Gmb7W1mQ=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr7992214wrn.257.1599065364055;
 Wed, 02 Sep 2020 09:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
 <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
 <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com>
 <87k0xdjbtt.fsf@nanos.tec.linutronix.de> <CALCETrUpjUPPvnPuS9fP4jgid7U_qdU_yTKSq9PjJ=z2w9HvHg@mail.gmail.com>
 <87blioinub.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blioinub.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 2 Sep 2020 09:49:12 -0700
X-Gmail-Original-Message-ID: <CALCETrUuyXpG0Vhrb-9m-G8J94+2bGqdrJkKfz+-5z7dsGLK8Q@mail.gmail.com>
Message-ID: <CALCETrUuyXpG0Vhrb-9m-G8J94+2bGqdrJkKfz+-5z7dsGLK8Q@mail.gmail.com>
Subject: Re: ptrace_syscall_32 is failing
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 1:29 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Sep 01 2020 at 17:09, Andy Lutomirski wrote:
> > On Tue, Sep 1, 2020 at 4:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > I think that they almost work for x86, but not quite as
> >> > indicated by this bug.  Even if we imagine we can somehow hack around
> >> > this bug, I imagine we're going to find other problems with this
> >> > model, e.g. the potential upcoming exit problem I noted in my review.
> >>
> >> What's the upcoming problem?
> >
> > If we ever want to get single-stepping fully correct across syscalls,
> > we might need to inject SIGTRAP on syscall return. This would be more
> > awkward if we can't run instrumentable code after the syscall part of
> > the syscall is done.
>
> We run a lot of instrumentable code after sys_foo() returns. Otherwise
> all the TIF work would not be possible at all.
>
> But you might tell me where exactly you want to inject the SIGTRAP in
> the syscall exit code flow.

It would be a bit complicated.  Definitely after any signals from the
syscall are delivered.  Right now, I think that we don't deliver a
SIGTRAP on the instruction boundary after SYSCALL while
single-stepping.  (I think we used to, but only sometimes, and now we
are at least consistent.)  This is because IRET will not trap if it
starts with TF clear and ends up setting it.  (I asked Intel to
document this, and I think they finally did, although I haven't gotten
around to reading the new docs.  Certainly the old docs as of a year
or two ago had no description whatsoever of how TF changes worked.)

Deciding exactly *when* a trap should occur would be nontrivial -- we
can't trap on sigreturn() from a SIGTRAP, for example.

So this isn't fully worked out.

>
> >> I don't think we want that in general. The current variant is perfectly
> >> fine for everything except the 32bit fast syscall nonsense. Also
> >> irqentry_entry/exit is not equivalent to the syscall_enter/exit
> >> counterparts.
> >
> > If there are any architectures in which actual work is needed to
> > figure out whether something is a syscall in the first place, they'll
> > want to do the usual kernel entry work before the syscall entry work.
>
> That's low level entry code which does not require RCU, lockdep, tracing
> or whatever muck we setup before actual work can be done.
>
> arch_asm_entry()
>   ...
>   arch_c_entry(cause) {
>     switch(cause) {
>       case EXCEPTION: arch_c_exception(...);
>       case SYSCALL: arch_c_syscall(...);
>       ...
>     }

You're assuming that figuring out the cause doesn't need the kernel
entry code to run first.  In the case of the 32-bit vDSO fast
syscalls, we arguably don't know whether an entry is a syscall until
we have done a user memory access.  Logically, we're doing:

if (get_user() < 0) {
  /* Not a syscall.  This is actually a silly operation that sets AX =
-EFAULT and returns.  Do not audit or invoke ptrace. */
} else {
  /* This actually is a syscall. */
}

So we really do want to stick arch code between the
enter_from_user_mode() and the audit check.  We *can't* audit because
we don't know the syscall args.  Now maybe we could invent new
semantics for this in which a fault here is still somehow a syscall,
but I think that would be a real ABI change and would want very
careful thought.  And it would be weird -- syscalls are supposed to
actually call the syscall handler, aren't they?  (Arguably we should
go back in time and make this a SIGSEGV.  We have the infrastructure
to do this cleanly, but when I wrote the code I just copied the ABI
from code that was before my time.  Even so, it would be an exception,
not a syscall.)

>
> You really want to differentiate between exception and syscall
> entry/exit.
>

Why do we want to distinguish between exception and syscall
entry/exit?  For the enter part, AFAICS the exception case boils down
to enter_from_user_mode() and the syscall case is:

        enter_from_user_mode(regs);
        instrumentation_begin();

        local_irq_enable();
        ti_work = READ_ONCE(current_thread_info()->flags);
        if (ti_work & SYSCALL_ENTER_WORK)
                syscall = syscall_trace_enter(regs, syscall, ti_work);
        instrumentation_end();

Which would decompose quite nicely as a regular (non-syscall) entry
plus the syscall part later.

> The splitting of syscall_enter_from_user_mode() is only necessary for
> that 32bit fast syscall thing on x86 and there is no point to open code
> it with two calls for e.g. do_syscall_64().
>
> > Maybe your patch actually makes this possible -- I haven't digested
> > all the details yet.
> >
> > Who advised you to drop the arch parameter?
>
> Kees, IIRC, but I would have to search through the gazillions of mail
> threads to be sure.
>
> >> +       syscall_enter_from_user_mode_prepare(regs);
> >
> > I'm getting lost in all these "enter" functions...
>
> It's not that hard.
>
>      syscall_enter_from_user_mode_prepare()
> +    syscall_enter_from_user_mode_work()
> =    syscall_enter_from_user_mode()
>
> That's exactly what you suggested just with the difference that it is
> explicit for syscalls and not using irqentry_enter/exit().
>
> If we would do that then instead of having a single call for sane
> syscall pathes:
>
>   arch_c_entry()
>      nr = syscall_enter_from_user_mode();
>
> or for that 32bit fast syscall nonsense the split variant:
>
>   arch_c_entry()
>      syscall_enter_from_user_mode_prepare();
>      do_fast_syscall_muck();
>      nr = syscall_enter_from_user_mode_work();
>
> we'd have:
>
>   arch_c_entry()
>      irqentry_enter();
>      local_irq_enble();
>      nr = syscall_enter_from_user_mode_work();
>      ...
>
> which enforces two calls for sane entries and more code in arch/....

This is why I still like my:

arch_c_entry()
  irqentry_enter_from_user_mode();
  generic_syscall();
  exit...
}
