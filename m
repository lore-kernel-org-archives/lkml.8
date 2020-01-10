Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF3FC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA6C2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c9L+frf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgAJBxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:53:30 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41721 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgAJBxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:53:30 -0500
Received: by mail-qv1-f66.google.com with SMTP id x1so100549qvr.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 17:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/fMVlCqxH7TYnGng6weJicBdaodJmAWTQi+tUFgHll4=;
        b=c9L+frf0rw+duLwmB6qHSNoiIPfTUYtK8oqEW7QzYzMerHKt6OccqOlSyTHGvVCTqf
         Kin2nhmdMCTXyrZ3pw0bAwscFkyMqEwCL5cFVp2kPDTnY8aCLuzokcQrA8pyvA+Npe19
         454L+KinqcoARRXLI9n3K/XrRuEzoeRSNtmtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/fMVlCqxH7TYnGng6weJicBdaodJmAWTQi+tUFgHll4=;
        b=oUSM4Oe9N268z2V6RjEfsIx6q1rjBvXkHEAW13Z+RUjGGCeR4Wa6i6DEp+g9OlWEM1
         FA1Ga/89deEnKOxAnjYNoxTZ00fRBV7JnhSn3C2unR+mCK3TkzDz7Pyk7zoVGarIKt65
         jx/xUcRMIT7Vn6pwoaRAaQZXLbqObbg7jHUpofd+hYQ9JLk5PRGbRpFPdxdktHB7Vnm6
         QKM4OYY80b2lXPlXpTKNZR9tmBLdmq2eTQiANaCcA4qXmN1d5kWTqj1ms/W6QCZwBqRT
         qOWGl5YT42lw6ue6/pts81XN1Vbq17V4cIjxe4O0mgrtRzSZ8MBgEG91XOEOrpJs3D84
         gV4Q==
X-Gm-Message-State: APjAAAVQB8gnMVMpUuSYcpC5fWZMnUCKWQ3vwZ/D0nmREWGxHHNnZc8j
        m8+jL+/SwiNs2PAHyECUV0VgJVA90OGdo2SoFLvglg==
X-Google-Smtp-Source: APXvYqwwMn64xtYJxSAfST4HD4Mcg/Ska64cyK6bvZ7Sz6NVYCLT+MPjgY36iu8O+DTFs0t+m6y7JWQK0aWzGRuwboU=
X-Received: by 2002:a0c:c345:: with SMTP id j5mr555882qvi.156.1578621209242;
 Thu, 09 Jan 2020 17:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org> <20200108052337.65916-6-drinkcat@chromium.org>
 <b58a8cf9-3275-cf89-6dff-596aceeb8000@arm.com>
In-Reply-To: <b58a8cf9-3275-cf89-6dff-596aceeb8000@arm.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 10 Jan 2020 09:53:18 +0800
Message-ID: <CANMq1KBcNr=1_poBHrA_SDo_h-5i3e5TMqASEVaDj5LevsRcOQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/panfrost: Add support for multiple power
 domain support
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ulf to keep me honest on the power domains

On Thu, Jan 9, 2020 at 10:08 PM Steven Price <steven.price@arm.com> wrote:
>
> On 08/01/2020 05:23, Nicolas Boichat wrote:
> > When there is a single power domain per device, the core will
> > ensure the power domains are all switched on.
> >
> > However, when there are multiple ones, as in MT8183 Bifrost GPU,
> > we need to handle them in driver code.
> >
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >
> > The downstream driver we use on chromeos-4.19 currently uses 2
> > additional devices in device tree to accomodate for this [1], but
> > I believe this solution is cleaner.
>
> I'm not sure what is best, but it seems odd to encode this into the Panfr=
ost driver itself - it doesn't have any knowledge of what to do with these =
power domains. The naming of the domains looks suspiciously like someone th=
ought that e.g. only half of the cores could be powered, but it doesn't loo=
k like that was implemented in the chromeos driver linked and anyway that i=
s *meant* to be automatic in the hardware! (I.e. if you only power up one c=
ores in one core stack then the PDC should only enable the power domain for=
 that set of cores).

This is actually implemented in the Chrome OS driver [1]. IMHO power
domains are a bit confusing [2]:
 i. If there's only 1 power domain in the device, then the core takes
care of power on the domain (based on pm_runtime)
 ii. If there's more than 1 power domain, then the device needs to
link the domains manually.

So the Chrome OS [1] driver takes approach (i), by creating 3 devices,
each with 1 power domain that is switched on/off automatically using
pm_runtime.

This patch takes approach (ii) with device links to handle the extra domain=
s.

I believe the latter is more upstream-friendly, but, as always,
suggestions welcome.

[2] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/domai=
n.c#L2466

> Steve
>
> >
> > [1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/r=
efs/heads/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbas=
e_runtime_pm.c#31
> >
> > drivers/gpu/drm/panfrost/panfrost_device.c | 87 ++++++++++++++++++++--
> >   drivers/gpu/drm/panfrost/panfrost_device.h |  4 +
> >   2 files changed, 83 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/d=
rm/panfrost/panfrost_device.c
> > index a0b0a6fef8b4e63..c6e9e059de94a4d 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -5,6 +5,7 @@
> >   #include <linux/clk.h>
> >   #include <linux/reset.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> >   #include <linux/regulator/consumer.h>
> >
> >   #include "panfrost_device.h"
> > @@ -131,6 +132,67 @@ static void panfrost_regulator_fini(struct panfros=
t_device *pfdev)
> >       regulator_disable(pfdev->regulator_sram);
> >   }
> >
> > +static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
> > +             if (!pfdev->pm_domain_devs[i])
> > +                     break;
> > +
> > +             if (pfdev->pm_domain_links[i])
> > +                     device_link_del(pfdev->pm_domain_links[i]);
> > +
> > +             dev_pm_domain_detach(pfdev->pm_domain_devs[i], true);
> > +     }
> > +}
> > +
> > +static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
> > +{
> > +     int err;
> > +     int i, num_domains;
> > +
> > +     num_domains =3D of_count_phandle_with_args(pfdev->dev->of_node,
> > +                                              "power-domains",
> > +                                              "#power-domain-cells");
> > +     /* Single domains are handled by the core. */
> > +     if (num_domains < 2)
> > +             return 0;
> > +
> > +     if (num_domains > ARRAY_SIZE(pfdev->pm_domain_devs)) {
> > +             dev_err(pfdev->dev, "Too many pm-domains: %d\n", num_doma=
ins);
> > +             return -EINVAL;
> > +     }
> > +
> > +     for (i =3D 0; i < num_domains; i++) {
> > +             pfdev->pm_domain_devs[i] =3D
> > +                     dev_pm_domain_attach_by_id(pfdev->dev, i);
> > +             if (IS_ERR(pfdev->pm_domain_devs[i])) {
> > +                     err =3D PTR_ERR(pfdev->pm_domain_devs[i]);
> > +                     pfdev->pm_domain_devs[i] =3D NULL;
> > +                     dev_err(pfdev->dev,
> > +                             "failed to get pm-domain %d: %d\n", i, er=
r);
> > +                     goto err;
> > +             }
> > +
> > +             pfdev->pm_domain_links[i] =3D device_link_add(pfdev->dev,
> > +                             pfdev->pm_domain_devs[i], DL_FLAG_PM_RUNT=
IME |
> > +                             DL_FLAG_STATELESS | DL_FLAG_RPM_ACTIVE);
> > +             if (!pfdev->pm_domain_links[i]) {
> > +                     dev_err(pfdev->pm_domain_devs[i],
> > +                             "adding device link failed!\n");
> > +                     err =3D -ENODEV;
> > +                     goto err;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +
> > +err:
> > +     panfrost_pm_domain_fini(pfdev);
> > +     return err;
> > +}
> > +
> >   int panfrost_device_init(struct panfrost_device *pfdev)
> >   {
> >       int err;
> > @@ -161,37 +223,45 @@ int panfrost_device_init(struct panfrost_device *=
pfdev)
> >               goto err_out1;
> >       }
> >
> > +     err =3D panfrost_pm_domain_init(pfdev);
> > +     if (err) {
> > +             dev_err(pfdev->dev, "pm_domain init failed %d\n", err);
> > +             goto err_out2;
> > +     }
> > +
> >       res =3D platform_get_resource(pfdev->pdev, IORESOURCE_MEM, 0);
> >       pfdev->iomem =3D devm_ioremap_resource(pfdev->dev, res);
> >       if (IS_ERR(pfdev->iomem)) {
> >               dev_err(pfdev->dev, "failed to ioremap iomem\n");
> >               err =3D PTR_ERR(pfdev->iomem);
> > -             goto err_out2;
> > +             goto err_out3;
> >       }
> >
> >       err =3D panfrost_gpu_init(pfdev);
> >       if (err)
> > -             goto err_out2;
> > +             goto err_out3;
> >
> >       err =3D panfrost_mmu_init(pfdev);
> >       if (err)
> > -             goto err_out3;
> > +             goto err_out4;
> >
> >       err =3D panfrost_job_init(pfdev);
> >       if (err)
> > -             goto err_out4;
> > +             goto err_out5;
> >
> >       err =3D panfrost_perfcnt_init(pfdev);
> >       if (err)
> > -             goto err_out5;
> > +             goto err_out6;
> >
> >       return 0;
> > -err_out5:
> > +err_out6:
> >       panfrost_job_fini(pfdev);
> > -err_out4:
> > +err_out5:
> >       panfrost_mmu_fini(pfdev);
> > -err_out3:
> > +err_out4:
> >       panfrost_gpu_fini(pfdev);
> > +err_out3:
> > +     panfrost_pm_domain_fini(pfdev);
> >   err_out2:
> >       panfrost_reset_fini(pfdev);
> >   err_out1:
> > @@ -208,6 +278,7 @@ void panfrost_device_fini(struct panfrost_device *p=
fdev)
> >       panfrost_mmu_fini(pfdev);
> >       panfrost_gpu_fini(pfdev);
> >       panfrost_reset_fini(pfdev);
> > +     panfrost_pm_domain_fini(pfdev);
> >       panfrost_regulator_fini(pfdev);
> >       panfrost_clk_fini(pfdev);
> >   }
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/d=
rm/panfrost/panfrost_device.h
> > index a124334d69e7e93..92d471676fc7823 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -19,6 +19,7 @@ struct panfrost_job;
> >   struct panfrost_perfcnt;
> >
> >   #define NUM_JOB_SLOTS 3
> > +#define MAX_PM_DOMAINS 3
> >
> >   struct panfrost_features {
> >       u16 id;
> > @@ -62,6 +63,9 @@ struct panfrost_device {
> >       struct regulator *regulator;
> >       struct regulator *regulator_sram;
> >       struct reset_control *rstc;
> > +     /* pm_domains for devices with more than one. */
> > +     struct device *pm_domain_devs[MAX_PM_DOMAINS];
> > +     struct device_link *pm_domain_links[MAX_PM_DOMAINS];
> >
> >       struct panfrost_features features;
> >
> >
>
