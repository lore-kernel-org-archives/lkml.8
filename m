Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE289C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 13:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2F320825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598104039;
	bh=96L7B+okFVZq/04jywlusT8K3xmTarPedqhqNo5VI/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o50MlJjzGw1Tcrin6o7NeqfYIfSsyrq4g6ed/SRGRPwhxDXrxu2IaMqJDFR3L4jUp
	 DUgDJ77PuGyVApXvk3+Rl3e1zjAJ82Vp8zY/7CE5dTMXPa0gwE/qvn6jLgq5uj749Y
	 ZVpDBU6pgvsNc7P0FwRrUh3fC6BDhzYGVT/SpRiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgHVNrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 09:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgHVNrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 09:47:17 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82B2521741
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598104036;
        bh=96L7B+okFVZq/04jywlusT8K3xmTarPedqhqNo5VI/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P09jrbympqAEkN69SBz1EvE+01fNdlQ2Flk1caOFT34h84ugqwdODFoNS90KxoMlu
         x8dpAL7LSv20oH95Lc99/AjCv9rxPmzKLiZT9frKTjSruZ1KgC5QJGBXpe5gC2sXBZ
         uJdZVyODiznCS4YeXjmLG4kKQAivA+zqNhDJImaA=
Received: by mail-ot1-f46.google.com with SMTP id h22so3743282otq.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 06:47:16 -0700 (PDT)
X-Gm-Message-State: AOAM5335UHZPKm1eE0ZV6T7FgRQp+mWJeJiJc5UdLKmSdWX5gtxNeIH7
        juALpDEsf5Ne1nQ/MjJSbDlEEMJKn0jYy/Xon+o=
X-Google-Smtp-Source: ABdhPJxWTqkJNUyGiLJ4QHqylhZpK9O4tBtOIx4L96uyoM+oPAsUY0Tj5opirBhgEzSeY4EhiZoPNWPi7hr5yoN8hpk=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr5100058otk.90.1598104035809;
 Sat, 22 Aug 2020 06:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200812125645.GA8675@willie-the-truck> <20200812141557.GQ14398@arm.com>
 <20200812160017.GA30302@linux-8ccs> <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net> <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs> <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck> <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck>
In-Reply-To: <20200821123036.GA21158@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 22 Aug 2020 15:47:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgHo59vuua49rAoLfSt36JKSzFMMH+Z=y+3jNjbFPZsg@mail.gmail.com>
Message-ID: <CAMj1kXHgHo59vuua49rAoLfSt36JKSzFMMH+Z=y+3jNjbFPZsg@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Masahiro)

On Fri, 21 Aug 2020 at 14:30, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Aug 21, 2020 at 02:27:05PM +0200, Ard Biesheuvel wrote:
> > On Fri, 21 Aug 2020 at 14:20, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, Aug 13, 2020 at 03:07:13PM +0200, Ard Biesheuvel wrote:
> > > > On Thu, 13 Aug 2020 at 15:04, Jessica Yu <jeyu@kernel.org> wrote:
> > > > >
> > > > > +++ Ard Biesheuvel [13/08/20 10:36 +0200]:
> > > > > >On Wed, 12 Aug 2020 at 22:00, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > >>
> > > > > >> On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
> > > > > >> > I know there is little we can do at this point, apart from ignoring
> > > > > >> > the permissions - perhaps we should just defer the w^x check until
> > > > > >> > after calling module_frob_arch_sections()?
> > > > > >>
> > > > > >> My earlier suggestion was to ignore it for 0-sized sections.
> > > > > >
> > > > > >Only they are 1 byte sections in this case.
> > > > > >
> > > > > >We override the sh_type and sh_flags explicitly for these sections at
> > > > > >module load time, so deferring the check seems like a reasonable
> > > > > >alternative to me.
> > > > >
> > > > > So module_enforce_rwx_sections() is already called after
> > > > > module_frob_arch_sections() - which really baffled me at first, since
> > > > > sh_type and sh_flags should have been set already in
> > > > > module_frob_arch_sections().
> > > > >
> > > > > I added some debug prints to see which section the module code was
> > > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
> > > > > arm64's module_frob_arch_sections():
> > > > >
> > > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> > > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
> > > > >                                  ".text.ftrace_trampoline"))
> > > > >                         tramp = sechdrs + i;
> > > > >
> > > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> > > > > is never set here and the if (tramp) check at the end of the function
> > > > > fails, so its section flags are never set, so they remain WAX and fail
> > > > > the rwx check.
> > > >
> > > > Right. Our module.lds does not go through the preprocessor, so we
> > > > cannot add the #ifdef check there currently. So we should either drop
> > > > the IS_ENABLED() check here, or simply rename the section, dropping
> > > > the .text prefix (which doesn't seem to have any significance outside
> > > > this context)
> > > >
> > > > I'll leave it to Will to make the final call here.
> > >
> > > Why don't we just preprocess the linker script, like we do for the main
> > > kernel?
> > >
> >
> > That should work as well, I just haven't checked how straight-forward
> > it is to change that.
>
> Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
> altogether.
>

I played around with this for a while, but failed to get Kbuild to
instantiate $(objtree)/arch/arm64/kernel/module.lds based on
$(srctree)/arch/arm64/kernel/module.lds.S and the cpp_lds_S rule.
Perhaps Masahiro has any suggestions here? Otherwise, let's just drop
the IS_ENABLED() check for now.
