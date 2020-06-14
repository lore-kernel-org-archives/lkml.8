Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492DD20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAHhEFxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFNRQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgFNRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:16:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B9DC03E969
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 10:16:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so12358365wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NB/Urk4sJ7NmljdwQD2Dnqq/4/xbrUeJIHIJ24wA9w=;
        b=QAHhEFxeJmo0Om8T1XowjgXKEOtxoTEUtMZtDrPDZ16145txGi0czO09BgNHN6gHKc
         Hqng+qmsvf0PiYElL5AYpW0PlOZar/aOBcvHd1iMzOfCMA9Qz5zA50S1NrmxuZ/DueoO
         F20OgRGR60ysi4D1Xieo5pYVvVpPUfFqsXIKHRmamJAxD18hB+RXmqa5K2JpeAmJJG3/
         lzF83lZZPc62cgwg67PFw60FRz0XJm1BqWuzxfS3qFVm+NNwvel93rCRiQB+E+araGBV
         YaJ/eOuO7WhyU6kpAYespn4cTCZcBG8/JnTgfH/6xHCHA53xX36xR4Ing06Qdw9Q7p6i
         Ed1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NB/Urk4sJ7NmljdwQD2Dnqq/4/xbrUeJIHIJ24wA9w=;
        b=d8h6OUBlrEfQCxQDfEIGUwxXwe6eKKFOkQ14jLAoZ61LSs5hknRTdUjICYvivQGLxp
         VDJU44ehiKW6UT84a1ZcOwBb8RQtTnQB63Ricb5G++kPsMFHKA94Aa8X+SF1fhEgoyS9
         Xv/XldEZZ01jdrZcQlSyWJSi2jkC+l0I9blIg49MiUSUxFbm5kQkg2Fxh5FsO5Sb9dJm
         PaDaEnrVDpmZm0P4ZvYvPb6FreM91AGaju35nzTpMsim39o/2I+xzSCS7KOwAUjsAsac
         j/qNmaBsWhQZ2fol/e0lSqij6PeFMbaRPElFzIyWuN55Dv+1Wn5aQHEB8rZ0XG8Paztj
         QT1g==
X-Gm-Message-State: AOAM533jbcYAj4iXar0sfAJsQnTjedpcKbnkU93Vk3rhTW100EYs/vyI
        otg6q9v3Ixki/SAp/VC2mOne80+baIh9TZwMY4l9RQ==
X-Google-Smtp-Source: ABdhPJyN4KeTIsKZyv/xnv0GBlMgsrAn8BwQKjsw6BJ2Bjm3+v4PjEme/I0FaAaWCNt3azLN5km5AF5DB41xZAPtEpw=
X-Received: by 2002:a1c:2082:: with SMTP id g124mr9383717wmg.21.1592155004853;
 Sun, 14 Jun 2020 10:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200614144534.237035-1-glider@google.com> <202006141000.B93DF245@keescook>
In-Reply-To: <202006141000.B93DF245@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Sun, 14 Jun 2020 19:16:33 +0200
Message-ID: <CAG_fn=V0w2OShK+iQODkwdPoG094VpiPkhZ8O_F37m=g2XWwug@mail.gmail.com>
Subject: Re: [PATCH] [RFC] security: allow using Clang's zero initialization
 for stack variables
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 7:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Jun 14, 2020 at 04:45:34PM +0200, glider@google.com wrote:
> > In addition to -ftrivial-auto-var-init=pattern (used by
> > CONFIG_INIT_STACK_ALL now) Clang also supports zero initialization for
> > locals enabled by -ftrivial-auto-var-init=zero.
> > The future of this flag is still being debated, see
> > https://bugs.llvm.org/show_bug.cgi?id=45497
> > Right now it is guarded by another flag,
> > -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
> > which means it may not be supported by future Clang releases.
> > Another possible resolution is that -ftrivial-auto-var-init=zero will
> > persist (as certain users have already started depending on it), but the
> > name of the guard flag will change.
> >
> > In the meantime, zero initialization has proven itself as a good
> > production mitigation measure against uninitialized locals. Unlike
> > pattern initialization, which has a higher chance of triggering existing
> > bugs, zero initialization provides safe defaults for strings, pointers,
> > indexes, and sizes. On the other hand, pattern initialization remains
> > safer for return values.
> > Performance-wise, the difference between pattern and zero initialization
> > is usually negligible, although the generated code for zero
> > initialization is more compact.
> >
> > The proposed config, CONFIG_USE_CLANG_ZERO_INITIALIZATION, makes
> > CONFIG_INIT_STACK_ALL use zero initialization if the corresponding flags
> > are supported by Clang.
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  Makefile                   | 15 ++++++++++++++-
> >  security/Kconfig.hardening | 16 ++++++++++++++++
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index fd31992bf918..2860bad7e39a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -802,9 +802,22 @@ KBUILD_CFLAGS    += -fomit-frame-pointer
> >  endif
> >  endif
> >
> > -# Initialize all stack variables with a pattern, if desired.
> > +# Initialize all stack variables, if desired.
> >  ifdef CONFIG_INIT_STACK_ALL
> > +
> > +# Use pattern initialization by default.
> > +ifndef CONFIG_USE_CLANG_ZERO_INITIALIZATION
> >  KBUILD_CFLAGS        += -ftrivial-auto-var-init=pattern
> > +else
> > +
> > +ifdef CONFIG_CC_HAS_AUTO_VAR_ZERO_INIT
> > +# Future support for zero initialization is still being debated, see
> > +# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
> > +# renamed or dropped.
> > +KBUILD_CFLAGS        += -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> > +endif
> > +
> > +endif
> >  endif
>
> I'd prefer this be split instead of built as a nested if (i.e. entirely
> control section via the Kconfig -- see below).
>
> >
> >  DEBUG_CFLAGS := $(call cc-option, -fno-var-tracking-assignments)
> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > index af4c979b38ee..299d27c6d78c 100644
> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -22,6 +22,9 @@ menu "Memory initialization"
> >  config CC_HAS_AUTO_VAR_INIT
> >       def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
> >
> > +config CC_HAS_AUTO_VAR_ZERO_INIT
> > +     def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
> > +
>
> I'd like to be more specific here. Let's rename CC_HAS_AUTO_VAR_INIT to
> CC_HAS_AUTO_VAR_INIT_PATTERN, and change the other to
> CC_HAS_AUTO_VAR_INIT_ZERO (they then both match the word order of the
> option, and the thing that changes is the last word).
>
> >  choice
> >       prompt "Initialize kernel stack variables at function entry"
> >       default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
> > @@ -100,6 +103,19 @@ choice
> >
> >  endchoice
> >
> > +config USE_CLANG_ZERO_INITIALIZATION
> > +     bool "Use Clang's zero initialization for local variables"
> > +     depends on CC_HAS_AUTO_VAR_ZERO_INIT
> > +     depends on INIT_STACK_ALL
> > +     help
> > +       If set, uses zeros instead of 0xAA to initialize local variables in
> > +       INIT_STACK_ALL. Zeroing the stack provides safer defaults for strings,
> > +       pointers, indexes, and sizes. The downsides are less-safe defaults for
> > +       return values, and exposing fewer bugs where the underlying code
> > +       relies on zero initialization.
> > +       The corresponding flag isn't officially supported by Clang and may
> > +       sooner or later go away or get renamed.
> > +
>
> Similarly, I'd like to rename INIT_STACK_ALL to INIT_STACK_ALL_PATTERN
> and then add INIT_STACK_ALL_ZERO.

What are the policies regarding keeping the existing config flags?
Don't we need to preserve INIT_STACK_ALL?
