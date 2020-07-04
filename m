Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D389C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF86021927
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593874579;
	bh=ojbgQmjPTV7D6kXqc4BTRRhR75bviWgGGtdXVdf+q9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GjphzYM5rZZxgiNeTR0L1tMfK4FmLCP/qc4ZKJoM4He6r5hIx4402cq6M8+cOXHc/
	 JBQqQ95OEGqXZV9aOs/MJ2tAp+brRMng4Ie+kVSkfradNrmIaDsGW5I4TO8szglBq5
	 P3w+wZ+J/qZDGbsIRSyH6mcWll7P90c+NNCsUTxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGDOzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgGDOzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:55:43 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9260208FE;
        Sat,  4 Jul 2020 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593874542;
        bh=ojbgQmjPTV7D6kXqc4BTRRhR75bviWgGGtdXVdf+q9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y3eSMm59oP8v1iEQ7GYqolbPktucp14jR0nXZszhUE2dTmzXPf35N2IOz91wo8Mcb
         NnXjhBNvxqNPDHdG0mD6FLIiRVM4jtRN2rFAjqBvRz+w1k1J9cVer/BrWEzNCuYFGi
         R2l9SCKG5o2CfKIQ0NcKo8VAYaUVPaMRsq/J44h0=
Received: by mail-lj1-f173.google.com with SMTP id n23so40292530ljh.7;
        Sat, 04 Jul 2020 07:55:41 -0700 (PDT)
X-Gm-Message-State: AOAM531dss3lHWWAaDALyI1l9TEq9klAiV6Ljs43688svoa5H1mHNF+8
        nwHG9UWMiUAZuCCAqn0XE2metTTwbJhZtt5rLXE=
X-Google-Smtp-Source: ABdhPJzIk1tCgJjz4OUWhVlitpIkUcsZm9HDMIiZYK03ivVBzcTjfWnBMrpv0O6qL9pOvJGS1ty5yLoysAERVwX8Y94=
X-Received: by 2002:a05:651c:2da:: with SMTP id f26mr21209299ljo.377.1593874540221;
 Sat, 04 Jul 2020 07:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <1593833659-26224-1-git-send-email-guoren@kernel.org> <CAOJsxLFF4o8AFWzPFJgwaeuA=Lb9VsjMXXfVmbhZBwLPcG=Asg@mail.gmail.com>
In-Reply-To: <CAOJsxLFF4o8AFWzPFJgwaeuA=Lb9VsjMXXfVmbhZBwLPcG=Asg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 4 Jul 2020 22:55:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSYyj5rTUJW-yDDrrV7T3hUssAhGc0gnCntcQpuixNJzw@mail.gmail.com>
Message-ID: <CAJF2gTSYyj5rTUJW-yDDrrV7T3hUssAhGc0gnCntcQpuixNJzw@mail.gmail.com>
Subject: Re: [PATCH V1 0/5] riscv: Add k/uprobe supported
To:     Pekka Enberg <penberg@gmail.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        bjorn.topel@gmail.com, Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Sat, Jul 4, 2020 at 2:40 PM Pekka Enberg <penberg@gmail.com> wrote:
>
> On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
> > The patchset includes kprobe/uprobe support and some related fixups.
>
> Nice!
>
> On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
> > There is no single step exception in riscv ISA, so utilize ebreak to
> > simulate. Some pc related instructions couldn't be executed out of line
> > and some system/fence instructions couldn't be a trace site at all.
> > So we give out a reject list and simulate list in decode-insn.c.
>
> Can you elaborate on what you mean by this? Why would you need a
> single-step facility for kprobes? Is it for executing the instruction
> that was replaced with a probe breakpoint?

It's the single-step exception, not single-step facility!

Other arches use hardware single-step exception for k/uprobe,  eg:
 - powerpc: regs->msr |=3D MSR_SINGLESTEP
 - arm/arm64: PSTATE.D for enabling software step exceptions
 - s390: Set PER control regs, turns on single step for the given address
 - x86: regs->flags |=3D X86_EFLAGS_TF
 - csky: of course use hw single step :)

Yes, All the above arches use a hardware single-step exception
mechanism to execute the instruction that was replaced with a probe
breakpoint.

>
> Also, the "Debug Specification" [1] specifies a single-step facility
> for RISC-V -- why is that not useful for implementing kprobes?
>
> 1. https://riscv.org/specifications/debug-specification/
We need single-step exception not single-step by jtag, so above spec
is not related to the patchset.

See riscv-Privileged spec:

Interrupt Exception Code-Description
1 0 Reserved
1 1 Supervisor software interrupt
1 2=E2=80=934 Reserved
1 5 Supervisor timer interrupt
1 6=E2=80=938 Reserved
1 9 Supervisor external interrupt
1 10=E2=80=9315 Reserved
1 =E2=89=A516 Available for platform use
0 0 Instruction address misaligned
0 1 Instruction access fault
0 2 Illegal instruction
0 3 Breakpoint
0 4 Load address misaligned
0 5 Load access fault
0 6 Store/AMO address misaligned
0 7 Store/AMO access fault
0 8 Environment call from U-mode
0 9 Environment call from S-mode
0 10=E2=80=9311 Reserved
0 12 Instruction page fault
0 13 Load page fault
0 14 Reserved
0 15 Store/AMO page fault
0 16=E2=80=9323 Reserved
0 24=E2=80=9331 Available for custom use
0 32=E2=80=9347 Reserved
0 48=E2=80=9363 Available for custom use
0 =E2=89=A564 Reserved

No single step!

So I insert a "ebreak" instruction behind the target single-step
instruction to simulate the same mechanism.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
