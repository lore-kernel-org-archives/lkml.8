Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E30C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836C224670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X+or/FqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgANTYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:24:05 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40239 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANTYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:24:05 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so6208345qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRjRPlux6wSyjnZ/ZJLi4YacFFAZNG6NTQbrGZ6UsVI=;
        b=X+or/FqQvJcJefSyOeYni8dpHySKwCWrwsSVsIhbsd2LEAQqTsJigEzCCxPiiUY+8B
         LPN/q5FC3o36GkAT/PIsyB4ODEabpJ8xupqyU3ogulJQ6cALyxu/PAqI4m7wOtXN9Gbi
         jQijUtZ9/mrDcvmbd0KAt0nuXaWmmPRH9R9iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRjRPlux6wSyjnZ/ZJLi4YacFFAZNG6NTQbrGZ6UsVI=;
        b=pJMrzA0wa77SCKUSjx0mVeHgBBke9XkKfsaHgZMHzNbR3JcRJ2vWzmOoKsD/auNm8n
         lBi4HTnI7OFSAKBkAZoSQ8jtNYNNcjHsWwlOnc8DuaUktxtPX6cafWeUQDCtTfbeNiAj
         MOj8HC3I5K0Do4/IXMBFWXPLsdY0onCuav9Cyav2/gyM0RMyEHwDBE1EwWO/YeWb2VDA
         e8jVWUUhGMpe5IEJUXkZayvQyqqXPB1Kn9HkanB/Ywv0jP5mVjOu8pU2mRSWg/DHxbn7
         HhYV2vtGghsYHU24cc/mel84h0Z4XnTuF9/r3IBGyJVSmkiPo3o3yS9Neii7O8I473SV
         8IhA==
X-Gm-Message-State: APjAAAUwFaXphcJmiUlWg5YVbZkkUyi3Fn4VgszSlm42APJzEpOsbWbX
        N9nbopkQpkpTo/e7OqwV60cuuzp5bHMwY8l9DFoq/g==
X-Google-Smtp-Source: APXvYqwdR4jVMhOXoIhk+YkbWUX8vs3i4ybb0/ki/48m/wXDZQdebSO2x8N5F5Nh9TtIjTyPxrmAI58J/5MU6b1NSX4=
X-Received: by 2002:a0c:e790:: with SMTP id x16mr22050544qvn.18.1579029843997;
 Tue, 14 Jan 2020 11:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20200114031056.44502-1-pmalani@chromium.org> <b39666db-38e4-c131-bfbb-077a53a8ef69@collabora.com>
In-Reply-To: <b39666db-38e4-c131-bfbb-077a53a8ef69@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 14 Jan 2020 11:23:53 -0800
Message-ID: <CACeCKacSiMQOA63c81deGHOvKZb=MEFQqjK=iQRmmot8GrjS+A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] platform: chrome: Add cros-usbpd-notify driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 9:07 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 14/1/20 4:10, Prashant Malani wrote:
> > From: Jon Flatley <jflat@chromium.org>
> > +};
> > +MODULE_DEVICE_TABLE(acpi, cros_usbpd_acpi_device_ids);
> Ops, there is a build error here, please make sure to build the driver before
> sending.
Hmm. That's odd, I did check  using arm64 defconfig. My apologies.
Could you kindly share your build commands so that I can use this
going forward?
>
> s/cros_usbpd_acpi_device_ids/cros_usbpd_notify_acpi_device_ids/
>
> Apart from this I'm getting build errors with my defconfig which has CONFIG_ACPI
> and CONFIG_OF enabled.
>
> Another problem that I have with this driver is that actually there is no user
> for it. I'd really prefer have this included on a series that also introduces
> the user of this notifier. If you are only testing the ACPI case you can focus
> first on this use case and we add later the OF case (maybe is an easy way to
> proceed).
I'm testing with an arm64 device too locally. I will try to
incorporate the new change which updates cros_usbpd-charger to use the
notifier mechanism. I think we can try for the OF case simultaneously
(it is probably just the build errors I need to check for)

Thanks again!
>
> Thanks,
>  Enric
>
> > +
> > +static struct acpi_driver cros_usbpd_notify_acpi_driver = {
> > +     .name = DRV_NAME,
> > +     .class = DRV_NAME,
> > +     .ids = cros_usbpd_notify_acpi_device_ids,
> > +     .ops = {
> > +             .add = cros_usbpd_notify_add_acpi,
> > +             .notify = cros_usbpd_notify_acpi,
> > +     },
> > +};
> > +module_acpi_driver(cros_usbpd_notify_acpi_driver);
> > +
> > +#endif /* CONFIG_ACPI */
> > +
> > +#ifdef CONFIG_OF
> > +
> > +static int cros_usbpd_notify_plat(struct notifier_block *nb,
> > +             unsigned long queued_during_suspend, void *data)
> > +{
> > +     struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> > +     u32 host_event = cros_ec_get_host_event(ec_dev);
> > +
> > +     if (!host_event)
> > +             return NOTIFY_BAD;
> > +
> > +     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> > +             blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> > +                             host_event, NULL);
> > +             return NOTIFY_OK;
> > +     }
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> > +     struct notifier_block *nb;
> > +     int ret;
> > +
> > +     nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> > +     if (!nb)
> > +             return -ENOMEM;
> > +
> > +     nb->notifier_call = cros_usbpd_notify_plat;
> > +     dev_set_drvdata(dev, nb);
> > +
> > +     ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
> > +                                             nb);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to register notifier\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> > +     struct notifier_block *nb =
> > +             (struct notifier_block *)dev_get_drvdata(dev);
> > +
> > +     blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
> > +                     nb);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver cros_usbpd_notify_plat_driver = {
> > +     .driver = {
> > +             .name = DRV_NAME,
> > +     },
> > +     .probe = cros_usbpd_notify_probe_plat,
> > +     .remove = cros_usbpd_notify_remove_plat,
> > +};
> > +module_platform_driver(cros_usbpd_notify_plat_driver);
> > +
> > +#endif /* CONFIG_OF */
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
> > +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
> > new file mode 100644
> > index 0000000000000..4f2791722b6d3
> > --- /dev/null
> > +++ b/include/linux/platform_data/cros_usbpd_notify.h
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ChromeOS EC Power Delivery Notifier Driver
> > + *
> > + * Copyright 2020 Google LLC
> > + */
> > +
> > +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> > +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> > +
> > +#include <linux/notifier.h>
> > +
> > +int cros_usbpd_register_notify(struct notifier_block *nb);
> > +
> > +void cros_usbpd_unregister_notify(struct notifier_block *nb);
> > +
> > +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
> >
