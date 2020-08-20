Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D17C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2C720674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967639;
	bh=OrvMhzElo/BOA9sucY6YNBL0y8bC8eI2i5C7W2muAhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yhlGS9d6EFTv5VFjj88hQDthIceO9uEm0jyn//1+w4mDw0/oxDNsPXooDkIYloK25
	 6wHKcflj29ZJyc5h7VfkOtOpLxmTuz46tIoOJZVQXj7Wv0oEZFNQo8UpvIDS3SEN+e
	 gOGIJOQZpqvv3eQ9Yzm3IM5NMAAWOn0u18yJLjsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgHTXx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHTXxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:53:45 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00326208E4;
        Thu, 20 Aug 2020 23:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597967094;
        bh=OrvMhzElo/BOA9sucY6YNBL0y8bC8eI2i5C7W2muAhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jZnXbZvd6r/RDmhRl8Pd5bDqWjtnOLOVXZheUhdWXNR8JZL8+j8DXWO/rfJUaVM7s
         /aoaV762OQv+WFcuD4lrNZquWhQrGZiaGbYEq0edwA/JnZ6oCShF0kGqpoBWarODnk
         T0eURcudahnEMu2tSEyme9KyN5dYpoIqloRcKgaU=
Received: by mail-ej1-f45.google.com with SMTP id jp10so270208ejb.0;
        Thu, 20 Aug 2020 16:44:53 -0700 (PDT)
X-Gm-Message-State: AOAM530u3nGoPADJTPnHkvEnE2WB2jrhLNkpH/EqlIoOE0tMzFxSe0G9
        fum59jzwZuTMso6dqZ7etHBv1rTFtJt1nA5wpQ==
X-Google-Smtp-Source: ABdhPJyfF0seo8n875amt4dn9oSi2w9SsfnbMsQlnhtKaOBwUNOQeGo3OezMKFROAQyoW2OBGtjzdsNfwx1Y6KwE1IM=
X-Received: by 2002:a17:906:3a41:: with SMTP id a1mr337598ejf.260.1597967092612;
 Thu, 20 Aug 2020 16:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com> <1597903458-8055-9-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1597903458-8055-9-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:44:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Xt8=tQByDAZwuu_TT9bta1UtLak58uNKb2YM9XtG8DA@mail.gmail.com>
Message-ID: <CAAOTY_9Xt8=tQByDAZwuu_TT9bta1UtLak58uNKb2YM9XtG8DA@mail.gmail.com>
Subject: Re: [PATCH v1 08/21] drm/mediatek: check if fb is null
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> It's possible that state->base.fb is null. Add a check before access its
> format.

Add a Fixes tag.

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 427fe7f..2506803 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -269,7 +269,7 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp =
*comp, unsigned int idx,
>         }
>
>         con =3D ovl_fmt_convert(ovl, fmt);
> -       if (state->base.fb->format->has_alpha)
> +       if (state->base.fb && state->base.fb->format->has_alpha)
>                 con |=3D OVL_CON_AEN | OVL_CON_ALPHA;
>
>         if (pending->rotation & DRM_MODE_REFLECT_Y) {
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
