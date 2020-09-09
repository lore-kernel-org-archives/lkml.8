Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2159BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6AD72076C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXjtcXJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIIIWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgIIIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599639750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDu4WTB9qWTPV0dbKk/SY2ZW1BVfToU7xoBYtd+G0E0=;
        b=gXjtcXJ/OZZd5nhp5xN617J9bqxs2GLOVlh1Rfp5ZWq9xbm8ejvblTxzHb5oJjlqrnSSZL
        IDqEA1b3YytNnqk3wmeH1f10RkU79BDEszYJLPKKi/tH0OeUDiN+u8MncceW7J0UrXIWQu
        Q0SgjFQ/BK3ijz3VCjdWc/l6cIwLi1k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-1Xs-rci_P6-00Jr_s5y6aA-1; Wed, 09 Sep 2020 04:22:26 -0400
X-MC-Unique: 1Xs-rci_P6-00Jr_s5y6aA-1
Received: by mail-qk1-f197.google.com with SMTP id 125so960603qkh.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDu4WTB9qWTPV0dbKk/SY2ZW1BVfToU7xoBYtd+G0E0=;
        b=oNYJVY+MG8bRbJjTOMigTUJIDtIAP3Kw7eWXeUzWMrZkDs/FSKjs7shlReNzY0HQS9
         TEfxYjPRYNXArDfQs/t4J4wfihmxfogvfeSdn0QC+mtklZJr4eaXVC++FDyt/OpbC4Rh
         XH+p2vVSX27W8TQ7KkBiejjrTf911ArfY5JOqpz2Ow5SYhUbNTH+TMSFgNKXXSYrer1E
         ry3QBGqSZlIxwSUFjxBdvE+jhsgDQ0YctdwzduW026eOExjHdldlvPLEksWYoDV4MGxG
         rd4bGn37QWr0S3YfoPAA/cwm6ibBXCUmdtfxjJ2OUctTQOvpXa5SfP0ardGzU+LiofBS
         CwVg==
X-Gm-Message-State: AOAM533zYApBH2uSJISdPt+cUl69AEc3BGVgCpEKjtiGaLp/Pm/i4pKQ
        4Wl/Yu52BBbjhBA7JknZ+ah6/WTQe8SZr6eLL+W92dE/eSnx9fZhlwoBy1WSVoxKorugnkyjFS1
        lH0dNP4FuoSAj6u7h82aTd88NAKdLxNUPesED39IC
X-Received: by 2002:a05:620a:cd7:: with SMTP id b23mr2302250qkj.192.1599639745974;
        Wed, 09 Sep 2020 01:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL9+uuU8O0pxBu3MC+S7Ux+Tw5qi1GkJwbdWT5j4dzjoEP5JLDsHQrTn6kHBzSuM1M5Ad+8Ztb7gcqD61r7r8=
X-Received: by 2002:a05:620a:cd7:: with SMTP id b23mr2302242qkj.192.1599639745631;
 Wed, 09 Sep 2020 01:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200812204952.1921587-1-jcline@redhat.com> <CACAvsv71oxCYB1+LCAUHD5v_NGAP-DpxPY_dPz53iw2=91KAJg@mail.gmail.com>
In-Reply-To: <CACAvsv71oxCYB1+LCAUHD5v_NGAP-DpxPY_dPz53iw2=91KAJg@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 9 Sep 2020 10:22:14 +0200
Message-ID: <CACO55tvv6REmNzZZyyRSJyRT5z-xEf38+tk9cDnft63DX5JQUw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Add fine-grain temperature reporting
To:     Ben Skeggs <skeggsb@gmail.com>
Cc:     Jeremy Cline <jcline@redhat.com>, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 6:06 AM Ben Skeggs <skeggsb@gmail.com> wrote:
>
> On Thu, 13 Aug 2020 at 06:50, Jeremy Cline <jcline@redhat.com> wrote:
> >
> > Commit d32656373857 ("drm/nouveau/therm/gp100: initial implementation of
> > new gp1xx temperature sensor") added support for reading finer-grain
> > temperatures, but continued to report temperatures in 1 degree Celsius
> > increments via nvkm_therm_temp_get().
> >
> > Rather than altering nvkm_therm_temp_get() to report finer-grain
> > temperatures, which would be inconvenient for other users of the
> > function, a second interface has been added to line up with hwmon's
> > native unit of temperature.
> Hey Jeremy,
>
> Sorry this slipped past me until now.  I'm OK with adding support for
> millidegree temperature reporting, but don't think we need to keep
> both interfaces around and would rather see the existing code
> converted to return millidegrees (even on GPUs that don't support it)
> instead of degrees.
>
> Thanks!
> Ben.
>

just a note as I was trying something like that in the past: we have a
lot of code which fetches the temperature and there are a lot of
places where we would then do a divide by 1000, so having a wrapper
function at least makes sense. If we want to keep the func pointers?
well.. I guess the increased CPU overhead wouldn't be as bad if all
sub classes do this static * 1000 as well either. I just think we
should have both interfaces in subdev/therm.h so we can just keep most
of the current code as is.

> >
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> > ---
> >  .../drm/nouveau/include/nvkm/subdev/therm.h   | 18 +++++++++++++
> >  drivers/gpu/drm/nouveau/nouveau_hwmon.c       |  4 +--
> >  .../gpu/drm/nouveau/nvkm/subdev/therm/base.c  | 16 ++++++++++++
> >  .../gpu/drm/nouveau/nvkm/subdev/therm/gp100.c | 25 +++++++++++++++++--
> >  .../gpu/drm/nouveau/nvkm/subdev/therm/priv.h  |  1 +
> >  5 files changed, 60 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
> > index 62c34f98c930..7b9928dd001c 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
> > @@ -100,6 +100,24 @@ struct nvkm_therm {
> >  };
> >
> >  int nvkm_therm_temp_get(struct nvkm_therm *);
> > +
> > +/**
> > + * nvkm_therm_temp_millidegree_get() - get the temperature in millidegrees
> > + * @therm: The thermal device to read from.
> > + *
> > + * This interface reports temperatures in units of millidegree Celsius to
> > + * align with the hwmon API. Some cards may only be capable of reporting in
> > + * units of Celsius, and those that report finer grain temperatures may not be
> > + * capable of millidegree Celsius accuracy,
> > + *
> > + * For cases where millidegree temperature is too fine-grain, the
> > + * nvkm_therm_temp_get() interface reports temperatures in one degree Celsius
> > + * increments.
> > + *
> > + * Return: The temperature in millidegrees Celsius, or -ENODEV if temperature
> > + *         reporting is not supported.
> > + */
> > +int nvkm_therm_temp_millidegree_get(struct nvkm_therm *therm);
> >  int nvkm_therm_fan_sense(struct nvkm_therm *);
> >  int nvkm_therm_cstate(struct nvkm_therm *, int, int);
> >  void nvkm_therm_clkgate_init(struct nvkm_therm *,
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > index 1c3104d20571..e96355f93ce5 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > @@ -428,8 +428,8 @@ nouveau_temp_read(struct device *dev, u32 attr, int channel, long *val)
> >         case hwmon_temp_input:
> >                 if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
> >                         return -EINVAL;
> > -               ret = nvkm_therm_temp_get(therm);
> > -               *val = ret < 0 ? ret : (ret * 1000);
> > +               ret = nvkm_therm_temp_millidegree_get(therm);
> > +               *val = ret;
> >                 break;
> >         case hwmon_temp_max:
> >                 *val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK)
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
> > index 4a4d1e224126..e655b32c78b8 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
> > @@ -34,6 +34,22 @@ nvkm_therm_temp_get(struct nvkm_therm *therm)
> >         return -ENODEV;
> >  }
> >
> > +int
> > +nvkm_therm_temp_millidegree_get(struct nvkm_therm *therm)
> > +{
> > +       int ret = -ENODEV;
> > +
> > +       if (therm->func->temp_millidegree_get)
> > +               return therm->func->temp_millidegree_get(therm);
> > +
> > +       if (therm->func->temp_get) {
> > +               ret = therm->func->temp_get(therm);
> > +               if (ret > 0)
> > +                       ret *= 1000;
> > +       }
> > +       return ret;
> > +}
> > +
> >  static int
> >  nvkm_therm_update_trip(struct nvkm_therm *therm)
> >  {
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
> > index 9f0dea3f61dc..4c3c2895a3cb 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
> > @@ -24,7 +24,7 @@
> >  #include "priv.h"
> >
> >  static int
> > -gp100_temp_get(struct nvkm_therm *therm)
> > +gp100_temp_get_raw(struct nvkm_therm *therm)
> >  {
> >         struct nvkm_device *device = therm->subdev.device;
> >         struct nvkm_subdev *subdev = &therm->subdev;
> > @@ -37,14 +37,35 @@ gp100_temp_get(struct nvkm_therm *therm)
> >
> >         /* device valid */
> >         if (tsensor & 0x20000000)
> > -               return (inttemp >> 8);
> > +               return inttemp;
> >         else
> >                 return -ENODEV;
> >  }
> >
> > +static int
> > +gp100_temp_millidegree_get(struct nvkm_therm *therm)
> > +{
> > +       int raw_temp = gp100_temp_get_raw(therm);
> > +
> > +       if (raw_temp < 0)
> > +               return raw_temp;
> > +       return raw_temp * 1000 >> 8;
> > +}
> > +
> > +static int
> > +gp100_temp_get(struct nvkm_therm *therm)
> > +{
> > +       int raw_temp = gp100_temp_get_raw(therm);
> > +
> > +       if (raw_temp < 0)
> > +               return raw_temp;
> > +       return raw_temp >> 8;
> > +}
> > +
> >  static const struct nvkm_therm_func
> >  gp100_therm = {
> >         .temp_get = gp100_temp_get,
> > +       .temp_millidegree_get = gp100_temp_millidegree_get,
> >         .program_alarms = nvkm_therm_program_alarms_polling,
> >  };
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
> > index 21659daf1864..a53068b4f0b9 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
> > @@ -92,6 +92,7 @@ struct nvkm_therm_func {
> >         int (*pwm_clock)(struct nvkm_therm *, int line);
> >
> >         int (*temp_get)(struct nvkm_therm *);
> > +       int (*temp_millidegree_get)(struct nvkm_therm *therm);
> >
> >         int (*fan_sense)(struct nvkm_therm *);
> >
> > --
> > 2.26.2
> >
> > _______________________________________________
> > Nouveau mailing list
> > Nouveau@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/nouveau
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

