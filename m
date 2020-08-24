Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47094C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248C12074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598282670;
	bh=PJNmuOt3cuIJ/fEo9jiSn8Ena+MmvwcHWeips3IOnuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LpoB6Az32OvZ5GODa2XdgvCMZqPxCICABn5RgAbkpMRveL3kUyUir0Dkfuj3ngXtN
	 7bGNv5IsYPUXj1M+fXy+tao0cdHcsmWls0W+WVC2c3GnicQUM5Yeae1nZgL46EmobR
	 AFhjGHX5LaKO6SGPM9rff/EJy6tU8rKk2ZyGW1Qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHXPY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgHXPYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:24:06 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5537B2074D;
        Mon, 24 Aug 2020 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598282645;
        bh=PJNmuOt3cuIJ/fEo9jiSn8Ena+MmvwcHWeips3IOnuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jj7/JB/sl111AqTKYGcLETUt/OPetaI7g//bROBfk7HM7qTFuLYPvwqJLOWoAXGMW
         vZvWK7ssRLGn+1zpEnroZfzilDgglArGkKCeRQWxVfEb0Y4jzNkJnRRZuP7Kc3dof3
         WI2Gq5YZQUYdvAyVAe/iF/s0GU+SJW719wnt4Oms=
Date:   Mon, 24 Aug 2020 17:24:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Message-ID: <20200824152359.GA32398@linux-8ccs>
References: <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net>
 <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs>
 <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck>
 <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck>
 <CAMj1kXHgHo59vuua49rAoLfSt36JKSzFMMH+Z=y+3jNjbFPZsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXHgHo59vuua49rAoLfSt36JKSzFMMH+Z=y+3jNjbFPZsg@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Ard Biesheuvel [22/08/20 15:47 +0200]:
>(+ Masahiro)
>
>On Fri, 21 Aug 2020 at 14:30, Will Deacon <will@kernel.org> wrote:
>>
>> On Fri, Aug 21, 2020 at 02:27:05PM +0200, Ard Biesheuvel wrote:
>> > On Fri, 21 Aug 2020 at 14:20, Will Deacon <will@kernel.org> wrote:
>> > >
>> > > On Thu, Aug 13, 2020 at 03:07:13PM +0200, Ard Biesheuvel wrote:
>> > > > On Thu, 13 Aug 2020 at 15:04, Jessica Yu <jeyu@kernel.org> wrote:
>> > > > >
>> > > > > +++ Ard Biesheuvel [13/08/20 10:36 +0200]:
>> > > > > >On Wed, 12 Aug 2020 at 22:00, Peter Zijlstra <peterz@infradead.org> wrote:
>> > > > > >>
>> > > > > >> On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
>> > > > > >> > I know there is little we can do at this point, apart from ignoring
>> > > > > >> > the permissions - perhaps we should just defer the w^x check until
>> > > > > >> > after calling module_frob_arch_sections()?
>> > > > > >>
>> > > > > >> My earlier suggestion was to ignore it for 0-sized sections.
>> > > > > >
>> > > > > >Only they are 1 byte sections in this case.
>> > > > > >
>> > > > > >We override the sh_type and sh_flags explicitly for these sections at
>> > > > > >module load time, so deferring the check seems like a reasonable
>> > > > > >alternative to me.
>> > > > >
>> > > > > So module_enforce_rwx_sections() is already called after
>> > > > > module_frob_arch_sections() - which really baffled me at first, since
>> > > > > sh_type and sh_flags should have been set already in
>> > > > > module_frob_arch_sections().
>> > > > >
>> > > > > I added some debug prints to see which section the module code was
>> > > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
>> > > > > arm64's module_frob_arch_sections():
>> > > > >
>> > > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
>> > > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
>> > > > >                                  ".text.ftrace_trampoline"))
>> > > > >                         tramp = sechdrs + i;
>> > > > >
>> > > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
>> > > > > is never set here and the if (tramp) check at the end of the function
>> > > > > fails, so its section flags are never set, so they remain WAX and fail
>> > > > > the rwx check.
>> > > >
>> > > > Right. Our module.lds does not go through the preprocessor, so we
>> > > > cannot add the #ifdef check there currently. So we should either drop
>> > > > the IS_ENABLED() check here, or simply rename the section, dropping
>> > > > the .text prefix (which doesn't seem to have any significance outside
>> > > > this context)
>> > > >
>> > > > I'll leave it to Will to make the final call here.
>> > >
>> > > Why don't we just preprocess the linker script, like we do for the main
>> > > kernel?
>> > >
>> >
>> > That should work as well, I just haven't checked how straight-forward
>> > it is to change that.
>>
>> Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
>> altogether.
>>
>
>I played around with this for a while, but failed to get Kbuild to
>instantiate $(objtree)/arch/arm64/kernel/module.lds based on
>$(srctree)/arch/arm64/kernel/module.lds.S and the cpp_lds_S rule.
>Perhaps Masahiro has any suggestions here? Otherwise, let's just drop
>the IS_ENABLED() check for now.

I also tinkered around a bit and was able to generate
$(objtree)/arch/arm64/kernel/module.lds based on
$(srctree)/arch/arm64/kernel/module.lds.S only if I specified the
former as the make target directly. Correct me if I'm wrong, but I
guess this might be because the single build targets would utilize
scripts/Makefile.build (where the cpp_lds_S rule is defined) while the
module-related Makefiles don't seem to support .lds.S -> .lds in
general.. Masahiro, how easy would it be to extend .lds.S -> .lds
support to module linker scripts as well?

Thanks,

Jessica
