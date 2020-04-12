Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B9FC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 05:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FD3206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 05:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586668442;
	bh=o15yl6i3Tl6MjNG1fMvCTZ6LsBdH7GT+eCxjX/2NlTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SvO+v+/H8vlK0qvt/VCebOEJFTVnF3pamEAIfMwY9O8nE/4qiakAA7cbe3lN7tCMe
	 BExplTjXo1cskHCG4zX86RoviNCUpvs9Dv9i4i9IvelaLgqUpq7q6Sn2/vgmczi2PK
	 AqdrhxKB5oyDPAQCaNu1x3Xt58VeWOsfgiLVmEis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgDLFOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 01:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgDLFOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 01:14:01 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50F4B206E9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 05:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586668440;
        bh=o15yl6i3Tl6MjNG1fMvCTZ6LsBdH7GT+eCxjX/2NlTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HFvDe0oW/RQ9oBEzXDLIjZI66tFIcAhZ+LNwoC1HT3WifMwemhoqOb04u+63W21j3
         G9kWE0eKfQYOZFA1nArl5IV+EO1XGinJPKL0fYVjmKjnY9QAfS3zFm21s7I6X2xMVC
         93ZD0xzr+Qk0iVeyCVy3l01k/HeZliB9X5eNPvv4=
Received: by mail-lj1-f182.google.com with SMTP id q19so5677698ljp.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 22:14:00 -0700 (PDT)
X-Gm-Message-State: AGi0Puboq2tNmtb0b4vl9hlcmSTkhgTnFUc0GdvLO/lmPIXGhSL5Qblv
        yksvW9rbTpbL5aMIVT2SNxMORfhuZEvidu/Fdt4=
X-Google-Smtp-Source: APiQypIvKIuQln1REJ+wnYOKl40MquF0FqzdfLMcawVz+7qg8LKopErPAReWxCpNoQEhbFRpzSEQ3l0Xailj64Ujqio=
X-Received: by 2002:a2e:3812:: with SMTP id f18mr7437940lja.67.1586668438308;
 Sat, 11 Apr 2020 22:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200410032634.57511-1-zong.li@sifive.com> <CAJF2gTSAe_=0Eg12O-Sjc6897EOqwZOQFPc5utKWQ32gn6BFEA@mail.gmail.com>
 <CANXhq0rPxoKfwL302ehihr=TR64mN1_T8qBH9vbDbrpdfzR1tg@mail.gmail.com>
In-Reply-To: <CANXhq0rPxoKfwL302ehihr=TR64mN1_T8qBH9vbDbrpdfzR1tg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 12 Apr 2020 13:13:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQzC+cO+7Wjh5ZHJMocJRZJLvMpbUkjV7o9BmnX9pEN_g@mail.gmail.com>
Message-ID: <CAJF2gTQzC+cO+7Wjh5ZHJMocJRZJLvMpbUkjV7o9BmnX9pEN_g@mail.gmail.com>
Subject: Re: [PATCH] riscv: remove the assert of lock for cpu_running
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'll continue riscv locdep work and include your patch.

On Sat, Apr 11, 2020 at 12:17 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Sat, Apr 11, 2020 at 11:44 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Acked-by: Guo Ren <guoren@kernel.org>
> >
> > Haha, are you working on lockdep ? Me too, here is my patch, not finished.
>
> No, I just went to add a lock assert at somewhere, so enabled lockdep
> to test it on incomplete lockdep support, then I found this error. If
> you are working on lockdep, it might be better to fix this problem on
> your side instead of here.
>
> >
> > It's still warning at begin, I've no time to debug, and it's similar to csky's:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/csky?id=000591f1ca3312d9a29e15a9e3fe5c4171f75586
> >
> > If you are working on LOCKDEP, I'll wait your patch :)
> >
> > commit 096d7a4b26d21aa7c71c86f200241144569e697a (riscv-lockdep)
> > Author: Guo Ren <guoren@linux.alibaba.com>
> > Date:   Fri Apr 10 16:38:37 2020 +0800
> >
> >     riscv: Enable LOCKDEP_SUPPORT
> >
> >     Lockdep is needed by proving the spinlocks and rwlocks.
> >
> >     Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 8672e77a5b7a..bfe76c76a107 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -163,6 +163,9 @@ config PGTABLE_LEVELS
> >         default 3 if 64BIT
> >         default 2
> >
> > +config LOCKDEP_SUPPORT
> > +       def_bool y
> > +
> >  source "arch/riscv/Kconfig.socs"
> >
> >  menu "Platform type"
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 208702d8c18e..41588ee74cb2 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -175,6 +175,24 @@ ENTRY(handle_exception)
> >  .option pop
> >
> >         la ra, ret_from_exception
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +       call trace_hardirqs_off
> > +       la ra, ret_from_exception
> > +       REG_L s0, PT_SP(sp)
> > +       REG_L s1, PT_STATUS(sp)
> > +       REG_L s2, PT_EPC(sp)
> > +       REG_L s3, PT_BADADDR(sp)
> > +       REG_L s4, PT_CAUSE(sp)
> > +       REG_L s5, PT_TP(sp)
> > +       REG_L a0, PT_A0(sp)
> > +       REG_L a1, PT_A1(sp)
> > +       REG_L a2, PT_A2(sp)
> > +       REG_L a3, PT_A3(sp)
> > +       REG_L a4, PT_A4(sp)
> > +       REG_L a5, PT_A5(sp)
> > +       REG_L a6, PT_A6(sp)
> > +       REG_L a7, PT_A7(sp)
> > +#endif
> >         /*
> >          * MSB of cause differentiates between
> >          * interrupts and exceptions
> > @@ -191,6 +209,24 @@ ENTRY(handle_exception)
> >          */
> >         andi t0, s1, SR_PIE
> >         beqz t0, 1f
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +       call trace_hardirqs_on
> > +       la ra, ret_from_exception
> > +       REG_L s0, PT_SP(sp)
> > +       REG_L s1, PT_STATUS(sp)
> > +       REG_L s2, PT_EPC(sp)
> > +       REG_L s3, PT_BADADDR(sp)
> > +       REG_L s4, PT_CAUSE(sp)
> > +       REG_L s5, PT_TP(sp)
> > +       REG_L a0, PT_A0(sp)
> > +       REG_L a1, PT_A1(sp)
> > +       REG_L a2, PT_A2(sp)
> > +       REG_L a3, PT_A3(sp)
> > +       REG_L a4, PT_A4(sp)
> > +       REG_L a5, PT_A5(sp)
> > +       REG_L a6, PT_A6(sp)
> > +       REG_L a7, PT_A7(sp)
> > +#endif
> >         csrs CSR_STATUS, SR_IE
> >
> >  1:
> > @@ -291,6 +327,31 @@ resume_userspace:
> >         csrw CSR_SCRATCH, tp
> >
> >  restore_all:
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +       REG_L s1, PT_STATUS(sp)
> > +       andi t0, s1, SR_PIE
> > +       beqz t0, 1f
> > +       call trace_hardirqs_on
> > +       j 2f
> > +1:
> > +       call trace_hardirqs_off
> > +2:
> > +       la ra, ret_from_exception
> > +       REG_L s0, PT_SP(sp)
> > +       REG_L s1, PT_STATUS(sp)
> > +       REG_L s2, PT_EPC(sp)
> > +       REG_L s3, PT_BADADDR(sp)
> > +       REG_L s4, PT_CAUSE(sp)
> > +       REG_L s5, PT_TP(sp)
> > +       REG_L a0, PT_A0(sp)
> > +       REG_L a1, PT_A1(sp)
> > +       REG_L a2, PT_A2(sp)
> > +       REG_L a3, PT_A3(sp)
> > +       REG_L a4, PT_A4(sp)
> > +       REG_L a5, PT_A5(sp)
> > +       REG_L a6, PT_A6(sp)
> > +       REG_L a7, PT_A7(sp)
> > +#endif
> >         RESTORE_ALL
> >  #ifdef CONFIG_RISCV_M_MODE
> >         mret
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 8bc01f0ca73b..54fd70eb50bd 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -115,7 +115,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> >                   task_stack_page(tidle) + THREAD_SIZE);
> >         WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> >
> > -       lockdep_assert_held(&cpu_running);
> > +//     lockdep_assert_held(&cpu_running);
> >         wait_for_completion_timeout(&cpu_running,
> >                                             msecs_to_jiffies(1000));
> >
> > On Fri, Apr 10, 2020 at 11:26 AM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > The cpu_running is not a lock-class, it lacks the dep_map member in
> > > completion. It causes the error as follow:
> > >
> > > arch/riscv/kernel/smpboot.c: In function '__cpu_up':
> > > ./include/linux/lockdep.h:364:52: error: 'struct completion' has no member named 'dep_map'
> > >   364 | #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
> > >       |                                                    ^~
> > > ./include/asm-generic/bug.h:113:25: note: in definition of macro 'WARN_ON'
> > >   113 |  int __ret_warn_on = !!(condition);    \
> > >       |                         ^~~~~~~~~
> > > ./include/linux/lockdep.h:390:27: note: in expansion of macro 'lockdep_is_held'
> > >   390 |   WARN_ON(debug_locks && !lockdep_is_held(l)); \
> > >       |                           ^~~~~~~~~~~~~~~
> > > arch/riscv/kernel/smpboot.c:118:2: note: in expansion of macro 'lockdep_assert_held'
> > >   118 |  lockdep_assert_held(&cpu_running);
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  arch/riscv/kernel/smpboot.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > > index 8bc01f0ca73b..bbc1baa2d90c 100644
> > > --- a/arch/riscv/kernel/smpboot.c
> > > +++ b/arch/riscv/kernel/smpboot.c
> > > @@ -115,7 +115,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> > >                   task_stack_page(tidle) + THREAD_SIZE);
> > >         WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> > >
> > > -       lockdep_assert_held(&cpu_running);
> > >         wait_for_completion_timeout(&cpu_running,
> > >                                             msecs_to_jiffies(1000));
> > >
> > > --
> > > 2.26.0
> > >
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
