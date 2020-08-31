Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B3C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D23120767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598889720;
	bh=iUR8IYgzp/6akmwOXmAd+HX6cW9xEtvKjxHO8rwb4gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EDzsrDqEDykZAEEo0XNymZhe+yB4yvyfswxwk0l4t0HUrmxYOl2zmUnBA0S41Qf00
	 /XyIvEyISL/IElsHsb7Rlo/A50atg/f621vjSZPh8XMidtD1GkICAsWosVMVaQfNxP
	 DWPG1BCyJcuCdOqJAyRTGJg2QylkVFtLUPbcZZTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHaQB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHaQB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:01:58 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA2C2145D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598889717;
        bh=iUR8IYgzp/6akmwOXmAd+HX6cW9xEtvKjxHO8rwb4gg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QgTQxhab31aK5spObMDeQRm0++fmXdWGSLBqGPRYsrl+A44Hs5RUzVJdKGzyoJpIC
         +L5oN2QF/CQ1HC6ogvMfm6hRkVp1bNWGc+1tAoycznjR2HPx+cXyZ0tZiRdzQ6Q5i6
         JC8F3z511YS4tU5GwhJIASJJl7DI5dFEGecS8uoc=
Received: by mail-ej1-f54.google.com with SMTP id i26so8868755ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:01:57 -0700 (PDT)
X-Gm-Message-State: AOAM531SuMzx+9wStZIr/71nO8aM62TV/tR4umFQdgPC569xHB+CgFkH
        mSGdi6sSS9KVN66cf0MLO+4UE4mbe8CeLmeKVQ==
X-Google-Smtp-Source: ABdhPJzJNO5A2mjJEp7v7G3h9ZfxVuiBb0Bqcn+T3k8lEdhP6GrZzueU5tpm/gV8/nLYYaAth6caXxEIfGgQ0YrhwOE=
X-Received: by 2002:a17:906:a141:: with SMTP id bu1mr1690401ejb.303.1598889715909;
 Mon, 31 Aug 2020 09:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200823014830.15962-1-chunkuang.hu@kernel.org>
 <20200823014830.15962-4-chunkuang.hu@kernel.org> <CAAOTY__mJ=+Mg7PikH+bZ9kPxO8yiURhJSt0Ms_Z9=YGuBwCRg@mail.gmail.com>
 <1598838410.7054.7.camel@mhfsdcap03>
In-Reply-To: <1598838410.7054.7.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 1 Sep 2020 00:01:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY__+oAynmN6--z4j8vYNRdGVXE+Do=YBkW7CtSROBBwU7Q@mail.gmail.com>
Message-ID: <CAAOTY__+oAynmN6--z4j8vYNRdGVXE+Do=YBkW7CtSROBBwU7Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] phy: mediatek: Move mtk_hdmi_phy driver into
 drivers/phy/mediatek folder
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chunfeng:

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=883=
1=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=889:48=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Mon, 2020-08-31 at 07:03 +0800, Chun-Kuang Hu wrote:
> > Hi, Chunfeng & Kishon:
> >
> > How do you feel about this patch?
> It's fine to me,
>
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>

Could you give an 'Acked-by' tag on this patch? So I could apply the
whole series into my tree.

Regards,
Chun-Kuang.

> Thanks a lot
>
> >
> > Regards,
> > Chun-Kuang.
> >
> > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=889:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > From: CK Hu <ck.hu@mediatek.com>
> > >
> > > mtk_hdmi_phy is currently placed inside mediatek drm driver, but it's
> > > more suitable to place a phy driver into phy driver folder, so move
> > > mtk_hdmi_phy driver into phy driver folder.
> > >
> > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > ---
> > >  drivers/gpu/drm/mediatek/Kconfig                           | 7 -----=
--
> > >  drivers/gpu/drm/mediatek/Makefile                          | 6 -----=
-
> > >  drivers/phy/mediatek/Kconfig                               | 7 +++++=
++
> > >  drivers/phy/mediatek/Makefile                              | 5 +++++
> > >  .../mediatek/phy-mtk-hdmi-mt2701.c}                        | 2 +-
> > >  .../mediatek/phy-mtk-hdmi-mt8173.c}                        | 2 +-
> > >  .../mtk_hdmi_phy.c =3D> phy/mediatek/phy-mtk-hdmi.c}         | 2 +-
> > >  .../mtk_hdmi_phy.h =3D> phy/mediatek/phy-mtk-hdmi.h}         | 0
> > >  8 files changed, 15 insertions(+), 16 deletions(-)
> > >  rename drivers/{gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c =3D> phy/medi=
atek/phy-mtk-hdmi-mt2701.c} (99%)
> > >  rename drivers/{gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c =3D> phy/medi=
atek/phy-mtk-hdmi-mt8173.c} (99%)
> > >  rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.c =3D> phy/mediatek/ph=
y-mtk-hdmi.c} (99%)
> > >  rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.h =3D> phy/mediatek/ph=
y-mtk-hdmi.h} (100%)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/media=
tek/Kconfig
> > > index 6363f2c1cdbc..65cd03a4be29 100644
> > > --- a/drivers/gpu/drm/mediatek/Kconfig
> > > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > > @@ -27,10 +27,3 @@ config DRM_MEDIATEK_HDMI
> > >         select PHY_MTK_HDMI
> > >         help
> > >           DRM/KMS HDMI driver for Mediatek SoCs
> > > -
> > > -config PHY_MTK_HDMI
> > > -       tristate "MediaTek HDMI-PHY Driver"
> > > -       depends on ARCH_MEDIATEK && OF
> > > -       select GENERIC_PHY
> > > -       help
> > > -         Support HDMI PHY for Mediatek SoCs.
> > > diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/medi=
atek/Makefile
> > > index fcbef23aa6ce..77b0fd86063d 100644
> > > --- a/drivers/gpu/drm/mediatek/Makefile
> > > +++ b/drivers/gpu/drm/mediatek/Makefile
> > > @@ -22,9 +22,3 @@ mediatek-drm-hdmi-objs :=3D mtk_cec.o \
> > >                           mtk_hdmi_ddc.o
> > >
> > >  obj-$(CONFIG_DRM_MEDIATEK_HDMI) +=3D mediatek-drm-hdmi.o
> > > -
> > > -phy-mtk-hdmi-drv-objs :=3D mtk_hdmi_phy.o \
> > > -                        mtk_mt2701_hdmi_phy.o \
> > > -                        mtk_mt8173_hdmi_phy.o
> > > -
> > > -obj-$(CONFIG_PHY_MTK_HDMI) +=3D phy-mtk-hdmi-drv.o
> > > diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kcon=
fig
> > > index dee757c957f2..50c5e9306e19 100644
> > > --- a/drivers/phy/mediatek/Kconfig
> > > +++ b/drivers/phy/mediatek/Kconfig
> > > @@ -35,3 +35,10 @@ config PHY_MTK_XSPHY
> > >           Enable this to support the SuperSpeedPlus XS-PHY transceive=
r for
> > >           USB3.1 GEN2 controllers on MediaTek chips. The driver suppo=
rts
> > >           multiple USB2.0, USB3.1 GEN2 ports.
> > > +
> > > +config PHY_MTK_HDMI
> > > +       tristate "MediaTek HDMI-PHY Driver"
> > > +       depends on ARCH_MEDIATEK && OF
> > > +       select GENERIC_PHY
> > > +       help
> > > +         Support HDMI PHY for Mediatek SoCs.
> > > diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Mak=
efile
> > > index 08a8e6a97b1e..6325e38709ed 100644
> > > --- a/drivers/phy/mediatek/Makefile
> > > +++ b/drivers/phy/mediatek/Makefile
> > > @@ -6,3 +6,8 @@
> > >  obj-$(CONFIG_PHY_MTK_TPHY)             +=3D phy-mtk-tphy.o
> > >  obj-$(CONFIG_PHY_MTK_UFS)              +=3D phy-mtk-ufs.o
> > >  obj-$(CONFIG_PHY_MTK_XSPHY)            +=3D phy-mtk-xsphy.o
> > > +
> > > +phy-mtk-hdmi-drv-y                     :=3D phy-mtk-hdmi.o
> > > +phy-mtk-hdmi-drv-y                     +=3D phy-mtk-hdmi-mt2701.o
> > > +phy-mtk-hdmi-drv-y                     +=3D phy-mtk-hdmi-mt8173.o
> > > +obj-$(CONFIG_PHY_MTK_HDMI)             +=3D phy-mtk-hdmi-drv.o
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers=
/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > > similarity index 99%
> > > rename from drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > > rename to drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > > index 99fe05cd3598..a6cb1dea3d0c 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > > +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > > @@ -4,7 +4,7 @@
> > >   * Author: Chunhui Dai <chunhui.dai@mediatek.com>
> > >   */
> > >
> > > -#include "mtk_hdmi_phy.h"
> > > +#include "phy-mtk-hdmi.h"
> > >
> > >  #define HDMI_CON0      0x00
> > >  #define RG_HDMITX_DRV_IBIAS            0
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers=
/phy/mediatek/phy-mtk-hdmi-mt8173.c
> > > similarity index 99%
> > > rename from drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > > rename to drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> > > index 827b93786fac..6cdfdf5a698a 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > > +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> > > @@ -4,7 +4,7 @@
> > >   * Author: Jie Qiu <jie.qiu@mediatek.com>
> > >   */
> > >
> > > -#include "mtk_hdmi_phy.h"
> > > +#include "phy-mtk-hdmi.h"
> > >
> > >  #define HDMI_CON0              0x00
> > >  #define RG_HDMITX_PLL_EN               BIT(31)
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/phy/me=
diatek/phy-mtk-hdmi.c
> > > similarity index 99%
> > > rename from drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > > rename to drivers/phy/mediatek/phy-mtk-hdmi.c
> > > index fe022acddbef..8fc83f01a720 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > > +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> > > @@ -4,7 +4,7 @@
> > >   * Author: Jie Qiu <jie.qiu@mediatek.com>
> > >   */
> > >
> > > -#include "mtk_hdmi_phy.h"
> > > +#include "phy-mtk-hdmi.h"
> > >
> > >  static int mtk_hdmi_phy_power_on(struct phy *phy);
> > >  static int mtk_hdmi_phy_power_off(struct phy *phy);
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/phy/me=
diatek/phy-mtk-hdmi.h
> > > similarity index 100%
> > > rename from drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > > rename to drivers/phy/mediatek/phy-mtk-hdmi.h
> > > --
> > > 2.17.1
> > >
>
