Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA667C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FD820706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593186194;
	bh=ZFhUHtGFu5ZIA4z89ukPBSVLkUvs7iACq58UI8CR9kQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NgynZ8TEJf8dcz9QvncmDDJU5R7l9YKos8xlK7TwnAVboRIlDT7prreafWw6SEOWT
	 KmeiNCc7Wr0THrp6ajE0yde8yREVfg+bxRrMm1fBtOB2Jz++tof8qE99UxSVwdF/bu
	 RxBTukulFomjKdnq9KDqXGn+Sam+9mhBDuBZl0G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgFZPnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:43:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38051 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgFZPnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:43:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id r8so8428062oij.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFS0A0GALa85jcwxFWd7qm3+ETIaduqsmP4v2A7mkd4=;
        b=npiJijXIoCkCtVOLfqwsf6veI/39XxNkRL+I0Mor532xc2VF4s/pZbE2HbGEGxz0/n
         pJoTmFId0DvjJKohkd4afklAVqkRZE4+E2Zdstr7y044UqsZQnVMF3dJy73hfk2tvYdc
         C98IC7lxzn+v1J0YTYn5IucH6LVFFjiJzMD+yGb0b6hvTxlBa/NPYAQJSuSKpsImJBFy
         0eb6ED8o0UQh7EYOG6BneR2cyJihpKrVdN3JDQkikDe2uBEyFkK7sLUHG0Yb5to5WBqR
         iKLVTDcHAAiBYs1nWRkb8egrDGPyd9aJJc0SLmozq3lVw0jgIBHS4IRL73bl4GUjchmC
         QaWw==
X-Gm-Message-State: AOAM533Mla6ecaQyGhunhRyWqh0Jy4yyuhnPVu+StjU79aQwFIxcys/W
        iWOdPvoN5hWpBSFcOC8eEWy0TePe9CeazTbFJC2eL+sX
X-Google-Smtp-Source: ABdhPJypLeDV2LckMOXvyTvsspyQajm/zBr0CubHbVFZYs8R4ojC/YhlMLPDnsf5S9DcOktseIn1onDAM7HB1zN92TM=
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr2849111oic.68.1593186191326;
 Fri, 26 Jun 2020 08:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e@eucas1p2.samsung.com>
 <20200626100103.18879-1-a.hajda@samsung.com> <20200626100103.18879-3-a.hajda@samsung.com>
In-Reply-To: <20200626100103.18879-3-a.hajda@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Jun 2020 17:43:00 +0200
Message-ID: <CAJZ5v0g72gY70aKC9DZh=GH6dvGesV5ug0Dc8i0YbX_X1bkCTQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] driver core: add deferring probe reason to
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

On Fri, Jun 26, 2020 at 12:01 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
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

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c |  8 ++++++--
>  drivers/base/dd.c   | 23 ++++++++++++++++++++++-
>  3 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 95c22c0f9036..6954fccab3d7 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -93,6 +93,7 @@ struct device_private {
>         struct klist_node knode_class;
>         struct list_head deferred_probe;
>         struct device_driver *async_driver;
> +       char *deferred_probe_reason;
>         struct device *device;
>         u8 dead:1;
>  };
> @@ -134,6 +135,8 @@ extern void device_release_driver_internal(struct device *dev,
>  extern void driver_detach(struct device_driver *drv);
>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>  extern void driver_deferred_probe_del(struct device *dev);
> +extern void device_set_deferred_probe_reson(const struct device *dev,
> +                                           struct va_format *vaf);
>  static inline int driver_match_device(struct device_driver *drv,
>                                       struct device *dev)
>  {
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3a827c82933f..fee047f03681 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3963,6 +3963,8 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>   * This helper implements common pattern present in probe functions for error
>   * checking: print debug or error message depending if the error value is
>   * -EPROBE_DEFER and propagate error upwards.
> + * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
> + * checked later by reading devices_deferred debugfs attribute.
>   * It replaces code sequence:
>   *     if (err != -EPROBE_DEFER)
>   *             dev_err(dev, ...);
> @@ -3984,10 +3986,12 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
>         vaf.fmt = fmt;
>         vaf.va = &args;
>
> -       if (err != -EPROBE_DEFER)
> +       if (err != -EPROBE_DEFER) {
>                 dev_err(dev, "error %d: %pV", err, &vaf);
> -       else
> +       } else {
> +               device_set_deferred_probe_reson(dev, &vaf);
>                 dev_dbg(dev, "error %d: %pV", err, &vaf);
> +       }
>
>         va_end(args);
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9a1d940342ac..dd5683b61f74 100644
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
> +               kfree(dev->p->deferred_probe_reason);
> +               dev->p->deferred_probe_reason = NULL;
>         }
>         mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -211,6 +214,23 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +/**
> + * device_set_deferred_probe_reson() - Set defer probe reason message for device
> + * @dev: the pointer to the struct device
> + * @vaf: the pointer to va_format structure with message
> + */
> +void device_set_deferred_probe_reson(const struct device *dev, struct va_format *vaf)
> +{
> +       const char *drv = dev_driver_string(dev);
> +
> +       mutex_lock(&deferred_probe_mutex);
> +
> +       kfree(dev->p->deferred_probe_reason);
> +       dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> +
> +       mutex_unlock(&deferred_probe_mutex);
> +}
> +
>  /*
>   * deferred_devs_show() - Show the devices in the deferred probe pending list.
>   */
> @@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>         mutex_lock(&deferred_probe_mutex);
>
>         list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> -               seq_printf(s, "%s\n", dev_name(curr->device));
> +               seq_printf(s, "%s\t%s", dev_name(curr->device),
> +                          curr->device->p->deferred_probe_reason ?: "\n");
>
>         mutex_unlock(&deferred_probe_mutex);
>
> --
> 2.17.1
>
