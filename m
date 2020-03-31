Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C4CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48464206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585659675;
	bh=Nfl47u1xeUXnlgIrfnkPwm3bagj8NSOXldMy+Hhzr9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QUizpBzEIqMb3eZIwMXZHFQP2As6L7ikq+T2WsUZschq9Nvx39ShDK1CvmdMHK80p
	 Pafruw9nvAdXH3kbELzVsDOm6Os5/+EB2Ngynxk+z1qWRUKst54/6FG+6dhmX2ERn4
	 Xm75MQKjFZy0Qd4blyOuJMpq40URuFxMpbpfEnOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgCaNBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbgCaNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:01:14 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C18C2078B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585659672;
        bh=Nfl47u1xeUXnlgIrfnkPwm3bagj8NSOXldMy+Hhzr9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X0AIOsd7Ku5rH7Viok3BWEgppCqjy1GotNuHRAwUI1Dyv5ZVPM1j7dYTppECIsjY6
         ZXRwvnwzU93+AM630g/qZBS29+wf+LnELs7b4/3FrcKOe4q5Xrm5NZ+ahlY3KebpUJ
         LvZWi8+bLVz7KISdL9DP3IZtGV8TAjLIvEWN/w7s=
Received: by mail-ed1-f47.google.com with SMTP id cf14so24975057edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 06:01:12 -0700 (PDT)
X-Gm-Message-State: ANhLgQ11hjTpxMcWRtowfXdHJwdI66QZ5vcO1G1KXggCEhydEjbjUjx/
        UshyKuq794ussFnvHM6HW5ijSZfodj26fb+MXQ==
X-Google-Smtp-Source: ADFU+vtG0HzoHGEJZdc4SeIl3MerLvRzg5Qp69UHJ0ZuDqDUN2AbQDJIziXDYXzOE0H28L1yL+HwWbiBMAHeVls5qjQ=
X-Received: by 2002:a17:906:4bc3:: with SMTP id x3mr3719882ejv.38.1585659670641;
 Tue, 31 Mar 2020 06:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200330141222.17529-1-chunkuang.hu@kernel.org>
 <20200330141222.17529-4-chunkuang.hu@kernel.org> <b1c22917-76b4-2de9-3f0a-0d7736dae94f@baylibre.com>
In-Reply-To: <b1c22917-76b4-2de9-3f0a-0d7736dae94f@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 31 Mar 2020 21:00:59 +0800
X-Gmail-Original-Message-ID: <CAAOTY_88=yo1P9F-hEbpsOjqPpRCLnE71fT+Jgts8ifxaH1xGw@mail.gmail.com>
Message-ID: <CAAOTY_88=yo1P9F-hEbpsOjqPpRCLnE71fT+Jgts8ifxaH1xGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/mediatek: Move mtk_hdmi_phy driver into
 drivers/phy/mediatek folder
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neil:

Neil Armstrong <narmstrong@baylibre.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=883=
1=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:05=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> On 30/03/2020 16:12, Chun-Kuang Hu wrote:
> > From: CK Hu <ck.hu@mediatek.com>
> >
> > mtk_hdmi_phy is currently placed inside mediatek drm driver, but it's
> > more suitable to place a phy driver into phy driver folder, so move
> > mtk_hdmi_phy driver into phy driver folder.
>
> Pretty sure the subject should start with "phy: " and have an ack from Ki=
shon.

I would modify the subject in next version and wait for Kishon's ack.

Regards,
Chun-Kuang.

>
> Neil
>
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >  drivers/gpu/drm/mediatek/Kconfig                           | 7 -------
> >  drivers/gpu/drm/mediatek/Makefile                          | 6 ------
> >  drivers/phy/mediatek/Kconfig                               | 7 +++++++
> >  drivers/phy/mediatek/Makefile                              | 7 +++++++
> >  .../mediatek/phy-mtk-hdmi-mt2701.c}                        | 2 +-
> >  .../mediatek/phy-mtk-hdmi-mt8173.c}                        | 2 +-
> >  .../mtk_hdmi_phy.c =3D> phy/mediatek/phy-mtk-hdmi.c}         | 2 +-
> >  .../mtk_hdmi_phy.h =3D> phy/mediatek/phy-mtk-hdmi.h}         | 0
> >  8 files changed, 17 insertions(+), 16 deletions(-)
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
> > index ff6a1eb4ae83..2427d5bf699d 100644
> > --- a/drivers/gpu/drm/mediatek/Kconfig
> > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > @@ -26,10 +26,3 @@ config DRM_MEDIATEK_HDMI
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
> > diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makef=
ile
> > index 08a8e6a97b1e..cda074c53235 100644
> > --- a/drivers/phy/mediatek/Makefile
> > +++ b/drivers/phy/mediatek/Makefile
> > @@ -6,3 +6,10 @@
> >  obj-$(CONFIG_PHY_MTK_TPHY)           +=3D phy-mtk-tphy.o
> >  obj-$(CONFIG_PHY_MTK_UFS)            +=3D phy-mtk-ufs.o
> >  obj-$(CONFIG_PHY_MTK_XSPHY)          +=3D phy-mtk-xsphy.o
> > +
> > +phy-mtk-hdmi-drv-objs :=3D phy-mtk-hdmi.o \
> > +                      phy-mtk-hdmi-mt2701.o \
> > +                      phy-mtk-hdmi-mt8173.o
> > +
> > +obj-$(CONFIG_PHY_MTK_HDMI) +=3D phy-mtk-hdmi-drv.o
> > +
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
> > index b55f51675205..3521c4893c53 100644
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
> >
>
