Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D32C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB428206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uauVhkLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgF2TIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbgF2THn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:07:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7265BC030F28
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:38:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f2so7300385plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfKoyluBhqQK8WBSpnVThNVVFytFAMIzrkcMglZ8Sh0=;
        b=uauVhkLqChQY63QDsmizLdb/jQYdWYW2KZ7pDQo7+LSredLUfRUSIycrU7mWGxUqmv
         UqhWWO75apzhc+4AIvEGjaPBN6DgDsjFKLLbLxodJmTZyv5NWBdEI7SN9qeaem1xeojk
         4YuYBBHgFJC1Axa1M4NXPDBt4XfhgZKQAp4wgHVmxX1gQhufADuzSGfbv4UHcpkYfOj7
         q1VsVxAKsaF0O5un27MpbU1wyibjF4fizkGKLO2oiNuG3h8NFSAQlD/cwH+02E3TJnUt
         h1tf5Dv0xt/qmGWxJMBRxbW19fIlwNgnPTt2O9f+wtLKjcFE+X9sFxQyvTbE/GTASltt
         alBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfKoyluBhqQK8WBSpnVThNVVFytFAMIzrkcMglZ8Sh0=;
        b=hqcjUM1xnSrp9OUqsQAWjQlxN4GhmTFcOLVmgf6CW1GEdhA7HoqVwisjPtxNP2+6TI
         HIoE3qV73DTdmjh+OPn/pM0inEQgTsDgZ/Zqkh2aqdbGd66uPf/jpaf2BU6yVvHfLE+t
         00+Ro5occfPu654IBrKFGYTM9GVMxIbdBBgJPMd9eDxwq9PNPztOKXoufXOPEDHoHAeQ
         dGLYQ5U7dmqftf0xdfG2cejZA+HI5h+jGZsBjgjp129lEFkK5tDfj/R6fMek93NzFbS0
         av+uWR6FVhKFBhjZWGQtoilCHQ+6drM7uN87awkaiX1p5smTsstD+Z9L+f6HG0sGQCYq
         8LEg==
X-Gm-Message-State: AOAM5304GMqiACWWRnb3vkt5jVVGe/qnnHjCFQJLJBNVB+yOJEM8NCl6
        dSsLpt5UpxX0gmaY+AlzFNzzO4/CA2LNXsINRFvibwtPK/E=
X-Google-Smtp-Source: ABdhPJyR7dnU1HeSw18RQd4JxqNmjcJaca3SHFEBSw63fP13UbNmoK//y1xzhiGRspEbeWiiZppivaRU9rPhRRIw160=
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr14218920pll.255.1593448697956;
 Mon, 29 Jun 2020 09:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200629112248eucas1p187e5dac2f4f6120aacbc86e48ad0fff9@eucas1p1.samsung.com>
 <20200629112242.18380-1-a.hajda@samsung.com> <20200629112242.18380-2-a.hajda@samsung.com>
In-Reply-To: <20200629112242.18380-2-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Jun 2020 19:38:04 +0300
Message-ID: <CAHp75VegHLG5tgVFjwmpmDfSqELqNXcb9dFSM4jLRx+anW7Lsw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] driver core: add device probe log helper
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

On Mon, Jun 29, 2020 at 2:22 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
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

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(I'm fine with current code, though, consider below comments)

> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
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

Perhaps positive conditional.

> +               dev_err(dev, "error %d: %pV", err, &vaf);
> +       else
> +               dev_dbg(dev, "error %d: %pV", err, &vaf);

Perhaps {} to be added here.

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


-- 
With Best Regards,
Andy Shevchenko
