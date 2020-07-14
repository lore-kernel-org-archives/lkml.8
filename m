Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC7C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACE3221FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594743910;
	bh=k/Tsw6xLqgnJY1o7iH6r4M/K+u3aSSQdGkYMYdYd8I8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KINpTK1WbBMOh8Rx/Aat1XzPtJ2ABQ+e3j0DWhC7uGJXo6XGO01vHUeLoW2gOelP0
	 BTx84iSv78e7Hjpqfdh9ANcFAHbkWmUHrJ5sCrbaTUPCA9Id+Yfls9zDQVjVgxfXLD
	 0kS2abJXZdtyvWwKHMZfWtoY5E9DrQ1X74N2ZQgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgGNQZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgGNQZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:25:08 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60662255F;
        Tue, 14 Jul 2020 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594743908;
        bh=k/Tsw6xLqgnJY1o7iH6r4M/K+u3aSSQdGkYMYdYd8I8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VTmpkPIzMgweGoJMVFQhHwPlTmsACcCZYKLnJf4uV5MJbosmzzKJ397vHUls2HOaz
         eFZ69VNZv/h5RjAH/J8ksD9O2qsAxaIIp5R0iwg9VlZld06OGkc2JS41oAV6UtM2Za
         h6VSMX+rCl64xxRhkdYo617vEockbRKEzQ3aA/hg=
Received: by mail-lj1-f171.google.com with SMTP id d17so23599198ljl.3;
        Tue, 14 Jul 2020 09:25:07 -0700 (PDT)
X-Gm-Message-State: AOAM530zx9pSZGMmt+pXQJpdJUBK8GQyz5xzGkOp7MZq62TcyGqWho1E
        B9u7XmA/PYsim9qu+R+jpLh0W7yFrwIv9gSaKYk=
X-Google-Smtp-Source: ABdhPJw2LgpnAjeHGhekyjVCCVOxT1kK9hVgydd27e2JfjQorPcSs3QPMc/nVkb/g8IlxUzlBQI7f749Aj988uEH82o=
X-Received: by 2002:a2e:864e:: with SMTP id i14mr2747628ljj.441.1594743905973;
 Tue, 14 Jul 2020 09:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <1594683562-68149-1-git-send-email-guoren@kernel.org>
 <1594683562-68149-7-git-send-email-guoren@kernel.org> <20200714203757.512ce7fb5fa61a88b1dbb2f3@kernel.org>
In-Reply-To: <20200714203757.512ce7fb5fa61a88b1dbb2f3@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 15 Jul 2020 00:24:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSMUnHfv3GLj_TGT2dJkKq2zbEsnbPKREiq5i6PPjyTBg@mail.gmail.com>
Message-ID: <CAJF2gTSMUnHfv3GLj_TGT2dJkKq2zbEsnbPKREiq5i6PPjyTBg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] riscv: Add KPROBES_ON_FTRACE supported
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
        Guo Ren <guoren@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Masami,

On Tue, Jul 14, 2020 at 7:38 PM Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>
> On Mon, 13 Jul 2020 23:39:21 +0000
> guoren@kernel.org wrote:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch adds support for kprobes on ftrace call sites to avoids
> > much of the overhead with regular kprobes. Try it with simple
> > steps:
> >
> > 1. Get _do_fork ftrace call site.
> > Dump of assembler code for function _do_fork:
> >    0xffffffe00020af64 <+0>:     addi    sp,sp,-128
> >    0xffffffe00020af66 <+2>:     sd      s0,112(sp)
> >    0xffffffe00020af68 <+4>:     sd      ra,120(sp)
> >    0xffffffe00020af6a <+6>:     addi    s0,sp,128
> >    0xffffffe00020af6c <+8>:     sd      s1,104(sp)
> >    0xffffffe00020af6e <+10>:    sd      s2,96(sp)
> >    0xffffffe00020af70 <+12>:    sd      s3,88(sp)
> >    0xffffffe00020af72 <+14>:    sd      s4,80(sp)
> >    0xffffffe00020af74 <+16>:    sd      s5,72(sp)
> >    0xffffffe00020af76 <+18>:    sd      s6,64(sp)
> >    0xffffffe00020af78 <+20>:    sd      s7,56(sp)
> >    0xffffffe00020af7a <+22>:    mv      s4,a0
> >    0xffffffe00020af7c <+24>:    mv      a0,ra
> >    0xffffffe00020af7e <+26>:    nop   <<<<<<<< here!
> >    0xffffffe00020af82 <+30>:    nop
> >    0xffffffe00020af86 <+34>:    ld      s3,0(s4)
> >
> > 2. Set _do_fork+26 as the kprobe.
> >   echo 'p:myprobe _do_fork+26 dfd=3D%a0 filename=3D%a1 flags=3D%a2 mode=
=3D+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
> >   echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> >   cat /sys/kernel/debug/tracing/trace
> >   tracer: nop
> >
> >   entries-in-buffer/entries-written: 3/3   #P:1
> >
> >                                _-----=3D> irqs-off
> >                               / _----=3D> need-resched
> >                              | / _---=3D> hardirq/softirq
> >                              || / _--=3D> preempt-depth
> >                              ||| /     delay
> >             TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> >                | |       |   ||||       |         |
> >               sh-87    [000] ....   551.557031: myprobe: (_do_fork+0x1a=
/0x2e6) dfd=3D0xffffffe00020af7e filename=3D0xffffffe00020b34e flags=3D0xff=
ffffe00101e7c0 mode=3D0x20af86ffffffe0
> >
> >   cat /sys/kernel/debug/kprobes/list
> > ffffffe00020af7e  k  _do_fork+0x1a    [FTRACE]
> >                                        ^^^^^^
>
> Hmm, this seems fentry is not supported on RISC-V yet. But anyway,
> it will be useful for users (if they can find the offset).

Seems only x86 & =E2=AC=86=EF=B8=8F90 use fentry=EF=BC=8Ccan you elaborate =
more about fentry's
benefit and how the user could set kprobe on ftrace call site without
disassemble?

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
