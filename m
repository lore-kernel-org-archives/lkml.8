Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E9AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D09A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IHIGL3sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgIJFul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgIJFsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:48:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D29C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:48:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so5294072wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I7HXHoZUPjIWa51xLsX5lBcbKjI+7D42UiOnxk3Dydc=;
        b=IHIGL3sDLvhkFznmNhPIuTfgebgiVyomeJUGTpz7IKwGJP5eW7teIcEDQ9GqsdMlWI
         0L2LH5UG4vwLK+uV+coa2eSC9TpWvABAM9m2SltZ18r/qhNwLC9o+FN5vixIYyYhezMM
         g7BZa3zsUZJh27H/drt6gipvU78m9FuDo5xiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=I7HXHoZUPjIWa51xLsX5lBcbKjI+7D42UiOnxk3Dydc=;
        b=io8t2H64esMTH8Lu80KtzNM+OaaZiYxndgLHr13uX75qmsWvzMsjKyntzBml9NbBTc
         Hs3sMZuSpVIyImbXI3ESeM0vdJBWAX1iLScW9cmnNw2PE/Zb8rLmJNasnn6UdbUssbuO
         43UpzlUo3ZAqh9LZZggjWEtQUpTJPguLx1QMEK5IjkAvaihuLLqPPBxEr4gtiUfB/371
         ZIBCqzeW5yhDQa+czT9pe5XzaaxAtqOE8s2Ay/u+W0qKXSGUB7mNFFbFVRaNdhOu/Tfh
         17dszmmnpJrIlrCLNnSLg1qgrs2rsfb0bk78AKxLcL7vMXtjKHc40uuid+CCSXqI4K87
         bvCA==
X-Gm-Message-State: AOAM533h1G0CxN5jc0nfPgARskVyTVfV7Eaom5ljQPOlIkemnWxIsNgY
        0Lm4ZL2IDfxZbSg5OqqIsYKNDA==
X-Google-Smtp-Source: ABdhPJxFksw3Uz6l+VgxdkO/ALbi5Kpv2LgTIRZ0Cc4P7Dxld4TE/oZaQUaG//4MLORTkGsUhKz/xw==
X-Received: by 2002:adf:82b1:: with SMTP id 46mr7684464wrc.271.1599716916109;
        Wed, 09 Sep 2020 22:48:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g143sm1918363wme.0.2020.09.09.22.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 22:48:35 -0700 (PDT)
Date:   Thu, 10 Sep 2020 07:48:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        boris.brezillon@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [RESEND PATCH v2 2/2] drm/mediatek: mtk_dpi: Convert to bridge
 driver
Message-ID: <20200910054828.GC438822@phenom.ffwll.local>
Mail-Followup-To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, boris.brezillon@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
References: <20200826085317.681385-1-enric.balletbo@collabora.com>
 <20200826085317.681385-3-enric.balletbo@collabora.com>
 <CAAOTY__UwVCDn_J1RWesrm7eTS=Ti4LS9FutaydomFNLBVsF2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOTY__UwVCDn_J1RWesrm7eTS=Ti4LS9FutaydomFNLBVsF2g@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:35:21AM +0800, Chun-Kuang Hu wrote:
> Hi, Andrzej & Neil:
> 
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年8月26日 週三 下午4:53寫道：
> 
> >
> > Convert mtk_dpi to a bridge driver with built-in encoder support for
> > compatibility with existing component drivers.
> >
> 
> This is a DRM-bridge related patch, how do you think about it?

bridge stuff is also maintained in drm-misc, so good to go imo.

For the bigger picture I think it'd be really good if bridges drivers
would use the of bridge lookup, and not hand roll something with
component. So 2nd step of converting this over to a proper bridge driver
would be to replace the component code here too.

Cheers, Daniel

> 
> Regards,
> Chun-Kuang.
> 
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> > Changes in v2:
> > - Maintain error message when attach to bridge fails. (Boris)
> >
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 71 ++++++++++++++++++------------
> >  1 file changed, 42 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index f7372dbdac0e..589ef33a1780 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -64,6 +64,7 @@ enum mtk_dpi_out_color_format {
> >  struct mtk_dpi {
> >         struct mtk_ddp_comp ddp_comp;
> >         struct drm_encoder encoder;
> > +       struct drm_bridge bridge;
> >         struct drm_bridge *next_bridge;
> >         void __iomem *regs;
> >         struct device *dev;
> > @@ -83,9 +84,9 @@ struct mtk_dpi {
> >         int refcount;
> >  };
> >
> > -static inline struct mtk_dpi *mtk_dpi_from_encoder(struct drm_encoder *e)
> > +static inline struct mtk_dpi *bridge_to_dpi(struct drm_bridge *b)
> >  {
> > -       return container_of(e, struct mtk_dpi, encoder);
> > +       return container_of(b, struct mtk_dpi, bridge);
> >  }
> >
> >  enum mtk_dpi_polarity {
> > @@ -521,50 +522,53 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> >         return 0;
> >  }
> >
> > -static bool mtk_dpi_encoder_mode_fixup(struct drm_encoder *encoder,
> > -                                      const struct drm_display_mode *mode,
> > -                                      struct drm_display_mode *adjusted_mode)
> > +static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
> >  {
> > -       return true;
> > +       drm_encoder_cleanup(encoder);
> >  }
> >
> > -static void mtk_dpi_encoder_mode_set(struct drm_encoder *encoder,
> > -                                    struct drm_display_mode *mode,
> > -                                    struct drm_display_mode *adjusted_mode)
> > +static const struct drm_encoder_funcs mtk_dpi_encoder_funcs = {
> > +       .destroy = mtk_dpi_encoder_destroy,
> > +};
> > +
> > +static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
> > +                                enum drm_bridge_attach_flags flags)
> >  {
> > -       struct mtk_dpi *dpi = mtk_dpi_from_encoder(encoder);
> > +       struct mtk_dpi *dpi = bridge_to_dpi(bridge);
> > +
> > +       return drm_bridge_attach(bridge->encoder, dpi->next_bridge,
> > +                                &dpi->bridge, flags);
> > +}
> > +
> > +static void mtk_dpi_bridge_mode_set(struct drm_bridge *bridge,
> > +                               const struct drm_display_mode *mode,
> > +                               const struct drm_display_mode *adjusted_mode)
> > +{
> > +       struct mtk_dpi *dpi = bridge_to_dpi(bridge);
> >
> >         drm_mode_copy(&dpi->mode, adjusted_mode);
> >  }
> >
> > -static void mtk_dpi_encoder_disable(struct drm_encoder *encoder)
> > +static void mtk_dpi_bridge_disable(struct drm_bridge *bridge)
> >  {
> > -       struct mtk_dpi *dpi = mtk_dpi_from_encoder(encoder);
> > +       struct mtk_dpi *dpi = bridge_to_dpi(bridge);
> >
> >         mtk_dpi_power_off(dpi);
> >  }
> >
> > -static void mtk_dpi_encoder_enable(struct drm_encoder *encoder)
> > +static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
> >  {
> > -       struct mtk_dpi *dpi = mtk_dpi_from_encoder(encoder);
> > +       struct mtk_dpi *dpi = bridge_to_dpi(bridge);
> >
> >         mtk_dpi_power_on(dpi);
> >         mtk_dpi_set_display_mode(dpi, &dpi->mode);
> >  }
> >
> > -static int mtk_dpi_atomic_check(struct drm_encoder *encoder,
> > -                               struct drm_crtc_state *crtc_state,
> > -                               struct drm_connector_state *conn_state)
> > -{
> > -       return 0;
> > -}
> > -
> > -static const struct drm_encoder_helper_funcs mtk_dpi_encoder_helper_funcs = {
> > -       .mode_fixup = mtk_dpi_encoder_mode_fixup,
> > -       .mode_set = mtk_dpi_encoder_mode_set,
> > -       .disable = mtk_dpi_encoder_disable,
> > -       .enable = mtk_dpi_encoder_enable,
> > -       .atomic_check = mtk_dpi_atomic_check,
> > +static const struct drm_bridge_funcs mtk_dpi_bridge_funcs = {
> > +       .attach = mtk_dpi_bridge_attach,
> > +       .mode_set = mtk_dpi_bridge_mode_set,
> > +       .disable = mtk_dpi_bridge_disable,
> > +       .enable = mtk_dpi_bridge_enable,
> >  };
> >
> >  static void mtk_dpi_start(struct mtk_ddp_comp *comp)
> > @@ -605,12 +609,11 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
> >                 dev_err(dev, "Failed to initialize decoder: %d\n", ret);
> >                 goto err_unregister;
> >         }
> > -       drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_funcs);
> >
> >         /* Currently DPI0 is fixed to be driven by OVL1 */
> >         dpi->encoder.possible_crtcs = BIT(1);
> >
> > -       ret = drm_bridge_attach(&dpi->encoder, dpi->next_bridge, NULL, 0);
> > +       ret = drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL, 0);
> >         if (ret) {
> >                 dev_err(dev, "Failed to attach bridge: %d\n", ret);
> >                 goto err_cleanup;
> > @@ -791,8 +794,15 @@ static int mtk_dpi_probe(struct platform_device *pdev)
> >
> >         platform_set_drvdata(pdev, dpi);
> >
> > +       dpi->bridge.funcs = &mtk_dpi_bridge_funcs;
> > +       dpi->bridge.of_node = dev->of_node;
> > +       dpi->bridge.type = DRM_MODE_CONNECTOR_DPI;
> > +
> > +       drm_bridge_add(&dpi->bridge);
> > +
> >         ret = component_add(dev, &mtk_dpi_component_ops);
> >         if (ret) {
> > +               drm_bridge_remove(&dpi->bridge);
> >                 dev_err(dev, "Failed to add component: %d\n", ret);
> >                 return ret;
> >         }
> > @@ -802,7 +812,10 @@ static int mtk_dpi_probe(struct platform_device *pdev)
> >
> >  static int mtk_dpi_remove(struct platform_device *pdev)
> >  {
> > +       struct mtk_dpi *dpi = platform_get_drvdata(pdev);
> > +
> >         component_del(&pdev->dev, &mtk_dpi_component_ops);
> > +       drm_bridge_remove(&dpi->bridge);
> >
> >         return 0;
> >  }
> > --
> > 2.28.0
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
