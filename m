Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC7CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8310206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZBSlId5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eoru9GuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgIDKN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:13:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D0C061244;
        Fri,  4 Sep 2020 03:13:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599214396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z8OvW6DJXZpgU3aKJ+ArJf6u2HaUfprFbOOK8smF874=;
        b=dZBSlId5W09VtfHcoWhseB5XiTBbGXWSjSWG5XFU58ZWYuqDdtM4Ipu9mNGZY+ddAn37dS
        AxDs/0r1rhHicd824BDPwytOgDf8f17n5gdpXS06ccu1J8J02/S3Px3uFgDRLoGRl+PjKM
        bU83O/2nJ/tSYGIE4CElngX6XiPbSOHvrFIlF/46BHUlEwSBUrrrMnzuy1Ks/8KOesKn82
        yzz5TXpXJFv9IUUrWA8fr+U2kWyVy8VmvS31HDRYjYZ0xy05l0NK41J5gNkBa6AjMjEEvi
        SqxPITHKMuMWLYE38SvauwgernJ2tQIyJdf2qZxYvlL917z72wWol9JRX9XuYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599214396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z8OvW6DJXZpgU3aKJ+ArJf6u2HaUfprFbOOK8smF874=;
        b=eoru9GuSlO3Zvk6GwC/O3LrVM2/p6u5L16LR2oCIwbP9/NjUC2FQtUYVwbzdk2rHLSP1Ta
        igirNT0+2/4DKxDw==
To:     Andy Lutomirski <luto@kernel.org>
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
Subject: Re: ptrace_syscall_32 is failing
In-Reply-To: <CALCETrUuyXpG0Vhrb-9m-G8J94+2bGqdrJkKfz+-5z7dsGLK8Q@mail.gmail.com>
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com> <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com> <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com> <87k0xdjbtt.fsf@nanos.tec.linutronix.de> <CALCETrUpjUPPvnPuS9fP4jgid7U_qdU_yTKSq9PjJ=z2w9HvHg@mail.gmail.com> <87blioinub.fsf@nanos.tec.linutronix.de> <CALCETrUuyXpG0Vhrb-9m-G8J94+2bGqdrJkKfz+-5z7dsGLK8Q@mail.gmail.com>
Date:   Fri, 04 Sep 2020 12:13:15 +0200
Message-ID: <87mu254zpg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

On Wed, Sep 02 2020 at 09:49, Andy Lutomirski wrote:
> On Wed, Sep 2, 2020 at 1:29 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> But you might tell me where exactly you want to inject the SIGTRAP in
>> the syscall exit code flow.
>
> It would be a bit complicated.  Definitely after any signals from the
> syscall are delivered.  Right now, I think that we don't deliver a
> SIGTRAP on the instruction boundary after SYSCALL while
> single-stepping.  (I think we used to, but only sometimes, and now we
> are at least consistent.)  This is because IRET will not trap if it
> starts with TF clear and ends up setting it.  (I asked Intel to
> document this, and I think they finally did, although I haven't gotten
> around to reading the new docs.  Certainly the old docs as of a year
> or two ago had no description whatsoever of how TF changes worked.)
>
> Deciding exactly *when* a trap should occur would be nontrivial -- we
> can't trap on sigreturn() from a SIGTRAP, for example.
>
> So this isn't fully worked out.

Oh well.

>> >> I don't think we want that in general. The current variant is perfectly
>> >> fine for everything except the 32bit fast syscall nonsense. Also
>> >> irqentry_entry/exit is not equivalent to the syscall_enter/exit
>> >> counterparts.
>> >
>> > If there are any architectures in which actual work is needed to
>> > figure out whether something is a syscall in the first place, they'll
>> > want to do the usual kernel entry work before the syscall entry work.
>>
>> That's low level entry code which does not require RCU, lockdep, tracing
>> or whatever muck we setup before actual work can be done.
>>
>> arch_asm_entry()
>>   ...
>>   arch_c_entry(cause) {
>>     switch(cause) {
>>       case EXCEPTION: arch_c_exception(...);
>>       case SYSCALL: arch_c_syscall(...);
>>       ...
>>     }
>
> You're assuming that figuring out the cause doesn't need the kernel
> entry code to run first.  In the case of the 32-bit vDSO fast
> syscalls, we arguably don't know whether an entry is a syscall until
> we have done a user memory access.  Logically, we're doing:
>
> if (get_user() < 0) {
>   /* Not a syscall.  This is actually a silly operation that sets AX =
> -EFAULT and returns.  Do not audit or invoke ptrace. */
> } else {
>   /* This actually is a syscall. */
> }

Yes, that's what I've addressed with providing split interfaces.

>> You really want to differentiate between exception and syscall
>> entry/exit.
>>
>
> Why do we want to distinguish between exception and syscall
> entry/exit?  For the enter part, AFAICS the exception case boils down
> to enter_from_user_mode() and the syscall case is:
>
>         enter_from_user_mode(regs);
>         instrumentation_begin();
>
>         local_irq_enable();
>         ti_work = READ_ONCE(current_thread_info()->flags);
>         if (ti_work & SYSCALL_ENTER_WORK)
>                 syscall = syscall_trace_enter(regs, syscall, ti_work);
>         instrumentation_end();
>
> Which would decompose quite nicely as a regular (non-syscall) entry
> plus the syscall part later.

There is a difference between syscall entry and exception entry at least
in my view:

syscall:
                enter_from_user_mode(regs);
                local_irq_enable();

exception:
                enter_from_user_mode(regs);

>> we'd have:
>>
>>   arch_c_entry()
>>      irqentry_enter();
>>      local_irq_enble();
>>      nr = syscall_enter_from_user_mode_work();
>>      ...
>>
>> which enforces two calls for sane entries and more code in arch/....
>
> This is why I still like my:
>
> arch_c_entry()
>   irqentry_enter_from_user_mode();
>   generic_syscall();
>   exit...

So what we have now (with my patch applied) is either:

1) arch_c_entry()
        nr = syscall_enter_from_user_mode();
        arch_handle_syscall(nr);
        syscall_exit_to_user_mode();

or for that extra 32bit fast syscall thing:

2) arch_c_entry()
        syscall_enter_from_user_mode_prepare();
        arch_do_stuff();
        nr = syscall_enter_from_user_mode_work();
        arch_handle_syscall(nr);
        syscall_exit_to_user_mode();

So for sane cases you just use #1.

Ideally we'd not need arch_handle_syscall(nr) at all, but that does not
work with multiple ABIs supported, i.e. the compat muck.

The only way we could make that work is to have:

    syscall_enter_exit(regs, mode)
      nr = syscall_enter_from_user_mode();
      arch_handle_syscall(mode, nr);
      syscall_exit_to_user_mode();

and then arch_c_entry() becomes:

    syscall_enter_exit(regs, mode);

which means that arch_handle_syscall() would have to evaluate the mode
and chose the appropriate syscall table. Not sure whether that's a win.

Thanks,

        tglx


