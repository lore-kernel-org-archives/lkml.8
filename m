Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4971AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2454D206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyVs6zij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgEYIGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYIGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:06:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973C1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:06:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so2170221wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9/oovloWt+h7E97JvLdqaDcgFTRvGPO1rjgLxzzS94=;
        b=DyVs6zij9YrWJbjsbObjpQe1Em8pTb4hQru0IPiS+wvCDiIO5bQy3ZTQeSvVUx9wej
         DtWsfi0+j1YgIAvB7MxNbmpP/DrnHzOVS/ASmpI9gjXw4IP6kki4ViARVI1SvTqPCa9G
         XBsLdbQyv/B4c5WVw7C7H6flDUJwHCuhnwVapeDrR3W2uOUiq1JFzSXrkuSNNZosWVnq
         UfO63gqVBYMxsBvOAf2A9woR0TLWPx/76IDOKMFTKGVXf6YjdP3s8liFXf2Ps4qS4kIU
         jUk4VdQlxQHsAz23iUbWdGe9JH6bDm6p9NVXw28jFSdFjBjbtJZ7KlhAwi9xzxqYoNH6
         zEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9/oovloWt+h7E97JvLdqaDcgFTRvGPO1rjgLxzzS94=;
        b=Ok2wo9pgnzJb077aqh2+m/c/ETfwyGTXHD/WUW/vuOTmdjohkd+0kwBP/O6DOCvNdF
         ZNt3K7//oxvoW0TMJ3goyfwsXGA3BeLH+m6FCbhEHRRfz51GyjWx7VGlUP92FEEq7L/k
         +DIGVxIr7nmp2vzXq7fZNjsOSHtLEdRVSENmGlg6sd5aWGqXriOTp5vany3cpQtctXfX
         sbL14ITt5P803W8AKO/7l+RjF6ujvgS8YwwpzzOeFrDpvi/qtqEXgw/6ZCWMGXBNN5Au
         zRzn77VPOjn6VCvjoYcRtCharUQSlZHNQELU769cJK7TmcDDLCig6YpNg8Gz6X4cVb3e
         fCjA==
X-Gm-Message-State: AOAM5318c19tuiD4AhbHn0XDZj3039v2bqQp0AYKKVRJBiq5dggfrCts
        ASjw3pRwGVmTJ6IGodZZRBVktGR1NMe8sgJEgVP/h/ZL33I=
X-Google-Smtp-Source: ABdhPJw/21DHuNj5Ju5exZkm2cdVIZeRsrNx1/VpkZIxqIDpRMpVF+LDb0Jhj/6Rmhl72wSHxMr0jtE8tPYwYLIJ/IE=
X-Received: by 2002:a5d:4385:: with SMTP id i5mr7488540wrq.420.1590394006345;
 Mon, 25 May 2020 01:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <7361f34d712b027f0cd85dc36ee158f9b6076cef.1588833125.git.baolin.wang7@gmail.com>
In-Reply-To: <7361f34d712b027f0cd85dc36ee158f9b6076cef.1588833125.git.baolin.wang7@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 25 May 2020 16:06:09 +0800
Message-ID: <CAAfSe-s6Tp=4QQzU-=YSL9R5LkqAZVQTsWCiQgkgNmyDuM366Q@mail.gmail.com>
Subject: Re: [PATCH] mfd: sprd: Add wakeup capability for PMIC irq
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 at 14:40, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> When changing to use suspend-to-idle to save power, the PMIC irq can not
> wakeup the system due to lack of wakeup capability, which will cause
> the sub-irqs (such as power key) of the PMIC can not wake up the system.
> Thus we can add the wakeup capability for PMIC irq to solve this issue,
> as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
> a wakeup source.
>
> Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Thanks for fixing this issue, with this patch, power key can wakeup
s2idle correctly on my sprd board.

Tested-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index ebdf2f1..3064a60 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -256,7 +256,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
>         }
>
>         ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
> -                                      IRQF_ONESHOT | IRQF_NO_SUSPEND, 0,
> +                                      IRQF_ONESHOT, 0,
>                                        &ddata->irq_chip, &ddata->irq_data);
>         if (ret) {
>                 dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n", ret);
> @@ -272,9 +272,36 @@ static int sprd_pmic_probe(struct spi_device *spi)
>                 return ret;
>         }
>
> +       device_init_wakeup(&spi->dev, 1);
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sprd_pmic_suspend(struct device *dev)
> +{
> +       struct spi_device *spi = to_spi_device(dev);
> +       struct sprd_pmic *ddata = spi_get_drvdata(spi);
> +
> +       if (device_may_wakeup(dev))
> +               enable_irq_wake(ddata->irq);
> +
> +       return 0;
> +}
> +
> +static int sprd_pmic_resume(struct device *dev)
> +{
> +       struct spi_device *spi = to_spi_device(dev);
> +       struct sprd_pmic *ddata = spi_get_drvdata(spi);
> +
> +       if (device_may_wakeup(dev))
> +               disable_irq_wake(ddata->irq);
> +
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
> +
>  static const struct of_device_id sprd_pmic_match[] = {
>         { .compatible = "sprd,sc2731", .data = &sc2731_data },
>         {},
> @@ -286,6 +313,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
>                 .name = "sc27xx-pmic",
>                 .bus = &spi_bus_type,
>                 .of_match_table = sprd_pmic_match,
> +               .pm = &sprd_pmic_pm_ops,
>         },
>         .probe = sprd_pmic_probe,
>  };
> --
> 1.9.1
>
