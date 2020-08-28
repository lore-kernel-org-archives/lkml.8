Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B638DC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3082078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+FVf6O2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgH1MbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbgH1M2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:28:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9FC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:28:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so398186plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yn8qp0pF0/ymUX0XYVgXndiqVwNlWscX3zxb5Gz4UJU=;
        b=X+FVf6O2bFdGzHWCgjCVD7j07pWnLrK8pDEB5dJnuBAu/1F1HKyE/tVrR3DRtYNMya
         K2cxsdNeQTdW/cf8AxIBxcdnw/3Q5y1XGI5F1JUxfSwtfez0txiFW7IW40UV6G+R42/b
         yALQTnIGOqqF8ftT9SqLysAXjXYNyMLIqn1PvOg/NU801yPaSTppbr6uOiLwoMnOF8YO
         cHAqvsryqhxVYEwQAZu+2u11KG4AN/uIwiePYtMvXettO0NAy4QYXuwm6t8OVbQjGuwl
         VFLEJ/EFZOxdq76gNC+vdgubsan2Ta9NlfJfeSuu5sd1vZVPCP1349OMVHCsWM/mNP3C
         RKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn8qp0pF0/ymUX0XYVgXndiqVwNlWscX3zxb5Gz4UJU=;
        b=pJ6Een1NmzmkgEz4/QMt3EHXduD1n/2Vu+7pirbQErlGQsa5pxYsckTbqGvmZdGRiE
         ycPDYNxG0j+Xi1rYPEzqOL0Fqsqxw8WnCswxEGFwtFz3IRd0gpfZbTjZsiE3aACHdlvB
         +CFWRytjx16Dur5VV21gjG9xIE2b4+v6sHY6g5eXz5C3peFr7GrZBtlovIAoeFUlI8Ds
         JQM6UW2e+6oOWuWv5XWxelaEVPxFXBiZz33Ki3nveOLiXKwkrSQdNE81sbmgmUCKAmem
         9tCQEee9640rd9usBvXfKtWeiTqMi9b3QA4P+pozOpYhoOXpwO0eWyf+fsLgN9MHtQOz
         gkjQ==
X-Gm-Message-State: AOAM532seXKvFfEJZno0vaMy9mFVJjV/qrN7NT/BW+YF6epmraOyifTB
        k4ap43bHX3c75XCDvYlkn+DdjXzuGS2/xJWTAzmPBg==
X-Google-Smtp-Source: ABdhPJzVZkYCWWsHu7+PNcR14S9/KpmQmb3zA6Q9/eo/rw8us10i1Vm/2ObVdHhvBAhwplZzBagcUgtxDPrC1liV4rI=
X-Received: by 2002:a17:90a:a791:: with SMTP id f17mr1015324pjq.136.1598617714338;
 Fri, 28 Aug 2020 05:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <5d0f3c0ee55c58ffa9f58bdea6fa6bf4f6f973a4.1597425745.git.andreyknvl@google.com>
 <20200828111221.GA185387@elver.google.com>
In-Reply-To: <20200828111221.GA185387@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 28 Aug 2020 14:28:23 +0200
Message-ID: <CAAeHK+zpKXQT4-6CfVt1BfXr=SdYjWjhMR_0yV4Wncbz7Aq73w@mail.gmail.com>
Subject: Re: [PATCH 35/35] kasan: add documentation for hardware tag-based mode
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 1:12 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, Aug 14, 2020 at 07:27PM +0200, Andrey Konovalov wrote:
> > Add documentation for hardware tag-based KASAN mode and also add some
> > clarifications for software tag-based mode.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  Documentation/dev-tools/kasan.rst | 73 +++++++++++++++++++++----------
> >  1 file changed, 51 insertions(+), 22 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> > index a3030fc6afe5..aeed89d6eaf5 100644
> [...]
> > -Tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64 CPUs to
> > -store a pointer tag in the top byte of kernel pointers. Like generic KASAN it
> > -uses shadow memory to store memory tags associated with each 16-byte memory
> > -cell (therefore it dedicates 1/16th of the kernel memory for shadow memory).
> > +Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64
> > +CPUs to store a pointer tag in the top byte of kernel pointers. Like generic
> > +KASAN it uses shadow memory to store memory tags associated with each 16-byte
> > +memory cell (therefore it dedicates 1/16th of the kernel memory for shadow
> > +memory).
>
> It might be helpful to be more specific vs. saying "modern arm64 CPUs".
> Does the "modern" qualifier suggest not all arm64 CPUs support the
> feature?  (HW tag-based KASAN below is specific, and mentions ARMv8.5.)

Will clarify this in v2.

> > +On each memory allocation software tag-based KASAN generates a random tag, tags
> > +the allocated memory with this tag, and embeds this tag into the returned
> > +pointer.
> >
> > -On each memory allocation tag-based KASAN generates a random tag, tags the
> > -allocated memory with this tag, and embeds this tag into the returned pointer.
> >  Software tag-based KASAN uses compile-time instrumentation to insert checks
> >  before each memory access. These checks make sure that tag of the memory that
> >  is being accessed is equal to tag of the pointer that is used to access this
> > -memory. In case of a tag mismatch tag-based KASAN prints a bug report.
> > +memory. In case of a tag mismatch software tag-based KASAN prints a bug report.
> >
> >  Software tag-based KASAN also has two instrumentation modes (outline, that
> >  emits callbacks to check memory accesses; and inline, that performs the shadow
> > @@ -215,9 +222,31 @@ simply printed from the function that performs the access check. With inline
> >  instrumentation a brk instruction is emitted by the compiler, and a dedicated
> >  brk handler is used to print bug reports.
> >
> > -A potential expansion of this mode is a hardware tag-based mode, which would
> > -use hardware memory tagging support instead of compiler instrumentation and
> > -manual shadow memory manipulation.
> > +Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses aren't
> > +checked).
> > +
> > +Software tag-based KASAN currently only supports tagging of slab memory.
> > +
> > +Hardware tag-based KASAN
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Hardware tag-based KASAN is similar to the software mode in concept, but uses
> > +hardware memory tagging support instead of compiler instrumentation and
> > +shadow memory.
> > +
> > +Hardware tag-based KASAN is based on both arm64 Memory Tagging Extension (MTE)
> > +introduced in ARMv8.5 Instruction Set Architecture, and Top Byte Ignore (TBI).
>
> Is there anything inherently tying tag-based KASAN to arm64?

Not really, the approach is generic and can be used by any arch that
supports memory tagging.

> I guess if
> some other architecture supports MTE, they just have to touch arch/,
> right?

For the most part - yes, but maybe adjustments to the generic code
will be required. No way to know before one tries to integrate another
arch.

> You could reword to say that "Hardware tag-based KASAN is currently only
> supported on the ARM64 architecture.
>
> On the ARM64 architecture, tag-based KASAN is based on both ..."

Will do in v2, thanks!
