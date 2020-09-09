Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A35C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A21A20C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKCBOrW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIIEGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgIIEGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:06:04 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C14C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 21:06:04 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id v78so894469ybv.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 21:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5l1eticj7qDEdDrm+OGUOAk8jXt5YDIoOSHNMBDZgrs=;
        b=QKCBOrW+n5uJloRSW/TtfMCk2ECMuKI0/Ix/ZlH1tx5chIYiuGO+fPBqUG39J/laqA
         tT3nj1TNAuEingDRkUbUa8yoGpLSXKacXQFIDkr4DuKukTkqc3r1tCZ6vRrhX76HFZ8R
         GvK4q2OapZQtyohQaPR40jrK6INB98O7Nsvp0yU/p1N7Ccjky2/e8SbNvxHuNTETNvtC
         KvuQZb/CpjTwhdYz0fuV+qXCCX/Zbbz62G6be0r39Le319Ah8pliXMsv+QYG+3PH3zJV
         /Q9+noQh1ZjjhzE2wg2ieli4Xuu9go5nTuYyKG9ox9LELbmLhYpHIZ6J0Y6iIpvB737Z
         dtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5l1eticj7qDEdDrm+OGUOAk8jXt5YDIoOSHNMBDZgrs=;
        b=DGS3v3u3kuoLDUT+zJFomTeKowsGGp/o2Y4C5yNojV4p6Amg2i/3ucYG0FgnF82Yqq
         G/TEa3bt2h+Qos2bDQozHaZD5CA3zO9sBJNXd04sPr3m894j+crWILmX7Tz7iwktHf5m
         EK3Dm1V0C9bbauAVorNLzcMDs7YtWCfilRj9mtST+78yudo4qgx2dzqjV6eyNpuMMzGv
         6W63z/Cy2yHHdyzmCR2DbxnNopxw6CQWe2ILLmVRP5P0YorJI70GRShHCv2DOytYXURj
         JVUo++Kge0QkOFwAff/AEtsVUknvWpCNE2v1FBqD9RpW2Dyrva4azfK0FtF54cJQ8TKf
         PLog==
X-Gm-Message-State: AOAM530u8tgZTI9B3ktAxt/LsuV1QRU4sEY3rqsoqp76TuaGMuc3TcFj
        hL8ptH5YV445r4o855c6p6PN6QclnVjgRyOTTZQ=
X-Google-Smtp-Source: ABdhPJy9FO00MIL4D9dDFJBguiKSTl16emuFaEgF/hSBMy+cayLwOwEwIBBW7+th3r2A/O5CkHUDdgMCa8tuQni/HeE=
X-Received: by 2002:a25:bc82:: with SMTP id e2mr2918057ybk.435.1599624363612;
 Tue, 08 Sep 2020 21:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200812204952.1921587-1-jcline@redhat.com>
In-Reply-To: <20200812204952.1921587-1-jcline@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 9 Sep 2020 14:05:52 +1000
Message-ID: <CACAvsv71oxCYB1+LCAUHD5v_NGAP-DpxPY_dPz53iw2=91KAJg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Add fine-grain temperature reporting
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 at 06:50, Jeremy Cline <jcline@redhat.com> wrote:
>
> Commit d32656373857 ("drm/nouveau/therm/gp100: initial implementation of
> new gp1xx temperature sensor") added support for reading finer-grain
> temperatures, but continued to report temperatures in 1 degree Celsius
> increments via nvkm_therm_temp_get().
>
> Rather than altering nvkm_therm_temp_get() to report finer-grain
> temperatures, which would be inconvenient for other users of the
> function, a second interface has been added to line up with hwmon's
> native unit of temperature.
Hey Jeremy,

Sorry this slipped past me until now.  I'm OK with adding support for
millidegree temperature reporting, but don't think we need to keep
both interfaces around and would rather see the existing code
converted to return millidegrees (even on GPUs that don't support it)
instead of degrees.

Thanks!
Ben.

>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  .../drm/nouveau/include/nvkm/subdev/therm.h   | 18 +++++++++++++
>  drivers/gpu/drm/nouveau/nouveau_hwmon.c       |  4 +--
>  .../gpu/drm/nouveau/nvkm/subdev/therm/base.c  | 16 ++++++++++++
>  .../gpu/drm/nouveau/nvkm/subdev/therm/gp100.c | 25 +++++++++++++++++--
>  .../gpu/drm/nouveau/nvkm/subdev/therm/priv.h  |  1 +
>  5 files changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
> index 62c34f98c930..7b9928dd001c 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
> @@ -100,6 +100,24 @@ struct nvkm_therm {
>  };
>
>  int nvkm_therm_temp_get(struct nvkm_therm *);
> +
> +/**
> + * nvkm_therm_temp_millidegree_get() - get the temperature in millidegrees
> + * @therm: The thermal device to read from.
> + *
> + * This interface reports temperatures in units of millidegree Celsius to
> + * align with the hwmon API. Some cards may only be capable of reporting in
> + * units of Celsius, and those that report finer grain temperatures may not be
> + * capable of millidegree Celsius accuracy,
> + *
> + * For cases where millidegree temperature is too fine-grain, the
> + * nvkm_therm_temp_get() interface reports temperatures in one degree Celsius
> + * increments.
> + *
> + * Return: The temperature in millidegrees Celsius, or -ENODEV if temperature
> + *         reporting is not supported.
> + */
> +int nvkm_therm_temp_millidegree_get(struct nvkm_therm *therm);
>  int nvkm_therm_fan_sense(struct nvkm_therm *);
>  int nvkm_therm_cstate(struct nvkm_therm *, int, int);
>  void nvkm_therm_clkgate_init(struct nvkm_therm *,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> index 1c3104d20571..e96355f93ce5 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> @@ -428,8 +428,8 @@ nouveau_temp_read(struct device *dev, u32 attr, int channel, long *val)
>         case hwmon_temp_input:
>                 if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
>                         return -EINVAL;
> -               ret = nvkm_therm_temp_get(therm);
> -               *val = ret < 0 ? ret : (ret * 1000);
> +               ret = nvkm_therm_temp_millidegree_get(therm);
> +               *val = ret;
>                 break;
>         case hwmon_temp_max:
>                 *val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK)
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
> index 4a4d1e224126..e655b32c78b8 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
> @@ -34,6 +34,22 @@ nvkm_therm_temp_get(struct nvkm_therm *therm)
>         return -ENODEV;
>  }
>
> +int
> +nvkm_therm_temp_millidegree_get(struct nvkm_therm *therm)
> +{
> +       int ret = -ENODEV;
> +
> +       if (therm->func->temp_millidegree_get)
> +               return therm->func->temp_millidegree_get(therm);
> +
> +       if (therm->func->temp_get) {
> +               ret = therm->func->temp_get(therm);
> +               if (ret > 0)
> +                       ret *= 1000;
> +       }
> +       return ret;
> +}
> +
>  static int
>  nvkm_therm_update_trip(struct nvkm_therm *therm)
>  {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
> index 9f0dea3f61dc..4c3c2895a3cb 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
> @@ -24,7 +24,7 @@
>  #include "priv.h"
>
>  static int
> -gp100_temp_get(struct nvkm_therm *therm)
> +gp100_temp_get_raw(struct nvkm_therm *therm)
>  {
>         struct nvkm_device *device = therm->subdev.device;
>         struct nvkm_subdev *subdev = &therm->subdev;
> @@ -37,14 +37,35 @@ gp100_temp_get(struct nvkm_therm *therm)
>
>         /* device valid */
>         if (tsensor & 0x20000000)
> -               return (inttemp >> 8);
> +               return inttemp;
>         else
>                 return -ENODEV;
>  }
>
> +static int
> +gp100_temp_millidegree_get(struct nvkm_therm *therm)
> +{
> +       int raw_temp = gp100_temp_get_raw(therm);
> +
> +       if (raw_temp < 0)
> +               return raw_temp;
> +       return raw_temp * 1000 >> 8;
> +}
> +
> +static int
> +gp100_temp_get(struct nvkm_therm *therm)
> +{
> +       int raw_temp = gp100_temp_get_raw(therm);
> +
> +       if (raw_temp < 0)
> +               return raw_temp;
> +       return raw_temp >> 8;
> +}
> +
>  static const struct nvkm_therm_func
>  gp100_therm = {
>         .temp_get = gp100_temp_get,
> +       .temp_millidegree_get = gp100_temp_millidegree_get,
>         .program_alarms = nvkm_therm_program_alarms_polling,
>  };
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
> index 21659daf1864..a53068b4f0b9 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
> @@ -92,6 +92,7 @@ struct nvkm_therm_func {
>         int (*pwm_clock)(struct nvkm_therm *, int line);
>
>         int (*temp_get)(struct nvkm_therm *);
> +       int (*temp_millidegree_get)(struct nvkm_therm *therm);
>
>         int (*fan_sense)(struct nvkm_therm *);
>
> --
> 2.26.2
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
