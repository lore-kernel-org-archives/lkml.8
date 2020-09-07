Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBF9C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84D3206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Euxtu+tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgIGHOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIGHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:14:12 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775CDC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:14:11 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id g26so33385ooa.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVfAGFVhhH+3gKxWPx4EEt2i/99FDkLx011kDtsMF+I=;
        b=Euxtu+trgjabIp7kfpqLzFQS+dE83z6NFR5B38p25hCsIskYQhJEXI8aDOFmjb9/rb
         ajdQe4bmbBxWioDNhCAVb/QZqh3F00karTYzM2FazYTVvrVMLOroBXd2TBPPFA8thdy7
         kAmoBHvDcK9wIivmZv2bC4v0rV5TvwkjuxeM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVfAGFVhhH+3gKxWPx4EEt2i/99FDkLx011kDtsMF+I=;
        b=FVcNN5DZm9Q+c1C8R1Dm12dNczblYS95LlfujqRbOH8I70unhYpD30xwemoxp8I/qh
         q+W0Ig/HpkgQaHe0ugHJ/3tBOMy/l0YQibf4IFAVtdNR4XvdYmg7gnlUK8ySWP7vijFB
         kjz/giaK0dT30u3cfPuqKo9zqjx2rPCZmpz9anQg5SlnK4QxZM/RZsmicqrIGFlcdqF8
         cc8iX3wULpWeSnG6TbYX5qzqg5VvsHcNk+5JKxEMM57Ro5tEi3DLT7PK8fUkkiLdvI6z
         KoHrLQZikiRlwrj92QsggrIfszPC5Lpet5QiaKJUJnVovj2Oeu3M8sLMPFdx9Qti2+U/
         5b+g==
X-Gm-Message-State: AOAM533LA8hs3GvT3zoXiOU0NdyZ9jLXLsgME2ejYF6X6lo5KQfisxHr
        pi33yCPXBDO7UvLm5x+iAycg24EP4Upg6U64I68SJQ==
X-Google-Smtp-Source: ABdhPJyDsSLWPXy8R9Ce8HIpecD+QM6t0+0yQYpXyChVzKDiPvzj0GbvH4ZECIfVS8TxI8k421NQRVJ+suYIajAm3/8=
X-Received: by 2002:a4a:e98e:: with SMTP id s14mr13829467ood.28.1599462848946;
 Mon, 07 Sep 2020 00:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200818092017.26290-1-kraxel@redhat.com> <20200818092017.26290-2-kraxel@redhat.com>
 <20200901074043.GT2352366@phenom.ffwll.local> <20200907063901.atwjdxz7iqyra22h@sirius.home.kraxel.org>
In-Reply-To: <20200907063901.atwjdxz7iqyra22h@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 7 Sep 2020 09:13:58 +0200
Message-ID: <CAKMK7uFixrbxVoaF4-1hXvQcPySaaYRooQ=LKoivPALH-UCgbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: allow limiting the scatter list size.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:DRM DRIVERS FOR NVIDIA TEGRA" 
        <linux-tegra@vger.kernel.org>,
        "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 8:39 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > +   /**
> > > +    * @max_segment:
> > > +    *
> > > +    * Max size for scatter list segments.  When unset the default
> > > +    * (SCATTERLIST_MAX_SEGMENT) is used.
> > > +    */
> > > +   size_t max_segment;
> >
> > Is there no better place for this then "at the bottom"? drm_device is a
> > huge structure, piling stuff up randomly doesn't make it better :-)
>
> Moved next to the other gem fields for now (v3 posted).
>
> > I think ideally we'd have a gem substruct like we have on the modeset side
> > at least.
>
> Phew, that'll be quite some churn in the tree.  And there aren't that many
> gem-related fields in struct drm_device.
>
> So you are looking for something like below (header changes only)?

Hm yeah it's a lot less than I thought. And yes I think that would be neat.
-Daniel

>
> take care,
>   Gerd
>
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index c455ef404ca6..950167ede98a 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -299,22 +299,8 @@ struct drm_device {
>         /** @mode_config: Current mode config */
>         struct drm_mode_config mode_config;
>
> -       /** @object_name_lock: GEM information */
> -       struct mutex object_name_lock;
> -
> -       /** @object_name_idr: GEM information */
> -       struct idr object_name_idr;
> -
> -       /** @vma_offset_manager: GEM information */
> -       struct drm_vma_offset_manager *vma_offset_manager;
> -
> -       /**
> -        * @max_segment:
> -        *
> -        * Max size for scatter list segments for GEM objects.  When
> -        * unset the default (SCATTERLIST_MAX_SEGMENT) is used.
> -        */
> -       size_t max_segment;
> +       /** @gem_config: Current GEM config */
> +       struct drm_gem_config gem_config;
>
>         /** @vram_mm: VRAM MM memory manager */
>         struct drm_vram_mm *vram_mm;
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 337a48321705..74129fb29fb8 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -39,6 +39,25 @@
>
>  #include <drm/drm_vma_manager.h>
>
> +struct drm_gem_config {
> +       /** @object_name_lock: GEM information */
> +       struct mutex object_name_lock;
> +
> +       /** @object_name_idr: GEM information */
> +       struct idr object_name_idr;
> +
> +       /** @vma_offset_manager: GEM information */
> +       struct drm_vma_offset_manager *vma_offset_manager;
> +
> +       /**
> +        * @max_segment:
> +        *
> +        * Max size for scatter list segments for GEM objects.  When
> +        * unset the default (SCATTERLIST_MAX_SEGMENT) is used.
> +        */
> +       size_t max_segment;
> +};
> +
>  struct drm_gem_object;
>
>  /**
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
