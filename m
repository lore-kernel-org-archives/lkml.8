Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47F620678
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598482935;
	bh=bCjCScApoje+ayni77KRjV1QLUiQwwWxm8yIGtQ7Vaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1DDgFy2woQsDnbF6vsmc9YlQ6CInWq70pMP36AWjdY7nNbmvXmC9pMtpfMh4AIX3n
	 C5JhGLAYQMDCiVhHI882E2Es0KtFyQxNl55Y3tnc80qn71nsp1CerRnWR95sLX2SEX
	 FXpERyaJyp7iPdcRD/8QyXBReisvjsjahLE6CtOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHZXCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgHZXCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 19:02:10 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8470D2087C;
        Wed, 26 Aug 2020 23:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598482929;
        bh=bCjCScApoje+ayni77KRjV1QLUiQwwWxm8yIGtQ7Vaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G52m6VY9mQDjn1suTD9wsUR71Zs9dOK8EwRciblQDH2krnAbYoYN9K47Ha1vXoBkR
         bLBr7vyx5GEl5IoDbhLPfCZ2y3qvvrqv4XdXirpr0Fyi1VyVdcRlBdqZz9volySEBh
         HCmpmnOV3XTIw+ZwjNWOhKLv3H1g5R2W911R4tHw=
Received: by mail-ed1-f44.google.com with SMTP id l23so3204532edv.11;
        Wed, 26 Aug 2020 16:02:09 -0700 (PDT)
X-Gm-Message-State: AOAM532Y4/UXSweiyLG9UEb3+XALas24bIjzgxbF7Myl29RtC2yiaQeo
        iVdQ4wRj0wjdkGCDMcKAA2zaam9QRlKSmlTtww==
X-Google-Smtp-Source: ABdhPJzvgIKXOsUB/2JDtGjX6TXHpU+YwBmlx7G7aEdn6AJRmJ2tC3KN8bkUm5p4M73ZSUJ2axruuCmlcgbeN/o/haA=
X-Received: by 2002:a50:d71c:: with SMTP id t28mr6557897edi.148.1598482928003;
 Wed, 26 Aug 2020 16:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200817130640.18021-1-jitao.shi@mediatek.com>
 <CAAOTY_9ggDUdDD9KoOaWBx3XaK+=Q=5qxahG7SJ5uYBQZ4aadw@mail.gmail.com>
 <1597718492.6381.6.camel@mszsdaap41> <CAAOTY_94Bd4PGnn88r_yJC0LYkmcByTY52gwNMALuv9+D0rTXg@mail.gmail.com>
In-Reply-To: <CAAOTY_94Bd4PGnn88r_yJC0LYkmcByTY52gwNMALuv9+D0rTXg@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 27 Aug 2020 07:01:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY__OfwCN4_GyyvyYRHfFh_7iRYVKtiR1ieV_Q9ijhEJw+g@mail.gmail.com>
Message-ID: <CAAOTY__OfwCN4_GyyvyYRHfFh_7iRYVKtiR1ieV_Q9ijhEJw+g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: dsi: fix scrolling of panel with small
 hfp or hbp
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:45=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Jitao:
>
> Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Tue, 2020-08-18 at 07:42 +0800, Chun-Kuang Hu wrote:
> > > Hi, Jitao:
> > >
> > > Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=881=
7=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:07=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > >
> > > > horizontal_backporch_byte should be hbp * bpp - hbp extra bytes.
> > > > So remove the wrong subtraction 10.
> > > >
> > > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/m=
ediatek/mtk_dsi.c
> > > > index 270bf22c98fe..5d031e634571 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > @@ -473,14 +473,13 @@ static void mtk_dsi_config_vdo_timing(struct =
mtk_dsi *dsi)
> > > >         horizontal_sync_active_byte =3D (vm->hsync_len * dsi_tmp_bu=
f_bpp - 10);
> > >
> > > So this subtraction 10 is correct?
> > >
> > > Regards,
> > > Chun-Kuang.
> > >
> >
> > Yes, It is right.
> >
> > In the cea861 and dmt spec the mini hsync is 40 pixels.
> > So the vm->hsync_len * dsi_tmp_buf_bpp >=3D 120 > 10
> >
>
> OK, so
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

> > Best Regards
> > jitao
> > > >
> > > >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> > > > -               horizontal_backporch_byte =3D
> > > > -                       (vm->hback_porch * dsi_tmp_buf_bpp - 10);
> > > > +               horizontal_backporch_byte =3D vm->hback_porch * dsi=
_tmp_buf_bpp;
> > > >         else
> > > > -               horizontal_backporch_byte =3D ((vm->hback_porch + v=
m->hsync_len) *
> > > > -                       dsi_tmp_buf_bpp - 10);
> > > > +               horizontal_backporch_byte =3D (vm->hback_porch + vm=
->hsync_len) *
> > > > +                                           dsi_tmp_buf_bpp;
> > > >
> > > >         data_phy_cycles =3D timing->lpx + timing->da_hs_prepare +
> > > > -                         timing->da_hs_zero + timing->da_hs_exit +=
 3;
> > > > +                         timing->da_hs_zero + timing->da_hs_exit;
> > > >
> > > >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > > >                 if ((vm->hfront_porch + vm->hback_porch) * dsi_tmp_=
buf_bpp >
> > > > --
> > > > 2.12.5
> > > > _______________________________________________
> > > > Linux-mediatek mailing list
> > > > Linux-mediatek@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >
