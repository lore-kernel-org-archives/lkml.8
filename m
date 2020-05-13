Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD75C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D632065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehOQ0f61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbgEMQlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgEMQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:41:03 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:41:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so322373qts.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Of6DuVfllLEJKZni4Ai4vipcUdfNzlQ6+FZgLgcsMF8=;
        b=ehOQ0f61ejewm2g+6SEOb8DS6voX1jKlEAKsoRPlJRIIFmbPMjaaoPGNrQLjj3ZK4w
         hepeE8/r99wWaPmbogTTG7Ujhx8Di0mHpuuPhQE2unfc1UhiQiu6Q3QrZIpmOMuv6E97
         F+xMDkcQOEEjl0OQOqReOKAB2mWDFPN2LEFmfLNwdfXI4RA8iuoL+aBebyrP0d7h1tvs
         XpEa5UoXed4Q8b2c1IDNtjFndFuYyMQZzCznKxs5pofbHgpMmu3aOmTehGln+XUVUmN0
         jOaeqf/ZGDI+PVcrkjgJC0H0KMdQX3JTkTYYECXWD+Mdugahf5Jz5tZpneOUtIIEWU8a
         BcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Of6DuVfllLEJKZni4Ai4vipcUdfNzlQ6+FZgLgcsMF8=;
        b=c2D5ZagS6BBU6TW0ZNaEoHvXKJcqwHOGlrEBBiW4QFtCuHj4AsXsX1pgg436X050rt
         YcMuh0yeI+GTxxHAG6FE6m9HyQCJVp+wBvQQwAihKnzRHeCdnzx0fLvKjOqwWaTA1EXC
         1nJFRY1G5wA5gsoTI0WzSi3aoWdGL3O/+suz11z7BfDumsX8nbOHlITgtZNjCT19ifcU
         WG5Bi0J0qecb92I7eFQyzOqxPvrOsYDi3x60zaqoTH/ryfzqT11LOAaPha5rbf4sEOcP
         WpdqaTqUDF5gyPrVWb83hwHyvNYuOnIAO10GfQ6bGIhNmwkc6wvbjJhTNziiVi583mMj
         Iafg==
X-Gm-Message-State: AGi0PubxqtS/qAiVRgrB7nqBhm4/1Y74B265szvMHihEiRAT5BJEIhn3
        PcWtMaMRGPX99SK5VC+W0Hp+MtAJn0y5Bb3NJ+E=
X-Google-Smtp-Source: APiQypKQF8wuPkIB/Ht0f9sQIUQaXRfVgczFyL9sDMRdp1ebZgYPB8wvKrKrbVS6PA73SGgLiaV98lH5IaSqDqzX4fc=
X-Received: by 2002:ac8:739a:: with SMTP id t26mr27687484qtp.311.1589388061575;
 Wed, 13 May 2020 09:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200501152335.1805790-1-enric.balletbo@collabora.com> <20200501152335.1805790-8-enric.balletbo@collabora.com>
In-Reply-To: <20200501152335.1805790-8-enric.balletbo@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 13 May 2020 18:40:50 +0200
Message-ID: <CAFqH_53h=3OXzwLnw1XT3rHYkMPOPNFBdQdPeFmNubN9qq_Twg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drm/mediatek: mtk_dsi: Create connector for bridges
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
dia dv., 1 de maig 2020 a les 17:25:
>
> Use the drm_bridge_connector helper to create a connector for pipelines
> that use drm_bridge. This allows splitting connector operations across
> multiple bridges when necessary, instead of having the last bridge in
> the chain creating the connector and handling all connector operations
> internally.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

A gentle ping on this, I think that this one is the only one that
still needs a review in the series.

Thanks,
 Enric

> ---
>
> Changes in v4: None
> Changes in v3:
> - Move the bridge.type line to the patch that adds drm_bridge support. (Laurent Pinchart)
>
> Changes in v2: None
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 4f3bd095c1ee..471fcafdf348 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -17,6 +17,7 @@
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
> @@ -183,6 +184,7 @@ struct mtk_dsi {
>         struct drm_encoder encoder;
>         struct drm_bridge bridge;
>         struct drm_bridge *next_bridge;
> +       struct drm_connector *connector;
>         struct phy *phy;
>
>         void __iomem *regs;
> @@ -977,10 +979,19 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>          */
>         dsi->encoder.possible_crtcs = 1;
>
> -       ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
> +       ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
> +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>         if (ret)
>                 goto err_cleanup_encoder;
>
> +       dsi->connector = drm_bridge_connector_init(drm, &dsi->encoder);
> +       if (IS_ERR(dsi->connector)) {
> +               DRM_ERROR("Unable to create bridge connector\n");
> +               ret = PTR_ERR(dsi->connector);
> +               goto err_cleanup_encoder;
> +       }
> +       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> +
>         return 0;
>
>  err_cleanup_encoder:
> --
> 2.26.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
