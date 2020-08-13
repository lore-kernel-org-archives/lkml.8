Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281F7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6692078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597324050;
	bh=VcwApqM6DK8ecEh+UIkhoHA0RLne+ZImllm8gN6jcVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X+NWiMGSk+XpjOFHjDOhVWr1B0CkOrtElTJYMcmGNIZj4Myaj1fsolDACWCgquLDg
	 R5LTlE74oR/Q17cLZaWFDC18hJVrJ4XR5Knr8IfcoJB90xWG/iIhZ2j5F2LoCo+yN4
	 jxUGfDfhPTtWiFk6kAkx6HlaEsntoo/uWegYf53E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHMNH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMNH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:07:26 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D218C2087C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597324045;
        bh=VcwApqM6DK8ecEh+UIkhoHA0RLne+ZImllm8gN6jcVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gVBS22cSg1yykUPgCjhs3OEKYO/ySG7YzbCnzKWILSmyjDaKbLmHDQjehMjMz7IwJ
         w/Ss5NWKEz3Rb2EGYgpjAEg5aO+EWbfGmCDfByoQUESUJhPEL9fD+FRXtmWTigUPaD
         MIEJqpTkcPNOFN+/7o8/p4gzy0pVFn7CkDVw1Ik8=
Received: by mail-oi1-f173.google.com with SMTP id e6so4961112oii.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 06:07:25 -0700 (PDT)
X-Gm-Message-State: AOAM5315yP/gX3rk+s13sONRYVBYfRafjTobjBi/mJe/8yo5OaeCeXlJ
        Tkp1zoXVNxYGMNE0QjVBRO4tbFIc0nPoidIJmN8=
X-Google-Smtp-Source: ABdhPJzVJrqrlp2mXbzFo3U0IRt32Fp3ZcBnhWaqBWVxjF81pihOTqAZz9SwhjBByuqfVQKB5I1Cu3OhIhK19c/9/P8=
X-Received: by 2002:aca:d8c5:: with SMTP id p188mr3103262oig.47.1597324045108;
 Thu, 13 Aug 2020 06:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200811172738.2d632a09@coco.lan> <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net> <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com> <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net> <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs>
In-Reply-To: <20200813130422.GA16938@linux-8ccs>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Aug 2020 15:07:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
Message-ID: <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
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

On Thu, 13 Aug 2020 at 15:04, Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Ard Biesheuvel [13/08/20 10:36 +0200]:
> >On Wed, 12 Aug 2020 at 22:00, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
> >> > I know there is little we can do at this point, apart from ignoring
> >> > the permissions - perhaps we should just defer the w^x check until
> >> > after calling module_frob_arch_sections()?
> >>
> >> My earlier suggestion was to ignore it for 0-sized sections.
> >
> >Only they are 1 byte sections in this case.
> >
> >We override the sh_type and sh_flags explicitly for these sections at
> >module load time, so deferring the check seems like a reasonable
> >alternative to me.
>
> So module_enforce_rwx_sections() is already called after
> module_frob_arch_sections() - which really baffled me at first, since
> sh_type and sh_flags should have been set already in
> module_frob_arch_sections().
>
> I added some debug prints to see which section the module code was
> tripping on, and it was .text.ftrace_trampoline. See this snippet from
> arm64's module_frob_arch_sections():
>
>                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
>                          !strcmp(secstrings + sechdrs[i].sh_name,
>                                  ".text.ftrace_trampoline"))
>                         tramp = sechdrs + i;
>
> Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> is never set here and the if (tramp) check at the end of the function
> fails, so its section flags are never set, so they remain WAX and fail
> the rwx check.

Right. Our module.lds does not go through the preprocessor, so we
cannot add the #ifdef check there currently. So we should either drop
the IS_ENABLED() check here, or simply rename the section, dropping
the .text prefix (which doesn't seem to have any significance outside
this context)

I'll leave it to Will to make the final call here.
