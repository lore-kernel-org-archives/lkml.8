Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A052C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5379F2063A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595648745;
	bh=/xi1l59t4puPNMHa6vw+Wd6hAJ1YW7wjpGo/KFK67X4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oFdHKC0oV0dLFhNSG6NVtNaBDUqsADK4rG5XBNNs2MBg10Vby5Kfh8EshsZxOE6wi
	 eDRzZz6bUJiu4xU5/rl+N/OLvtY6lYAVkTc21/6F2kC/aSA1bCH2bd3AfUWKLeCnHj
	 4+Ymo1nced0VND/UMEaN7pVBGpQBUzqhaFy+Z3kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGYDp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 23:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgGYDp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:45:27 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57AA72070E;
        Sat, 25 Jul 2020 03:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595648726;
        bh=/xi1l59t4puPNMHa6vw+Wd6hAJ1YW7wjpGo/KFK67X4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iIS1UnzfBDp4JZn7blCJlTzLHKbpEZBF7uiHi6Rs7wNlnt70Gim6sl1x4nrtwsS9c
         riLZAxptx/nDlq1rkQkjqDycH66BStyZkAV52zSlNAQU/+MZgmr0dtUs6DILJJsBhY
         VM7uEN5YxXW/XjkL/bK8oVe8tMDFhN9+bLy+7VBM=
Received: by mail-ej1-f51.google.com with SMTP id c10so3718868ejs.5;
        Fri, 24 Jul 2020 20:45:26 -0700 (PDT)
X-Gm-Message-State: AOAM53192kGk/lf736UwMNw3ayc6DI7OXtggZi15HOFfkSw3drn3pMxo
        /zCnQXR14pRNFXH9i1EpYVd39J4HrRR/eUmj4Q==
X-Google-Smtp-Source: ABdhPJxzrr2oNDn9HERLTsIjAMm+pViG6iwprV4+t/cPE8RMjtFFo/kBjpquOofvuhgoLjfdcSKqzQlhG7Q0XCm7Nck=
X-Received: by 2002:a17:906:8489:: with SMTP id m9mr9652154ejx.94.1595648724836;
 Fri, 24 Jul 2020 20:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
 <1595469798-3824-8-git-send-email-yongqiang.niu@mediatek.com>
 <CAAOTY_9hdvw7htuOkJmmmGR9SAev4O+kWuMopfP_F=8Vg=_U+A@mail.gmail.com> <1595647858.13250.20.camel@mhfsdcap03>
In-Reply-To: <1595647858.13250.20.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 25 Jul 2020 11:45:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Y=bcxPWQG7H4Su_X11e3kRx761ZmHTb_wOtb0R71-WA@mail.gmail.com>
Message-ID: <CAAOTY_9Y=bcxPWQG7H4Su_X11e3kRx761ZmHTb_wOtb0R71-WA@mail.gmail.com>
Subject: Re: [v7, PATCH 7/7] drm/mediatek: add support for mediatek SOC MT8183
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8825=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:32=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Sat, 2020-07-25 at 07:24 +0800, Chun-Kuang Hu wrote:
> > Hi Yongqiang:
> >
> > Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=
=9C=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:15=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > This patch add support for mediatek SOC MT8183
> > > 1.ovl_2l share driver with ovl
> >
> > I think this is done in [1], [2], [3], this patch just add the support
> > of mt8183-ovl and mt8183-ovl-2l.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/drivers/gpu/drm/mediatek?h=3Dv5.8-rc6&id=3D132c6e250ed745443973cada8=
db17cdbaebdf551
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/drivers/gpu/drm/mediatek?h=3Dv5.8-rc6&id=3D318462d1a568634ba09263cc7=
30cb0fb1d56c2b3
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/drivers/gpu/drm/mediatek?h=3Dv5.8-rc6&id=3D57148baac8b78461e394953cf=
d5317bde8f795ab
> >
> > > 2.rdma1 share drive with rdma0, but fifo size is different
> >
> > I think this is done in [4], this patch just add the support of mt8183-=
rdma.
> >
> > [4] https://patchwork.kernel.org/patch/11679549/
> >
> > > 3.add mt8183 mutex private data, and mmsys private data
> > > 4.add mt8183 main and external path module for crtc create
> >
> > The fourth item is the mmsys private data in third item, so you need
> > not to repeat it.
> >
>
> i will remove some useless description in next version.
> > >
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 18 ++++++++++++
> > >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  6 ++++
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c   | 47 ++++++++++++++++++++++=
++++++++++
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 43 ++++++++++++++++++++++=
+++++++
> > >  4 files changed, 114 insertions(+)
> > >
> >
> > [snip]
> >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm=
/mediatek/mtk_drm_ddp.c
> > > index 014c1bb..60788c1 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > @@ -15,6 +15,8 @@
> > >
> > >  #define MT2701_DISP_MUTEX0_MOD0                        0x2c
> > >  #define MT2701_DISP_MUTEX0_SOF0                        0x30
> > > +#define MT8183_DISP_MUTEX0_MOD0                        0x30
> > > +#define MT8183_DISP_MUTEX0_SOF0                        0x2c
> > >
> > >  #define DISP_REG_MUTEX_EN(n)                   (0x20 + 0x20 * (n))
> > >  #define DISP_REG_MUTEX(n)                      (0x24 + 0x20 * (n))
> > > @@ -25,6 +27,18 @@
> > >
> > >  #define INT_MUTEX                              BIT(1)
> > >
> > > +#define MT8183_MUTEX_MOD_DISP_RDMA0            0
> > > +#define MT8183_MUTEX_MOD_DISP_RDMA1            1
> > > +#define MT8183_MUTEX_MOD_DISP_OVL0             9
> > > +#define MT8183_MUTEX_MOD_DISP_OVL0_2L          10
> > > +#define MT8183_MUTEX_MOD_DISP_OVL1_2L          11
> > > +#define MT8183_MUTEX_MOD_DISP_WDMA0            12
> > > +#define MT8183_MUTEX_MOD_DISP_COLOR0           13
> > > +#define MT8183_MUTEX_MOD_DISP_CCORR0           14
> > > +#define MT8183_MUTEX_MOD_DISP_AAL0             15
> > > +#define MT8183_MUTEX_MOD_DISP_GAMMA0           16
> > > +#define MT8183_MUTEX_MOD_DISP_DITHER0          17
> > > +
> > >  #define MT8173_MUTEX_MOD_DISP_OVL0             11
> > >  #define MT8173_MUTEX_MOD_DISP_OVL1             12
> > >  #define MT8173_MUTEX_MOD_DISP_RDMA0            13
> > > @@ -74,6 +88,10 @@
> > >  #define MUTEX_SOF_DSI2                 5
> > >  #define MUTEX_SOF_DSI3                 6
> > >
> > > +#define MT8183_MUTEX_SOF_DPI0                  2
> > > +#define MT8183_MUTEX_EOF_DSI0                  (MUTEX_SOF_DSI0 << 6)
> > > +#define MT8183_MUTEX_EOF_DPI0                  (MT8183_MUTEX_SOF_DPI=
0 << 6)
> > > +
> > >
> > >  struct mtk_disp_mutex {
> > >         int id;
> > > @@ -153,6 +171,20 @@ struct mtk_ddp {
> > >         [DDP_COMPONENT_WDMA1] =3D MT8173_MUTEX_MOD_DISP_WDMA1,
> > >  };
> > >
> > > +static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] =3D=
 {
> > > +       [DDP_COMPONENT_AAL0] =3D MT8183_MUTEX_MOD_DISP_AAL0,
> > > +       [DDP_COMPONENT_CCORR] =3D MT8183_MUTEX_MOD_DISP_CCORR0,
> > > +       [DDP_COMPONENT_COLOR0] =3D MT8183_MUTEX_MOD_DISP_COLOR0,
> > > +       [DDP_COMPONENT_DITHER] =3D MT8183_MUTEX_MOD_DISP_DITHER0,
> > > +       [DDP_COMPONENT_GAMMA] =3D MT8183_MUTEX_MOD_DISP_GAMMA0,
> > > +       [DDP_COMPONENT_OVL0] =3D MT8183_MUTEX_MOD_DISP_OVL0,
> > > +       [DDP_COMPONENT_OVL_2L0] =3D MT8183_MUTEX_MOD_DISP_OVL0_2L,
> > > +       [DDP_COMPONENT_OVL_2L1] =3D MT8183_MUTEX_MOD_DISP_OVL1_2L,
> > > +       [DDP_COMPONENT_RDMA0] =3D MT8183_MUTEX_MOD_DISP_RDMA0,
> > > +       [DDP_COMPONENT_RDMA1] =3D MT8183_MUTEX_MOD_DISP_RDMA1,
> > > +       [DDP_COMPONENT_WDMA0] =3D MT8183_MUTEX_MOD_DISP_WDMA0,
> > > +};
> > > +
> > >  static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] =
=3D {
> > >         [DDP_MUTEX_SOF_SINGLE_MODE] =3D MUTEX_SOF_SINGLE_MODE,
> > >         [DDP_MUTEX_SOF_DSI0] =3D MUTEX_SOF_DSI0,
> > > @@ -163,6 +195,12 @@ struct mtk_ddp {
> > >         [DDP_MUTEX_SOF_DSI3] =3D MUTEX_SOF_DSI3,
> > >  };
> > >
> > > +static const unsigned int mt8183_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] =
=3D {
> > > +       [DDP_MUTEX_SOF_SINGLE_MODE] =3D MUTEX_SOF_SINGLE_MODE,
> > > +       [DDP_MUTEX_SOF_DSI0] =3D MUTEX_SOF_DSI0 | MT8183_MUTEX_EOF_DS=
I0,
> >
> > I think this array is for 'sof', so you should drop MT8183_MUTEX_EOF_DS=
I0.
> >
> > > +       [DDP_MUTEX_SOF_DPI0] =3D MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX=
_EOF_DPI0,
> >
> > Ditto.
>
> we need set EOF at the same on MT8183, that is different with before SoC
> EOF and SOF are location in the same hardware register.

Even though EOF and SOF are located in the same hardware register, why
should we set EOF?
We just need mutex hardware to send SOF to MODs, we don't need mutex
to send EOF.

> >
> > Regards,
> > Chun-Kuang.
> >
> > > +};
> > > +
> > >  static const struct mtk_ddp_data mt2701_ddp_driver_data =3D {
> > >         .mutex_mod =3D mt2701_mutex_mod,
> > >         .mutex_sof =3D mt2712_mutex_sof,
> > > @@ -184,6 +222,13 @@ struct mtk_ddp {
> > >         .mutex_sof_reg =3D MT2701_DISP_MUTEX0_SOF0,
> > >  };
> > >
>
