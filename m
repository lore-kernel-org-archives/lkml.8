Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63DD2070C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595649065;
	bh=IB/6QMM3mNcLq0yp3daj3De1omfUDNO/kHLqyEhsa6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VMk/pjaPYT+aBniXh+Dv9ZclKybWon0s+ZlC7TP3aDHGq5836oq/jyZfMrfsWinBm
	 pKLBLcoCskqKRiSffHVl0sh0MYQJNkacw5LtX7FbGyXXwpFEqnNNEvogmuSsHwLtRy
	 0dpT9pezYVMtmtGUAbdsDoExl/C8UcsDPgUby+/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgGYDvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 23:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGYDvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:51:04 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2ED220719;
        Sat, 25 Jul 2020 03:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595649063;
        bh=IB/6QMM3mNcLq0yp3daj3De1omfUDNO/kHLqyEhsa6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K2KEh7TpNnF0mxAAYCqLboKVGglNo3SHCYHfljAe0xUta6Iitan62CbCecjxUdHwG
         HXBphKcfLkHGOOtCm8zoVgCHNZ2F3SrYMMzB+yes4gHO1K41s2zWEp/P/TaiTzKW6+
         AvVEhpyF9jSOP3gHlxMV12o5Wbs1AflrT4CHiD8Q=
Received: by mail-ej1-f50.google.com with SMTP id l4so11823059ejd.13;
        Fri, 24 Jul 2020 20:51:02 -0700 (PDT)
X-Gm-Message-State: AOAM533VU00j56UQ4HWO2koglbN5kpUWRj5y6mVdMYii4SCpV0LqtREG
        KBbtXd4AdmasLc7LQQA2B8qkkEAybIOP3ACGBg==
X-Google-Smtp-Source: ABdhPJxcx4pKWckZ+ivOQWgliPqjd8Cxz0hiophWU1IPuWMgAOcngrm0sm/OsQ7JYpawO3hTDs8v8meuDWYVWGhBJ0k=
X-Received: by 2002:a17:906:7857:: with SMTP id p23mr10925441ejm.260.1595649061371;
 Fri, 24 Jul 2020 20:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com> <1595469798-3824-7-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1595469798-3824-7-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 25 Jul 2020 11:50:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9jsunT=PH59yrJ=q_uPM83WVH1m4c379APCUOGL3ZjdQ@mail.gmail.com>
Message-ID: <CAAOTY_9jsunT=PH59yrJ=q_uPM83WVH1m4c379APCUOGL3ZjdQ@mail.gmail.com>
Subject: Re: [v7, PATCH 6/7] drm/mediatek: add fifo_size into rdma private data
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

The primary thing of this patch is to get fifo size from device tree.
So you may modify title to show the primary thing.

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> the fifo size of rdma in mt8183 is different.
> rdma0 fifo size is 5k
> rdma1 fifo size is 2k

I would like the description to be "Get the fifo size from device tree
because each rdma in the same SoC may have different fifo size."

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index e04319f..794acc5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -63,6 +63,7 @@ struct mtk_disp_rdma {
>         struct mtk_ddp_comp             ddp_comp;
>         struct drm_crtc                 *crtc;
>         const struct mtk_disp_rdma_data *data;
> +       u32                             fifo_size;
>  };
>
>  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *co=
mp)
> @@ -131,12 +132,18 @@ static void mtk_rdma_config(struct mtk_ddp_comp *co=
mp, unsigned int width,
>         unsigned int threshold;
>         unsigned int reg;
>         struct mtk_disp_rdma *rdma =3D comp_to_rdma(comp);
> +       u32 rdma_fifo_size;
>
>         mtk_ddp_write_mask(cmdq_pkt, width, comp,
>                            DISP_REG_RDMA_SIZE_CON_0, 0xfff);
>         mtk_ddp_write_mask(cmdq_pkt, height, comp,
>                            DISP_REG_RDMA_SIZE_CON_1, 0xfffff);
>
> +       if (rdma->fifo_size)
> +               rdma_fifo_size =3D rdma->fifo_size;
> +       else
> +               rdma_fifo_size =3D RDMA_FIFO_SIZE(rdma);
> +
>         /*
>          * Enable FIFO underflow since DSI and DPI can't be blocked.
>          * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> @@ -145,7 +152,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp=
, unsigned int width,
>          */
>         threshold =3D width * height * vrefresh * 4 * 7 / 1000000;
>         reg =3D RDMA_FIFO_UNDERFLOW_EN |
> -             RDMA_FIFO_PSEUDO_SIZE(RDMA_FIFO_SIZE(rdma)) |
> +             RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
>               RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
>         mtk_ddp_write(cmdq_pkt, reg, comp, DISP_REG_RDMA_FIFO_CON);
>  }
> @@ -291,6 +298,16 @@ static int mtk_disp_rdma_probe(struct platform_devic=
e *pdev)
>                 return comp_id;
>         }
>
> +       if (of_find_property(dev->of_node, "mediatek,rdma_fifo_size", &re=
t)) {
> +               ret =3D of_property_read_u32(dev->of_node,
> +                                          "mediatek,rdma_fifo_size",
> +                                          &priv->fifo_size);
> +               if (ret) {
> +                       dev_err(dev, "Failed to get rdma fifo size\n");
> +                       return ret;
> +               }
> +       }
> +
>         ret =3D mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, com=
p_id,
>                                 &mtk_disp_rdma_funcs);
>         if (ret) {
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
