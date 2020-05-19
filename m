Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E91C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F42207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589901248;
	bh=ScSGe8jrv3hfKhjCdizhN+Uxf0LNOAIcifPOI6l0k1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NApIudWRSeB9WGa7IcaVptxqndaPhWTwCEr770qztg3y34/cataHdRWN692V4w4WP
	 X9tW2sRKBPiwHqNaYX2nuCfmg/5dpyNEV0056QHnE0JSiQx47UR1qhrmll2Z2SncUr
	 v6r7TPN0Jl85KTpP3W9jrZkZa+zavI+m9WvXkddg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgESPOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgESPOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:14:07 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8349020849
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589901246;
        bh=ScSGe8jrv3hfKhjCdizhN+Uxf0LNOAIcifPOI6l0k1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FKp/kLhhACiUYxTanjepKan9en1fyjUm9fL4lkrMfnS6meFg+txGACCaV1MW6ciFs
         TL1A1kdD/qDFJVvRZ6lUs05xiyHRTPYkNV0tJF1kY254vAZTmeSO4gXHNE5rqSRxEw
         8CSoX0Mcj/zyPbInqAEjbZ8AzqM89Sc2bISgLGNY=
Received: by mail-ej1-f42.google.com with SMTP id x20so12212257ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:14:06 -0700 (PDT)
X-Gm-Message-State: AOAM531NoHjTiuMGHVEoaun0ECgRlBNR1rZ2pKUWrJzHNUS2q3+ePpa3
        pDt21zdOoBIYYVL6Vnur/ShqAuvZsgoEfiUglA==
X-Google-Smtp-Source: ABdhPJyGEMfHqwCecpXfV9Hb2nOIzkFqW5hk23VzHWZF6LNSHpvLL5cECCEgClHrkDVgI7tUHYITO+v3cLGXVoWSYp8=
X-Received: by 2002:a17:906:3041:: with SMTP id d1mr13973435ejd.7.1589901244908;
 Tue, 19 May 2020 08:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200519094115.2448092-1-enric.balletbo@collabora.com>
In-Reply-To: <20200519094115.2448092-1-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 19 May 2020 23:13:53 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-uyJiBEDNDv8OvGD6MT6jx-jiH1hM4kc6d1v9f2a525g@mail.gmail.com>
Message-ID: <CAAOTY_-uyJiBEDNDv8OvGD6MT6jx-jiH1hM4kc6d1v9f2a525g@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi: Remove debug messages for
 function calls
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B45=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:41=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Equivalent information can be nowadays obtained using function tracer
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/gpu/drm/mediatek/mtk_hdmi.c            | 12 +-----------
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  4 ----
>  2 files changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index b0555a7cb3b4..172d67294435 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1634,8 +1634,6 @@ static int mtk_hdmi_audio_startup(struct device *de=
v, void *data)
>  {
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
>
> -       dev_dbg(dev, "%s\n", __func__);
> -
>         mtk_hdmi_audio_enable(hdmi);
>
>         return 0;
> @@ -1645,8 +1643,6 @@ static void mtk_hdmi_audio_shutdown(struct device *=
dev, void *data)
>  {
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
>
> -       dev_dbg(dev, "%s\n", __func__);
> -
>         mtk_hdmi_audio_disable(hdmi);
>  }
>
> @@ -1655,8 +1651,6 @@ mtk_hdmi_audio_digital_mute(struct device *dev, voi=
d *data, bool enable)
>  {
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
>
> -       dev_dbg(dev, "%s(%d)\n", __func__, enable);
> -
>         if (enable)
>                 mtk_hdmi_hw_aud_mute(hdmi);
>         else
> @@ -1669,8 +1663,6 @@ static int mtk_hdmi_audio_get_eld(struct device *de=
v, void *data, uint8_t *buf,
>  {
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
>
> -       dev_dbg(dev, "%s\n", __func__);
> -
>         memcpy(buf, hdmi->conn.eld, min(sizeof(hdmi->conn.eld), len));
>
>         return 0;
> @@ -1770,7 +1762,6 @@ static int mtk_drm_hdmi_probe(struct platform_devic=
e *pdev)
>                 goto err_bridge_remove;
>         }
>
> -       dev_dbg(dev, "mediatek hdmi probe success\n");
>         return 0;
>
>  err_bridge_remove:
> @@ -1793,7 +1784,7 @@ static int mtk_hdmi_suspend(struct device *dev)
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
>
>         mtk_hdmi_clk_disable_audio(hdmi);
> -       dev_dbg(dev, "hdmi suspend success!\n");
> +
>         return 0;
>  }
>
> @@ -1808,7 +1799,6 @@ static int mtk_hdmi_resume(struct device *dev)
>                 return ret;
>         }
>
> -       dev_dbg(dev, "hdmi resume success!\n");
>         return 0;
>  }
>  #endif
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu=
/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index b55f51675205..1c3575372230 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -159,8 +159,6 @@ static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
>  {
>         struct mtk_hdmi_phy *hdmi_phy =3D to_mtk_hdmi_phy(hw);
>
> -       dev_dbg(hdmi_phy->dev, "%s\n", __func__);
> -
>         mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_AUTOK_EN=
);
>         mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_PLL_POSDIV);
>         mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON3, RG_HDMITX_MHLCK_EN);
> @@ -178,8 +176,6 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
>  {
>         struct mtk_hdmi_phy *hdmi_phy =3D to_mtk_hdmi_phy(hw);
>
> -       dev_dbg(hdmi_phy->dev, "%s\n", __func__);
> -
>         mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_TXDIV_=
EN);
>         mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_BIAS_L=
PF_EN);
>         usleep_range(100, 150);
> --
> 2.26.2
>
