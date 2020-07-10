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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BFDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7841A207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLn2L3Yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGJIvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgGJIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:51:11 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B9C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:51:11 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a17so2578537vsq.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqIVvQ2zr6ElD+RZxcXvNwfajcIvHD5hM0pq+5dyaCU=;
        b=FLn2L3Yu3a71IwsJbkyQMnv/2osNAG/OpLYe8aVWnpHC68jeftI7JiS5xkEur8kxr8
         5NHTmxbaEsLcIUnxVR6rii4rGIYH6RKZ59lfFL8So3UnrtKvIw6lxdU7uLFYBeJUNnIm
         tfEpSMgM2TOUjQEI4tpG8lTUAfHJ/RH85mI05YDwSzSztlH5AYXDWGNrnei6VmYZahKC
         AI5y3oT6Ch+wl6ujyswxkMQJKfF2kRbnx51NAIofofKcmxWWI9uyI9welkfj6IDQ34rg
         vKIlPJiXCdkk9Dk/riLmjG7zTZxG8comE2fgeJsZ7tDyRlfXSW3bnr82QgFyZWPwBDFC
         ugfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqIVvQ2zr6ElD+RZxcXvNwfajcIvHD5hM0pq+5dyaCU=;
        b=GXXziLLN3rrchFwCvqVPVt2LXNcQpPnhNzhapcyEf67CQnaJzLZAYORKTU0uTfA5+e
         WPpJGtr4G5grDcUprV4bMWVovQwrBX7qVLVCt7g5s/QQ8wik/3E+y33bcfBbNbVtZ7uR
         4kdptnx+k5HvJTBrgWm5UZqugik7YWEG9Ild0Drp0f17RhxKQBS15e4g9L1B9Ce2YPRE
         K8JodDktASdyKhahaF12sKff6IOWNjJB+0j3TT7uL9XdJMxxL42E33ut66g6hmOfjfTr
         RG9QbFahOGYCaV0Bga6vy+RY+NHt4uJ8fget9v5GDEbwCODMrq6zkhDqOjwI+O3mwLA6
         gqog==
X-Gm-Message-State: AOAM532RqWUypm5p06AsJ6gdc5FUfMp+Qzc5ru72yVYU1GkEY89DJFQP
        OjJY0x86tQMbzwMrIR0pPtFnKQ/imT4mSM/kBq/9Fn4IE5g=
X-Google-Smtp-Source: ABdhPJxOxsAazACc1kbzqT6xDB5kyDVlMOltsczaiTYVbWwwDKSYWKhNV616GOdXFWDb1WiHKNt7EMLwcaMLICyoP3s=
X-Received: by 2002:a67:c90c:: with SMTP id w12mr41263992vsk.86.1594371070342;
 Fri, 10 Jul 2020 01:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200710074143.306787-1-christian.gmeiner@gmail.com>
 <20200710074143.306787-3-christian.gmeiner@gmail.com> <6098f2549eb96348af0ba062d87a716f20d1af1c.camel@pengutronix.de>
In-Reply-To: <6098f2549eb96348af0ba062d87a716f20d1af1c.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 10 Jul 2020 10:50:59 +0200
Message-ID: <CAH9NwWex+9LvaBhzPkYDaYOHnvxFeK4sAMgFZi2i5b+TOSVPmA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/etnaviv: add loadavg accounting
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Lucas,

Am Fr., 10. Juli 2020 um 10:19 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
>
> Hi Christian,
>
> Am Freitag, den 10.07.2020, 09:41 +0200 schrieb Christian Gmeiner:
> > The GPU has an idle state register where each bit represents the idle
> > state of a sub-GPU component like FE or TX. Sample this register
> > every 10ms and calculate a simple moving average over the sub-GPU
> > component idle states with a total observation time frame of 1s.
> >
> > This provides us with a percentage based load of each sub-GPU
> > component.
> >
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 14 ++++++++++++
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 32 +++++++++++++++++++++++++++
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.h | 29 ++++++++++++++++++++++++
> >  3 files changed, 75 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > index f9afe11c50f0..b31920241c86 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > @@ -46,6 +46,19 @@ static void load_gpu(struct drm_device *dev)
> >       }
> >  }
> >
> > +static void unload_gpu(struct drm_device *dev)
> > +{
> > +     struct etnaviv_drm_private *priv = dev->dev_private;
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < ETNA_MAX_PIPES; i++) {
> > +             struct etnaviv_gpu *g = priv->gpu[i];
> > +
> > +             if (g)
> > +                     etnaviv_gpu_shutdown(g);
> > +     }
> > +}
> > +
> >  static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
> >  {
> >       struct etnaviv_drm_private *priv = dev->dev_private;
> > @@ -581,6 +594,7 @@ static void etnaviv_unbind(struct device *dev)
> >       struct drm_device *drm = dev_get_drvdata(dev);
> >       struct etnaviv_drm_private *priv = drm->dev_private;
> >
> > +     unload_gpu(drm);
> >       drm_dev_unregister(drm);
> >
> >       component_unbind_all(dev, drm);
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > index a31eeff2b297..1f0eb7e00657 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > @@ -714,6 +714,28 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
> >       gpu_write(gpu, VIVS_HI_INTR_ENBL, ~0U);
> >  }
> >
> > +static void etnaviv_loadavg_function(struct timer_list *t)
> > +{
> > +     struct etnaviv_gpu *gpu = from_timer(gpu, t, loadavg_timer);
> > +     const u32 idle = gpu_read(gpu, VIVS_HI_IDLE_STATE);
>
> This isn't guaranteed to work on a clock/power gated GPU. Also we
> surely don't want to wake a idle system every 10ms just to sample a "no
> load" value, so this needs some integration with runtime PM, to disable
> the sampling when the GPU is powered down and enable when powered up.
> The loadavg must be able to adapt to jumps in the sampling interval
> while idle.
>

Oh yea.. runtime PM.. I thought I was missing something. Will tackle this in the
next version.

>
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
> > +             if ((idle & etna_idle_module_names[i].bit))
> > +                     sma_loadavg_add(&gpu->loadavg_value[i], 0);
> > +             else
> > +                     sma_loadavg_add(&gpu->loadavg_value[i], 100);
> > +
> > +     spin_lock_bh(&gpu->loadavg_spinlock);
> > +
> > +     for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
> > +             gpu->loadavg_percentage[i] = sma_loadavg_read(&gpu->loadavg_value[i]);
> > +
> > +     spin_unlock_bh(&gpu->loadavg_spinlock);
> > +
> > +     mod_timer(t, jiffies + msecs_to_jiffies(10));
>
> A jiffies based timer is much too coarse for a regular 10ms sampling.
> On a typical 100Hz system 10ms is a single jiffy, so your timer will
> fire anywhere in the range of ~0ms...~20ms. This won't get us a usable
> measurement.
>

Makes sense.. will switch to hrtimers.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
