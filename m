Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B149BC2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1FD20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OL87gJfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501925AbgDNM1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501912AbgDNM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:27:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CBDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:27:01 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g74so12851142qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oMYbOdpo+9J1ouSM2RLjgqda5qd9JwHSLPm5KH5iBRA=;
        b=OL87gJfF0Lai5QA/wkTraFaZeOSO+QXBHPXq0YlRcK9vzbCcbJbbNygT9g3JoYpxX9
         UmzBQJJBdQFeP5Ik+CjapitA0S0n7Gyj+lqyQv7FVz0I6aIl75ayTu0PXTUkVT50oymk
         tCVguHZuWurqV7A5lm1gDhOiYLsEbWR/U7Z1fATYeLq0UDSi616BDI1FGmcybn5vJgxN
         xaQr/YKAsAWKDoO5xR3wtcK3d3oKrUPZRp2ydp2mqDCXRSEXRD6cQT90GhQvHWzqzebr
         0A/VTHHpJQSx3lnhSlYl6ugxjCZocDuLwfU6xPARV3Z9BLcrWicByovFwVB40bBq1JOm
         8trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oMYbOdpo+9J1ouSM2RLjgqda5qd9JwHSLPm5KH5iBRA=;
        b=NE4S+MzJRsUU/8Rz9wd5lxlWklcgy3GQ/+Gq4D0f8KEL0IpyL0zPKeksdl8hvhdi2n
         T4y4LPIBFxdNFkhco1hQqLBdhzDJsYNyChgue5SIOdUk3cSix0iU78azbeEGNn2+0K92
         8wX37Es19eS6WlaLFuwe8hA13jA7unaDn8rZBWTx/n7XOYipeMfsTVAnNJmNQ/hPjtFm
         Hsdv0Y5Dp0+hK5yZ2tqDo/TxlQedvj+sMFqvVCnUcgXJxk05Xn8YE+vY/RgXp9YY22AH
         p4txDj4GX4ixwhsToAbIMJFYpghinu5mj6Ve2b7nJGAsXCUsa1hAWEsrM1cKVWfE93ON
         macQ==
X-Gm-Message-State: AGi0PuYxxUTKaiKIm/dgMGgEkGIrIyMTuD4thNMYj4ZQO9B3P0jsrHwz
        Zdq9qXWEGWVp1haG0Sr1blyJh/KbWbf/memJsXn9gMd8
X-Google-Smtp-Source: APiQypKKyn+xF7HXSEHC+hxChronDvELDGTLZLon3xgVgEW+iP+8F2yjGXq99NGOy7nJFf4ORjyVpTF4K9uqCozhjpQ=
X-Received: by 2002:a05:620a:1289:: with SMTP id w9mr6020359qki.263.1586867220834;
 Tue, 14 Apr 2020 05:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200320093125.23092-1-brgl@bgdev.pl> <CACRpkdZgWUwmmuXn12DS3TsQS0yQxcweqK6HGxBm=V_2LBLBMw@mail.gmail.com>
In-Reply-To: <CACRpkdZgWUwmmuXn12DS3TsQS0yQxcweqK6HGxBm=V_2LBLBMw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 14 Apr 2020 14:26:49 +0200
Message-ID: <CAMpxmJUb09KGreHw6Bdz79rbnQE7oZnWg_5qN_FhzoS2-XccFA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: don't call sleeping functions with a spinlock taken
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 14 kwi 2020 o 14:00 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Fri, Mar 20, 2020 at 10:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
>
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
> I'm sorry that I lost track of this patch :(
>
> Do we still need something like this or has it been fixed
> by some other patches?
>
> Yours,
> Linus Walleij

Nope, this is still an issue. Do you have a better idea than mine?

Bart
