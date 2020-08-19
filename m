Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C17C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EA6207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dr3dJhrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHSR4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:56:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3517BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:56:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so18433377qtt.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfiunOf44XI9+MPstBMX2TkSWz+lSVO6pH2bOmIQZyg=;
        b=dr3dJhrH7Fmq9QexZ8NGZnM6Swg7W4thUUaNwI2rHnqIu5z4g6DUG/HdvRyI665jyN
         UshRRSz1Eckur35WFE3NFtjEPKm+LSVU36xgljQ4KddIzTauT/Ld7fyVb6ur+Tw6cUOu
         xwjI7yuH8xDlPGsE9lyHjvbNF7hCat8xT26w0T4b1C/dywBj6ynGmDzejPCwyC/VyqFK
         4cDB/R028NBn2N1cGP7IWHEWnItDcJLhUuC5Ce9ld2XZt2cl+ezYlIlsTeUjPadIM4tW
         qd22R/LWVasY9Aj6lvN+7ooEDxHu50trpxMP4EMGo4ftF/AaFhGpI7airSQTlk+Odcbm
         A1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfiunOf44XI9+MPstBMX2TkSWz+lSVO6pH2bOmIQZyg=;
        b=UpN528NRKYGxPZLysns/Fpdu79K+c+z+SdUKGch8H4JY+zfwtd6amMBLhZz4DuICva
         jD5Urc4lk95ofUAssghbOUiqmCKguoBELTFNsl088y/AJhmnwm2OV5tQHko/UwGvQlkL
         nUWhciwI0MfY4OF5Q7imgWMYZEjt+Qk5SE0czttWI1TIo87nEour5soRTtjytSZCnXSp
         zdHXFkw+QM6tyAH9TrVkGt+YUa2irhW7AYOBuD2Bjo9LINJwxyMUygqMVuE9y/J9AE5+
         wD9LnS5JrejxGPDf0PUtLmHK70lcby8ekpeZ9Y0MF8/uEawnD4YJkhKFLW4BFSgs8j/w
         lqTw==
X-Gm-Message-State: AOAM531I0BZ89s4dSF+tKkLVTHbP8iDrnFg2ip78VT7c2FoLdvJtb3rt
        JYJWOMDvAQ2NcPQHZFIYEB1WN9J2C9bU42CGpjwpHg==
X-Google-Smtp-Source: ABdhPJyQtuknrzEQNakf3MeOPHKQ+Hx1XSYnrhn3uCBBj+Y38XMt1c6t8P7GG779ClFTdqFo8Nvm3vjlS2YB0moYWYE=
X-Received: by 2002:ac8:4e39:: with SMTP id d25mr22979101qtw.208.1597859778427;
 Wed, 19 Aug 2020 10:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200721144832.750728-1-abanoubsameh@protonmail.com> <CAHp75VdFvAYR+z8c6R2J9Q2JK-WpHS4LU_-cWvsOa2g8+Gfk9w@mail.gmail.com>
In-Reply-To: <CAHp75VdFvAYR+z8c6R2J9Q2JK-WpHS4LU_-cWvsOa2g8+Gfk9w@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 19 Aug 2020 19:56:07 +0200
Message-ID: <CAMpxmJVW0yXdVVxYYiNjHw5XsKx+cyb6hV7KTeOQBxgFJWWx4w@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-crystalcove.c: changed every 'unsigned' to
 'unsigned int'
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Abanoub Sameh <abanoubsameh8@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abanoub Sameh <abanoubsameh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 6:05 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 21, 2020 at 5:49 PM Abanoub Sameh <abanoubsameh8@gmail.com> wrote:
> >
> > Changed 'unsigned' to 'unsigned int'.
> > This makes the code more uniform, and compliant with the kernel coding style.
>
> In all patches you wrongly added 'gpio-' and '.c' parts. Also you
> missed the version of the patches (I have told you about) and
> changelog.
>
> No need to resend, I fixed that this time for you. Be careful in the future.
>
> --
> With Best Regards,
> Andy Shevchenko

Hi Andy,

I was going through pending patches and noticed those from Abanoub:
are you also the maintainer for gpio-crystalcove and gpio-msic? The
MAINTAINERS entry for Intel GPIO drivers doesn't include those - do
you want me to send a patch that adds them?

Bartosz
