Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A738C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBB8208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="K6SgVbTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJJyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:54:50 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34494 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgBJJyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:54:50 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so6886344iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 01:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=20Wymewe+x5PqdgnKQr7ePARZqrWymwqXgpPdUZ5mPE=;
        b=K6SgVbTr7PiMCAWcIH6RdnOEBwLsaNXgTQ6ozCy9KGZZlwA410tGYPb0bOoi8agKbs
         4zxqB1IVwn/oa6RrhKLdFPZb4fmmHXqheGTuSNKodMdF8lxnZedoYcFiUqK5hXQ6fWCB
         9uLFinyl8Zcgrkm6HvS4Ox4SiIo9+BKKwbp8NIGLW1sb0OCz8BZ+tZHZ7PaIdCS86EkU
         fy6Px3yvHZn7mr0pl6ayPmeneaxPogbR18KHloluViytHj5Yg6H1k6fHZ8nVnzLQMrwr
         btrHMxHpLc+vpaCucRGtnn6ldet5czZ0KinnKNQpDHh0rEJOqLhmUuGK2JaOoB6GUlIZ
         ys+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=20Wymewe+x5PqdgnKQr7ePARZqrWymwqXgpPdUZ5mPE=;
        b=uOk172KMu8aW4Kzz5kSfRyfvRXFJXgMI36AuLZQmJHh6AgelkBGhkY+yXHdCZdBUvg
         aXOS/LfLd0pIkXsv8ZnOnPR5lJVotHRKBbjsbbR+yRr0Sv5b7bpMRGoEu/fU3MncEwV+
         1E1GFFRE6sjuXv7VY1udGkH68YzyUfNUi609avL6Cm9B1Ycj0vjVtlgDG/JqNqYbpKXL
         TE3ZPVLCvfuGx3Bqd27egvQYUyfmVeawIpxgCgeHFTMZ4N6khb8Z9OSea/pxxN03xxOX
         esf/7hJhLZohRrViz+YQ+iKtG2dZrO4jUumO4CH5HGeVYitOLw4Ov84kDZp/jB5lvG9k
         FamA==
X-Gm-Message-State: APjAAAV11Qvm+hHXeYePOSjlfCr46WQtsmKPBzsGPJIcRBcXfeaCWZYa
        m/xHCKJo9MZnIWI5EGwdjREt/D2Y1VmPqq7JeyAjcA==
X-Google-Smtp-Source: APXvYqymAdDtJCWNl3SDZzdgyjavx27Z2bVWg2q4rAtKgBJsi6CJ+1pzyujrN5nBkKwVd9SKHOt3S4i7PHkdum1Q9+4=
X-Received: by 2002:a5d:8952:: with SMTP id b18mr8614428iot.40.1581328488334;
 Mon, 10 Feb 2020 01:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20200209111620.97423-1-sachinagarwal@sachins-MacBook-2.local>
In-Reply-To: <20200209111620.97423-1-sachinagarwal@sachins-MacBook-2.local>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Feb 2020 10:54:37 +0100
Message-ID: <CAMRc=Md9gsrm3OXcMgxd7DuiuZUovBB=Bcqfs7zCLApmgV6A8Q@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: ich: fix a typo
To:     sachin agarwal <asachin591@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 9 lut 2020 o 12:16 sachin agarwal <asachin591@gmail.com> napisa=C5=
=82(a):
>
> From: sachin agarwal <asachin591@gmail.com>
>
> We had written "Mangagment" rather than "Management".
>
> Signed-off-by: Sachin Agarwal <asachin591@gmail.com>
> ---
>  drivers/gpio/gpio-ich.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-ich.c b/drivers/gpio/gpio-ich.c
> index 2f086d0aa1f4..9960bb8b0f5b 100644
> --- a/drivers/gpio/gpio-ich.c
> +++ b/drivers/gpio/gpio-ich.c
> @@ -89,7 +89,7 @@ static struct {
>         struct device *dev;
>         struct gpio_chip chip;
>         struct resource *gpio_base;     /* GPIO IO base */
> -       struct resource *pm_base;       /* Power Mangagment IO base */
> +       struct resource *pm_base;       /* Power Management IO base */
>         struct ichx_desc *desc; /* Pointer to chipset-specific descriptio=
n */
>         u32 orig_gpio_ctrl;     /* Orig CTRL value, used to restore on ex=
it */
>         u8 use_gpio;            /* Which GPIO groups are usable */
> --
> 2.24.1
>

I'm seeing that you have been sending a lot of these single typo
fixes. This is polluting the history and I'm not a fan of that.

Linus: what is your policy on this?

Bartosz
