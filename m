Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3BAC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31E020739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oCbp72cT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgCTQzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:55:18 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39017 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgCTQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:55:18 -0400
Received: by mail-il1-f194.google.com with SMTP id r5so1506718ilq.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=usrqhcsME51fYUKBNI2VhtAWdq1tmoI6o2V5TV7GAqk=;
        b=oCbp72cTVPbZaDqUR615UdrgaJiORTpatTh0elU9NAhTpQ8DTVxGwY9RLXgTWDBwVw
         M/I0fwvnaMQ/bMrDS3Pqo8YWfjtDhbBXIjw3arkHzeBFachRiGxGN2sqIUTq7J+XOM9u
         F3IlzWQmVHL0TYbisV7O8YrsgpreQbZSgvc5EikCxaBoaINh2kofT1Rv33fejkgyfDLh
         AnK8fJH+UqnoRcY/X1vfVdR5dqy0xyBQRlwotcqfWxmCv5kEMFuwH65ciZGN/lc2wdIc
         X8PRNMFCGxImG1/OZRG9QAacg9TbaGbaPiOYByP8SxcEAzjPhQ96Cf5MmDO1g/Kb9d3B
         joFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=usrqhcsME51fYUKBNI2VhtAWdq1tmoI6o2V5TV7GAqk=;
        b=WdEwGeIMyefqAktM5maTsXpgM0kmscBCHnA9WqULT7bXV7tF3S5KsFgEbnPCo1/PHl
         VOOs831d0VgDmnd+YN2J68D5KwE4gKxaGzxnPqsnysmcAwIiMPdrzmBn+60eDPHxY8pz
         8v5VwdYw7NE+y2kBsjLl9qvE7aUetjkl+gh0m0fWoIB4GJvhQMNE90LT1gV88dG7OPIg
         xDN9Po+MfxY95IZemjzhPQZD5yHjeIY2fXuPKJxAlJ6GWysYAh+KzFgJ5wfiJ0a5ch2G
         dFGbdMjdvPldsfmkgr5PLl5HxGpN0US2icuS4PQg8V6Zbnw0yNdqcQM2uDhdk6J8BLLj
         kO1g==
X-Gm-Message-State: ANhLgQ3VN+RL6lfFoZyrt9SoEQTNl8EIisPE3T3oH2Ma4h/OkTGSG7e5
        MDi9I4F8GxACuYRjKDPM9HvZQIRF01z1Cd5u6ZKZaQ==
X-Google-Smtp-Source: ADFU+vuk+OWO9FewAHbJCMHsu2uMoHkROhEMo5o7mXmXWPKSw9W038Uq+2tmpfrkI2XZLOntd0juGnlYRy/Jw0eifzs=
X-Received: by 2002:a05:6e02:10d3:: with SMTP id s19mr8977167ilj.220.1584723317219;
 Fri, 20 Mar 2020 09:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200320093125.23092-1-brgl@bgdev.pl> <CAMuHMdXWrK3QjGmAPC0aPtQ_62buiQLopyRKB-qro6HBK5bDyg@mail.gmail.com>
In-Reply-To: <CAMuHMdXWrK3QjGmAPC0aPtQ_62buiQLopyRKB-qro6HBK5bDyg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 20 Mar 2020 17:55:06 +0100
Message-ID: <CAMRc=McrL9bZpMVFHt7e9zKzqCd1aMoPYSBd5WqXRmiDU3pL-w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: don't call sleeping functions with a spinlock taken
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 20 mar 2020 o 11:59 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> On Fri, Mar 20, 2020 at 10:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We must not call pinctrl_gpio_can_use_line() with the gpio_lock taken
> > as it takes a mutex internally. Let's move the call before taking the
> > spinlock and store the return value.
> >
> > This isn't perfect - there's a moment between calling
> > pinctrl_gpio_can_use_line() and taking the spinlock where the situation
> > can change but it isn't a regression either: previously this part wasn'=
t
> > protected at all and it only affects the information user-space is
> > seeing.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: d2ac25798208 ("gpiolib: provide a dedicated function for setting=
 lineinfo")
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Thanks for your patch!
>
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1154,8 +1154,19 @@ static void gpio_desc_to_lineinfo(struct gpio_de=
sc *desc,
> >                                   struct gpioline_info *info)
> >  {
> >         struct gpio_chip *chip =3D desc->gdev->chip;
> > +       bool ok_for_pinctrl;
> >         unsigned long flags;
> >
> > +       /*
> > +        * This function takes a mutex so we must check this before tak=
ing
> > +        * the spinlock.
> > +        *
> > +        * FIXME: find a non-racy way to retrieve this information. May=
be a
> > +        * lock common to both frameworks?
> > +        */
> > +       ok_for_pinctrl =3D pinctrl_gpio_can_use_line(
> > +                               chip->base + info->line_offset);
>
> Note that this is now called unconditionally, while before it was only ca=
lled
> if all previous steps in the ||-pipeline failed.
>

Is this a problem though? Doesn't seem so. Am I missing something?

Bart
