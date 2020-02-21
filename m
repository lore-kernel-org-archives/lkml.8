Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B30C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B5720578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIRlx/Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgBUQ02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:26:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43532 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:26:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id s23so1909503lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEsiGHVETpwlrx9fi+Y8ffreY+Moy7t7I8prpX48pGY=;
        b=YIRlx/PxwWRwZFbiqPDrD+GllLKbeMlj8TOyziXCoAV3t50KR3BWMLjDQXXOyoFU3+
         iqSUbPNiyzwosbGAH1t+PND/hoWXjBdwDOHdU4OVa1BI4jReidjUDXGHGufMEGLSY5wP
         RJLszk+Ilh/YhS7sain9VCh3m8hd0E+9onBdJ1WBFdyaJm+Qr5fL7fUd8dgf7XDcyjRL
         hy/ie/CJ2yluPpWXn5dJM7OAyXGQWM7tR1V2uDqv5mDf40Sy+ZSY6/q1lF0WoHOirBMt
         s+k5oTDfIqt7rjAt+ENZgg1fkMVgXIOyaUEhjS/lu3gCtDvjruf/RUquoa3XDrTH5vcO
         w9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEsiGHVETpwlrx9fi+Y8ffreY+Moy7t7I8prpX48pGY=;
        b=KKZcdmsTE7MlLEpfP1+PVIZ4Jnmlg6SjYb7Vw/OhJR+6ass+mQHSxPDFnsMRbwoOfs
         fJJQnIFwZXfFBYFFjnmjoI4WyP7uiHp7ZoSLBPFl7otr18WUcr7alqhs9D2V6HLVX+UR
         t9s/MrmTE/Nrw/hy5W7zbYq4KYjGAN0W5GAnY0y38vpyTEXzuY2Df5yXtQdIUf3XRl6q
         IkgIf0cMZVXXRaTEvo4dWcMlIITmFid5qoVZaDZx1721tey3h6wD15CeOrmiXNrr1RD9
         RlXP/T2uQoriFCDy76pPBj/I6UfQYLk5Ape2PK40ihToHoat+14b7ijo7X5b6guzmaZj
         duvw==
X-Gm-Message-State: APjAAAWrkgqY58pSiDaBlmkMVmTkn5mKUyCN1Kkdzew78PVxygCqb1Cb
        j4FtB0ff+hY+IpO+gmqJgKRmjIlguF/MYPWg1Uf2lw==
X-Google-Smtp-Source: APXvYqywGbEBh7bGuXZLuysiMiKaR5yHQBkjlPXb1Wptk7HKMuran7OsKT4LKbVRZz7BCa7YUX8vyWwiWOdd+xXVIkM=
X-Received: by 2002:ac2:44a5:: with SMTP id c5mr8394490lfm.4.1582302385173;
 Fri, 21 Feb 2020 08:26:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582299415.git.Asmaa@mellanox.com> <d5d95e7b2823ef45878739ea338a1661df2e6a89.1582299415.git.Asmaa@mellanox.com>
In-Reply-To: <d5d95e7b2823ef45878739ea338a1661df2e6a89.1582299415.git.Asmaa@mellanox.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 17:26:13 +0100
Message-ID: <CACRpkdYTRj-on1s55p7eHRdtO--=gJq4mhMeV3F9JbzoM_i6Xw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asmaa,

thanks for your patch!

On Fri, Feb 21, 2020 at 4:40 PM Asmaa Mnebhi <Asmaa@mellanox.com> wrote:

> This patch adds support for the GPIO controller used by
> Mellanox BlueField 2 SOCs.
>
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
(...)

> +config GPIO_MLXBF2
> +       tristate "Mellanox BlueField 2 SoC GPIO"
> +       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST)
> +       select GPIO_GENERIC

This selects GPIO_GENERIC but does not make use of it?

> +/*
> + * gpio[x] block registers and their offset
> + */
> +#define YU_GPIO_DATAOUT                        0x00
> +#define YU_GPIO_DATAIN                 0x04
> +#define YU_GPIO_MODE1                  0x08
> +#define YU_GPIO_MODE0                  0x0c
> +#define YU_GPIO_DATASET                        0x14
> +#define YU_GPIO_DATACLEAR              0x18
> +#define YU_GPIO_MODE1_CLEAR            0x50
> +#define YU_GPIO_MODE0_SET              0x54
> +#define YU_GPIO_MODE0_CLEAR            0x58

This however looks a lot like it could use GPIO_GENERIC.

> +       /* Must hold this lock to modify shared data. */
> +       spinlock_t lock;

Incidentally GPIO_GENERIC accessors also contains
a lock so you don't need to implement that either.

> +       /* All 3 YU GPIO block address */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, GPIO_BLOCKS);
> +       if (!res)
> +               return -ENODEV;

If there are 3 GPIO blocks, simply spawn 3 struct gpio_chip's so you
can use the generic accessors?

> +       /* YU ARM GPIO Lock address */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, ARM_GPIO_LOCK);
> +       if (!res)
> +               return -ENOMEM;

If the direction setting needs some special lock/unlock to happen, why not
just override the .set/get_direction() callbacks?

I would recommend:

- Split in one gpio_chip per instance
- Look at drivers/gpio/gpio-ftgpio010.c on how to populate callbacks
  for each with bgpio_init()
- In struct mlxbf2_gpio_state create some custom direction
  callbacks to store what comes back in direction_input/output
  and indirect the calls from direction_input/output to these
  with locking folded in.

Yours,
Linus Walleij
