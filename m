Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC84C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B1820757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BBO2buZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgCQNuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:50:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46279 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCQNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:50:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id a28so5414119lfr.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bl6Wl8W1k8+UQXRdrCsPqiuDGnxac/zO2yeYWcwH/eY=;
        b=BBO2buZOeTxK0pTFcnu2vsX80POcqQJc4xww2aupjp3CUcUyRERCJVPxOku6Aa1UD+
         TdQ3ulqZrG+z4FycBEAhYazQKCR56uL3u+gjU2zBF1yApArsbKhWr+mIlMaeU6RJnIkH
         3mha3ioQs0YGEaIJZyKWvb16kby/lPx/VM9v6RZ+7Vn/V3CzxmV9M/m4xaFBEmEAPnj1
         at+zXtyuHqSvx6FIl1EDBhs4TosAgYqCTcjUKCE6hL9aWmjBjuD1ck604axr8kvBZp/X
         2aIO/omD5oUHySZmd1whOdSQk6M2cGFoKZmq43572olq0U2X2dWCj6fWpArT4t+R2Ubo
         LrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bl6Wl8W1k8+UQXRdrCsPqiuDGnxac/zO2yeYWcwH/eY=;
        b=DFpQd0lC6fvk7xnqR78UWOHIgFVfu7LSVVBfPhhRnBH1LeznQZpaXZxkS5Vp+j/Atz
         JbNfr79hfCcBpMcwJjzJwyiiY10MTCojIOGGJHLX/yGMcaQtLESjGxDV3+dolwdk7ErI
         em+bmNuIv862swgZ778LDyI6mXi7Mc+7JgH3fqGbHAmGvbUS1sypsYp/i6irtgs4XYPN
         YSZq5tgik+r2Zs4a6R4mYcSQVtczZzdBSVYCn2sW897bvbUBCTaDnhiRZlEDtyNXOwtQ
         s2GFrT/xxNfNo9NpsW0PAejgDTvJZUHQUuvC7tTcg0eplHGJgCjyMFSW1HPcMoLtRtMn
         MMbw==
X-Gm-Message-State: ANhLgQ2pz+mxuR671WxdKiskBE5CQcKkvki97/WpxaLatowTRvGo6VuX
        1w485hfx9sLCbD3Jq5DNXXypm1n6xEo4gSdJoaMSRPA6
X-Google-Smtp-Source: ADFU+vs1OKaCfhYsk3ZLqgceZIr7uOgl5r7AdLgYUcjxlwtwPMRQ6uDNBO6ughO/XEUAqjxZzkDuEiXPj5zd5bOvAHc=
X-Received: by 2002:adf:bb06:: with SMTP id r6mr6318759wrg.324.1584453039735;
 Tue, 17 Mar 2020 06:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200316195048.2592199-1-gabravier@gmail.com>
In-Reply-To: <20200316195048.2592199-1-gabravier@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 17 Mar 2020 14:50:03 +0100
Message-ID: <CAMpxmJXHQPDBsuJ_tBhys0wtp1xcsi3irC7uexqW3iXxq=5JAA@mail.gmail.com>
Subject: Re: [PATCH] gpio-hammer: Apply scripts/Lindent and retain good changes
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

pon., 16 mar 2020 o 20:50 Gabriel Ravier <gabravier@gmail.com> napisa=C5=82=
(a):
>
> "retain good changes" means that I left the help string split up instead
> of having this weird thing where it tries to merge together the last thre=
e
> lines and it looks **really** bad
>
> Signed-off-by: Gabriel Ravier <gabravier@gmail.com>
> ---
>  tools/gpio/gpio-hammer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/gpio/gpio-hammer.c b/tools/gpio/gpio-hammer.c
> index 0e0060a6eb34..51a65f8149ea 100644
> --- a/tools/gpio/gpio-hammer.c
> +++ b/tools/gpio/gpio-hammer.c
> @@ -77,7 +77,7 @@ int hammer_device(const char *device_name, unsigned int=
 *lines, int nlines,
>
>                 fprintf(stdout, "[%c] ", swirr[j]);
>                 j++;
> -               if (j =3D=3D sizeof(swirr)-1)
> +               if (j =3D=3D sizeof(swirr) - 1)
>                         j =3D 0;
>
>                 fprintf(stdout, "[");
> --
> 2.24.1
>

Patch applied, thanks!

Bartosz
