Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EF2C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E222071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wz9uTaIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCLNy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:54:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34500 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgCLNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:54:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id f3so6269996qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YJCbAPM757c7WtP5729q/CvzsGeEr1ydJuKt4rhqYN0=;
        b=Wz9uTaImPoBXmMxauB2gmqMyOC7ZHJIqwDg3dkJxuEtcOEk7VlKjUF7hgOsfXtoDcf
         j56kSjTCHlUXqEi+p4R2+8g6dT3gOl/SfmGOcvsTWoiIqnsO1gIjCd8nmxxSGGTU+gXg
         redRm1hKIc7Hw5YBy+xDo0LJcZwVYZbd3/gGlzuiEBUPTOsTKdPvowZBsC/atoHowoQL
         Wd6J4G7x2CQKp0qB8Q4ri+INEfgSNXrxafpiqxJXlFFMGhj7xVIBbfKyTOmvcpmFwtzH
         rJWugm3npmE/ewF3g+mT9QpKbmwqmK6NhDhKv8RUCMsY/qAWA4H2bHNlERC3rgkJlNnM
         +vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJCbAPM757c7WtP5729q/CvzsGeEr1ydJuKt4rhqYN0=;
        b=gy81wMNaJa/1wJMos/enNu8QRoePnxiDDBAw8qi6wWCEmOfkJVfE7lV+pY7X0oQtyf
         6b0Poh+7PoE6bUyZkPwBly+a1PjASRnbZes2rnNMRslP+PiuUBvPH6hkGGV7olxjtS9w
         yuN5lyTpbgsgrk8peQE5mJHoeezBnI78MlAdaeA18wKTAP/mVLWG1qjOGCAxjy9BnNp4
         eOYMFCJvKChOMLCd7zyUgzeBuVPJLvUriIT4ieIy8NfjoTo8EI9VUTlIZuclKiT2qabJ
         PWYx4Gt9/29nOD8UUlXRgskx9TrKSFzX6i5pOBYwFOzFy57KkSYJtYpiJ4g+KdXF1QYw
         cL8A==
X-Gm-Message-State: ANhLgQ337vH8BXI8PJWTGwSWgl/VqiCmBZ19orHplm98P1cGeh66slW+
        ZpKSm/tWgonNDuqKgFrlsfl6JPJXRIFgO5B25G/XBw==
X-Google-Smtp-Source: ADFU+vsuGDmI45/A8Yf3+0B7+92jTTpshUjY3yuJofcW2KRZcB5IKMAjUaGCEWxWhVaaeduCWL8mS5oibYzFRjRxZqM=
X-Received: by 2002:a05:620a:1362:: with SMTP id d2mr8052260qkl.120.1584021265259;
 Thu, 12 Mar 2020 06:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200312094008.1833929-1-gabravier@gmail.com>
In-Reply-To: <20200312094008.1833929-1-gabravier@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 12 Mar 2020 14:54:12 +0100
Message-ID: <CAMpxmJUUth5w8tvZp8mFV-FDz0YivmRWAqsOQSTdze1xagMX8A@mail.gmail.com>
Subject: Re: [PATCH] gpio-hammer: Avoid potential overflow in main
To:     Gabriel Ravier <gabravier@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 12 mar 2020 o 10:40 Gabriel Ravier <gabravier@gmail.com> napisa=C5=82=
(a):
>
> If '-o' was used more than 64 times in a single invocation of gpio-hammer=
,
> this could lead to an overflow of the 'lines' array. This commit fixes
> this by avoiding the overflow and giving a proper diagnostic back to the
> user
>
> Signed-off-by: Gabriel Ravier <gabravier@gmail.com>
> ---
>  tools/gpio/gpio-hammer.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/tools/gpio/gpio-hammer.c b/tools/gpio/gpio-hammer.c
> index 0e0060a6e..273d33847 100644
> --- a/tools/gpio/gpio-hammer.c
> +++ b/tools/gpio/gpio-hammer.c
> @@ -77,7 +77,7 @@ int hammer_device(const char *device_name, unsigned int=
 *lines, int nlines,
>
>                 fprintf(stdout, "[%c] ", swirr[j]);
>                 j++;
> -               if (j =3D=3D sizeof(swirr)-1)
> +               if (j =3D=3D sizeof(swirr) - 1)

Please don't try to sneak in unrelated changes into commits. This is
of course correct coding-style-wise but send it in a separate patch.

>                         j =3D 0;
>
>                 fprintf(stdout, "[");
> @@ -135,7 +135,14 @@ int main(int argc, char **argv)
>                         device_name =3D optarg;
>                         break;
>                 case 'o':
> -                       lines[i] =3D strtoul(optarg, NULL, 10);
> +                       /*
> +                        * Avoid overflow. Do not immediately error, we w=
ant to
> +                        * be able to accurately report on the amount of =
times
> +                        *'-o' was given to give an accurate error messag=
e
> +                        */
> +                       if (i < GPIOHANDLES_MAX)
> +                               lines[i] =3D strtoul(optarg, NULL, 10);
> +
>                         i++;
>                         break;
>                 case '?':
> @@ -143,6 +150,14 @@ int main(int argc, char **argv)
>                         return -1;
>                 }
>         }
> +
> +       if (i >=3D GPIOHANDLES_MAX) {
> +               fprintf(stderr,
> +                       "Only %d occurences of '-o' are allowed, %d were =
found\n",
> +                       GPIOHANDLES_MAX, i + 1);
> +               return -1;
> +       }
> +
>         nlines =3D i;
>
>         if (!device_name || !nlines) {
> --
> 2.24.1
>

Other than that, looks good.

Bartosz
