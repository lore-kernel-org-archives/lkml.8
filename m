Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BB5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB0B206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9qW9HTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgGaOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGaOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:53:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 07:53:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so28983847qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJ7CXsexIR3+9NabGND9XyABX4+Hw57eKjQc2Kl4LME=;
        b=A9qW9HTvWb5TMKIBHkwF+nHMq0EEp/M0lpNFJnRJhc+5+m20+yemUBtQ+blY79ZuPp
         pNCofC9u6kyF6/Fi98ATHwhiCraxftkHJuIsiDYUWQyVfJtpKKGugbQIsSZikdxfLh+K
         dczzXJm/kTUwaFUouAcgyxmxqq+Jkw6YfZ0I6r5Ca2E3FLWdJJElNf6ckc7MbkdWT30M
         KrbToNlaPtffRB3bkq+xpKmsDBpMywrLbP1zETaM6MR0vH+p/8OwjZ3+mq1d6/JDTOFm
         b/yMaJuHhLp/kBfku+JP5RrCip1++cJZwlqPkGujKdt1qcgjYizZBQbqVkeX5Cjqa8MH
         cZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CJ7CXsexIR3+9NabGND9XyABX4+Hw57eKjQc2Kl4LME=;
        b=poI5jl/0qvxXxuojP/R7lR0hoDBYa+duJtEdyr00mKnrX0ptzOtUEuSJ46XBQNGF8m
         nZusDDIEOlrhdFK4DGYj+n2zZOlt+zk6ubjcSeMsN8f1kZOYA9huXeW1NxhVy9b8d4S8
         ZUpMfltASci5HV+LUANvXfNtQVayd5lAcfYMNT8oupu4liko5zomHai8laCUp5cf6a4H
         bQEVcawP/JkjdkrCEUeYcqTvnhtpzKjGX3AmmxClRbcgoKhkaed301lw9YKakTNeDbKp
         gQ0HoJRQ9Bn14xMMVF/WSjm8U/Z22Wm1GVdk7mxLF07+66c4ZQuvev9T2ad0FvIVha7o
         35iw==
X-Gm-Message-State: AOAM532A9XYyLWCANySKeQoR2HhJPcpJIlJfZ1x8VbihyPBOXhb2vGZC
        dbnK4ZsOPYYbTn41fILJQ6E=
X-Google-Smtp-Source: ABdhPJyMQGUBWTQtLayJ0miwc05/cfZlgv+Ibu5+r4bjkAlTloh2VO4o5H6Lqadvfi2PIkh5nI6BHQ==
X-Received: by 2002:a05:620a:22ee:: with SMTP id p14mr4542341qki.223.1596207235574;
        Fri, 31 Jul 2020 07:53:55 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x29sm8713166qtv.80.2020.07.31.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 07:53:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 31 Jul 2020 10:53:52 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
Message-ID: <20200731145352.GA2076085@rani.riverdale.lan>
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-1-nivedita@alum.mit.edu>
 <20200717134654.GA3187880@rani.riverdale.lan>
 <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
 <CAMj1kXGeSFXnuO7Y94pyBU9qfSgtsLvMoCZSfDk476BBs2ejcw@mail.gmail.com>
 <202007241624.D59FB48@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007241624.D59FB48@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 04:25:20PM -0700, Kees Cook wrote:
> On Sat, Jul 18, 2020 at 08:44:50AM +0300, Ard Biesheuvel wrote:
> > On Fri, 17 Jul 2020 at 21:17, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Jul 17, 2020 at 6:46 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Tue, Jul 14, 2020 at 08:41:26PM -0400, Arvind Sankar wrote:
> > > > > The compressed kernel currently contains bogus run-time relocations in
> > > > > the startup code in head_{32,64}.S, which are generated by the linker,
> > > > > but must not actually be processed at run-time.
> > > > >
> > > > > This generates warnings when linking with the BFD linker, and errors
> > > > > with LLD, which defaults to erroring on run-time relocations in read-only
> > > > > sections. It also requires the -z noreloc-overflow hack for the 64-bit
> > > > > kernel, which prevents us from linking it as -pie on an older BFD linker
> > > > > (<= 2.26) or on LLD, because the locations that are to be apparently
> > > > > relocated are only 32-bits in size and so cannot really have
> > > > > R_X86_64_RELATIVE relocations.
> > > > >
> > > > > This series aims to get rid of these relocations. I've build- and
> > > > > boot-tested with combinations of clang/gcc-10 with lld/bfd-2.34, and
> > > > > gcc-4.9.0 with bfd-2.24, skipping clang on 32-bit because it currently
> > > > > has other issues [0].
> > > > >
> > > >
> > > > Hi Thomas, Ingo, Borislav, would you be able to take a look over this
> > > > series in time for 5.9?
> > >
> > > Hi Arvind, thanks for the series; I'm behind on testing.  When I try
> > > to apply this series on top of linux-next, I get a collision in
> > > drivers/firmware/efi/libstub/Makefile:27 when applying "0002
> > > x86/boot/compressed: Force hidden visibility for all symbol
> > > references". Would you mind refreshing the series to avoid that
> > > collision?
> > 
> > That is not the right way to deal with conflicts against -next.
> > 
> > This series targets the -tip tree, and applies fine against it. If you
> > want to apply it on some other tree and test it, that is fine, and
> > highly appreciated, but 'refreshing' the series against -next means it
> > no longer applies to -tip, and may be based on unidentified conflict
> > resolutions performed by Stephen that the maintainers will have to
> > deal with.
> > 
> > Boris, Ingo, Thomas,
> > 
> > Mind taking v5 of this series? (With Nick's Tested-by) I think these
> > patches have been simmering long enough. Do note there is a conflict
> > against the kbuild tree, but the resolution should be straightforward.
> 
> I would love that; I need to rebase my orphan series on this too...
> 
> -- 
> Kees Cook

Ping?
