Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56460C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202D82087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597966294;
	bh=siMyYw8rX8N1Dhqk3gnghjjgdALtTTya5eY3c3s8Zy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A0Q7RuMgJXmj49VZu4HRBg/zem8CQetcHPkAMWGgO6kzmFVXqU1hdITVf5qm/rCQy
	 /v4PZrbfvCqYy2mTL1mNVHpkuB2gadYRfYr0FKwUb7+tAHnjM+Uk4MveJSfqGANgoO
	 4IFPpZCPriGhiPAaUXTWv4UWEgzlVxb5oEbfiRdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgHTXbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbgHTXba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:31:30 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9CC2072D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597966289;
        bh=siMyYw8rX8N1Dhqk3gnghjjgdALtTTya5eY3c3s8Zy0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JcuNwaBRAoqhrx2qo4spB8Kq/A7SLb7/2Wr64flZdSgIGbowfiryUT+VqxB15nuI4
         bbA4A4xW38bZCIajmyWfgn53y4+OuhJW6TDn9gRG2vSA2MImH0UkMum0thETf+86Lx
         G0YBA73OSCaklrcrDtUS0s447aHeP17DBupLHQ+w=
Received: by mail-ed1-f42.google.com with SMTP id w2so2714588edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:31:28 -0700 (PDT)
X-Gm-Message-State: AOAM530pCOFLEJoFRUqC19RlrBFKtZ8ROZU4CHqTbEa1BXI1+ft2WKN0
        x/khC5TcRhJhYVS8iVRhcEAGG8gFFt8DC0B4qQ==
X-Google-Smtp-Source: ABdhPJxHhOTvvDw994kMrLUKQlvnI8puRCe+1TL8jGYVtqHWewKlN2sgdfCX6J2E7VXx0eWM8FVrOr2ur+JfL2a5StE=
X-Received: by 2002:a50:e109:: with SMTP id h9mr259119edl.47.1597966287544;
 Thu, 20 Aug 2020 16:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200819154421.7013-1-chunkuang.hu@kernel.org>
 <20200819154421.7013-4-chunkuang.hu@kernel.org> <20200819160434.GA2655@ravnborg.org>
In-Reply-To: <20200819160434.GA2655@ravnborg.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:31:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-BUecBKf=ZbNns2Mh=gbtRkJgH2_6wbQVpJNvt4vs8Pw@mail.gmail.com>
Message-ID: <CAAOTY_-BUecBKf=ZbNns2Mh=gbtRkJgH2_6wbQVpJNvt4vs8Pw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] phy: mediatek: Move mtk_hdmi_phy driver into
 drivers/phy/mediatek folder
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sam:

Sam Ravnborg <sam@ravnborg.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8820=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang
>
> Two small details below.
>
>         Sam
>
> On Wed, Aug 19, 2020 at 11:44:20PM +0800, Chun-Kuang Hu wrote:
> > From: CK Hu <ck.hu@mediatek.com>
> >
> > mtk_hdmi_phy is currently placed inside mediatek drm driver, but it's
> > more suitable to place a phy driver into phy driver folder, so move
> > mtk_hdmi_phy driver into phy driver folder.
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> >  drivers/gpu/drm/mediatek/Kconfig                           | 7 -------
> >  drivers/gpu/drm/mediatek/Makefile                          | 6 ------
> >  drivers/phy/mediatek/Kconfig                               | 7 +++++++
> >  drivers/phy/mediatek/Makefile                              | 6 ++++++
> >  .../mediatek/phy-mtk-hdmi-mt2701.c}                        | 2 +-
> >  .../mediatek/phy-mtk-hdmi-mt8173.c}                        | 2 +-
> >  .../mtk_hdmi_phy.c =3D> phy/mediatek/phy-mtk-hdmi.c}         | 2 +-
> >  .../mtk_hdmi_phy.h =3D> phy/mediatek/phy-mtk-hdmi.h}         | 0
> >  8 files changed, 16 insertions(+), 16 deletions(-)
> >  rename drivers/{gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c =3D> phy/mediat=
ek/phy-mtk-hdmi-mt2701.c} (99%)
> >  rename drivers/{gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c =3D> phy/mediat=
ek/phy-mtk-hdmi-mt8173.c} (99%)
> >  rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.c =3D> phy/mediatek/phy-=
mtk-hdmi.c} (99%)
> >  rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.h =3D> phy/mediatek/phy-=
mtk-hdmi.h} (100%)
> >
> > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediate=
k/Kconfig
> > index ca3cd871a350..65cd03a4be29 100644
> > --- a/drivers/gpu/drm/mediatek/Kconfig
> > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > @@ -27,10 +27,3 @@ config DRM_MEDIATEK_HDMI
> >       select PHY_MTK_HDMI
> >       help
> >         DRM/KMS HDMI driver for Mediatek SoCs
> > -
> > -config PHY_MTK_HDMI
> > -    tristate "MediaTek HDMI-PHY Driver"
> > -    depends on ARCH_MEDIATEK && OF
> > -    select GENERIC_PHY
> > -    help
> > -          Enable this to support HDMI-PHY
> > diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediat=
ek/Makefile
> > index fcbef23aa6ce..77b0fd86063d 100644
> > --- a/drivers/gpu/drm/mediatek/Makefile
> > +++ b/drivers/gpu/drm/mediatek/Makefile
> > @@ -22,9 +22,3 @@ mediatek-drm-hdmi-objs :=3D mtk_cec.o \
> >                         mtk_hdmi_ddc.o
> >
> >  obj-$(CONFIG_DRM_MEDIATEK_HDMI) +=3D mediatek-drm-hdmi.o
> > -
> > -phy-mtk-hdmi-drv-objs :=3D mtk_hdmi_phy.o \
> > -                      mtk_mt2701_hdmi_phy.o \
> > -                      mtk_mt8173_hdmi_phy.o
> > -
> > -obj-$(CONFIG_PHY_MTK_HDMI) +=3D phy-mtk-hdmi-drv.o
> > diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfi=
g
> > index dee757c957f2..10f0ec2d5b54 100644
> > --- a/drivers/phy/mediatek/Kconfig
> > +++ b/drivers/phy/mediatek/Kconfig
> > @@ -35,3 +35,10 @@ config PHY_MTK_XSPHY
> >         Enable this to support the SuperSpeedPlus XS-PHY transceiver fo=
r
> >         USB3.1 GEN2 controllers on MediaTek chips. The driver supports
> >         multiple USB2.0, USB3.1 GEN2 ports.
> > +
> > +config PHY_MTK_HDMI
> > +    tristate "MediaTek HDMI-PHY Driver"
> > +    depends on ARCH_MEDIATEK && OF
> > +    select GENERIC_PHY
> > +    help
> > +          Enable this to support HDMI-PHY
> This helptext could use a bit more love and care - it is not obvious
> from the help text what this option does.
>

OK, would add more detail information.

>
> > diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makef=
ile
> > index 08a8e6a97b1e..c9a3641f0b16 100644
> > --- a/drivers/phy/mediatek/Makefile
> > +++ b/drivers/phy/mediatek/Makefile
> > @@ -6,3 +6,9 @@
> >  obj-$(CONFIG_PHY_MTK_TPHY)           +=3D phy-mtk-tphy.o
> >  obj-$(CONFIG_PHY_MTK_UFS)            +=3D phy-mtk-ufs.o
> >  obj-$(CONFIG_PHY_MTK_XSPHY)          +=3D phy-mtk-xsphy.o
> > +
> > +phy-mtk-hdmi-drv-objs :=3D phy-mtk-hdmi.o \
> > +                      phy-mtk-hdmi-mt2701.o \
> > +                      phy-mtk-hdmi-mt8173.o
> > +
> The modern syntax is to use -y and not -objs.
> And getting rid of '\' would also be nice.
> So something like this:
>
> phy-mtk-hdmi-drv-y :=3D phy-mtk-hdmi.o
> phy-mtk-hdmi-drv-y +=3D phy-mtk-hdmi-mt2701.o
> phy-mtk-hdmi-drv-y +=3D phy-mtk-hdmi-mt8173.o
>
> Looks much more readable to me.
>

OK,

Regards,
Chun-Kuang.

> > +obj-$(CONFIG_PHY_MTK_HDMI) +=3D phy-mtk-hdmi-drv.o
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/p=
hy/mediatek/phy-mtk-hdmi-mt2701.c
> > similarity index 99%
> > rename from drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > rename to drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > index 99fe05cd3598..a6cb1dea3d0c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > @@ -4,7 +4,7 @@
> >   * Author: Chunhui Dai <chunhui.dai@mediatek.com>
> >   */
> >
> > -#include "mtk_hdmi_phy.h"
> > +#include "phy-mtk-hdmi.h"
> >
> >  #define HDMI_CON0    0x00
> >  #define RG_HDMITX_DRV_IBIAS          0
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/p=
hy/mediatek/phy-mtk-hdmi-mt8173.c
> > similarity index 99%
> > rename from drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > rename to drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> > index 827b93786fac..6cdfdf5a698a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> > @@ -4,7 +4,7 @@
> >   * Author: Jie Qiu <jie.qiu@mediatek.com>
> >   */
> >
> > -#include "mtk_hdmi_phy.h"
> > +#include "phy-mtk-hdmi.h"
> >
> >  #define HDMI_CON0            0x00
> >  #define RG_HDMITX_PLL_EN             BIT(31)
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/phy/medi=
atek/phy-mtk-hdmi.c
> > similarity index 99%
> > rename from drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > rename to drivers/phy/mediatek/phy-mtk-hdmi.c
> > index fe022acddbef..8fc83f01a720 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> > @@ -4,7 +4,7 @@
> >   * Author: Jie Qiu <jie.qiu@mediatek.com>
> >   */
> >
> > -#include "mtk_hdmi_phy.h"
> > +#include "phy-mtk-hdmi.h"
> >
> >  static int mtk_hdmi_phy_power_on(struct phy *phy);
> >  static int mtk_hdmi_phy_power_off(struct phy *phy);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/phy/medi=
atek/phy-mtk-hdmi.h
> > similarity index 100%
> > rename from drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > rename to drivers/phy/mediatek/phy-mtk-hdmi.h
> > --
> > 2.17.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
