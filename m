Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72F7C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB00206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wCt6Xy7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgBRJpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:45:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37547 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:45:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id c188so18876581qkg.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9XVsQps1/vECfqy4vvjUlJkB0Wdi1HRB2ynEm0uGvLU=;
        b=wCt6Xy7h7SLxMTWAHkvasgiQNxbFwovHBFNKQFIKvB2x+m3gdr49sdpintVS6KM6Tz
         spDJfjHnmeq1y0mZ2osVbQUwL/iipt7Xbb6Q9g8e70iWgEewAnTkOTtxBbL/AngrNVBp
         2fkDuTN+f7hCMQswtvGn4/rpUU5M3LzfNPwuLAPTyevugM8tc61RL3Xlvhwb0GVWkwhu
         CaEpiGguPy3Sfc9/PzMLxYHikY8U4t3lxf8dV2vCNHKOmty1orsnat70eEdafafMWTCa
         z6p/+kyK+5VD9EwEwWUG6KAdugsep1U9qM6SMEvAoRZoff4Y3vWqBkuziQ+QmXpk++XL
         taRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9XVsQps1/vECfqy4vvjUlJkB0Wdi1HRB2ynEm0uGvLU=;
        b=LhIY7P+eQ0YnUZiqrJfzdS+U9/bOLEDfN5b7s4i9pOuZIPeL/ZILayM80mn01ZsGsS
         +3uWv4jPlzOXaaIdXASYAZWAGOVR5PH+hsbNZ6tN1HZeazLeDP3kz7wFcXADvpU8Alx1
         v1VcHwe9sYyZCd9pNpdN0Dt0fFVcMO9WfdUNvjzgwMGT0obhzWm3+/v3kY4QD8x99qbF
         Cu4OfNZdhkX9BsQFen7g7w5uWKm2ZSoW0RsFoYwvZD9uVXeLHn7tCsViSZdnvXfFwWzH
         3DeW9+9LzQridH6XncjBl0QwGg5wVShij0J14xMr9JjX+dFTQgMXyNB+BHdJJctHNE1b
         WNNQ==
X-Gm-Message-State: APjAAAXjk19nmoZsFZMG8dcUmcpw2HMXbROabz6CNGYjd4Nmkmk+U9Zl
        EomRWHWMeAAXfQQOOvHpyxGoXjTxjref+SPiC8bOvg==
X-Google-Smtp-Source: APXvYqzS+gppcwwBIOn4U7HU8L6ESgFTX05wkRhJ5CnsoiW6Z/UTtG9SC8kuoyJt2sd8jC+QAFbM+0jly8VHAmp3KqQ=
X-Received: by 2002:a37:8343:: with SMTP id f64mr17248561qkd.21.1582019102971;
 Tue, 18 Feb 2020 01:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20200217195435.9309-1-brgl@bgdev.pl> <20200217195435.9309-3-brgl@bgdev.pl>
 <f539c993-52b5-766d-d6e5-51836998f445@linaro.org>
In-Reply-To: <f539c993-52b5-766d-d6e5-51836998f445@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 18 Feb 2020 10:44:52 +0100
Message-ID: <CAMpxmJUxj2+u8_Dh4tGbA44-9oBuRXP6PEdW=X0u02E2Fv3fjw@mail.gmail.com>
Subject: Re: [PATCH 2/6] nvmem: fix memory leak in error path
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 18 lut 2020 o 10:42 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
>
> On 17/02/2020 19:54, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We need to remove the ida mapping when returning from nvmem_register()
> > with an error.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Was too quick in my last reply..
>
> > ---
> >   drivers/nvmem/core.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index ef326f243f36..b0be03d5f240 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -353,7 +353,7 @@ struct nvmem_device *nvmem_register(const struct nv=
mem_config *config)
> >               nvmem->wp_gpio =3D gpiod_get_optional(config->dev, "wp",
> >                                                   GPIOD_OUT_HIGH);
> >       if (IS_ERR(nvmem->wp_gpio))
> > -             return ERR_CAST(nvmem->wp_gpio);
> > +             goto err_ida_remove;
>
> Looks like this is adding  nvmem leak here.
> May be something like this should help:
>
>
> if (IS_ERR(nvmem->wp_gpio)) {
>         rval =3D  ERR_CAST(nvmem->wp_gpio);
>         ida_simple_remove(&nvmem_ida, nvmem->id);
>         kfree(nvmem);
>         return rval;
>
> }
>

Srinivas,

I just sent a v2 of this series that addresses it as well. Please
don't apply v1 yet.

Bartosz
