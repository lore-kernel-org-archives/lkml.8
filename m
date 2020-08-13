Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DB1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2B420774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmiBT0ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMMoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:44:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22220 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgHMMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597322651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DuaKe1mZfbQOEy3vU0IvOh3qvOEZnjiR99rYX0WAkfY=;
        b=SmiBT0lnFaHbkRZKsWrJ2eaa4lllHXVa9oOwfSUtxgz+M7+RljwhJq1pTCbijUxkd2hhIo
        n3JC03Isml0iPa22zJdA7lemKEsIKhqNIHGThgKeVeLpc/uwXr5qMzVlmNJWm0Fm+uZiFK
        kq1/cdCWyKrEhrBXbrSTFfhM7JE+InQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-OdL8TFQBP9qnSm2Hcaj50Q-1; Thu, 13 Aug 2020 08:44:09 -0400
X-MC-Unique: OdL8TFQBP9qnSm2Hcaj50Q-1
Received: by mail-qk1-f198.google.com with SMTP id z1so3798538qkg.23
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DuaKe1mZfbQOEy3vU0IvOh3qvOEZnjiR99rYX0WAkfY=;
        b=VLuISregqkKOch4GNCEqft8Rn75X0qOtnckD1aGHXzS7UpDrm3mmmwI9YvGOG4vfWp
         ufC4Zq+0zCr1i7AO8tj2N47kXNr4prsrIBF9JKzM7ZSv107h5Ny03kyH3sgq7Qc0KJ5E
         8DPIPy8A3X/pHQcXRDAsPi8WnklExccrCBTS9Z40b3DxuutaOcN1RvHSCP6svDln+b/K
         0ZRVaqBF8k4pAHVmEeJaD+hH4W7gHK6m/UVqL2YKm3KYVY8ViK+9el3/5K7tx3o2Pi3L
         etmGXrm27EwCIqwBgEn6UaewWeNOiU+QS65UvAz4r8IHjER+MIHTvdAuRFYg5slFsNM4
         rECg==
X-Gm-Message-State: AOAM531D7vQcqhZpmJ7V/zEqxvgcJqGz06vpUsvU6tXyC5AzcjEzM+GC
        WSIGblGMaq8+vwZzO56VRpL4hC56Az8mcI4KYnP88Hd5DZoBEEPImMyuOFsORRGETNnhAnGo5ag
        IA022zi9wwg1tN0fnwoB7MkMksU/6KH7QxAjwjR1y
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr4944631qtr.254.1597322648938;
        Thu, 13 Aug 2020 05:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxicaEepBIMK6TfbtL+T0MXKjJ+N/gu+zF3IhKDvPZQsjbaCt3vMck1dvybXgaPOkrqmPAFI60DmEZFhhozH9M=
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr4944601qtr.254.1597322648679;
 Thu, 13 Aug 2020 05:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200812204952.1921587-1-jcline@redhat.com>
In-Reply-To: <20200812204952.1921587-1-jcline@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 13 Aug 2020 14:43:57 +0200
Message-ID: <CACO55tuYkFvSXL+i1zcAROq7T=LvGuOzdhzy+2DZVG0O2L4mjA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: Add fine-grain temperature reporting
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Wed, Aug 12, 2020 at 10:50 PM Jeremy Cline <jcline@redhat.com> wrote:
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

