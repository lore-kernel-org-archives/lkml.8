Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CCC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D42D207BC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598964766;
	bh=yg/250nrats4qE+SuiX9Do3DhW2WXHg0wipMKKK8bH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hb/+87eGY/RmvFTb89bkXGeljN0GoScAxhfhdYrpJ44vPOu0UhLKqo870LZhgWbLj
	 iI7Bhi+Sb0zT5Ybsf/t9KOXYRjVCdmMVVvrNISyDMBk7xjlX6aYCzEC6rkew6eye5F
	 pc7py1GSmfLBwTrKcU5MyOjv52ABNmiBJl9JkGGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgIAMwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgIAMv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:51:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD45E206CD;
        Tue,  1 Sep 2020 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598964680;
        bh=yg/250nrats4qE+SuiX9Do3DhW2WXHg0wipMKKK8bH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFQyodSg+2l6w6kPeibO0GULGs+Vsdkq6mUZbBbB5HGS0lWEaxH3w8+UWZFU4Hh7N
         08r5Ll27IpCpWu8h/3ol2IhRiKpdeQ4ieDBKZs/W+ZuX+q2UWmD3ZbFZKayubGFjH0
         GPjXzsbINdvnQoMFKAdsfrLGSL5HX6OiTvvCzU/c=
Date:   Tue, 1 Sep 2020 13:51:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200901125114.GA3307@willie-the-truck>
References: <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net>
 <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs>
 <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck>
 <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck>
 <20200831094651.GA16385@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831094651.GA16385@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:46:51AM +0200, Jessica Yu wrote:
> +++ Will Deacon [21/08/20 13:30 +0100]:
> [snipped]
> > > > > > So module_enforce_rwx_sections() is already called after
> > > > > > module_frob_arch_sections() - which really baffled me at first, since
> > > > > > sh_type and sh_flags should have been set already in
> > > > > > module_frob_arch_sections().
> > > > > >
> > > > > > I added some debug prints to see which section the module code was
> > > > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
> > > > > > arm64's module_frob_arch_sections():
> > > > > >
> > > > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> > > > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
> > > > > >                                  ".text.ftrace_trampoline"))
> > > > > >                         tramp = sechdrs + i;
> > > > > >
> > > > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> > > > > > is never set here and the if (tramp) check at the end of the function
> > > > > > fails, so its section flags are never set, so they remain WAX and fail
> > > > > > the rwx check.
> > > > >
> > > > > Right. Our module.lds does not go through the preprocessor, so we
> > > > > cannot add the #ifdef check there currently. So we should either drop
> > > > > the IS_ENABLED() check here, or simply rename the section, dropping
> > > > > the .text prefix (which doesn't seem to have any significance outside
> > > > > this context)
> > > > >
> > > > > I'll leave it to Will to make the final call here.
> > > >
> > > > Why don't we just preprocess the linker script, like we do for the main
> > > > kernel?
> > > >
> > > 
> > > That should work as well, I just haven't checked how straight-forward
> > > it is to change that.
> > 
> > Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
> > altogether.
> 
> Unfortunately I've been getting more reports about this issue, so let's just
> get the aforementioned workaround merged first. Does the following look OK?
> 
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 0ce3a28e3347..2e224435c024 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -305,8 +305,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                        mod->arch.core.plt_shndx = i;
>                else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
>                        mod->arch.init.plt_shndx = i;
> -               else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> -                        !strcmp(secstrings + sechdrs[i].sh_name,
> +               else if (!strcmp(secstrings + sechdrs[i].sh_name,
>                                 ".text.ftrace_trampoline"))
>                        tramp = sechdrs + i;
>                else if (sechdrs[i].sh_type == SHT_SYMTAB)
> 
> If so I'll turn it into a formal patch and we can get that merged in the next -rc.

Acked-by: Will Deacon <will@kernel.org>

Will
