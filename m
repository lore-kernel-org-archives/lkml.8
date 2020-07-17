Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD62206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+B1FN5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGQSVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:21:25 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB1C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:21:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l17so11376802iok.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3BZIZFFWoflh+aCDXlOZJ2oTKuNvfj+cVytvkYsY/sw=;
        b=i+B1FN5sfEO2JO9mjOHGAiDaKC/nW0OgUp/t1+69iSYVjdeyNRltLCBtFwhn4ddP2a
         zOJVCdAdngjvA78h9yJHASGP7gJfhkfDYdcLGIOCeCNKiluR5J9tHzkIAx8km7j/A+xO
         Hoo5NFdS2nXai3EJFSgi/hu9Xd1UcPkuCgco9YBa65IazvlkXrijzalxxD6dxeEIbflU
         IQHyZ/wR6oocqbmgOIQNepjp8DNeovmr+lFHb+G0a7fRMF8QoLWDVvUYD2K8T54YcwoR
         LTRw3yglABzPs7FUue1Ab4g0+i8JIh2wkKWs02114SqmHVqVi9VLXSsx7GKhEGcvD147
         6xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3BZIZFFWoflh+aCDXlOZJ2oTKuNvfj+cVytvkYsY/sw=;
        b=ogZJy5tIdjqRc/q+E5EQJr1MHF5v/uos91hLJhYWeQ5sb6BVv4yNnlWYGamDG+3seh
         xf26C8GIQzIMjCiM4oNLut7ZxcDf+EAj655upWyqIx1i4HC1/Jx1vQqme9foQUCEYj9R
         B+kZy4XjwpuiXDgC3spLW5U6ftX1MpXdV7cqVHueKvwb/PZFtLzddWimSNPjej5+ywEG
         gNciiB6c9JBJVBGuBNq9oassg5vc5IoPyXR+mije90iVJaNmYrvkS828E6Gfc6szSvIW
         LwY8d15XZNV8tvHUdEx7v6/roWMG2Qqt75ZTdEeVHxxUqoQOGMoxVJnFgZqRVEzVoTMG
         5CRw==
X-Gm-Message-State: AOAM533gG/9FD9JyAkSq1nb4XkZZrQmD2URRBiO+bm3QqInHPet7uFi0
        tAVpG/+PgCyTP79pEcfwH29Xb64W3c9L9mIkPLk=
X-Google-Smtp-Source: ABdhPJy4YkCpGbclYNUSLg9DK7bhX6/BwVjEl5UosNsBMzslhwjwMHZlLBYZ7I2+xBw3oxYA+REgm2aHqgHNwwSJeKk=
X-Received: by 2002:a5e:9309:: with SMTP id k9mr10687234iom.135.1595010084329;
 Fri, 17 Jul 2020 11:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-1-nivedita@alum.mit.edu> <20200717134654.GA3187880@rani.riverdale.lan>
 <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
In-Reply-To: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Jul 2020 20:21:12 +0200
Message-ID: <CA+icZUUxE=+yq-NPitRBwJ-92cqEP6TXdf=kRiLTN09UQUAi2Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 8:17 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jul 17, 2020 at 6:46 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jul 14, 2020 at 08:41:26PM -0400, Arvind Sankar wrote:
> > > The compressed kernel currently contains bogus run-time relocations in
> > > the startup code in head_{32,64}.S, which are generated by the linker,
> > > but must not actually be processed at run-time.
> > >
> > > This generates warnings when linking with the BFD linker, and errors
> > > with LLD, which defaults to erroring on run-time relocations in read-only
> > > sections. It also requires the -z noreloc-overflow hack for the 64-bit
> > > kernel, which prevents us from linking it as -pie on an older BFD linker
> > > (<= 2.26) or on LLD, because the locations that are to be apparently
> > > relocated are only 32-bits in size and so cannot really have
> > > R_X86_64_RELATIVE relocations.
> > >
> > > This series aims to get rid of these relocations. I've build- and
> > > boot-tested with combinations of clang/gcc-10 with lld/bfd-2.34, and
> > > gcc-4.9.0 with bfd-2.24, skipping clang on 32-bit because it currently
> > > has other issues [0].
> > >
> >
> > Hi Thomas, Ingo, Borislav, would you be able to take a look over this
> > series in time for 5.9?
>
> Hi Arvind, thanks for the series; I'm behind on testing.  When I try
> to apply this series on top of linux-next, I get a collision in
> drivers/firmware/efi/libstub/Makefile:27 when applying "0002
> x86/boot/compressed: Force hidden visibility for all symbol
> references". Would you mind refreshing the series to avoid that
> collision?
>

I guess taking a Linux-next release as a new base is not a good idea.
With the next Linux-next release... new troubles.
Please, keep the base on recent Linux v5.8-rcX.

- Sedat -
