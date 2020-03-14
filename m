Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDEC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7DE2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Sf5x1zwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCOCFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:05:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39358 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgCOCFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:05:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id w65so7696140pfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XS7pPJqjYBq2Cs3zeKdcSdMmGqDIVMj9vKA0yVpQYQM=;
        b=Sf5x1zwN8QR6qPFehI+iNJp+T4OBQDZok0BZVP5d7W697tY7nu3iIaNX/pTClNaP6m
         a2IlKNgv3JLE+oLxB140e6Gni9q1YQvXzxUKBXYU2Qz/JmiQg9VkiOFdwViV3x/oNTuq
         ODxU2QcZ0/2BsgOZHB9KPXhgo4UWuHOLkdg5ebQcSj1DOyzkciV28dC7LznuuSbbsgLf
         9qKypmkEvJauObctXk54IDy1FlikMphAdZKUM9sRnEVtB06VebdZWeFf0jzJDmICKRGR
         j4BvQWoJ3wr5/ZDTL0CUeBuvqrdKMphzxoyMadubUapSr3ZlPFVXY042oSM6QDHGEcQF
         Y0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XS7pPJqjYBq2Cs3zeKdcSdMmGqDIVMj9vKA0yVpQYQM=;
        b=pUc5LhjVWtMU6sO7RX0KGMD228xKIJzMnR9LRT25SHsJAKhkUar1UsNyiDG9pCFo7a
         Q7rPwo+0h+f/lO/EkQE65ma7OW2NhmkiEYGso4z2Dpu92WTr1aDopbpVQnDcEFN7Mi1S
         K2+BdXO8IIthRdydVZYVWsmkBr5gGnp245rA9m6hfSANbMk0sMFkG3CNt1KP52c1x6ZU
         71sZtsUT7mOkbhRIMRx1tdBi0T6QrNgrL6r1Uwz9XV2SHwji/+OkvSQC7/AHhumiFjua
         PU2jLde2RaY/Sb6BOlxiK+tfX6odzhtG3BRAGPHSf5PN9R4vhREBf6Bl8EBIiDEWE0cd
         zm/Q==
X-Gm-Message-State: ANhLgQ19yqICuaZQAoDJBgBqVUrpq+AzNCYeg0CrWm3ofDhx1MsqOhCH
        gS+rXqcrjRBF0Qs52Ns1feOT5vaug8xT6kvksVr6JoD7
X-Google-Smtp-Source: ADFU+vvNqfelgTman/LTAHlaUt3dUAnq12p1V6wQSTw4nfnSrB6N2tLtBDR4+u3SG5RCHzJpuWY38EXEpQpmo5eYaxA=
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr18048548iop.130.1584217720359;
 Sat, 14 Mar 2020 13:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200312145020.1848727-1-gabravier@gmail.com>
In-Reply-To: <20200312145020.1848727-1-gabravier@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 14 Mar 2020 21:28:29 +0100
Message-ID: <CAMRc=Me=u5dq1_kOk3qJ-XZbkiOrK01ZDueY6K_U2N2QSc27zQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio-hammer: Avoid potential overflow in main
To:     Gabriel Ravier <gabravier@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 12 mar 2020 o 15:50 Gabriel Ravier <gabravier@gmail.com> napisa=C5=82=
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
>  tools/gpio/gpio-hammer.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/gpio/gpio-hammer.c b/tools/gpio/gpio-hammer.c
> index 0e0060a6e..083399d27 100644
> --- a/tools/gpio/gpio-hammer.c
> +++ b/tools/gpio/gpio-hammer.c
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
> +                        * '-o' was given to give an accurate error messa=
ge
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

Patch applied, thanks!

Bartosz
