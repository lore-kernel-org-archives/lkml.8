Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71865C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgCWMo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:44:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46499 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCWMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:44:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id q204so6733915oia.13;
        Mon, 23 Mar 2020 05:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39N5FxH28hMQJbJlqOIGr8VU2Gg2+3CuREbRUZnH+ok=;
        b=m1FgJxLWWN2EOWXIjWYHv21VSTuZuRZIsJ0btyw73undTEgfQHEyHS2joSH/ZIQVm0
         loi3xgRZor14rMw3eRf7Qpin/Olcz5o1aTrjchkU7ZnynGr9VSFsA1eXch6IO1jE1JZD
         i+qeUpG9Cfg89XvbAzLXIyFwU1YpqxzA0BucKQV+65kViUgEyrffCVokKxARYM5v8lh7
         51QUN6vDAg4AUKgFUWIcM+susR8R5r9Y4wHgkSuCRorzwvSKGYLrlriJ/2GY82HstUqQ
         O3zdAwGUXKQ+5gsEf0Bd+YquCcJW8MAxRmoO3KVPcdywWaKxPBktl3TiGzAG6rkEWxwE
         RD6Q==
X-Gm-Message-State: ANhLgQ2wNns5mp/MYDmFxJUdhrjFwHMDoHCiV4nloA60PSQFvoQ50H8y
        GLm1qMWb5KIBuIOM1BJ/RafYTqkAhiwx8Aboyi4=
X-Google-Smtp-Source: ADFU+vv/gsSxc+6YiCICJ4vvrkojNPp7uG8N2PL7YzjEMfp/VUvd0LWmMqP8ql9ldsSOCyQzxfjtiiDTGQruzLfVTyY=
X-Received: by 2002:aca:4e57:: with SMTP id c84mr16133180oib.148.1584967467089;
 Mon, 23 Mar 2020 05:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200315140525.21780-1-zhengdejin5@gmail.com> <20200315140525.21780-2-zhengdejin5@gmail.com>
In-Reply-To: <20200315140525.21780-2-zhengdejin5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Mar 2020 13:44:15 +0100
Message-ID: <CAMuHMdW_1SP-1Z-y7ejUWM1MhTb1_AOiocvq4JwoOcjerUJwEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drivers: provide devm_platform_get_and_ioremap_resource()
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dejin,

On Sun, Mar 15, 2020 at 3:05 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> Since commit "drivers: provide devm_platform_ioremap_resource()",
> it was wrap platform_get_resource() and devm_ioremap_resource() as
> single helper devm_platform_ioremap_resource(). but now, many drivers
> still used platform_get_resource() and devm_ioremap_resource()
> together in the kernel tree. The reason can not be replaced is they
> still need use the resource variables obtained by platform_get_resource().
> so provide this helper.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Thanks for your patch!

> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -62,6 +62,28 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>
>  #ifdef CONFIG_HAS_IOMEM
> +/**
> + * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
> + *                                         platform device and get resource
> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource management
> + * @index: resource index
> + * @res: get the resource

Optional output parameter to store a pointer to the obtained resource.

With the above changed:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> + */
> +void __iomem *
> +devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
> +                               unsigned int index, struct resource **res)
> +{
> +       struct resource *r;
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +       if (res)
> +               *res = r;
> +       return devm_ioremap_resource(&pdev->dev, r);
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
