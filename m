Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2124C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F95A21D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599690845;
	bh=qn7F9kIfrQDK9ilpICfJwnlqi88jogiZeINUWgtswHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LRXIlUGTpQHrURbYL0hQxTRPuAi3SMhFhz8D27M9E/Acd3j5r9wGt4HMZEsVDE4qm
	 rpH4hWMxMamwNzzvGEoTA6hTBumcuXnQfLgscReBZLiWmGYGTVZuEElquB2c3MOaQQ
	 l0ek6x/0Bap96KhSBQ0uMXwUio33ZLTPpxIDohGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIWeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgIIWeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 18:34:02 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F3F21D95
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599690841;
        bh=qn7F9kIfrQDK9ilpICfJwnlqi88jogiZeINUWgtswHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iMi/HJEhuhW4pM1AwbvKOq53FSk1YcujGZPO1K9TA6pNwJS8gPW9uq4uB1TRnkz0F
         wPnYcbHWC65NpQ2jbU0bpRveJHozE3zgQXYJLBjYDNQj9MITMfR3fnPK2/CTdHi1Az
         C2sv9nmC8QuACfs+p4/pitJoXrx01d76ieNUkY0c=
Received: by mail-ej1-f43.google.com with SMTP id lo4so5823190ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 15:34:00 -0700 (PDT)
X-Gm-Message-State: AOAM532yAY0HWeQViLptsOiPbcFv92OfayBCRVoSZCXAC6Z4AHPeqkAJ
        1TFJ+cUakzaTssECO2Ls2HU7CbXpwAwSbRtkTw==
X-Google-Smtp-Source: ABdhPJziy8hMosSfpL73I0q786HLEcsVS9kNOqzP/Nfn7KJ9FugubRKZT1YW+F3eOFoLVx5h6kQovjh9Mn2m2hErytY=
X-Received: by 2002:a17:906:a256:: with SMTP id bi22mr5766251ejb.375.1599690839500;
 Wed, 09 Sep 2020 15:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200826085317.681385-1-enric.balletbo@collabora.com> <20200826085317.681385-2-enric.balletbo@collabora.com>
In-Reply-To: <20200826085317.681385-2-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 10 Sep 2020 06:33:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-bix-mpn9rGmU0KGuByOJhG3oQQNS7w28oGdqDr_m4LQ@mail.gmail.com>
Message-ID: <CAAOTY_-bix-mpn9rGmU0KGuByOJhG3oQQNS7w28oGdqDr_m4LQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/2] drm/mediatek: mtk_dpi: Rename bridge to next_bridge
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        boris.brezillon@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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

Hi, Andrzej & Neil:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B48=E6=9C=8826=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:53=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> This is really a cosmetic change just to make a bit more readable the
> code after convert the driver to drm_bridge. The bridge variable name
> will be used by the encoder drm_bridge, and the chained bridge will be
> named next_bridge.

This is a DRM-bridge related patch, how do you think about it?

Regards,
Chun-Kuang.

>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2: None
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index d4f0fb7ad312..f7372dbdac0e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -64,7 +64,7 @@ enum mtk_dpi_out_color_format {
>  struct mtk_dpi {
>         struct mtk_ddp_comp ddp_comp;
>         struct drm_encoder encoder;
> -       struct drm_bridge *bridge;
> +       struct drm_bridge *next_bridge;
>         void __iomem *regs;
>         struct device *dev;
>         struct clk *engine_clk;
> @@ -610,7 +610,7 @@ static int mtk_dpi_bind(struct device *dev, struct de=
vice *master, void *data)
>         /* Currently DPI0 is fixed to be driven by OVL1 */
>         dpi->encoder.possible_crtcs =3D BIT(1);
>
> -       ret =3D drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL, 0);
> +       ret =3D drm_bridge_attach(&dpi->encoder, dpi->next_bridge, NULL, =
0);
>         if (ret) {
>                 dev_err(dev, "Failed to attach bridge: %d\n", ret);
>                 goto err_cleanup;
> @@ -770,11 +770,11 @@ static int mtk_dpi_probe(struct platform_device *pd=
ev)
>         }
>
>         ret =3D drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> -                                         NULL, &dpi->bridge);
> +                                         NULL, &dpi->next_bridge);
>         if (ret)
>                 return ret;
>
> -       dev_info(dev, "Found bridge node: %pOF\n", dpi->bridge->of_node);
> +       dev_info(dev, "Found bridge node: %pOF\n", dpi->next_bridge->of_n=
ode);
>
>         comp_id =3D mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
>         if (comp_id < 0) {
> --
> 2.28.0
>
