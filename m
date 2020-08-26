Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DACAC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D7920707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHrcSwx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHZBLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHZBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:11:28 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E05C061757
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 18:03:17 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m23so437802iol.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 18:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=95iD9grKs874OZRXLaKmh7iAntQIC8bb1aAQXOrsWwE=;
        b=lHrcSwx6f+2je3HDnro8+xvQr/Rb/uzaQBMsDxmMIjnAskry1/9NbsY8sqELCe7BXk
         d0UUA8UTs2blL34Iykm+nzrbCaLn9n7iX1zb/E+Uy7vBiJnnYAEQEq+uo6/C7kzv3LUv
         ywLStIBD7hnJvAZiHvDaNPOIeJm8c2w3fOd+s6n5jO78HzwQAsivDKegiHNXV2qK8iIP
         L4Lt+PDM9f1zl+uw0bO10QGvhwuwsDESBbrNqNu4USKl+/eW8PmVoLwYcHeLdh0PdaEv
         ReZC7rvTY9hs0q9qEqTLIiyJVEAeg7OwfZiarndpdCdn51/Ewy9a5+59W49WOlKpdD20
         tUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=95iD9grKs874OZRXLaKmh7iAntQIC8bb1aAQXOrsWwE=;
        b=UzQ7uFFaJrGnk//B/n49i64XEvEkDuPj6Rlo6WoXbtQjzsHdL4yZgDkGeZDvcs5RVI
         RXvZOu9HziBy1vSOJwwoYnUaxNv0trTOjsE2srIxGlExzpww0KYIkR4bcSlU0agtmB7X
         oqqB25n3TOD0FHX+6fvql4586aaUZKSWrrrZcnwiRjVQOlpXPqZ5V6XDimVOxcC5Qyht
         401AnR1w6NTZAH/6TEKA+SnaW4kTJFsj5wXtQJLZ2H/wnHcUVOAoE/Z0VCfexgbTiDdD
         pJyxPEoL2e4XxaqzD1mHYHQdGTVty8nB5jTAN7HMeKZsB227dYKfdtD2GrOWyXFxR7Ba
         jNlw==
X-Gm-Message-State: AOAM531sI5hJXZ6SnQ6rOrM+h9D0CWh+nQVx0VLxy4gwmAkyprwF9JHG
        3xInXur4CH5TjBBJVyoNbr6NmcAeMcitkW+6dA==
X-Google-Smtp-Source: ABdhPJx0STFJXc8n9KRdJxmsoPCIo2ciwcv0Edi29efO7FnJqTlfX7dDYa0Uq9vyNgtqfl6BF4RtXHgi+n0ot/eygxc=
X-Received: by 2002:a02:730b:: with SMTP id y11mr13196057jab.126.1598403796593;
 Tue, 25 Aug 2020 18:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200521200513.656533920@linutronix.de> <20200521202118.796915981@linutronix.de>
 <f0079706-4cb3-b3e3-9a5e-97aaba0aa0eb@amazon.com> <87a6yj58af.fsf@nanos.tec.linutronix.de>
 <051182cc-6c90-e48b-d191-8ca004385261@amazon.com> <CALCETrXutDjE5Z6WR+47MJvp3xt4n=EGiF_oEYm88vGvCqUgHA@mail.gmail.com>
 <b1fdf037-9c11-9f47-f285-e9a0843d648a@amazon.com>
In-Reply-To: <b1fdf037-9c11-9f47-f285-e9a0843d648a@amazon.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 25 Aug 2020 21:03:05 -0400
Message-ID: <CAMzpN2i3AL3cED-XAo-YmaAD5PhjxfwPs9e0JPPNZOkOpu=9HQ@mail.gmail.com>
Subject: Re: [patch V9 21/39] x86/irq: Convey vector as argument and not in ptregs
To:     Alexander Graf <graf@amazon.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Avi Kivity <avi@scylladb.com>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>, robketr@amazon.de,
        amos@scylladb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 8:04 PM Alexander Graf <graf@amazon.com> wrote:
>
> Hi Andy,
>
> On 26.08.20 01:41, Andy Lutomirski wrote:
> >
> > On Tue, Aug 25, 2020 at 4:18 PM Alexander Graf <graf@amazon.com> wrote:
> >>
> >> Hi Thomas,
> >>
> >> On 25.08.20 12:28, Thomas Gleixner wrote:
> >>> void irq_complete_move(struct irq_cfg *cfg)
> > {
> >          __irq_complete_move(cfg, ~get_irq_regs()->orig_ax);
> > }
> >
> >>> Alex,
> >>>
> >>> On Mon, Aug 24 2020 at 19:29, Alexander Graf wrote:
> >>>> I'm currently trying to understand a performance regression with
> >>>> ScyllaDB on i3en.3xlarge (KVM based VM on Skylake) which we reliably
> >>>> bisected down to this commit:
> >>>>
> >>>>      https://github.com/scylladb/scylla/issues/7036
> >>>>
> >>>> What we're seeing is that syscalls such as membarrier() take forever
> >>>> (0-10 =C2=B5s would be normal):
> >>> ...
> >>>> That again seems to stem from a vastly slowed down
> >>>> smp_call_function_many_cond():
> >>>>
> >>>> Samples: 218K of event 'cpu-clock', 4000 Hz
> >>>> Overhead  Shared Object        Symbol
> >>>>      94.51%  [kernel]             [k] smp_call_function_many_cond
> >>>>       0.76%  [kernel]             [k] __do_softirq
> >>>>       0.32%  [kernel]             [k] native_queued_spin_lock_slowpa=
th
> >>>> [...]
> >>>>
> >>>> which is stuck in
> >>>>
> >>>>           =E2=94=82     csd_lock_wait():
> >>>>           =E2=94=82             smp_cond_load_acquire(&csd->flags, !=
(VAL &
> >>>>      0.00 =E2=94=82       mov    0x8(%rcx),%edx
> >>>>      0.00 =E2=94=82       and    $0x1,%edx
> >>>>           =E2=94=82     =E2=86=93 je     2b9
> >>>>           =E2=94=82     rep_nop():
> >>>>      0.70 =E2=94=822af:   pause
> >>>>           =E2=94=82     csd_lock_wait():
> >>>>     92.82 =E2=94=82       mov    0x8(%rcx),%edx
> >>>>      6.48 =E2=94=82       and    $0x1,%edx
> >>>>      0.00 =E2=94=82     =E2=86=91 jne    2af
> >>>>      0.00 =E2=94=822b9: =E2=86=91 jmp    282
> >>>>
> >>>>
> >>>> Given the patch at hand I was expecting lost IPIs, but I can't quite=
 see
> >>>> anything getting lost.
> >>>
> >>> I have no idea how that patch should be related to IPI and smp functi=
on
> >>> calls. It's changing the way how regular device interrupts and their
> >>> spurious counterpart are handled and not the way how IPIs are
> >>> handled. They are handled by direct vectors and do not go through
> >>> do_IRQ() at all.
> >>>
> >>> Aside of that the commit just changes the way how the interrupt vecto=
r
> >>> of a regular device interrupt is stored and conveyed. The extra read =
and
> >>> write on the cache hot stack is hardly related to anything IPI.
> >>
> >> I am as puzzled as you are, but the bisect is very clear: 79b9c183021e
> >> works fast and 633260fa1 (as well as mainline) shows the weird behavio=
r
> >> above.
> >>
> >> It gets even better. This small (demonstrative only, mangled) patch on
> >> top of 633260fa1 also resolves the performance issue:
> >>
> >> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> >> index c766936..7e91e9a 100644
> >> --- a/arch/x86/kernel/irq.c
> >> +++ b/arch/x86/kernel/irq.c
> >> @@ -239,6 +239,7 @@ __visible void __irq_entry do_IRQ(struct pt_regs
> >> *regs, unsigned long vector)
> >>           * lower 8 bits.
> >>           */
> >>          vector &=3D 0xFF;
> >> +       regs->orig_ax =3D ~vector;
> >>
> >>          /* entering_irq() tells RCU that we're not quiescent.  Check =
it. */
> >>          RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up R=
CU");
> >>
> >>
> >> To me that sounds like some irq exit code somewhere must still be
> >> looking at orig_ax to decide on something - and that something is wron=
g
> >> now that we removed the negation of the vector. It also seems to have =
an
> >> impact on remote function calls.
> >>
> >> I'll have a deeper look tomorrow again if I can find any such place, b=
ut
> >> I wouldn't mind if anyone could point me into the right direction
> >> earlier :).
> >
> > How about this:
> >
> > void irq_complete_move(struct irq_cfg *cfg)
> > {
> >          __irq_complete_move(cfg, ~get_irq_regs()->orig_ax);
> > }
> >
> > in arch/x86/kernel/apic/vector.c.
> >
>
> Thanks a lot, I stumbled over the same thing just after I sent the email
> as well and had been trying to see if I can quickly patch it up before I
> fall asleep :).
>
> The code path above is used by the APIC vector move (irqbalance) logic,
> which explains why not everyone was seeing issues.
>
> So with 633260fa1 applied, we never get out of moving state for our IRQ
> because orig_ax is always -1. That means we send an IPI to the cleanup
> vector on every single device interrupt, completely occupying the poor
> CPU that we moved the IRQ from.
>
> I've confirmed that the patch below fixes the issue and will send a
> proper, more complete patch on top of mainline with fancy description
> and stable tag tomorrow.
>
>
> Alex
>
>
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e7434cd..a474e6e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -734,7 +734,6 @@ SYM_CODE_START_LOCAL(common_spurious)
>         call    interrupt_entry
>         UNWIND_HINT_REGS indirect=3D1
>         movq    ORIG_RAX(%rdi), %rsi            /* get vector from stack =
*/
> -       movq    $-1, ORIG_RAX(%rdi)             /* no syscall to restart =
*/
>         call    smp_spurious_interrupt          /* rdi points to pt_regs =
*/
>         jmp     ret_from_intr
>   SYM_CODE_END(common_spurious)
> @@ -746,7 +745,6 @@ SYM_CODE_START_LOCAL(common_interrupt)
>         call    interrupt_entry
>         UNWIND_HINT_REGS indirect=3D1
>         movq    ORIG_RAX(%rdi), %rsi            /* get vector from stack =
*/
> -       movq    $-1, ORIG_RAX(%rdi)             /* no syscall to restart =
*/
>         call    do_IRQ                          /* rdi points to pt_regs =
*/
>         /* 0(%rsp): old RSP */
>   ret_from_intr:
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.=
c
> index 67768e5443..5b6f74e 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -934,7 +934,7 @@ static void __irq_complete_move(struct irq_cfg *cfg,
> unsigned vector)
>
>   void irq_complete_move(struct irq_cfg *cfg)
>   {
> -       __irq_complete_move(cfg, ~get_irq_regs()->orig_ax);
> +       __irq_complete_move(cfg, get_irq_regs()->orig_ax);
>   }

I think you need to also truncate the vector to 8-bits, since it now
gets sign-extended when pushed into the orig_ax slot.

--
Brian Gerst
