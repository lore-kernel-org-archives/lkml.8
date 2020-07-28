Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6846DC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD7920775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWtVLdfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgG1KZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgG1KZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:25:21 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32BC061794;
        Tue, 28 Jul 2020 03:25:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k22so17030573oib.0;
        Tue, 28 Jul 2020 03:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9eDEWn1oEoc77W2XMgWcgmmSn3pQA5mrUEY8YypgbM=;
        b=lWtVLdfRXKLA0oafpiA7O2552zaBd438hBmjbAkSLj2O9mYcpWWFoSJEsXmZqn6Tvk
         pNQ2x8Gr6+QPnxUd7JYB6ZFYmXjDQ6U/PKiGujZ43GO06+F8+wz2HSehaqn9VnSwdNdz
         B0nkkdpOTNaYWpfTuRyC0J6rVUscABWPvy1FXcOcTPdo6xIMpVuWK6PYhBb0hsnCz93v
         HQiEjjPFf0LDn4rvdSwrf4zpDq/ofqsh8FUWb/4msViF1TXcdKsKpus68w2RXEp33+K/
         eLn4rjz48ppidlmY11a4xuD4kKzJwI4Jn52t7Glw0Mfu/hjOnvap9T2HKRn9Urcf/zqt
         ikDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9eDEWn1oEoc77W2XMgWcgmmSn3pQA5mrUEY8YypgbM=;
        b=X6ZznwkT1j+NQKYOTM4q5m7bfB3qdHPFRz2cNt1TfgWFerCbFFLexeOQ7Rmm5QDD6F
         ZTbFlgx01j+TbLq9mfhz3yjojF3rvDVnwfsZtVz/avKGFXsS1Ix8GT+ZtRzl+lAiFiCO
         icOCTjUcFse946HXrO4Tb5pv66OHIhMEZ8zsYZRiLlqZXkMLKTcyTswR7/p9gdnwS5F1
         E8mj0k5clzsKQz/g1sbnwNfu3ZZrQxi6KBA44c8Kacm5P40IMa/X7lIa55pXFkFT6wrA
         O76IBExXzsZkpurIZ+RHy5wVSsfwLLS/bmzeeq7aSM1AyLVJTwOJURv5FlLnmdZ6fDvs
         ZJdQ==
X-Gm-Message-State: AOAM533yPjXbKHvZ7HTTDc/Cys0RLrJNazh7pBeum8QxO/VR5aPmOk8a
        inhN74x2up5M7FMUWI/OiiFPmhQsuFoTsE32BNg=
X-Google-Smtp-Source: ABdhPJzQ5HZKTcRLoUciu8PdxQvObJp/E6hTnZ1nO7O2D46wmPBVRBbL0JFWuUmbkGTLGTYHLQPqQtDuyN6QViIforY=
X-Received: by 2002:aca:5296:: with SMTP id g144mr2841338oib.129.1595931920837;
 Tue, 28 Jul 2020 03:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
 <1595469798-3824-3-git-send-email-yongqiang.niu@mediatek.com>
 <CAFqH_51sKR-tUHhdJs4N5KaGq-4+oFsAOhZsJqpFk0ikZjJ=mg@mail.gmail.com> <1595647675.13250.18.camel@mhfsdcap03>
In-Reply-To: <1595647675.13250.18.camel@mhfsdcap03>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 28 Jul 2020 12:25:09 +0200
Message-ID: <CAFqH_52KOJx-80z4Jx2f_Hp9UVH3zrtk5VaJD1nE8OUY-St4YA@mail.gmail.com>
Subject: Re: [v7, PATCH 2/7] mtk-mmsys: add mmsys private data
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongqiang,

Missatge de Yongqiang Niu <yongqiang.niu@mediatek.com> del dia ds., 25
de jul. 2020 a les 5:29:
>
> On Thu, 2020-07-23 at 11:32 +0200, Enric Balletbo Serra wrote:
> > Hi Yongqiang Niu,
> >
> > Thank you for your patch.
> >
> > Missatge de Yongqiang Niu <yongqiang.niu@mediatek.com> del dia dj., 23
> > de jul. 2020 a les 4:05:
> > >
> > > add mmsys private data
> > >
> >
> > I think this change requires a better explanation of what you are
> > doing. Although I'm really uncomfortable with this change, why you
> > need to create a new mt2701-mmsys file?
>
> reason:
> 1.there will more and more Mediatek Soc upstream, and the display path
> connection function mtk_mmsys_ddp_mout_en, mtk_mmsys_ddp_sel_in and
> mtk_mmsys_ddp_sout_sel will complicated more and more,
> 2. many of the connection are only used in some SoC, and useless for
> other SoC and not readable,
> 3. if we add a new SoC connection, we need check is this affect other
> Soc,
> >
> > > Feature: drm/mediatek
> >
> > Remove this.
> next version will remove this
> >
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/Makefile             |   1 +
> > >  drivers/soc/mediatek/mmsys/Makefile       |   2 +
> > >  drivers/soc/mediatek/mmsys/mt2701-mmsys.c | 250 +++++++++++++++++++++++++++
> > >  drivers/soc/mediatek/mtk-mmsys.c          | 271 +++++-------------------------
> > >  include/linux/soc/mediatek/mtk-mmsys.h    |  15 ++
> > >  5 files changed, 314 insertions(+), 225 deletions(-)
> > >  create mode 100644 drivers/soc/mediatek/mmsys/Makefile
> > >  create mode 100644 drivers/soc/mediatek/mmsys/mt2701-mmsys.c
> > >
> > > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > > index 2afa7b9..b37ac2c 100644
> > > --- a/drivers/soc/mediatek/Makefile
> > > +++ b/drivers/soc/mediatek/Makefile
> > > @@ -3,3 +3,4 @@ obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> > >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> > >  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > >  obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
> > > +obj-$(CONFIG_MTK_MMSYS) += mmsys/
> > > diff --git a/drivers/soc/mediatek/mmsys/Makefile b/drivers/soc/mediatek/mmsys/Makefile
> > > new file mode 100644
> > > index 0000000..33b0dab
> > > --- /dev/null
> > > +++ b/drivers/soc/mediatek/mmsys/Makefile
> > > @@ -0,0 +1,2 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +obj-y += mt2701-mmsys.o
> > > diff --git a/drivers/soc/mediatek/mmsys/mt2701-mmsys.c b/drivers/soc/mediatek/mmsys/mt2701-mmsys.c
> > > new file mode 100644
> > > index 0000000..b8e53b0
> > > --- /dev/null
> > > +++ b/drivers/soc/mediatek/mmsys/mt2701-mmsys.c
> > > @@ -0,0 +1,250 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +//
> > > +// Copyright (c) 2020 MediaTek Inc.
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/io.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/soc/mediatek/mtk-mmsys.h>
> > > +
> > > +#define DISP_REG_CONFIG_DISP_OVL0_MOUT_EN      0x040
> > > +#define DISP_REG_CONFIG_DISP_OVL1_MOUT_EN      0x044
> > > +#define DISP_REG_CONFIG_DISP_OD_MOUT_EN                0x048
> > > +#define DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN     0x04c
> > > +#define DISP_REG_CONFIG_DISP_UFOE_MOUT_EN      0x050
> > > +#define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN     0x084
> > > +#define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN     0x088
> > > +#define DISP_REG_CONFIG_DSIE_SEL_IN            0x0a4
> > > +#define DISP_REG_CONFIG_DSIO_SEL_IN            0x0a8
> > > +#define DISP_REG_CONFIG_DPI_SEL_IN             0x0ac
> > > +#define DISP_REG_CONFIG_DISP_RDMA2_SOUT                0x0b8
> > > +#define DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN     0x0c4
> > > +#define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN     0x0c8
> > > +#define DISP_REG_CONFIG_MMSYS_CG_CON0          0x100
> > > +
> > > +#define DISP_REG_CONFIG_DISP_OVL_MOUT_EN       0x030
> > > +#define DISP_REG_CONFIG_OUT_SEL                        0x04c
> > > +#define DISP_REG_CONFIG_DSI_SEL                        0x050
> > > +#define DISP_REG_CONFIG_DPI_SEL                        0x064
> > > +
> > > +#define OVL0_MOUT_EN_COLOR0                    0x1
> > > +#define OD_MOUT_EN_RDMA0                       0x1
> > > +#define OD1_MOUT_EN_RDMA1                      BIT(16)
> > > +#define UFOE_MOUT_EN_DSI0                      0x1
> > > +#define COLOR0_SEL_IN_OVL0                     0x1
> > > +#define OVL1_MOUT_EN_COLOR1                    0x1
> > > +#define GAMMA_MOUT_EN_RDMA1                    0x1
> > > +#define RDMA0_SOUT_DPI0                                0x2
> > > +#define RDMA0_SOUT_DPI1                                0x3
> > > +#define RDMA0_SOUT_DSI1                                0x1
> > > +#define RDMA0_SOUT_DSI2                                0x4
> > > +#define RDMA0_SOUT_DSI3                                0x5
> > > +#define RDMA1_SOUT_DPI0                                0x2
> > > +#define RDMA1_SOUT_DPI1                                0x3
> > > +#define RDMA1_SOUT_DSI1                                0x1
> > > +#define RDMA1_SOUT_DSI2                                0x4
> > > +#define RDMA1_SOUT_DSI3                                0x5
> > > +#define RDMA2_SOUT_DPI0                                0x2
> > > +#define RDMA2_SOUT_DPI1                                0x3
> > > +#define RDMA2_SOUT_DSI1                                0x1
> > > +#define RDMA2_SOUT_DSI2                                0x4
> > > +#define RDMA2_SOUT_DSI3                                0x5
> > > +#define DPI0_SEL_IN_RDMA1                      0x1
> > > +#define DPI0_SEL_IN_RDMA2                      0x3
> > > +#define DPI1_SEL_IN_RDMA1                      (0x1 << 8)
> > > +#define DPI1_SEL_IN_RDMA2                      (0x3 << 8)
> > > +#define DSI0_SEL_IN_RDMA1                      0x1
> > > +#define DSI0_SEL_IN_RDMA2                      0x4
> > > +#define DSI1_SEL_IN_RDMA1                      0x1
> > > +#define DSI1_SEL_IN_RDMA2                      0x4
> > > +#define DSI2_SEL_IN_RDMA1                      (0x1 << 16)
> > > +#define DSI2_SEL_IN_RDMA2                      (0x4 << 16)
> > > +#define DSI3_SEL_IN_RDMA1                      (0x1 << 16)
> > > +#define DSI3_SEL_IN_RDMA2                      (0x4 << 16)
> > > +#define COLOR1_SEL_IN_OVL1                     0x1
> > > +
> > > +#define OVL_MOUT_EN_RDMA                       0x1
> > > +#define BLS_TO_DSI_RDMA1_TO_DPI1               0x8
> > > +#define BLS_TO_DPI_RDMA1_TO_DSI                        0x2
> > > +#define DSI_SEL_IN_BLS                         0x0
> > > +#define DPI_SEL_IN_BLS                         0x0
> > > +#define DSI_SEL_IN_RDMA                                0x1
> > > +
> > > +static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
> > > +                                         enum mtk_ddp_comp_id next,
> > > +                                         unsigned int *addr)
> > > +{
> >
> > Can't be reused this function for all devices? You did in the previous
> > series, why not now?
>
> can not reused, that why need add mmsys private data like before
> version.

You did in the previous series, would that mean that your previous
series were wrong or nonworking or break on some SoCs?

I agree that you need per SoC data, what I am complaining is the idea
of having pointers to functions instead of just having the registers
or the media paths per SoC. You can have private data for registers,
something like this:

static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
        .clk_driver = "clk-mt8183-mm",
        .regs = {
                .ovl0_mout_en = MT8183_DISP_OVL0_MOUT_EN,
                .rdma0_sout_sel_in = MT8183_DISP_RDMA0_SOUT_SEL_IN,
                .rdma0_sout_color0 = MT8183_RDMA0_SOUT_COLOR0,
                .rdma1_sout_sel_in = MT8183_DISP_RDMA1_SOUT_SEL_IN,
                .rdma1_sout_dsi0 = MT8183_RDMA1_SOUT_DSI0,
                .dpi0_sel_in = MT8183_DISP_DPI0_SEL_IN,
                .dpi0_sel_in_rdma1 = MT8183_DPI0_SEL_IN_RDMA1,
                .dsi0_sel_in = MT8183_DISP_DSI0_SEL_IN,
                .dsi0_sel_in_rdma1 = MT8183_DSI0_SEL_IN_RDMA1,
        },
};

And you can also have the media configuration paths in the driver
data, similar to what you did for mt8183 but not for the others. But,
I'd recommend to do this in a second step, and go step-by-step. Your
v6 and v7 are quite different, but IMHO I'm more in favor of what you
did for v6 (as a first step to support mt8183) than this patchset. For
v7 I was expecting just to move the bits that needed to mtk-mmsys, not
such rework. Said all that, I'm not the maintainer and is up to the
maintainer to decide the direction that driver should take.

> but that still not a good idea.
>
> the next path like this will be more readable, and more easy to maintain
> https://patchwork.kernel.org/patch/11679539/

Ack, that's more readable and probably should be the direction to go,
always assuming we have the *data* (mmsys_path_sel, etc.) per SoC and
the functions  mtk_mmsys_ddp_mout_en(),  mtk_mmsys_ddp_sel_in(),
mtk_mmsys_ddp_sout_sel() common for all SoCs.

Thanks,
 Enric

[snip]
