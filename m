Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF52C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 16:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237B82073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583597228;
	bh=yyqK+Ql2p4NXPr4RjWF269NGUHTHvvPj0zJ+ILRkEOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r2DCHq/M4a0WHmx+EFGSb80hnlnVPQOz+GnRkWb8uVoC9d2TxKTQ3NpyN8lduUca/
	 VIAOn0LyLILUPQ6zSQqaG30FRfZ02w82iL+XnpDppiVI40h2SAe8JFZJpjaVzxyKcD
	 VQQF3WFxCMOZlaWqZFlZik1pGEMMLgqCUaeVK6wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCGQHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 11:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgCGQHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 11:07:06 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5813F20656
        for <linux-kernel@vger.kernel.org>; Sat,  7 Mar 2020 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583597225;
        bh=yyqK+Ql2p4NXPr4RjWF269NGUHTHvvPj0zJ+ILRkEOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NL2x4LxRYKBgtzACYWlJ2pMI2FhHtawWlR1dNr+OEMGq4wtXfu+jDuErJZ621Eo9V
         pyNKtA+g6i2pQVjrJqM9HU/+OwGee39y9b3TUnEwraXGxgVPqCl+sqLsOWw67e1GHv
         3GSoav2poMwmYQz7PAv09M81nqNVqekxvY/ZkefY=
Received: by mail-wm1-f52.google.com with SMTP id a5so5638799wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 08:07:05 -0800 (PST)
X-Gm-Message-State: ANhLgQ3K5x17ACj16SF7DRWl9ZQheaY31pZgfCAS2+ftL3PzE0QWzgnh
        F9W122QLCaI3EZ92Vd7VYv4k7B3ZwmqMXiYYkfWCcA==
X-Google-Smtp-Source: ADFU+vudN2xwPRYRNB2o4MM2vanAeeTTHZ6j/KCg28MIjew9C/SRRYIi+AzD8kBMAgCC+UznEhbzhnyozZYz03npvFQ=
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr10869694wmc.49.1583597223816;
 Sat, 07 Mar 2020 08:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20200306234204.847674001@linutronix.de> <20200307000259.448059232@linutronix.de>
 <CALCETrV74siTTHHWRPv+Gz=YS3SAUA6eqB6FX1XaHKvZDCbaNg@mail.gmail.com>
 <87r1y4a3gw.fsf@nanos.tec.linutronix.de> <CALCETrWc0wM1x-mAcKCPRUiGtzONtXiNVMFgWZwkRD3v3K3jsA@mail.gmail.com>
 <87d09o9n7y.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d09o9n7y.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 7 Mar 2020 08:06:52 -0800
X-Gmail-Original-Message-ID: <CALCETrXpW5TYRNu2hMXt=fGC8EOh7WVqffCzS5GrwApC1inTzw@mail.gmail.com>
Message-ID: <CALCETrXpW5TYRNu2hMXt=fGC8EOh7WVqffCzS5GrwApC1inTzw@mail.gmail.com>
Subject: Re: [patch 2/2] x86/kvm: Sanitize kvm_async_pf_task_wait()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 7, 2020 at 7:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Sat, Mar 7, 2020 at 2:01 AM Thomas Gleixner <tglx@linutronix.de> wro=
te:
> >> > What=E2=80=99s the local_irq_disable() here for? I would believe a
> >> > lockdep_assert_irqs_disabled() somewhere in here would make sense.
> >> > (Yes, I see you copied this from the old code. It=E2=80=99s still no=
nsense.)
> >>
> >> native_safe_halt() does:
> >>
> >>          STI
> >>          HLT
> >>
> >> So the irq disable is required as the loop should exit with interrupts
> >> disabled.
> >
> > Oops, should have looked at what native_safe_halt() does.
> >
> >>
> >> > I also find it truly bizarre that hlt actually works in this context=
.
> >> > Does KVM in fact wake a HLTed guest that HLTed with IRQs off when a
> >> > pending async pf is satisfied?  This would make sense if the wake
> >> > event were an interrupt, but it=E2=80=99s not according to Paolo.
> >>
> >> See above. safe halt enables interrupts, which means IF =3D=3D 1 and t=
he
> >> host sanity check for IF =3D=3D 1 is satisfied.
> >>
> >> In fact, if e.g. some regular interrupt arrives before the page become=
s
> >> available and the guest entered the halt loop because the fault happen=
ed
> >> inside a RCU read side critical section with preemption enabled, then
> >> the interrupt might wake up another task, set need resched and this
> >> other task can run.
> >
> > Now I'm confused again.  Your patch is very careful not to schedule if
> > we're in an RCU read-side critical section, but the regular preemption
> > code (preempt_schedule_irq, etc) seems to be willing to schedule
> > inside an RCU read-side critical section.  Why is the latter okay but
> > not the async pf case?
>
> Preemption is fine, but voluntary schedule not. voluntary schedule might
> end up in idle if this is the last runnable task.

I guess something horrible happens if we try to go idle while in an
RCU read-side critical section.  Like perhaps it's considered a grace
period.  Hmm.

>
> > Ignoring that, this still seems racy:
> >
> > STI
> > nested #PF telling us to wake up
> > #PF returns
> > HLT
>
> You will say Ooops, should have looked .... when I tell you that the
> above cannot happen. From the SDM:
>
>   If IF =3D 0, maskable hardware interrupts remain inhibited on the
>   instruction boundary following an execution of STI.
>
> Otherwise safe_halt would not work at all :)

Ooops, should have looked. :)

> > Sadly, wrmsr to turn off async pf will inject wakeups even if IF =3D=3D=
 0.
>
> WHAT? That's fundamentally broken. Can you point me to the code in
> question?

I think Paolo said so in a different thread, but I can't Let me see if
I can find it:

kvm_pv_enable_async_pf()
  kvm_clear_async_pf_completion_queue()

but that doesn't actually seem to send #PF.  So maybe I'm wrong.

I will admit that, even after reading the host code a few times, I'm
also not convinced that wakeups don't get swallowed on occasion if
they would have been delivered at times when it's illegal.
