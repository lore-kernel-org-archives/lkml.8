Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148BDC433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4FB207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595424697;
	bh=G+K3d514kcxDDUU/TieFP3V0nSBRnKLAgwKlg3nKpOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jNHTpCRIBsyZ+GBTjMr0Tcw/st7O6HJaP+l5aP1NS45brgW/91qduNAdUpgPzWTPm
	 aYMKYeBPTYV8P7EgqH6JLWGUbGHf4tJr53pQ8H1dvgw+DWCGt75UK9VSXv6u+XTU69
	 O00PK7FU0ZH22KxQ3+1a6Pgo88p2NDitN5FjK484=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgGVNbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgGVNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:31:34 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB11207BB;
        Wed, 22 Jul 2020 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595424694;
        bh=G+K3d514kcxDDUU/TieFP3V0nSBRnKLAgwKlg3nKpOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qtqVsywTdyKY0aLtGD7JuZ+qcoKUwI4hl8trE9CPPMhV3qlgTpMTYLvs5Y0jeTGlC
         k0g/7b8jeMzwqCY/GM+3WrGj7wo7qTagwHXLA/K2A/8jK92j0czE+TPYj2Q5QECoy6
         NWp9gVuH6gKeb6Zr8H5ZHawpEr1CELbE85dKoCa0=
Received: by mail-lj1-f171.google.com with SMTP id j11so2493100ljo.7;
        Wed, 22 Jul 2020 06:31:33 -0700 (PDT)
X-Gm-Message-State: AOAM5330qKK8C5u0YX2Vy55LFXtHLxB1M63VSE08R/c64OWnfIG14fzw
        Wh2LHfI8cZr5Qu0OXm2Tgz4ADQKb976rF2TgHLs=
X-Google-Smtp-Source: ABdhPJw7AlCg8zPFdGB7cfoEAZq9U0346rr0bSMhuJZm/pzQsspB7CrpgTev9f3U1nbJZCYRWvKZKCFQWwq0czTvfzQ=
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr14060325ljl.250.1595424692019;
 Wed, 22 Jul 2020 06:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <1594683562-68149-1-git-send-email-guoren@kernel.org>
 <1594683562-68149-7-git-send-email-guoren@kernel.org> <20200714203757.512ce7fb5fa61a88b1dbb2f3@kernel.org>
 <CAJF2gTSMUnHfv3GLj_TGT2dJkKq2zbEsnbPKREiq5i6PPjyTBg@mail.gmail.com> <20200721222701.3074315f6a9f6c42c5963f40@kernel.org>
In-Reply-To: <20200721222701.3074315f6a9f6c42c5963f40@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Jul 2020 21:31:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR4319vMy9hStLeR3+42WG4opnsZTaGdN__Bm23VCHjBg@mail.gmail.com>
Message-ID: <CAJF2gTR4319vMy9hStLeR3+42WG4opnsZTaGdN__Bm23VCHjBg@mail.gmail.com>
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

Hi Masami,

Current riscv ftrace_caller utilize fp(s0) - 8 in stack to get ra of
function, eg:
foo:
   2bb0:       7119                    addi    sp,sp,-128
    2bb2:       f8a2                    sd      s0,112(sp)
    2bb4:       fc86                    sd      ra,120(sp)
...
    2bc4:       0100                    addi    s0,sp,128
...
0000000000002bca <.LVL828>:
    2bca:       00000097                auipc   ra,0x0
    2bce:       000080e7                jalr    ra # 2bca <.LVL828> //_mcou=
nt

So just put two nops before prologue of function isn't enough, because
riscv don't like arm64 which could use x9-x18 reserved regs to pass
ra(x30).
    | mov       x9, x30
    | bl        <ftrace-entry>
If the benefit is just making a kprobe on function symbol address to
prevent disassembling, I'll delay this feature.


I also have a look at HAVE_FENTRY & HAVE_NOP_MCOUNT. Seems it just
avoid using scripts/recordmcount.pl script and directly generate nops
for _mcount.
It's different from -fpatchable-function-entry=3D2 which generating nops
before function prologue in arm64, isn't it?

On Tue, Jul 21, 2020 at 9:27 PM Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>
> On Wed, 15 Jul 2020 00:24:54 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > Thx Masami,
> >
> > On Tue, Jul 14, 2020 at 7:38 PM Masami Hiramatsu <mhiramat@kernel.org> =
wrote:
> > >
> > > On Mon, 13 Jul 2020 23:39:21 +0000
> > > guoren@kernel.org wrote:
> > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > This patch adds support for kprobes on ftrace call sites to avoids
> > > > much of the overhead with regular kprobes. Try it with simple
> > > > steps:
> > > >
> > > > 1. Get _do_fork ftrace call site.
> > > > Dump of assembler code for function _do_fork:
> > > >    0xffffffe00020af64 <+0>:     addi    sp,sp,-128
> > > >    0xffffffe00020af66 <+2>:     sd      s0,112(sp)
> > > >    0xffffffe00020af68 <+4>:     sd      ra,120(sp)
> > > >    0xffffffe00020af6a <+6>:     addi    s0,sp,128
> > > >    0xffffffe00020af6c <+8>:     sd      s1,104(sp)
> > > >    0xffffffe00020af6e <+10>:    sd      s2,96(sp)
> > > >    0xffffffe00020af70 <+12>:    sd      s3,88(sp)
> > > >    0xffffffe00020af72 <+14>:    sd      s4,80(sp)
> > > >    0xffffffe00020af74 <+16>:    sd      s5,72(sp)
> > > >    0xffffffe00020af76 <+18>:    sd      s6,64(sp)
> > > >    0xffffffe00020af78 <+20>:    sd      s7,56(sp)
> > > >    0xffffffe00020af7a <+22>:    mv      s4,a0
> > > >    0xffffffe00020af7c <+24>:    mv      a0,ra
> > > >    0xffffffe00020af7e <+26>:    nop   <<<<<<<< here!
> > > >    0xffffffe00020af82 <+30>:    nop
> > > >    0xffffffe00020af86 <+34>:    ld      s3,0(s4)
> > > >
> > > > 2. Set _do_fork+26 as the kprobe.
> > > >   echo 'p:myprobe _do_fork+26 dfd=3D%a0 filename=3D%a1 flags=3D%a2 =
mode=3D+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
> > > >   echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> > > >   cat /sys/kernel/debug/tracing/trace
> > > >   tracer: nop
> > > >
> > > >   entries-in-buffer/entries-written: 3/3   #P:1
> > > >
> > > >                                _-----=3D> irqs-off
> > > >                               / _----=3D> need-resched
> > > >                              | / _---=3D> hardirq/softirq
> > > >                              || / _--=3D> preempt-depth
> > > >                              ||| /     delay
> > > >             TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > > >                | |       |   ||||       |         |
> > > >               sh-87    [000] ....   551.557031: myprobe: (_do_fork+=
0x1a/0x2e6) dfd=3D0xffffffe00020af7e filename=3D0xffffffe00020b34e flags=3D=
0xffffffe00101e7c0 mode=3D0x20af86ffffffe0
> > > >
> > > >   cat /sys/kernel/debug/kprobes/list
> > > > ffffffe00020af7e  k  _do_fork+0x1a    [FTRACE]
> > > >                                        ^^^^^^
> > >
> > > Hmm, this seems fentry is not supported on RISC-V yet. But anyway,
> > > it will be useful for users (if they can find the offset).
> >
> > Seems only x86 & =E2=AC=86=EF=B8=8F90 use fentry=EF=BC=8Ccan you elabor=
ate more about fentry's
> > benefit and how the user could set kprobe on ftrace call site without
> > disassemble?
>
> On x86, the fentry replaces the mcount with just one call instruction, wi=
thout
> saving any arguments. This means all probes which are puts on the address=
 of
> target symbol, are automatically using ftrace. IOW, all probes on _do_for=
k+0
> will use ftrace. We don't need any disassembling.
>
> I think if RISC-V already support "-fpatchable-function-entry=3D2" option=
 on
> GCC, you can easily enable it as same as arm64. See https://lkml.org/lkml=
/2019/6/18/648
>
> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
