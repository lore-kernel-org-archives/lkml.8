Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB47C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B962086A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596326941;
	bh=oCx/GR0RX1huNTjbv/4QOj0BuphlW+WSIv710+yID1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qVOIM1BuHLRzoZPoF3S9DwGOaJ9UKAfTVgmYI19MuzjY7wQ6ufp7O/I/g0JEagV25
	 +RhhoispzyALwCX3OFq6ujoyM8NHdYRI1UJ93h/JR/AGSGTuZTmawsOYSD9YyRbYHS
	 LXij13szhPgLAYnFmUzevWySNWSSPJhSKOZeXqy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHBAI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBAI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 20:08:59 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 218E420888
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 00:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596326938;
        bh=oCx/GR0RX1huNTjbv/4QOj0BuphlW+WSIv710+yID1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=auSXa5Kl4kZmf41UMcsHVRiDTL85kbbPlpxVkVFQ7kWooytCoMrwGXLSHsoRDdwJv
         xF/3YFiTpEPCuGF/rFnjd68Phkka9RwUgLkY0C5OL8mSPZFJdulDE16Q4HL+mBKiQZ
         2aWsNLP3xq0tkonqfRAa1bYYq38KoR6z2FFtMzIc=
Received: by mail-ed1-f49.google.com with SMTP id c2so18958718edx.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 17:08:58 -0700 (PDT)
X-Gm-Message-State: AOAM532JrvuJV7om7aXXR0BUHK4wyON+jNJ5NKPlPESu8CLUdVu84u9V
        uAZ/eFBriq6ay2Ssj43JZ4Jr6tBVXmfdKgLbrA==
X-Google-Smtp-Source: ABdhPJw+2iH5+3kHHpb6k2cVa4JH26tuia/OYDRUWLfZx9UmtxOcJ2m2snfcRquwm1ycO+1YX3mUPz/vKyDmnugHutE=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr9749512edb.48.1596326936640;
 Sat, 01 Aug 2020 17:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200728111800.77641-1-frank-w@public-files.de> <20200728111800.77641-3-frank-w@public-files.de>
In-Reply-To: <20200728111800.77641-3-frank-w@public-files.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Aug 2020 08:08:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY__7wCeTm0OY0P1VKZp-r7+d7yj=LLb79Nzr1pVVkOjy2g@mail.gmail.com>
Message-ID: <CAAOTY__7wCeTm0OY0P1VKZp-r7+d7yj=LLb79Nzr1pVVkOjy2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] drm/mediatek: fix boot up for 720 and 480 but 1080
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chunhui dai <chunhui.dai@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:19=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> From: chunhui dai <chunhui.dai@mediatek.com>
>
> - disable tmds on phy on mt2701
> - support other resolutions like 1280x1024

If this patch does two things, it should be broken into two patches.

>
> without this Patch i see flickering on my TFT (1280x1024),
> so i guess clock is wrong.
>
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 3 +++
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        | 1 +
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/me=
diatek/mtk_hdmi_phy.c
> index 5223498502c4..edadb7a700f1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -184,6 +184,9 @@ static int mtk_hdmi_phy_probe(struct platform_device =
*pdev)
>                 return PTR_ERR(phy_provider);
>         }
>
> +       if (hdmi_phy->conf->pll_default_off)
> +               hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);

I think every pll is default off, so you should turn on pll rather
than disable tmds.

Regards,
Chun-Kuang.

> +
>         return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
>                                    hdmi_phy->pll);
>  }
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/me=
diatek/mtk_hdmi_phy.h
> index 2d8b3182470d..f472fdeb63dc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -22,6 +22,7 @@ struct mtk_hdmi_phy;
>  struct mtk_hdmi_phy_conf {
>         bool tz_disabled;
>         unsigned long flags;
> +       bool pll_default_off;
>         const struct clk_ops *hdmi_phy_clk_ops;
>         void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>         void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu=
/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index d3cc4022e988..6fbedacfc1e8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -239,6 +239,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi=
_phy *hdmi_phy)
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf =3D {
>         .tz_disabled =3D true,
>         .flags =3D CLK_SET_RATE_GATE,
> +       .pll_default_off =3D true,
>         .hdmi_phy_clk_ops =3D &mtk_hdmi_phy_pll_ops,
>         .hdmi_phy_enable_tmds =3D mtk_hdmi_phy_enable_tmds,
>         .hdmi_phy_disable_tmds =3D mtk_hdmi_phy_disable_tmds,
> --
> 2.25.1
>
