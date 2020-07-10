Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D540C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E98206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOfJNQOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgGJJq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgGJJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:46:54 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A8C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:54 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id s21so4543601ilk.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2PkZ0KMfPN1OA7SrWBVa6yVGQXjrOPg2jq/AQlMASlY=;
        b=ZOfJNQOKwRkLfcD2eXSRyILzui2BO7olC4bpIs6yzqjz2vzJ7mSvdWeG9Luhy159Ia
         kUVwCZoutyaVDYjKFg0zXMcDp5rlLlQqtF8MecsaiLh64L8x0R2Eqi5tE9KDQNVOO++1
         DnhrWLxD81m2SDIiWDDnHjq20UCci/3xBhn9BF+GvNfAILrD5lP0J1QTXTNptZuiPIXT
         w2n/tfODNLwasFelYFtAufY9fRURwzSWs0EMn/Nn1SwMcucpUf1uJByfmjwGuJmyTIOY
         Xj6ooLgSR4i9MKZGYQGIiYp21q+vwhQj8cTBhsbG4jQ/lqJeo88Y9GfJJkOWLG16A5++
         s+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2PkZ0KMfPN1OA7SrWBVa6yVGQXjrOPg2jq/AQlMASlY=;
        b=pVFXXt8w8jmE2+DQcJY7tjS/TL+UL9IzFVAw0MAJuc0GxFcIcI6I1DypurL5DRRe3Y
         YjRCtFWmaqODv3x3n51E+bM1VAYlaTMxcOeFrPYJcyFtkPsHp+jXugWJ+L5RanYa1z7q
         aXS6ulDj0lnZS2SYyYbLAbLB+zfSnXddrf0uvqlTqwX0dJIxpwSxzvJWgBphB+BGCXAu
         IpiW8bR2svq2Zi51km4bf/UOgLAuZRFl/yQAcVq7l9mgTd+G10Kc2YQ6LruwvPm/Ti3o
         7oURbKSKuLqeIDJsuukJT6WxbM/gA+O3f3Iqioz1gor7NS0d7sx58mm8SNxWOxiEA6wS
         jADQ==
X-Gm-Message-State: AOAM531CpOhCahUkb8acOrXdYYZpmfErXvHJKXaFnBHSTUX3YCJpK8de
        kHUGgBVbXGJpGP6BXkEkZac5ceB+NeGscqVKCy7QMDhsq4c=
X-Google-Smtp-Source: ABdhPJwcGdIXGchFJo9j3gS5um5v/M6e0fXhjYwH54KU+x8EPpZmCDXIdH3Pn38J7vDe6YaAy4OUikxJ7gVPSmEBQQk=
X-Received: by 2002:a92:4b08:: with SMTP id m8mr48711749ilg.150.1594374413838;
 Fri, 10 Jul 2020 02:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200710092548.316054-1-peron.clem@gmail.com> <20200710092548.316054-5-peron.clem@gmail.com>
In-Reply-To: <20200710092548.316054-5-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 10 Jul 2020 11:46:42 +0200
Message-ID: <CAJiuCcf=RnxkHJ=uoZaWL_p50JB6N0FiZSooLLOSy4pmCuEmZA@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] drm/panfrost: introduce panfrost_devfreq struct
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 10 Jul 2020 at 11:25, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Introduce a proper panfrost_devfreq to deal with devfreq variables.
>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 76 ++++++++++++---------
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h | 20 +++++-
>  drivers/gpu/drm/panfrost/panfrost_device.h  | 11 +--
>  drivers/gpu/drm/panfrost/panfrost_job.c     |  4 +-
>  4 files changed, 65 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index df7b71da9a84..962550363391 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -10,23 +10,23 @@
>  #include "panfrost_device.h"
>  #include "panfrost_devfreq.h"
>
> -static void panfrost_devfreq_update_utilization(struct panfrost_device *=
pfdev)
> +static void panfrost_devfreq_update_utilization(struct panfrost_devfreq =
*pfdevfreq)
>  {
>         ktime_t now;
>         ktime_t last;
>
> -       if (!pfdev->devfreq.devfreq)
> +       if (!pfdevfreq->devfreq)
>                 return;
>
>         now =3D ktime_get();
> -       last =3D pfdev->devfreq.time_last_update;
> +       last =3D pfdevfreq->time_last_update;
>
> -       if (atomic_read(&pfdev->devfreq.busy_count) > 0)
> -               pfdev->devfreq.busy_time +=3D ktime_sub(now, last);
> +       if (atomic_read(&pfdevfreq->busy_count) > 0)
> +               pfdevfreq->busy_time +=3D ktime_sub(now, last);
>         else
> -               pfdev->devfreq.idle_time +=3D ktime_sub(now, last);
> +               pfdevfreq->idle_time +=3D ktime_sub(now, last);
>
> -       pfdev->devfreq.time_last_update =3D now;
> +       pfdevfreq->time_last_update =3D now;
>  }
>
>  static int panfrost_devfreq_target(struct device *dev, unsigned long *fr=
eq,
> @@ -47,30 +47,31 @@ static int panfrost_devfreq_target(struct device *dev=
, unsigned long *freq,
>         return 0;
>  }
>
> -static void panfrost_devfreq_reset(struct panfrost_device *pfdev)
> +static void panfrost_devfreq_reset(struct panfrost_devfreq *pfdevfreq)
>  {
> -       pfdev->devfreq.busy_time =3D 0;
> -       pfdev->devfreq.idle_time =3D 0;
> -       pfdev->devfreq.time_last_update =3D ktime_get();
> +       pfdevfreq->busy_time =3D 0;
> +       pfdevfreq->idle_time =3D 0;
> +       pfdevfreq->time_last_update =3D ktime_get();
>  }
>
>  static int panfrost_devfreq_get_dev_status(struct device *dev,
>                                            struct devfreq_dev_status *sta=
tus)
>  {
>         struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +       struct panfrost_devfreq *pfdevfreq =3D &pfdev->pfdevfreq;
>
> -       panfrost_devfreq_update_utilization(pfdev);
> +       panfrost_devfreq_update_utilization(pfdevfreq);
>
>         status->current_frequency =3D clk_get_rate(pfdev->clock);
> -       status->total_time =3D ktime_to_ns(ktime_add(pfdev->devfreq.busy_=
time,
> -                                                  pfdev->devfreq.idle_ti=
me));
> +       status->total_time =3D ktime_to_ns(ktime_add(pfdevfreq->busy_time=
,
> +                                                  pfdevfreq->idle_time))=
;
>
> -       status->busy_time =3D ktime_to_ns(pfdev->devfreq.busy_time);
> +       status->busy_time =3D ktime_to_ns(pfdevfreq->busy_time);
>
> -       panfrost_devfreq_reset(pfdev);
> +       panfrost_devfreq_reset(pfdevfreq);
>
> -       dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n", s=
tatus->busy_time,
> -               status->total_time,
> +       dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
> +               status->busy_time, status->total_time,
>                 status->busy_time / (status->total_time / 100),
>                 status->current_frequency / 1000 / 1000);
>
> @@ -91,6 +92,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev=
)
>         struct device *dev =3D &pfdev->pdev->dev;
>         struct devfreq *devfreq;
>         struct thermal_cooling_device *cooling;
> +       struct panfrost_devfreq *pfdevfreq =3D &pfdev->pfdevfreq;
>
>         ret =3D dev_pm_opp_of_add_table(dev);
>         if (ret =3D=3D -ENODEV) /* Optional, continue without devfreq */
> @@ -98,7 +100,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfde=
v)
>         else if (ret)
>                 return ret;
>
> -       panfrost_devfreq_reset(pfdev);
> +       panfrost_devfreq_reset(pfdevfreq);
>
>         cur_freq =3D clk_get_rate(pfdev->clock);
>
> @@ -116,53 +118,59 @@ int panfrost_devfreq_init(struct panfrost_device *p=
fdev)
>                 dev_pm_opp_of_remove_table(dev);
>                 return PTR_ERR(devfreq);
>         }
> -       pfdev->devfreq.devfreq =3D devfreq;
> +       pfdevfreq->devfreq =3D devfreq;
>
>         cooling =3D of_devfreq_cooling_register(dev->of_node, devfreq);
>         if (IS_ERR(cooling))
>                 DRM_DEV_INFO(dev, "Failed to register cooling device\n");
>         else
> -               pfdev->devfreq.cooling =3D cooling;
> +               pfdevfreq->cooling =3D cooling;
>
>         return 0;
>  }
>
>  void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>  {
> -       if (pfdev->devfreq.cooling)
> -               devfreq_cooling_unregister(pfdev->devfreq.cooling);
> +       struct panfrost_devfreq *pfdevfreq =3D &pfdev->pfdevfreq;
> +
> +       if (pfdevfreq->cooling)
> +               devfreq_cooling_unregister(pfdevfreq->cooling);
>         dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
>  }
>
>  void panfrost_devfreq_resume(struct panfrost_device *pfdev)
>  {
> -       if (!pfdev->devfreq.devfreq)
> +       struct panfrost_devfreq *pfdevfreq =3D &pfdev->pfdevfreq;
> +
> +       if (!pfdevfreq->devfreq)
>                 return;
>
> -       panfrost_devfreq_reset(pfdev);
> +       panfrost_devfreq_reset(pfdevfreq);
>
> -       devfreq_resume_device(pfdev->devfreq.devfreq);
> +       devfreq_resume_device(pfdevfreq->devfreq);
>  }
>
>  void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
>  {
> -       if (!pfdev->devfreq.devfreq)
> +       struct panfrost_devfreq *pfdevfreq =3D &pfdev->pfdevfreq;
> +
> +       if (!pfdevfreq->devfreq)
>                 return;
>
> -       devfreq_suspend_device(pfdev->devfreq.devfreq);
> +       devfreq_suspend_device(pfdevfreq->devfreq);
>  }
>
> -void panfrost_devfreq_record_busy(struct panfrost_device *pfdev)
> +void panfrost_devfreq_record_busy(struct panfrost_devfreq *pfdevfreq)
>  {
> -       panfrost_devfreq_update_utilization(pfdev);
> -       atomic_inc(&pfdev->devfreq.busy_count);
> +       panfrost_devfreq_update_utilization(pfdevfreq);
> +       atomic_inc(&pfdevfreq->busy_count);
>  }
>
> -void panfrost_devfreq_record_idle(struct panfrost_device *pfdev)
> +void panfrost_devfreq_record_idle(struct panfrost_devfreq *pfdevfreq)
>  {
>         int count;
>
> -       panfrost_devfreq_update_utilization(pfdev);
> -       count =3D atomic_dec_if_positive(&pfdev->devfreq.busy_count);
> +       panfrost_devfreq_update_utilization(pfdevfreq);
> +       count =3D atomic_dec_if_positive(&pfdevfreq->busy_count);
>         WARN_ON(count < 0);
>  }
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.h
> index 0611beffc8d0..0697f8d5aa34 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -4,13 +4,29 @@
>  #ifndef __PANFROST_DEVFREQ_H__
>  #define __PANFROST_DEVFREQ_H__
>
> +#include <linux/ktime.h>
> +
> +struct devfreq;
> +struct thermal_cooling_device;
> +
> +struct panfrost_device;
> +
> +struct panfrost_devfreq {
> +       struct devfreq *devfreq;
> +       struct thermal_cooling_device *cooling;
> +       ktime_t busy_time;
> +       ktime_t idle_time;
> +       ktime_t time_last_update;
> +       atomic_t busy_count;
> +};
> +
>  int panfrost_devfreq_init(struct panfrost_device *pfdev);
>  void panfrost_devfreq_fini(struct panfrost_device *pfdev);
>
>  void panfrost_devfreq_resume(struct panfrost_device *pfdev);
>  void panfrost_devfreq_suspend(struct panfrost_device *pfdev);
>
> -void panfrost_devfreq_record_busy(struct panfrost_device *pfdev);
> -void panfrost_devfreq_record_idle(struct panfrost_device *pfdev);
> +void panfrost_devfreq_record_busy(struct panfrost_devfreq *devfreq);
> +void panfrost_devfreq_record_idle(struct panfrost_devfreq *devfreq);
>
>  #endif /* __PANFROST_DEVFREQ_H__ */
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index c30c719a8059..2efa59c9d1c5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -13,6 +13,8 @@
>  #include <drm/drm_mm.h>
>  #include <drm/gpu_scheduler.h>
>
> +#include "panfrost_devfreq.h"
> +
>  struct panfrost_device;
>  struct panfrost_mmu;
>  struct panfrost_job_slot;
> @@ -107,14 +109,7 @@ struct panfrost_device {
>         struct list_head shrinker_list;
>         struct shrinker shrinker;
>
> -       struct {
> -               struct devfreq *devfreq;
> -               struct thermal_cooling_device *cooling;
> -               ktime_t busy_time;
> -               ktime_t idle_time;
> -               ktime_t time_last_update;
> -               atomic_t busy_count;
> -       } devfreq;
> +       struct panfrost_devfreq pfdevfreq;
>  };
>
>  struct panfrost_mmu {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c

drivers/gpu/drm/panfrost/panfrost_job.c:413:33
I missed on pfdev in my rebase here,

> index 4c13dbae68fb..49b2157d8549 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -145,7 +145,7 @@ static void panfrost_job_hw_submit(struct panfrost_jo=
b *job, int js)
>         u64 jc_head =3D job->jc;
>         int ret;
>
> -       panfrost_devfreq_record_busy(pfdev);
> +       panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
>
>         ret =3D pm_runtime_get_sync(pfdev->dev);
>         if (ret < 0)
> @@ -478,7 +478,7 @@ static irqreturn_t panfrost_job_irq_handler(int irq, =
void *data)
>                                 pfdev->jobs[j] =3D NULL;
>
>                                 panfrost_mmu_as_put(pfdev, &job->file_pri=
v->mmu);
> -                               panfrost_devfreq_record_idle(pfdev);
> +                               panfrost_devfreq_record_idle(&pfdev->pfde=
vfreq);
>
>                                 dma_fence_signal_locked(job->done_fence);
>                                 pm_runtime_put_autosuspend(pfdev->dev);
> --
> 2.25.1
>
