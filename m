Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDE02075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ65UtxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgH1QEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgH1QEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:04:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ACEC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:04:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s9so988253lfs.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oIKbsHLnqvGsELjvqZL61YDeg0eZW/ktTj7wIaqfA5g=;
        b=cJ65UtxIdkdkexD4Co7//9Ao10cVDys/cZGoqx8rLEjrrTz2ZD+9awbcw++Ac0AmIZ
         i7TFHh7HoD0omsgsMqVjKfvkVApaBnDpWq7hOMQ/wbifpkN8GxpQS/6wrc7ZSVlLED/Q
         p+hCkUOhO2OcfYjkS+9/ynOw9YUES/jYbd8Ag2v2qzt0g7jXuAIdzZ6hrvGcwfuNcg/3
         n3innKfu/8VdLQQGRPTTDjlT5jdU0fwdQIqkWc7RfZn8wLHF/G7BCHBfnblzSohPYurG
         HNPDzXQGNSzsCgaREOFnflBNSx7GsRQu7nFW2UO5JxI1O6y0HaueQlCSqTmacwxSZKfS
         PSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oIKbsHLnqvGsELjvqZL61YDeg0eZW/ktTj7wIaqfA5g=;
        b=M7YXtuhQBI5d0IqKYwR9VtA4qxFVyBGPRWn6BUbTQyE+Jc0Tym67/r3vMOVSMK6Wp6
         FKvR06Pb+iiBfSJX8fNMhhA3+Eu4NUhWk8T4+r37IzvO72JGkUpZf3fN+1Vy8oPACsAb
         PcbK82fIgqf71kP/E9R1AmUoLZns3zLbtqLOMfhD/J/WwcIIknT6B9SBw3S4iJKNkiAY
         HKCQCaw31UDtBfiEga+WCDGzEdvPb3P7EyrECS4ehf3KNh0j08vjVjtbMPcClJHdtfOA
         OJ7xmIloUulxLgvB06m5lPxbX8tWhgcVRmVpjlbADuf4MPClGRKJabCsX7IUQSmbFNZ3
         lvGw==
X-Gm-Message-State: AOAM531Cwlwl581me6DHTmqki/kEjiloOLvx0Q0U+GONu40ISPd36Vrn
        rLCpZhx8fvhMZQCmUIXWKB7GmrVDJ1Xo8ExsQ5rGznpM4m8=
X-Google-Smtp-Source: ABdhPJziyHWTa7+B6bpbcJzHK5O9EZWaBgdzUsr1Z4Nf7WpQvcu35jy+NW8zIegquUibNqbpLkgfZOENaQ2D+dM9qK4=
X-Received: by 2002:a05:6512:1044:: with SMTP id c4mr1116974lfb.77.1598630685452;
 Fri, 28 Aug 2020 09:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
 <1595930879-2478-3-git-send-email-kevin3.tang@gmail.com> <20200728204532.GC1277651@ravnborg.org>
In-Reply-To: <20200728204532.GC1277651@ravnborg.org>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Sat, 29 Aug 2020 00:04:34 +0800
Message-ID: <CAFPSGXaXxr+Du0ptbBHguEPgoHULozSUb-rS3-61pef1fF6b-g@mail.gmail.com>
Subject: Re: [PATCH RFC v6 2/6] drm/sprd: add Unisoc's drm kms master
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kevin.
>
> Nice split of the driver.
> Some feedback in the following.
> Most to bring the driver up-to-date with what have happened since
> we saw it last time.
> Keeping up with the changes in drm is not always easy.
>
>         Sam
>
Hi Sam,
Thanks for your feedback,
I am really busy sometimes, but will try my best to keep up with others.

>
> On Tue, Jul 28, 2020 at 06:07:55PM +0800, Kevin Tang wrote:
> > From: Kevin Tang <kevin.tang@unisoc.com>
> >
> > Adds drm support for the Unisoc's display subsystem.
> >
> > This is drm kms driver, this driver provides support for the
> > application framework in Android, Yocto and more.
> >
> > Application framework can access Unisoc's display internel
> > peripherals through libdrm or libkms, it's test ok by modetest
> > (DRM/KMS test tool) and Android HWComposer.
> >
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > ---
> >  drivers/gpu/drm/Kconfig         |   2 +
> >  drivers/gpu/drm/Makefile        |   1 +
> >  drivers/gpu/drm/sprd/Kconfig    |  12 +++
> >  drivers/gpu/drm/sprd/Makefile   |   5 +
> >  drivers/gpu/drm/sprd/sprd_drm.c | 226 ++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/sprd/sprd_drm.h |  16 +++
> >  6 files changed, 262 insertions(+)
> >  create mode 100644 drivers/gpu/drm/sprd/Kconfig
> >  create mode 100644 drivers/gpu/drm/sprd/Makefile
> >  create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
> >  create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index c4fd57d..7fe7ab91 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -386,6 +386,8 @@ source "drivers/gpu/drm/mcde/Kconfig"
> >
> >  source "drivers/gpu/drm/tidss/Kconfig"
> >
> > +source "drivers/gpu/drm/sprd/Kconfig"
> > +
> >  # Keep legacy drivers last
> >
> >  menuconfig DRM_LEGACY
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 2c0e5a7..ee2ccd9 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -123,3 +123,4 @@ obj-$(CONFIG_DRM_PANFROST) +=3D panfrost/
> >  obj-$(CONFIG_DRM_ASPEED_GFX) +=3D aspeed/
> >  obj-$(CONFIG_DRM_MCDE) +=3D mcde/
> >  obj-$(CONFIG_DRM_TIDSS) +=3D tidss/
> > +obj-$(CONFIG_DRM_SPRD) +=3D sprd/
> > diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfi=
g
> > new file mode 100644
> > index 0000000..b189a54
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/Kconfig
> > @@ -0,0 +1,12 @@
> > +config DRM_SPRD
> > +     tristate "DRM Support for Unisoc SoCs Platform"
> > +     depends on ARCH_SPRD || COMPILE_TEST
> > +     depends on DRM && OF
> > +     select DRM_KMS_HELPER
> > +     select DRM_GEM_CMA_HELPER
> > +     select DRM_KMS_CMA_HELPER
> > +     select DRM_MIPI_DSI
> > +     help
> > +       Choose this option if you have a Unisoc chipsets.
> > +       If M is selected the module will be called sprd-drm.
> > +
> > diff --git a/drivers/gpu/drm/sprd/Makefile b/drivers/gpu/drm/sprd/Makef=
ile
> > new file mode 100644
> > index 0000000..86d95d9
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +subdir-ccflags-y +=3D -I$(srctree)/$(src)
> subdir-ccflags-y is not needed - drop it.
>
> > +
> > +obj-y :=3D sprd_drm.o
> > diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/spr=
d_drm.c
> > new file mode 100644
> > index 0000000..4706185
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/sprd_drm.c
> > @@ -0,0 +1,226 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Unisoc Inc.
> > + */
> > +
> > +#include <linux/component.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/of_platform.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_drv.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_probe_helper.h>
> > +#include <drm/drm_vblank.h>
> > +
> > +#include "sprd_drm.h"
> > +
> > +#define DRIVER_NAME  "sprd"
> > +#define DRIVER_DESC  "Spreadtrum SoCs' DRM Driver"
> > +#define DRIVER_DATE  "20200201"
> > +#define DRIVER_MAJOR 1
> > +#define DRIVER_MINOR 0
> > +
> > +static const struct drm_mode_config_helper_funcs sprd_drm_mode_config_=
helper =3D {
> > +     .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
> > +};
> > +
> > +static const struct drm_mode_config_funcs sprd_drm_mode_config_funcs =
=3D {
> > +     .fb_create =3D drm_gem_fb_create,
> > +     .atomic_check =3D drm_atomic_helper_check,
> > +     .atomic_commit =3D drm_atomic_helper_commit,
> > +};
> > +
> > +static void sprd_drm_mode_config_init(struct drm_device *drm)
> > +{
> > +     drm_mode_config_init(drm);
> The documentation of this functions says:
>
> FIXME: This function is deprecated and drivers should be converted over t=
o
> drmm_mode_config_init().
>
>
> > +
> > +     drm->mode_config.min_width =3D 0;
> > +     drm->mode_config.min_height =3D 0;
> > +     drm->mode_config.max_width =3D 8192;
> > +     drm->mode_config.max_height =3D 8192;
> > +     drm->mode_config.allow_fb_modifiers =3D true;
> > +
> > +     drm->mode_config.funcs =3D &sprd_drm_mode_config_funcs;
> > +     drm->mode_config.helper_private =3D &sprd_drm_mode_config_helper;
> > +}
> > +
> > +DEFINE_DRM_GEM_CMA_FOPS(sprd_drm_fops);
> > +
> > +static struct drm_driver sprd_drm_drv =3D {
> > +     .driver_features        =3D DRIVER_GEM | DRIVER_MODESET | DRIVER_=
ATOMIC,
> > +     .fops                   =3D &sprd_drm_fops,
> > +
> > +     /* GEM Operations */
> > +     DRM_GEM_CMA_VMAP_DRIVER_OPS,
> > +
> > +     .name                   =3D DRIVER_NAME,
> > +     .desc                   =3D DRIVER_DESC,
> > +     .date                   =3D DRIVER_DATE,
> > +     .major                  =3D DRIVER_MAJOR,
> > +     .minor                  =3D DRIVER_MINOR,
> > +};
> > +
> > +static int sprd_drm_bind(struct device *dev)
> > +{
> > +     struct drm_device *drm;
> > +     struct sprd_drm *sprd;
> > +     int err;
> > +
> > +     drm =3D drm_dev_alloc(&sprd_drm_drv, dev);
> > +     if (IS_ERR(drm))
> > +             return PTR_ERR(drm);
> > +
> > +     dev_set_drvdata(dev, drm);
> > +
> > +     sprd =3D devm_kzalloc(drm->dev, sizeof(*sprd), GFP_KERNEL);
> > +     if (!sprd)
> > +             err =3D -ENOMEM;
>
> Embed drm_device in sprd_drm and use devm_drm_dev_alloc
> See other drivers and drm_drv.c how to do it.
> drm_drv.c has a nice example explained in one of the comment blocks.
>
> > +
> > +     drm->dev_private =3D sprd;
> dev_private is deprecated. Alwyas use upclassing.
dev_private is deprecated ? I see everyone is still using it, so it
will be deprecated in the future?
>
> > +
> > +     sprd_drm_mode_config_init(drm);
> > +
> > +     /* bind and init sub drivers */
> > +     err =3D component_bind_all(drm->dev, drm);
> > +     if (err) {
> > +             DRM_ERROR("failed to bind all component.\n");
> > +             goto err_dc_cleanup;
> > +     }
> > +
> > +     /* vblank init */
> > +     err =3D drm_vblank_init(drm, drm->mode_config.num_crtc);
> > +     if (err) {
> > +             DRM_ERROR("failed to initialize vblank.\n");
> > +             goto err_unbind_all;
> > +     }
> > +     /* with irq_enabled =3D true, we can use the vblank feature. */
> > +     drm->irq_enabled =3D true;
> Can drm_irq_install() be used?
> Then this flag shall not be set by the driver, And the interrupt numbers =
on different Soc are not necessarily the same
>
We need to set "IRQ_NOAUTOEN" flag for CRTC IRQ, you can see that we
manually turn the interrupt on and off by crtc
atomic_enable/atomic_disable
and the interrupt number on different Soc are not necessarily the
same. So intall interrupt in kms maybe is not suitable for us...
> > +
> > +     /* reset all the states of crtc/plane/encoder/connector */
> > +     drm_mode_config_reset(drm);
> > +
> > +     /* init kms poll for handling hpd */
> > +     drm_kms_helper_poll_init(drm);
> > +
> > +     err =3D drm_dev_register(drm, 0);
> > +     if (err < 0)
> > +             goto err_kms_helper_poll_fini;
> > +
> > +     return 0;
> > +
> > +err_kms_helper_poll_fini:
> > +     drm_kms_helper_poll_fini(drm);
> > +err_unbind_all:
> > +     component_unbind_all(drm->dev, drm);
> > +err_dc_cleanup:
> > +     drm_mode_config_cleanup(drm);
> > +     return err;
> > +}
> > +
> > +static void sprd_drm_unbind(struct device *dev)
> > +{
> > +     struct drm_device *drm =3D dev_get_drvdata(dev);
> > +
> > +     drm_dev_unregister(drm);
> > +
> > +     drm_kms_helper_poll_fini(drm);
> > +
> > +     drm_mode_config_cleanup(drm);
> > +
> > +     component_unbind_all(drm->dev, drm);
> > +     drm->dev_private =3D NULL;
> > +     dev_set_drvdata(dev, NULL);
> > +
> > +     drm_dev_put(drm);
> > +}
> > +
> > +static const struct component_master_ops drm_component_ops =3D {
> > +     .bind =3D sprd_drm_bind,
> > +     .unbind =3D sprd_drm_unbind,
> > +};
> > +
> > +static int compare_of(struct device *dev, void *data)
> > +{
> > +     return dev->of_node =3D=3D data;
> > +}
> > +
> > +static int sprd_drm_probe(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +
> > +     ret =3D dma_set_mask_and_coherent(&pdev->dev, ~0);
> > +     if (ret) {
> > +             DRM_ERROR("dma_set_mask_and_coherent failed (%d)\n", ret)=
;
> > +             return ret;
> > +     }
> > +
> > +     return drm_of_component_probe(&pdev->dev, compare_of, &drm_compon=
ent_ops);
> > +}
> > +
> > +static int sprd_drm_remove(struct platform_device *pdev)
> > +{
> > +     component_master_del(&pdev->dev, &drm_component_ops);
> > +     return 0;
> > +}
> > +
> > +static void sprd_drm_shutdown(struct platform_device *pdev)
> > +{
> > +     struct drm_device *drm =3D platform_get_drvdata(pdev);
> > +
> > +     if (!drm) {
> > +             DRM_WARN("drm device is not available, no shutdown\n");
> > +             return;
> > +     }
> > +
> > +     drm_atomic_helper_shutdown(drm);
> > +}
> > +
> > +static const struct of_device_id drm_match_table[] =3D {
> > +     { .compatible =3D "sprd,display-subsystem", },
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, drm_match_table);
> > +
> > +static struct platform_driver sprd_drm_driver =3D {
> > +     .probe =3D sprd_drm_probe,
> > +     .remove =3D sprd_drm_remove,
> > +     .shutdown =3D sprd_drm_shutdown,
> > +     .driver =3D {
> > +             .name =3D "sprd-drm-drv",
> > +             .of_match_table =3D drm_match_table,
> > +     },
> > +};
> > +
> > +static struct platform_driver *sprd_drm_drivers[]  =3D {
> > +     &sprd_drm_driver,
> > +};
> > +
> > +static int __init sprd_drm_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D platform_register_drivers(sprd_drm_drivers,
> > +                                     ARRAY_SIZE(sprd_drm_drivers));
> > +     return ret;
> > +}
> > +
> > +static void __exit sprd_drm_exit(void)
> > +{
> > +     platform_unregister_drivers(sprd_drm_drivers,
> > +                                 ARRAY_SIZE(sprd_drm_drivers));
> > +}
> > +
> > +module_init(sprd_drm_init);
> > +module_exit(sprd_drm_exit);
> > +
> > +MODULE_AUTHOR("Leon He <leon.he@unisoc.com>");
> > +MODULE_AUTHOR("Kevin Tang <kevin.tang@unisoc.com>");
> > +MODULE_DESCRIPTION("Unisoc DRM KMS Master Driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/gpu/drm/sprd/sprd_drm.h b/drivers/gpu/drm/sprd/spr=
d_drm.h
> > new file mode 100644
> > index 0000000..edf0881
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/sprd_drm.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020 Unisoc Inc.
> > + */
> > +
> > +#ifndef _SPRD_DRM_H_
> > +#define _SPRD_DRM_H_
> > +
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_print.h>
> > +
> > +struct sprd_drm {
> > +     struct drm_device *drm;
> > +};
> > +
> > +#endif /* _SPRD_DRM_H_ */
> > --
> > 2.7.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
