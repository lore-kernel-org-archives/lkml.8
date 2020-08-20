Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B5AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DA82072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597966824;
	bh=JeuGzk3Jo72ENzZOP/w7evl58YykGw/rfEkk7d6Bnpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WNvJ9Sy5dhfiMFGDUYyFR1T4rv0Pssb72+fqchB5rd9Hlcy7J/QYYpZ3uziOxRz7K
	 1RPDT30m6pJx8HNot5ZEi08VdHC/5TCWNXpc2jaMm5B+3adnivkNDzeTNWiklk39Nl
	 mC1iPITEFc5YzvjM2XNRtxQcGHvQT5Q0c5sVCDCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgHTXkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgHTXkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:40:22 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0728D2184D;
        Thu, 20 Aug 2020 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597966821;
        bh=JeuGzk3Jo72ENzZOP/w7evl58YykGw/rfEkk7d6Bnpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a3vAsrfeJ3XPEnlQEcN4od4V3SSKEJZzcpwwisxe/CuZw6iMFYA9EkBoMo0KEQ+bT
         Lx6ATLXDPkRDWK30QPfXXUzReIoBRSsm0h+huSNNfawXTHltpj6ZLD9NTSpVUZxket
         dr1w2tQrIBMnfWMcMYLWLFVtGEHlGpX9qPfzZ+nE=
Received: by mail-ed1-f52.google.com with SMTP id w17so7730edt.8;
        Thu, 20 Aug 2020 16:40:20 -0700 (PDT)
X-Gm-Message-State: AOAM531S6ujatVlXXx9aFkFnHK1oY2O5eyx3bhTfsQ3wmhEe4shShJSo
        4oPylqcPttT0n2b3tHVWwESp0NAxp9O1xyzEbQ==
X-Google-Smtp-Source: ABdhPJzna3InnRxo8hkyDHSNU+9VcCcyFr6DNyT7xME6ZRkd0mWDrHGJLBqAN3OHiSHoxJRJW9bWBYnWZRnLLuJ25Vg=
X-Received: by 2002:a50:d80b:: with SMTP id o11mr311324edj.148.1597966819553;
 Thu, 20 Aug 2020 16:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com> <1597903458-8055-7-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1597903458-8055-7-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:40:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY__s51xHeESdBwiRNL_2dg5n755ZT3cT+bn+2YDEaXCYBA@mail.gmail.com>
Message-ID: <CAAOTY__s51xHeESdBwiRNL_2dg5n755ZT3cT+bn+2YDEaXCYBA@mail.gmail.com>
Subject: Re: [PATCH v1 06/21] drm/mediatek: add disp config and mm 26mhz clock
 into mutex device
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
> there are 2 more clock need enable for display.
> parser these clock when mutex device probe,
> enable and disable when mutex on/off
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 49 ++++++++++++++++++++++++++++=
------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/med=
iatek/mtk_drm_ddp.c
> index 60788c1..de618a1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -118,7 +118,7 @@ struct mtk_ddp_data {
>
>  struct mtk_ddp {
>         struct device                   *dev;
> -       struct clk                      *clk;
> +       struct clk                      *clk[3];
>         void __iomem                    *regs;
>         struct mtk_disp_mutex           mutex[10];
>         const struct mtk_ddp_data       *data;
> @@ -257,14 +257,39 @@ int mtk_disp_mutex_prepare(struct mtk_disp_mutex *m=
utex)
>  {
>         struct mtk_ddp *ddp =3D container_of(mutex, struct mtk_ddp,
>                                            mutex[mutex->id]);
> -       return clk_prepare_enable(ddp->clk);
> +       int ret;
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(ddp->clk); i++) {
> +               if (IS_ERR(ddp->clk[i]))
> +                       continue;
> +               ret =3D clk_prepare_enable(ddp->clk[i]);
> +               if (ret) {
> +                       pr_err("failed to enable clock, err %d. i:%d\n",
> +                               ret, i);
> +                       goto err;
> +               }
> +       }
> +
> +       return 0;
> +
> +err:
> +       while (--i >=3D 0)
> +               clk_disable_unprepare(ddp->clk[i]);
> +       return ret;
>  }
>
>  void mtk_disp_mutex_unprepare(struct mtk_disp_mutex *mutex)
>  {
>         struct mtk_ddp *ddp =3D container_of(mutex, struct mtk_ddp,
>                                            mutex[mutex->id]);
> -       clk_disable_unprepare(ddp->clk);
> +       int i;
> +
> +        for (i =3D 0; i < ARRAY_SIZE(ddp->clk); i++) {
> +               if (IS_ERR(ddp->clk[i]))
> +                       continue;
> +               clk_disable_unprepare(ddp->clk[i]);
> +       }
>  }
>
>  void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
> @@ -415,11 +440,19 @@ static int mtk_ddp_probe(struct platform_device *pd=
ev)
>         ddp->data =3D of_device_get_match_data(dev);
>
>         if (!ddp->data->no_clk) {
> -               ddp->clk =3D devm_clk_get(dev, NULL);
> -               if (IS_ERR(ddp->clk)) {
> -                       if (PTR_ERR(ddp->clk) !=3D -EPROBE_DEFER)
> -                               dev_err(dev, "Failed to get clock\n");
> -                       return PTR_ERR(ddp->clk);
> +               int ret;
> +
> +               for (i =3D 0; i < ARRAY_SIZE(ddp->clk); i++) {

Modify binding document for this.

Regards,
Chun-Kuang.

> +                       ddp->clk[i] =3D of_clk_get(dev->of_node, i);
> +
> +                       if (IS_ERR(ddp->clk[i])) {
> +                               ret =3D PTR_ERR(ddp->clk[i]);
> +                               if (ret !=3D EPROBE_DEFER)
> +                                       dev_err(dev, "Failed to get clock=
 %d\n",
> +                                               ret);
> +
> +                               return ret;
> +                       }
>                 }
>         }
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
