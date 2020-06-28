Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBDC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CD120738
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593353991;
	bh=FM4B6O890rOp11oQrSU4ptT/qfDOHTlolMOEiV7c7eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xQeqfBf+wUvTOkkPLq2g2g3B6FR8Lm8AWV6ppQjeSFdSEW70CkN9laDWTtx5Sh8WW
	 T0Ogd1RoeOLQSQnukZjggmD+NOZAQEQrkC/ijVVLooZ6duN+3pXi02gWsMJG3xyxgF
	 dEjB0lMCW7NysSLjxbnPBNenCOpNpdhfOxMX21P4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgF1OTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgF1OTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:19:44 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71832081A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593353984;
        bh=FM4B6O890rOp11oQrSU4ptT/qfDOHTlolMOEiV7c7eg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ferf/tRhh+Cyjnbgp3+HUzWJL7BG8wJdiusxjhIetWjKuYQLl1NXBXPjmBnr3vCvh
         dWv/o8RrX2s86NOIEDgsogfylbi+64Vl0yWbnZnSa9GCWp6fP+GaPtakZlExoeSwaZ
         Bbc5g+ADqv3U4MT/VcWtmh/WHRGkU0jlflrDU7+E=
Received: by mail-ej1-f44.google.com with SMTP id mb16so14041817ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 07:19:43 -0700 (PDT)
X-Gm-Message-State: AOAM5302gPL5/6bOqdbkoLxl5/k5KOulRPzERFyHWcB/+mlj21GouXuD
        IvMiz4huo/jlxNBBgLonga3S78K9mOaZUnGBQg==
X-Google-Smtp-Source: ABdhPJyBxW8NlX1UpfAJTQrr9ECyVfuVuXvUNgqMd8hviZLwctZBgwiwnmX4TCg6/5R7MfpzaqzdROaukyvUmvcYUqY=
X-Received: by 2002:a17:906:5fc4:: with SMTP id k4mr10157244ejv.94.1593353982337;
 Sun, 28 Jun 2020 07:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200616065102.15756-1-bernard@vivo.com>
In-Reply-To: <20200616065102.15756-1-bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 28 Jun 2020 22:19:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-yTjG7xW6MZ6NFYUDaeKCkASPP4JQPD1WTLUmOCG3muA@mail.gmail.com>
Message-ID: <CAAOTY_-yTjG7xW6MZ6NFYUDaeKCkASPP4JQPD1WTLUmOCG3muA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: remove unnecessary conversion to bool
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bernard:

Bernard Zhao <bernard@vivo.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8816=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In function mtk_dsi_clk_hs_state, remove unnecessary conversion
> to bool return, this change is to make the code a bit readable.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
> Changes since V1:
> *optimize to make the code a bit more clear.
>
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1255327/
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 4491e64b3f06..840cc9b9efc8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -316,10 +316,7 @@ static void mtk_dsi_lane0_ulp_mode_leave(struct mtk_=
dsi *dsi)
>
>  static bool mtk_dsi_clk_hs_state(struct mtk_dsi *dsi)
>  {
> -       u32 tmp_reg1;
> -
> -       tmp_reg1 =3D readl(dsi->regs + DSI_PHY_LCCON);
> -       return ((tmp_reg1 & LC_HS_TX_EN) =3D=3D 1);
> +       return (readl(dsi->regs + DSI_PHY_LCCON) & LC_HS_TX_EN);
>  }
>
>  static void mtk_dsi_clk_hs_mode(struct mtk_dsi *dsi, bool enter)
> --
> 2.17.1
>
