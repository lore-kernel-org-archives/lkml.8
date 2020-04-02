Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCFDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687EB206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585831808;
	bh=BgurOqN8YH50Ohx6QZHMHzK9Spell372FkyiG6w8WT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WfiQrvxl67/zGB2/ZJNT0DegTXHJc/oTUsKM8AaNS8Fo2e1MEwAzKgrNUYQXyiLjQ
	 onB3UJHGgfMLUwtfNS+WenhfeSq+yZMr2H3csdtAY1G1aU6KrAYZErGG5/9TEee8Vf
	 0yw+n9LDm8EpqLImi/ZZce4l3pSMEWF0Vvucocsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbgDBMuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgDBMuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:50:04 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380D2206F6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585831803;
        bh=BgurOqN8YH50Ohx6QZHMHzK9Spell372FkyiG6w8WT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XAV4hhYyQ3GdnynfQvvooUuE8rlZ1PDG47HWS+QJfX2oYeDlIcF5/blR/duheKEBX
         4gtQgmxL20OdaRjd3jiUH+sdYOv5eo2a40h/wFiyBtAhP98z0E3Iox0vALB6GDT9Mw
         MMml7G/nQzfGIQT5WyFzTIeaTUJjArBM4SSS3Wak=
Received: by mail-ed1-f54.google.com with SMTP id i7so3960261edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:50:03 -0700 (PDT)
X-Gm-Message-State: AGi0Pubp3zpPZosjK2QuZNI/epi9+5oWj3QsaSSDv1ZbMiZqPOMjAvYf
        2qqtfl0XW3MolW5f1cViFJPIUR/l14Jv8ap1UA==
X-Google-Smtp-Source: APiQypJuhApCgfNeVfyRBA7I1Vqx/qouVDmtjFJxSrUqEZy2eH7v73RzO/vmzS4PJe08jnen+1Vf4fAM/BVv+6B8dwg=
X-Received: by 2002:a17:906:124f:: with SMTP id u15mr2951082eja.360.1585831801460;
 Thu, 02 Apr 2020 05:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200331155728.18032-1-chunkuang.hu@kernel.org>
 <20200331155728.18032-2-chunkuang.hu@kernel.org> <1585707361.28859.19.camel@mhfsdcap03>
 <ceae861b-b5ee-1d33-67dd-0a2ff4af2816@gmail.com>
In-Reply-To: <ceae861b-b5ee-1d33-67dd-0a2ff4af2816@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 2 Apr 2020 20:49:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8EScidYVri=fn+sdteyD1TGSZ4AnYkp7kz2RozriSk=A@mail.gmail.com>
Message-ID: <CAAOTY_8EScidYVri=fn+sdteyD1TGSZ4AnYkp7kz2RozriSk=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/mediatek: Move tz_disabled from mtk_hdmi_phy
 to mtk_hdmi driver
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=88=
1=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:53=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 01/04/2020 04:16, Chunfeng Yun wrote:
> > On Tue, 2020-03-31 at 23:57 +0800, Chun-Kuang Hu wrote:
> >> From: CK Hu <ck.hu@mediatek.com>
> >>
> >> tz_disabled is used to control mtk_hdmi output signal, but this variab=
le
> >> is stored in mtk_hdmi_phy and mtk_hdmi_phy does not use it. So move
> >> tz_disabled to mtk_hdmi where it's used.
> >>
> >> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> >> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >> ---
> >>  drivers/gpu/drm/mediatek/mtk_hdmi.c           | 22 ++++++++++++++++--=
-
> >>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |  1 -
> >>  .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    |  1 -
> >>  3 files changed, 19 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi.c
> >> index 5e4a4dbda443..878433c09c9b 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> >> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> >> @@ -144,11 +144,16 @@ struct hdmi_audio_param {
> >>      struct hdmi_codec_params codec_params;
> >>  };
> >>
> >> +struct mtk_hdmi_conf {
> >> +    bool tz_disabled;
> >> +};
> >> +
> >>  struct mtk_hdmi {
> >>      struct drm_bridge bridge;
> >>      struct drm_bridge *next_bridge;
> >>      struct drm_connector conn;
> >>      struct device *dev;
> >> +    const struct mtk_hdmi_conf *conf;
> >>      struct phy *phy;
> >>      struct device *cec_dev;
> >>      struct i2c_adapter *ddc_adpt;
> >> @@ -230,7 +235,6 @@ static void mtk_hdmi_hw_vid_black(struct mtk_hdmi =
*hdmi, bool black)
> >>  static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool=
 enable)
> >>  {
> >>      struct arm_smccc_res res;
> >> -    struct mtk_hdmi_phy *hdmi_phy =3D phy_get_drvdata(hdmi->phy);
> >>
> >>      /*
> >>       * MT8173 HDMI hardware has an output control bit to enable/disab=
le HDMI
> >> @@ -238,7 +242,7 @@ static void mtk_hdmi_hw_make_reg_writable(struct m=
tk_hdmi *hdmi, bool enable)
> >>       * The ARM trusted firmware provides an API for the HDMI driver t=
o set
> >>       * this control bit to enable HDMI output in supervisor mode.
> >>       */
> >> -    if (hdmi_phy->conf && hdmi_phy->conf->tz_disabled)
> >> +    if (hdmi->conf->tz_disabled)
>
> Wouldn't we need to check:
> if (hdmi->conf && hdmi->conf->tz_disabled)

My design is: hdmi->conf would not be NULL.

>
> >>              regmap_update_bits(hdmi->sys_regmap,
> >>                                 hdmi->sys_offset + HDMI_SYS_CFG20,
> >>                                 0x80008005, enable ? 0x80000005 : 0x80=
00);
> >> @@ -1688,6 +1692,7 @@ static int mtk_drm_hdmi_probe(struct platform_de=
vice *pdev)
> >>              return -ENOMEM;
> >>
> >>      hdmi->dev =3D dev;
> >> +    hdmi->conf =3D of_device_get_match_data(dev);
> >>
> >>      ret =3D mtk_hdmi_dt_parse_pdata(hdmi, pdev);
> >>      if (ret)
> >> @@ -1765,8 +1770,19 @@ static int mtk_hdmi_resume(struct device *dev)
> >>  static SIMPLE_DEV_PM_OPS(mtk_hdmi_pm_ops,
> >>                       mtk_hdmi_suspend, mtk_hdmi_resume);
> >>
> >> +static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 =3D {
> >> +    .tz_disabled =3D true,
> >> +};
> >> +
> >> +static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8173;
> >> +
> >>  static const struct of_device_id mtk_drm_hdmi_of_ids[] =3D {
> >> -    { .compatible =3D "mediatek,mt8173-hdmi", },
> >> +    { .compatible =3D "mediatek,mt2701-hdmi",
> >> +      .data =3D &mtk_hdmi_conf_mt2701,
> >> +    },
> >> +    { .compatible =3D "mediatek,mt8173-hdmi",
> >> +      .data =3D &mtk_hdmi_conf_mt8173,
>
> We don't have any data? Then we should set data to NULL instead.

My design is data would not be NULL, so I need not to check whether it
is NULL in driver.

Regards,
CK

>
> Regards,
> Matthias
>
> >> +    },
> >>      {}
> >>  };
> >>
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm=
/mediatek/mtk_hdmi_phy.h
> >> index 2d8b3182470d..fc1c2efd1128 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> >> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> >> @@ -20,7 +20,6 @@
> >>  struct mtk_hdmi_phy;
> >>
> >>  struct mtk_hdmi_phy_conf {
> >> -    bool tz_disabled;
> >>      unsigned long flags;
> >>      const struct clk_ops *hdmi_phy_clk_ops;
> >>      void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/=
gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> >> index d3cc4022e988..99fe05cd3598 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> >> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> >> @@ -237,7 +237,6 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_h=
dmi_phy *hdmi_phy)
> >>  }
> >>
> >>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf =3D {
> >> -    .tz_disabled =3D true,
> >>      .flags =3D CLK_SET_RATE_GATE,
> >>      .hdmi_phy_clk_ops =3D &mtk_hdmi_phy_pll_ops,
> >>      .hdmi_phy_enable_tmds =3D mtk_hdmi_phy_enable_tmds,
> >
> > Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> >
