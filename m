Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE2C47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5E9208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588384470;
	bh=uY8fEHgTBnpO8fsoxZlDnMux6T26lJUIhugrBr31N6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kbu4f4UmTHGql9FMhp+I5HrTNLw4emqQLHchOJE6yZxdal/vHH+Y1IDK+xpY/t3pH
	 Vs04H9BizM9iOOhvnKmwIZTKAxM3OxQwHl/jp+272EGZdJTyzcAI3CLlfrMaBW57gd
	 mNBlmXunztQzA25s0kx+qSkqI8iaR2Wa/nUmCwQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgEBBy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 21:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgEBBy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 21:54:29 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C3D2495B
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 01:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588384468;
        bh=uY8fEHgTBnpO8fsoxZlDnMux6T26lJUIhugrBr31N6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lJ5ds4TttwcpUROIM02Abch8q9cYzIApIjH5H7FzrkOfsEFG+JygEY2PuwABm6cvn
         FJaYdq0EAVE6omje0vk8O3jjQr9jdMUBg8yfzhPe1JMcpXtpzquRSldL3dESw8AGsp
         r5Ce54XMyml1bB9Wcvs0d/naEeSfmZngKFQqOSkg=
Received: by mail-ed1-f53.google.com with SMTP id g16so8687715eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 18:54:28 -0700 (PDT)
X-Gm-Message-State: AGi0PuZbI5IFVmkVlCDkgBG15kqedRTS+dBhIP5csgZtMmWP82jufFjf
        jWxewriSVYxQhaobhBD1BqxFZY6MjsVOayaScQ==
X-Google-Smtp-Source: APiQypIS+1NERldYNzLF5tD3POttq+/wUdUvXB9NBGGdtW+fUkc/vmloe1jVIGuZx6UIhOyurmUOKZuUiQtKW1FC/Nk=
X-Received: by 2002:a50:ea87:: with SMTP id d7mr5761934edo.48.1588384466454;
 Fri, 01 May 2020 18:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200417150614.2631786-1-enric.balletbo@collabora.com>
 <20200417150614.2631786-8-enric.balletbo@collabora.com> <CAAOTY_8uWP80ZMO5ZQGLJ5YLFZcmGjZwc33Hi_oXsCPj5Yr89A@mail.gmail.com>
 <0584a198-02f2-a8a3-676e-74365a697bd4@collabora.com>
In-Reply-To: <0584a198-02f2-a8a3-676e-74365a697bd4@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 2 May 2020 09:54:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY__UWdXMYxeYNLOEiTX+-wWuRU_xuXy9SkPToerH+=mveA@mail.gmail.com>
Message-ID: <CAAOTY__UWdXMYxeYNLOEiTX+-wWuRU_xuXy9SkPToerH+=mveA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] drm/mediatek: mtk_dsi: Create connector for bridges
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B45=E6=9C=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:59=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> Thank you for your review.
>
> On 1/5/20 16:26, Chun-Kuang Hu wrote:
> > Hi, Enric:
> >
> > Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B44=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:06=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> Use the drm_bridge_connector helper to create a connector for pipeline=
s
> >> that use drm_bridge. This allows splitting connector operations across
> >> multiple bridges when necessary, instead of having the last bridge in
> >> the chain creating the connector and handling all connector operations
> >> internally.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >> Changes in v3:
> >> - Move the bridge.type line to the patch that adds drm_bridge support.=
 (Laurent Pinchart)
> >>
> >> Changes in v2: None
> >>
> >>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/medi=
atek/mtk_dsi.c
> >> index 157097c63b23..85f76b01ae4d 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> >> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> >> @@ -17,6 +17,7 @@
> >>
> >>  #include <drm/drm_atomic_helper.h>
> >>  #include <drm/drm_bridge.h>
> >> +#include <drm/drm_bridge_connector.h>
> >>  #include <drm/drm_mipi_dsi.h>
> >>  #include <drm/drm_of.h>
> >>  #include <drm/drm_panel.h>
> >> @@ -183,6 +184,7 @@ struct mtk_dsi {
> >>         struct drm_encoder encoder;
> >>         struct drm_bridge bridge;
> >>         struct drm_bridge *next_bridge;
> >> +       struct drm_connector *connector;
> >>         struct phy *phy;
> >>
> >>         void __iomem *regs;
> >> @@ -977,10 +979,19 @@ static int mtk_dsi_encoder_init(struct drm_devic=
e *drm, struct mtk_dsi *dsi)
> >>          */
> >>         dsi->encoder.possible_crtcs =3D 1;
> >>
> >> -       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0=
);
> >> +       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
> >> +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >>         if (ret)
> >>                 goto err_cleanup_encoder;
> >>
> >> +       dsi->connector =3D drm_bridge_connector_init(drm, &dsi->encode=
r);
> >> +       if (IS_ERR(dsi->connector)) {
> >> +               DRM_ERROR("Unable to create bridge connector\n");
> >> +               ret =3D PTR_ERR(dsi->connector);
> >> +               goto err_cleanup_encoder;
> >> +       }
> >> +       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >> +
> >
> > I'm not very clear about how brige-connector works, but why connector
> > does not attach to panel?
> >
>
> Laurent or other drm maintainers might have more details than me, but, AF=
AIK the
> drm_bridge_connector_init initializes a connector for a chain of bridges =
that
> starts at the @encoder. At this point you don't know which bridge is conn=
ected
> to the panel physically but doesn't really matter as what you know is tha=
t will
> be only one connector in the  chain.

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
> > Regards,
> > Chun-Kuang.
> >
> >>         return 0;
> >>
> >>  err_cleanup_encoder:
> >> --
> >> 2.25.1
> >>
