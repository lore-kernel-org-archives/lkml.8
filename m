Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B4AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 22:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3E920870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593901951;
	bh=JDgxeDc0q77mn2Bfmub/zIa2vh8KeOhsnmJmESnVl2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tK+/A4UvqixnAVw3vDar4czza92R1fzXLdoiPvHpIqdvPG1mwlB1/Yij32RyDoQMe
	 GvA2S8g1ED+LhFIJMMGIHu0ImouC6gQgIXw783OUo9uRsuK3uTJ5zZig7b5CVPOGYn
	 dOF9mV3tZtYXWSZB6s+6mwU/mMwZ0nRbGceVMsoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGDWca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 18:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgGDWc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 18:32:29 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9084D20870
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593901948;
        bh=JDgxeDc0q77mn2Bfmub/zIa2vh8KeOhsnmJmESnVl2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OU2Bcdj8eCRQq8bAmhgE0cftlYY58Yxm5cABJyNij191smRipqOnrccERDDwgDzvh
         0MbRVPb51d4BQjFO2kjLhRMssRQ/uR5jhrGvor4tNUsC39LEY4vE568Hl4KKZZy/AR
         hil1WKo3XVAUlPSWNvZD0kFhNY/zehPelTPTa/P0=
Received: by mail-ed1-f51.google.com with SMTP id b15so31205545edy.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 15:32:28 -0700 (PDT)
X-Gm-Message-State: AOAM531dtA2u51seFGiha3dELZnYPPeXQLI45tTp3pJJbT7ofA6kCjoE
        9dISwpql7ZcMjK0jmmMsZtWtbOH96FVhAogCNA==
X-Google-Smtp-Source: ABdhPJxIh4GPX7JSDq52xIUF04T9azFXrk5ce1qys5ZdT5X5tZvDB1t9DiHPJQy7D2fBh8P/jxN/It9MNTUvgHMpkkk=
X-Received: by 2002:a05:6402:203c:: with SMTP id ay28mr38014412edb.271.1593901947136;
 Sat, 04 Jul 2020 15:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200519094045.2447940-1-enric.balletbo@collabora.com> <CAAOTY_-m67cCrrgb=Ot9gnj22Ks3qDCDFQhELMA=m0xSB9mwWQ@mail.gmail.com>
In-Reply-To: <CAAOTY_-m67cCrrgb=Ot9gnj22Ks3qDCDFQhELMA=m0xSB9mwWQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 5 Jul 2020 06:32:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY__YSVs5dFPSBcAfpkxZLQcc+Ky_MaO7QmCnXKXYa82=7A@mail.gmail.com>
Message-ID: <CAAOTY__YSVs5dFPSBcAfpkxZLQcc+Ky_MaO7QmCnXKXYa82=7A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_mt8173_hdmi_phy: Remove unnused const variables
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
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

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:12=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Enric:
>
> Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B45=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:40=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > There are some `static const u8` variables that are not used, this
> > triggers a warning building with `make W=3D1`, it is safe to remove the=
m,
> > so do it and make the compiler more happy.
> >
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  .../gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c    | 48 -------------------
> >  1 file changed, 48 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/g=
pu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > index 1c3575372230..827b93786fac 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > @@ -107,54 +107,6 @@
> >  #define RGS_HDMITX_5T1_EDG             (0xf << 4)
> >  #define RGS_HDMITX_PLUG_TST            BIT(0)
> >
> > -static const u8 PREDIV[3][4] =3D {
> > -       {0x0, 0x0, 0x0, 0x0},   /* 27Mhz */
> > -       {0x1, 0x1, 0x1, 0x1},   /* 74Mhz */
> > -       {0x1, 0x1, 0x1, 0x1}    /* 148Mhz */
> > -};
> > -
> > -static const u8 TXDIV[3][4] =3D {
> > -       {0x3, 0x3, 0x3, 0x2},   /* 27Mhz */
> > -       {0x2, 0x1, 0x1, 0x1},   /* 74Mhz */
> > -       {0x1, 0x0, 0x0, 0x0}    /* 148Mhz */
> > -};
> > -
> > -static const u8 FBKSEL[3][4] =3D {
> > -       {0x1, 0x1, 0x1, 0x1},   /* 27Mhz */
> > -       {0x1, 0x0, 0x1, 0x1},   /* 74Mhz */
> > -       {0x1, 0x0, 0x1, 0x1}    /* 148Mhz */
> > -};
> > -
> > -static const u8 FBKDIV[3][4] =3D {
> > -       {19, 24, 29, 19},       /* 27Mhz */
> > -       {19, 24, 14, 19},       /* 74Mhz */
> > -       {19, 24, 14, 19}        /* 148Mhz */
> > -};
> > -
> > -static const u8 DIVEN[3][4] =3D {
> > -       {0x2, 0x1, 0x1, 0x2},   /* 27Mhz */
> > -       {0x2, 0x2, 0x2, 0x2},   /* 74Mhz */
> > -       {0x2, 0x2, 0x2, 0x2}    /* 148Mhz */
> > -};
> > -
> > -static const u8 HTPLLBP[3][4] =3D {
> > -       {0xc, 0xc, 0x8, 0xc},   /* 27Mhz */
> > -       {0xc, 0xf, 0xf, 0xc},   /* 74Mhz */
> > -       {0xc, 0xf, 0xf, 0xc}    /* 148Mhz */
> > -};
> > -
> > -static const u8 HTPLLBC[3][4] =3D {
> > -       {0x2, 0x3, 0x3, 0x2},   /* 27Mhz */
> > -       {0x2, 0x3, 0x3, 0x2},   /* 74Mhz */
> > -       {0x2, 0x3, 0x3, 0x2}    /* 148Mhz */
> > -};
> > -
> > -static const u8 HTPLLBR[3][4] =3D {
> > -       {0x1, 0x1, 0x0, 0x1},   /* 27Mhz */
> > -       {0x1, 0x2, 0x2, 0x1},   /* 74Mhz */
> > -       {0x1, 0x2, 0x2, 0x1}    /* 148Mhz */
> > -};
> > -
> >  static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
> >  {
> >         struct mtk_hdmi_phy *hdmi_phy =3D to_mtk_hdmi_phy(hw);
> > --
> > 2.26.2
> >
