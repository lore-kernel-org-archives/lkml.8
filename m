Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F451C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C017206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qLk5xYU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgFVQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbgFVQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:50:52 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CDC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:50:52 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so13155786qtg.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zNIXazRbZTl0hNjJl4OuKyr32sJX5wD3ftLoVFvgmfw=;
        b=qLk5xYU+6MCO8B1j+gRdWtyZBWQWjzYhV/+LazyTuBN5g1R95S/Y4JXHO5PFT8ZCn7
         JBVC18sGz5YktASw5JOAsiib9AkM+m6iT5A7rir1JpUq5Gffrr0H4OZ6Vu5FPPKd4iir
         QiADywIlhy5T+looP4rJGXP8anyX5lM9DwHd67sGHUw2A66URTsv6jGsKSkz+fXV161x
         zWxvKMOevq9Hqg3YPchIIq4nN5xdMsulBk9RZeasoZzsVUE9uZuOGKgg+gw8XW35GQSS
         DRfAMHdz3uCCKolLbdY8nd3XpWdGH1OQ+D/KacLXyB7Fy6JGmIeviFZB7G24Cd4Bo4l9
         LKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zNIXazRbZTl0hNjJl4OuKyr32sJX5wD3ftLoVFvgmfw=;
        b=qZ2w+gn3+Bt6oY7XQp4wNnT2DOTqzW5ck4hbfgvdEGcMYipGdUWfnbI4CAjoyf3wZ8
         K8nRavOT90j5kEcWgJ96Y2Ur8LkJrxaa48vjp6iq7RIzAqy5ZjTeIYMNHKeGM4vDovjg
         DBEh2Fq1YpMIe183nxYn573vtx9CS+AjeM7TA+ZOxXZLVwtVaZHBJgdECVw2kOWkX7p0
         smQ5uBQ6r/7az09LVrq5NgWEzublIh6ihfohT9uBqVOhLMLEs/Z7EKflLgkec2pOVZzh
         6G/r9qrIPjs0gYzsHQeRQMh26ecLQOpyXAGxSwTAxViJRD0V8sEVp2BmfdKmRa4GwWON
         MKlg==
X-Gm-Message-State: AOAM532q0yVv1Ste3Dy8Kuo+QQXcCRqYBgCd7grgWGy8MFgn1CxS2ZM7
        vzbgd9MOnj/sJOnLfydIahHsxAmnxl/QdfIw2wuKUQ==
X-Google-Smtp-Source: ABdhPJyL3/bqH4D0qJphsqucAUiUEnZ/g/CZ7SeS110SRX14jdu6QKSOu+pQG/UBfDyE0ONgN4VR83Prp7EvmVjxsW8=
X-Received: by 2002:ac8:23fb:: with SMTP id r56mr17425833qtr.197.1592844651549;
 Mon, 22 Jun 2020 09:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200617235831.25671-1-gaurav1086@gmail.com>
In-Reply-To: <20200617235831.25671-1-gaurav1086@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 22 Jun 2020 18:50:40 +0200
Message-ID: <CAMpxmJW40AO9bEf2LPHk7Pbu_r4tgczaR6uJ6iyHPa8gUmR0=w@mail.gmail.com>
Subject: Re: [PATCH] max732x_probe: remove redundant check
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 18 cze 2020 o 01:58 Gaurav Singh <gaurav1086@gmail.com> napisa=C5=82(=
a):
>
> The check : if (pdata) is redundant since its already
> dereferenced before: pdata->have_64bit_regs;
> pdata is not initialized after that hence remove
> this null check.
>
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  drivers/gpio/gpio-max732x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
> index 5fb0bcf31142..63472f308857 100644
> --- a/drivers/gpio/gpio-max732x.c
> +++ b/drivers/gpio/gpio-max732x.c
> @@ -703,7 +703,7 @@ static int max732x_probe(struct i2c_client *client,
>         if (ret)
>                 return ret;
>
> -       if (pdata && pdata->setup) {
> +       if (pdata->setup) {
>                 ret =3D pdata->setup(client, chip->gpio_chip.base,
>                                 chip->gpio_chip.ngpio, pdata->context);
>                 if (ret < 0)
> --
> 2.17.1
>

The subject should be 'gpio: max732x: ...". I fixed it up and applied
the path to for-next.

Bartosz
