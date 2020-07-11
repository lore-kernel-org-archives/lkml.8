Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A181C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8B320674
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lma5SysD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGKBrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgGKBrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:47:46 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E3C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:47:45 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so5985951qtf.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LwJ+r+zSNbDBrbHfG/yJxOB40XctVV/C95i6o1WQLd4=;
        b=lma5SysDXyrK4RYvkDP8GEQsGxjhc2LXx53kWcKEhjTNIJCPn6w1atInBkWAnCBz2z
         SeRRlFRe1Kqp3cCHxDcBdqw/Xdszlqjncq5/pHTNHITUohwxESCzIsgoO0MlVwv5tRlR
         6RLalIKftGqw6UrvQHWWgPSCMN82D6ZmM8a1+W8i5sD37+giXDsFz8rJCy+E9yHcH6Ox
         PPfz2/hOBZq7T6nayvBfsXHAeeC6bwOlqrW4iwRg85BczayLvMDCOf+WKxTPb1bSGEUL
         EejMd3WGqpFDiOVMRPM1MWZZK0p9Qq1aAb/lwqUAeoiyBWB50qFo05vfUlKXRg6p7rOz
         NrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LwJ+r+zSNbDBrbHfG/yJxOB40XctVV/C95i6o1WQLd4=;
        b=rpRv5HT+Q41pgP4nkJhl2pTMd04/5rmxiT6iSsg1Nmq0ccHzfLYb9GMbmfPn7CKagf
         KrH6HgiN5Lq2WYAgIL1DKVvm2HdZcjL9Y4QHMpuO+EE96mVqAL017RB58e7SL3j26GZD
         51faJlzYfmR4aoNtsG45ahRYTXXLtNkRScCLcVyy05cZ8ytVSgz3YUHupsu5SN9xVw28
         J4uhkeoqcChn9e6eGA/0V1DKNZv6XaDtg5CIQMpj0X6Jau0P0v/qI6E+o/rpHuUiv3vd
         xuGsB8QQZuu9ZMESMAQ2wIXbxP/ZIrh4AmjDLqDkrz/70uOCt2tbCETX9MGVusRYMVMI
         OSKg==
X-Gm-Message-State: AOAM533OxEmUx475BheS6W7xEPmV7DhRW9+mc/JD3Z60ntqtNyN3wRYL
        qsOxqSrkJGf0ardDcdzOoOhXIhgE5bvQtw/UHNcNDg==
X-Google-Smtp-Source: ABdhPJw6Kjf8WI27c8EPcBFNEhz4cx+nw2z0k5lxVojVNh0y79LY5wif82NNbsx21QLsNRtUZOyRWuccgNVRNLIhIQc=
X-Received: by 2002:ac8:7593:: with SMTP id s19mr42297445qtq.199.1594432064956;
 Fri, 10 Jul 2020 18:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <1d89d5a6b54ca3d3203cb02ff4548b4eb9820c61.1592989082.git.greentime.hu@sifive.com>
 <mhng-21b29738-a664-4209-89e8-763e32a59a4e@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-21b29738-a664-4209-89e8-763e32a59a4e@palmerdabbelt-glaptop1>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Sat, 11 Jul 2020 09:47:33 +0800
Message-ID: <CAHCEeh+8wzxLGEU7Mr18j6bTzYCG8fUtHBAKv6AJ7ZnEkjNr=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: Enable context tracking
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8811=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 24 Jun 2020 02:03:16 PDT (-0700), greentime.hu@sifive.com wrote:
> > This patch implements and enables context tracking for riscv (which is =
a
> > prerequisite for CONFIG_NO_HZ_FULL support)
> >
> > It adds checking for previous state in the entry that all excepttions a=
nd
> > interrupts goes to and calls context_tracking_user_exit() if it comes f=
rom
> > user space. It also calls context_tracking_user_enter() if it will retu=
rn
> > to user space before restore_all.
> >
> > This patch is tested with the dynticks-testing testcase in
> > qemu-system-riscv64 virt machine and Unleashed board.
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/dynticks-testing=
.git
> >
> > We can see the log here. The tick got mostly stopped during the executi=
on
> > of the user loop.
> >
> >                         _-----=3D> irqs-off
> >                        / _----=3D> need-resched
> >                       | / _---=3D> hardirq/softirq
> >                       || / _--=3D> preempt-depth
> >                       ||| /     delay
> >      TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> >         | |       |   ||||       |         |
> >    <idle>-0     [001] d..2   604.183512: sched_switch: prev_comm=3Dswap=
per/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Dtasks=
et next_pid=3D273 next_prio=3D120
> > user_loop-273   [001] d.h1   604.184788: hrtimer_expire_entry: hrtimer=
=3D000000002eda5fab function=3Dtick_sched_timer now=3D604176096300
> > user_loop-273   [001] d.s2   604.184897: workqueue_queue_work: work str=
uct=3D00000000383402c2 function=3Dvmstat_update workqueue=3D00000000f36d35d=
4 req_cpu=3D1 cpu=3D1
> > user_loop-273   [001] dns2   604.185039: tick_stop: success=3D0 depende=
ncy=3DSCHED
> > user_loop-273   [001] dn.1   604.185103: tick_stop: success=3D0 depende=
ncy=3DSCHED
> > user_loop-273   [001] d..2   604.185154: sched_switch: prev_comm=3Dtask=
set prev_pid=3D273 prev_prio=3D120 prev_state=3DR+ =3D=3D> next_comm=3Dkwor=
ker/1:1 next_pid=3D46 next_prio=3D120
> >     <...>-46    [001] ....   604.185194: workqueue_execute_start: work =
struct 00000000383402c2: function vmstat_update
> >     <...>-46    [001] d..2   604.185266: sched_switch: prev_comm=3Dkwor=
ker/1:1 prev_pid=3D46 prev_prio=3D120 prev_state=3DI =3D=3D> next_comm=3Dta=
skset next_pid=3D273 next_prio=3D120
> > user_loop-273   [001] d.h1   604.188812: hrtimer_expire_entry: hrtimer=
=3D000000002eda5fab function=3Dtick_sched_timer now=3D604180133400
> > user_loop-273   [001] d..1   604.189050: tick_stop: success=3D1 depende=
ncy=3DNONE
> > user_loop-273   [001] d..2   614.251386: sched_switch: prev_comm=3Duser=
_loop prev_pid=3D273 prev_prio=3D120 prev_state=3DX =3D=3D> next_comm=3Dswa=
pper/1 next_pid=3D0 next_prio=3D120
> >    <idle>-0     [001] d..2   614.315391: sched_switch: prev_comm=3Dswap=
per/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Dtasks=
et next_pid=3D276 next_prio=3D120
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/Kconfig        |  1 +
> >  arch/riscv/kernel/entry.S | 23 +++++++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 128192e14ff2..17520e11815b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -52,6 +52,7 @@ config RISCV
> >       select HAVE_ARCH_SECCOMP_FILTER
> >       select HAVE_ARCH_TRACEHOOK
> >       select HAVE_ASM_MODVERSIONS
> > +     select HAVE_CONTEXT_TRACKING
> >       select HAVE_COPY_THREAD_TLS
> >       select HAVE_DMA_CONTIGUOUS if MMU
> >       select HAVE_EBPF_JIT if MMU
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index cae7e6d4c7ef..6ed579fc1073 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -97,6 +97,14 @@ _save_context:
> >       la gp, __global_pointer$
> >  .option pop
> >
> > +#ifdef CONFIG_CONTEXT_TRACKING
> > +     /* If previous state is in user mode, call context_tracking_user_=
exit. */
> > +     andi a0, s1, SR_SPP
>
> I've changed that to SR_PP, as I don't see any reason why this should dep=
end on
> MMU.
>
> I think this is correct: we're using scratch=3D=3D0 elsewhere to detect r=
ecursive
> traps, but we've blown that away by this point so it's not an option.  I =
don't
> know of any reason why PP wouldn't be accurate.

Hi Palmer,

Thank you. That makes sense to me.

>
> > +     bnez a0, skip_context_tracking
> > +     call context_tracking_user_exit
> > +
> > +skip_context_tracking:
> > +#endif
> >       la ra, ret_from_exception
> >       /*
> >        * MSB of cause differentiates between
> > @@ -137,6 +145,17 @@ _save_context:
> >       tail do_trap_unknown
> >
> >  handle_syscall:
> > +#ifdef CONFIG_CONTEXT_TRACKING
> > +     /* Recover a0 - a7 for system calls */
> > +     REG_L x10, PT_A0(sp)
> > +     REG_L x11, PT_A1(sp)
> > +     REG_L x12, PT_A2(sp)
> > +     REG_L x13, PT_A3(sp)
> > +     REG_L x14, PT_A4(sp)
> > +     REG_L x15, PT_A5(sp)
> > +     REG_L x16, PT_A6(sp)
> > +     REG_L x17, PT_A7(sp)
> > +#endif
> >        /* save the initial A0 value (needed in signal handlers) */
> >       REG_S a0, PT_ORIG_A0(sp)
> >       /*
> > @@ -205,6 +224,10 @@ resume_userspace:
> >       andi s1, s0, _TIF_WORK_MASK
> >       bnez s1, work_pending
> >
> > +#ifdef CONFIG_CONTEXT_TRACKING
> > +     call context_tracking_user_enter
> > +#endif
> > +
> >       /* Save unwound kernel stack pointer in thread_info */
> >       addi s0, sp, PT_SIZE_ON_STACK
> >       REG_S s0, TASK_TI_KERNEL_SP(tp)
