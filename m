Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA9820774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dg9qHz7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgDXGjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbgDXGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:39:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB02BC09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:39:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so9217325qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MI+yH4sWs2g+xaF5o8m/k2oPkU56sjfkGtnomIB4E0U=;
        b=dg9qHz7EDRwXufT/YP6k9XH3SP+J4Xh//jNFQ/EEJX3Nvk0y/SC3n1nt9PMbu0jQ/X
         VvKHCMu8F94TwPTtc555MwZ0CQ4mT22g0uTSgbO933KX3/H1GcfLmykKQO+SYU0LSpBL
         WzyVexhmKOfFxDRtOYgaSZXe7uB7Ipi9U9Nx0bG/ahjksO2aD5C7ZELgYFF5qx1Fa+es
         c/gCbAj0tpavovlvqPWD/tZt9Jufis2GRR3Jg4P008vrb9xN6lOhdU5TudO9A2zcARwL
         ocjyOXAIweMQdtqDEP+aYenA+/JBp8ExxBuOIxZ12fw96S3t6YFPR/5NUypiLRP90Qfj
         /W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MI+yH4sWs2g+xaF5o8m/k2oPkU56sjfkGtnomIB4E0U=;
        b=SLFpUKzYg33JqhGvH4lUrFl2X97uRS+M1TlS4YgPT1ehsORBAa1MxwMZbysdHbTypH
         SAXV7KjF7Cj0/amJXBEELXZ0Mxt6G86AtTlH/4aYEAgr1mLYlEcNWxlp5TGL7xGbyNxf
         my7nbtR126oMmiqxNLhDcK/Uuzq5SvkC6Nn1P+Axvx9I8NflvBxl7F4D7M8NDYCiguX1
         TE/96uekKgdM5ZTqRYjEjPHznLN9gzvpOA+mpjWD7wQ6lppQ3Mcrn3+uPkJtsJeB+kLp
         HuKv7BfkQN/pElmbCWTlUXVKbwlW/P8AoMuY4FIxLSk7j38VHt2JkDF3dlGMEOZrg3ey
         J8Tg==
X-Gm-Message-State: AGi0Pubs+DJQLqVzetboGV4jMiXZ6Ahiskk2/tFJQqpDiKvl6x7uJGOD
        SyTkGkQzhjxJqN8v0MG5GKQ21rvRIeJVURMMGPwR0g==
X-Google-Smtp-Source: APiQypJTxoKTMusG3+g6U7mAgMTkBCtd9S+RSwVgV6Ylt84lBEXLVH/cth7Ecc7CdJxpGo1zxG6AXwY9dmwgK2uLDgw=
X-Received: by 2002:a05:620a:1395:: with SMTP id k21mr7467340qki.120.1587710355206;
 Thu, 23 Apr 2020 23:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200419163816.19856-1-zhengdejin5@gmail.com>
In-Reply-To: <20200419163816.19856-1-zhengdejin5@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 24 Apr 2020 08:39:04 +0200
Message-ID: <CAMpxmJUzrWRuHV-=EOgjd-N-iwhZwVGzF26tH0ybpzZQSP6VJQ@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: fix several typos
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 19 kwi 2020 o 18:38 Dejin Zheng <zhengdejin5@gmail.com> napisa=C5=
=82(a):
>
> Use codespell to fix lots of typos over frontends.
>
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/gpio/gpio-ftgpio010.c | 2 +-
>  drivers/gpio/gpio-mm-lantiq.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.=
c
> index fbddb1662428..4031164780f7 100644
> --- a/drivers/gpio/gpio-ftgpio010.c
> +++ b/drivers/gpio/gpio-ftgpio010.c
> @@ -193,7 +193,7 @@ static int ftgpio_gpio_set_config(struct gpio_chip *g=
c, unsigned int offset,
>         if (val =3D=3D deb_div) {
>                 /*
>                  * The debounce timer happens to already be set to the
> -                * desireable value, what a coincidence! We can just enab=
le
> +                * desirable value, what a coincidence! We can just enabl=
e
>                  * debounce on this GPIO line and return. This happens mo=
re
>                  * often than you think, for example when all GPIO keys
>                  * on a system are requesting the same debounce interval.
> diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.=
c
> index f460d71b0c92..538e31fe8903 100644
> --- a/drivers/gpio/gpio-mm-lantiq.c
> +++ b/drivers/gpio/gpio-mm-lantiq.c
> @@ -36,7 +36,7 @@ struct ltq_mm {
>   * @chip:     Pointer to our private data structure.
>   *
>   * Write the shadow value to the EBU to set the gpios. We need to set th=
e
> - * global EBU lock to make sure that PCI/MTD dont break.
> + * global EBU lock to make sure that PCI/MTD don't break.
>   */
>  static void ltq_mm_apply(struct ltq_mm *chip)
>  {
> --
> 2.25.0
>

The subject line should be gpio: <name of the driver>: short message

And please split those into patches for each driver.

Bart
