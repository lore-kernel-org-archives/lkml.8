Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CB8C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5083920719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585927393;
	bh=VgTn9bcNOSD9uXQoi/BYbHBZqU6U/bPHJOYKAow0HLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wzjRjxFi5YppnxDGiwrUyJZD/Kk7l/m7vlFNO4c9Y8OxqQp64j3HV/3/1S3IUZe5u
	 5UOEjecknFZZdcynDpdk8RHPOe7swZf1afcdg6sPf6BpOqpwzn3yQ5UyJmeMA6nPoR
	 GDlqUPS0yWrceP11/QJUFBFQWK4ZyFok+PTQcf9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404227AbgDCPXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404080AbgDCPXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:23:12 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92CF20CC7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Apr 2020 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585927391;
        bh=VgTn9bcNOSD9uXQoi/BYbHBZqU6U/bPHJOYKAow0HLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fl+CUr5gI6cRDR2adWBoB4qmj+hGFXzEB++RrxblKX0YtD3VLO2fG8HyTwfPcILL7
         x9gG27AIrqDFkdEEzQx/uwW7kzuA6L71lbR91fIcfhVQkDJuq+b0tXxkg7BdPQPKmJ
         mlbG7UyLIwePKt6n1iFtJM1u5p00hPDJCK+S1vGE=
Received: by mail-ed1-f50.google.com with SMTP id cw6so9653543edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:23:10 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ7eK9Ca4LiC8lqFMgudcX+18OJ0k9OSwhMwfGfJe20grawbSki
        33GDmDl4D6Y7GBLmjceZ1Xb7IUuax6uthMcU6w==
X-Google-Smtp-Source: APiQypJsws5ySCftPDCOmhjHI+FJoUbQYXzRxrRyf+OUeN3WHz0vnMQk2MtzJASwrlmS4sQX4+CE2CF2Mz8EKBf3/38=
X-Received: by 2002:a05:6402:b70:: with SMTP id cb16mr8077145edb.48.1585927389063;
 Fri, 03 Apr 2020 08:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200331155728.18032-1-chunkuang.hu@kernel.org>
 <20200331155728.18032-2-chunkuang.hu@kernel.org> <1585707361.28859.19.camel@mhfsdcap03>
 <ceae861b-b5ee-1d33-67dd-0a2ff4af2816@gmail.com> <CAAOTY_8EScidYVri=fn+sdteyD1TGSZ4AnYkp7kz2RozriSk=A@mail.gmail.com>
 <1585882773.28772.7.camel@mhfsdcap03>
In-Reply-To: <1585882773.28772.7.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 3 Apr 2020 23:22:57 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9OsJQNU4rceXN0sg9igH_hWo=m1TWzaO26NJ=wg8NGLA@mail.gmail.com>
Message-ID: <CAAOTY_9OsJQNU4rceXN0sg9igH_hWo=m1TWzaO26NJ=wg8NGLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/mediatek: Move tz_disabled from mtk_hdmi_phy
 to mtk_hdmi driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:59=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu, 2020-04-02 at 20:49 +0800, Chun-Kuang Hu wrote:
> > Hi, Matthias:
> >
> > Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B44=E6=
=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:53=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > >
> > >
> > > On 01/04/2020 04:16, Chunfeng Yun wrote:
> > > > On Tue, 2020-03-31 at 23:57 +0800, Chun-Kuang Hu wrote:
> > > >> From: CK Hu <ck.hu@mediatek.com>
> > > >>
> > > >> tz_disabled is used to control mtk_hdmi output signal, but this va=
riable
> > > >> is stored in mtk_hdmi_phy and mtk_hdmi_phy does not use it. So mov=
e
> > > >> tz_disabled to mtk_hdmi where it's used.
> > > >>
> > > >> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > >> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > >> ---
> > > >>  drivers/gpu/drm/mediatek/mtk_hdmi.c           | 22 ++++++++++++++=
++---
> > > >>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |  1 -
> > > >>  .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    |  1 -
> > > >>  3 files changed, 19 insertions(+), 5 deletions(-)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm=
/mediatek/mtk_hdmi.c
> > > >> index 5e4a4dbda443..878433c09c9b 100644
> > > >> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > > >> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > > >> @@ -144,11 +144,16 @@ struct hdmi_audio_param {
> > > >>      struct hdmi_codec_params codec_params;
> > > >>  };
> > > >>
> > > >> +struct mtk_hdmi_conf {
> > > >> +    bool tz_disabled;
> > > >> +};
> > > >> +
> > > >>  struct mtk_hdmi {
> > > >>      struct drm_bridge bridge;
> > > >>      struct drm_bridge *next_bridge;
> > > >>      struct drm_connector conn;
> > > >>      struct device *dev;
> > > >> +    const struct mtk_hdmi_conf *conf;
> > > >>      struct phy *phy;
> > > >>      struct device *cec_dev;
> > > >>      struct i2c_adapter *ddc_adpt;
> > > >> @@ -230,7 +235,6 @@ static void mtk_hdmi_hw_vid_black(struct mtk_h=
dmi *hdmi, bool black)
> > > >>  static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, =
bool enable)
> > > >>  {
> > > >>      struct arm_smccc_res res;
> > > >> -    struct mtk_hdmi_phy *hdmi_phy =3D phy_get_drvdata(hdmi->phy);
> > > >>
> > > >>      /*
> > > >>       * MT8173 HDMI hardware has an output control bit to enable/d=
isable HDMI
> > > >> @@ -238,7 +242,7 @@ static void mtk_hdmi_hw_make_reg_writable(stru=
ct mtk_hdmi *hdmi, bool enable)
> > > >>       * The ARM trusted firmware provides an API for the HDMI driv=
er to set
> > > >>       * this control bit to enable HDMI output in supervisor mode.
> > > >>       */
> > > >> -    if (hdmi_phy->conf && hdmi_phy->conf->tz_disabled)
> > > >> +    if (hdmi->conf->tz_disabled)
> > >
> > > Wouldn't we need to check:
> > > if (hdmi->conf && hdmi->conf->tz_disabled)
> >
> > My design is: hdmi->conf would not be NULL.
> >
> > >
> > > >>              regmap_update_bits(hdmi->sys_regmap,
> > > >>                                 hdmi->sys_offset + HDMI_SYS_CFG20,
> > > >>                                 0x80008005, enable ? 0x80000005 : =
0x8000);
> > > >> @@ -1688,6 +1692,7 @@ static int mtk_drm_hdmi_probe(struct platfor=
m_device *pdev)
> > > >>              return -ENOMEM;
> > > >>
> > > >>      hdmi->dev =3D dev;
> > > >> +    hdmi->conf =3D of_device_get_match_data(dev);
> > > >>
> > > >>      ret =3D mtk_hdmi_dt_parse_pdata(hdmi, pdev);
> > > >>      if (ret)
> > > >> @@ -1765,8 +1770,19 @@ static int mtk_hdmi_resume(struct device *d=
ev)
> > > >>  static SIMPLE_DEV_PM_OPS(mtk_hdmi_pm_ops,
> > > >>                       mtk_hdmi_suspend, mtk_hdmi_resume);
> > > >>
> > > >> +static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 =3D {
> > > >> +    .tz_disabled =3D true,
> > > >> +};
> > > >> +
> > > >> +static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8173;
> > > >> +
> > > >>  static const struct of_device_id mtk_drm_hdmi_of_ids[] =3D {
> > > >> -    { .compatible =3D "mediatek,mt8173-hdmi", },
> > > >> +    { .compatible =3D "mediatek,mt2701-hdmi",
> > > >> +      .data =3D &mtk_hdmi_conf_mt2701,
> > > >> +    },
> > > >> +    { .compatible =3D "mediatek,mt8173-hdmi",
> > > >> +      .data =3D &mtk_hdmi_conf_mt8173,
> > >
> > > We don't have any data? Then we should set data to NULL instead.
> >
> > My design is data would not be NULL, so I need not to check whether it
> > is NULL in driver.
> But we don't need .data for mt8173, it's better to set it to NULL.

OK, in the view of reducing the code size, setting it to NULL would
make code size smaller.
I would modify this in next version.

Regards,
Chun-Kuang.

>
> >
> > Regards,
> > CK
> >
> > >
> > > Regards,
> > > Matthias
> > >
> > > >> +    },
> > > >>      {}
> > > >>  };
> > > >>
> > > >> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu=
/drm/mediatek/mtk_hdmi_phy.h
> > > >> index 2d8b3182470d..fc1c2efd1128 100644
> > > >> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > > >> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > > >> @@ -20,7 +20,6 @@
> > > >>  struct mtk_hdmi_phy;
> > > >>
> > > >>  struct mtk_hdmi_phy_conf {
> > > >> -    bool tz_disabled;
> > > >>      unsigned long flags;
> > > >>      const struct clk_ops *hdmi_phy_clk_ops;
> > > >>      void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> > > >> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/driv=
ers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > > >> index d3cc4022e988..99fe05cd3598 100644
> > > >> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > > >> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > > >> @@ -237,7 +237,6 @@ static void mtk_hdmi_phy_disable_tmds(struct m=
tk_hdmi_phy *hdmi_phy)
> > > >>  }
> > > >>
> > > >>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf =3D {
> > > >> -    .tz_disabled =3D true,
> > > >>      .flags =3D CLK_SET_RATE_GATE,
> > > >>      .hdmi_phy_clk_ops =3D &mtk_hdmi_phy_pll_ops,
> > > >>      .hdmi_phy_enable_tmds =3D mtk_hdmi_phy_enable_tmds,
> > > >
> > > > Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > >
>
