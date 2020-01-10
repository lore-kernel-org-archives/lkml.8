Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBBCC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD4A2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FmZBjhTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgAJI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:26:23 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45659 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgAJI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:26:23 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so1108230iln.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 00:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Mpto8STXUyff3SuN++CYO1ReCNV8kLrYeZBrybALQQ=;
        b=FmZBjhTY7sbuVMCk14C7YB05gIcPfuYjlNIumlGDZGFcvL9gObsjtxhanIt0aREDY1
         yUeIS8tRAPx+xK3UGSEaWYkiRO6HMJDB1w5gMx3egYwW8iw+taMQqD6wf+Fz3B1IguUZ
         gXmgP459EmWBqG/zTFJFLAf9Ld7XBOOGKvG25VSlDIggvxvbJB+c0l8G9jWUCN2bAPp9
         2/rlDZbRvbUUVKzTKnJTFHfi1mQ48le2Uh00ABoAjSYICDDKPXgw1LGelTw8lXqf2h9J
         2ryN5q5rA/42FuIsp+SglWAZtS0a4JdZvTqF1APhypxIZ0KQE9tEi1LRKXhfYLYe9ay1
         B7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Mpto8STXUyff3SuN++CYO1ReCNV8kLrYeZBrybALQQ=;
        b=Kyq6RmR+zoKYmlyNhv/sgrAhgQYe1kfbD69n64reM1W+zPKxmLiNnNh0XruJlXarzM
         /SOLvtJMcafguRZXRLnKfIWBZ6sg1kFGmZrq/X+VLVQHHNkcCFdjHYmO7XTtP1flhEX4
         f5mCWNy7iAZ5Q25HV+a5e+XpKdI6rDQSygAREJszqign5ourNjZbWhGikK4x3wmuBpAj
         aLrbjxpqe452KQBs0FGww0u/EN28U2mJKqYMlJ6OvSjUPrKOApeHup5+sdbvzD0bNBV4
         VcfwpS8QCpvQzlqw/O8Bugh13TmLmz+obpzWeTqGTFHFNbMyvqFAVOhCRfV9p4eGMB03
         LgUg==
X-Gm-Message-State: APjAAAVXrlVEL0/1+Zap0bdpEthTtyZV5hBtTZTE8UzuIxpIIEdQfI/a
        9ehgWbHnnDtE3tOYC2ZhwMsEMNJy50XYPeU4w8n2Fw==
X-Google-Smtp-Source: APXvYqxiZuxf4E+HAmZNdw51irHN6iQPilLO58L76uP/dDwDEuhp/LNJuvWEwYVatV95J0cqnRCHu9XWuHzEaePBa74=
X-Received: by 2002:a92:8712:: with SMTP id m18mr1633334ild.40.1578644782463;
 Fri, 10 Jan 2020 00:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20200110082441.8300-1-brgl@bgdev.pl>
In-Reply-To: <20200110082441.8300-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Jan 2020 09:26:11 +0100
Message-ID: <CAMRc=Mc3hkzJ+Xk_nD3m3uv4_pTUnNaW-0s6Vh3osXCzYBH7fA@mail.gmail.com>
Subject: Re: [PATCH -next] nvmem: fix a 'makes pointer from integer without a
 cast' build warning
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Khouloud Touil <ktouil@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 sty 2020 o 09:24 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> nvmem_register() returns a pointer, not a long int. Use ERR_CAST() to
> cast the struct gpio_desc pointer to struct nvmem_device.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/nvmem/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 3e1c94c4eee8..408ce702347e 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -351,7 +351,7 @@ struct nvmem_device *nvmem_register(const struct nvme=
m_config *config)
>                 nvmem->wp_gpio =3D gpiod_get_optional(config->dev, "wp",
>                                                     GPIOD_OUT_HIGH);
>         if (IS_ERR(nvmem->wp_gpio))
> -               return PTR_ERR(nvmem->wp_gpio);
> +               return ERR_CAST(nvmem->wp_gpio);
>
>
>         kref_init(&nvmem->refcnt);
> --
> 2.23.0
>

Srinivas: this fixes a bug introduced in a patch I took through the
at24 tree. With your ack I'll apply it as a follow-up.

Bart
