Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E6FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C54520787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJUTgpiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgE0F66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgE0F65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:58:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD157C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:58:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v16so27440092ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZrxLWEv2RQwIV4nFIWedkkizU0DIsRXfRmjD6gFnTY=;
        b=dJUTgpiMkJ1s0zS0iy9nBJ3IHP5NHvdqW4eA3+0tV/Yadk+ve6GdDgBLTP79aXub38
         ekh0+PedTpGyJNu7HvTuXYznrJlYsAAK1Q4YyDCvkE7JuopBTUyqyQKc3+J9gv5YQKaE
         mPckQgv/SXPxD60SABLLSqZPksIKZy1wYsmvDFgvaor9LdiCR2ferynQ5R9rQF6XOVC9
         cQGBG4Sr9NotnvZY5brGYP4Cg+Yx+/Va9OYrRzmsmNtdWBRSP9UusWScDhgE/pEUJ8VF
         8LK8Kh87YrgFCh1yp7n1iEyOBHg2Uaj/zqt0vUJ3eJecVUPOPauj17f/Zdopj8qfG9oV
         iqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZrxLWEv2RQwIV4nFIWedkkizU0DIsRXfRmjD6gFnTY=;
        b=PoJ6U8IAPGq+w/cZznwcWEtiYVzEbKczTZVdAC+I5tqbTrJkPHRvYobnLGb7OgBOSd
         /gt0MLi3PTu29+67YaKIjSFrj+nriVgv5TEUF+lVpV7RLuTvzTAMj02gcydEfW7EJ1eh
         NGo8mA03QSFeQYGL4Z35lBuEqXJVEV/WXiiMM/CxNtl8cSQmm12fW7rgAMp/QbXuyXOo
         DFSVfxSTUoNccHsUfZu7VVB4mmjBrWXcjYODtrxpQmzAhwbZiA7rbAP+ByYOgEA0Uusf
         DT0md0nUUFRCneJUsWT85/lHgh2H27HiCkZ6oDnY+aUu0TutCyidWLwcxtNlM2Fjk0T1
         kQSQ==
X-Gm-Message-State: AOAM53096Hw8w54CNhttd8VAZ/yRMljJoGRGddXfCDDW22cHaR9YHkBg
        BkkhIMwSylhbp96ZE89AY2ULMA1qsIYOve8J9ExDIw==
X-Google-Smtp-Source: ABdhPJyGcOO7k15GXBI4U9yp14BYnpfxbNWQD5wYC44Hid+bFIymEYNGNVKU6kUy+bEnmzAzciNLCRQ3ybuZ8NtGOMo=
X-Received: by 2002:a2e:b5b0:: with SMTP id f16mr2362794ljn.100.1590559134977;
 Tue, 26 May 2020 22:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200516064507.19058-1-warthog618@gmail.com> <CACRpkdbputuoHFWL_FhUNR-ZywvJt=qYdaa+i2cLt-Odmgxe2w@mail.gmail.com>
 <20200525141902.GA27938@sol>
In-Reply-To: <20200525141902.GA27938@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 May 2020 07:58:43 +0200
Message-ID: <CACRpkda4PEYd5UGbLkq9w1RBbtOdZxuMQ75k-nu5YfoKTZ_azA@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: uapi: v2 proposal
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 4:19 PM Kent Gibson <warthog618@gmail.com> wrote:

> > > +struct gpioline_config {
> > > +       __u8 default_values[GPIOLINES_MAX];
> >
> > So 32 bytes
> >
>
> Actually that one is 64 bytes, which is the same as v1, i.e. GPIOLINES_MAX
> is the same as GPIOHANDLES_MAX - just renamed.
>
> On the subject of values, is there any reason to use a byte for each line
> rather value than a bit?

Not really, other than making things simple for userspace.

> when adding future fields, the idea was to have a bit
> in the flags that indicates that the corresponding field is now valid.
> If the flag is not set then whatever value is there is irrelevant.

You would need to document that idea, say in the kerneldoc,
else when someone else comes along to do this they will
get it wrong.

> But definitely better to play it safe - will check the padding is
> zeroed as well, as well as any field for which the flag bit is clear.

Yeah better like that. You can write a comment in the code too,
such like "when adding new parameters, update this validation code
to accept it".

> Back on retired ioctls, I notice that 5, 6, and 7 are missing from gpio.
> Have those been retired, or just skipped over by accident?

Just thought it was nice to use jump to 8 for line info.
They should be used when adding generic chip information ioctls().

Yours,
Linus Walleij
