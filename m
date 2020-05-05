Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F0AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A96C206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588683958;
	bh=dvbRX7EeM06dsl2ZOfOT5WBgv/T4PM2ppoNNZuX4hm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KmWT3uIblS5nqWQUls3hLui6GJ2Cep5tR/ojO67/rM/72ZhUM/ViKoboXas//bQYy
	 6U/5nVu8NHkcDZPDDn8GkDiDsV+jrrW0bG78vFfqh6xGIgbZ4Vi0NLyS1Ue9is93K3
	 N8URbMCKuTLlifggDLHAZZJSeiEgg8bfcCNkUIJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgEENF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgEENF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:05:57 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E76620757
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588683956;
        bh=dvbRX7EeM06dsl2ZOfOT5WBgv/T4PM2ppoNNZuX4hm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=neqboCczN+Cdz09ZuDmJ5SDMNim2FB9HO7s1Q9yYJ3/NilYj5E454ePytgS+Asq6w
         aoC5r10DK1ND17IpN/vWZNpYfjligx54R/u3Wiew9ALEj/kS/uW1r59UOgv5Ivm9AI
         xbI9Syh3SVWVXuDtwl2GIBYcVCLcnkR2I632xPaI=
Received: by mail-ed1-f54.google.com with SMTP id a8so1787282edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:05:56 -0700 (PDT)
X-Gm-Message-State: AGi0Pub8/BLBaMw13mHy7iW5MGdvupkDmHklQAxs4mKLt+41TWajy8z7
        M/8eHzUypAVySxsRUekp6/FqXtCo+pnlGQ9b2w==
X-Google-Smtp-Source: APiQypIQFhovoglRSXHegx9gEyfNNxTtVpJjyKZpJgiRmyVTk2jNz+plbrT0C7AXa4PJSMiG3lL/djzaOe3llc15X/Y=
X-Received: by 2002:aa7:dcd7:: with SMTP id w23mr2569139edu.300.1588683954729;
 Tue, 05 May 2020 06:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200504141408.60877-1-enric.balletbo@collabora.com> <20200504141408.60877-2-enric.balletbo@collabora.com>
In-Reply-To: <20200504141408.60877-2-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 5 May 2020 21:05:41 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8bOAW-8-8v-=S2qBrdG-dSAjf9WMWON+VHk4EKrQG7XQ@mail.gmail.com>
Message-ID: <CAAOTY_8bOAW-8-8v-=S2qBrdG-dSAjf9WMWON+VHk4EKrQG7XQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/mediatek: mtk_dpi: Rename bridge to next_bridge
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
=B45=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:14=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> This is really a cosmetic change just to make a bit more readable the
> code after convert the driver to drm_bridge. The bridge variable name
> will be used by the encoder drm_bridge, and the chained bridge will be
> named next_bridge.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 7fbfa95bab09..7112125dc3d1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -61,7 +61,7 @@ enum mtk_dpi_out_color_format {
>  struct mtk_dpi {
>         struct mtk_ddp_comp ddp_comp;
>         struct drm_encoder encoder;
> -       struct drm_bridge *bridge;
> +       struct drm_bridge *next_bridge;
>         void __iomem *regs;
>         struct device *dev;
>         struct clk *engine_clk;
> @@ -607,7 +607,7 @@ static int mtk_dpi_bind(struct device *dev, struct de=
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
> @@ -747,11 +747,11 @@ static int mtk_dpi_probe(struct platform_device *pd=
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
> 2.26.2
>
