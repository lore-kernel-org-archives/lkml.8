Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B21C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB13020772
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mp/R7usr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgF1OYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgF1OYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:24:11 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B6C061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 07:24:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c139so13064125qkg.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pa3FUFLT+GV81vsc2dzbhglUJ5l7g7j3SXkv9tIOgLA=;
        b=mp/R7usrLwgLeZThv5Gq64jafiV7slo6xS+y3bARloZbPdTDnwbaVZr0yzfM4dAKHz
         jYNG908GpvySGKoXvzOF9eFNBe55diWUAM2eiIyix8ZlWNo3o/Zp2LQUW+vQoTcvRcyw
         BWmZ+Og3Rv07zDh+sySlCqbnxYmb9f9wLyNT+eyMprsPPjXQGekXaKB97+TYlLK+rW5G
         4x8qBz0b4/vpPc8Qn34VTfH+kCD4YNMWeR4XXiO6U0ADKO7UhACm9nSvbfX3bTsxednH
         +pAiLdJ4CB99rffaG8bhh+aVbgo3iqcBVYsaX+rHGxknHZyGxtmmxL1/6k1EB1rOwRec
         n0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pa3FUFLT+GV81vsc2dzbhglUJ5l7g7j3SXkv9tIOgLA=;
        b=QIW9DRe+UR5ne2koMa+bEhUaN8xA6NQoKo6WxNP0ovg1fPYbhyz6hVl1yb9uM3XHKv
         lGXuzTD3Gm3aZK25Axg62KscBbSoMAeIS33madWTDcp9T/jq6ls/tHoFLi+t/0PM0zA4
         p42HGjlC1Pzk1ln9QeQl3uHLBahkqZWQ4DLCm6nN7Vv4dufPLAmtUJ5dGPWzpNEmQDaa
         3oTLkD08KvVz8kKTQvfKfh0pz3NoRTF0W+v+G4nIaizGHeyYfQ3i9aKp72g1QLZD3NJ5
         WgIUI6wKdyMIeYyks7Myjig32ny1/ys69pwHy9rAZlghJdDI1lMCKNX1CAQIp6B+lqPE
         OkBQ==
X-Gm-Message-State: AOAM531w7jtU1dgP55LxkYL8AZa8xX16ifraKiYT+DgYHXd0Vgce+YIO
        DcbhjZ2ymvv1YLjU7iFPsSAZTpG7LXvCkJ8Ecden/1IiMgSeLw==
X-Google-Smtp-Source: ABdhPJw5zJD2ITRLeUfhGJFPL5+vE4kpm0P9SFv6oFICaUdvrjg+qX9opcJL7lfW/+hCUHrqx93I9QVyT1Shd56pzkc=
X-Received: by 2002:ae9:e519:: with SMTP id w25mr11179177qkf.327.1593354250317;
 Sun, 28 Jun 2020 07:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <c0b15ad6-4385-41bb-82a6-a43107c0e0a1.guoren@linux.alibaba.com>
In-Reply-To: <c0b15ad6-4385-41bb-82a6-a43107c0e0a1.guoren@linux.alibaba.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Sun, 28 Jun 2020 22:23:54 +0800
Message-ID: <CAHCEehK3N_1dbgX2ZbSg0zG9mHc2XUdZFs0F+-65H7TDyYGp4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Enable context tracking
To:     guoren <guoren@linux.alibaba.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        aou <aou@eecs.berkeley.edu>, palmer <palmer@dabbelt.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

guoren <guoren@linux.alibaba.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Greentime,
>
> On 2020/6/23 9:28 =E4=B8=8B=E5=8D=88, Greentime Hu wrote:
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
> >                          _-----=3D> irqs-off
> >                         / _----=3D> need-resched
> >                        | / _---=3D> hardirq/softirq
> >                        || / _--=3D> preempt-depth
> >                        ||| /     delay
> >       TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> >          | |       |   ||||       |         |
> >     <idle>-0     [001] d..2   604.183512: sched_switch: prev_comm=3Dswa=
pper/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Dtask=
set next_pid=3D273 next_prio=3D120
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
> >      <...>-46    [001] ....   604.185194: workqueue_execute_start: work=
 struct 00000000383402c2: function vmstat_update
> >      <...>-46    [001] d..2   604.185266: sched_switch: prev_comm=3Dkwo=
rker/1:1 prev_pid=3D46 prev_prio=3D120 prev_state=3DI =3D=3D> next_comm=3Dt=
askset next_pid=3D273 next_prio=3D120
> > user_loop-273   [001] d.h1   604.188812: hrtimer_expire_entry: hrtimer=
=3D000000002eda5fab function=3Dtick_sched_timer now=3D604180133400
> > user_loop-273   [001] d..1   604.189050: tick_stop: success=3D1 depende=
ncy=3DNONE
> > user_loop-273   [001] d..2   614.251386: sched_switch: prev_comm=3Duser=
_loop prev_pid=3D273 prev_prio=3D120 prev_state=3DX =3D=3D> next_comm=3Dswa=
pper/1 next_pid=3D0 next_prio=3D120
> >     <idle>-0     [001] d..2   614.315391: sched_switch: prev_comm=3Dswa=
pper/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Dtask=
set next_pid=3D276 next_prio=3D120
> >
> > Signed-off-by: Greentime Hu<greentime.hu@sifive.com>
> > ---
> >   arch/riscv/Kconfig        |  1 +
> >   arch/riscv/kernel/entry.S | 23 +++++++++++++++++++++++
> >   2 files changed, 24 insertions(+)
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
> >   .option pop
> >
> > +#ifdef CONFIG_CONTEXT_TRACKING
> > +     /* If previous state is in user mode, call context_tracking_user_=
exit. */
> > +     andi a0, s1, SR_SPP
> > +     bnez a0, skip_context_tracking
> > +     call context_tracking_user_exit
>
> It will destroy s1-s5 which are used in entry.S like these:
>
>          REG_S s0, PT_SP(sp)
>          REG_S s1, PT_STATUS(sp)
>          REG_S s2, PT_EPC(sp)
>          REG_S s3, PT_BADADDR(sp)
>          REG_S s4, PT_CAUSE(sp)
>          REG_S s5, PT_TP(sp)
> ...
>          /*
>           * MSB of cause differentiates between
>           * interrupts and exceptions
>           */
>          bge s4, zero, 1f
>
> ...
>
>          /*
>           * Exceptions run with interrupts enabled or disabled depending
> on the
>           * state of SR_PIE in m/sstatus.
>           */
>          andi t0, s1, SR_PIE
>
> ...
>
>          /* Handle syscalls */
>          li t0, EXC_SYSCALL
>          beq s4, t0, handle_syscall
>
> ...
>
> I also solved it in my lockdep patches, please have a look:
> https://lore.kernel.org/linux-riscv/1592323021-98541-4-git-send-email-guo=
ren@kernel.org/T/#u
>
>

Hi Guo,

These registers are callee saved registers. I think callee will take care o=
f it.
https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md#integ=
er-register-convention-
