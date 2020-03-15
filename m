Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA895C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C2D205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgCOJsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:48:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34083 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgCOJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:48:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id g6so14524762oiy.1;
        Sun, 15 Mar 2020 02:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+LODFo2fy0kDMGy85X+h9jjQYAdzhfINocSjcve4S0=;
        b=pvn2QogDI6jWWm9fX8QHMjFO7Brtp7rxngbmu2uleAfv2dx6vqTrVPnTXX3eurC7f1
         34Gu2JhrfqYxu/KT24K+iysjUgO7JEq1kfN7Df/hfqYeSy/tqxVGnRPSwusFpN6A2U50
         gXp3nmc3J749l7+7xjQQvhMjkn79nHokqIxcyAeFN14q/k/A9MYem9yB4i4Xx4STRzgb
         lAikCzTH7cI9GiIzaNyjrhCdBKEqjk0qLRmTkybUQxSLSaEse0NTWgQT2z6GlOJv82Ut
         cUILnmLBUudf6M95AzGhY61r5D73Vy4lz2xHUt7qSYqkw2RKuFCx/bQLGMIO9HXtU+2D
         RWkQ==
X-Gm-Message-State: ANhLgQ0jZJHQ8rFBCbu1c4ks9667t4Exm9f/B8PMQsZIrf2tZlQ+2uAn
        qeg0q3l+GWqWDFAXU81wPp42mP+hOpgHwput9bRSC/Nj
X-Google-Smtp-Source: ADFU+vuz4qFn0EvbpJhx4q1r3ECpJm4MVPpr63RkM9TAWxt5VDdFu8JNApIGRhZEd++gVv6aHEmpdBMDCW+xs8RJQJk=
X-Received: by 2002:aca:ad93:: with SMTP id w141mr13930641oie.54.1584265691223;
 Sun, 15 Mar 2020 02:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200314052638.6008-1-zhengdejin5@gmail.com> <20200314052638.6008-2-zhengdejin5@gmail.com>
In-Reply-To: <20200314052638.6008-2-zhengdejin5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 15 Mar 2020 10:47:59 +0100
Message-ID: <CAMuHMdVvjvR4J-nB8zmJVH62VGvPPnsLX0+X=aC9p_Dnh_AJ9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drivers: provide devm_platform_ioremap_and_get_resource()
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dejin,

On Sat, Mar 14, 2020 at 6:26 AM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> Since commit "drivers: provide devm_platform_ioremap_resource()",
> It was wrap platform_get_resource() and devm_ioremap_resource() as
> single helper devm_platform_ioremap_resource(). but now, many drivers
> still used platform_get_resource() and devm_ioremap_resource()
> together in the kernel tree. The reason can not be replaced is they
> still need use the resource variables obtained by platform_get_resource().
> so provide this helper.
>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Thanks for your patch!

> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -62,6 +62,24 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>
>  #ifdef CONFIG_HAS_IOMEM
> +/**
> + * devm_platform_ioremap_and_get_resource - call devm_ioremap_resource() for a
> + *                                         platform device and get resource
> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource management
> + * @index: resource index
> + * @res: get the resource
> + */
> +void __iomem *
> +devm_platform_ioremap_and_get_resource(struct platform_device *pdev,
> +                               unsigned int index, struct resource **res)
> +{
> +       *res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +       return devm_ioremap_resource(&pdev->dev, *res);
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_ioremap_and_get_resource);

As this duplicates most of the implementation of
devm_platform_ioremap_resource(),
I think it would be better to make res optional:

    void __iomem *
    devm_platform_ioremap_and_get_resource(struct platform_device *pdev,
                                           unsigned int index, struct
resource **resp)
    {
            struct resource **res;

            res = platform_get_resource(pdev, IORESOURCE_MEM, index);
            if (resp)
                    *resp = res;
            return devm_ioremap_resource(&pdev->dev, *res);
    }

And implement devm_platform_ioremap_resource() by calling
devm_platform_ioremap_and_get_resource() with resp = NULL.
Whether the best way to do that is as an exported functions, or as an
inlined function, is to be seen (measure impact on kernel size).

> +
>  /**
>   * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
>   *                                 device
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 276a03c24691..5fd1977e3eaf 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -55,6 +55,9 @@ extern struct device *
>  platform_find_device_by_driver(struct device *start,
>                                const struct device_driver *drv);
>  extern void __iomem *
> +devm_platform_ioremap_and_get_resource(struct platform_device *pdev,
> +                               unsigned int index, struct resource **res);
> +extern void __iomem *
>  devm_platform_ioremap_resource(struct platform_device *pdev,
>                                unsigned int index);
>  extern void __iomem *

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
