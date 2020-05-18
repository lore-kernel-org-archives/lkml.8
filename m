Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA99C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D719207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/0XbD1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgERRMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:12:01 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:12:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v15so5071204qvr.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yijTSszOmirrN4dcf+zjcxVlnR23zFrRY84RCRmsEHc=;
        b=X/0XbD1lQ13+eZr52dRelGxdLfX0hNxu9gqDRuBIKnHVBfXNSmt3sr1StzGjNq3ATp
         nNh6rUAGrIWX/x8hE4jWd2RRAgmPmlycThUeU8WIYZRIWTUwYWY3TxwHbq+YkmRJwRRk
         kgWuQwZQHzcHXftWPvc4bYAjMMueXFM7Jh79R7dekcaUAq+bGIvla3ClJIsDD4sSoiRi
         fTxxRnS9jpIqpBEAFH5DlPgeG1zILA1j4M6xBkYJXfmVBspw9MxlDEVkgHinl5JK3JsM
         JcUj6sPSahs04snUCY6B7x0tA5ueFI7SLNXkbQBMtbEIYhtnCmjztw4yuQtTitFPU7WJ
         9wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yijTSszOmirrN4dcf+zjcxVlnR23zFrRY84RCRmsEHc=;
        b=Dzo1Req3MuX/eQKjaSRBPM1uPT6yT4oVnWrVehTHT5nMsk9iTSlbuwLHmmvPkTL9R9
         Qu902xyoMV6fAf+0upbJXCes+0zGh2kPXA3KJtwo10XOdGsjNnlFmb3MnrIC8KLpqqy0
         qU8W37ja+epa/iOjvnZIbDodtfUZOv1yMowCKX750Zpt7XZhLtKV8p2e63fnslJjO3hM
         4fMdhf4bOt+AeeT+6ch5n9nCVCgyTwY1Mav7J8nEgf3veoIFQrQVUJ0woi9VmkeInNv7
         uEVAD7V7ZN13OZbW6dAHAdxRNkxiWzOoFofEfqpQf/IK+ckbECxFOC6N2AGzzYjIlwoP
         gfRQ==
X-Gm-Message-State: AOAM532VyaicGseIefksc3oHZ+LVk1wNjSGMryvD4Zcbjbn/if9D+6V4
        aWX7U0JpPFlEg7ahndEKBlyDknB62kFXgINfPJI=
X-Google-Smtp-Source: ABdhPJzw1WFo4BEBKw/NTJAYyzgk94FU/T8fZ9uRFndR1BREptGLqHhw7soukJPoF4CYNE7kzMYuDvlAwjuqNHm0Fc4=
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr11194223qvu.197.1589821920011;
 Mon, 18 May 2020 10:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
 <20200501152335.1805790-8-enric.balletbo@collabora.com> <CAFqH_53h=3OXzwLnw1XT3rHYkMPOPNFBdQdPeFmNubN9qq_Twg@mail.gmail.com>
 <CAAOTY_-pOUuM7LQ1jm6gqpg8acMqDWOHxGucY5XOjq0ctGUkzA@mail.gmail.com>
 <53683f2d-23c7-57ab-2056-520c50795ffe@collabora.com> <CAAOTY__b6V12fS2xTKGjB1fQTfRjX7AQyBqDPXzshfhkjjSkeQ@mail.gmail.com>
 <37191700-5832-2931-5764-7f7fddd023b9@collabora.com> <e1ac7d75-c46a-445a-5fcf-5253548f2707@collabora.com>
 <CAAOTY_-w0V0iQgjZ0n26KKs_MdB-im9+LC2EDTmGo0wMG9p_Vw@mail.gmail.com>
In-Reply-To: <CAAOTY_-w0V0iQgjZ0n26KKs_MdB-im9+LC2EDTmGo0wMG9p_Vw@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 18 May 2020 19:11:48 +0200
Message-ID: <CAFqH_52YJEnuoXmJVq1TgH5Ay76p-feVQPZ6s4h-1TMBDQ8fDA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drm/mediatek: mtk_dsi: Create connector for bridges
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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

Hi Chun-Kuang,

Missatge de Chun-Kuang Hu <chunkuang.hu@kernel.org> del dia ds., 16 de
maig 2020 a les 12:11:
>
> Hi, Enric:
>
> Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B45=E6=9C=8815=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:35=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > Hi again,
> >
> > On 14/5/20 19:12, Enric Balletbo i Serra wrote:
> > > Hi Chun-Kuang,
> > >
> > > On 14/5/20 18:44, Chun-Kuang Hu wrote:
> > >> Hi, Enric:
> > >>
> > >> Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=
=E5=B9=B45=E6=9C=8814=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:42=
=E5=AF=AB=E9=81=93=EF=BC=9A
> > >>>
> > >>> Hi Chun-Kuang,
> > >>>
> > >>> On 14/5/20 16:28, Chun-Kuang Hu wrote:
> > >>>> Hi, Enric:
> > >>>>
> > >>>> Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2020=E5=B9=B4=
5=E6=9C=8814=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:41=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > >>>>>
> > >>>>> Hi Chun-Kuang,
> > >>>>>
> > >>>>> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com>=
 del
> > >>>>> dia dv., 1 de maig 2020 a les 17:25:
> > >>>>>>
> > >>>>>> Use the drm_bridge_connector helper to create a connector for pi=
pelines
> > >>>>>> that use drm_bridge. This allows splitting connector operations =
across
> > >>>>>> multiple bridges when necessary, instead of having the last brid=
ge in
> > >>>>>> the chain creating the connector and handling all connector oper=
ations
> > >>>>>> internally.
> > >>>>>>
> > >>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.=
com>
> > >>>>>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > >>>>>
> > >>>>> A gentle ping on this, I think that this one is the only one that
> > >>>>> still needs a review in the series.
> > >>>>
> > >>>> This is what I reply in patch v3:
> > >>>>
> > >>>
> > >>> Sorry for missing this.
> > >>>
> > >>>> I think the panel is wrapped into next_bridge here,
> > >>>>
> > >>>
> > >>> Yes, you can have for example:
> > >>>
> > >>> 1. drm_bridge (mtk_dsi) -> drm_bridge (ps8640 - dsi-to-edp) -> drm_=
panel_bridge
> > >>> (edp panel)
> > >>>
> > >>> or a
> > >>>
> > >>> 2. drm_bridge (mtk_dsi)-> drm_panel_bridge (dsi panel)
> > >>>
> > >>> The _first_ one is my use case
> > >>>
> > >>>> if (panel) {
> > >>>
> > >>> This handles the second case, where you attach a dsi panel.
> > >>>
> > >>>>     dsi->next_bridge =3D devm_drm_panel_bridge_add(dev, panel);
> > >>>>
> > >>>> so the next_bridge is a panel_bridge, in its attach function
> > >>>> panel_bridge_attach(),
> > >>>> according to the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR, if not exist=
,
> > >>>> it would create connector and attach connector to panel.
> > >>>>
> > >>>> I'm not sure this flag would exist or not, but for both case, it's=
 strange.
> > >>>> If exist, you create connector in this patch but no where to attac=
h
> > >>>> connector to panel.
> > >>>
> > >>> Yes, in fact, this is transitional patch needed, as once I converte=
d mtk_dpi,
> > >>> mtk_dsi and mtk_hdmi to the new drm_bridge API the drm_bridge_conne=
ctor_init()
> > >>> will be done in mtk_drm_drv. We will need to call drm_bridge_connec=
tor_init for
> > >>> dpi and dsi pipes and remove that call from mtk_dsi and mtk_dpi dri=
vers. The
> > >>> graphic controller driver should create connectors and CRTCs, as ex=
ample you can
> > >>> take a look at drivers/gpu/drm/omapdrm/omap_drv.c
> > >>>
> > >>
> > >> I have such question because I've reviewed omap's driver. In omap's
> > >> driver, after it call drm_bridge_connector_init(), it does this:
> > >>
> > >> if (pipe->output->panel) {
> > >> ret =3D drm_panel_attach(pipe->output->panel,
> > >>       pipe->connector);
> > >> if (ret < 0)
> > >> return ret;
> > >> }
> > >>
> > >> In this patch, you does not do this.
> > >>
> > >
> > > I see, so yes, I am probably missing call drm_panel_attach in case th=
ere is a
> > > direct panel attached. Thanks for pointing it.
> > >
> > > I'll send a new version adding the drm_panel_attach call.
> > >
> >
> > Wait, shouldn't panel be attached on the call of mtk_dsi_bridge_attach =
as
> > next_bridge points to a bridge or a panel?
> >
> > static int mtk_dsi_bridge_attach(struct drm_bridge *bridge,
> >                                  enum drm_bridge_attach_flags flags)
> > {
> >         struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> >
> >         /* Attach the panel or bridge to the dsi bridge */
> >         return drm_bridge_attach(bridge->encoder, dsi->next_bridge,
> >                                  &dsi->bridge, flags);
> > }
> >
> > Or I am continuing misunderstanding all this?
> >
>
> My point is: when do you attach panel to a connector?
> In this patch,
>
> ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
>                                           DRM_BRIDGE_ATTACH_NO_CONNECTOR)=
;
>
> it would call into mtk_dsi_bridge_attach() with
> DRM_BRIDGE_ATTACH_NO_CONNECTOR, and call into panel_bridge_attach()
> with DRM_BRIDGE_ATTACH_NO_CONNECTOR.

My understanding is that the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is to
ease transition between the old and the new model. The drivers that
support the new model shall set that flag.

> If you does not pass DRM_BRIDGE_ATTACH_NO_CONNECTOR into
> panel_bridge_attach(), it would create a connector and attach panel to
> that connector.

Yes, and create a connector an attach the panel is the old model, I
guess. Hence we are passing DRM_BRIDGE_ATTACH_NO_CONNECTOR.

> And you pass DRM_BRIDGE_ATTACH_NO_CONNECTOR into
> panel_bridge_attach(), so I thiink you need to create connector and
> attach panel to that connector by yourself (this is what omap does).
>

Yes, omap driver supports both models the old and the new.  For
mtk_dsi I expect all the drivers in the chain use the new model. IIUC
create the connector here and attach to the panel is only needed to
support also the old model.

drm_panel_attach() is called in panel_bridge_attach() which is the
drm_brige_funcs.attach() handler for the panel bridge. As we're using
the panel bridge

    dsi->next_bridge =3D devm_drm_panel_bridge_add(dev, panel);

there should be no need to call drm_panel_attach().

My point is, do we need to support the old model for mtk_dsi driver
even we don't have users for the old model, or can we migrate
unconditionally?

Please correct me if I'm still misunderstanding the problem.

Regards,
 Enric

> Regards,
> Chun-Kuang.
>
> > >>>> If not exist, the next_brige would create one connector and this b=
rige
> > >>>> would create another connector.
> > >>>>
> > >>>> I think in your case, mtk_dsi does not directly connect to a panel=
, so
> > >>>
> > >>> Exactly
> > >>>
> > >>>> I need a exact explain. Or someone could test this on a
> > >>>> directly-connect-panel platform.
> > >>>
> > >>> I don't think I am breaking this use case but AFAICS there is no us=
ers in
> > >>> mainline that directly connect a panel using the mediatek driver. A=
s I said my
> > >>> use case is the other so I can't really test. Do you know anyone th=
at can test this?
> > >>
> > >> I'm not sure who can test this, but [1], which is sent by YT Shen in=
 a
> > >> series, is a patch to support dsi command mode so dsi could directly
> > >> connect to panel.
> > >>
> > >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/drivers/gpu/drm/mediatek?h=3Dv5.7-rc5&id=3D21898816831fc60c92dd63=
4ab4316a24da7eb4af
> > >>
> > >> It's better that someone could test this case, but if no one would
> > >> test this, I could also accept a good-look patch.
> > >>
> > >> Regards,
> > >> Chun-Kuang.
> > >>
> > >>>
> > >>> Thanks,
> > >>>  Enric
> > >>>
> > >>>>
> > >>>> Regards,
> > >>>> Chun-Kuang.
> > >>>>
> > >>>>>
> > >>>>> Thanks,
> > >>>>>  Enric
> > >>>>>
> > >>>>>> ---
> > >>>>>>
> > >>>>>> Changes in v4: None
> > >>>>>> Changes in v3:
> > >>>>>> - Move the bridge.type line to the patch that adds drm_bridge su=
pport. (Laurent Pinchart)
> > >>>>>>
> > >>>>>> Changes in v2: None
> > >>>>>>
> > >>>>>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++++++++++++-
> > >>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
> > >>>>>>
> > >>>>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/dr=
m/mediatek/mtk_dsi.c
> > >>>>>> index 4f3bd095c1ee..471fcafdf348 100644
> > >>>>>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > >>>>>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > >>>>>> @@ -17,6 +17,7 @@
> > >>>>>>
> > >>>>>>  #include <drm/drm_atomic_helper.h>
> > >>>>>>  #include <drm/drm_bridge.h>
> > >>>>>> +#include <drm/drm_bridge_connector.h>
> > >>>>>>  #include <drm/drm_mipi_dsi.h>
> > >>>>>>  #include <drm/drm_of.h>
> > >>>>>>  #include <drm/drm_panel.h>
> > >>>>>> @@ -183,6 +184,7 @@ struct mtk_dsi {
> > >>>>>>         struct drm_encoder encoder;
> > >>>>>>         struct drm_bridge bridge;
> > >>>>>>         struct drm_bridge *next_bridge;
> > >>>>>> +       struct drm_connector *connector;
> > >>>>>>         struct phy *phy;
> > >>>>>>
> > >>>>>>         void __iomem *regs;
> > >>>>>> @@ -977,10 +979,19 @@ static int mtk_dsi_encoder_init(struct drm=
_device *drm, struct mtk_dsi *dsi)
> > >>>>>>          */
> > >>>>>>         dsi->encoder.possible_crtcs =3D 1;
> > >>>>>>
> > >>>>>> -       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, N=
ULL, 0);
> > >>>>>> +       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, N=
ULL,
> > >>>>>> +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> > >>>>>>         if (ret)
> > >>>>>>                 goto err_cleanup_encoder;
> > >>>>>>
> > >>>>>> +       dsi->connector =3D drm_bridge_connector_init(drm, &dsi->=
encoder);
> > >>>>>> +       if (IS_ERR(dsi->connector)) {
> > >>>>>> +               DRM_ERROR("Unable to create bridge connector\n")=
;
> > >>>>>> +               ret =3D PTR_ERR(dsi->connector);
> > >>>>>> +               goto err_cleanup_encoder;
> > >>>>>> +       }
> > >>>>>> +       drm_connector_attach_encoder(dsi->connector, &dsi->encod=
er);
> > >>>>>> +
> > >>>>>>         return 0;
> > >>>>>>
> > >>>>>>  err_cleanup_encoder:
> > >>>>>> --
> > >>>>>> 2.26.2
> > >>>>>>
> > >>>>>>
> > >>>>>> _______________________________________________
> > >>>>>> Linux-mediatek mailing list
> > >>>>>> Linux-mediatek@lists.infradead.org
> > >>>>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > >
