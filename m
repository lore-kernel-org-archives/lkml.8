Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C1C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC6B20773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGhljGuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgGMO6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:58:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5814C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:58:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so6114227pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idB200zkk4M6w9/S7/x4u9pjVtl7D3vW0TITJbchsNw=;
        b=MGhljGuEzLpygi69eidMBOHf8JA7D5si19uxVWcDC6Wy1Ds3uBLnXz+J8pmK1Apf4C
         rMmUlG6BbNE4/eHlD2XU9eX/SsqTtl43LhMyugFG9ueLoLh8na9gJF9gzHZi2RsHIAp4
         6pesbK3XrTP9JIQRWJEoKp6puC2JSUW19qeZrksHqiwiKMbntIEIK16tGnrB5kP4T66g
         ZT/J+hRlu+6DCemfhm1vsgZdBrFLrrpBJeVu4nhLxLLp0MHoQvvA3dHs9EOzuPYjNbUS
         By46/6ScZW9bi40KVfwRLM0C/czPMJALxG9Lxbl337r5C17bgkkNmVWQvXxZ81iY9y5u
         W+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idB200zkk4M6w9/S7/x4u9pjVtl7D3vW0TITJbchsNw=;
        b=NlFk9OxbcJ+Wk3n9qm1hZmdxXt2NTjtY8uHEik/gStJeqEgXnLl6rIBoB1MqgYxWJN
         pqkmWDIhPGxaGUkB+r10gPo0weN3S6Pv5Rt1+y7NOJuE/XerTjkRmeA5wQJI9kawFjUB
         rAoYTDKkAg22vdIQ74j/pU9g8S1JdHtl7+BwMGHtDiq1pd1olYaU1GTM8Tg43fe7noDp
         213IpZSbguNQjUZB7f02wMSJZs9lXybD/PrUAv03Sbq7hJ5X3ZnAnQWCJglwjA9eDbmP
         bPAV48gVxM3fIBdfnrozWxjmIx4BeZkytOEB0YgwHwoG4s5mnxAY/jm1A15HfsSynR6O
         Zpkw==
X-Gm-Message-State: AOAM532IPSl7STovzyHuAqF6UafsiL8p4LabBGjw0yXL2uTetRkqbkdX
        yxIbYbe5WTWsPOEbXKmhkdHmapo7SwALa5e8pl8=
X-Google-Smtp-Source: ABdhPJzSyfGH2iI/Q+3QHtm6sw7B/R49Wh2d9hhEuP9TMUliSNgAwNMZgJjgLyFsLds0c5NgdCISMsDDBLwbg/1t0bM=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr61913148pgn.4.1594652332426;
 Mon, 13 Jul 2020 07:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200713144331eucas1p24107a30783dacc92887b80cf082be9fb@eucas1p2.samsung.com>
 <20200713144324.23654-1-a.hajda@samsung.com> <20200713144324.23654-2-a.hajda@samsung.com>
In-Reply-To: <20200713144324.23654-2-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jul 2020 17:58:35 +0300
Message-ID: <CAHp75VdgMgBy2no77YZrAm6p_BCSo9oxpvSrOJMKeBD13SDW=Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] driver core: add device probe log helper
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
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

On Mon, Jul 13, 2020 at 5:43 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> During probe every time driver gets resource it should usually check for
> error printk some message if it is not -EPROBE_DEFER and return the error.
> This pattern is simple but requires adding few lines after any resource
> acquisition code, as a result it is often omitted or implemented only
> partially.
> dev_err_probe helps to replace such code sequences with simple call,
> so code:
>         if (err != -EPROBE_DEFER)
>                 dev_err(dev, ...);
>         return err;
> becomes:
>         return dev_err_probe(dev, err, ...);
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/base/core.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 45 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67d39a90b45c..3a827c82933f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3953,6 +3953,48 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>
>  #endif
>
> +/**
> + * dev_err_probe - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print debug or error message depending if the error value is
> + * -EPROBE_DEFER and propagate error upwards.
> + * It replaces code sequence:
> + *     if (err != -EPROBE_DEFER)
> + *             dev_err(dev, ...);
> + *     else
> + *             dev_dbg(dev, ...);
> + *     return err;
> + * with
> + *     return dev_err_probe(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
> +
> +       va_start(args, fmt);
> +       vaf.fmt = fmt;
> +       vaf.va = &args;

> +       if (err != -EPROBE_DEFER)

I would rather see positive conditional (slightly better to parse when
read), but here I think it's more or less equal.

> +               dev_err(dev, "error %d: %pV", err, &vaf);
> +       else
> +               dev_dbg(dev, "error %d: %pV", err, &vaf);

> +       va_end(args);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(dev_err_probe);
> +
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
>         return fwnode && !IS_ERR(fwnode->secondary);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 15460a5ac024..6b2272ae9af8 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -964,6 +964,9 @@ void device_link_remove(void *consumer, struct device *supplier);
>  void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
>
> +extern __printf(3, 4)
> +int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> +
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
