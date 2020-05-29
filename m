Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D775BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A4920721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVj1SxIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgE2Miz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Miy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:38:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD0C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:38:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so2110104iow.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GpFpmfPvBmGCrG+YRKg1DrvOcE2InyRqDPpkvzlFCeM=;
        b=mVj1SxIGA3hVciY4NUFoGwHDguUdi8OCtpuRPDrjBwFaVKkhs1v55X0i1OCPFqCHpt
         4rBTnBYnJBmYkfpLc+ndkygjilRiqdzjzJYQ4yJK6NL6PueO8q6FueVbdpfFnfQhfs2E
         NpDpzxYXS1JYaL2scfsyM1nreK4qCmmRFNCawu3VKCvSNWVIRNRoxrGVDLQJkn2ST54I
         qvwRGncVUaze0w9H6AnElFUr91zBTEcXalYBNfP0zCX7CNpDkgNfcFVMFGew7A+YaeFH
         u108q6hPTtFJ1TGTyCu/QujkVDrjG9qp8OIzRSi44tDrgrT9UORoRbLQWWYYjw8dkU44
         MD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GpFpmfPvBmGCrG+YRKg1DrvOcE2InyRqDPpkvzlFCeM=;
        b=Ul1S0hAutCNcjtqExGssmKymBd5N+vFw9xNcRSU6ktfg2VEoGS7xW+tDGQNCpymEuQ
         SfYUxBBTi2d07yPmHDQ8Zt4jbgkCsGaKLWYNM+nii2pFgdxmvpz4z7G2fIstjOm152K1
         ALcjSh5k+88m9KUvZAzGa0zJ5zBTGAKoniHIiIp/6sa9iW2bhuKklFIZ05IzKjKu0POd
         zUhrvw1yDdxoNAf15o95u19Gtkt5stkVk/vch/XanpsUkkTI865+BQgMPcKCd7Kw3fnD
         GsVJta33S8RjATQd2YwHD3znH9j966aJe1eLGp8KADEqwOnlQfQ5hon+ZGCcUhjhM6Dc
         tUKw==
X-Gm-Message-State: AOAM533qB6m0Dgx/K5+sX2fulP9f5X6uKUuufLijyJWdxVkIcccMU+/P
        BenoxRX59uYb3lbFbw1Z8XRWgqJj7AEvix3A1mQ=
X-Google-Smtp-Source: ABdhPJzC5HqY80HYqaqZ/++TCc0BhpKqOpSkx5Q2xANUotb6MLwGX7JT8NDyyJ7xjrJ3CWH29iviOulcsIucJd2TYx4=
X-Received: by 2002:a6b:7841:: with SMTP id h1mr6339900iop.101.1590755933524;
 Fri, 29 May 2020 05:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200510165538.19720-1-peron.clem@gmail.com> <20200510165538.19720-9-peron.clem@gmail.com>
 <3ca4dd51-d868-0d6a-d4ca-37af572190bd@arm.com>
In-Reply-To: <3ca4dd51-d868-0d6a-d4ca-37af572190bd@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 29 May 2020 14:38:42 +0200
Message-ID: <CAJiuCceH-wOHc7wEEtmd+CC==QgqK1nOG6YB389Gs=+0t8i=wg@mail.gmail.com>
Subject: Re: [PATCH 08/15] drm/panfrost: move devfreq_init()/fini() in device
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven

On Thu, 28 May 2020 at 15:22, Steven Price <steven.price@arm.com> wrote:
>
> On 10/05/2020 17:55, Cl=C3=A9ment P=C3=A9ron wrote:
> > Later we will introduce devfreq probing regulator if they
> > are present. As regulator should be probe only one time we
> > need to get this logic in the device_init().
> >
> > panfrost_device is already taking care of devfreq_resume()
> > and devfreq_suspend(), so it's not totally illogic to move
> > the devfreq_init() and devfreq_fini() here.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >   drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++-------=
-
> >   drivers/gpu/drm/panfrost/panfrost_drv.c    | 15 ++-------
> >   2 files changed, 25 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/d=
rm/panfrost/panfrost_device.c
> > index 8136babd3ba9..f480127205d6 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -212,59 +212,67 @@ int panfrost_device_init(struct panfrost_device *=
pfdev)
> >               return err;
> >       }
> >
> > +     err =3D panfrost_devfreq_init(pfdev);
> > +     if (err) {
> > +             dev_err(pfdev->dev, "devfreq init failed %d\n", err);
> > +             goto err_out0;
> > +     }
> > +
> >       err =3D panfrost_regulator_init(pfdev);
> >       if (err) {
> >               dev_err(pfdev->dev, "regulator init failed %d\n", err);
> > -             goto err_out0;
> > +             goto err_out1;
>
> NIT: Rather than just renumbering these can we give them sensible names
> so we don't have this sort of refactoring in future?

Agree, I will change that in v2

>
> >       }
> >
> >       err =3D panfrost_reset_init(pfdev);
> >       if (err) {
> >               dev_err(pfdev->dev, "reset init failed %d\n", err);
> > -             goto err_out1;
> > +             goto err_out2;
> >       }
> >
> >       err =3D panfrost_pm_domain_init(pfdev);
> >       if (err)
> > -             goto err_out2;
> > +             goto err_out3;
> >
> >       res =3D platform_get_resource(pfdev->pdev, IORESOURCE_MEM, 0);
> >       pfdev->iomem =3D devm_ioremap_resource(pfdev->dev, res);
> >       if (IS_ERR(pfdev->iomem)) {
> >               dev_err(pfdev->dev, "failed to ioremap iomem\n");
> >               err =3D PTR_ERR(pfdev->iomem);
> > -             goto err_out3;
> > +             goto err_out4;
> >       }
> >
> >       err =3D panfrost_gpu_init(pfdev);
> >       if (err)
> > -             goto err_out3;
> > +             goto err_out4;
> >
> >       err =3D panfrost_mmu_init(pfdev);
> >       if (err)
> > -             goto err_out4;
> > +             goto err_out5;
> >
> >       err =3D panfrost_job_init(pfdev);
> >       if (err)
> > -             goto err_out5;
> > +             goto err_out6;
> >
> >       err =3D panfrost_perfcnt_init(pfdev);
> >       if (err)
> > -             goto err_out6;
> > +             goto err_out7;
> >
> >       return 0;
> > -err_out6:
> > +err_out7:
> >       panfrost_job_fini(pfdev);
> > -err_out5:
> > +err_out6:
> >       panfrost_mmu_fini(pfdev);
> > -err_out4:
> > +err_out5:
> >       panfrost_gpu_fini(pfdev);
> > -err_out3:
> > +err_out4:
> >       panfrost_pm_domain_fini(pfdev);
> > -err_out2:
> > +err_out3:
> >       panfrost_reset_fini(pfdev);
> > -err_out1:
> > +err_out2:
> >       panfrost_regulator_fini(pfdev);
> > +err_out1:
> > +     panfrost_devfreq_fini(pfdev);
> >   err_out0:
> >       panfrost_clk_fini(pfdev);
> >       return err;
> > @@ -278,6 +286,7 @@ void panfrost_device_fini(struct panfrost_device *p=
fdev)
> >       panfrost_gpu_fini(pfdev);
> >       panfrost_pm_domain_fini(pfdev);
> >       panfrost_reset_fini(pfdev);
> > +     panfrost_devfreq_fini(pfdev);
> >       panfrost_regulator_fini(pfdev);
> >       panfrost_clk_fini(pfdev);
> >   }
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/=
panfrost/panfrost_drv.c
> > index 882fecc33fdb..4dda68689015 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -14,7 +14,6 @@
> >   #include <drm/drm_utils.h>
> >
> >   #include "panfrost_device.h"
> > -#include "panfrost_devfreq.h"
> >   #include "panfrost_gem.h"
> >   #include "panfrost_mmu.h"
> >   #include "panfrost_job.h"
> > @@ -606,13 +605,6 @@ static int panfrost_probe(struct platform_device *=
pdev)
> >               goto err_out0;
> >       }
> >
> > -     err =3D panfrost_devfreq_init(pfdev);
> > -     if (err) {
> > -             if (err !=3D -EPROBE_DEFER)
> > -                     dev_err(&pdev->dev, "Fatal error during devfreq i=
nit\n");
>
> You seem to have lost the check for EPROBE_DEFER during the move.

Correct, sorry for that, I will fix it in v2.

Thanks for your review,
Clement

>
> > -             goto err_out1;
> > -     }
> > -
> >       pm_runtime_set_active(pfdev->dev);
> >       pm_runtime_mark_last_busy(pfdev->dev);
> >       pm_runtime_enable(pfdev->dev);
> > @@ -625,16 +617,14 @@ static int panfrost_probe(struct platform_device =
*pdev)
> >        */
> >       err =3D drm_dev_register(ddev, 0);
> >       if (err < 0)
> > -             goto err_out2;
> > +             goto err_out1;
> >
> >       panfrost_gem_shrinker_init(ddev);
> >
> >       return 0;
> >
> > -err_out2:
> > -     pm_runtime_disable(pfdev->dev);
> > -     panfrost_devfreq_fini(pfdev);
> >   err_out1:
> > +     pm_runtime_disable(pfdev->dev);
> >       panfrost_device_fini(pfdev);
> >   err_out0:
> >       drm_dev_put(ddev);
> > @@ -650,7 +640,6 @@ static int panfrost_remove(struct platform_device *=
pdev)
> >       panfrost_gem_shrinker_cleanup(ddev);
> >
> >       pm_runtime_get_sync(pfdev->dev);
> > -     panfrost_devfreq_fini(pfdev);
> >       panfrost_device_fini(pfdev);
> >       pm_runtime_put_sync_suspend(pfdev->dev);
> >       pm_runtime_disable(pfdev->dev);
> >
>
