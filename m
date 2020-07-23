Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E3C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBE6206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595521289;
	bh=6+0/elepkARkgOsTxARSEPfUsQ0kUT59TejC709DQOk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ppPHuUTAaV8IpfTa+QXLjTVEPKmObgk4Gi2QqCey1+COtO39ViTdt8Nesk3ihZBSd
	 HrKijKSh9QsIGB70wWAI1oSYhLQ45afgCKtTBmMyDWYTSeLy7nkmY3jl++QpHOefHn
	 hKiV85cPyEJcFUpc/JHlUzk4CNMXhQIgp0LowmvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgGWQV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGWQV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:21:27 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E768A22BF5;
        Thu, 23 Jul 2020 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595521286;
        bh=6+0/elepkARkgOsTxARSEPfUsQ0kUT59TejC709DQOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rNWywE0uqiF5fWYLgX1UMCbtbCYBJ1ob7Ojq6jMbqsECPSXnAhOywBkb/WEfBgHBe
         H6fiECXyUWpQuDsiI/Kxs2pWTCu57/keSneVpFJbQ0rCjfW1F7HcLSlR1rIz+j+yVQ
         DKmFF4ESoUQ+eoNmxiZZDozNkHR98UXo5Me86NHA=
Received: by mail-ej1-f47.google.com with SMTP id rk21so7045325ejb.2;
        Thu, 23 Jul 2020 09:21:25 -0700 (PDT)
X-Gm-Message-State: AOAM533YauEKEDQKlC33CPkr96vIn1YGW3X1oMgmkJB0lpP15DziO7BF
        Y3285nn0BvejNyKWi1Y4QjT52RkUBjIzmw5BXA==
X-Google-Smtp-Source: ABdhPJwfk66abeK8oi/cVBHx5H7Gp1l6otQXnpopQ1fbIoD2End7rCWaLJQk2FAbvfBbzOPHRPtXGys6UdSJM+h5hMI=
X-Received: by 2002:a17:906:7857:: with SMTP id p23mr4119216ejm.260.1595521284362;
 Thu, 23 Jul 2020 09:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
 <1595469798-3824-2-git-send-email-yongqiang.niu@mediatek.com>
 <CAFqH_50=MkBLHJ23hJo--RG=4560ttOUOjHuEwpevghFZ59xQQ@mail.gmail.com> <1595498644.13250.2.camel@mhfsdcap03>
In-Reply-To: <1595498644.13250.2.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 24 Jul 2020 00:21:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8SgNcAAch=AQazAG0z2wGte1Wa614bnAgG2eZQxCzL7A@mail.gmail.com>
Message-ID: <CAAOTY_8SgNcAAch=AQazAG0z2wGte1Wa614bnAgG2eZQxCzL7A@mail.gmail.com>
Subject: Re: [v7, PATCH 1/7] drm/mediatek: move ddp component defint into mtk_mmsys.h
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, 2020-07-23 at 11:34 +0200, Enric Balletbo Serra wrote:
> > Hi Yongqian Niu,
> >
> > Thank you for your patch
> >
> > Missatge de Yongqiang Niu <yongqiang.niu@mediatek.com> del dia dj., 23
> > de jul. 2020 a les 4:05:
> > >
> > > move ddp component defint into mtk_mmsys.h
> > >
> >
> > There is a typo, should be "defines". But why you should move these
> > defines to mtk-mmsys?
> >
>
> ck do not like this :
> > -#include "../../gpu/drm/mediatek/mtk_drm_ddp.h"
> > -#include "../../gpu/drm/mediatek/mtk_drm_ddp_comp.h"

I think no one like this.

>
> after remove this, we need move the ddp component define
>
> type error will fixed in next version.
>

mmsys is the driver which control the routing of these ddp component,
so the definition of mtk_ddp_comp_id should be placed in mtk-mmsys.h

Regards,
Chun-Kuang.

>
> >
> >
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 34 +------------------=
----------
> > >  drivers/soc/mediatek/mtk-mmsys.c            |  4 +---
> > >  include/linux/soc/mediatek/mtk-mmsys.h      | 33 +++++++++++++++++++=
+++++++++
> > >  3 files changed, 35 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gp=
u/drm/mediatek/mtk_drm_ddp_comp.h
> > > index debe363..161201f 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > > @@ -7,6 +7,7 @@
> > >  #define MTK_DRM_DDP_COMP_H
> > >
> > >  #include <linux/io.h>
> > > +#include <linux/soc/mediatek/mtk-mmsys.h>
> > >
> > >  struct device;
> > >  struct device_node;
> > > @@ -35,39 +36,6 @@ enum mtk_ddp_comp_type {
> > >         MTK_DDP_COMP_TYPE_MAX,
> > >  };
> > >
> > > -enum mtk_ddp_comp_id {
> > > -       DDP_COMPONENT_AAL0,
> > > -       DDP_COMPONENT_AAL1,
> > > -       DDP_COMPONENT_BLS,
> > > -       DDP_COMPONENT_CCORR,
> > > -       DDP_COMPONENT_COLOR0,
> > > -       DDP_COMPONENT_COLOR1,
> > > -       DDP_COMPONENT_DITHER,
> > > -       DDP_COMPONENT_DPI0,
> > > -       DDP_COMPONENT_DPI1,
> > > -       DDP_COMPONENT_DSI0,
> > > -       DDP_COMPONENT_DSI1,
> > > -       DDP_COMPONENT_DSI2,
> > > -       DDP_COMPONENT_DSI3,
> > > -       DDP_COMPONENT_GAMMA,
> > > -       DDP_COMPONENT_OD0,
> > > -       DDP_COMPONENT_OD1,
> > > -       DDP_COMPONENT_OVL0,
> > > -       DDP_COMPONENT_OVL_2L0,
> > > -       DDP_COMPONENT_OVL_2L1,
> > > -       DDP_COMPONENT_OVL1,
> > > -       DDP_COMPONENT_PWM0,
> > > -       DDP_COMPONENT_PWM1,
> > > -       DDP_COMPONENT_PWM2,
> > > -       DDP_COMPONENT_RDMA0,
> > > -       DDP_COMPONENT_RDMA1,
> > > -       DDP_COMPONENT_RDMA2,
> > > -       DDP_COMPONENT_UFOE,
> > > -       DDP_COMPONENT_WDMA0,
> > > -       DDP_COMPONENT_WDMA1,
> > > -       DDP_COMPONENT_ID_MAX,
> > > -};
> > > -
> > >  struct mtk_ddp_comp;
> > >  struct cmdq_pkt;
> > >  struct mtk_ddp_comp_funcs {
> > > diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/=
mtk-mmsys.c
> > > index a55f255..36ad66b 100644
> > > --- a/drivers/soc/mediatek/mtk-mmsys.c
> > > +++ b/drivers/soc/mediatek/mtk-mmsys.c
> > > @@ -5,13 +5,11 @@
> > >   */
> > >
> > >  #include <linux/device.h>
> > > +#include <linux/io.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/soc/mediatek/mtk-mmsys.h>
> > >
> > > -#include "../../gpu/drm/mediatek/mtk_drm_ddp.h"
> > > -#include "../../gpu/drm/mediatek/mtk_drm_ddp_comp.h"
> > > -
> > >  #define DISP_REG_CONFIG_DISP_OVL0_MOUT_EN      0x040
> > >  #define DISP_REG_CONFIG_DISP_OVL1_MOUT_EN      0x044
> > >  #define DISP_REG_CONFIG_DISP_OD_MOUT_EN                0x048
> > > diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/s=
oc/mediatek/mtk-mmsys.h
> > > index 7bab5d9..2228bf6 100644
> > > --- a/include/linux/soc/mediatek/mtk-mmsys.h
> > > +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> > > @@ -9,6 +9,39 @@
> > >  enum mtk_ddp_comp_id;
> > >  struct device;
> > >
> > > +enum mtk_ddp_comp_id {
> > > +       DDP_COMPONENT_AAL0,
> > > +       DDP_COMPONENT_AAL1,
> > > +       DDP_COMPONENT_BLS,
> > > +       DDP_COMPONENT_CCORR,
> > > +       DDP_COMPONENT_COLOR0,
> > > +       DDP_COMPONENT_COLOR1,
> > > +       DDP_COMPONENT_DITHER,
> > > +       DDP_COMPONENT_DPI0,
> > > +       DDP_COMPONENT_DPI1,
> > > +       DDP_COMPONENT_DSI0,
> > > +       DDP_COMPONENT_DSI1,
> > > +       DDP_COMPONENT_DSI2,
> > > +       DDP_COMPONENT_DSI3,
> > > +       DDP_COMPONENT_GAMMA,
> > > +       DDP_COMPONENT_OD0,
> > > +       DDP_COMPONENT_OD1,
> > > +       DDP_COMPONENT_OVL0,
> > > +       DDP_COMPONENT_OVL_2L0,
> > > +       DDP_COMPONENT_OVL_2L1,
> > > +       DDP_COMPONENT_OVL1,
> > > +       DDP_COMPONENT_PWM0,
> > > +       DDP_COMPONENT_PWM1,
> > > +       DDP_COMPONENT_PWM2,
> > > +       DDP_COMPONENT_RDMA0,
> > > +       DDP_COMPONENT_RDMA1,
> > > +       DDP_COMPONENT_RDMA2,
> > > +       DDP_COMPONENT_UFOE,
> > > +       DDP_COMPONENT_WDMA0,
> > > +       DDP_COMPONENT_WDMA1,
> > > +       DDP_COMPONENT_ID_MAX,
> > > +};
> > > +
> > >  void mtk_mmsys_ddp_connect(struct device *dev,
> > >                            enum mtk_ddp_comp_id cur,
> > >                            enum mtk_ddp_comp_id next);
> > > --
> > > 1.8.1.1.dirty
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
