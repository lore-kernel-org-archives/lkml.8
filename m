Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C204C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDA021556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRvn7qM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgFQR5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:57:22 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8ACC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:57:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u13so3840059iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q00goUzCyLy6SD4mp+vmnrzfR0St7QeKsEVA6ziR2PU=;
        b=RRvn7qM35mVqAY1knuIVPc10vaUdrQvNMukTRVNOheuSL4BNGgJUWKZcI1Tlop7ulM
         eHEbNnONoOFpOMHgV3OxjZJtAVHASnb6+Kp0iM8VLOvBUPU30Ce6EvIRrDUDDe7aq/1t
         V5AIQ1Be14Z83jXBo6gBw9pPIYqOTrpX+U/4BWkVHzRchV8quM6JYDrY7uXvtB/sCM4i
         BXsTwdu2DB+p4w8OeDUtvERmD0VxVXxT27DcDci4gRQ0R9Xg28f6mSS7xRq8+TWNyqVw
         YtcHyxUltXLKolgtcMD0+EotnZ7NCfKeRWa0Uo3yDAMselHTgbsUYYTAFboGZqKs2pz3
         NTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q00goUzCyLy6SD4mp+vmnrzfR0St7QeKsEVA6ziR2PU=;
        b=hlGKB1uR2kL1I6dlN6Fx2Iq7pHN3ya5IOWsiaHcL6DHAbz3XtvBrHl6w1SG9B+cqmd
         9idS5GbLu2XIgQEnwFSaK7ZDbLZco8kbAcnf279hZRYBiLu42WvQeaDmtELFdRGWGOx8
         wdK5SGGKAM+CLnGboefooCY8Xjk98ozptkaTW9j0PAVcKjz69iBcBPFkLaYAyBu2xeRl
         4nJ+BcUpWcwKEwFQv7NYaVwHTZTHLuNb0oprSn5Ntp6ghk0vPKeOgS3om1LuxQdaNVey
         uwjEaB+eKJEhS/rrxB07V0GGDjudKsMATd7kqyYuTK7MXtx0998svcQsxggG6fgKapxt
         VD3g==
X-Gm-Message-State: AOAM532clz/82mXadbx4Vp3IW+66t730pyqHWm+ppZei1Hks1mywlNug
        cZ5HKzUIB60ineyvGfeqg9C/Z6eAob6X2KemA/Y=
X-Google-Smtp-Source: ABdhPJzZJiTWi2uOtNqtsGdWLlE7w0p8Q7blzZ5DDM9DIsZb9e2+H8BHK6oknVOa8kl+OV9UMTyk7Mfx5H5udXhynxA=
X-Received: by 2002:a6b:b252:: with SMTP id b79mr621281iof.31.1592416640937;
 Wed, 17 Jun 2020 10:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VcLR2w9Ym0YOqUT9G8xT9qWrdD1-wP4UA-1wtuwCNxqSA@mail.gmail.com>
 <20200615061220.68711-1-navid.emamdoost@gmail.com> <befc07e1d630dbc5a6f96fba4e47e083e6386090.camel@pengutronix.de>
In-Reply-To: <befc07e1d630dbc5a6f96fba4e47e083e6386090.camel@pengutronix.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Wed, 17 Jun 2020 12:57:09 -0500
Message-ID: <CAEkB2EQ9DuLt12MXkw3DYpBDaDAxoWTnMC9+=E7v=6dGGRK=nQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: fix ref count leak via pm_runtime_get_sync
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        mccamant@cs.umn.edu, Andy Shevchenko <andy.shevchenko@gmail.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,


On Wed, Jun 17, 2020 at 4:53 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Navid,
>
> Am Montag, den 15.06.2020, 01:12 -0500 schrieb Navid Emamdoost:
> > in etnaviv_gpu_submit, etnaviv_gpu_recover_hang, etnaviv_gpu_debugfs,
> > and etnaviv_gpu_init the call to pm_runtime_get_sync increments the
> > counter even in case of failure, leading to incorrect ref count.
> > In case of failure, decrement the ref count before returning.
>
> While that change is correct with the current API, may I ask the
> question why the way this API works is considered reasonable? A API
> call that fails, but still changes internal state and expects the
> caller to clean up the mess it not really what I would consider fool-
> proof API design. Is there a specific reason why it is done this way
> and not handled internally?

I share the same concern with you on the way this API is working now.
To the best of my knowledge, there are ongoing discussions on this
issue:

https://lkml.org/lkml/2020/6/14/76
https://patchwork.ozlabs.org/project/linux-tegra/patch/20200520095148.10995-1-dinghao.liu@zju.edu.cn/

>
> Regards,
> Lucas
>
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> > Changes in v2:
> >       - replace pm_runtime_put with  pm_runtime_put_noidle
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > index a31eeff2b297..7c9f3f9ba123 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > @@ -722,7 +722,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
> >       ret = pm_runtime_get_sync(gpu->dev);
> >       if (ret < 0) {
> >               dev_err(gpu->dev, "Failed to enable GPU power domain\n");
> > -             return ret;
> > +             goto pm_put;
> >       }
> >
> >       etnaviv_hw_identify(gpu);
> > @@ -819,6 +819,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
> >
> >  fail:
> >       pm_runtime_mark_last_busy(gpu->dev);
> > +pm_put:
> >       pm_runtime_put_autosuspend(gpu->dev);
> >
> >       return ret;
> > @@ -859,7 +860,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
> >
> >       ret = pm_runtime_get_sync(gpu->dev);
> >       if (ret < 0)
> > -             return ret;
> > +             goto pm_put;
> >
> >       dma_lo = gpu_read(gpu, VIVS_FE_DMA_LOW);
> >       dma_hi = gpu_read(gpu, VIVS_FE_DMA_HIGH);
> > @@ -1003,6 +1004,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
> >       ret = 0;
> >
> >       pm_runtime_mark_last_busy(gpu->dev);
> > +pm_put:
> >       pm_runtime_put_autosuspend(gpu->dev);
> >
> >       return ret;
> > @@ -1016,7 +1018,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
> >       dev_err(gpu->dev, "recover hung GPU!\n");
> >
> >       if (pm_runtime_get_sync(gpu->dev) < 0)
> > -             return;
> > +             goto pm_put;
> >
> >       mutex_lock(&gpu->lock);
> >
> > @@ -1035,6 +1037,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
> >
> >       mutex_unlock(&gpu->lock);
> >       pm_runtime_mark_last_busy(gpu->dev);
> > +pm_put:
> >       pm_runtime_put_autosuspend(gpu->dev);
> >  }
> >
> > @@ -1308,8 +1311,10 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
> >
> >       if (!submit->runtime_resumed) {
> >               ret = pm_runtime_get_sync(gpu->dev);
> > -             if (ret < 0)
> > +             if (ret < 0) {
> > +                     pm_runtime_put_noidle(gpu->dev);
> >                       return NULL;
> > +             }
> >               submit->runtime_resumed = true;
> >       }
> >
> > @@ -1326,6 +1331,7 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
> >       ret = event_alloc(gpu, nr_events, event);
> >       if (ret) {
> >               DRM_ERROR("no free events\n");
> > +             pm_runtime_put_noidle(gpu->dev);
> >               return NULL;
> >       }
> >
>


--
Navid.
