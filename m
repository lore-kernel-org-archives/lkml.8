Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7150C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C4020674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967646;
	bh=Lgp8hsNdzOTq4kLm5ig7EfIsrARcaqyBrt2jpFkQe6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JZ2HtvmOXeqMnNPiKgQUF+9oegd8FMZpMdcUJum+LiAWOWWgBUIBIz8hGVOpxt4ae
	 2vbWDAFl0z8SLIAM9yBAKOxjrv8BhbkEF0lVxwAU8Grvhc80+4HYQJnMhD8VSqDx6e
	 70qlRcmiMH+lLXBewByRQ2v0CWuelcXdB9cyfqL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHTXyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgHTXxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:53:45 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4867F2087D;
        Thu, 20 Aug 2020 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597967175;
        bh=Lgp8hsNdzOTq4kLm5ig7EfIsrARcaqyBrt2jpFkQe6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OZZdzKzBD51K1BPGM0EaH36CMBKdv2QMN7b+GZuFw580TLsXutGo3pLBWhEXxDJjb
         yyKWfMFiN5pyb8aRWbVR6bWiB3b6XemNhW8ka0ApBKAQewZpX+xuTYvG603BrQW6fU
         cJrqycD8Iahf+l7FUboEoQsu0APFA7Lj3l5W3YdY=
Received: by mail-ej1-f41.google.com with SMTP id d6so249824ejr.5;
        Thu, 20 Aug 2020 16:46:15 -0700 (PDT)
X-Gm-Message-State: AOAM531nwDGGnzGc73Hd9CggPdWsqPHBVYS+i/ZtdS/2UDEllFZ4pmny
        lEpuyJiUSj5xlqpIc9iZ6aRWPm4gcmbb+Vsrww==
X-Google-Smtp-Source: ABdhPJwImiPZfml816TKJ8tULu0ObTfnI7+zw4vuK73Jk4H3K6TAuI9PR6yWIJfRJ60uRj1hxTknbdc2N7ifSaHVAU8=
X-Received: by 2002:a17:906:2356:: with SMTP id m22mr350366eja.124.1597967173923;
 Thu, 20 Aug 2020 16:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com> <1597903458-8055-10-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1597903458-8055-10-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:46:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8rWUdGgNQfvdZh0gCim8uQ=mJ7Pm=WRgCN_z+Dfb_bEQ@mail.gmail.com>
Message-ID: <CAAOTY_8rWUdGgNQfvdZh0gCim8uQ=mJ7Pm=WRgCN_z+Dfb_bEQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/21] drm/mediatek: fix aal size config
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
=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:18=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> fix aal size config
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index c90d2ee..fe76387 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -31,8 +31,13 @@
>  #define DISP_REG_UFO_START                     0x0000
>
>  #define DISP_AAL_EN                            0x0000
> +#define DISP_AAL_CFG                           0x0020
> +#define AAL_RELAY_MODE                                 BIT(0)
> +#define AAL_ENGINE_EN                                  BIT(1)
>  #define DISP_AAL_SIZE                          0x0030
>
> +#define DISP_AAL_OUTPUT_SIZE                   0x04d8
> +
>  #define DISP_CCORR_EN                          0x0000
>  #define CCORR_EN                               BIT(0)
>  #define DISP_CCORR_CFG                         0x0020
> @@ -182,7 +187,11 @@ static void mtk_aal_config(struct mtk_ddp_comp *comp=
, unsigned int w,
>                            unsigned int h, unsigned int vrefresh,
>                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
>  {
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_AAL_SIZE);
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_AAL_SIZE);
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_AAL_OUTPUT_SIZE);
> +
> +       mtk_ddp_write_mask(NULL, AAL_RELAY_MODE, comp, DISP_AAL_CFG,
> +                          AAL_RELAY_MODE | AAL_ENGINE_EN);

If this only should set in mt8192, add a private data to distinguish this.

Regards,
Chun-Kuang.

>  }
>
>  static void mtk_aal_start(struct mtk_ddp_comp *comp)
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
