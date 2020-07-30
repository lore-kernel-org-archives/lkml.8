Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC1DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA54A20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7DAd+sH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgG3Reh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgG3Reh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:34:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7373C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:34:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so28764438eje.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuZsBZ4FLSs9DhBM1ftF7hTsqpq1dRFqVaVn0cYFE4g=;
        b=j7DAd+sHLdDJ1H0wCIR2fuQ5+ckusNhPRIsnJ1myi7/6BBDVF3JxPMrBlrfMKhXMdu
         gv6dE2bX935ee7Nd11/v966XzPxHZ47TmrRb1HoZqu2BRXxcH4+ktw2SmiZj6Z61+U8Z
         GlgoopJvOSClM7n36PQA4nu2xx+AG9Me5N5HUxF7LAiNCk6f/RR+rbV8P/zt7DZIEVp4
         D9Hbk5MWpGWW/CPEU/8SLqI7DDNqx9gnr+iNe0x30YHxHTcR8BNTMmsUWlQsSWUkX7Nv
         aZKZefzC7YF6ZNkaL5R8hDzlbVAA9uhPYPY7cBVeQsu30bUSIluxP4pO6kayqJvwWVQd
         eh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuZsBZ4FLSs9DhBM1ftF7hTsqpq1dRFqVaVn0cYFE4g=;
        b=PNIhJgODG/kkEM+VA3nwutyMxc30gEIcICbhOjlVH4TzokXfLXH4MO/NrrqVYVdJq9
         HHJ+6Bq7N5OuJAtN/dyzhqnOATpUG8eO05ZWPjbE03Ku/UEwrsgjY1LFTflr4gmVs2FG
         BdXZOZ7CGUgvqPQF48YL3w5wLDJaoUFWxNt1dgLwt0zf3mnAR8Rtmte5fBL5662FpF7S
         96tgHziFSsXofFZcVdc8AzYuB4/jNSgfWiqhtYkGM/xdss4bwiVliBKpHVeazc6YnUmW
         B/Pnh1rDFkG6sOVWw31loWSAt8XvjEwuKZsEzHkMbe65UdFJmF6k1t5bDA3zQ5NyMKAT
         9bcg==
X-Gm-Message-State: AOAM530UzDCmWKgCW1wh4WPbf+GBrnnsOauO/UY1qb9aYJcIqEdoRnDm
        OShkauZVmLiGVYDJeJeVsVel3S8P4lrzocIbqWbqPA==
X-Google-Smtp-Source: ABdhPJzbC5lkyCpfXxRlJkHYlGyMrrpTTlmn1AnjedJDLk9WedVHAqMNHtCkEKp0tdOxwS7vyb5EA6A44iZkQCOZrao=
X-Received: by 2002:a17:906:a204:: with SMTP id r4mr171760ejy.552.1596130475360;
 Thu, 30 Jul 2020 10:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200729215152.662225-1-samitolvanen@google.com>
 <20200730153701.3892953-1-samitolvanen@google.com> <20200730172430.GC3128@gaia>
In-Reply-To: <20200730172430.GC3128@gaia>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 30 Jul 2020 10:34:24 -0700
Message-ID: <CABCJKucATXjvTgiAp2G+WOWPFSiFPCZx6YDHj95YYiMLgoQHrA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/alternatives: move length validation inside the subsection
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:24 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Jul 30, 2020 at 08:37:01AM -0700, Sami Tolvanen wrote:
> > Commit f7b93d42945c ("arm64/alternatives: use subsections for replacement
> > sequences") breaks LLVM's integrated assembler, because due to its
> > one-pass design, it cannot compute instruction sequence lengths before the
> > layout for the subsection has been finalized. This change fixes the build
> > by moving the .org directives inside the subsection, so they are processed
> > after the subsection layout is known.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1078
> > Fixes: f7b93d42945c ("arm64/alternatives: use subsections for replacement sequences")
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> > v1 -> v2:
> > - Added the missing Fixes tag and dropped CC: stable@.
> >
> > ---
> >  arch/arm64/include/asm/alternative.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> > index 12f0eb56a1cc..619db9b4c9d5 100644
> > --- a/arch/arm64/include/asm/alternative.h
> > +++ b/arch/arm64/include/asm/alternative.h
> > @@ -77,9 +77,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
> >       "663:\n\t"                                                      \
> >       newinstr "\n"                                                   \
> >       "664:\n\t"                                                      \
> > -     ".previous\n\t"                                                 \
> >       ".org   . - (664b-663b) + (662b-661b)\n\t"                      \
> > -     ".org   . - (662b-661b) + (664b-663b)\n"                        \
> > +     ".org   . - (662b-661b) + (664b-663b)\n\t"                      \
> > +     ".previous\n"                                                   \
> >       ".endif\n"
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> There are a few instances of the .org test outside the subsection,
> though using in .S files. Are those ok?

Yes, this only appears to be a problem when used in inline assembly.

Sami
