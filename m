Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1869C206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594789296;
	bh=BP1XU8xIR+fvOq10ATBpe//b2NjFNKyBXAHk6X7rMGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J7+tTj+q+5FUujSpYiuQPQ0PUCINNV5+O9qOJjnTNbWPxFHtryky1XNV5MYZz4ASa
	 YvrVniuwgy14Q1tfWzRinlC8bM4+QuvFVI8c1a6kZ7L3Ud5xNMZ87Y9w8IT7xP1SFX
	 yMS6qM2SDaW9prNvRYCCGttLKTs+9ATW0uT2PnEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGOFBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgGOFBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:01:34 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B13D02074B;
        Wed, 15 Jul 2020 05:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594789293;
        bh=BP1XU8xIR+fvOq10ATBpe//b2NjFNKyBXAHk6X7rMGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DRyMU3+1kKmzK6QQceszq3hcQikuwW84EuLUOMhsWmsFh1oj+0JJpQsb/pMq/EgrM
         h/XbCNDGXBdURCMagxqaa2GWpNRChZH+9x5J/E6we1zg6HfLBIMIck1eH0RZiT6RLD
         45LoO5tLcsod3yfHwKuhuh4KGeWkOs+zau+n1VPM=
Received: by mail-lj1-f179.google.com with SMTP id r19so1027272ljn.12;
        Tue, 14 Jul 2020 22:01:32 -0700 (PDT)
X-Gm-Message-State: AOAM533hEPW09oZsGUAiD4OBD5gS5qqNH0A4ADCBAj5bsujm/4D5EMQ3
        umt7MRWGl1iWc4gDj52ksP28lh7efq21XEeqsqM=
X-Google-Smtp-Source: ABdhPJwEi9sTAbh/CUwlrbnxmAqKB7C+J6BICaVzBsW7VDPRYLh/EqngV/qcwFIWR4LPkB8QYPbW7xlc5s4feenHWZ0=
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr3645428ljl.250.1594789290935;
 Tue, 14 Jul 2020 22:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTSYyj5rTUJW-yDDrrV7T3hUssAhGc0gnCntcQpuixNJzw@mail.gmail.com>
 <mhng-3921ee3a-6033-4f1c-9c93-ecdb5751b3b1@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-3921ee3a-6033-4f1c-9c93-ecdb5751b3b1@palmerdabbelt-glaptop1>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 15 Jul 2020 13:01:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSEHqD0KR85r-FjDXW-4Z2kzNDVgM5pHVsKwoVoX==NgA@mail.gmail.com>
Message-ID: <CAJF2gTSEHqD0KR85r-FjDXW-4Z2kzNDVgM5pHVsKwoVoX==NgA@mail.gmail.com>
Subject: Re: [PATCH V1 0/5] riscv: Add k/uprobe supported
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Pekka Enberg <penberg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Wed, Jul 15, 2020 at 2:43 AM Palmer Dabbelt <palmerdabbelt@google.com> w=
rote:
>
> On Sat, 04 Jul 2020 07:55:28 PDT (-0700), guoren@kernel.org wrote:
> > Hi Pekka,
> >
> > On Sat, Jul 4, 2020 at 2:40 PM Pekka Enberg <penberg@gmail.com> wrote:
> >>
> >> On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
> >> > The patchset includes kprobe/uprobe support and some related fixups.
> >>
> >> Nice!
> >>
> >> On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
> >> > There is no single step exception in riscv ISA, so utilize ebreak to
> >> > simulate. Some pc related instructions couldn't be executed out of l=
ine
> >> > and some system/fence instructions couldn't be a trace site at all.
> >> > So we give out a reject list and simulate list in decode-insn.c.
> >>
> >> Can you elaborate on what you mean by this? Why would you need a
> >> single-step facility for kprobes? Is it for executing the instruction
> >> that was replaced with a probe breakpoint?
> >
> > It's the single-step exception, not single-step facility!
> >
> > Other arches use hardware single-step exception for k/uprobe,  eg:
> >  - powerpc: regs->msr |=3D MSR_SINGLESTEP
> >  - arm/arm64: PSTATE.D for enabling software step exceptions
> >  - s390: Set PER control regs, turns on single step for the given addre=
ss
> >  - x86: regs->flags |=3D X86_EFLAGS_TF
> >  - csky: of course use hw single step :)
> >
> > Yes, All the above arches use a hardware single-step exception
> > mechanism to execute the instruction that was replaced with a probe
> > breakpoint.
>
> I guess we could handle fences by just IPIing over there and executing th=
e
> fence?  Probably not worth the effort, though, as if you have an issue th=
at's
> showing up close enough to a fence that you can't just probe somewhere ne=
arby
> then you're probably going to disrupt things too much to learn anything.
All fence instructions are rejected to probe in the current patchset.
ref arch/riscv/kernel/probes/decode-insn.c:
        /*
         * Reject instructions list:
         */
        RISCV_INSN_REJECTED(system,             insn);
        RISCV_INSN_REJECTED(fence,              insn);

> I'd
> assume that AMOs are also too much of a headache to emulate, as moving th=
em to
> a different hart would allow for different orderings that may break thing=
s.
All AMO instructions could be single-step emulated.

>
> I suppose the tricker issue is that inserting a probe in the middle of a =
LR/SC
> sequence will result in a loss of forward progress (or maybe even incorre=
ct
> behavior, if you mess up a pairing), as there are fairly heavyweight
> restrictions on what you're allowed to do inside there.  I don't see any
> mechanism for handling this, maybe we need to build up tables of restrict=
ed
> regions?  All the LR/SC sequences should be hidden behind macros already,=
 so it
> shouldn't be that hard to figure it out.
Yes, the probe between LR/SC will cause dead loop risk and arm64 just
prevent exclusive instructions to probe without the middle detecting.
The macros wrapper idea seems good, but I prefer to leave it to user caring=
.

>
> I only gave the code a quick look, but I don't see any references to LR/S=
C or
> AMO so if you are handling these I guess we at least need a comment :)
Yes, I let all AMO & LR/SC could be executed out of line with a
single-step style.
I'll add a comment about LR/SC wrapper macros' idea which you mentioned.

>
> >
> >>
> >> Also, the "Debug Specification" [1] specifies a single-step facility
> >> for RISC-V -- why is that not useful for implementing kprobes?
> >>
> >> 1. https://riscv.org/specifications/debug-specification/
> > We need single-step exception not single-step by jtag, so above spec
> > is not related to the patchset.
> >
> > See riscv-Privileged spec:
> >
> > Interrupt Exception Code-Description
> > 1 0 Reserved
> > 1 1 Supervisor software interrupt
> > 1 2=E2=80=934 Reserved
> > 1 5 Supervisor timer interrupt
> > 1 6=E2=80=938 Reserved
> > 1 9 Supervisor external interrupt
> > 1 10=E2=80=9315 Reserved
> > 1 =E2=89=A516 Available for platform use
> > 0 0 Instruction address misaligned
> > 0 1 Instruction access fault
> > 0 2 Illegal instruction
> > 0 3 Breakpoint
> > 0 4 Load address misaligned
> > 0 5 Load access fault
> > 0 6 Store/AMO address misaligned
> > 0 7 Store/AMO access fault
> > 0 8 Environment call from U-mode
> > 0 9 Environment call from S-mode
> > 0 10=E2=80=9311 Reserved
> > 0 12 Instruction page fault
> > 0 13 Load page fault
> > 0 14 Reserved
> > 0 15 Store/AMO page fault
> > 0 16=E2=80=9323 Reserved
> > 0 24=E2=80=9331 Available for custom use
> > 0 32=E2=80=9347 Reserved
> > 0 48=E2=80=9363 Available for custom use
> > 0 =E2=89=A564 Reserved
> >
> > No single step!
> >
> > So I insert a "ebreak" instruction behind the target single-step
> > instruction to simulate the same mechanism.
>
> Single step is part of the debug spec.  That mostly discusses JTAG debugg=
ing,
> but there's also some stuff in there related to in-band debugging (at lea=
st
> watch points and single step, though there may be more).  IIRC you get a
What's the meaning of IIRC?

> breakpoint exception and then chase around some CSRs to differentiate bet=
ween
> the various reasons, but it's been a while since I've looked at this stuf=
f.
I just use k/uprobe state check function in ebreak handler, no
additional csr tested.
asmlinkage __visible void do_trap_break(struct pt_regs *regs)
{
#ifdef CONFIG_KPROBES
        if (kprobe_single_step_handler(regs))
                return;

        if (kprobe_breakpoint_handler(regs))
                return;
#endif
#ifdef CONFIG_UPROBES
        if (uprobe_single_step_handler(regs))
                return;

        if (uprobe_breakpoint_handler(regs))
                return;
#endif
        current->thread.bad_cause =3D regs->cause;

Seems it works good.

>
> It's all kind of irrelevant, though, as there's no way to get at all this=
 stuff
> from supervisor mode.  I don't see any reason we couldn't put together an=
 SBI
> extension to access this stuff, but I also don't know anyone who's looked=
 into
> doing so.  There are some complexities involved because this state is all
> shared between machine mode and debug mode that we'd need to deal with, b=
ut I
> think we could put something together -- at least for single step those a=
re
> fairly straight-forward issues to handle.
Do you prefer to add a single-step mechanism into a privileged-spec?

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
