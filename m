Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24734C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEF920716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqDBE4cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbgHQRZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389504AbgHQRO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:14:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D201C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:14:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id t10so18619526ejs.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HRH4wla07jht+Skbj8wFO6vqCAFqpa7H6BM6x87yVg=;
        b=dqDBE4cR++KAZZ5hLmGT6aqmpeeGLsderydI/lunO905KBRozODliRGNiJIhHiF5h0
         F9m8FoKTci5UAxC4rCkJJja5uT4Tz1VvH6G528LJ75HmWo3ozbnCZ3un5IO0DXA50eVM
         zf5syXmgrNl5UuZLcxear/pdEnGpWozETr/QN/cUlj66AqeR/1+NM0IVrrbDx8CloZ6Z
         PVgtO0sGyR2rXkCu9mJvuaI8+7F/AxmsSGnQ5j4zcYpk+9TNvq88ZM4mVEZwTsBCcIet
         z82hsl+acS9ITMvrQt7bY0NM4JT4vrTZSKsMgpfRaDyRu+ghuNDgJmWVTty+OvQ4MFy3
         OfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HRH4wla07jht+Skbj8wFO6vqCAFqpa7H6BM6x87yVg=;
        b=CHYQVUi0JZwKaPghdPlkFXMo1E93lTa10pMYlJ+zbKVR31VbTFTW0O/Q9x67Mkd4JP
         bMJwuBHjHjRSUtFuSlcJ5p1Ltycsni4E0XmB1WhBP+jYl2yS9dbOLdFX9WHQDXTqI71B
         SEOJ/JYfMv5Twnmz6AfsX50SHY/NqcQTTFmJ+q5PBcC4I1tNBAuAZjyAPewh4GhYNtcU
         RdoxB2+SuSNzQfnJl5iR4SXWnh8XqBdt/IItbRMBMEqQvaUNTd8Jdhbcrn5mjHXuVb+9
         xob8YVvkTDfNnwvJ9aoImL3Yq7++t7NVw15vIBagTcLN9lxbxAMP/oJvh0s3Yz9t9mS7
         dh/g==
X-Gm-Message-State: AOAM533fn9UXkfoRkfshuI+CAzqL5BXplY7Gg+X3HYzkUNVq5HKve+fe
        Fufwz2zsvo/n2UDB1/h0bJe2ZjcRpSyvLHP5v1QFlw==
X-Google-Smtp-Source: ABdhPJyKHR5Mdvurt/PpCfpAL7T67WQ33FTGWP0iLP80KXwPMohlRdvQKDLY5ncwnlLyNJlKI+K/D519Z8mHnFX111w=
X-Received: by 2002:a17:906:2356:: with SMTP id m22mr15726038eja.124.1597684494511;
 Mon, 17 Aug 2020 10:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200815014006.GB99152@rani.riverdale.lan> <20200815020946.1538085-1-ndesaulniers@google.com>
 <202008150921.B70721A359@keescook> <CAKwvOdnyHfx6ayqEoOr3pb_ibKBAG9vj31LuKE+f712W=7LFKA@mail.gmail.com>
 <457a91183581509abfa00575d0392be543acbe07.camel@perches.com>
 <CAKwvOdk4PRi45MXCtg4kmeN6c1AK5w9EJ1XFBJ5GyUjwEtRj1g@mail.gmail.com>
 <ccacb2a860151fdd6ce95371f1e0cd7658a308d1.camel@perches.com>
 <CAKwvOd=QkpmdWHAvWVFtogsDom2z_fA4XmDF6aLqz1czjSgZbQ@mail.gmail.com>
 <20200816001917.4krsnrik7hxxfqfm@google.com> <CA+icZUW=rQ-e=mmYWsgVns8jDoQ=FJ7kdem1fWnW_i5jx-6JzQ@mail.gmail.com>
 <20200816150217.GA1306483@rani.riverdale.lan>
In-Reply-To: <20200816150217.GA1306483@rani.riverdale.lan>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 17 Aug 2020 10:14:43 -0700
Message-ID: <CABCJKucsXufD6rmv7qQZ=9kLC7XrngCJkKA_WzGOAn-KfcObeA@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string.c: implement stpcpy
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 8:02 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Aug 16, 2020 at 07:22:35AM +0200, Sedat Dilek wrote:
> > On Sun, Aug 16, 2020 at 2:19 AM 'Fangrui Song' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> > >
> > > Adding a definition without a declaration for stpcpy looks good.
> > > Clang LTO will work.
> > >
> > > (If the kernel does not want to provide these routines,
> > > is http://git.kernel.org/linus/6edfba1b33c701108717f4e036320fc39abe1912
> > > probably wrong? (why remove -ffreestanding from the main Makefile) )
> > >
> >
> > We had some many issues in arch/x86 where *FLAGS were removed or used
> > differently and had to re-add them :-(.
> >
> > So if -ffreestanding is used in arch/x86 and was! used in top-level
> > Makefile - it makes sense to re-add it back?
> > ( I cannot speak for archs other than x86. )
> >
> > - Sedat -
>
> -ffreestanding disables _all_ builtins and libcall optimizations, which
> is probably not desirable. If we added it back, we'd need to also go
> back to #define various string functions to the __builtin versions.
>
> Though I don't understand the original issue, with -ffreestanding,
> sprintf shouldn't have been turned into strcpy in the first place.
>
> 32-bit still has -ffreestanding -- I wonder if that's actually necessary
> any more?
>
> Why does -fno-builtin-stpcpy not work with clang LTO? Isn't that a
> compiler bug?

I just confirmed that adding -fno-builtin-stpcpy to KBUILD_CFLAGS does
work with LTO as well.

Sami
