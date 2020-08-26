Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B18C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFE52074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oWdw0mdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHZXi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgHZXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 19:38:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDEFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 16:38:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i10so2014080pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 16:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eV0GIFTuiQm5ErvJErExla4nXTXonFJmiqihB7uxsxA=;
        b=oWdw0mdhenNP0Kp9CO9VlhW09fLxGT/6X+7SHhz2uayWEyNL/Vnc3PBeVFddFpiaRM
         LTO9BDu0Fxxo9ACmYQxY+7JKZJ3Ug1oElwA/9/SHlY/NsQos1Zf7SpE7xtTVUNl8A676
         xWnmltHKbF6Ew/pSpxGpxOBVCOAxnGl1uL8uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eV0GIFTuiQm5ErvJErExla4nXTXonFJmiqihB7uxsxA=;
        b=ppsDnlg3NlGDWKDfv6Ntdev+vb0SvUHKjC1vfwyh8VwMG/KvPJFX+q4SeRCBiyLmhY
         EW4V2JMp8rdC/CNZYpfuQJaWlVXaoJK+0L1NOv7ieBIBI4mvCRXl+k5jXlKerBz0x186
         JxbzB1kofe/MtCnXOpmZtOXL14+fUcd3jQzxUyRf8H/KQWw1y1a5FWJW9NHjYzLepo+3
         1iKKaQyPhc4m1lCvjnhWMClq1W3T2m/cQeVZTXnSSRTNHBIhEUvMnQrnBqC9pkP3OhXt
         2JLaT5ipk7lLhhwxPkyq5kC0Pie1kpax/X2dwIPHU0GShHn5qh7u673RrkcDj4aq+mO9
         4zAg==
X-Gm-Message-State: AOAM531qNl2xO0l34NxKj2C6b0XhJk04rPBdypHibKn1N9JMJcnWxEwP
        wbDRDCLnpdna25VCJIvOkvSJ2A==
X-Google-Smtp-Source: ABdhPJyTVEbRBoVBR8TxoOepzs7FJi44uf9SoY94TFXDyY1fdhabQ/kXpMnm7aew3isQ5l2r0I2RGA==
X-Received: by 2002:a63:4451:: with SMTP id t17mr11449209pgk.92.1598485105726;
        Wed, 26 Aug 2020 16:38:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g129sm295099pfb.33.2020.08.26.16.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 16:38:24 -0700 (PDT)
Date:   Wed, 26 Aug 2020 16:38:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>, Andy Lavr <andy.lavr@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lib/string.c: implement stpcpy
Message-ID: <202008261627.7B2B02A@keescook>
References: <20200825135838.2938771-1-ndesaulniers@google.com>
 <CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com>
 <d56bf7b93f7a28c4a90e4e16fd412e6934704346.camel@perches.com>
 <CAKwvOd=YrVtPsB7HYPO0N=K7QJm9KstayqqeYQERSaGtGy2Bjg@mail.gmail.com>
 <CAK7LNAQKwOo=Oas+7Du9+neSm=Ev6pxdPV7ges7eEEpW+jh8Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQKwOo=Oas+7Du9+neSm=Ev6pxdPV7ges7eEEpW+jh8Ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:59:45AM +0900, Masahiro Yamada wrote:
> On Thu, Aug 27, 2020 at 1:58 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Aug 26, 2020 at 9:57 AM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Thu, 2020-08-27 at 01:49 +0900, Masahiro Yamada wrote:
> > > > I do not have time to keep track of the discussion fully,
> > > > but could you give me a little more context why
> > > > the usage of stpcpy() is not recommended ?
> > > >
> > > > The implementation of strcpy() is almost the same.
> > > > It is unclear to me what makes stpcpy() unsafe..
> >
> > https://lore.kernel.org/lkml/202008150921.B70721A359@keescook/
> >
> > >
> > > It's the same thing that makes strcpy unsafe:
> > >
> > > Unchecked buffer lengths with no guarantee src is terminated.
> >
> 
> 
> OK, then stpcpy(), strcpy() and sprintf()
> have the same level of unsafety.

Yes. And even snprintf() is dangerous because its return value is how
much it WOULD have written, which when (commonly) used as an offset for
further pointer writes, causes OOB writes too. :(
https://github.com/KSPP/linux/issues/105

> strcpy() is used everywhere.

Yes. It's very frustrating, but it's not an excuse to continue
using it nor introducing more bad APIs.

$ git grep '\bstrcpy\b' | wc -l
2212
$ git grep '\bstrncpy\b' | wc -l
751
$ git grep '\bstrlcpy\b' | wc -l
1712

$ git grep '\bstrscpy\b' | wc -l
1066

https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
https://github.com/KSPP/linux/issues/88

https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
https://github.com/KSPP/linux/issues/89

https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
https://github.com/KSPP/linux/issues/90

We have no way right now to block the addition of deprecated API usage,
which makes ever catching up on this replacement very challenging. The
only way we caught up with VLA removal was because of -Wvla on sfr's
-next builds.

I guess we could set up a robot to just watch -next commits and yell
about new instances, but patches come and go -- I worry it'd be noisy...

> I am not convinced why only stpcpy() should be hidden.

Because nothing uses it right now. It's only the compiler suddenly now
trying to use it directly...

-- 
Kees Cook
