Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C309C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04AD320706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593186133;
	bh=P8IYjU69AFY5eKHaIU+hw64ziKzzqZ+d1Z7SRKDZsH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J/8YARLjeNHSg147KdnIez59WxNm4BaEC2JBHIJTiknkzMBTu6WBco8gW+YnNJ0Gf
	 dnjpeHt5WpDkB2rCDAvz22BFZNvVF6FgYB0uKE0wFEPvZURPAN4M4rg5ycvGO9tlWG
	 Y+k0Y18ra/MiS/iq4baph/jA9/0M5NL7GbH2fMos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgFZPmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:42:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46893 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgFZPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:42:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id n24so6765942otr.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ude1bR8RU8qUzK94voP4g4TNkMR22P61Cfio3xgn+s=;
        b=JfJ35XuYTQfpdK1OeS9kdKUHfkmTc6Bw2/HqCozQm06jw4x6bsK/jjzYAJudf+PAIV
         9UAbL7O0AvgQziDkCm+YdvDNPR1xOvsVP2zRrb9rtCzPypZU+5paUdU3gtAoO/kEf8y3
         B07FqNnxxq17tpYus4hdF7lpgubxptghqTVEQHsi1rsNX94WScoc/cy0pDBAl7S5XRIr
         8RCFczK+n7tiuamXbyn8aceQDzrt8In6M9RuUBoglDE4kIaBjdFapVLk1tOkiPSPMd3O
         o2HxitBHnL2/T0DyJMN5LUwjk3FPoNxVgef0YXQ1H5PON3wHdNS6+v8NHtuh8GNmVGEY
         CBWA==
X-Gm-Message-State: AOAM5316TyXS0PQXLdBG2hM6Jf7LZ3SQgljSKfCrZtpsKmQRo77v/+t4
        2Yr/nlpLvafiKZcWfuxbZHQdyxjtrM/iFkKiuzy0sQ==
X-Google-Smtp-Source: ABdhPJwykW8CrxuR35IBI3mVnWYSs2LHk0wtbO4rVQPPGyV2Q2g7uhLmf3ZijDe7l5lciP0dn5HkBGfAKNH4nhjtUaE=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr2867799otn.118.1593186130046;
 Fri, 26 Jun 2020 08:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200626100109eucas1p25331652d017cd17d21c0ae60541d1f73@eucas1p2.samsung.com>
 <20200626100103.18879-1-a.hajda@samsung.com> <20200626100103.18879-2-a.hajda@samsung.com>
In-Reply-To: <20200626100103.18879-2-a.hajda@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Jun 2020 17:41:59 +0200
Message-ID: <CAJZ5v0hDNvop_HCEqrwtDCPbNKSvayKUgdQzpi3UkLyZTTykwQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] driver core: add device probe log helper
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

On Fri, Jun 26, 2020 at 12:01 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
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
>         return probe_err(dev, err, ...);
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

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
> +
> +       if (err != -EPROBE_DEFER)
> +               dev_err(dev, "error %d: %pV", err, &vaf);
> +       else
> +               dev_dbg(dev, "error %d: %pV", err, &vaf);
> +
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
