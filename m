Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A41BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6222D20866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888877;
	bh=w+EDbiFp13r6lJ/kAKwfMHFMAHeI7XPaWxPo4Tl6/VU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cay5GTaBNfZMNpmaI9un76v53L2Re2HnK8KCLb325mOzq0T6ptvUSZFK0bzATfKYM
	 7fPVfY4niLmr6Rov6+RJelou27lRSRjrvthxy+bJNMyJ3gPq25TlAjSe9mdGkftg6U
	 AUJd68rCSRXFEcDGoyq/CeFge1hjXdsF8oBUqDA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHaPry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:47:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35217 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgHaPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:47:51 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 07VFlWbq029725
        for <linux-kernel@vger.kernel.org>; Tue, 1 Sep 2020 00:47:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 07VFlWbq029725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598888852;
        bh=qK1w4CnK9sHGz8/7DuIpsP5Iyn6Md+3zNA/CADDAXvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d06z/3rZW2Ua2pUo09MEy489xf0lBEZA7hrVIsCT8xsG1C3LMe3AisDvFSbeh/J2e
         ou6N4KGv/2PKVTwNeB3pVQYMSziar+HkmzRQoXpvvtuvwfRNyhZ30ibQPj9SMFtQ6h
         JFtlWjddLgt4JXO2HPZGsfvy8gufzzhsXDN2E9NuN5xXfBYm7YaJiswlXlB9HtgHxP
         BdK4pajjQXYpB5a5W3ceGFOm0gVcv4+oJSfeNkthhgzc1myZiuJO2YwX9kLnZ3+aSu
         qtSdA47iLlfaMmSvjQxRHjr0FArQUTrom+QNdhODrph0Gj+4ftaaJwUE0wBm9LCjrf
         NePXEIhsDJDMw==
X-Nifty-SrcIP: [209.85.210.169]
Received: by mail-pf1-f169.google.com with SMTP id u20so785592pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:47:32 -0700 (PDT)
X-Gm-Message-State: AOAM533k3xKtUPpb+o+edmjNpB4IlS1rOuKzq8ZBa0fmOcHan0ZKXR04
        MbsgAwhf1dmomTceHIXcSpl3gQskEdE1ODP6ygI=
X-Google-Smtp-Source: ABdhPJyMoijaMVlEQC1xv4vvRgFTmFuiREs1AN3GxjFDeO41/V1w4uJ3xn30Ij9YQcGqs8AgBT5T3C0N19Tp305Xdt0=
X-Received: by 2002:aa7:92c7:: with SMTP id k7mr1640206pfa.239.1598888851666;
 Mon, 31 Aug 2020 08:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200812141557.GQ14398@arm.com> <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net> <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs> <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck> <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck> <20200831094651.GA16385@linux-8ccs>
 <CAK7LNARc1vjAV5ib1D0LaQA+rNGcE7YwGnp-MrshGD34_7V4WQ@mail.gmail.com> <CAMj1kXGRtmj_4GKFbcHnugwn6Vpj9Fnzii7My0wrGL_j1Xh8sw@mail.gmail.com>
In-Reply-To: <CAMj1kXGRtmj_4GKFbcHnugwn6Vpj9Fnzii7My0wrGL_j1Xh8sw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 1 Sep 2020 00:46:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvQiExx5YkMqJvUyJJ96mST8jhvo2LF_iQVEjU2DLgng@mail.gmail.com>
Message-ID: <CAK7LNAQvQiExx5YkMqJvUyJJ96mST8jhvo2LF_iQVEjU2DLgng@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:25 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 31 Aug 2020 at 13:43, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Mon, Aug 31, 2020 at 6:47 PM Jessica Yu <jeyu@kernel.org> wrote:
> > >
> > > +++ Will Deacon [21/08/20 13:30 +0100]:
> > > [snipped]
> > > >> > > > So module_enforce_rwx_sections() is already called after
> > > >> > > > module_frob_arch_sections() - which really baffled me at first, since
> > > >> > > > sh_type and sh_flags should have been set already in
> > > >> > > > module_frob_arch_sections().
> > > >> > > >
> > > >> > > > I added some debug prints to see which section the module code was
> > > >> > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
> > > >> > > > arm64's module_frob_arch_sections():
> > > >> > > >
> > > >> > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> > > >> > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
> > > >> > > >                                  ".text.ftrace_trampoline"))
> > > >> > > >                         tramp = sechdrs + i;
> > > >> > > >
> > > >> > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> > > >> > > > is never set here and the if (tramp) check at the end of the function
> > > >> > > > fails, so its section flags are never set, so they remain WAX and fail
> > > >> > > > the rwx check.
> > > >> > >
> > > >> > > Right. Our module.lds does not go through the preprocessor, so we
> > > >> > > cannot add the #ifdef check there currently. So we should either drop
> > > >> > > the IS_ENABLED() check here, or simply rename the section, dropping
> > > >> > > the .text prefix (which doesn't seem to have any significance outside
> > > >> > > this context)
> > > >> > >
> > > >> > > I'll leave it to Will to make the final call here.
> > > >> >
> > > >> > Why don't we just preprocess the linker script, like we do for the main
> > > >> > kernel?
> > > >> >
> > > >>
> > > >> That should work as well, I just haven't checked how straight-forward
> > > >> it is to change that.
> > > >
> > > >Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
> > > >altogether.
> > >
> > > Unfortunately I've been getting more reports about this issue, so let's just
> > > get the aforementioned workaround merged first. Does the following look OK?
> > >
> > > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > > index 0ce3a28e3347..2e224435c024 100644
> > > --- a/arch/arm64/kernel/module-plts.c
> > > +++ b/arch/arm64/kernel/module-plts.c
> > > @@ -305,8 +305,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> > >                         mod->arch.core.plt_shndx = i;
> > >                 else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
> > >                         mod->arch.init.plt_shndx = i;
> > > -               else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> > > -                        !strcmp(secstrings + sechdrs[i].sh_name,
> > > +               else if (!strcmp(secstrings + sechdrs[i].sh_name,
> > >                                  ".text.ftrace_trampoline"))
> > >                         tramp = sechdrs + i;
> > >                 else if (sechdrs[i].sh_type == SHT_SYMTAB)
> > >
> > > If so I'll turn it into a formal patch and we can get that merged in the next -rc.
> > >
> > > Thanks,
> > >
> > > Jessica
> >
> >
> >
> > Sorry for the delay.
> >
> > Please try the attached patch.
> >
>
> Thanks Masahiro,
>
> I'll leave it to the maintainers to make the final call, but this does
> look rather intrusive to me, especially for an -rc.

Sure, I am OK with putting this off.


> Renaming
> scripts/module-common.lds to scripts/module.lds means that the distros
> may have to update their scripts to generate the linux-headers
> packages etc,


It depends on how distributions
implement scripts in their packages.

It would be annoying if the packages were broken
every time a new script is added.


So, I expect the whole of scripts/
is copied to the module development package.


The in-kernel deb package is OK
because files under scripts/ are collected
by the 'find' command.


scripts/package/builddeb:59:
      find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f

scripts/package/builddeb:67:
      find arch/$SRCARCH/include Module.symvers include scripts -type f


The rpm packages are also OK.



But, downstream packages should be updated
if scripts/module-common.lds is hard-coded.



> so if we do this at all, we'd better do it between
> releases.

Sure.
We can go with Jessica's one-liner fix.

I will post mine as a separate patch
with linux-arch ML CCed to get more
attention.


-- 
Best Regards
Masahiro Yamada
