Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2203020767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598398933;
	bh=CyQtlYDE+A8MG0JyxNX1QVig85hDl88iFa2qsrgexI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=COcStWWfLlkuDp6dx4POS+xe+0/Kj7w+3q3T4TpZ7CjUbB3D7SLMehgRVKWLyO4Xh
	 DOL5FL93ICmxAVs3x0RWLXvJY8ImI8pChbRIt8zG8FYVHdvnRw27H1mKwKMGmM/knY
	 lHt3p4tm3SrriKjICbcK1RopAU57lvU0M/oiCI/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHYXmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgHYXlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:41:50 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C7621775
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 23:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598398910;
        bh=CyQtlYDE+A8MG0JyxNX1QVig85hDl88iFa2qsrgexI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gx5ZsCuzH4ioCxetiD2y+vDwoxSZvhEsF7Y75vaMTQ31Zx2Pc7i8L0ab0V5om2kr2
         356372LR7wlNGShYXgIo51ov/7n9BBGd4pZEl0ixshjyVVdqBdEqHTPdcSE7dNGJKP
         BCmCCFOhrMdnaXxrUoK47jEzw6JP1t6ssDxFnh+U=
Received: by mail-wr1-f54.google.com with SMTP id p17so495394wrj.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 16:41:49 -0700 (PDT)
X-Gm-Message-State: AOAM533T2NrM78sKWEC1N55b2U2zT8M8WSCq7i/vOuwp/qioQ8S7sZrC
        xh2Q07fYlYQNzVOCYzhP5XsjStjZa3MzpRFKkdHcdg==
X-Google-Smtp-Source: ABdhPJziIjnGOyouCp9gtTbUgUQ2Fpvm/xo4S/Yz68qNI2Xo0rcmdpT4fj8YTSQ4WNQrlkdF8f3yZXhj2uoNEGenMOo=
X-Received: by 2002:a5d:4145:: with SMTP id c5mr12976959wrq.18.1598398908278;
 Tue, 25 Aug 2020 16:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200521200513.656533920@linutronix.de> <20200521202118.796915981@linutronix.de>
 <f0079706-4cb3-b3e3-9a5e-97aaba0aa0eb@amazon.com> <87a6yj58af.fsf@nanos.tec.linutronix.de>
 <051182cc-6c90-e48b-d191-8ca004385261@amazon.com>
In-Reply-To: <051182cc-6c90-e48b-d191-8ca004385261@amazon.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Aug 2020 16:41:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXutDjE5Z6WR+47MJvp3xt4n=EGiF_oEYm88vGvCqUgHA@mail.gmail.com>
Message-ID: <CALCETrXutDjE5Z6WR+47MJvp3xt4n=EGiF_oEYm88vGvCqUgHA@mail.gmail.com>
Subject: Re: [patch V9 21/39] x86/irq: Convey vector as argument and not in ptregs
To:     Alexander Graf <graf@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Brian Gerst <brgerst@gmail.com>,
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

On Tue, Aug 25, 2020 at 4:18 PM Alexander Graf <graf@amazon.com> wrote:
>
> Hi Thomas,
>
> On 25.08.20 12:28, Thomas Gleixner wrote:
> >void irq_complete_move(struct irq_cfg *cfg)
{
        __irq_complete_move(cfg, ~get_irq_regs()->orig_ax);
}

> > Alex,
> >
> > On Mon, Aug 24 2020 at 19:29, Alexander Graf wrote:
> >> I'm currently trying to understand a performance regression with
> >> ScyllaDB on i3en.3xlarge (KVM based VM on Skylake) which we reliably
> >> bisected down to this commit:
> >>
> >>     https://github.com/scylladb/scylla/issues/7036
> >>
> >> What we're seeing is that syscalls such as membarrier() take forever
> >> (0-10 =C2=B5s would be normal):
> > ...
> >> That again seems to stem from a vastly slowed down
> >> smp_call_function_many_cond():
> >>
> >> Samples: 218K of event 'cpu-clock', 4000 Hz
> >> Overhead  Shared Object        Symbol
> >>     94.51%  [kernel]             [k] smp_call_function_many_cond
> >>      0.76%  [kernel]             [k] __do_softirq
> >>      0.32%  [kernel]             [k] native_queued_spin_lock_slowpath
> >> [...]
> >>
> >> which is stuck in
> >>
> >>          =E2=94=82     csd_lock_wait():
> >>          =E2=94=82             smp_cond_load_acquire(&csd->flags, !(VA=
L &
> >>     0.00 =E2=94=82       mov    0x8(%rcx),%edx
> >>     0.00 =E2=94=82       and    $0x1,%edx
> >>          =E2=94=82     =E2=86=93 je     2b9
> >>          =E2=94=82     rep_nop():
> >>     0.70 =E2=94=822af:   pause
> >>          =E2=94=82     csd_lock_wait():
> >>    92.82 =E2=94=82       mov    0x8(%rcx),%edx
> >>     6.48 =E2=94=82       and    $0x1,%edx
> >>     0.00 =E2=94=82     =E2=86=91 jne    2af
> >>     0.00 =E2=94=822b9: =E2=86=91 jmp    282
> >>
> >>
> >> Given the patch at hand I was expecting lost IPIs, but I can't quite s=
ee
> >> anything getting lost.
> >
> > I have no idea how that patch should be related to IPI and smp function
> > calls. It's changing the way how regular device interrupts and their
> > spurious counterpart are handled and not the way how IPIs are
> > handled. They are handled by direct vectors and do not go through
> > do_IRQ() at all.
> >
> > Aside of that the commit just changes the way how the interrupt vector
> > of a regular device interrupt is stored and conveyed. The extra read an=
d
> > write on the cache hot stack is hardly related to anything IPI.
>
> I am as puzzled as you are, but the bisect is very clear: 79b9c183021e
> works fast and 633260fa1 (as well as mainline) shows the weird behavior
> above.
>
> It gets even better. This small (demonstrative only, mangled) patch on
> top of 633260fa1 also resolves the performance issue:
>
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index c766936..7e91e9a 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -239,6 +239,7 @@ __visible void __irq_entry do_IRQ(struct pt_regs
> *regs, unsigned long vector)
>          * lower 8 bits.
>          */
>         vector &=3D 0xFF;
> +       regs->orig_ax =3D ~vector;
>
>         /* entering_irq() tells RCU that we're not quiescent.  Check it. =
*/
>         RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU")=
;
>
>
> To me that sounds like some irq exit code somewhere must still be
> looking at orig_ax to decide on something - and that something is wrong
> now that we removed the negation of the vector. It also seems to have an
> impact on remote function calls.
>
> I'll have a deeper look tomorrow again if I can find any such place, but
> I wouldn't mind if anyone could point me into the right direction
> earlier :).

How about this:

void irq_complete_move(struct irq_cfg *cfg)
{
        __irq_complete_move(cfg, ~get_irq_regs()->orig_ax);
}

in arch/x86/kernel/apic/vector.c.
