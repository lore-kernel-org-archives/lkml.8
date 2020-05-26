Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FACEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2998206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtxbLmei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgEZPjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEZPjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:39:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AABC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:39:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s18so8526787ioe.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=4ZIKnaG5waGw7rdcggFZ4Qkg+MYDijQCP6NqwMYy6bU=;
        b=HtxbLmeirDZPitp0aO6eatzB4nFgaIGEhMNohJaH2zQrxv6q7z4VLcgUmv4/3zx/EP
         oz2svdj3WA4JU1Slki0vVh1LotC8ZuHheZ3Cdw69g9rKLMeNGerxnxbwJDaawTe/VtsY
         7C48BYfhOkur2cN9WHfIWciR1J+/v+5gZyivKfr9N7n83ey++bzr0ZW8I9hoH7aGO1ZC
         3cidnz9Lb9niHoIkpr2V+CciXirwkTQiWLdwjrznn4DLcGMp3k6V9h/T/hFZwQI2+WwC
         cpbnf+LelZbsDPkFBJeIXSXlWRUmh9hs7C2jHXx6aB+zdHM/YoiH3bZQT+hQrQGdkdVm
         97EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4ZIKnaG5waGw7rdcggFZ4Qkg+MYDijQCP6NqwMYy6bU=;
        b=JDx0S0ySV92PYz4Me2qpd2TYwKFgq7yy4rp4KCQi4mpaKodqNTROJIxf4SAMdxBGgo
         6gw5IK+fA3T4V1BIKRBVZhhwVvzAlZsvskoLdOlS1cA7Nu0rvOqW62y+qhR8z8skFNLJ
         ccJiE3X8PR1SYrvXXbJFQZ0PrOiF46bc7DKJRJzm9u6k5HQCGD0RHaUEatIN9RSqMpRB
         8bIEVvVYU9mJrfmDr/ainVCwCleK7OANSL98lCCN8Zfk9mSeJ4Ny/0EENDS1i6JzOEt7
         iRm9MVL18fb5evVFEGeLo1ESSbdCC+loXSin15pqSmMZbzHw/WIdnzFH660iuizDgopa
         elIw==
X-Gm-Message-State: AOAM5330GXGShFoZnz2XwRsoC/d4kfb3oVlTXcQtAC+KwRnpibmaCCWH
        dc1EzTMjhVSXAyIhCsrdf1MQz9V8zA3S0wUdlwg=
X-Google-Smtp-Source: ABdhPJz65e5oUPUUhLjZsGgE6BuEfXrtMuNjPyRxNBJaviJIh4B+96XtUW73uRFqlrOr6eXQxUWrABOhQa8YMAeLfzU=
X-Received: by 2002:a05:6602:2f06:: with SMTP id q6mr17415978iow.135.1590507541222;
 Tue, 26 May 2020 08:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu> <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
 <20200526144748.GA2190602@rani.riverdale.lan> <CA+icZUUY7a5XGwcQQ511OeoTjOzWbrgF8BZdTrLDK09QWG4hwQ@mail.gmail.com>
 <20200526153636.GD2190602@rani.riverdale.lan>
In-Reply-To: <20200526153636.GD2190602@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 26 May 2020 17:38:50 +0200
Message-ID: <CA+icZUUtdT+zV7Y9LM9qRxUSVPuOsf2EQMToLdF-fwrageWpKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 5:36 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, May 26, 2020 at 04:50:38PM +0200, Sedat Dilek wrote:
> > On Tue, May 26, 2020 at 4:47 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, May 26, 2020 at 02:44:29PM +0200, Sedat Dilek wrote:
> > > >
> > > > Are those diffs correct when using "x86/boot: Correct relocation
> > > > destination on old linkers"?
> > > >
> > >
> > > It looks ok, but that patch (and even marking the other symbols .hidden)
> > > should be unnecessary after this series.
> >
> > You mean _bss, _ebss and _end?
> >
> > - Sedat -
>
> Yes. Those .hidden markings are there to ensure that when relocations
> are generated (as they are currently), they're generated as
> R_386_RELATIVE (which uses B+A calculation, with A being the link-time
> virtual address of the symbol, and stored in the relocation field)
> rather than R_386_32 (which uses S+A calculation, and so doesn't work
> without runtime processing). After this patchset there aren't any
> relocations, so while the .hidden markings won't hurt, they won't be
> necessary either.
>

So, I am here on Debian/testing AMD64.

How can I test the patchset worked correctly?

- Sedat -
