Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B3BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0966207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597761969;
	bh=uLShTqPsScOSS/Y7xhwooyk4VokN/5lcf0l5sX6cwe0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UsAdMvum9A5sOl5XY4I2L52lsNPngpLfsHBvFK98xPoINvZSkEuWoqziVGC0yZZl+
	 zc0fRnqIwZ3DfB48kC3GEX7Ff5kVf9GbJSqgt3k5X7iqfv9KRSoNhGUZ/nVuEJBRJ5
	 4IU6jnn9a3jPSUJoVd6MdkWwTaW2sYkYatk1qPwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHROqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHROqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:46:08 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F94A2087D;
        Tue, 18 Aug 2020 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597761967;
        bh=uLShTqPsScOSS/Y7xhwooyk4VokN/5lcf0l5sX6cwe0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LqPm/t4tT/0fik+ovMNaZmmhNITKQnbE/SEtpU/wQaHeFsc0oEqv0Ok7zgT8K8q0g
         RzriiVo1EJOuEDWve2doQaiolPRjJE7i2Qfp7Q61s8o6qzy1RG89yQc6J/XgBhUjv8
         N80VcYnaemw4XlLvCbVZs7Xhay5iOr2yqH8+lDpY=
Received: by mail-ej1-f45.google.com with SMTP id g19so22370916ejc.9;
        Tue, 18 Aug 2020 07:46:07 -0700 (PDT)
X-Gm-Message-State: AOAM533lKBTbAXZOYuZVpyNfYO23zEGDZfc7Gx0A0S14yLS19Cl8Vw3Z
        2kwe6chwRp8g629TF/C0G4mFpjORsFWVEEh9/w==
X-Google-Smtp-Source: ABdhPJyAegsVyLKiVAWm3/ULM5Zo7ujEpLDRmMYGDKOTvVSOcFz66S1v3I39ISq/ljIBOR2BqS2UuSxiTjiBJSeDKEk=
X-Received: by 2002:a17:906:15cc:: with SMTP id l12mr21208887ejd.7.1597761965685;
 Tue, 18 Aug 2020 07:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200817130640.18021-1-jitao.shi@mediatek.com>
 <CAAOTY_9ggDUdDD9KoOaWBx3XaK+=Q=5qxahG7SJ5uYBQZ4aadw@mail.gmail.com> <1597718492.6381.6.camel@mszsdaap41>
In-Reply-To: <1597718492.6381.6.camel@mszsdaap41>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 18 Aug 2020 22:45:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_94Bd4PGnn88r_yJC0LYkmcByTY52gwNMALuv9+D0rTXg@mail.gmail.com>
Message-ID: <CAAOTY_94Bd4PGnn88r_yJC0LYkmcByTY52gwNMALuv9+D0rTXg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: dsi: fix scrolling of panel with small
 hfp or hbp
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, 2020-08-18 at 07:42 +0800, Chun-Kuang Hu wrote:
> > Hi, Jitao:
> >
> > Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8817=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:07=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > horizontal_backporch_byte should be hbp * bpp - hbp extra bytes.
> > > So remove the wrong subtraction 10.
> > >
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/med=
iatek/mtk_dsi.c
> > > index 270bf22c98fe..5d031e634571 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > @@ -473,14 +473,13 @@ static void mtk_dsi_config_vdo_timing(struct mt=
k_dsi *dsi)
> > >         horizontal_sync_active_byte =3D (vm->hsync_len * dsi_tmp_buf_=
bpp - 10);
> >
> > So this subtraction 10 is correct?
> >
> > Regards,
> > Chun-Kuang.
> >
>
> Yes, It is right.
>
> In the cea861 and dmt spec the mini hsync is 40 pixels.
> So the vm->hsync_len * dsi_tmp_buf_bpp >=3D 120 > 10
>

OK, so

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Best Regards
> jitao
> > >
> > >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> > > -               horizontal_backporch_byte =3D
> > > -                       (vm->hback_porch * dsi_tmp_buf_bpp - 10);
> > > +               horizontal_backporch_byte =3D vm->hback_porch * dsi_t=
mp_buf_bpp;
> > >         else
> > > -               horizontal_backporch_byte =3D ((vm->hback_porch + vm-=
>hsync_len) *
> > > -                       dsi_tmp_buf_bpp - 10);
> > > +               horizontal_backporch_byte =3D (vm->hback_porch + vm->=
hsync_len) *
> > > +                                           dsi_tmp_buf_bpp;
> > >
> > >         data_phy_cycles =3D timing->lpx + timing->da_hs_prepare +
> > > -                         timing->da_hs_zero + timing->da_hs_exit + 3=
;
> > > +                         timing->da_hs_zero + timing->da_hs_exit;
> > >
> > >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > >                 if ((vm->hfront_porch + vm->hback_porch) * dsi_tmp_bu=
f_bpp >
> > > --
> > > 2.12.5
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
