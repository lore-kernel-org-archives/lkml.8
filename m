Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00154C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06ED2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597707778;
	bh=x2x17PXByjmc5GL+cpiiMIiGtoeX2KrAjZvn4MxGmjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Gxu5VS7miVtTEEO8xkPhbeL9G62xE77wWgjKrttHph+skhZSVDbXVjjVa7GeJkD+X
	 BD9ohaIxYyKuBCRFds3W+sIXY1mXjP4Q/uC04GdsI8ZfZI/xLNQE9gk/x5LZni6yaQ
	 4zLZDWtntsK9Tfp5+oHE7qBsPxxhvFd6Rh/I+k/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHQXm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgHQXm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:42:56 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8693F2072E;
        Mon, 17 Aug 2020 23:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597707775;
        bh=x2x17PXByjmc5GL+cpiiMIiGtoeX2KrAjZvn4MxGmjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jc/vz+UQzZaY3RWlTnKJ/1TkiZZistwAP8D5Rbr8gGMvQbCioL9ezZGWDCLTThzMQ
         I5yeRps1Ms1E0aACHi+zxzWiY6evzagCBlM0RQAdSbsnhAHBIiYPfeCGeWc7+3eOqs
         dR1K0IcG7QqNsmy+9iOB1VtJ8Sl6Xkug3njoTXFI=
Received: by mail-ej1-f43.google.com with SMTP id jp10so19918105ejb.0;
        Mon, 17 Aug 2020 16:42:55 -0700 (PDT)
X-Gm-Message-State: AOAM533+bJjEgTqAcpo1nZ2COO7AFuTb8WGdmgRyuKBHHG1Fk6mjC0aa
        TUjKmE21vn1y50E7QApIp2CobQiRmshgzSJ15Q==
X-Google-Smtp-Source: ABdhPJz1blTGXowp+NNEIdFVKpxsWzYUxZj6C7dOmrD54k7lOK5kU33K3omXAVdbUpjCWHkbhkIeIAutfvc+KMgeqYw=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr16958911ejb.187.1597707774145;
 Mon, 17 Aug 2020 16:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200817130640.18021-1-jitao.shi@mediatek.com>
In-Reply-To: <20200817130640.18021-1-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 18 Aug 2020 07:42:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9ggDUdDD9KoOaWBx3XaK+=Q=5qxahG7SJ5uYBQZ4aadw@mail.gmail.com>
Message-ID: <CAAOTY_9ggDUdDD9KoOaWBx3XaK+=Q=5qxahG7SJ5uYBQZ4aadw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: dsi: fix scrolling of panel with small
 hfp or hbp
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> horizontal_backporch_byte should be hbp * bpp - hbp extra bytes.
> So remove the wrong subtraction 10.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 270bf22c98fe..5d031e634571 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -473,14 +473,13 @@ static void mtk_dsi_config_vdo_timing(struct mtk_ds=
i *dsi)
>         horizontal_sync_active_byte =3D (vm->hsync_len * dsi_tmp_buf_bpp =
- 10);

So this subtraction 10 is correct?

Regards,
Chun-Kuang.

>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> -               horizontal_backporch_byte =3D
> -                       (vm->hback_porch * dsi_tmp_buf_bpp - 10);
> +               horizontal_backporch_byte =3D vm->hback_porch * dsi_tmp_b=
uf_bpp;
>         else
> -               horizontal_backporch_byte =3D ((vm->hback_porch + vm->hsy=
nc_len) *
> -                       dsi_tmp_buf_bpp - 10);
> +               horizontal_backporch_byte =3D (vm->hback_porch + vm->hsyn=
c_len) *
> +                                           dsi_tmp_buf_bpp;
>
>         data_phy_cycles =3D timing->lpx + timing->da_hs_prepare +
> -                         timing->da_hs_zero + timing->da_hs_exit + 3;
> +                         timing->da_hs_zero + timing->da_hs_exit;
>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
>                 if ((vm->hfront_porch + vm->hback_porch) * dsi_tmp_buf_bp=
p >
> --
> 2.12.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
