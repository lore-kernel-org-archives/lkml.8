Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4FEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21BC207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598012481;
	bh=dyzu8JJ2FTVbgIo72WlGH/VPEaryNWuRCr3LcXdqh4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dVivEegtW4FEAF8IlMBUhoVQpJX7Jmo/gS3VBlG0Ab3wIIhkWnmIB5ndMlPG+X8SZ
	 FOBEX7G4xB3evEtBXsclN8yQGWKVWWGLqpwky9ai74C5+1cwkJqYLpWs0z2F/tjqgz
	 RpSuOnuotB75lNMvc0WwB7pnkQHo08wTjnuSajCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgHUMVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgHUMUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:20:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9C920724;
        Fri, 21 Aug 2020 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598012405;
        bh=dyzu8JJ2FTVbgIo72WlGH/VPEaryNWuRCr3LcXdqh4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lu/9DkAtOB95J4Ms4k9gmDWfffQIS72eFLvyILY0YFPx/9OPsNw7L9blTvB+RML2e
         cHAKxOgMKoyELaprbdI0V5apssBPfSPYWc7PFijT3N0ro9KWOqjzyldA+NaTv+6Ram
         /dTH146HYvby4S9XHjrCAIgHqL25RK7OLHgOiQQg=
Date:   Fri, 21 Aug 2020 13:20:00 +0100
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
Message-ID: <20200821121959.GC20833@willie-the-truck>
References: <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net>
 <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com>
 <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net>
 <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs>
 <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 03:07:13PM +0200, Ard Biesheuvel wrote:
> On Thu, 13 Aug 2020 at 15:04, Jessica Yu <jeyu@kernel.org> wrote:
> >
> > +++ Ard Biesheuvel [13/08/20 10:36 +0200]:
> > >On Wed, 12 Aug 2020 at 22:00, Peter Zijlstra <peterz@infradead.org> wrote:
> > >>
> > >> On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
> > >> > I know there is little we can do at this point, apart from ignoring
> > >> > the permissions - perhaps we should just defer the w^x check until
> > >> > after calling module_frob_arch_sections()?
> > >>
> > >> My earlier suggestion was to ignore it for 0-sized sections.
> > >
> > >Only they are 1 byte sections in this case.
> > >
> > >We override the sh_type and sh_flags explicitly for these sections at
> > >module load time, so deferring the check seems like a reasonable
> > >alternative to me.
> >
> > So module_enforce_rwx_sections() is already called after
> > module_frob_arch_sections() - which really baffled me at first, since
> > sh_type and sh_flags should have been set already in
> > module_frob_arch_sections().
> >
> > I added some debug prints to see which section the module code was
> > tripping on, and it was .text.ftrace_trampoline. See this snippet from
> > arm64's module_frob_arch_sections():
> >
> >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> >                          !strcmp(secstrings + sechdrs[i].sh_name,
> >                                  ".text.ftrace_trampoline"))
> >                         tramp = sechdrs + i;
> >
> > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> > is never set here and the if (tramp) check at the end of the function
> > fails, so its section flags are never set, so they remain WAX and fail
> > the rwx check.
> 
> Right. Our module.lds does not go through the preprocessor, so we
> cannot add the #ifdef check there currently. So we should either drop
> the IS_ENABLED() check here, or simply rename the section, dropping
> the .text prefix (which doesn't seem to have any significance outside
> this context)
> 
> I'll leave it to Will to make the final call here.

Why don't we just preprocess the linker script, like we do for the main
kernel?

Will
