Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EBBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80461207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596071349;
	bh=TswWeoP8M0WaG5VC/mGNEtkfyyPr2p2vDX8T2CicOqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cYcbXrxya1FqxcISelRCf7Z6WjyzfIllloU8+MOzecvVQTShGLqDkm2m/Em9447Dh
	 lqDhF6VxbXFtE+Qs0QhlTf3iVssdaMMul+yoPDAt66M3oyWSr6J34DjhBLPPLqDtfy
	 ost6edKK3+zOMx1LNg+wYa41jDX4kmd1xsYbqZps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG3BJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 21:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3BJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:09:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457902074B;
        Thu, 30 Jul 2020 01:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596071347;
        bh=TswWeoP8M0WaG5VC/mGNEtkfyyPr2p2vDX8T2CicOqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jL5PSsBgnU5manfhdob8yg1u89clnWVnjQeRzlXIsBviSsEmu+iLFWqHgnrgtv9aM
         EWOZOBHXdYGVmE8LS2z4x4VMtPrpzvrAU9/qjWWbJ8sAzn6UG+6oydkw73PeXWhzjQ
         baxcMDjGDRrzc4e9/x2jIHHqzoRXforSoasIEIQA=
Date:   Thu, 30 Jul 2020 10:09:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-Id: <20200730100902.c5fa86a87a72ced0bce3dcf4@kernel.org>
In-Reply-To: <CAMj1kXFdzXFH8b8fu1oKNLk-khBzWVqnBuiu1GEnWSV13jcAHQ@mail.gmail.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
        <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
        <20200724092746.GD517988@gmail.com>
        <20200725031648.GG17052@linux.intel.com>
        <20200726081408.GB2927915@kernel.org>
        <CAMj1kXHDK5RSbTu3SG1AzbLRJD_FsdAmCnjmf31P=Db6J0ktww@mail.gmail.com>
        <20200728171715.0800093e2226e3d72b04a3ae@kernel.org>
        <CAMj1kXGJ_7mUtFHWsLaBj-MSK_VxpBet=wi1Z7frkKRVEgozpQ@mail.gmail.com>
        <20200728223545.ce4ff78cac73b571a27bb357@kernel.org>
        <CAMj1kXG9Fr6ym43JN9FLnzk9vdANPFe95LPKaLK6KF8BiRK0NQ@mail.gmail.com>
        <20200729105054.06f74749eb933c08342e6dd6@kernel.org>
        <CAMj1kXFdzXFH8b8fu1oKNLk-khBzWVqnBuiu1GEnWSV13jcAHQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 09:13:21 +0300
Ard Biesheuvel <ardb@kernel.org> wrote:

> On Wed, 29 Jul 2020 at 04:51, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 28 Jul 2020 20:51:08 +0300
> > Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > On Tue, 28 Jul 2020 at 16:35, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Tue, 28 Jul 2020 13:56:43 +0300
> > > > Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > > On Tue, 28 Jul 2020 at 11:17, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > > > Masami or Peter should correct me if I am wrong, but it seems to me
> > > > > > > that the way kprobes uses these pages does not require them to be in
> > > > > > > relative branching range of the core kernel on any architecture, given
> > > > > > > that they are populated with individual instruction opcodes that are
> > > > > > > executed in single step mode, and relative branches are emulated (when
> > > > > > > needed)
> > > > > >
> > > > > > Actually, x86 and arm has the "relative branching range" requirements
> > > > > > for the jump optimized kprobes. For the other architectures, I think
> > > > > > we don't need it. Only executable text buffer is needed.
> > > > > >
> > > > >
> > > > > Thanks for the explanation. Today, arm64 uses the definition below.
> > > > >
> > > > > void *alloc_insn_page(void)
> > > > > {
> > > > >   return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > > > >     GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > > > >     NUMA_NO_NODE, __builtin_return_address(0));
> > > > > }
> > > > >
> > > > > Do you think we could use that as the generic implementation if we use
> > > > > MODULES_START/_END as the allocation window?
> > > >
> > > > Yes, but for the generic implementation, we don't need to consider the
> > > > relative branching range since we can override it for x86 and arm.
> > > > (and that will be almost same as module_alloc() default code)
> > >
> > > Indeed. So having kprobes specific macros that default to
> > > VMALLOC_START/END but can be overridden would be sufficient.
> > >
> > > > BTW, is PAGE_KERNEL_ROX flag available generically?
> > > >
> > >
> > > Turns out that it is not :-(
> >
> > Hmm, in that case, we need to use PAGE_KERNEL_EXEC.
> >
> > In the result, may it be similar to this? :)
> >
> > void * __weak module_alloc(unsigned long size)
> > {
> >         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> >                         GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> >                         NUMA_NO_NODE, __builtin_return_address(0));
> > }
> >
> > The major difference between module_alloc() and kprobe's alloc_page_insn()
> > is the alloc_page_insn() makes the page ROX after allocating the pages *ONLY*
> > on x86 and arm64.
> >
> 
> Right.
> 
> > $ git grep -w alloc_insn_page -- arch
> > arch/arm64/kernel/probes/kprobes.c:void *alloc_insn_page(void)
> > arch/x86/kernel/kprobes/core.c:void *alloc_insn_page(void)
> >
> > However since the module_alloc() owns its arch-dependent implementations
> > most of major architectures, if we implement independent text_alloc_kprobe(),
> > we need to make deadcopies of module_alloc() for each architecture.
> >
> 
> No, that is what we are trying to avoid.
> 
> > $ git grep 'module_alloc(unsigned' arch/
> > arch/arm/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/arm64/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/mips/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/nds32/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/nios2/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/parisc/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/riscv/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/s390/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/sparc/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/unicore32/kernel/module.c:void *module_alloc(unsigned long size)
> > arch/x86/kernel/module.c:void *module_alloc(unsigned long size)
> >
> > It seems that some constrains for module_alloc() exists for above
> > architectures.
> >
> > Anyway, for kprobe's text_alloc() requirements are
> > - It must be executable for the arch which uses a single-step out-of-line.
> >   (and need to be registered to KASAN?)
> 
> No, kasan shadow is not needed here.

OK, I just saw the KASAN shadow was generated (kasan_module_alloc was
called) in module_alloc() on x86.
So current x86 alloc_insn_page() has it.

> > - It must be ROX if implemented (currently only for x86 and arm64)
> 
> x86 does not actually define thr macro, but the result is the same.

Yes, alloc_insn_page() for x86 is adding the RO and X flag on the page.

> > - It must be in the range of relative branching only for x86 and arm.
> >
> 
> So in summary, the generic module_alloc() above can be reused for
> kprobes on all arches except x86 and arm64, right? Then we can remove
> the call to it, and drop the modules dependency.

Yes, that's correct. If there is a generic module_alloc(), kprobes is
happy to use it :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
