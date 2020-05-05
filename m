Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C696EC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23D4206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sk4Waohl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgEEQ1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbgEEQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:27:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF295C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:27:53 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so2456705qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qEFIrk8I4x+Pe/UX6dmyNmgUh3ccSPdNfMqmW/bFJxY=;
        b=sk4WaohlKQtyYNrc6QHMgyHesOEY6lH9TMMmiBdrnAwFt1Wzv8LHqXzRwY632/F/st
         oVWWyF+7UeCucrHKMA4uvADq/Zdjnq9q0n+YTsLYRJ5bEaKr0nTjbHclZgSl/zNhahTc
         lrUpYQNR3z60hinHazOAPzNScS0hJ2fVJx7hJ6oHy/jf3gvgl23BRc5GDx9gJsK5/bwX
         pduBBIxWLIi4J0M5ovRTM14SGgzhuE7ZvurfFJ3IuQgY8HvWwKT75ItzgiDUEXkZXva5
         K48L3rHysP0gP3bAfjYM+gmh3s+ewgOt/R03WmJL1mcV4kPQ/Zf8Q+pqgFFNmlkIbh2V
         59Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qEFIrk8I4x+Pe/UX6dmyNmgUh3ccSPdNfMqmW/bFJxY=;
        b=WXnfy+rn+FDBAdnpGVX/5QvZN8D9I5J6LodpHC/jyt79B8tGCKzFHf+JxhH4CxYH/C
         4FLIcf4uMlEL8ErtmzMNQGKtzMsVsEX9vKG1A/NFF8fbFxT+/U8IANqWqbrpUQ83gFz6
         J7ZvfFNuGgQKSdFADBhEAy25+nCtOsGbw15UBIf5dbWg+QkryOGrx5EwTMjlj5h5LaFt
         ts4EHgFlbZ/3lNloxF2ioCnPoQv1KWJmfwQ1e0ybs0pU+DIWEk/V4Zu0XwYWNydaFu7V
         bX61KUOswVYibRcwrX2D0/V+HaiV8OteL/vzYt3pCe6eHJUoAFYgE5qIVqbxL0IT1del
         QPLA==
X-Gm-Message-State: AGi0PuZSxvn/5mIv9nuuCx7pLJJtepWJrj670HDoMpi0l4kUgDgqeHOO
        NtY0Id406TAk1BDoF9HOuZT7bH9aksYegR4oHZLfjg==
X-Google-Smtp-Source: APiQypIDdY/RPDHOS6aSjrmaca8BOHQEL/JYupW+oHH4dRImVr5/u8HEH7uPOGlk6S2dC7Pdx6xiVkMu+uENsvuZl4s=
X-Received: by 2002:ac8:7b8b:: with SMTP id p11mr3528956qtu.131.1588696072959;
 Tue, 05 May 2020 09:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200430000916.8880-1-warthog618@gmail.com>
In-Reply-To: <20200430000916.8880-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 5 May 2020 18:27:42 +0200
Message-ID: <CAMpxmJXh6G0F1guJkPMJWwj_+Vk8D+k6y4MybVYOf7x9Cf-adA@mail.gmail.com>
Subject: Re: [PATCH] tools/gpio: add bias flags to lsgpio
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

czw., 30 kwi 2020 o 02:10 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a=
):
>
> Add display of the bias flags.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  tools/gpio/lsgpio.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/gpio/lsgpio.c b/tools/gpio/lsgpio.c
> index e1430f504c13..8a71ad36f83b 100644
> --- a/tools/gpio/lsgpio.c
> +++ b/tools/gpio/lsgpio.c
> @@ -49,6 +49,18 @@ struct gpio_flag flagnames[] =3D {
>                 .name =3D "open-source",
>                 .mask =3D GPIOLINE_FLAG_OPEN_SOURCE,
>         },
> +       {
> +               .name =3D "pull-up",
> +               .mask =3D GPIOLINE_FLAG_BIAS_PULL_UP,
> +       },
> +       {
> +               .name =3D "pull-down",
> +               .mask =3D GPIOLINE_FLAG_BIAS_PULL_DOWN,
> +       },
> +       {
> +               .name =3D "bias-disabled",
> +               .mask =3D GPIOLINE_FLAG_BIAS_DISABLE,
> +       },
>  };
>
>  void print_flags(unsigned long flags)
> --
> 2.26.2
>

Patch applied, thanks!

Bart
