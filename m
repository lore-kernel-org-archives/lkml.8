Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D30C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2F820656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TG6rKq8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403953AbgF2VnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgF2Shw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DF2C031C7F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:18:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so8221478pfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVpg6vIouDiH3on4zq6Qkvcb4IcnV9Eg7LBox0nJvvM=;
        b=TG6rKq8OIgA/7NkvNhVbwcp7Zv81JPFjOf+X5UcCa1t+7uVP1xbpgSP9j7A1oaOrDB
         URqVDRAfG2f8ZVotshyU0N6vx7j9gnEMkN2ZKla0nhU8H+hqEabOCXFHgrmhkdiUNDc0
         c10xCi1y0+t2AOlKgfjDJ3AF633ROwnB2UluF8oFnaHIxW/ZNI4eeEh/Tnaf0n3YeW+T
         YTW9iGyu6ShQ6xVj1DqYA0MHDO/YQTZJ6l/Re/dhnJklZQC8rIkaANrpwMxz2E/eYA6E
         q6tGvHjkbrH7RdYeDdgMCAj7jYCOqIERf7OTSeWu13R4TJZinjirQ0MiAVPZ4kdnGlSh
         PMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVpg6vIouDiH3on4zq6Qkvcb4IcnV9Eg7LBox0nJvvM=;
        b=WGwJqk95sXsvtpldIN0w2oQEpXj0A05PF4edrwN9J2AgDq3jmm+2WPQ5e/VxqFoDad
         wMXyFD2A+oUNCknCGYR9bhhnYtHO82IGaEaLc7AQPyTFdsQegm3nNixv/lgte0VtaR0y
         E7Iv7NlX5MIiHrEL9P0oRBwEQ/wU1kl4NFOYvtKbuqgDQjmcAbDtt6gK2yjMXIZwdce9
         1luEoPZgvimXZSv8XHs8yYbQwipCGtVayd0W+bjAtaWAljDkQ1hdGVRKh1xOuTTe3bbj
         5GBxeywrHUPsKnFdhZYpV51UF1SfTNyKMax0zOx2hBhLx/SakJE74jCG2IZ7k0w0qJUA
         6toA==
X-Gm-Message-State: AOAM533KzOw0cKC5OwbzqJxEhaLujCESvNVC5PXagVUu/3/fDigYw0ew
        uT0OaHt5bXGlI9RnsLIikniFZxYUwx2RniMeqke2vs8H
X-Google-Smtp-Source: ABdhPJx9DCxKOqTyOvK/N39qAKQF4pHJeiMiGtVuafF9ig7zbCcl+2HZ5M9JzPJoDZZmvSgVG0JvPipv8QimLEaooNg=
X-Received: by 2002:a63:5644:: with SMTP id g4mr11018260pgm.381.1593454711516;
 Mon, 29 Jun 2020 11:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <202006210249.QHly8bQZ%lkp@intel.com> <CA+h21hpABfDvthiwq_JwWGpqZ68VJxu5TOBVbw_Gaxpq8j+XQg@mail.gmail.com>
 <CAKwvOdnAKR_CtOccZohR_r1kzKKVuvo8LbpLi0s3ek+3u+c_zw@mail.gmail.com> <CA+h21hokCCF52O1wxkg0gLqS9ZcGtB0xMBm07_--i56=anJ=Rg@mail.gmail.com>
In-Reply-To: <CA+h21hokCCF52O1wxkg0gLqS9ZcGtB0xMBm07_--i56=anJ=Rg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jun 2020 11:18:20 -0700
Message-ID: <CAKwvOdkcPWT4krC5FuCpiXaoY+GiTeUa=CiamFCk5tPJOz4Cjw@mail.gmail.com>
Subject: Re: drivers/gpu/drm/panel/panel-samsung-ld9040.c:240:12: warning:
 stack frame size of 8312 bytes in function 'ld9040_prepare'
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 12:43 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Hi Nick,
>
> On Mon, 22 Jun 2020 at 19:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
>
> > > I really don't get what's the problem here. The listing of
> > > ld9040_prepare at the given commit and with the given .config is:
> >
> > I wrote a tool to help debug these.
> > https://github.com/ClangBuiltLinux/frame-larger-than
> > If you fetch the randconfig and rebuild with debug info, that tool
> > will help show you which variables are used in which stack frames and
> > what their sizes are.  Also note that strange things get dug up from
> > randconfigs.
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> I ran your tool and it basically told me that all 11 calls to

Cool? No bugs running it? (I still need to extend support for many
architectures)

> ld9040_dcs_write from within ld9040_init are inlined by the compiler.
> Each of these ld9040_dcs_write functions calls ld9040_spi_write_word
> twice, so 22 inline calls to that. Now, sizeof(struct
> spi_transfer)=136 and sizeof(struct spi_message)=104, so, no wonder we
> run out of stack pretty quickly.

I'd expect these to have distinct lifetimes resulting in stack slot
reuse.  When the compiler inlines functions, it introduces a lexical
scope. You can imagine it inlining the body, but within a new `{}`
delineated compound statement.  Then the compiler knows that the
variables local to those scopes can't outlive each other, and can
reuse their stack slots in the containing function.  Escape analysis
comes into play, too, but I'm not sure that's an issue here.

>
> But my question is: what's wrong with the code, if anything at all?

The general case we try to find+fix with this warning is excessively
large stack allocations that probably should be heap allocated,
percpu, or static.  Also, the `noinline_for_stack` function annotation
is used frequently for this.

One known case of issues are the sanitizers, which can generally
prevent the reuse of stack slots.  Were any of those set in this
config, since this was a randconfig?  I'd check this first, then
consider if `noinline_for_stack` is appropriate on any of the related
functions.

> Why does the compiler try to inline it, and then complain that it's
> using too much stack

The flag -Wframe-larger-than= is a warning on semantics, not really an
optimization flag controlling the maximum stack depth of the function
being inlined into.

> when basically nobody appears to have asked it to
> inline it?

That's not really how inlining works.  If you don't specify compiler
attributes, then the compiler can decide to inline or not at its
discretion.  The `inline` keyword or its absence doesn't really affect
this.  __attribute__((always_inline)) and __attribute__((noinline))
can give you more control, but there are hyper obscure edge cases
where even those don't work as advertised.

-- 
Thanks,
~Nick Desaulniers
