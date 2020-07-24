Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C3C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2422F206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595633090;
	bh=Xq0D/3Ahn9nc9K3oRf4KbLNgsT57WhGyF47ymke7J1I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rteKYssTzw1JCpGKoMFaDEhTEoMWCW8hLzcYna5P9nz3jZ+nDxQsvXauMCyAPuCq7
	 7QufGQ+55k4RVmJr3YFOVhscCFKsJSYQ8QPbsWvG25rpZ6jLXRbOTVU6tAxS6fU3qo
	 N4tsN/ExmDHcfe6Cy94rUYsTwXgmSQmyGJmXYkpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGXXYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgGXXYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:24:48 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67BEB20759;
        Fri, 24 Jul 2020 23:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595633087;
        bh=Xq0D/3Ahn9nc9K3oRf4KbLNgsT57WhGyF47ymke7J1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MIZBc67KRjS8ZLworVZFG+SYVi3xl9mvfo5oYUoKFTMujoPdru9o7MwwdmH77Hz6A
         r5pXZ/CLYwX8cvPrWZWN7lvyEwy0pySxMxvV9jZ2MNAxDpeEp8dePxAQPFfKvZpyXI
         UqJ0ZiKUFF37FOK8uWzT5urNtwDON1Im4IGLQKVs=
Received: by mail-ej1-f43.google.com with SMTP id g7so3269266ejw.12;
        Fri, 24 Jul 2020 16:24:47 -0700 (PDT)
X-Gm-Message-State: AOAM531LrPg/Ejx2wwj729HwpYxmD8i4e9OQ2KmElb1J7vu4Rqz3NIVF
        gVDtzLn5l94azFTjjxffAoRGpf30KJZWj23E5A==
X-Google-Smtp-Source: ABdhPJwfhfPDr4sa3JCxhKDCTo0pXvPswGrmNiVpCVyLZxB4s1571M0BK+9I9DpZATfRGeAEvIM+EI8OA/dtKifFn2Q=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr11401027ejb.124.1595633085797;
 Fri, 24 Jul 2020 16:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com> <1595469798-3824-8-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1595469798-3824-8-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 25 Jul 2020 07:24:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9hdvw7htuOkJmmmGR9SAev4O+kWuMopfP_F=8Vg=_U+A@mail.gmail.com>
Message-ID: <CAAOTY_9hdvw7htuOkJmmmGR9SAev4O+kWuMopfP_F=8Vg=_U+A@mail.gmail.com>
Subject: Re: [v7, PATCH 7/7] drm/mediatek: add support for mediatek SOC MT8183
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

Hi Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:15=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add support for mediatek SOC MT8183
> 1.ovl_2l share driver with ovl

I think this is done in [1], [2], [3], this patch just add the support
of mt8183-ovl and mt8183-ovl-2l.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/mediatek?h=3Dv5.8-rc6&id=3D132c6e250ed745443973cada8db17=
cdbaebdf551
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/mediatek?h=3Dv5.8-rc6&id=3D318462d1a568634ba09263cc730cb=
0fb1d56c2b3
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/mediatek?h=3Dv5.8-rc6&id=3D57148baac8b78461e394953cfd531=
7bde8f795ab

> 2.rdma1 share drive with rdma0, but fifo size is different

I think this is done in [4], this patch just add the support of mt8183-rdma=
.

[4] https://patchwork.kernel.org/patch/11679549/

> 3.add mt8183 mutex private data, and mmsys private data
> 4.add mt8183 main and external path module for crtc create

The fourth item is the mmsys private data in third item, so you need
not to repeat it.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 18 ++++++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  6 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c   | 47 ++++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 43 ++++++++++++++++++++++++++=
+++
>  4 files changed, 114 insertions(+)
>

[snip]

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/med=
iatek/mtk_drm_ddp.c
> index 014c1bb..60788c1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -15,6 +15,8 @@
>
>  #define MT2701_DISP_MUTEX0_MOD0                        0x2c
>  #define MT2701_DISP_MUTEX0_SOF0                        0x30
> +#define MT8183_DISP_MUTEX0_MOD0                        0x30
> +#define MT8183_DISP_MUTEX0_SOF0                        0x2c
>
>  #define DISP_REG_MUTEX_EN(n)                   (0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)                      (0x24 + 0x20 * (n))
> @@ -25,6 +27,18 @@
>
>  #define INT_MUTEX                              BIT(1)
>
> +#define MT8183_MUTEX_MOD_DISP_RDMA0            0
> +#define MT8183_MUTEX_MOD_DISP_RDMA1            1
> +#define MT8183_MUTEX_MOD_DISP_OVL0             9
> +#define MT8183_MUTEX_MOD_DISP_OVL0_2L          10
> +#define MT8183_MUTEX_MOD_DISP_OVL1_2L          11
> +#define MT8183_MUTEX_MOD_DISP_WDMA0            12
> +#define MT8183_MUTEX_MOD_DISP_COLOR0           13
> +#define MT8183_MUTEX_MOD_DISP_CCORR0           14
> +#define MT8183_MUTEX_MOD_DISP_AAL0             15
> +#define MT8183_MUTEX_MOD_DISP_GAMMA0           16
> +#define MT8183_MUTEX_MOD_DISP_DITHER0          17
> +
>  #define MT8173_MUTEX_MOD_DISP_OVL0             11
>  #define MT8173_MUTEX_MOD_DISP_OVL1             12
>  #define MT8173_MUTEX_MOD_DISP_RDMA0            13
> @@ -74,6 +88,10 @@
>  #define MUTEX_SOF_DSI2                 5
>  #define MUTEX_SOF_DSI3                 6
>
> +#define MT8183_MUTEX_SOF_DPI0                  2
> +#define MT8183_MUTEX_EOF_DSI0                  (MUTEX_SOF_DSI0 << 6)
> +#define MT8183_MUTEX_EOF_DPI0                  (MT8183_MUTEX_SOF_DPI0 <<=
 6)
> +
>
>  struct mtk_disp_mutex {
>         int id;
> @@ -153,6 +171,20 @@ struct mtk_ddp {
>         [DDP_COMPONENT_WDMA1] =3D MT8173_MUTEX_MOD_DISP_WDMA1,
>  };
>
> +static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] =3D {
> +       [DDP_COMPONENT_AAL0] =3D MT8183_MUTEX_MOD_DISP_AAL0,
> +       [DDP_COMPONENT_CCORR] =3D MT8183_MUTEX_MOD_DISP_CCORR0,
> +       [DDP_COMPONENT_COLOR0] =3D MT8183_MUTEX_MOD_DISP_COLOR0,
> +       [DDP_COMPONENT_DITHER] =3D MT8183_MUTEX_MOD_DISP_DITHER0,
> +       [DDP_COMPONENT_GAMMA] =3D MT8183_MUTEX_MOD_DISP_GAMMA0,
> +       [DDP_COMPONENT_OVL0] =3D MT8183_MUTEX_MOD_DISP_OVL0,
> +       [DDP_COMPONENT_OVL_2L0] =3D MT8183_MUTEX_MOD_DISP_OVL0_2L,
> +       [DDP_COMPONENT_OVL_2L1] =3D MT8183_MUTEX_MOD_DISP_OVL1_2L,
> +       [DDP_COMPONENT_RDMA0] =3D MT8183_MUTEX_MOD_DISP_RDMA0,
> +       [DDP_COMPONENT_RDMA1] =3D MT8183_MUTEX_MOD_DISP_RDMA1,
> +       [DDP_COMPONENT_WDMA0] =3D MT8183_MUTEX_MOD_DISP_WDMA0,
> +};
> +
>  static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] =3D {
>         [DDP_MUTEX_SOF_SINGLE_MODE] =3D MUTEX_SOF_SINGLE_MODE,
>         [DDP_MUTEX_SOF_DSI0] =3D MUTEX_SOF_DSI0,
> @@ -163,6 +195,12 @@ struct mtk_ddp {
>         [DDP_MUTEX_SOF_DSI3] =3D MUTEX_SOF_DSI3,
>  };
>
> +static const unsigned int mt8183_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] =3D {
> +       [DDP_MUTEX_SOF_SINGLE_MODE] =3D MUTEX_SOF_SINGLE_MODE,
> +       [DDP_MUTEX_SOF_DSI0] =3D MUTEX_SOF_DSI0 | MT8183_MUTEX_EOF_DSI0,

I think this array is for 'sof', so you should drop MT8183_MUTEX_EOF_DSI0.

> +       [DDP_MUTEX_SOF_DPI0] =3D MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF=
_DPI0,

Ditto.

Regards,
Chun-Kuang.

> +};
> +
>  static const struct mtk_ddp_data mt2701_ddp_driver_data =3D {
>         .mutex_mod =3D mt2701_mutex_mod,
>         .mutex_sof =3D mt2712_mutex_sof,
> @@ -184,6 +222,13 @@ struct mtk_ddp {
>         .mutex_sof_reg =3D MT2701_DISP_MUTEX0_SOF0,
>  };
>
