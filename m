Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE90FC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EF52072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LrPlZIuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBXPhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:37:53 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34698 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgBXPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:37:53 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so4314597qvf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HuiS5VpQdVWKyWZNdAImJ0IGya/kRsZICZjyMlw0prs=;
        b=LrPlZIufqg9LL07eHs2XATTTm09m/+vYZkHtS86qicAyjqgw2IlPXNVlrUaxGi5K29
         WCy1OQVM5qF5wrJuAqO7iQUpoEtAtHKZMto9qbmF56dM6UCRad722srOymjNJkNd3mWS
         q7E0ZSwo0aaei3WxTgDlrDDcJ+QE5REimB2KO5vGKr/Cwl8TpIAsd7wQ1PruxzjwDLgc
         cS+d8FNYeFbyrPwA/rLtClKyVqlcDv0L3v5zwNHGCJqxp35ZH9cC4k9VCRnLjBXuEc/Z
         fu0Z3UezLh7zIb1AH6GNya1c3xlGOPtgPdRtca9+p8XBHqLwYUg1/cdyhbwdCpS1gjRt
         t1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HuiS5VpQdVWKyWZNdAImJ0IGya/kRsZICZjyMlw0prs=;
        b=kJVhl/gjtBh+08oe+sFtNrsH4hdgJxAH4SYZuJrERKJGKj12AtVUJYAxBO3e+Tmepr
         zpypRd3HckXrE+U03iH2KpkUOjXmvQt2IexOuSq09uodxYjY8vKFoE5jm/cISvJlEz9d
         obZdIV/QYyCb/C61g6Gs2t585GTHMvWyFk12YQkO1UB7vhducixGGk/IikVRl4NMEamK
         8m2YendVagJ0HUUKw5ejBdje+A+I0KDBDbgZnWFaAie5Ra/dFdrsm+aY317t9FosRv3l
         A1RxiVbzqOYCFWBZyR1w0MPYylSCQ2BD5JyNVVZoFS7GFMDBlKcob7xpjAjMrpnHKquZ
         sbVQ==
X-Gm-Message-State: APjAAAVS/BBX+GFB3v0zx6Brp607IyPoaJEEDKWQjoo/nXJuCyyM4c7K
        h0VKgp9QhGZc5w0IHa7I8X4vwOfG+11Nx32680c1AQ==
X-Google-Smtp-Source: APXvYqwEyegZKG9qSxEvaiQrAO+4+goO1TqN1PPTdfqCy/GVK+bGYHTmzgQQ10XA+K2Z0igoWpt33yw8zZLAsCUXu6E=
X-Received: by 2002:a0c:f28f:: with SMTP id k15mr44011080qvl.76.1582558671694;
 Mon, 24 Feb 2020 07:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20200224144953.1845-1-warthog618@gmail.com>
In-Reply-To: <20200224144953.1845-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 24 Feb 2020 16:37:40 +0100
Message-ID: <CAMpxmJUoYP0vLF=G00HBfp6bcoQd-nXSRHsmm-E8tufdMUdjpg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix unwatch ioctl()
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

pon., 24 lut 2020 o 15:50 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a=
):
>
> Fix the field having a bit cleared by the unwatch ioctl().
>
> Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in =
line info")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>
> ---
>
> I had written some tests for v1 of the new ioctl patch series, and just
> updated them to run against the v6, which is now in gpio/for-next.
>
> I found the Unwatch ioctl suffered a regression - it simply didn't work
> anymore, though it wasn't returning any error.
>
> This patch fixes that regression.
>
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 73a1e0831eeb..2411562a9bac 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1276,7 +1276,7 @@ static long gpio_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
>                 if (IS_ERR(desc))
>                         return PTR_ERR(desc);
>
> -               clear_bit(desc_to_gpio(desc), &desc->flags);
> +               clear_bit(desc_to_gpio(desc), priv->watched_lines);
>                 return 0;
>         }
>         return -EINVAL;
> --
> 2.25.0
>

Thanks for catching this. Applied!

Bart
