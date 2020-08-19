Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6858CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40016207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0qzDu0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHSULe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:11:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8709EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:11:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so4603pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysEscVWILmvmykMxg8+0n31+wodeRoaMfoU6oDZTo84=;
        b=W0qzDu0dz/vFLIgmwd1kjxLHoxU+UwI1bE9+a5gGd+09ufPzSS4iMaaJ+O1+MrnJgc
         2ms7ld15axXbGMV4cveW2c13TbR98YkSq+qPYMrtJvudgciopq2AQu+mo9MNykDpBsLy
         cTCA7w3gv+vTyr9GoMzmF7vXnZ+QNO1kQaS6x8Oqt/tJL6o+wcQRhDcZv3TZ8EIpOMF2
         MrqQACaFUfPnHEfC0vNTlCJUepNtOyEf4z99vf9/dUNx1HcJBNzpMZSSSx3IM/X/Pj+3
         abAtZWj7BSlh/omOuXiBBmjiQnN7kgR1tg93rDtfc+pfQLx61XrLLnxwifrHUzsNmM0T
         Vz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysEscVWILmvmykMxg8+0n31+wodeRoaMfoU6oDZTo84=;
        b=BoRWITBiVZZaj9MSEYfYDuPUQcryLdT+uK0DvXPkVN+ODqAJE38rIsHkVqCJeLvdxB
         8a51jmsbyeWNNzXD7/E6K6zS4wxErI2FjOGMHVD+NnIG4sCr6h+CL90PsC/FGB4JEsgv
         c+WG7M7GmTEpamOyTG4w5fq7uP9Op9NRmCokfA8EPW4zb7w+Ud2TiAwulgShU4EWMb0A
         0MvRJkbKjtv7AzeS6pdE/AFnhovF9hxZY5MZFgqDOdyRTZRJEF3ltWrNPLXzK+Q6bKBt
         294gcChsc1/tKmI0dC8vACHaBI+g2wk+HmvvLrhGSPFGxTmyWLvoeOCx3BWP6WY/CluI
         Pz1Q==
X-Gm-Message-State: AOAM533WWN2XW3v3tZTq+wHJhukTfIXb3xudPL6cZeKprucyaEbzGul2
        tu4wcH3Fj8EnEX3NAa3xLC6w0elMx4xGSwt2YyhdWQ==
X-Google-Smtp-Source: ABdhPJwvRmg/DUpVHXrDhcZyVbveYkPJZZxlAB7YooCCxegjU6ojPHBaRIQeJNx70cCujRu1aiwKGCQG01MEe7c2woM=
X-Received: by 2002:a05:6a00:14d0:: with SMTP id w16mr20101130pfu.39.1597867888865;
 Wed, 19 Aug 2020 13:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200819191654.1130563-1-ndesaulniers@google.com>
 <20200819191654.1130563-5-ndesaulniers@google.com> <20200819192932.GA58968@rani.riverdale.lan>
In-Reply-To: <20200819192932.GA58968@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Aug 2020 13:11:17 -0700
Message-ID: <CAKwvOdnkqt8vBHcFNk1TMDWcnrOKcZF2O=Y250r6ZBns5dGvBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] x86/boot: use -fno-builtin-bcmp
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:29 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Aug 19, 2020 at 12:16:53PM -0700, Nick Desaulniers wrote:
> > We're reverting
> > commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
> > in favor of -fno-builtin-bcmp. Remove the additional definition here,
> > too.
> >
> > arch/x86/purgatory/Makefile uses -ffreestanding, so there's no risk of
> > this libcall optimization occurring for arch/x86/boot/purgatory.ro.
> >
> > arch/x86/boot/Makefile resets KBUILD_CFLAGS, so make sure to reset this
> > flag that was set for the top level Makefile.
> >
> > Fixes: 4ce97317f41d ("x86/purgatory: Do not use __builtin_memcpy and __builtin_memset")
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/x86/boot/Makefile | 1 +
> >  arch/x86/boot/string.c | 8 --------
> >  2 files changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> > index fe605205b4ce..ef7f15bfceab 100644
> > --- a/arch/x86/boot/Makefile
> > +++ b/arch/x86/boot/Makefile
> > @@ -70,6 +70,7 @@ KBUILD_CFLAGS       := $(REALMODE_CFLAGS) -D_SETUP
> >  KBUILD_AFLAGS        := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> >  KBUILD_CFLAGS        += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> >  KBUILD_CFLAGS        += -fno-asynchronous-unwind-tables
> > +KBUILD_CFLAGS        += -fno-builtin-bcmp
> >  GCOV_PROFILE := n
> >  UBSAN_SANITIZE := n
> >
>
> This should be unnecessary: KBUILD_CFLAGS in arch/x86/boot/Makefile is
> set to REALMODE_CFLAGS (defined in arch/x86/Makefile), which includes
> -ffreestanding.

I triple checked by grepping the disassemblies of
./arch/x86/purgatory/purgatory.ro, arch/x86/purgatory/*.o, and
arch/x86/boot/*.o for bcmp; should be fine to drop that hunk.  Will
wait a bit to see if there's other feedback, and whether folks are on
board with the plan to merge the series proposed in the cover letter
or not.

--
Thanks,
~Nick Desaulniers
