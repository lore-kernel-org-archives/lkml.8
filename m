Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD61C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DA52192A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PPJ1YOge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBDKFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:05:00 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33525 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgBDKFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:05:00 -0500
Received: by mail-qv1-f66.google.com with SMTP id z3so8287112qvn.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vIq07h0Q4Xacts0Z8nGndxELy+JbkoofTPHFyoyLP7k=;
        b=PPJ1YOgen/v+popaeR1IlDfTIc4vqCR1n08a0ESdIof9DQcNCYRAMrdpOXVhcrej1w
         F3of+b2a/FKKgGMwH/k54gHGxPi3/fswcLiHYxdMpW5Q1uERpYmnN4IzvqPlH7+ukwNh
         yisYGgzeZgPUgntSZIHoGxueP6CiPlKbU6u43wcRCqJXJChNBYo3qpN6U9yv8Whn1cEU
         bOlXVaB5uDUfs2TAhyP67bYQ3CVacdeuTPZw5ohRptomczy+8VXcPlH7/qhvzpfn8yNr
         OrBxH8yamzwx93scetaVROFRkRvcYZKDJAQ5ZhFNqHXZmBUh2AlKEuidIADLKH6NTUmY
         b8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vIq07h0Q4Xacts0Z8nGndxELy+JbkoofTPHFyoyLP7k=;
        b=OeZ3Uo5juKjQfbA26dZ7yq3ikuSU4/i31QgmJZFKhB8lwxj2CWAcNwLofkoT72f7hJ
         yrA1TvgfmiWDVeDqdJXS8f7ht+6CRtixT5VtGuIb2eaPNYVnGBOB6le6lx6o+/Hd/YAp
         ipGPtoNEsXk4uaOMUgDUlWgHni5pf36UW6OGHxEjrVuEYnCF/XgJXloG/zgQApyEF5/a
         YkbdkeuhqJFhYbkIZXhbyELWyS7SOrz3mWOfC0aDFBCccBUWMzm6TEv0ykBxmGFsMkcI
         hXid4sxg9LmvrjXKUAFp+KhIV34mlbr3twwAlejsvocwnnhzEyWRzEidOW5zY3NiJeAc
         G63A==
X-Gm-Message-State: APjAAAVfdMhMbl60bZj3v/H69bNeYCz6KtXpyj1pKyfva4GSQ6fkOS+u
        1KlQs82yTpc3yLJJIjps5lfQdyG18qhj6MUIKTRzpA==
X-Google-Smtp-Source: APXvYqyfaW5WxVPRXst4b1KcTfegqhcamsfX0I4Imb0RailcutLwVqwRTH2tK+IgHTszdeoqagKyGzZqaiE97XAyo3Y=
X-Received: by 2002:ad4:55e8:: with SMTP id bu8mr27366613qvb.61.1580810697768;
 Tue, 04 Feb 2020 02:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20200120104626.30518-1-warthog618@gmail.com> <CAMpxmJWCwtnuB4T3_no59cVvPS5gy6QwOBV3i4FU4N6hmYugEw@mail.gmail.com>
 <20200129123349.GA3801@sol>
In-Reply-To: <20200129123349.GA3801@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 4 Feb 2020 11:04:46 +0100
Message-ID: <CAMpxmJU0d=e6ZrSd5Sp0q4xFz9PYo4Zwm=e2AsL8f-pEodZfng@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: remove unnecessary argument from set_config call
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 29 sty 2020 o 13:33 Kent Gibson <warthog618@gmail.com> napisa=C5=
=82(a):
>
> On Wed, Jan 29, 2020 at 11:55:49AM +0100, Bartosz Golaszewski wrote:
> > pon., 20 sty 2020 o 11:46 Kent Gibson <warthog618@gmail.com> napisa=C5=
=82(a):
> > >
> > > Remove unnecessary argument when setting PIN_CONFIG_BIAS_DISABLE.
> > >
> > > Fixes: 2148ad7790ea ("gpiolib: add support for disabling line bias")
> > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > > ---
> > >
> > > No argument is expected by pinctrl, so removing it should be harmless=
.
> > >
> >
> > This doesn't really fix any bug, does it? If not, then I'll just take
> > it for v5.7 after the merge window.
> >
>
> This is just fixing what I suspect was a cut-and-paste error on my part
> that wasn't picked up during review - until I had a closer look
> following Geert and Andy's recent comments on some of your proposed
> changes.  So it is just a tidy up.
>
> It could only a problem if a pinctrl is making use of the unnecessary
> argument, and there are no such pinctrls that I am aware of.
>
> Merge it in whenever it is convenient.
>
> Cheers,
> Kent.

I'm picking up various early fixes for v5.6 so I'll go ahead and apply
it while at it.

Bart
