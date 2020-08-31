Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91AEC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC6721531
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888070;
	bh=L7IW7ujgPe/NUb877LRT3j02HjrlovIN6ZMqanOiIfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YvNO8OSFnHNUkDdblaAU7CCFHu6u3yU5DelkKEOeMkBllTYh1sL2DV2gOOBUmyNDg
	 CfvHZZQIDARYoNaVkgDuqk3dAzXIpEBnbdeAct+u3YT9FjeKzhWPEIPuHb1gFgfvfE
	 1y7vBFr8nVfJRv3qoF9FBfXEmb2g4bOH7vu48U0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgHaPe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgHaPb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:31:26 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D479A2158C;
        Mon, 31 Aug 2020 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887886;
        bh=L7IW7ujgPe/NUb877LRT3j02HjrlovIN6ZMqanOiIfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3gN6cc/tbYU5Sv8RBKMA32UeL3YR+4f8dU7YmD/DM4y0OZoYCA95B/NC9UC/RaXx
         ot6xLz/q991B691peVydF/euvYtHOZU7QEH4aYCVx9Tx9y6rH0bYUVxZxmrzoBx61Z
         MVUzdx71By/248bwjhlrPwzdUCYxjNby0CEukS1Y=
Date:   Mon, 31 Aug 2020 17:31:19 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20200831153119.GA5731@linux-8ccs>
References: <20200812200019.GY3982@worktop.programming.kicks-ass.net>
 <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs>
 <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck>
 <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck>
 <20200831094651.GA16385@linux-8ccs>
 <CAK7LNARc1vjAV5ib1D0LaQA+rNGcE7YwGnp-MrshGD34_7V4WQ@mail.gmail.com>
 <CAMj1kXGRtmj_4GKFbcHnugwn6Vpj9Fnzii7My0wrGL_j1Xh8sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXGRtmj_4GKFbcHnugwn6Vpj9Fnzii7My0wrGL_j1Xh8sw@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Ard Biesheuvel [31/08/20 16:25 +0300]:
>On Mon, 31 Aug 2020 at 13:43, Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> On Mon, Aug 31, 2020 at 6:47 PM Jessica Yu <jeyu@kernel.org> wrote:
>> >
>> > +++ Will Deacon [21/08/20 13:30 +0100]:
>> > [snipped]
>> > >> > > > So module_enforce_rwx_sections() is already called after
>> > >> > > > module_frob_arch_sections() - which really baffled me at first, since
>> > >> > > > sh_type and sh_flags should have been set already in
>> > >> > > > module_frob_arch_sections().
>> > >> > > >
>> > >> > > > I added some debug prints to see which section the module code was
>> > >> > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
>> > >> > > > arm64's module_frob_arch_sections():
>> > >> > > >
>> > >> > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
>> > >> > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
>> > >> > > >                                  ".text.ftrace_trampoline"))
>> > >> > > >                         tramp = sechdrs + i;
>> > >> > > >
>> > >> > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
>> > >> > > > is never set here and the if (tramp) check at the end of the function
>> > >> > > > fails, so its section flags are never set, so they remain WAX and fail
>> > >> > > > the rwx check.
>> > >> > >
>> > >> > > Right. Our module.lds does not go through the preprocessor, so we
>> > >> > > cannot add the #ifdef check there currently. So we should either drop
>> > >> > > the IS_ENABLED() check here, or simply rename the section, dropping
>> > >> > > the .text prefix (which doesn't seem to have any significance outside
>> > >> > > this context)
>> > >> > >
>> > >> > > I'll leave it to Will to make the final call here.
>> > >> >
>> > >> > Why don't we just preprocess the linker script, like we do for the main
>> > >> > kernel?
>> > >> >
>> > >>
>> > >> That should work as well, I just haven't checked how straight-forward
>> > >> it is to change that.
>> > >
>> > >Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
>> > >altogether.
>> >
>> > Unfortunately I've been getting more reports about this issue, so let's just
>> > get the aforementioned workaround merged first. Does the following look OK?
>> >
>> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
>> > index 0ce3a28e3347..2e224435c024 100644
>> > --- a/arch/arm64/kernel/module-plts.c
>> > +++ b/arch/arm64/kernel/module-plts.c
>> > @@ -305,8 +305,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>> >                         mod->arch.core.plt_shndx = i;
>> >                 else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
>> >                         mod->arch.init.plt_shndx = i;
>> > -               else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
>> > -                        !strcmp(secstrings + sechdrs[i].sh_name,
>> > +               else if (!strcmp(secstrings + sechdrs[i].sh_name,
>> >                                  ".text.ftrace_trampoline"))
>> >                         tramp = sechdrs + i;
>> >                 else if (sechdrs[i].sh_type == SHT_SYMTAB)
>> >
>> > If so I'll turn it into a formal patch and we can get that merged in the next -rc.
>> >
>> > Thanks,
>> >
>> > Jessica
>>
>>
>>
>> Sorry for the delay.
>>
>> Please try the attached patch.
>>
>
>Thanks Masahiro,

Yes, thanks Masahiro for looking into this! And no worries about
the delay. I will be able to test the patch tomorrow.

>I'll leave it to the maintainers to make the final call, but this does
>look rather intrusive to me, especially for an -rc. Renaming
>scripts/module-common.lds to scripts/module.lds means that the distros
>may have to update their scripts to generate the linux-headers
>packages etc, so if we do this at all, we'd better do it between
>releases.

Yes, agreed - I was suggesting dropping the IS_ENABLED() check for
the next -rc so that the bug reports about this module loading issue
stop cropping up, and the "proper" fix of supporting module.lds.S ->
.lds would be suitable for the next release instead.

Jessica
