Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17067C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1E120848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598571276;
	bh=iGZm6J2WjfhefsqczRG+TkUdP6+d7DesLYj0sZgatNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=itoz2WpsS3Lt6UTTesRvTaE3KOIotREG6c5WdpVdLiU0RJChlQoDWrtqeOqJ/3nGV
	 fpWZgqh9hTBhYAeSDh+44oQ4Ko6ZPUS7lGkiTVWN7sIr//LbCG4EaXiXQED16Kxj1X
	 HjhTXMq58HK79AID9+0tH3qWtihLHQARsFaKFYMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgH0Xed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0Xed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 19:34:33 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86AA20848
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598571273;
        bh=iGZm6J2WjfhefsqczRG+TkUdP6+d7DesLYj0sZgatNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/8JOJEf2xry+J1SsJB5G5gDe//xmBO7o5SCt5TaFXMVNxfBJecYY46P/XQIwiYL6
         l3pFlqQSOdSOJ/oAMOHWmsD7ZoVKu3wvRiunoc6BtvdBYqHqHweyrQ0VuAlJH8/gap
         nEwA7CR9IgahFb5vluTbb8piIERckSv23IU9408g=
Received: by mail-ej1-f51.google.com with SMTP id j25so9942938ejk.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:34:32 -0700 (PDT)
X-Gm-Message-State: AOAM530iQ4TsuUZ4EnILRU+UhuPbbQYHRSXfy0kfcALfZ4jq+14BHhUP
        jje3C/SDvUNfISe7bzRuow888a0laM1mL53sPQ==
X-Google-Smtp-Source: ABdhPJym6RGZ5YVf6d7TmbAgVP0wINQV7MRPLDDxCToUeFwhon4p3PcCf89uMn44GaG8iKQOaIqwckS4XM39deoVjvY=
X-Received: by 2002:a17:906:2b0d:: with SMTP id a13mr22510518ejg.433.1598571271342;
 Thu, 27 Aug 2020 16:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200819081752.4805-1-linux@fw-web.de> <20200819081752.4805-6-linux@fw-web.de>
 <4812f750-5f85-61bb-fb68-4eec99285e77@gmail.com>
In-Reply-To: <4812f750-5f85-61bb-fb68-4eec99285e77@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 28 Aug 2020 07:34:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY___2nnjc14WB80VD2Hi607xXh8S8UAom3BJh6ZcwMbvAA@mail.gmail.com>
Message-ID: <CAAOTY___2nnjc14WB80VD2Hi607xXh8S8UAom3BJh6ZcwMbvAA@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] drm/mediatek: dpi/dsi: change the getting
 possible_crtc way
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=88=
20=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:14=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 19/08/2020 10:17, Frank Wunderlich wrote:
> > From: Jitao Shi <jitao.shi@mediatek.com>
> >
> > For current mediatek dsi encoder, its possible crtc is fixed in crtc
> > 0, and mediatek dpi encoder's possible crtc is fixed in crtc 1. In
> > some SoC the possible crtc is not fixed in this case, so call
> > mtk_drm_find_possible_crtc_by_comp() to find out the correct possible
> > crtc.
> >
>
> Hm, shouldn't we stash this int 4/7, otherwise we will have not used func=
tions
> in 4/7.

Agree with Matthias, so squash this patch into 4/7, and applied to
mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
>
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_dpi.c | 3 ++-
> >   drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
> >   2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index d4f0fb7ad312..e43977015843 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -608,7 +608,8 @@ static int mtk_dpi_bind(struct device *dev, struct =
device *master, void *data)
> >       drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_fun=
cs);
> >
> >       /* Currently DPI0 is fixed to be driven by OVL1 */
> > -     dpi->encoder.possible_crtcs =3D BIT(1);
> > +     dpi->encoder.possible_crtcs =3D
> > +             mtk_drm_find_possible_crtc_by_comp(drm_dev, dpi->ddp_comp=
);
> >
> >       ret =3D drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL, 0);
> >       if (ret) {
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/media=
tek/mtk_dsi.c
> > index 16fd99dcdacf..c9f4ad029cb1 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -974,7 +974,8 @@ static int mtk_dsi_encoder_init(struct drm_device *=
drm, struct mtk_dsi *dsi)
> >        * Currently display data paths are statically assigned to a crtc=
 each.
> >        * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
> >        */
> > -     dsi->encoder.possible_crtcs =3D 1;
> > +     dsi->encoder.possible_crtcs =3D
> > +             mtk_drm_find_possible_crtc_by_comp(drm, dsi->ddp_comp);
> >
> >       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
> >                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >
