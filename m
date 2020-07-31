Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21532206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZe66L7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgGaO7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGaO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:59:07 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CB6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 07:59:07 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so17055432oiv.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=HT0VjPF40Ntd8YWFXRJUxrumgrtjSgN7H3boxsBygfs=;
        b=LZe66L7qtKUkrlivnJ9bVitlCJU96riM+uLHmUsBpa4vdY+2GPu4MeqdyfZoXADcRl
         a/SYozykGxYANMZA52S/d5hqDLPYaPxGyazE+UHdeuqzFHmpE/XLk1mKXrT0rELzsLE3
         CIHQtHgN2hq006n9prpsjRIFa7q/0lpwG4EbJeikpd47ILRijj07kw5jtpmduiqRKo9D
         EJCu2Hzm+T7jhYZT4MRoJoiUAvr6h0b7N5XsMBwrD6odxy6rj4Y42hUWTecwkhwaPC0d
         j0C6yBGqh3M74J2kxJPPrnGqF0iRXnm4E64p4ArqnmIewy0yYXpH2kfqzui+EkHmtytg
         Pq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=HT0VjPF40Ntd8YWFXRJUxrumgrtjSgN7H3boxsBygfs=;
        b=eoXSuumaBHG4KEq/mI3I+iPYTg3nq8uc1KkmeGWuoCCiKJ55XcPQaNV3JJCNT0PqFY
         nUioZoMsDb9rubCJ9R1GIXvvCmQNt8WBCxiNy7mhPTHQ1jV3IZgxwIcypNQv3LlNbXkl
         hNvcg1K8UjLiL4NjROrYWCwCiBUYdWhx8c0Bu/dHleS7hyeivOk8pIUK73xPoYVFfmFT
         WaIqE4vFJLtIaUL4J1cVqDz///x/lpU0sO+owSAD9+Kke+cotfqI/wBMXgQFwPSz4q8L
         EfKutX9c2KWKcCe8xgf9WEq5QHJF5Nq8O5vaZr2/LL/QmZX95xZpkGh8etQ0FS8/+vuo
         LaQA==
X-Gm-Message-State: AOAM531yLleTBncTQ8lVhpLY/dR13OPwphEWuFb0rBW39WTZ0Z+mIDvD
        yVDQKQA56M7WPA6+k2efwLBWr9rv4r3CWTWYyc4=
X-Google-Smtp-Source: ABdhPJzrV0t++E3bPTqL8ZiTW2PcgYIGkjB+rAt5d/1kruY8j0dPhwd6n1PrIErxy3RJdMCO7XWSeBxhkVed1hyiuiQ=
X-Received: by 2002:a05:6808:311:: with SMTP id i17mr3409866oie.72.1596207547007;
 Fri, 31 Jul 2020 07:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-1-nivedita@alum.mit.edu> <20200717134654.GA3187880@rani.riverdale.lan>
 <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
 <CAMj1kXGeSFXnuO7Y94pyBU9qfSgtsLvMoCZSfDk476BBs2ejcw@mail.gmail.com>
 <202007241624.D59FB48@keescook> <20200731145352.GA2076085@rani.riverdale.lan>
In-Reply-To: <20200731145352.GA2076085@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 31 Jul 2020 16:58:55 +0200
Message-ID: <CA+icZUV2=hj=+9DtbH47wtdE=GM5AZjS1xTgH7PKE+NxsRa2jw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 4:53 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Jul 24, 2020 at 04:25:20PM -0700, Kees Cook wrote:
> > On Sat, Jul 18, 2020 at 08:44:50AM +0300, Ard Biesheuvel wrote:
> > > On Fri, 17 Jul 2020 at 21:17, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Jul 17, 2020 at 6:46 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Tue, Jul 14, 2020 at 08:41:26PM -0400, Arvind Sankar wrote:
> > > > > > The compressed kernel currently contains bogus run-time relocations in
> > > > > > the startup code in head_{32,64}.S, which are generated by the linker,
> > > > > > but must not actually be processed at run-time.
> > > > > >
> > > > > > This generates warnings when linking with the BFD linker, and errors
> > > > > > with LLD, which defaults to erroring on run-time relocations in read-only
> > > > > > sections. It also requires the -z noreloc-overflow hack for the 64-bit
> > > > > > kernel, which prevents us from linking it as -pie on an older BFD linker
> > > > > > (<= 2.26) or on LLD, because the locations that are to be apparently
> > > > > > relocated are only 32-bits in size and so cannot really have
> > > > > > R_X86_64_RELATIVE relocations.
> > > > > >
> > > > > > This series aims to get rid of these relocations. I've build- and
> > > > > > boot-tested with combinations of clang/gcc-10 with lld/bfd-2.34, and
> > > > > > gcc-4.9.0 with bfd-2.24, skipping clang on 32-bit because it currently
> > > > > > has other issues [0].
> > > > > >
> > > > >
> > > > > Hi Thomas, Ingo, Borislav, would you be able to take a look over this
> > > > > series in time for 5.9?
> > > >
> > > > Hi Arvind, thanks for the series; I'm behind on testing.  When I try
> > > > to apply this series on top of linux-next, I get a collision in
> > > > drivers/firmware/efi/libstub/Makefile:27 when applying "0002
> > > > x86/boot/compressed: Force hidden visibility for all symbol
> > > > references". Would you mind refreshing the series to avoid that
> > > > collision?
> > >
> > > That is not the right way to deal with conflicts against -next.
> > >
> > > This series targets the -tip tree, and applies fine against it. If you
> > > want to apply it on some other tree and test it, that is fine, and
> > > highly appreciated, but 'refreshing' the series against -next means it
> > > no longer applies to -tip, and may be based on unidentified conflict
> > > resolutions performed by Stephen that the maintainers will have to
> > > deal with.
> > >
> > > Boris, Ingo, Thomas,
> > >
> > > Mind taking v5 of this series? (With Nick's Tested-by) I think these
> > > patches have been simmering long enough. Do note there is a conflict
> > > against the kbuild tree, but the resolution should be straightforward.
> >
> > I would love that; I need to rebase my orphan series on this too...
> >
> > --
> > Kees Cook
>
> Ping?

I just tested v5 against Linux v5.8-rc7 and the conflict you mention is with:

commit da05b143a308bd6a7a444401f9732678ae63fc70
x86/boot: Don't add the EFI stub to targets

If I forgot...
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -
