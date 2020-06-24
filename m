Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD54520E65
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593000706;
	bh=WYagUbaaOvcmBl2RLbxgGe7ktunh8NJHc8AhXGd16Uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y3mVMuHhPQyROJpkvQttYy14GkrATMIgFopKqQFlC7N1a95GZm2UzBLQbnl3xdQHI
	 uvbaxSAwQ13qWdeQKsiFl6NZ0HyP9cH39Xn5sviK9ZfOcd0geWkbUnvInJ1RCLbF6m
	 uTbP3+vuKbMdsErw55QffbS3vZj41Y9ZsbSDxwNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbgFXMLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:11:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35302 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389662AbgFXMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:11:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id d4so1683191otk.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVKi7y8ESI3KMbXeBIkQdAvJ3a0cM5qUFA8J1Uc5Dz0=;
        b=IdxFGSd0pgRmiLMUcaHnuMTPCdxlA0YSvdga5+Ql53w8+dSK40sulqsj3dyntuJAhe
         yLI3T8ekB7f+kxjEl382JZ9Dquzx6op3LzoiR0rP9+ZSB/AjPH/XD9dP9zP4NjgauD72
         qiMncoZ0gF7kKFhrqgm26cRfofDmDC/fZdj5qBiFPzx5TekUkTzyqCWFGfaA+Pm+6SfO
         kzoro2F8PKADbcdPuXbDZs7ZduB7plo1S/bLY6mdiq0wmRQF1eSpRZa8hDFwgqYp7W+b
         4ViuEZThMYEuRurbmQMkVIoh//dvke/AjovJykTq7p30tWPwHMfNz5NvHL+7+8EKzAO8
         hZGA==
X-Gm-Message-State: AOAM531tGSEWcwOhL2DaYoTthPo6VrzNIH5/jRYse+rFoNXbNYza5yHo
        kOtW+fcsIzGSNm9oasiqvUXBRoX0WDgT1CXpqBM=
X-Google-Smtp-Source: ABdhPJwRO4c/Eg8V5sSsMvFUiIy7kmOS/UHTN+u6H/Zr5xzVGJdr+Iq4WuCtAeHV5U/wdkCKENgkqrcCIN+kZXI5UfU=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr21621638otn.118.1593000701065;
 Wed, 24 Jun 2020 05:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200624114136eucas1p1a3a31d95d86754201c7965f26ccd5de0@eucas1p1.samsung.com>
 <20200624114127.3016-1-a.hajda@samsung.com> <20200624114127.3016-3-a.hajda@samsung.com>
In-Reply-To: <20200624114127.3016-3-a.hajda@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Jun 2020 14:11:28 +0200
Message-ID: <CAJZ5v0hv-jKSegVtNQ2uMde5A6hQ0_ksK0m1CBapqaXZWmV_zg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 2/5] driver core: add deferring probe reason to
 devices_deferred property
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
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c | 10 ++++++----
>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>  3 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 95c22c0f9036..93ef1c2f4c1f 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -93,6 +93,7 @@ struct device_private {
>         struct klist_node knode_class;
>         struct list_head deferred_probe;
>         struct device_driver *async_driver;
> +       char *deferred_probe_msg;

What about calling this deferred_probe_reason?

>         struct device *device;
>         u8 dead:1;
>  };
> @@ -134,6 +135,8 @@ extern void device_release_driver_internal(struct device *dev,
>  extern void driver_detach(struct device_driver *drv);
>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>  extern void driver_deferred_probe_del(struct device *dev);
> +extern void __deferred_probe_set_msg(const struct device *dev,
> +                                    struct va_format *vaf);

I'd call this device_set_deferred_probe_reson() to follow the naming
convention for the function names in this header file.

>  static inline int driver_match_device(struct device_driver *drv,
>                                       struct device *dev)
>  {
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ee9da66bff1b..2a96954d5460 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3962,6 +3962,8 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>   *
>   * This helper implements common pattern present in probe functions for error
>   * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
> + * later by reading devices_deferred debugfs attribute.
>   * It replaces code sequence:
>   *     if (err != -EPROBE_DEFER)
>   *             dev_err(dev, ...);
> @@ -3977,14 +3979,14 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>         struct va_format vaf;
>         va_list args;
>
> -       if (err == -EPROBE_DEFER)
> -               return err;
> -
>         va_start(args, fmt);
>         vaf.fmt = fmt;
>         vaf.va = &args;
>
> -       dev_err(dev, "error %d: %pV", err, &vaf);
> +       if (err == -EPROBE_DEFER)
> +               __deferred_probe_set_msg(dev, &vaf);
> +       else
> +               dev_err(dev, "error %d: %pV", err, &vaf);
>
>         va_end(args);
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9a1d940342ac..f44d26454b6a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -27,6 +27,7 @@
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
> +#include <linux/slab.h>
>
>  #include "base.h"
>  #include "power/power.h"
> @@ -136,6 +137,8 @@ void driver_deferred_probe_del(struct device *dev)
>         if (!list_empty(&dev->p->deferred_probe)) {
>                 dev_dbg(dev, "Removed from deferred list\n");
>                 list_del_init(&dev->p->deferred_probe);
> +               kfree(dev->p->deferred_probe_msg);
> +               dev->p->deferred_probe_msg = NULL;
>         }
>         mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -211,6 +214,21 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +/*
> + * __deferred_probe_set_msg() - Set defer probe reason message for device

I'd change this into a full kerneldoc comment.

> + */
> +void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
> +{
> +       const char *drv = dev_driver_string(dev);
> +
> +       mutex_lock(&deferred_probe_mutex);
> +
> +       kfree(dev->p->deferred_probe_msg);
> +       dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> +
> +       mutex_unlock(&deferred_probe_mutex);
> +}
> +
>  /*
>   * deferred_devs_show() - Show the devices in the deferred probe pending list.
>   */
> @@ -221,7 +239,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>         mutex_lock(&deferred_probe_mutex);
>
>         list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> -               seq_printf(s, "%s\n", dev_name(curr->device));
> +               seq_printf(s, "%s\t%s", dev_name(curr->device),
> +                          curr->device->p->deferred_probe_msg ?: "\n");
>
>         mutex_unlock(&deferred_probe_mutex);
>
> --
> 2.17.1
>
