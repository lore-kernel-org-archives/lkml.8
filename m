Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD468C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9C5206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589474698;
	bh=g3SxwpF3clkQJALOVOS+tQn/1CGjcxeO8y+OVIVgzLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZelI8ktM24TK9SvNx6psxbk2JU4wFvHD3XcqwEomJh8p6VdVml2P0riGFdUojkIxs
	 LIiSTnQnqxXEHfJWlCZ1+KkpDHTdCFGtVo7YWJKtr5Nw6lQ2y1fZiT/tstiYapvHOM
	 0qbbOhFxF28lhPFWo7Yye5IGwmesUjBeRsajHXAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgENQo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgENQo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:44:57 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE1320787
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589474696;
        bh=g3SxwpF3clkQJALOVOS+tQn/1CGjcxeO8y+OVIVgzLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MkaHA97B58iZXj6+65p3f1T91JqZkJQzwpNHdo6vPoYYkZlAiJPG9LTjGGEzoD8pA
         qhM7eIfeZx0+oVEiIkdf2DfGSBvBeEu/V7L+uRo4KPVi3shknaHGjcN+BXN1wyhMR6
         j7tKkKLFYkeJvl/kGOseNs3Eyd6ombC2s+cqjtl8=
Received: by mail-ed1-f45.google.com with SMTP id l3so2893062edq.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:44:55 -0700 (PDT)
X-Gm-Message-State: AOAM531bUPK37dFnXGBTXha3dxpg477yMQg6vSOZkLA3oCYb3FzI6rCo
        bnK4JQTzqjfT1FdoPAqHx7110egRM04YUKymMg==
X-Google-Smtp-Source: ABdhPJxRZVleyxRQLDDwmHotVve0XmbOf8F5XT0JEZmHvi0qKhWaSF9zIPbdA7Kwd48aNi+JmKkiQ0/Yu2h9DjoweKo=
X-Received: by 2002:a05:6402:1f6:: with SMTP id i22mr4855618edy.271.1589474694258;
 Thu, 14 May 2020 09:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
 <20200501152335.1805790-8-enric.balletbo@collabora.com> <CAFqH_53h=3OXzwLnw1XT3rHYkMPOPNFBdQdPeFmNubN9qq_Twg@mail.gmail.com>
 <CAAOTY_-pOUuM7LQ1jm6gqpg8acMqDWOHxGucY5XOjq0ctGUkzA@mail.gmail.com> <53683f2d-23c7-57ab-2056-520c50795ffe@collabora.com>
In-Reply-To: <53683f2d-23c7-57ab-2056-520c50795ffe@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 15 May 2020 00:44:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY__b6V12fS2xTKGjB1fQTfRjX7AQyBqDPXzshfhkjjSkeQ@mail.gmail.com>
Message-ID: <CAAOTY__b6V12fS2xTKGjB1fQTfRjX7AQyBqDPXzshfhkjjSkeQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drm/mediatek: mtk_dsi: Create connector for bridges
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
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

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B45=E6=9C=8814=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:42=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On 14/5/20 16:28, Chun-Kuang Hu wrote:
> > Hi, Enric:
> >
> > Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2020=E5=B9=B45=E6=
=9C=8814=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:41=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >> Hi Chun-Kuang,
> >>
> >> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
> >> dia dv., 1 de maig 2020 a les 17:25:
> >>>
> >>> Use the drm_bridge_connector helper to create a connector for pipelin=
es
> >>> that use drm_bridge. This allows splitting connector operations acros=
s
> >>> multiple bridges when necessary, instead of having the last bridge in
> >>> the chain creating the connector and handling all connector operation=
s
> >>> internally.
> >>>
> >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> >>
> >> A gentle ping on this, I think that this one is the only one that
> >> still needs a review in the series.
> >
> > This is what I reply in patch v3:
> >
>
> Sorry for missing this.
>
> > I think the panel is wrapped into next_bridge here,
> >
>
> Yes, you can have for example:
>
> 1. drm_bridge (mtk_dsi) -> drm_bridge (ps8640 - dsi-to-edp) -> drm_panel_=
bridge
> (edp panel)
>
> or a
>
> 2. drm_bridge (mtk_dsi)-> drm_panel_bridge (dsi panel)
>
> The _first_ one is my use case
>
> > if (panel) {
>
> This handles the second case, where you attach a dsi panel.
>
> >     dsi->next_bridge =3D devm_drm_panel_bridge_add(dev, panel);
> >
> > so the next_bridge is a panel_bridge, in its attach function
> > panel_bridge_attach(),
> > according to the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR, if not exist,
> > it would create connector and attach connector to panel.
> >
> > I'm not sure this flag would exist or not, but for both case, it's stra=
nge.
> > If exist, you create connector in this patch but no where to attach
> > connector to panel.
>
> Yes, in fact, this is transitional patch needed, as once I converted mtk_=
dpi,
> mtk_dsi and mtk_hdmi to the new drm_bridge API the drm_bridge_connector_i=
nit()
> will be done in mtk_drm_drv. We will need to call drm_bridge_connector_in=
it for
> dpi and dsi pipes and remove that call from mtk_dsi and mtk_dpi drivers. =
The
> graphic controller driver should create connectors and CRTCs, as example =
you can
> take a look at drivers/gpu/drm/omapdrm/omap_drv.c
>

I have such question because I've reviewed omap's driver. In omap's
driver, after it call drm_bridge_connector_init(), it does this:

if (pipe->output->panel) {
ret =3D drm_panel_attach(pipe->output->panel,
      pipe->connector);
if (ret < 0)
return ret;
}

In this patch, you does not do this.

> > If not exist, the next_brige would create one connector and this brige
> > would create another connector.
> >
> > I think in your case, mtk_dsi does not directly connect to a panel, so
>
> Exactly
>
> > I need a exact explain. Or someone could test this on a
> > directly-connect-panel platform.
>
> I don't think I am breaking this use case but AFAICS there is no users in
> mainline that directly connect a panel using the mediatek driver. As I sa=
id my
> use case is the other so I can't really test. Do you know anyone that can=
 test this?

I'm not sure who can test this, but [1], which is sent by YT Shen in a
series, is a patch to support dsi command mode so dsi could directly
connect to panel.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/mediatek?h=3Dv5.7-rc5&id=3D21898816831fc60c92dd634ab4316=
a24da7eb4af

It's better that someone could test this case, but if no one would
test this, I could also accept a good-look patch.

Regards,
Chun-Kuang.

>
> Thanks,
>  Enric
>
> >
> > Regards,
> > Chun-Kuang.
> >
> >>
> >> Thanks,
> >>  Enric
> >>
> >>> ---
> >>>
> >>> Changes in v4: None
> >>> Changes in v3:
> >>> - Move the bridge.type line to the patch that adds drm_bridge support=
. (Laurent Pinchart)
> >>>
> >>> Changes in v2: None
> >>>
> >>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++++++++++++-
> >>>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/med=
iatek/mtk_dsi.c
> >>> index 4f3bd095c1ee..471fcafdf348 100644
> >>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> >>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> >>> @@ -17,6 +17,7 @@
> >>>
> >>>  #include <drm/drm_atomic_helper.h>
> >>>  #include <drm/drm_bridge.h>
> >>> +#include <drm/drm_bridge_connector.h>
> >>>  #include <drm/drm_mipi_dsi.h>
> >>>  #include <drm/drm_of.h>
> >>>  #include <drm/drm_panel.h>
> >>> @@ -183,6 +184,7 @@ struct mtk_dsi {
> >>>         struct drm_encoder encoder;
> >>>         struct drm_bridge bridge;
> >>>         struct drm_bridge *next_bridge;
> >>> +       struct drm_connector *connector;
> >>>         struct phy *phy;
> >>>
> >>>         void __iomem *regs;
> >>> @@ -977,10 +979,19 @@ static int mtk_dsi_encoder_init(struct drm_devi=
ce *drm, struct mtk_dsi *dsi)
> >>>          */
> >>>         dsi->encoder.possible_crtcs =3D 1;
> >>>
> >>> -       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, =
0);
> >>> +       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
> >>> +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >>>         if (ret)
> >>>                 goto err_cleanup_encoder;
> >>>
> >>> +       dsi->connector =3D drm_bridge_connector_init(drm, &dsi->encod=
er);
> >>> +       if (IS_ERR(dsi->connector)) {
> >>> +               DRM_ERROR("Unable to create bridge connector\n");
> >>> +               ret =3D PTR_ERR(dsi->connector);
> >>> +               goto err_cleanup_encoder;
> >>> +       }
> >>> +       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >>> +
> >>>         return 0;
> >>>
> >>>  err_cleanup_encoder:
> >>> --
> >>> 2.26.2
> >>>
> >>>
> >>> _______________________________________________
> >>> Linux-mediatek mailing list
> >>> Linux-mediatek@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
