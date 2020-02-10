Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05887C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D244C20863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHwli6sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBJR7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:59:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33743 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:59:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so3133084plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pCOOvs7wgP9Kvj4DJOrAWEYZ2o8fXqpYVG+BiTgHmVc=;
        b=tHwli6sFHuojuCLon0/ryBewWROo+uN/yAbgmkGqIZJwRPwdmOdkYmng+ZvxsWshbl
         l6w0lKjgiDnA/24zxy5knJ7PId2iOUUUUEmLt0CbOBZ2/wuBqK/KLXjqgbQavyCPNoKL
         VkBPLORv4g4y6amBeTKwSxSkgTLGMS5gfvwcIH1PD0nVXmVg2CP/y3EpeMzGpv8nKjDA
         AIYFitsGZqHcHUQtcAjGvONsQu04Fre4sYAZQTK3B+h95lcT0GJSBrSxv+0thd/OKw7+
         xDnKk4C0Msz914E775JW3VP4y2f3cWfZgMUyWySGjAcY+NWRNiN7yBxVNxasWwN0sK2D
         RYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pCOOvs7wgP9Kvj4DJOrAWEYZ2o8fXqpYVG+BiTgHmVc=;
        b=XNcK6PHHmJTrK1x5JsPt/A/e0+fYUzSuDMOrLvgW3y+jRJPbJdMns+g8OCvH1whpfV
         0I35hTaEUAJ4ny1n8PP4s2ixMpzMbkENpxJihSpUKQHdteL9qxLU9orUD/WARC8uPc5N
         7AoEuSE8rKpRGxWiG4fXjPzSxOt5UpJ75WduSqwSXc7szuYXarxetBhgdT5OHCf+nHwr
         OgHFVW1ee+zvNrdRDjKgKc5VuNrqhel+mwsopOmBga4XqZdZsWoP/uAZT6EehFRlrG+H
         trNqHUk7vuhOG8Sn6ewrRtiTNGbF/fHHEfRsPinE4VfNRRkfANG0UgvJ37zD2T6q4Uah
         wjMw==
X-Gm-Message-State: APjAAAXNeQJbGbWDImgq6UqvWW8QM2UXvHl8LYwwTG2Yybu2LopYyi1k
        zGF6FLjlo8I4/9AqfA/eRF+Cmw==
X-Google-Smtp-Source: APXvYqxAGmn4pRH4Znxw5xSkc/iSQ1uQ/8XO5AmkDzcftwKPqsBPYgIQRIhjSDhHSj++pUTaroWIGw==
X-Received: by 2002:a17:90a:fb45:: with SMTP id iq5mr237107pjb.93.1581357570204;
        Mon, 10 Feb 2020 09:59:30 -0800 (PST)
Received: from localhost (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id g13sm979000pfo.169.2020.02.10.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 09:59:28 -0800 (PST)
Date:   Mon, 10 Feb 2020 09:59:28 -0800 (PST)
X-Google-Original-Date: Mon, 10 Feb 2020 06:57:59 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH] gpio/sifive: fix static checker warning
In-Reply-To: <1580189061-14091-1-git-send-email-yash.shah@sifive.com>
CC:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>, wesley@sifive.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        yash.shah@sifive.com, sachin.ghadi@sifive.com,
        Mark Zyngier <maz@kernel.org>, linux-riscv@lists.infradead.org
To:     yash.shah@sifive.com
Message-ID: <mhng-5d97135c-42fa-437e-93e4-339b97d0123b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 21:24:21 PST (-0800), yash.shah@sifive.com wrote:
> Typcasting "irq_state" leads to the below static checker warning:
> The fix is to declare "irq_state" as unsigned long instead of u32.
>
> 	drivers/gpio/gpio-sifive.c:97 sifive_gpio_irq_enable()
> 	warn: passing casted pointer '&chip->irq_state' to
> 	'assign_bit()' 32 vs 64.
>
> Fixes: 96868dce644d ("gpio/sifive: Add GPIO driver for SiFive SoCs")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  drivers/gpio/gpio-sifive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
> index 147a1bd..c54dd08 100644
> --- a/drivers/gpio/gpio-sifive.c
> +++ b/drivers/gpio/gpio-sifive.c
> @@ -35,7 +35,7 @@ struct sifive_gpio {
>  	void __iomem		*base;
>  	struct gpio_chip	gc;
>  	struct regmap		*regs;
> -	u32			irq_state;
> +	unsigned long		irq_state;
>  	unsigned int		trigger[SIFIVE_GPIO_MAX];
>  	unsigned int		irq_parent[SIFIVE_GPIO_MAX];
>  };
> @@ -94,7 +94,7 @@ static void sifive_gpio_irq_enable(struct irq_data *d)
>  	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>
>  	/* Enable interrupts */
> -	assign_bit(offset, (unsigned long *)&chip->irq_state, 1);
> +	assign_bit(offset, &chip->irq_state, 1);
>  	sifive_gpio_set_ie(chip, offset);
>  }
>
> @@ -104,7 +104,7 @@ static void sifive_gpio_irq_disable(struct irq_data *d)
>  	struct sifive_gpio *chip = gpiochip_get_data(gc);
>  	int offset = irqd_to_hwirq(d) % SIFIVE_GPIO_MAX;
>
> -	assign_bit(offset, (unsigned long *)&chip->irq_state, 0);
> +	assign_bit(offset, &chip->irq_state, 0);
>  	sifive_gpio_set_ie(chip, offset);
>  	irq_chip_disable_parent(d);
>  }

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm assuming this is going to go in via some other tree (as I don't even have
gpio-sifive.c yet), but LMK if you want it via the RISC-V tree.

Thanks!
