Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E2F20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595520711;
	bh=UwNbjNnkRhPtN3M1FcHhf18EPEdkbGS8hia36IkGCMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WlVpRijmFULtirhnDCt86o6M3yjG1PKMtK0xdVKYdoLbmiuxNB5+r+G1Nii/j2VZj
	 GktNtqVSAnHZkVjR5gCbwaJoCbyuo7T4ELerFyIiFLungeU40CfAdlcsz0IiErRWT6
	 6nffXGfE52x6jeyciZE35U4OPu2QqYENowyY35ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgGWQLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:11:49 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E0EC20714;
        Thu, 23 Jul 2020 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595520708;
        bh=UwNbjNnkRhPtN3M1FcHhf18EPEdkbGS8hia36IkGCMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KTAu2n/tep3Ope7nKjpIkD+hDh2cBrQhD+vCOEIs3a+CvHULRCInnNBPVRtiJjVFz
         y2b0cdYj8JDxlEzZaYRf3gdCEFZ2VHlj9ynUF6u0mFAZJRGgFPQzDsuL1mPD6bhOB6
         bQrPjm1rSyM1gVdo1QEcqD83BrODAPLuHymSTkTU=
Date:   Fri, 24 Jul 2020 01:11:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>, linux-csky@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Patrick =?UTF-8?B?U3TDpGhsaW4=?= <me@packi.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH v3 6/7] riscv: Add KPROBES_ON_FTRACE supported
Message-Id: <20200724011143.a2dd2e231411e46edde2e8c4@kernel.org>
In-Reply-To: <CAJF2gTR4319vMy9hStLeR3+42WG4opnsZTaGdN__Bm23VCHjBg@mail.gmail.com>
References: <1594683562-68149-1-git-send-email-guoren@kernel.org>
        <1594683562-68149-7-git-send-email-guoren@kernel.org>
        <20200714203757.512ce7fb5fa61a88b1dbb2f3@kernel.org>
        <CAJF2gTSMUnHfv3GLj_TGT2dJkKq2zbEsnbPKREiq5i6PPjyTBg@mail.gmail.com>
        <20200721222701.3074315f6a9f6c42c5963f40@kernel.org>
        <CAJF2gTR4319vMy9hStLeR3+42WG4opnsZTaGdN__Bm23VCHjBg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 21:31:20 +0800
Guo Ren <guoren@kernel.org> wrote:

> Hi Masami,
> 
> Current riscv ftrace_caller utilize fp(s0) - 8 in stack to get ra of
> function, eg:
> foo:
>    2bb0:       7119                    addi    sp,sp,-128
>     2bb2:       f8a2                    sd      s0,112(sp)
>     2bb4:       fc86                    sd      ra,120(sp)
> ...
>     2bc4:       0100                    addi    s0,sp,128
> ...
> 0000000000002bca <.LVL828>:
>     2bca:       00000097                auipc   ra,0x0
>     2bce:       000080e7                jalr    ra # 2bca <.LVL828> //_mcount
> 
> So just put two nops before prologue of function isn't enough, because
> riscv don't like arm64 which could use x9-x18 reserved regs to pass
> ra(x30).
>     | mov       x9, x30
>     | bl        <ftrace-entry>
> If the benefit is just making a kprobe on function symbol address to
> prevent disassembling, I'll delay this feature.

I recommend that. This feature has to involve ftrace and gcc, so
it is better to split it from this series.

> 
> 
> I also have a look at HAVE_FENTRY & HAVE_NOP_MCOUNT. Seems it just
> avoid using scripts/recordmcount.pl script and directly generate nops
> for _mcount.

Right.

> It's different from -fpatchable-function-entry=2 which generating nops
> before function prologue in arm64, isn't it?

Yes, fentry is for x86, but -fpatchable-function-entry=2 is making a
placeholder with nop at the entry of the functions for direct patching.

Thank you,

> 
> On Tue, Jul 21, 2020 at 9:27 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 15 Jul 2020 00:24:54 +0800
> > Guo Ren <guoren@kernel.org> wrote:
> >
> > > Thx Masami,
> > >
> > > On Tue, Jul 14, 2020 at 7:38 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Mon, 13 Jul 2020 23:39:21 +0000
> > > > guoren@kernel.org wrote:
> > > >
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > This patch adds support for kprobes on ftrace call sites to avoids
> > > > > much of the overhead with regular kprobes. Try it with simple
> > > > > steps:
> > > > >
> > > > > 1. Get _do_fork ftrace call site.
> > > > > Dump of assembler code for function _do_fork:
> > > > >    0xffffffe00020af64 <+0>:     addi    sp,sp,-128
> > > > >    0xffffffe00020af66 <+2>:     sd      s0,112(sp)
> > > > >    0xffffffe00020af68 <+4>:     sd      ra,120(sp)
> > > > >    0xffffffe00020af6a <+6>:     addi    s0,sp,128
> > > > >    0xffffffe00020af6c <+8>:     sd      s1,104(sp)
> > > > >    0xffffffe00020af6e <+10>:    sd      s2,96(sp)
> > > > >    0xffffffe00020af70 <+12>:    sd      s3,88(sp)
> > > > >    0xffffffe00020af72 <+14>:    sd      s4,80(sp)
> > > > >    0xffffffe00020af74 <+16>:    sd      s5,72(sp)
> > > > >    0xffffffe00020af76 <+18>:    sd      s6,64(sp)
> > > > >    0xffffffe00020af78 <+20>:    sd      s7,56(sp)
> > > > >    0xffffffe00020af7a <+22>:    mv      s4,a0
> > > > >    0xffffffe00020af7c <+24>:    mv      a0,ra
> > > > >    0xffffffe00020af7e <+26>:    nop   <<<<<<<< here!
> > > > >    0xffffffe00020af82 <+30>:    nop
> > > > >    0xffffffe00020af86 <+34>:    ld      s3,0(s4)
> > > > >
> > > > > 2. Set _do_fork+26 as the kprobe.
> > > > >   echo 'p:myprobe _do_fork+26 dfd=%a0 filename=%a1 flags=%a2 mode=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
> > > > >   echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> > > > >   cat /sys/kernel/debug/tracing/trace
> > > > >   tracer: nop
> > > > >
> > > > >   entries-in-buffer/entries-written: 3/3   #P:1
> > > > >
> > > > >                                _-----=> irqs-off
> > > > >                               / _----=> need-resched
> > > > >                              | / _---=> hardirq/softirq
> > > > >                              || / _--=> preempt-depth
> > > > >                              ||| /     delay
> > > > >             TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > > > >                | |       |   ||||       |         |
> > > > >               sh-87    [000] ....   551.557031: myprobe: (_do_fork+0x1a/0x2e6) dfd=0xffffffe00020af7e filename=0xffffffe00020b34e flags=0xffffffe00101e7c0 mode=0x20af86ffffffe0
> > > > >
> > > > >   cat /sys/kernel/debug/kprobes/list
> > > > > ffffffe00020af7e  k  _do_fork+0x1a    [FTRACE]
> > > > >                                        ^^^^^^
> > > >
> > > > Hmm, this seems fentry is not supported on RISC-V yet. But anyway,
> > > > it will be useful for users (if they can find the offset).
> > >
> > > Seems only x86 & ⬆️90 use fentry，can you elaborate more about fentry's
> > > benefit and how the user could set kprobe on ftrace call site without
> > > disassemble?
> >
> > On x86, the fentry replaces the mcount with just one call instruction, without
> > saving any arguments. This means all probes which are puts on the address of
> > target symbol, are automatically using ftrace. IOW, all probes on _do_fork+0
> > will use ftrace. We don't need any disassembling.
> >
> > I think if RISC-V already support "-fpatchable-function-entry=2" option on
> > GCC, you can easily enable it as same as arm64. See https://lkml.org/lkml/2019/6/18/648
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/


-- 
Masami Hiramatsu <mhiramat@kernel.org>
