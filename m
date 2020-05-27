Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B59C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4482078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590622088;
	bh=ON8PGesyAn+4FmexUP19mmvqNBZwY/TUXpZfPPF4QJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vXTSm716caMp7InPu7n1/LNRXsSVsCMvkVz9Lzj5uvU8ald0dXXP+azC7xH7/M0nl
	 eBAHT3K/wr5dBWIbYxR6lW+5bmqCEjX8tDBxLp7gyL6slZ5o3JzFtEvmDI+ibX+rB0
	 CqMQAJWFhGYL+ppBkq6B9EAm9mVmG+EnJAbX/C+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgE0X2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0X2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:28:07 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCBB2078C;
        Wed, 27 May 2020 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590622086;
        bh=ON8PGesyAn+4FmexUP19mmvqNBZwY/TUXpZfPPF4QJ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kwd/vg40MGTNgBlsGgZ1Ns4+sylbYRSUWSNWkKyvF2LP9p7PPuTN74buHh4ysAfUP
         kx3KaoRMpZhdY7tjVPWt3N1iEkG2St95fPYcLkiFUc6rRYsmwUdfCmOhbSkxxLlh5i
         poNDOBeCPqZrqDXH78oVECSagX75utQkwG/6d91Q=
Received: by mail-ej1-f53.google.com with SMTP id o15so8684365ejm.12;
        Wed, 27 May 2020 16:28:06 -0700 (PDT)
X-Gm-Message-State: AOAM531FqwZp7VqhUwZ2UEsAaPmwxsqPppWEUfrglQDOJz3mmcMBa5Ss
        PN+bGrwQL7Puuja/J3mvvm1RggX4qkqXP4MH1Q==
X-Google-Smtp-Source: ABdhPJzcHSIbC4Mtrhld0K/22ZiApP3zop/6GIPFmfLxlHDVkueEoHAc4k/CHn67ZoeNeAdbwomWMXLXwYcLw84+BHU=
X-Received: by 2002:a17:906:bcf8:: with SMTP id op24mr635286ejb.260.1590622084979;
 Wed, 27 May 2020 16:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200522101225.62571-1-jitao.shi@mediatek.com>
In-Reply-To: <20200522101225.62571-1-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 28 May 2020 07:27:51 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8=HvU8p=6xG5_bNHtjXOsQwNAn1zqHF6AmwtOReZ_Xzw@mail.gmail.com>
Message-ID: <CAAOTY_8=HvU8p=6xG5_bNHtjXOsQwNAn1zqHF6AmwtOReZ_Xzw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: fix scrolling of panel with small hfp
 or hbp
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

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> If panel has too small hfp or hbp, horizontal_frontporch_byte or
> horizontal_backporch_byte may become very small value or negative
> value. This patch adjusts their values so that they are greater
> than minimum value and keep total of them unchanged.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 0ede69830a9d..aebaafd90ceb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -148,6 +148,9 @@
>         (type =3D=3D MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
>         (type =3D=3D MIPI_DSI_DCS_READ))
>
> +#define MIN_HFP_BYTE           0x02
> +#define MIN_HBP_BYTE           0x02
> +
>  struct mtk_phy_timing {
>         u32 lpx;
>         u32 da_hs_prepare;
> @@ -450,6 +453,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi =
*dsi)
>         u32 horizontal_sync_active_byte;
>         u32 horizontal_backporch_byte;
>         u32 horizontal_frontporch_byte;
> +       s32 signed_hfp_byte, signed_hbp_byte;
>         u32 dsi_tmp_buf_bpp, data_phy_cycles;
>         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
>
> @@ -519,6 +523,20 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi=
 *dsi)
>                 }
>         }
>
> +       signed_hfp_byte =3D (s32)horizontal_frontporch_byte;
> +       signed_hbp_byte =3D (s32)horizontal_backporch_byte;
> +
> +       if (signed_hfp_byte + signed_hbp_byte < MIN_HFP_BYTE + MIN_HBP_BY=
TE) {
> +               DRM_WARN("Calculated hfp_byte and hbp_byte are too small,=
 "
> +                        "panel may not work properly.\n");
> +       } else if (signed_hfp_byte < MIN_HFP_BYTE) {
> +               horizontal_frontporch_byte =3D MIN_HFP_BYTE;
> +               horizontal_backporch_byte -=3D MIN_HFP_BYTE - signed_hfp_=
byte;
> +       } else if (signed_hbp_byte < MIN_HBP_BYTE) {
> +               horizontal_frontporch_byte -=3D MIN_HBP_BYTE - signed_hbp=
_byte;
> +               horizontal_backporch_byte =3D MIN_HBP_BYTE;
> +       }
> +

I think horizontal_frontporch_byte would never be negtive, and
horizontal_backporch_byte would be negtive when

 if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
horizontal_backporch_byte =3D
(vm->hback_porch * dsi_tmp_buf_bpp - 10);
else
horizontal_backporch_byte =3D ((vm->hback_porch + vm->hsync_len) *
dsi_tmp_buf_bpp - 10);

If this time it's negtive, the calculation of
horizontal_frontporch_byte is so strange.
I think processing negtive value should before here.

Regards,
Chun-Kuang.

>         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>         writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>         writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
> --
> 2.25.1
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
