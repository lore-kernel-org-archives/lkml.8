Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6996EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3141422BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1pIiM/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgH0HRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgH0HRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:17:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453BC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:17:06 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v16so494933otp.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=zNOXVAGO16g0kovdlJNyDoGYPK7lUFG4qEghaPRGfks=;
        b=b1pIiM/0UNQDPwyoWjeSB0ShopOTgT838OTj33MZv709GGFDArARx2Bf0kuGtaRf8V
         OrWbf5XDNRdY2t9lr0f8Y4gOTMfap638g3bsokHo5Dgw3repIwoYdjHp5zLOyLBw+gQ6
         vIc5vnYKJ+h1O5tVZE8P1fvJFc5tRwseWwPOTRPp3fluECFzphZrUCNRCtTy2Cw++ioq
         QpJauVqZdRO4MopGL4nmxOJVbe1cEWzGGmeaarPifVkD4iXLOy88KYWWvW/XjSYR/ekN
         paF3m7n2ZFOs+B4/m8qqLZlZMnlrtUJDw3/5UiWQMCYRwT1fJV3R3ELbkSTvvszXl1Dl
         lwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=zNOXVAGO16g0kovdlJNyDoGYPK7lUFG4qEghaPRGfks=;
        b=hIxgU6vuEUuzwDPmNb14vCDIkSR0TN/yzuAPQ9leDYRYM8zr7vDKmoE3a4otyzr95E
         MH18R7hKeOeQ8+jTQIM5jk8tjixVnvEvoE3clZqlaObV8Tmk0KsVyeNkAMgDy9IFelIu
         RU7Kzpdzp/Jr9MNabxFSVwoPhvGog86taheOb8idGJdYYhc29YpXtOyPkKphVCPRKNuP
         lyoTKwQ6/YwPZD5sHx4c2eulS/kRnUUUMjY1ANyRxDpCqj4susT28BoT6mekfHrFg6db
         OC9/wOoawkNBiECuhVIxY3zwyfCqIi3uDz44+z1A3yAR4pleleFCXo0o+4a+IvvfPBez
         Teug==
X-Gm-Message-State: AOAM5316sYcmfkSsyHvl2MzT2E2D+HLDPxJTN+yLkuZO9Q0aysEIFiqt
        WXa3JuW6bvDkMr6EVZllIewSebXqIR2z0j9umeY=
X-Google-Smtp-Source: ABdhPJyi5eesw4d22B3bgXxKOLXqpAFz7pDYQsonSgnz8JJU9Y5I1eiy84DXkauge+o38MBC8axLozYuWT7csM7s9Mg=
X-Received: by 2002:a05:6830:1147:: with SMTP id x7mr13199188otq.28.1598512625531;
 Thu, 27 Aug 2020 00:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200826201420.3414123-1-ndesaulniers@google.com> <202008261356.B31349A@keescook>
In-Reply-To: <202008261356.B31349A@keescook>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 27 Aug 2020 09:16:54 +0200
Message-ID: <CA+icZUVhw6Pry-N3dZNHKYz1UqEg0-ePOYepoe7rn15+S5zGgA@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 11:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Aug 26, 2020 at 01:14:19PM -0700, Nick Desaulniers wrote:
> > During Plumbers 2020, we voted to just support the latest release of
> > Clang for now.  Add a compile time check for this.
> >
> > Older clang's may work, but we will likely drop workarounds for older
> > versions.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/9
> > Link: https://github.com/ClangBuiltLinux/linux/issues/941
> > Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  include/linux/compiler-clang.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index cee0c728d39a..7338d3ffd240 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -3,6 +3,14 @@
> >  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
> >  #endif
> >
> > +#define CLANG_VERSION (__clang_major__ * 10000       \
> > +                  + __clang_minor__ * 100    \
> > +                  + __clang_patchlevel__)
> > +
> > +#if CLANG_VERSION < 100001
> > +# error Sorry, your compiler is too old - please upgrade it.
>
> Perhaps a bike-shed suggestion, but I think we should make this message
> as specific (and helpful) as possible:
>
> # error Sorry, your version of Clang is too old - please use 10.0.1 or newer.
>

Agreed... Information about the required minimum version is user-friendly.

- Sedat -

> Then anyone seeing this has several pieces of information:
>
> - the kernel build was attempting to use Clang
>         (maybe they accidentally poked the wrong configs in a CI)
> - they need 10.0.1 or better
>         ("upgrade to what version?" doesn't need to be dug out of documentation,
>          headers, etc)
>
> With that, yes, let's do it. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> (And likely we should improve the GCC message at the same time...)
>
> --
> Kees Cook
