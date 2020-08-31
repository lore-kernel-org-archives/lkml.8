Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FE6C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D078C20782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598880365;
	bh=PKOmHk5fDC3lzYzZxF65l1OctcEHXfTawf5ki1aiohQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PVp+jnK0DQvpq0p7gefKoxzMZlfZ+k9+pzMxMf2uC2wlvfiT1th7zvzE6CYxDGXpk
	 VubUaAIcSfuk0sWYwx6gCMyQTJAe/85uJlllQhOv/nkLfR9Y+t1/+D+BWUaFPY9kKl
	 vXVCjkvJVWZv9g5SYOPEPgvHr3hSu9TlDT2kr+jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgHaN0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgHaNZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:25:54 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8662145D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598880354;
        bh=PKOmHk5fDC3lzYzZxF65l1OctcEHXfTawf5ki1aiohQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ND1aWjbk7tS8kvzgMcVKptOElGjl9Xq2uVFscNvTLU/TiCUrmpo3axXCXPQR5oATe
         lf14bjEQR0JEpiwYWyGDsJm6WpGws3YKuDlUKxt4UnW0rpLN6YFxdhLWqWjcJ4EOqY
         oWtHdwQ24CE95zPKOAYTuV3N+4c5h/FKs8rgTD0w=
Received: by mail-oo1-f45.google.com with SMTP id m4so1447430oos.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:25:54 -0700 (PDT)
X-Gm-Message-State: AOAM533INoW9NLUY6sw5RgfhmExbUDZRdVGM8Culr6wuNYy5mpdURj0Q
        aF3ePKIOpuDIc1IZReIZME56Mk/hqrgeqssWY+s=
X-Google-Smtp-Source: ABdhPJzNhuv89HNAhRu51mH3Ij/58evxHnEddDCvooDMBHMtdnn8Za6Er2nhk5h3OJ+/HOZNf6zME4rCxO09pn0/i+U=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr771180ooq.13.1598880353308;
 Mon, 31 Aug 2020 06:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200812141557.GQ14398@arm.com> <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net> <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs> <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck> <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck> <20200831094651.GA16385@linux-8ccs> <CAK7LNARc1vjAV5ib1D0LaQA+rNGcE7YwGnp-MrshGD34_7V4WQ@mail.gmail.com>
In-Reply-To: <CAK7LNARc1vjAV5ib1D0LaQA+rNGcE7YwGnp-MrshGD34_7V4WQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Aug 2020 16:25:42 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGRtmj_4GKFbcHnugwn6Vpj9Fnzii7My0wrGL_j1Xh8sw@mail.gmail.com>
Message-ID: <CAMj1kXGRtmj_4GKFbcHnugwn6Vpj9Fnzii7My0wrGL_j1Xh8sw@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Masahiro Yamada <masahiroy@kernel.org>
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

On Mon, 31 Aug 2020 at 13:43, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Aug 31, 2020 at 6:47 PM Jessica Yu <jeyu@kernel.org> wrote:
> >
> > +++ Will Deacon [21/08/20 13:30 +0100]:
> > [snipped]
> > >> > > > So module_enforce_rwx_sections() is already called after
> > >> > > > module_frob_arch_sections() - which really baffled me at first, since
> > >> > > > sh_type and sh_flags should have been set already in
> > >> > > > module_frob_arch_sections().
> > >> > > >
> > >> > > > I added some debug prints to see which section the module code was
> > >> > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
> > >> > > > arm64's module_frob_arch_sections():
> > >> > > >
> > >> > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> > >> > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
> > >> > > >                                  ".text.ftrace_trampoline"))
> > >> > > >                         tramp = sechdrs + i;
> > >> > > >
> > >> > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> > >> > > > is never set here and the if (tramp) check at the end of the function
> > >> > > > fails, so its section flags are never set, so they remain WAX and fail
> > >> > > > the rwx check.
> > >> > >
> > >> > > Right. Our module.lds does not go through the preprocessor, so we
> > >> > > cannot add the #ifdef check there currently. So we should either drop
> > >> > > the IS_ENABLED() check here, or simply rename the section, dropping
> > >> > > the .text prefix (which doesn't seem to have any significance outside
> > >> > > this context)
> > >> > >
> > >> > > I'll leave it to Will to make the final call here.
> > >> >
> > >> > Why don't we just preprocess the linker script, like we do for the main
> > >> > kernel?
> > >> >
> > >>
> > >> That should work as well, I just haven't checked how straight-forward
> > >> it is to change that.
> > >
> > >Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
> > >altogether.
> >
> > Unfortunately I've been getting more reports about this issue, so let's just
> > get the aforementioned workaround merged first. Does the following look OK?
> >
> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > index 0ce3a28e3347..2e224435c024 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -305,8 +305,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >                         mod->arch.core.plt_shndx = i;
> >                 else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
> >                         mod->arch.init.plt_shndx = i;
> > -               else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> > -                        !strcmp(secstrings + sechdrs[i].sh_name,
> > +               else if (!strcmp(secstrings + sechdrs[i].sh_name,
> >                                  ".text.ftrace_trampoline"))
> >                         tramp = sechdrs + i;
> >                 else if (sechdrs[i].sh_type == SHT_SYMTAB)
> >
> > If so I'll turn it into a formal patch and we can get that merged in the next -rc.
> >
> > Thanks,
> >
> > Jessica
>
>
>
> Sorry for the delay.
>
> Please try the attached patch.
>

Thanks Masahiro,

I'll leave it to the maintainers to make the final call, but this does
look rather intrusive to me, especially for an -rc. Renaming
scripts/module-common.lds to scripts/module.lds means that the distros
may have to update their scripts to generate the linux-headers
packages etc, so if we do this at all, we'd better do it between
releases.
