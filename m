Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5886C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8607F2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGJgRmWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgGRHBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgGRHBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:01:50 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C084C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 00:01:50 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id h16so9158479ilj.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=G3+2PMnjGfEPvKZwINap3pBMr0humQvV1EidfwRspkE=;
        b=MGJgRmWLI/yCr8L+tTPNBdz7aXETmcq/KuTunrZ7MM/RtVNbtM1kVzV2Ocj4Le9g4R
         5rjvV3vNi0OOKH/d4BmvhSdYpupHCj7CITrBg0hsbQDnKqb32b26cxc9nJZR2Mh8yJld
         aZsoqC9bNDTbtwph9s/uTlb6IgpSsCdwnRbC14zcBhc4gB1+BrpB9QS9CDhCleHkUM58
         f9p9ijMCel6H73XyuWjHQEXc5j7fCmZImBbiTjNITo8HZ6L/IZbiRSge/1AEjoXvczwj
         SkTpJeGAAK/C0ZO07Och/SiAhNAz2S8G0l2leyyjqEWwKE9vdFwC9dckTG5ypMe8T2WJ
         6nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=G3+2PMnjGfEPvKZwINap3pBMr0humQvV1EidfwRspkE=;
        b=Hy97+WPOV7EGZpz4gmYc/p3EKhCnkDAMIoImSRYQbRyF34dNbrHN8fOSTRmlQaCT72
         YtybdIb4U4drUmwA5dyUwcqVQieVIUfQOfysZCSh6w65XZ2HalydjyudHMc9j210vfYs
         tJ5tRb30vqXc7HMPfAQLIPGbpHF7x7HdXSPE0GpOPNIZEU7WYXk7zyOaHwd5MXmZnI3W
         MNyBz36/LAgcrNRdpmRxE7vPLDSN/tEv5mrtL6SRVvF93BXx4spiXrfJiqWtkZfIxvro
         d/OLPbh+yDyv29n9dkAfeq51XjKqcw2K1Zt8Eftdl5afU8g35dW4agvQesIMo6Hr2xkP
         LYMA==
X-Gm-Message-State: AOAM533jvWBY6z/W03O/0iM/TLMf0ihwAiZAaJmhn36PewDXDV7j5m+Q
        7HwB6lz19J4teXu7O4XHb459kErA4EgbueDWcXo=
X-Google-Smtp-Source: ABdhPJzTdaUqfX6+DaVwna/a0uUxxpGuzkBXrND8TM0hx5x6k9cgR93I8MQu8Mk3vTUr/s7NdsZ/VqeVaDP9Z1ETbmc=
X-Received: by 2002:a92:8b11:: with SMTP id i17mr13130616ild.212.1595055709714;
 Sat, 18 Jul 2020 00:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-1-nivedita@alum.mit.edu> <20200717134654.GA3187880@rani.riverdale.lan>
 <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com> <CAMj1kXGeSFXnuO7Y94pyBU9qfSgtsLvMoCZSfDk476BBs2ejcw@mail.gmail.com>
In-Reply-To: <CAMj1kXGeSFXnuO7Y94pyBU9qfSgtsLvMoCZSfDk476BBs2ejcw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 18 Jul 2020 09:01:40 +0200
Message-ID: <CA+icZUUmMLGm+EhaMak6TmusJVufd_wEKzwSOMF4MVdxYKr1xQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
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

On Sat, Jul 18, 2020 at 7:45 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 17 Jul 2020 at 21:17, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Jul 17, 2020 at 6:46 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Jul 14, 2020 at 08:41:26PM -0400, Arvind Sankar wrote:
> > > > The compressed kernel currently contains bogus run-time relocations in
> > > > the startup code in head_{32,64}.S, which are generated by the linker,
> > > > but must not actually be processed at run-time.
> > > >
> > > > This generates warnings when linking with the BFD linker, and errors
> > > > with LLD, which defaults to erroring on run-time relocations in read-only
> > > > sections. It also requires the -z noreloc-overflow hack for the 64-bit
> > > > kernel, which prevents us from linking it as -pie on an older BFD linker
> > > > (<= 2.26) or on LLD, because the locations that are to be apparently
> > > > relocated are only 32-bits in size and so cannot really have
> > > > R_X86_64_RELATIVE relocations.
> > > >
> > > > This series aims to get rid of these relocations. I've build- and
> > > > boot-tested with combinations of clang/gcc-10 with lld/bfd-2.34, and
> > > > gcc-4.9.0 with bfd-2.24, skipping clang on 32-bit because it currently
> > > > has other issues [0].
> > > >
> > >
> > > Hi Thomas, Ingo, Borislav, would you be able to take a look over this
> > > series in time for 5.9?
> >
> > Hi Arvind, thanks for the series; I'm behind on testing.  When I try
> > to apply this series on top of linux-next, I get a collision in
> > drivers/firmware/efi/libstub/Makefile:27 when applying "0002
> > x86/boot/compressed: Force hidden visibility for all symbol
> > references". Would you mind refreshing the series to avoid that
> > collision?
>
> That is not the right way to deal with conflicts against -next.
>
> This series targets the -tip tree, and applies fine against it. If you
> want to apply it on some other tree and test it, that is fine, and
> highly appreciated, but 'refreshing' the series against -next means it
> no longer applies to -tip, and may be based on unidentified conflict
> resolutions performed by Stephen that the maintainers will have to
> deal with.
>
> Boris, Ingo, Thomas,
>
> Mind taking v5 of this series? (With Nick's Tested-by) I think these
> patches have been simmering long enough. Do note there is a conflict
> against the kbuild tree, but the resolution should be straightforward.

Agreed with that approach.

v5 misses also my credits - Tested-by for the whole series is sufficient.

- Sedat -
