Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEC8C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FE920674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlbRR3Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgCPHfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:35:07 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41286 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPHfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:35:07 -0400
Received: by mail-qv1-f68.google.com with SMTP id a10so8274747qvq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h94iYAosWl5yBs6sDg+dpoMK/SKqP1ik2fFlZ6tXYRI=;
        b=nlbRR3CnLVKmKrelfmARMdBhFRPQYKSelMbbtMg9AzXqHPUs5v5/jmVZ5E6rhRlUD8
         1peMnyn1pNL4WK2P/3aUscerOWo8zY53cWkrzJgp2Kuy+BXYQsrjfviz6USIgXfBlvM/
         bLG09Ht7RRdwLX2ca+4uiTXIPSdL4e+78tKbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h94iYAosWl5yBs6sDg+dpoMK/SKqP1ik2fFlZ6tXYRI=;
        b=SSlItwgaggBrC9qQ7Z/PAjR8DWEd7ibipS3oLDLz8BW75JfGgkgexSya/VVwDWOgTq
         BFR8a67yHKret9PhcXVRzq/c0GfG1sV+IK5mjQxNOtb3YtznBwo5XW//2vfyKgUsMFga
         /KA9jrZCPTQl6YspxzpWnKr0LBXQt+S8/r721KE3RZjEEZBNqugbex33gb45eb8NpP1N
         DdxQrah8rE2ZzuU+gtvsoBjbpx/o3Qupx2GTW7HXnl/iNOHchWuNhsOwrYkz2aBpHKQ+
         PTe1NAH1Rc6by0LZIIuk51mmP19Ty5A/6YD5pDtDs971+f3Gvxo1quwNTl7n9BBgB+UR
         wwuQ==
X-Gm-Message-State: ANhLgQ3x/rKPAeML5VdMIzn4wcZpIfouRP0JjOT2fpvMCjDQiv9b4n05
        kgqPkoj2T7ybjKjEVYAIEdMO1nhe0IPtz4RI4+g9PA==
X-Google-Smtp-Source: ADFU+vssVySOgsmIGKYAwzZaFm9KCzZVtUS36f6nWvzaS7Aj9HpWqieQKk4tjjvH7zuiuYa0yzj3Z4N7VTVThM0fJPY=
X-Received: by 2002:a0c:e88d:: with SMTP id b13mr5891744qvo.219.1584344104793;
 Mon, 16 Mar 2020 00:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200312100809.21153-1-pmalani@chromium.org> <20200312100809.21153-3-pmalani@chromium.org>
 <5f873d6f-5d30-758f-48e4-513b86b39378@collabora.com> <20200315213827.GA185829@google.com>
In-Reply-To: <20200315213827.GA185829@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 16 Mar 2020 00:34:53 -0700
Message-ID: <CACeCKaeQ7jUK-tFj=8XEYEEqkyxrr7Kgei1n2zb7njO4QzN=Ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/chrome: notify: Amend ACPI driver to plat
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Sun, Mar 15, 2020 at 2:38 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Enric,
>
> Thanks a lot for reviewing the patch, kindly see inline:
>
> On Fri, Mar 13, 2020 at 01:42:26PM +0100, Enric Balletbo i Serra wrote:
> > Hi Prashant,
> >
> > On 12/3/20 11:08, Prashant Malani wrote:
> > > Convert the ACPI driver into the equivalent platform driver, with the
> > > same ACPI match table as before. This allows the device driver to access
> > > the parent platform EC device and its cros_ec_device struct, which will
> > > be required to communicate with the EC to pull PD Host event information
> > > from it.
> > >
> > > Also change the ACPI driver name to "cros-usbpd-notify-acpi" so that
> > > there is no confusion between it and the "regular" platform driver on
> > > platforms that have both CONFIG_ACPI and CONFIG_OF enabled.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  drivers/platform/chrome/cros_usbpd_notify.c | 82 ++++++++++++++++++---
> > >  1 file changed, 70 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> > > index edcb346024b07..d2dbf7017e29c 100644
> > > --- a/drivers/platform/chrome/cros_usbpd_notify.c
> > > +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/platform_device.h>
> > >
> > >  #define DRV_NAME "cros-usbpd-notify"
> > > +#define DRV_NAME_PLAT_ACPI "cros-usbpd-notify-acpi"
> > >  #define ACPI_DRV_NAME "GOOG0003"
> > >
> > >  static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> > > @@ -54,14 +55,72 @@ EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
> > >
> > >  #ifdef CONFIG_ACPI
> > >
> > > -static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
> > > +static void cros_usbpd_notify_acpi(acpi_handle device, u32 event, void *data)
> > >  {
> > > +   blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> > > +}
> > > +
> > > +static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
> > > +{
> > > +   struct cros_usbpd_notify_data *pdnotify;
> > > +   struct device *dev = &pdev->dev;
> > > +   struct acpi_device *adev;
> > > +   struct cros_ec_device *ec_dev;
> > > +   acpi_status status;
> > > +
> > > +   adev = ACPI_COMPANION(dev);
> > > +   if (!adev) {
> >
> > I still missing some bits of the ACPI devices but is this possible?
> >
> > The ACPI probe only will be called if there is a match so an ACPI device, I guess.
> >
> Ack. Will remove this check. I was following cros_ec_lpc.c but that is a
> common driver.
>
> > > +           dev_err(dev, "No ACPI device found.\n");
> > > +           return -ENODEV;
> > > +   }
> > > +
> > > +   pdnotify = devm_kzalloc(dev, sizeof(*pdnotify), GFP_KERNEL);
> > > +   if (!pdnotify)
> > > +           return -ENOMEM;
> > > +
> > > +   /* Get the EC device pointer needed to talk to the EC. */
> > > +   ec_dev = dev_get_drvdata(dev->parent);
> > > +   if (!ec_dev) {
> > > +           /*
> > > +            * We continue even for older devices which don't have the
> > > +            * correct device heirarchy, namely, GOOG0003 is a child
> > > +            * of GOOG0004.
> > > +            */
> > > +           dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
> >
> > I'm not sure this is correctly handled, see below ...
> >
> >
> > > +   }
> > > +
> > > +   pdnotify->dev = dev;
> > > +   pdnotify->ec = ec_dev;
> >
> > If !ec_dev you'll assign a NULL pointer to pdnotify->ec. On the cases that
> > GOOG0003 is not a child of GOOG0004 I suspect you will get a NULL dereference
> > later in some other part of the code?
> >
>
> I think there is a comment about this in the Patch 3/3 review, so will
> also address it there. Basically, cros_usbpd_notify_plat() will not have
> a NULL ec_dev, because the platform_probe() only happens for a cros MFD,
> which will be a child of the parent EC device always.
>
> > > +
> > > +   status = acpi_install_notify_handler(adev->handle,
> > > +                                        ACPI_ALL_NOTIFY,
> > > +                                        cros_usbpd_notify_acpi,
> > > +                                        pdnotify);
> > > +   if (ACPI_FAILURE(status)) {
> > > +           dev_warn(dev, "Failed to register notify handler %08x\n",
> > > +                    status);
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   dev_info(dev, "Chrome EC PD notify device registered.\n");
> > > +
> >
> > This is only noise to the kernel log, remove it.
>
> Done.
> >
> > >     return 0;
> > >  }
> > >
> > > -static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
> > > +static int cros_usbpd_notify_remove_acpi(struct platform_device *pdev)
> > >  {
> > > -   blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> > > +   struct device *dev = &pdev->dev;
> > > +   struct acpi_device *adev = ACPI_COMPANION(dev);
> > > +
> > > +   if (!adev) {
> > > +           dev_err(dev, "No ACPI device found.\n");
> >
> > Is this possible?
> >
> Ack. For ACPI probe not possible. Will remove it.
> > > +           return -ENODEV;
> > > +   }
> > > +
> > > +   acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
> > > +                              cros_usbpd_notify_acpi);
> > > +
> > > +   return 0;
> > >  }
> > >
> > >  static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
> > > @@ -70,14 +129,13 @@ static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
> > >
> > > -static struct acpi_driver cros_usbpd_notify_acpi_driver = {
> > > -   .name = DRV_NAME,
> > > -   .class = DRV_NAME,
> > > -   .ids = cros_usbpd_notify_acpi_device_ids,
> > > -   .ops = {
> > > -           .add = cros_usbpd_notify_add_acpi,
> > > -           .notify = cros_usbpd_notify_acpi,
> > > +static struct platform_driver cros_usbpd_notify_acpi_driver = {
> >
> > Nice, so it is converted to a platform_driver, now. This makes me think again if
> > we could just use a single platform_driver and register the acpi notifier in the
> > ACPI match case and use the non-acpi notifier on the OF case.
> >
> I'd like that as well. But, I'm hesitant to make the change now, since I
> don't have a platform which has CONFIG_OF and CONFIG_ACPI on which to
> test the common platform driver with (which is what you use IIRC).
>
> Would something as follows work (pseudo code to follow):
>
> static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
> {
>         struct device *dev = &pdev->dev;
>         struct acpi_device *adev = ACPI_COMPANION(dev);
>
>         /* "Non-ACPI case"
>         if (dev->parent->of_node) {
>                 /* Do non-ACPI case probe work here */
>
>         } else if (adev) {
>                 /* Do ACPI case probe work here */
>         } else {
>                 return -EINVAL;
>         }
> }
>
> and similarly for remove ?
>
> If so, I can change Patch 2/2 to do this :)
Actually, I tried the above out and this causes a compilation failure
for the ARM case (i.e CONFIG_OF && !CONFIG_ACPI), because struct
acpi_device isn't defined for that case. It looks like we might have
to stick with two separate drivers, even if both are platform. Open to
suggestions though.

>
> Best regards,
>
> -Prashant
>
> > > +   .driver = {
> > > +           .name = DRV_NAME_PLAT_ACPI,
> > > +           .acpi_match_table = cros_usbpd_notify_acpi_device_ids,
> > >     },
> > > +   .probe = cros_usbpd_notify_probe_acpi,
> > > +   .remove = cros_usbpd_notify_remove_acpi,
> > >  };
> > >
> > >  #endif /* CONFIG_ACPI */
> > > @@ -159,7 +217,7 @@ static int __init cros_usbpd_notify_init(void)
> > >             return ret;
> > >
> > >  #ifdef CONFIG_ACPI
> > > -   acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
> > > +   platform_driver_register(&cros_usbpd_notify_acpi_driver);
> > >  #endif
> > >     return 0;
> > >  }
> > > @@ -167,7 +225,7 @@ static int __init cros_usbpd_notify_init(void)
> > >  static void __exit cros_usbpd_notify_exit(void)
> > >  {
> > >  #ifdef CONFIG_ACPI
> > > -   acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
> > > +   platform_driver_unregister(&cros_usbpd_notify_acpi_driver);
> > >  #endif
> > >     platform_driver_unregister(&cros_usbpd_notify_plat_driver);
> > >  }
> > >
