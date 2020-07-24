Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4DBC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3BB2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyEZsYF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGXXZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgGXXZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:25:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9214C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:25:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t10so79349plz.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=li+CahyCqWbTts12ZkfxMqZXwJr2YlzPWYeFNg4b+Nw=;
        b=JyEZsYF4UFKqU6qCEUZWNSHx5ly7XbnSqAgGcpPeYmkxRz6pXDFM56YK4Vves3QrOA
         TbSI04VOCN6ylDJOjG0w5XYqEehBYBgu0/WU6uRhiu+Rf6ZXq8TJ6PcUZe6+M4DVaDG3
         2pHBdPtOGa90gyh41LpiJK3VG7G5TTd2H4d9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=li+CahyCqWbTts12ZkfxMqZXwJr2YlzPWYeFNg4b+Nw=;
        b=YVrlzUgbz8MzS5vBG8Y/fM9S3TE4NMhY0ZUVbcEQmUVbujisLVhQeZPG1Bj5Jmq/HX
         x4mgdMkOiQv8ynQbaqVPWmVaJjkwpeRh3dV1msFwd35oUITHp8HuyLbvFT9/NyKhnMSE
         JGwag6e3NufXyFakluZg8ToYJMA8+NLvmXbcc0rktMs+yqKuW5W5Yf9h9/TwfmXYfvcn
         g2EYoUC8TIvG5D0BcxCLGNAPzm+69SOY6hjQpHz0sN3BdCk/VwFahTzMCEBZhy4+1x/W
         adtwuCNfEFrAcrVeTCGTH6XbqACy1ChV+lcI5b3xWTBAylMFTY7mFVf4V9dgC9FAQDbu
         3bmA==
X-Gm-Message-State: AOAM533dN6hLvlHh2S8jbESTSbQQ7OZGC3ZZgDzRGiSQr+UrcB9RJ3zz
        oO+l8nrIOr9MWLvM+2rIw8mlyw==
X-Google-Smtp-Source: ABdhPJwRi2+G5TzZvhcQgoBydSnsMWDGcMkpFcfdHxP7IIXoomEjvPueYN9DrXjmqTjMp0tVIQ7n0g==
X-Received: by 2002:a17:902:eb49:: with SMTP id i9mr9617482pli.231.1595633123476;
        Fri, 24 Jul 2020 16:25:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r17sm7478205pfg.62.2020.07.24.16.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 16:25:22 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:25:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
Message-ID: <202007241624.D59FB48@keescook>
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-1-nivedita@alum.mit.edu>
 <20200717134654.GA3187880@rani.riverdale.lan>
 <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
 <CAMj1kXGeSFXnuO7Y94pyBU9qfSgtsLvMoCZSfDk476BBs2ejcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGeSFXnuO7Y94pyBU9qfSgtsLvMoCZSfDk476BBs2ejcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 08:44:50AM +0300, Ard Biesheuvel wrote:
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

I would love that; I need to rebase my orphan series on this too...

-- 
Kees Cook
