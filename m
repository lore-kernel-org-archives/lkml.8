Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2871C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9EA24670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H8aaMpsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgANVCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:02:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45878 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:02:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so13540606qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pHjVpCObkuuSiH3NFxvbDr510hiG3gp34w0TWxngRqM=;
        b=H8aaMpsXwTyJtfAF2XxwLoDVguXNNSc6FPcI9JDgIRp+RSmsjUSpoDqmftnW2qJn8h
         ioj+eoGQzk4iUyg+C3Y7AOt4h4nRlOzUfP0XNNjyFW36tWiSeGKrWia4Q+4fFUI9zxII
         b1oA3wm/4OX8k5l41BBSvIWiae129IntY0Ifk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pHjVpCObkuuSiH3NFxvbDr510hiG3gp34w0TWxngRqM=;
        b=q18b0Cgd+dK6RTKxLh7QrVBGv4KOMDUJm121Totk0XqSiwnjR002bUiWbTwczTNPWe
         D6Q2dww6E6limN6GuZO4h98Y4TVBpUWGORcpLbKKphUOPNlyfY+43N6rXpNT2mT5LF21
         O3Td7UWan+miBSCSZvrRsJQHnZQyz6bHZCVd8p7QibNQbZDp3aVuqVVvpF7WQCumaJkx
         ehmvxjoK9BCspYvCJxoXkkc0vtqXfUHL8y6ZUdwWToywr3Ec30bpKz/9+UOy2f8ae+sz
         H0zVDxgtu/RrrVGLU5o+ca7La235dE0UWDtF1JZPlaLkuMpRAHI9DjuVUwqtSRpMV0uX
         ZoOA==
X-Gm-Message-State: APjAAAWZgFHujXaPsE8RlAumkc2H+4F0kKxS8JDRmj1PxYEKNP3qxy+2
        cE834wxt+SgEWwNrQQlWpVwHsVYDxup5uvc9wwmGUA==
X-Google-Smtp-Source: APXvYqxIERByJU81GnxhBLPNSWBVBVmzomBQHzwjnYGX65Uv/Qxt1w8f1rn1WjdtdaSXSTLuXjEPX0yfZHMmt2i2BSc=
X-Received: by 2002:a37:9186:: with SMTP id t128mr22545558qkd.180.1579035753628;
 Tue, 14 Jan 2020 13:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20200114031056.44502-1-pmalani@chromium.org> <b39666db-38e4-c131-bfbb-077a53a8ef69@collabora.com>
 <CACeCKacSiMQOA63c81deGHOvKZb=MEFQqjK=iQRmmot8GrjS+A@mail.gmail.com> <4ddf93f1-fe0c-763c-25d6-144bdce5cd4c@collabora.com>
In-Reply-To: <4ddf93f1-fe0c-763c-25d6-144bdce5cd4c@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 14 Jan 2020 13:02:22 -0800
Message-ID: <CACeCKafFD94EaiCPkJOosQzfRaApsMnh3ciZyUyNCfczmTxGiw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] platform: chrome: Add cros-usbpd-notify driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:29 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
>
>
> On 14/1/20 20:23, Prashant Malani wrote:
> > On Tue, Jan 14, 2020 at 9:07 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Prashant,
> >>
> >> On 14/1/20 4:10, Prashant Malani wrote:
> >>> From: Jon Flatley <jflat@chromium.org>
> >>> +};
> >>> +MODULE_DEVICE_TABLE(acpi, cros_usbpd_acpi_device_ids);
> >> Ops, there is a build error here, please make sure to build the driver=
 before
> >> sending.
> > Hmm. That's odd, I did check  using arm64 defconfig. My apologies.
> > Could you kindly share your build commands so that I can use this
> > going forward?
> >>
> >> s/cros_usbpd_acpi_device_ids/cros_usbpd_notify_acpi_device_ids/
> >>
>
> one problem is the above^
>
> drivers/platform/chrome/cros_usbpd_notify.c:67:27: error:
> =E2=80=98cros_usbpd_acpi_device_ids=E2=80=99 undeclared here (not in a fu=
nction); did you mean
> =E2=80=98cros_usbpd_notify_acpi_device_ids=E2=80=99?
>
> The others I didn't dig in. My build commands are the common.
>
> make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- defconfig
> # Enable the new cros_usbpd_notify driver
> make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j4
This is helpful. Thanks Enric!
>
> Cheers,
>  Enric
>
> >> Apart from this I'm getting build errors with my defconfig which has C=
ONFIG_ACPI
> >> and CONFIG_OF enabled.
> >>
> >> Another problem that I have with this driver is that actually there is=
 no user
> >> for it. I'd really prefer have this included on a series that also int=
roduces
> >> the user of this notifier. If you are only testing the ACPI case you c=
an focus
> >> first on this use case and we add later the OF case (maybe is an easy =
way to
> >> proceed).
> > I'm testing with an arm64 device too locally. I will try to
> > incorporate the new change which updates cros_usbpd-charger to use the
> > notifier mechanism. I think we can try for the OF case simultaneously
> > (it is probably just the build errors I need to check for)
> >
> > Thanks again!
> >>
> >> Thanks,
> >>  Enric
> >>
> >>> +
> >>> +static struct acpi_driver cros_usbpd_notify_acpi_driver =3D {
> >>> +     .name =3D DRV_NAME,
> >>> +     .class =3D DRV_NAME,
> >>> +     .ids =3D cros_usbpd_notify_acpi_device_ids,
> >>> +     .ops =3D {
> >>> +             .add =3D cros_usbpd_notify_add_acpi,
> >>> +             .notify =3D cros_usbpd_notify_acpi,
> >>> +     },
> >>> +};
> >>> +module_acpi_driver(cros_usbpd_notify_acpi_driver);
> >>> +
> >>> +#endif /* CONFIG_ACPI */
> >>> +
> >>> +#ifdef CONFIG_OF
> >>> +
> >>> +static int cros_usbpd_notify_plat(struct notifier_block *nb,
> >>> +             unsigned long queued_during_suspend, void *data)
> >>> +{
> >>> +     struct cros_ec_device *ec_dev =3D (struct cros_ec_device *)data=
;
> >>> +     u32 host_event =3D cros_ec_get_host_event(ec_dev);
> >>> +
> >>> +     if (!host_event)
> >>> +             return NOTIFY_BAD;
> >>> +
> >>> +     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> >>> +             blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> >>> +                             host_event, NULL);
> >>> +             return NOTIFY_OK;
> >>> +     }
> >>> +     return NOTIFY_DONE;
> >>> +}
> >>> +
> >>> +static int cros_usbpd_notify_probe_plat(struct platform_device *pdev=
)
> >>> +{
> >>> +     struct device *dev =3D &pdev->dev;
> >>> +     struct cros_ec_dev *ecdev =3D dev_get_drvdata(dev->parent);
> >>> +     struct notifier_block *nb;
> >>> +     int ret;
> >>> +
> >>> +     nb =3D devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> >>> +     if (!nb)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     nb->notifier_call =3D cros_usbpd_notify_plat;
> >>> +     dev_set_drvdata(dev, nb);
> >>> +
> >>> +     ret =3D blocking_notifier_chain_register(&ecdev->ec_dev->event_=
notifier,
> >>> +                                             nb);
> >>> +     if (ret < 0) {
> >>> +             dev_err(dev, "Failed to register notifier\n");
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int cros_usbpd_notify_remove_plat(struct platform_device *pde=
v)
> >>> +{
> >>> +     struct device *dev =3D &pdev->dev;
> >>> +     struct cros_ec_dev *ecdev =3D dev_get_drvdata(dev->parent);
> >>> +     struct notifier_block *nb =3D
> >>> +             (struct notifier_block *)dev_get_drvdata(dev);
> >>> +
> >>> +     blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifi=
er,
> >>> +                     nb);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static struct platform_driver cros_usbpd_notify_plat_driver =3D {
> >>> +     .driver =3D {
> >>> +             .name =3D DRV_NAME,
> >>> +     },
> >>> +     .probe =3D cros_usbpd_notify_probe_plat,
> >>> +     .remove =3D cros_usbpd_notify_remove_plat,
> >>> +};
> >>> +module_platform_driver(cros_usbpd_notify_plat_driver);
> >>> +
> >>> +#endif /* CONFIG_OF */
> >>> +
> >>> +MODULE_LICENSE("GPL");
> >>> +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
> >>> +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> >>> +MODULE_ALIAS("platform:" DRV_NAME);
> >>> diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/includ=
e/linux/platform_data/cros_usbpd_notify.h
> >>> new file mode 100644
> >>> index 0000000000000..4f2791722b6d3
> >>> --- /dev/null
> >>> +++ b/include/linux/platform_data/cros_usbpd_notify.h
> >>> @@ -0,0 +1,17 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * ChromeOS EC Power Delivery Notifier Driver
> >>> + *
> >>> + * Copyright 2020 Google LLC
> >>> + */
> >>> +
> >>> +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> >>> +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> >>> +
> >>> +#include <linux/notifier.h>
> >>> +
> >>> +int cros_usbpd_register_notify(struct notifier_block *nb);
> >>> +
> >>> +void cros_usbpd_unregister_notify(struct notifier_block *nb);
> >>> +
> >>> +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
> >>>
