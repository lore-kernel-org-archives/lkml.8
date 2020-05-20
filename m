Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E2BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431C220674
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589934434;
	bh=WfaSB8+R0YSGnyr+Rv70toYCU7D7Ykllf1n/nKOpqbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f2l4xLsfMw/UBr11OMOeNGp30mHAL6vjByW0rA8HSk8sMtr76MzDp/cT3YsfVr9qJ
	 W290BT/OnlnXL111upharFMewS9d5B963to3Vk5QQ5KvzpQFPhwOczal7fm4sJv7cn
	 noYpV/Wi/fI3Iu4IcFXDOc6ansSJi1kD7cbQu2hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgETA1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETA1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:27:12 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C203C20888
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934432;
        bh=WfaSB8+R0YSGnyr+Rv70toYCU7D7Ykllf1n/nKOpqbM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=msuvT6AM+Gt9R65Dk9uTZZnI+I7jIgMrOo8Sh/1kZuA1qSwohYb3mKHsTUPaqrWdA
         kulL+exMYT1DThnplVg+q7Cr+V5sdKN9pdaae+5iyKze0QP1ST6vQAQlCDKhdNdAC/
         mYt7xxFwZ1tLxLI5V66ZlIn1+G3C6GZSIcaqokIk=
Received: by mail-wr1-f54.google.com with SMTP id l18so1330133wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:27:11 -0700 (PDT)
X-Gm-Message-State: AOAM532pU5FuoPtrxNwPmEJ0+LzcGMgp7c56BocXszHxCOx2KhnEGdUE
        zQU48Ew3FV4ypVehL8llUjTOdZf6ibwrKv+p3uvlFw==
X-Google-Smtp-Source: ABdhPJy9iOAholR+4CZL5fKp3eOhjQdhPN+KceGtcJDDHeFsGSCwdPQS2RPB0xwqZbZ415aOX4EcW6NWbwAa5H0SoMg=
X-Received: by 2002:adf:a389:: with SMTP id l9mr1507405wrb.18.1589934430039;
 Tue, 19 May 2020 17:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de>
 <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
 <87ftbv7nsd.fsf@nanos.tec.linutronix.de> <87a7237k3x.fsf@nanos.tec.linutronix.de>
 <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com> <874ksb7hbg.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874ksb7hbg.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:26:58 -0700
X-Gmail-Original-Message-ID: <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
Message-ID: <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
Subject: Re: [patch V6 12/37] x86/entry: Provide idtentry_entry/exit_cond_rcu()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 2:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Tue, May 19, 2020 at 1:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Thomas Gleixner <tglx@linutronix.de> writes:
> >> It's about this:
> >>
> >> rcu_nmi_enter()
> >> {
> >>         if (!rcu_is_watching()) {
> >>             make it watch;
> >>         } else if (!in_nmi()) {
> >>             do_magic_nohz_dyntick_muck();
> >>         }
> >>
> >> So if we do all irq/system vector entries conditional then the
> >> do_magic() gets never executed. After that I got lost...
> >
> > I'm also baffled by that magic, but I'm also not suggesting doing this
> > to *all* entries -- just the not-super-magic ones that use
> > idtentry_enter().
> >
> > Paul, what is this code actually trying to do?
>
> Citing Paul from IRC:
>
>   "The way things are right now, you can leave out the rcu_irq_enter()
>    if this is not a nohz_full CPU.
>
>    Or if this is a nohz_full CPU, and the tick is already
>    enabled, in that case you could also leave out the rcu_irq_enter().
>
>    Or even if this is a nohz_full CPU and it does not have the tick
>    enabled, if it has been in the kernel less than a few tens of
>    milliseconds, still OK to avoid invoking rcu_irq_enter()
>
>    But my guess is that it would be a lot simpler to just always call
>    it.
>
> Hope that helps.

Maybe?

Unless I've missed something, the effect here is that #PF hitting in
an RCU-watching context will skip rcu_irq_enter(), whereas all IRQs
(because you converted them) as well as other faults and traps will
call rcu_irq_enter().

Once upon a time, we did this horrible thing where, on entry from user
mode, we would turn on interrupts while still in CONTEXT_USER, which
means we could get an IRQ in an extended quiescent state.  This means
that the IRQ code had to end the EQS so that IRQ handlers could use
RCU.  But I killed this a few years ago -- x86 Linux now has a rule
that, if IF=1, we are *not* in an EQS with the sole exception of the
idle code.

In my dream world, we would never ever get IRQs while in an EQS -- we
would do MWAIT with IF=0 and we would exit the EQS before taking the
interrupt.  But I guess we still need to support HLT, which means we
have this mess.

But I still think we can plausibly get rid of the conditional.  If we
get an IRQ or (egads!) a fault in idle context, we'll have
!__rcu_is_watching(), but, AFAICT, we also have preemption off.  So it
should be okay to do rcu_irq_enter().  OTOH, if we get an IRQ or a
fault anywhere else, then we either have a severe bug in the RCU code
itself and the RCU code faulted (in which case we get what we deserve)
or RCU is watching and all is well.  This means that the rule will be
that, if preemption is on, it's fine to schedule inside an
idtentry_begin()/idtentry_end() pair.

The remaining bit is just the urgent thing, and I don't understand
what's going on.  Paul, could we split out the urgent logic all by
itself so that the IRQ handlers could do rcu_poke_urgent()?  Or am I
entirely misunderstanding its purpose?
