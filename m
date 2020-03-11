Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3010EC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D070E22464
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2Fzon0Zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgCKMfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:35:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40504 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgCKMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:35:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id n5so1370492qtv.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T5cO+vNox9HwjS2lqwQ2qXQiWseGejd3Ybtcz8SgsxM=;
        b=2Fzon0ZwCzzv/7AaI/YjiCmlavAXwe2i66o01TKnM725br6N4FUVqhWxmKB4BaBkbc
         6LC3Iid940WDT/7QEVYxsQ5emSFflAPLtVhVQjyUXwd3cqjhXWYLsw8BFql1KUEmUnHQ
         q10gMGZABekkne2ytc2fuKfp3hlchUjR5HpR8eJOkFXLxk7xMZsCSj/nhMrCtZ4S1rHI
         8Zeng55GoDvdnUYftZfOXxR1xr8HgUsqW+x/te6vPoD6AGaVGj4qGS3UxJGi1aK1QFME
         re6Hi1mbaQMcLIsZ8AkMKOf9Vtb/uOpW6mrMxt2sKMd9K5mmKVUE3MmOQYGw+2+5X4Zw
         40xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T5cO+vNox9HwjS2lqwQ2qXQiWseGejd3Ybtcz8SgsxM=;
        b=Ll6tv9xtfFjVPaM/KIpKtY0PUsApDhSUsAXg9+alMl+KQiiPAcecZYAI+3yBCrdzoA
         ovcxAkGmKEO9L8+FaDSp6nWTz9wG9u+3Q6K25XBL4TL/omW2IZZRfG+PhYWY9Rgj6pMn
         2EZ8KZYY29a1e4+yCdLsGuEvPH9LK0+5vk6PbDEVhbE3BM5N9CD855syyrwA+Os9yRd9
         eMxo2tuEsNS62aCIwGIGEVvS6PubPeqobEGcgOkeozNrCJ0/jJsDDhVirhikn9wDV4oz
         inMNywGEZSESorxr71t5O4BWKyZ3RgPr5ZgSrkiXzkcpeYpcoOlFh4DDmc9fwrE4FDht
         cWKQ==
X-Gm-Message-State: ANhLgQ2UYBCXHsIXMzDlHodd86Qr/ea2gfCLLscOUK4NaKzjjMAgtQj3
        29r6b1pt1Yo0TRsVYwDjw5u8KLhdE+L2bh2Up2ESfw==
X-Google-Smtp-Source: ADFU+vsoerkE2fj4dGB1JMHxsRHNClf6XJOZJUddj6pFbGdGYbDhEoy5eidtXv3LEwI0krOht5/bcLQPD61Of9+NWx4=
X-Received: by 2002:aed:36a5:: with SMTP id f34mr2330090qtb.57.1583930122148;
 Wed, 11 Mar 2020 05:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <1583719058-23370-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583719058-23370-1-git-send-email-Anson.Huang@nxp.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Mar 2020 13:35:10 +0100
Message-ID: <CAMpxmJUD_W3ciQE8RYmcw3mSPpRFAVEauC=dcLhDwJ_OM24xKg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxs: add COMPILE_TEST support for GPIO_MXS
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 9 mar 2020 o 03:03 Anson Huang <Anson.Huang@nxp.com> napisa=C5=82(a):
>
> Add COMPILE_TEST support to GPIO_MXS driver for better compile
> testing coverage.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b411226..3cbf888 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -400,7 +400,7 @@ config GPIO_MXC
>
>  config GPIO_MXS
>         def_bool y
> -       depends on ARCH_MXS
> +       depends on ARCH_MXS || COMPILE_TEST
>         select GPIO_GENERIC
>         select GENERIC_IRQ_CHIP
>
> --
> 2.7.4
>

Patch applied, thanks!

Bartosz
