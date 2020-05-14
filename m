Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE12C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3739E206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589466529;
	bh=c9L1O1InlStlIGidxd6wkgttvIpBEDDoT/skiDV3RvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lsrUEGA2+Fm31Ir0CWbWkZfScEN9YK8RjMCxXei9BKTU8fsaC2tfmiMAXXF0xRAiC
	 TksWtlBQQA8ECtNg2OjXn57oJoumTDQM97bxXaz8hC7SZtalW29iQ+Ni0bzhKIJSBa
	 N6hQDDmontioT4sS2JNRjAqvwBCrbzY6rrwz/GOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgENO2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgENO2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:28:47 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAB82078C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589466526;
        bh=c9L1O1InlStlIGidxd6wkgttvIpBEDDoT/skiDV3RvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JxDecQBn7l1dJvcoAMtJKzjbkyoPCFe3jN6GE9bIN4vNpmS0jZ4BL8QmgWPYGhjdx
         98XZLTISx3rmSGgsqNb9oJHtZnynI6zR0DVGcAvfrbFtKT3rANG5o1pYzdwIFJnaVV
         3fYXikXicKhyaywo187A9P+UdGinb8CG40vHH6cI=
Received: by mail-ed1-f53.google.com with SMTP id g9so2527052edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:28:46 -0700 (PDT)
X-Gm-Message-State: AOAM533Tn3CP4+LAoWZjuPfY+fBAyCMBlsn+qAlXS7TM2Q16TbJ5OVjz
        XeM5+5/GVuEPoyOVjlyI/xYCLWCXKdChg/Tqsg==
X-Google-Smtp-Source: ABdhPJwIyb+lTea2pZcVEwHLHdT4AKiwC3a2Q/WIWGftFZnpe494JxoCIClrf22bFDtgFzG2+qSq9oUl8aupkmV1SZA=
X-Received: by 2002:a50:ea87:: with SMTP id d7mr4038661edo.48.1589466524869;
 Thu, 14 May 2020 07:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
 <20200501152335.1805790-8-enric.balletbo@collabora.com> <CAFqH_53h=3OXzwLnw1XT3rHYkMPOPNFBdQdPeFmNubN9qq_Twg@mail.gmail.com>
In-Reply-To: <CAFqH_53h=3OXzwLnw1XT3rHYkMPOPNFBdQdPeFmNubN9qq_Twg@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 14 May 2020 22:28:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-pOUuM7LQ1jm6gqpg8acMqDWOHxGucY5XOjq0ctGUkzA@mail.gmail.com>
Message-ID: <CAAOTY_-pOUuM7LQ1jm6gqpg8acMqDWOHxGucY5XOjq0ctGUkzA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drm/mediatek: mtk_dsi: Create connector for bridges
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=
=8814=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:41=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Chun-Kuang,
>
> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
> dia dv., 1 de maig 2020 a les 17:25:
> >
> > Use the drm_bridge_connector helper to create a connector for pipelines
> > that use drm_bridge. This allows splitting connector operations across
> > multiple bridges when necessary, instead of having the last bridge in
> > the chain creating the connector and handling all connector operations
> > internally.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> A gentle ping on this, I think that this one is the only one that
> still needs a review in the series.

This is what I reply in patch v3:

I think the panel is wrapped into next_bridge here,

if (panel) {
    dsi->next_bridge =3D devm_drm_panel_bridge_add(dev, panel);

so the next_bridge is a panel_bridge, in its attach function
panel_bridge_attach(),
according to the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR, if not exist,
it would create connector and attach connector to panel.

I'm not sure this flag would exist or not, but for both case, it's strange.
If exist, you create connector in this patch but no where to attach
connector to panel.
If not exist, the next_brige would create one connector and this brige
would create another connector.

I think in your case, mtk_dsi does not directly connect to a panel, so
I need a exact explain. Or someone could test this on a
directly-connect-panel platform.

Regards,
Chun-Kuang.

>
> Thanks,
>  Enric
>
> > ---
> >
> > Changes in v4: None
> > Changes in v3:
> > - Move the bridge.type line to the patch that adds drm_bridge support. =
(Laurent Pinchart)
> >
> > Changes in v2: None
> >
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/media=
tek/mtk_dsi.c
> > index 4f3bd095c1ee..471fcafdf348 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -17,6 +17,7 @@
> >
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> > +#include <drm/drm_bridge_connector.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> > @@ -183,6 +184,7 @@ struct mtk_dsi {
> >         struct drm_encoder encoder;
> >         struct drm_bridge bridge;
> >         struct drm_bridge *next_bridge;
> > +       struct drm_connector *connector;
> >         struct phy *phy;
> >
> >         void __iomem *regs;
> > @@ -977,10 +979,19 @@ static int mtk_dsi_encoder_init(struct drm_device=
 *drm, struct mtk_dsi *dsi)
> >          */
> >         dsi->encoder.possible_crtcs =3D 1;
> >
> > -       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0)=
;
> > +       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
> > +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >         if (ret)
> >                 goto err_cleanup_encoder;
> >
> > +       dsi->connector =3D drm_bridge_connector_init(drm, &dsi->encoder=
);
> > +       if (IS_ERR(dsi->connector)) {
> > +               DRM_ERROR("Unable to create bridge connector\n");
> > +               ret =3D PTR_ERR(dsi->connector);
> > +               goto err_cleanup_encoder;
> > +       }
> > +       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> > +
> >         return 0;
> >
> >  err_cleanup_encoder:
> > --
> > 2.26.2
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
