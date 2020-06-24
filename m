Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F60C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6792100A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592999594;
	bh=UF5+rngD9+rHBuxSPtdGYW2xb/f3GudR5sSCsXSVlnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=olMRotxz74sjI3z9GQQIxE0SRQhKKkL4xZN2jrNazDcqLBKKr06n9ZUcuOczYAYxK
	 jcWsMqS6guPqPt81nZJM7dtWo7D6aMjHy+0yMkl3MMXI6ktGR2fnzn/EJd7JzT+wQr
	 NxcQ3zqNhgG5I6lr84cxzi71n+KLFdnHpsxezAx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbgFXLxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:53:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45853 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389075AbgFXLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:53:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id p70so1538516oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNOHpEt45vEJASrLn5J9px3ygRO0JRQDAke9QELkVn8=;
        b=q/wagShlJbU/X1cJrdOx72YGROFSkM/p8gjXbcAUwF87EhkyCJuGDcOc38d8wD3QhN
         pceH/u36R2BhfpojBPdzLFUx+9vsJrKUF5vSkwR00JfU36A6zKcA4PXNEgN5MEeUGD44
         mwzlJcjqg1v2x6+W5lpkJQZKuA1hEfhSCZ07T1Ah0Y7mkAYVeXbc6iCnr3zvIMN5HLQt
         Vky10ilcFHYc/es2rKQMqWj+tWYf11C+ScTmdnOXkaOMfd6zG5jajm3BSUu9DqW4HNZF
         yXYzplSKNLoXTg9RHpKDn6sVRUbet8J8tvoeOGxOpC+eqeIeAs5McTVaLAY2uGMnZjUk
         IZLw==
X-Gm-Message-State: AOAM533E/LkIVc3oBZPxV86J2o/ADq61x2GpNxQ0mcLctv+qJDbJrz/Q
        hQK2RVeiWINZb8F6Jk+RYnssL4KuX8M8PJiU7mI=
X-Google-Smtp-Source: ABdhPJw9eddIszcs6PWjGbc/pFF08ar5iUhFqSypqdZ+Wn1a80hW5gYdrDvdok5pF67jxVAZIVpQC78HX0EEkrL/CTU=
X-Received: by 2002:a54:4585:: with SMTP id z5mr1960621oib.110.1592999590943;
 Wed, 24 Jun 2020 04:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200624114135eucas1p26e2e4683d60cebdce7acd55177013992@eucas1p2.samsung.com>
 <20200624114127.3016-1-a.hajda@samsung.com> <20200624114127.3016-2-a.hajda@samsung.com>
In-Reply-To: <20200624114127.3016-2-a.hajda@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Jun 2020 13:52:58 +0200
Message-ID: <CAJZ5v0iZ_1o8nuGoRGuv++v81ZtDBxfPf-=U_+ZZdv1dgvrY2Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 1/5] driver core: add probe_err log helper
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 1:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:
>         if (err != -EPROBE_DEFER)
>                 dev_err(dev, ...);
>         return err;
> becomes:
>         return probe_err(dev, err, ...);
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67d39a90b45c..ee9da66bff1b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3953,6 +3953,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>
>  #endif
>
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * It replaces code sequence:
> + *     if (err != -EPROBE_DEFER)
> + *             dev_err(dev, ...);
> + *     return err;
> + * with
> + *     return probe_err(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
> +
> +       if (err == -EPROBE_DEFER)
> +               return err;
> +
> +       va_start(args, fmt);
> +       vaf.fmt = fmt;
> +       vaf.va = &args;
> +
> +       dev_err(dev, "error %d: %pV", err, &vaf);
> +
> +       va_end(args);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(probe_err);
> +
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
>         return fwnode && !IS_ERR(fwnode->secondary);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 15460a5ac024..40a90d9bf799 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -964,6 +964,9 @@ void device_link_remove(void *consumer, struct device *supplier);
>  void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
>
> +extern __printf(3, 4)
> +int probe_err(const struct device *dev, int err, const char *fmt, ...);
> +
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
> --
> 2.17.1
>
