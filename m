Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F77C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D3620747
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593997327;
	bh=LqebZajuTrNEjjHajHRCQ35Qvk4gUVQQV87PbV+cOq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mErKxFMDEcmaEHUhku/J8llPaEiXpQJS5L63GTWXSeuwPsKSSbDKM1PHMsDwLrCUm
	 oGFtUIYT4eksMLr8Vf3KoWQofdvFwlckpNw52MPJU2/A1F4IGOXeGd6s5NlgmNXXuJ
	 D6r9ZjbP5k2WmlDkj8NrU110/TDcTqmS5Pucpvww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgGFBCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgGFBCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:02:05 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E8BE2082F;
        Mon,  6 Jul 2020 01:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593997324;
        bh=LqebZajuTrNEjjHajHRCQ35Qvk4gUVQQV87PbV+cOq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l67xp6bG2B1/sbk9ZohvkhFRyzXgrp3JP4RMnU1zKLntY3FskhU2EC0ds2CZldwZC
         4bAyxkpDl8P7MwhRBGTq32TCQDTkp32+Oft3JKQVSBXUABzt8XU+VGyfblfJS+vNuj
         3VBKolV7RHPE58mqIZxXEQWYq+V79u8Yl9j/kH4g=
Received: by mail-lj1-f172.google.com with SMTP id n23so43429781ljh.7;
        Sun, 05 Jul 2020 18:02:04 -0700 (PDT)
X-Gm-Message-State: AOAM531osdLV8Wwz+ir1wWaT7VQmoZG0/JJoQMnstqw1oZK3Iav6a/vA
        QnWxISF+su6X9eh6/DxmNfSrHucbLnIxbt1j+JM=
X-Google-Smtp-Source: ABdhPJzNCD8oHwSnnsDE6x/2dqhk9LSDUKVA5+59CBGYitqD8IoGxpOVly7D+jGJQOvbzn+FnIezm2PT5HdT0hn9JlU=
X-Received: by 2002:a2e:864e:: with SMTP id i14mr23462994ljj.441.1593997322637;
 Sun, 05 Jul 2020 18:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <1593958397-62466-1-git-send-email-guoren@kernel.org> <202007051336.C9EA0ECF65@keescook>
In-Reply-To: <202007051336.C9EA0ECF65@keescook>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 6 Jul 2020 09:01:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR5Fc1wpjr1ZYZikS=hCP9rbjJVsH9b-z2nBxbBcfBoCA@mail.gmail.com>
Message-ID: <CAJF2gTR5Fc1wpjr1ZYZikS=hCP9rbjJVsH9b-z2nBxbBcfBoCA@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: enable per-task stack canaries
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 4:40 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Jul 05, 2020 at 02:13:17PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > After compare arm64 and x86 implementations, seems arm64's is more
> > flexible and readable. The key point is how gcc get the offset of
> > stack_canary from gs/el0_sp.
> >
> > x86: Use a fix offset from gs, not flexible.
> >
> > struct fixed_percpu_data {
> >         /*
> >          * GCC hardcodes the stack canary as %gs:40.  Since the
> >          * irq_stack is the object at %gs:0, we reserve the bottom
> >          * 48 bytes of the irq stack for the canary.
> >          */
> >         char            gs_base[40]; // :(
> >         unsigned long   stack_canary;
> > };
>
> Yes, x86's compiler's implementation of "thread local" stack canary
> isn't great for the kernel.
>
> > arm64: Use -mstack-protector-guard-offset & guard-reg
> >
> > ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> > prepare: stack_protector_prepare
> > stack_protector_prepare: prepare0
> >        $(eval KBUILD_CFLAGS += -mstack-protector-guard=sysreg            \
> >                                -mstack-protector-guard-reg=sp_el0        \
> >                                -mstack-protector-guard-offset=$(shell    \
> >                        awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
> >                                        include/generated/asm-offsets.h))
> > endif
> >
> > I prefer arm64, but x86 percpu_data design needs to be considered ?
>
> I don't know riscv internals, so I leave that to y'all! :)
>
> > After the discussion, let's continue the work for riscv gcc
> > stack-protector.
>
> I think you'll need some buy-in from GCC before this kernel patch can
> land.
exactly!

>
> > Here is arm64 gcc's work [1].
> >
> > [1] https://github.com/gcc-mirror/gcc/commit/cd0b2d361df82c848dc7e1c3078651bb0624c3c6
>
> Can this kind of thing be made general-purposes, instead of having to
> reimplement it each time there's a new arch wanting to do it?
Great idea. Now only x86 arm64 support, It's the right time point.

>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/riscv/Kconfig                      |  7 +++++++
> >  arch/riscv/Makefile                     | 10 ++++++++++
> >  arch/riscv/include/asm/stackprotector.h |  3 ++-
> >  arch/riscv/kernel/asm-offsets.c         |  3 +++
> >  arch/riscv/kernel/process.c             |  2 +-
> >  5 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 4b0e308..4b4e833 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -394,6 +394,13 @@ config CMDLINE_FORCE
> >
> >  endchoice
> >
> > +config CC_HAVE_STACKPROTECTOR_SYSREG
Should change to CC_HAVE_STACKPROTECTOR_GPR

> > +     def_bool $(cc-option,-mstack-protector-guard=gpr -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
>
> And, as I'm sure you realize, it's not supported by the riscv backend
> yet:
>
> riscv64-unknown-linux-gnu-gcc: error: unrecognized command line option '-mstack-protector-guard=gpr'; did you mean '-fstack-protector-strong'?
> riscv64-unknown-linux-gnu-gcc: error: unrecognized command line option '-mstack-protector-guard-reg=tp'; did you mean '-fstack-protector-strong'?
> riscv64-unknown-linux-gnu-gcc: error: unrecognized command line option '-mstack-protector-guard-offset=0'; did you mean '-fstack-protector-strong'?

Yeah! :) I just want to show you, how about the format: use tp in gpr
to do that. The format is similar to arm64.

tp is the task_struct point in riscv.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
