Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926C1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F7C206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596003216;
	bh=u7d5xK7YvZOBGWh1UlpubqMP0fRaHhDT8+EFryfPydc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=djy6tLd1PrjxTzmBz+II83QZJqdhBCE7ut1TTO1KFkYwRYbXW5iXgfdLeNuMbtWxc
	 teDy65tAyvp8vPZDeWfizHAadbVHjfgXKAjzRMXGuQ2K/MUIxM8e+bL5zOcVOO9Zan
	 Sj7N7JU/5P5bFfoAwrVh8O+cRLPd7IR4exiXPtTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgG2GNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgG2GNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:13:34 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC2C2070B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 06:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596003213;
        bh=u7d5xK7YvZOBGWh1UlpubqMP0fRaHhDT8+EFryfPydc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V5ZJBNCgjljMU5XeW52AONwfUK28LmE1GLwePhYZwRh/TV4yB7tKR5/xOnSIW36Qk
         7gksdnHlZwrQXWefT4b3DZBQFa6BVKeatDFVcQBXPpMdLYvumyucwXpJVNyRZ6raDR
         o4qdUAY/cSOrN18Y/Z1uYFHF/Z2Uxp0HMJyE5KSQ=
Received: by mail-ot1-f49.google.com with SMTP id o72so11134804ota.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:13:33 -0700 (PDT)
X-Gm-Message-State: AOAM531ekFTLRfE04euQnB/I9azUBIa7ltmTRcP0QOH1Coc5o18ica2g
        wr6xxn5FdIXethmR4GdqWt91wZyBcgPQSI/0amQ=
X-Google-Smtp-Source: ABdhPJzisB9A1LhQj4M7/NTAkUb9eJtp9/Ra3dmt8xSVIi2/rJEIGK31x1dU71fnIQt9LT+836SKAM4L/8rZIFEx0gk=
X-Received: by 2002:a9d:3b23:: with SMTP id z32mr9899829otb.77.1596003212957;
 Tue, 28 Jul 2020 23:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com> <20200725031648.GG17052@linux.intel.com>
 <20200726081408.GB2927915@kernel.org> <CAMj1kXHDK5RSbTu3SG1AzbLRJD_FsdAmCnjmf31P=Db6J0ktww@mail.gmail.com>
 <20200728171715.0800093e2226e3d72b04a3ae@kernel.org> <CAMj1kXGJ_7mUtFHWsLaBj-MSK_VxpBet=wi1Z7frkKRVEgozpQ@mail.gmail.com>
 <20200728223545.ce4ff78cac73b571a27bb357@kernel.org> <CAMj1kXG9Fr6ym43JN9FLnzk9vdANPFe95LPKaLK6KF8BiRK0NQ@mail.gmail.com>
 <20200729105054.06f74749eb933c08342e6dd6@kernel.org>
In-Reply-To: <20200729105054.06f74749eb933c08342e6dd6@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Jul 2020 09:13:21 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFdzXFH8b8fu1oKNLk-khBzWVqnBuiu1GEnWSV13jcAHQ@mail.gmail.com>
Message-ID: <CAMj1kXFdzXFH8b8fu1oKNLk-khBzWVqnBuiu1GEnWSV13jcAHQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 at 04:51, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 28 Jul 2020 20:51:08 +0300
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Tue, 28 Jul 2020 at 16:35, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Tue, 28 Jul 2020 13:56:43 +0300
> > > Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > > On Tue, 28 Jul 2020 at 11:17, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > > Masami or Peter should correct me if I am wrong, but it seems to me
> > > > > > that the way kprobes uses these pages does not require them to be in
> > > > > > relative branching range of the core kernel on any architecture, given
> > > > > > that they are populated with individual instruction opcodes that are
> > > > > > executed in single step mode, and relative branches are emulated (when
> > > > > > needed)
> > > > >
> > > > > Actually, x86 and arm has the "relative branching range" requirements
> > > > > for the jump optimized kprobes. For the other architectures, I think
> > > > > we don't need it. Only executable text buffer is needed.
> > > > >
> > > >
> > > > Thanks for the explanation. Today, arm64 uses the definition below.
> > > >
> > > > void *alloc_insn_page(void)
> > > > {
> > > >   return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > > >     GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > > >     NUMA_NO_NODE, __builtin_return_address(0));
> > > > }
> > > >
> > > > Do you think we could use that as the generic implementation if we use
> > > > MODULES_START/_END as the allocation window?
> > >
> > > Yes, but for the generic implementation, we don't need to consider the
> > > relative branching range since we can override it for x86 and arm.
> > > (and that will be almost same as module_alloc() default code)
> >
> > Indeed. So having kprobes specific macros that default to
> > VMALLOC_START/END but can be overridden would be sufficient.
> >
> > > BTW, is PAGE_KERNEL_ROX flag available generically?
> > >
> >
> > Turns out that it is not :-(
>
> Hmm, in that case, we need to use PAGE_KERNEL_EXEC.
>
> In the result, may it be similar to this? :)
>
> void * __weak module_alloc(unsigned long size)
> {
>         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
>                         GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
>                         NUMA_NO_NODE, __builtin_return_address(0));
> }
>
> The major difference between module_alloc() and kprobe's alloc_page_insn()
> is the alloc_page_insn() makes the page ROX after allocating the pages *ONLY*
> on x86 and arm64.
>

Right.

> $ git grep -w alloc_insn_page -- arch
> arch/arm64/kernel/probes/kprobes.c:void *alloc_insn_page(void)
> arch/x86/kernel/kprobes/core.c:void *alloc_insn_page(void)
>
> However since the module_alloc() owns its arch-dependent implementations
> most of major architectures, if we implement independent text_alloc_kprobe(),
> we need to make deadcopies of module_alloc() for each architecture.
>

No, that is what we are trying to avoid.

> $ git grep 'module_alloc(unsigned' arch/
> arch/arm/kernel/module.c:void *module_alloc(unsigned long size)
> arch/arm64/kernel/module.c:void *module_alloc(unsigned long size)
> arch/mips/kernel/module.c:void *module_alloc(unsigned long size)
> arch/nds32/kernel/module.c:void *module_alloc(unsigned long size)
> arch/nios2/kernel/module.c:void *module_alloc(unsigned long size)
> arch/parisc/kernel/module.c:void *module_alloc(unsigned long size)
> arch/riscv/kernel/module.c:void *module_alloc(unsigned long size)
> arch/s390/kernel/module.c:void *module_alloc(unsigned long size)
> arch/sparc/kernel/module.c:void *module_alloc(unsigned long size)
> arch/unicore32/kernel/module.c:void *module_alloc(unsigned long size)
> arch/x86/kernel/module.c:void *module_alloc(unsigned long size)
>
> It seems that some constrains for module_alloc() exists for above
> architectures.
>
> Anyway, for kprobe's text_alloc() requirements are
> - It must be executable for the arch which uses a single-step out-of-line.
>   (and need to be registered to KASAN?)

No, kasan shadow is not needed here.

> - It must be ROX if implemented (currently only for x86 and arm64)

x86 does not actually define thr macro, but the result is the same.

> - It must be in the range of relative branching only for x86 and arm.
>

So in summary, the generic module_alloc() above can be reused for
kprobes on all arches except x86 and arm64, right? Then we can remove
the call to it, and drop the modules dependency.
