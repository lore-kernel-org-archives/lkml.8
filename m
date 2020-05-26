Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAE7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83D0206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHWbf7Wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbgEZQIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgEZQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:08:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C017C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:08:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k22so8859825pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTyuk3oWFBmxwvB6ngXRDL+X9/MYc3CApnCwn/T5TSU=;
        b=FHWbf7Wvjx5PdFz1RG7GNaycGzbTIS84kShvUC8ttI3+RmlxdUuXD1p5owVRaFhTB6
         3tY/uF5IwyOh8mW2SAjJgmIIyM2+lCY6pDZeVJS/723twN1Gz7uEeBGd3V2K9LJC/tmw
         CQeGteduJXQDsPw46eMazXB9C6kbV0Et9ePdVy+qS0kZLQ2QrLOyA3BxQbojCmFnxxXJ
         +huUHYV1OZwVexvCRpVdPHtxlaEKDqdLtntbci/1NuUVYwQBD1eZ+l+MeoL/td7mGY8h
         Hj0ranoD0nm4/MxLjwGWGljYNsivM5nRfjxsmSMLQDG+EFmhjkGEg3QUi1X9h0hpDisq
         8UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTyuk3oWFBmxwvB6ngXRDL+X9/MYc3CApnCwn/T5TSU=;
        b=IDlO4K1jNCkxMlcekqr2NIfyywCMQGEXDuBeHDRkFJa4LHMGVFHDMXOQDOah4ytsjY
         JAUI59yu0L0+f9bTQ/R8eX0GxjMu5aF4Mwj1M+jrlpdpgr1a+KWEmKD7RIAb1uISit48
         ggCeHwlWvz3eJ7+EbAqggJdXv/mQu9BI7E8BchwgMo6YyvwEgmoKU7LWT2ArqkZgvyW3
         D22KIvtQPSiJMhpriLYPlhoDuemFpAbaK56h74fYCLlXCbEkE3UcYEYMWiZjMRw1NEk3
         +x3MFYFMo8GMOEc0jrvsMpayM1Aop7u1zjwmZRT9Y5Rim02vWEu3xZ8im3BYFFwTruox
         Mysw==
X-Gm-Message-State: AOAM532ET1Yf0rGgirQ4LkBlfbVoIi/Z6emfFOxaWK6gv8m3ed3XfQ7V
        WnxBconHDUyY8Pli7IzC0B1QogUlZgdsb+sF2MoPGw==
X-Google-Smtp-Source: ABdhPJxca/yviUIiH1otzrRCE374xvJoLYTTpyP5fD+KqaIP77dq9VyQxHvKVkl3mNCY2b7BrIfczonL/KQ+kXSRQyY=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr27972131pjb.101.1590509324637;
 Tue, 26 May 2020 09:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200526153004.GA74229@roeck-us.net> <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
 <8c5f8a2c-0ca2-b2f2-4278-d02198d4dd8d@roeck-us.net>
In-Reply-To: <8c5f8a2c-0ca2-b2f2-4278-d02198d4dd8d@roeck-us.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 May 2020 09:08:33 -0700
Message-ID: <CAKwvOd==CjrmNcDSEWa3hs4WWPecJorY5txG4T4FsFODhaa2sA@mail.gmail.com>
Subject: Re: [PATCH] compiler/gcc: Raise minimum GCC version for kernel builds
 to 4.8
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Will Deacon <will@kernel.org>, Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 9:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi Nick,
>
> On 5/26/20 8:40 AM, Nick Desaulniers wrote:
> > On Tue, May 26, 2020 at 8:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
> >>> It is very rare to see versions of GCC prior to 4.8 being used to build
> >>> the mainline kernel. These old compilers are also known to have codegen
> >>> issues which can lead to silent miscompilation:
> >>>
> >>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >>>
> >>> Raise the minimum GCC version to 4.8 for building the kernel and remove
> >>> some tautological Kconfig dependencies as a consequence.
> >>
> >> My hexagon compiler is v4.6.1, and I have been unable to find a more
> >> recent version. Does anyone happen to have a pointer to a hexagon toolchain
> >> with gcc 4.8 or later ?
> >
> > IIUC, hexagon moved to LLVM, though that target still has issues
> > building the kernel.
> > https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+hexagon%22
> >
>
> That won't help me for my build tests. It is bad enough having to maintain
> one compiler. I don't want to add another one to the mix, and I'll happily
> leave llvm build tests for ClangBuiltLinux. Guess I'll have to stop hexagon

:( We could use the additional test coverage.

> test builds starting with 5.8.
>
> Guenter



-- 
Thanks,
~Nick Desaulniers
