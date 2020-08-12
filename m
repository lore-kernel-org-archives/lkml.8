Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ADEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41462076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1tEVefoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHLRtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgHLRtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:49:05 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B088C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:49:05 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id l13so1408100qvt.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D31gvXwueiTQW0zOx6WQYb+FpRC9rVXNJ4C7VuyhJ1o=;
        b=1tEVefoD7l/vL0aoMx+sEWhWifIrF4HpNaz+cqo0t8WUEXAQKbrMjqwNPZJ6hZisLN
         igNElCrRIdGAPDhDjTpzCyjqWf8sxs7sqzgeNCLIFFjaVUkNn4LoaNyAsb22wB3lWCkB
         Ka9Zp39azUXQA1li48UvI8rKs4kcMLEv4nj/D5HyIrQPDfm11N25yo9BeKtJU0IwlqOf
         WiL8fBg58jhiEMM/oMGphDuPqlWKHBmBDctAadd/3zcEaoq98zs9tV1Cpojn5CGy5M3q
         5c9b4+HctAqnE9BreK7flKjW+zN5GaH/usZi+aL1X5Cp5aM1ca/T6EQLayxwaVZp1zil
         mzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D31gvXwueiTQW0zOx6WQYb+FpRC9rVXNJ4C7VuyhJ1o=;
        b=ntXxxWFfMa4A59EinbfpiwA/sN8GqK0fzZTlikFmFCgXOiUvsUJDkZxv1wbO68jnw5
         wWQViV9pNvV23oO2lEapq8L2emSUcClfUzdxw9d5pkaf2V7AVaiIN1u4usg/nE1hCMR8
         kgeKJwCWHq7l/ZdMHvp6hIRxzZSjArQZyg/lbm3d1NAv/RgD7Oc4uEQ4XZ9cKykzjVMe
         iHe1Vaad06HgYDBpNVoBSHsMUwtUafSJKgPDwmj6bNyBClpROw+0Xc1cZ7sXT+pypv3G
         1d9bG7Z6kuyl5RjvFjwyTkslqm6JqmmkOh8C+j2uU2B6pYw7jOos4BrM4ant22Hf0LRb
         G/RA==
X-Gm-Message-State: AOAM531LuIk4aPVHbKnwtEe6ob2vvaqI7rLNTzdfEyz+hci/660ye0nW
        NvVsrbeKBKqeosSxFnAMssU833b5/97R3tcRZrQR+Nrh
X-Google-Smtp-Source: ABdhPJzUmKRjdyp7ZnZ6xpunrA6u4/Q6+rQyHfo/Kb5MT2x8R76uUR3KRSRWXOzP+aUMh4P8c7JfqxymnNoxp3/x+BY=
X-Received: by 2002:ad4:5502:: with SMTP id az2mr763112qvb.148.1597254544478;
 Wed, 12 Aug 2020 10:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200809132529.264312-1-warthog618@gmail.com> <20200809132529.264312-3-warthog618@gmail.com>
 <CAMpxmJWe6Cjhwt3izuPLK-Xzvm=LqOy_nnZ7xg123+M_JgriLw@mail.gmail.com> <20200812015458.GA8760@sol>
In-Reply-To: <20200812015458.GA8760@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 12 Aug 2020 19:48:53 +0200
Message-ID: <CAMpxmJVbVWKaY5QuUFn9XxhJQ2-YFRTowk13_Lnt9kyQT=+-WQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/18] gpio: uapi: define uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 3:55 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Tue, Aug 11, 2020 at 09:11:41PM +0200, Bartosz Golaszewski wrote:
> > On Sun, Aug 9, 2020 at 3:26 PM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> [snip]
> > >
> > > +/*
> > > + * Maximum number of requested lines.
> > > + *
> > > + * Must be no greater than 64 as bitmaps are limited to 64-bits, and a
> > > + * multiple of 2 to ensure 32/64-bit alignment of structs.
> > > + */
> > > +#define GPIO_V2_LINES_MAX 64
> > > +
> >
> > If we refer to bitmaps for which helpers are defined in
> > include/linux/bitmap.h then they're not limited to 64-bits. I'd just
> > say here that we want to fit into 64-bit integers for simplicity.
> >
>
> Strictly speaking, userspace doesn't know about include/linux/bitmap.h,
> but I'm happy to remove any ambiguity.
>
> Does this work for you?:
>
>  * Must be no greater than 64, as bitmaps are restricted here to 64-bits
>  * for simplicity, and a multiple of 2 to ensure 32/64-bit alignment of
>  * structs.
>
> Cheers,
> Kent.

Yes, perfect.

Bart
