Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C3DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7642320724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598013054;
	bh=EYzeQyKbsyoYnxtSyFAJUuKt7H7T5SLVEFASRIYw5eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kwr/gKPRHkRwd2/Xmt2RJ/02P2vUwPQKwQzHUswK1t/B7t69iMGVqAIy1DVrx8dTo
	 Gq/zTsR+pWvMfvWr2ziLQrHNAIZaoK4yJ/Jm9fCM+JPK8RPzjf69JKxLOw6JAaTPCd
	 cTJWI5zdjD5WYcL7gttuiwLVBs2df1U1v8s1jLn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgHUMaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgHUMam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:30:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA3520724;
        Fri, 21 Aug 2020 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598013042;
        bh=EYzeQyKbsyoYnxtSyFAJUuKt7H7T5SLVEFASRIYw5eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyEJWEd0IHbfvhGb9bY0cgzrF9WvhjDFh5PYOofSP0BNqyXAeJm2aaku8FWEOnI1J
         PNeuXObtjumPpe1J5yGBwsNWhe5NVcIEA+MNq8FJAXrXw0AUKydoEN9JJ3soORcGfk
         Mz7pS57vRO2MrQrzgcSX/V7nGBM7Yga3vpvXdvZY=
Date:   Fri, 21 Aug 2020 13:30:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
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
Message-ID: <20200821123036.GA21158@willie-the-truck>
References: <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com>
 <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net>
 <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs>
 <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck>
 <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 02:27:05PM +0200, Ard Biesheuvel wrote:
> On Fri, 21 Aug 2020 at 14:20, Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Aug 13, 2020 at 03:07:13PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 13 Aug 2020 at 15:04, Jessica Yu <jeyu@kernel.org> wrote:
> > > >
> > > > +++ Ard Biesheuvel [13/08/20 10:36 +0200]:
> > > > >On Wed, 12 Aug 2020 at 22:00, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >>
> > > > >> On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
> > > > >> > I know there is little we can do at this point, apart from ignoring
> > > > >> > the permissions - perhaps we should just defer the w^x check until
> > > > >> > after calling module_frob_arch_sections()?
> > > > >>
> > > > >> My earlier suggestion was to ignore it for 0-sized sections.
> > > > >
> > > > >Only they are 1 byte sections in this case.
> > > > >
> > > > >We override the sh_type and sh_flags explicitly for these sections at
> > > > >module load time, so deferring the check seems like a reasonable
> > > > >alternative to me.
> > > >
> > > > So module_enforce_rwx_sections() is already called after
> > > > module_frob_arch_sections() - which really baffled me at first, since
> > > > sh_type and sh_flags should have been set already in
> > > > module_frob_arch_sections().
> > > >
> > > > I added some debug prints to see which section the module code was
> > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
> > > > arm64's module_frob_arch_sections():
> > > >
> > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
> > > >                                  ".text.ftrace_trampoline"))
> > > >                         tramp = sechdrs + i;
> > > >
> > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> > > > is never set here and the if (tramp) check at the end of the function
> > > > fails, so its section flags are never set, so they remain WAX and fail
> > > > the rwx check.
> > >
> > > Right. Our module.lds does not go through the preprocessor, so we
> > > cannot add the #ifdef check there currently. So we should either drop
> > > the IS_ENABLED() check here, or simply rename the section, dropping
> > > the .text prefix (which doesn't seem to have any significance outside
> > > this context)
> > >
> > > I'll leave it to Will to make the final call here.
> >
> > Why don't we just preprocess the linker script, like we do for the main
> > kernel?
> >
> 
> That should work as well, I just haven't checked how straight-forward
> it is to change that.

Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
altogether.

Will
