Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ED7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0936B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594795527;
	bh=rKQFcR5alF+tFHNKtaYJiSGqtRDX2JlX7RDtb0GdOmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B5Ks04CytlFET9oI7li0BVkReuDcitk4Cd1QT64J46pCkkgpEKtfJN7VFsQ8UWfoQ
	 I5FSJCCMqfLeJoSKAylmPA/Me7xKV5LsHeF3wf7ryr3fitYVof/xM6DVH03xQC3df/
	 fiOVqa9rhQnKNvyBTlv0P1PPh/vi7Yb4spYRvZ/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgGOGpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgGOGpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:45:25 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFF920663;
        Wed, 15 Jul 2020 06:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594795524;
        bh=rKQFcR5alF+tFHNKtaYJiSGqtRDX2JlX7RDtb0GdOmc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EhPnHnmGjr9wUskH8IHnqYjMOeqOC9zhaqoAqGrWNtaH18+N6XBDUIR3Fr17Ea8PE
         UsJKYMxN4axyKiNqxR3dJz9VqTf+eKpHpTV7ZVQL2p82GEbQlwEkbyZ+hqqMfs1zeJ
         um8RWUOPUcXDk+ODk680OoEUvzGSnGBI5fSSVi3U=
Received: by mail-lj1-f175.google.com with SMTP id q7so1367096ljm.1;
        Tue, 14 Jul 2020 23:45:24 -0700 (PDT)
X-Gm-Message-State: AOAM530AXJMrKlfGyiT+4hCKzkZzxKojJTFWwt2OvJdLxYzCvrGYl809
        Q9siw12Uf5is7N8kp/5bkpXG0ibY5Bs2hYl8ENY=
X-Google-Smtp-Source: ABdhPJzgLkHaatXo/v6B0i4NJW/UfIrAeP0WiiA7KGRrdx2EC97RJWu3/XV++mMaaxckgsPRAX1beDkOkn4BaplKO8o=
X-Received: by 2002:a2e:7e08:: with SMTP id z8mr3978030ljc.66.1594795522826;
 Tue, 14 Jul 2020 23:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <1594683562-68149-1-git-send-email-guoren@kernel.org> <20200714202346.0911e9475bf30a30d0d36b67@kernel.org>
In-Reply-To: <20200714202346.0911e9475bf30a30d0d36b67@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 15 Jul 2020 14:45:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTGvmtjiXdd882k9krvnO_MpNZ6qkjwxDvy=ZOyDTA3bw@mail.gmail.com>
Message-ID: <CAJF2gTTGvmtjiXdd882k9krvnO_MpNZ6qkjwxDvy=ZOyDTA3bw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] riscv: Add k/uprobe supported
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>, linux-csky@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 7:23 PM Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>
> Hi Guo,
>
> On Mon, 13 Jul 2020 23:39:15 +0000
> guoren@kernel.org wrote:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The patchset includes kprobe/uprobe support and some related fixups.
> > Patrick provides HAVE_REGS_AND_STACK_ACCESS_API support and some
> > kprobe's code. The framework of k/uprobe is from csky but also refers
> > to other arches'. kprobes on ftrace is also supported in the patchset.
> >
> > There is no single step exception in riscv ISA, only single-step
> > facility for jtag. See riscv-Privileged spec:
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
> > Other arches use hardware single-step exception for k/uprobe,  eg:
> >  - powerpc: regs->msr |=3D MSR_SINGLESTEP
> >  - arm/arm64: PSTATE.D for enabling software step exceptions
> >  - s390: Set PER control regs, turns on single step for the given addre=
ss
> >  - x86: regs->flags |=3D X86_EFLAGS_TF
> >  - csky: of course use hw single step :)
> >
> > All the above arches use a hardware single-step exception
> > mechanism to execute the instruction that was replaced with a probe
> > breakpoint. So utilize ebreak to simulate.
> >
> > Some pc related instructions couldn't be executed out of line and some
> > system/fence instructions couldn't be a trace site at all. So we give
> > out a reject list and simulate list in decode-insn.c.
> >
> > You could use uprobe to test simulate code like this:
> >
> >  echo 'p:enter_current_state_one /hello:0x6e4 a0=3D%a0 a1=3D%a1' >> /sy=
s/kernel/debug/tracing/uprobe_events
> >  echo 1 > /sys/kernel/debug/tracing/events/uprobes/enable
> >  /hello
> >  ^C
> >  cat /sys/kernel/debug/tracing/trace
> >  tracer: nop
> >
> >  entries-in-buffer/entries-written: 1/1   #P:1
> >
> >                               _-----=3D> irqs-off
> >                              / _----=3D> need-resched
> >                             | / _---=3D> hardirq/softirq
> >                             || / _--=3D> preempt-depth
> >                             ||| /     delay
> >            TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> >               | |       |   ||||       |         |
> >           hello-94    [000] d...    55.404242: enter_current_state_one:=
 (0x106e4) a0=3D0x1 a1=3D0x3fffa8ada8
> >
> > Be care /hello:0x6e4 is the file offset in elf and it relate to 0x106e4
> > in memory and hello is your target elf program.
> >
> > Try kprobe like this:
> >
> >  echo 'p:myprobe _do_fork dfd=3D%a0 filename=3D%a1 flags=3D%a2 mode=3D+=
4($stack)' > /sys/kernel/debug/tracing/kprobe_events
> >  echo 'r:myretprobe _do_fork $retval' >> /sys/kernel/debug/tracing/kpro=
be_event
> >
> >  echo 1 >/sys/kernel/debug/tracing/events/kprobes/enable
> >  cat /sys/kernel/debug/tracing/trace
> >  tracer: nop
> >
> >  entries-in-buffer/entries-written: 2/2   #P:1
> >
> >                               _-----=3D> irqs-off
> >                              / _----=3D> need-resched
> >                             | / _---=3D> hardirq/softirq
> >                             || / _--=3D> preempt-depth
> >                             ||| /     delay
> >            TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> >               | |       |   ||||       |         |
> >              sh-92    [000] .n..   131.804230: myprobe: (_do_fork+0x0/0=
x2e6) dfd=3D0xffffffe03929fdf8 filename=3D0x0 flags=3D0x101000 mode=3D0x120=
0000ffffffe0
> >              sh-92    [000] d...   131.806607: myretprobe: (__do_sys_cl=
one+0x70/0x82 <- _do_fork) arg1=3D0x5f
> >  cat /sys/kernel/debug/tracing/trace
>
> Thank you for your great work!
>
> BTW, could you also run the ftracetest and boot-time smoke test on it?
> You can find it under tools/testing/selftests/ftrace, and
> CONFIG_KPROBES_SANITY_TEST.
> It will ensure that your patch is correctly ported.

CONFIG_KPROBES_SANITY_TEST passed:
[    0.078274] NET: Registered protocol family 16
[    0.162015] Kprobe smoke test: started
[    0.456900] Kprobe smoke test: passed successfully

The tools/testing/selftests/ftrace cover a lot of stuff not only
kprobe, and I'll try them later to fixup in another patchset.
--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
