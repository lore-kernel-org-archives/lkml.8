Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD251C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A362081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axDANLEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgAOW4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:56:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52824 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAOW4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:56:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so1780188wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 14:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOruGbo3ihqEelkLm7kTR9rgnvVG+704WzoO70mY5DI=;
        b=axDANLEvzn0+6KXIOulqklysHdcGJXxnHb8JFp+eDXmTC2DBKPTAF1YZQggw7kJy3M
         r3ahq3WMS9unizcJC8lG9qFEUrpjG/5zsxS9aCzx1LiZKtWCtWETSeG0GN4eyg0L8QdN
         ddsCQ4rCnL+pjf6u9qy5oC4pm9GDYhicASpg1IQw7r9VP9sdoXmslO1qJj9AvFJjUsaK
         kRkB9xMqMtgWwl6Ca89Ztyw1N1z4bli+Zvq8sf00pSvQhZxEMmWch64m4oKN+WY31sCW
         MPJnVQddMYd65MgLX6KIG6CSJ7n9j14+AWFxXlIiADGD6Ckb1rz6YD97zZobOQV2cDdB
         m0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOruGbo3ihqEelkLm7kTR9rgnvVG+704WzoO70mY5DI=;
        b=OHchzOmJ7z17i5uQvAWvqvlSFibFu6mkhw21f6eZG/CcfYuZ4/u8vU7EN2UnrqgCuQ
         CI/Vf80Lud5Mpaw2bGcUGRHw6NwguaOvDOMDLuYg7bNiJfrlAxzM3mtjkshAzDculMaH
         +CMLAEOiKsrTzSg9qeK4nB1kne7uHVEcH2iu4LqcG54qYzMU0v2syA/siEiU7cWEc7Zz
         LnrSMk9zkJ6/tC0Tek7I2oZFyqrBt1ZPVcYUIKDgnmJ2dt/E0lF1D0AzHxDjcmjVEXtb
         J8URU3XmDzP6QtgknJEYl6U8SScSSN6UETMWHHNF8zT04DEGMQn7Dd7iZ4iSDbJMzY0v
         0TDg==
X-Gm-Message-State: APjAAAVNfqHC1rc9anxWAPuH7erifgZzVI22OAJu2Fam1gdU2JDhN6G1
        E86AKAaXamqdOWOk9/ROF5HMjC1A8QW3xBhBiI977Q==
X-Google-Smtp-Source: APXvYqxj8YNDlGv+pawLENmpumCqEjab5rwVbWmYyrD3AYTvRqCIvB6NM4qMMYjWMz6W7FsZ+HEy0Kx2vl5LVgnpZu8=
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr2576689wma.79.1579129010626;
 Wed, 15 Jan 2020 14:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com> <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
In-Reply-To: <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Wed, 15 Jan 2020 14:56:39 -0800
Message-ID: <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        aryabinin@virtuozzo.com, dvyukov@google.com,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:48 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
> Couple questions, if you don't mind.
>
> > +#ifdef CONFIG_X86_64
> > +#define KASAN_SHADOW_SIZE 0x100000000000UL
> > +#else
> > +#error "KASAN_SHADOW_SIZE is not defined in this sub-architecture"
> > +#endif
>
> Is it even possible today to compile ARCH=um on anything but x86_64? If
> yes, perhaps the above should be
>
>         select HAVE_ARCH_KASAN if X86_64
>
> or so? I assume KASAN itself has some dependencies though, but perhaps
> ARM 64-bit or POWERPC 64-bit could possibly run into this, if not X86
> 32-bit.
>

This seems like a good idea. I'll keep the #ifdef around
KASAN_SHADOW_SIZE, but add "select HAVE_ARCH_KASAN if X86_64" as well.
This will make extending it later easier.

> > +++ b/arch/um/kernel/skas/Makefile
> > @@ -5,6 +5,12 @@
> >
> >  obj-y := clone.o mmu.o process.o syscall.o uaccess.o
> >
> > +ifdef CONFIG_UML
> > +# Do not instrument until after start_uml() because KASAN is not
> > +# initialized yet
> > +KASAN_SANITIZE       := n
> > +endif
>
> Not sure I understand this, can anything in this file even get compiled
> without CONFIG_UML?
>

You are correct; this #ifdef was unnecessary. I will remove it. Thanks!

> > +++ b/kernel/Makefile
> > @@ -32,6 +32,12 @@ KCOV_INSTRUMENT_kcov.o := n
> >  KASAN_SANITIZE_kcov.o := n
> >  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> >
> > +ifdef CONFIG_UML
> > +# Do not istrument kasan on panic because it can be called before KASAN
>
> typo there - 'instrument'
>

Thanks for catching that!

> > +++ b/lib/Makefile
> > @@ -17,6 +17,16 @@ KCOV_INSTRUMENT_list_debug.o := n
> >  KCOV_INSTRUMENT_debugobjects.o := n
> >  KCOV_INSTRUMENT_dynamic_debug.o := n
> >
> > +# Don't sanatize
>
> typo
>

Thanks for catching this, too!

> Very cool, I look forward to trying this out! :-)
>
> Thanks,
> johannes
>

Thank you so much for the comments!

Best,
Patricia


--

Patricia Alfonso
Software Engineer
trishalfonso@google.com
