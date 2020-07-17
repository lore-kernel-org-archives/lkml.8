Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01665C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C933920717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxLHHdlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGQSRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:17:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE6C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:17:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so7080296pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBlDJFELNKgax0cjAHRAVjejfx/TTQsomiVQoBjL7ks=;
        b=bxLHHdlAY9eene1CvhhSCw9YTxQwX3eKCVv9iTe1Xjm+fSJKVJlBdfmF9vsb4MmJOs
         NEuJzywR0eANfT0z9SZtH7CZ+/6XKVOVivsGtsx2Rh2v6EG3cp8zXyPrUza4YZADBWTz
         vGYEJLcZLwE9AG6JcEoJBkaGvqoNgNTb/k8L3YTjqtbLXYDuKT8ZI6snpjCZY+CMjTTh
         sl4vuKdQjyFAcVuTZm2VPKZqMFUNJ8Hft5jMcn8td4zNzu0xpFssqM4f9HhxRPtUOPov
         NRQLWkLfBeWPaoqJl+F798mBQ9Dnd/LQ5w6F2GkVZ3fFshaScseaVuI7+xLwb46ARPaZ
         KbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBlDJFELNKgax0cjAHRAVjejfx/TTQsomiVQoBjL7ks=;
        b=qkwAv079ZyCzdHsTvCGdYW57A5KJLb3TjQQHaySpGhhD1AiE8T33ziG40WDS0xnTAF
         PmAdBojCaWzjzc011sHp3UyWx5Mn3LwRx6b3d5VwBUwyV1gSQZbgI8R0J8/Fr2RqDD6W
         lT/F9AYoZBM+pGnvCnxm1C9QVG4a+sCjK5C3ZRqoAA+zZNfG78p1yQEZlO81fTYhQb8r
         YUem0jFFEwq9KUdGsY+sRKbhwh0XGCIgsBrdEBj9/RVuXH21d/t19gzi/g/RFiMe2ona
         qbqzCbXAANfdgBqcd6U2VirnPuldNNeD1/7vlAezS6+eDZIYDmPScfFP0sMEXphePMpR
         OWNg==
X-Gm-Message-State: AOAM533rvd7+aNLp4pPVXd3dU40PCahyhxuKq7s+tEehwbz9wwsQAwsH
        B1ofWWhdG5Q6yuu+eSp4cUJfkHNoQWL/+j+8cw2O5w==
X-Google-Smtp-Source: ABdhPJybiEs4j8cKyv1rMOc1Gx7gNajlNveE0QzmIl6wfNAJ1FzzpA8QTOPOm9B9X3qyh5sCEuRppZOkpzxCn9KXteo=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr9210298pfu.169.1595009827674;
 Fri, 17 Jul 2020 11:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-1-nivedita@alum.mit.edu> <20200717134654.GA3187880@rani.riverdale.lan>
In-Reply-To: <20200717134654.GA3187880@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Jul 2020 11:16:56 -0700
Message-ID: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
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

On Fri, Jul 17, 2020 at 6:46 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jul 14, 2020 at 08:41:26PM -0400, Arvind Sankar wrote:
> > The compressed kernel currently contains bogus run-time relocations in
> > the startup code in head_{32,64}.S, which are generated by the linker,
> > but must not actually be processed at run-time.
> >
> > This generates warnings when linking with the BFD linker, and errors
> > with LLD, which defaults to erroring on run-time relocations in read-only
> > sections. It also requires the -z noreloc-overflow hack for the 64-bit
> > kernel, which prevents us from linking it as -pie on an older BFD linker
> > (<= 2.26) or on LLD, because the locations that are to be apparently
> > relocated are only 32-bits in size and so cannot really have
> > R_X86_64_RELATIVE relocations.
> >
> > This series aims to get rid of these relocations. I've build- and
> > boot-tested with combinations of clang/gcc-10 with lld/bfd-2.34, and
> > gcc-4.9.0 with bfd-2.24, skipping clang on 32-bit because it currently
> > has other issues [0].
> >
>
> Hi Thomas, Ingo, Borislav, would you be able to take a look over this
> series in time for 5.9?

Hi Arvind, thanks for the series; I'm behind on testing.  When I try
to apply this series on top of linux-next, I get a collision in
drivers/firmware/efi/libstub/Makefile:27 when applying "0002
x86/boot/compressed: Force hidden visibility for all symbol
references". Would you mind refreshing the series to avoid that
collision?
-- 
Thanks,
~Nick Desaulniers
