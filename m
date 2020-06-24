Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBAAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4462088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593000869;
	bh=ZqTcRAy8aSbQEXphGa9vNjZQzY+1SGH/kYfSleTBVDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y8JykLl6VYhFQaZ34myePtkqKyQdJX0TXN0FOAcvPUmpdEm9tlEs4wBd4MqS0A0fQ
	 B9tv9/uqMXuwZ7K6ILvKFoYcxtGkbEQm+17xIfkjU2JKJyBiGS6JHo91oqWr6j0x2j
	 FWRVWLZZQOlg/Fh6gfO8umAO0U2gWC5clhILyWKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390469AbgFXMO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:14:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44774 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbgFXMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:14:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so1650190ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7yu4WkGImMdwZqD5nlzk3Gg+6uRsmowaSAKYfis8Ec=;
        b=cTTIucy5irZvRDjtg+nb4YFXoS7Dt1Y+XV3QgnDsmuJtBjjnGxzBl0kHE20/Y5XuYv
         FjtS9Eoz8q2ydC0bhfY+swiQwYnPNpexdlH3yqYHW+uDmlWpD47kVEaR5Q/3TyV+8XdH
         yjcknkvb8Xu692Y/TZlVtPmKdy08sfTlvDy3B+E9fSzsGBQ2erwPiYdaM4AscWi+t0v1
         HRCWl09FYOGH4gaO1REw7nkHyjVCtgGS0aIuD2ebQKGyhAqph3XQEO67dsief9/vEtbD
         eehMl+TQCJdpA3hGX9WKY6Hsr7cAJXCcxsLwxLDbzpYKSm5H8VrpRuaz4IsKzlU0N/0/
         SWtg==
X-Gm-Message-State: AOAM532GIls34U+eNNq1fr/BYSTtsv4tz6Y2KtL560nLJHYVGqzL5bdh
        kvatxEvs5GofdNhSPB9xjaMZy/T7s4xidgsIyA4=
X-Google-Smtp-Source: ABdhPJy2xm4K83+5ka8fN3jLluj982gNGnXI4403pr+WEf02r/64OmGrKPGCEimwg+rQZsEsniiOURWTwd2GEXytWe8=
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr21642271oto.167.1593000864131;
 Wed, 24 Jun 2020 05:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-1-a.hajda@samsung.com> <20200624114127.3016-4-a.hajda@samsung.com>
In-Reply-To: <20200624114127.3016-4-a.hajda@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Jun 2020 14:14:11 +0200
Message-ID: <CAJZ5v0i7mU3dGGZv3sUwG2_2OCRP3=bPB7a8sstj0qLwmiwhog@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
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
> Many resource acquisition functions return error value encapsulated in
> pointer instead of integer value. To simplify coding we can use macro
> which will accept both types of error.
> With this patch user can use:
>         probe_err(dev, ptr, ...)
> instead of:
>         probe_err(dev, PTR_ERR(ptr), ...)
> Without loosing old functionality:
>         probe_err(dev, err, ...)
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

The separation of this change from patch [1/5] looks kind of artificial to me.

You are introducing a new function anyway, so why not to make it what
you want right away?

> ---
>  drivers/base/core.c    | 25 ++-----------------------
>  include/linux/device.h | 25 ++++++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2a96954d5460..df283c62d9c0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3953,28 +3953,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>
>  #endif
>
> -/**
> - * probe_err - probe error check and log helper
> - * @dev: the pointer to the struct device
> - * @err: error value to test
> - * @fmt: printf-style format string
> - * @...: arguments as specified in the format string
> - *
> - * This helper implements common pattern present in probe functions for error
> - * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> - * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
> - * later by reading devices_deferred debugfs attribute.
> - * It replaces code sequence:
> - *     if (err != -EPROBE_DEFER)
> - *             dev_err(dev, ...);
> - *     return err;
> - * with
> - *     return probe_err(dev, err, ...);
> - *
> - * Returns @err.
> - *
> - */
> -int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +int __probe_err(const struct device *dev, int err, const char *fmt, ...)
>  {
>         struct va_format vaf;
>         va_list args;
> @@ -3992,7 +3971,7 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>
>         return err;
>  }
> -EXPORT_SYMBOL_GPL(probe_err);
> +EXPORT_SYMBOL_GPL(__probe_err);
>
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 40a90d9bf799..22d3c3d4f461 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -965,7 +965,30 @@ void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
>
>  extern __printf(3, 4)
> -int probe_err(const struct device *dev, int err, const char *fmt, ...);
> +int __probe_err(const struct device *dev, int err, const char *fmt, ...);
> +
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test, can be integer or pointer type
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
> + * later by reading devices_deferred debugfs attribute.
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
> +#define probe_err(dev, err, args...) __probe_err(dev, (long)(err), args)
>
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
> --
> 2.17.1
>
