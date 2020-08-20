Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A5FC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D7C2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597966615;
	bh=zu6dDzfaquWSp2uUIMe35Em3fehg9+BJA+WpR/RQhd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DZDAAur43LrE4fpyIz2LNtki4ajw67fOPGtG9lQ6yHTWPWcIQQNmqvaxpXqGvbrNY
	 O5r2GtFHMCFTI+jgimvJYj+WICW1mTihV6u05w3gUS3oPySPOF+VMJLyjDL0Uwlbbb
	 UKq5XCqGsupuAiFowj17/8k+m+8ccYOW0x1VGqOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgHTXgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTXgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:36:53 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FAC82072D;
        Thu, 20 Aug 2020 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597966612;
        bh=zu6dDzfaquWSp2uUIMe35Em3fehg9+BJA+WpR/RQhd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VEp+3KyFjIwmu94z64ixA9Rrr71Jh6bFYApt+fq5Yn83IVa6pSFmfxSjLg27DtpYJ
         MtH+SJNf7631QI2iX7KMdCBfLWPWfyLokEuxCHD0w6eZ4iZ0Yl2x3yudQogSPs6cwO
         QV3wWok7jElKGlv57eg1w/yIaeNreCgJiIoli6cE=
Received: by mail-ed1-f53.google.com with SMTP id w2so5406edv.7;
        Thu, 20 Aug 2020 16:36:52 -0700 (PDT)
X-Gm-Message-State: AOAM532PyuJRX80RaGVIyawLqoRQwwU9SH4qxVUQPZNXmQwnVgaskPc2
        pGXZvsX4NmGPMH+91Ol1mjwk9EmCoI8eq7z+Kw==
X-Google-Smtp-Source: ABdhPJyBSJx3TcHZvu2J+XPfgaFyiT8RjUUAgdQ/KuzhMeixYVHxkITA+AkOph4jNHOhS8/2MYeaprdPdiaDkfm4vDY=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr309611edb.48.1597966610947;
 Thu, 20 Aug 2020 16:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com> <1597903458-8055-6-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1597903458-8055-6-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:36:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8rqu4_yVPVCCpyQjognDP0jK=wTr2rFw0WjjY=dzkHHg@mail.gmail.com>
Message-ID: <CAAOTY_8rqu4_yVPVCCpyQjognDP0jK=wTr2rFw0WjjY=dzkHHg@mail.gmail.com>
Subject: Re: [PATCH v1 05/21] mtk-mmsys: add ovl mout on support
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
=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:16=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add ovl mout on support
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/mmsys/mt8192-mmsys.c | 23 +++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c          |  8 ++++++++
>  include/linux/soc/mediatek/mtk-mmsys.h    |  3 +++
>  3 files changed, 34 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mmsys/mt8192-mmsys.c b/drivers/soc/medi=
atek/mmsys/mt8192-mmsys.c
> index 006d41d..06080ad 100644
> --- a/drivers/soc/mediatek/mmsys/mt8192-mmsys.c
> +++ b/drivers/soc/mediatek/mmsys/mt8192-mmsys.c
> @@ -134,10 +134,33 @@ static void mtk_mmsys_ddp_sout_sel(void __iomem *co=
nfig_regs,
>         }
>  }
>
> +static int mtk_mmsys_ovl_mout_en(enum mtk_ddp_comp_id cur,
> +                                enum mtk_ddp_comp_id next,
> +                                unsigned int *addr)
> +{
> +       int value =3D -1;
> +
> +       *addr =3D MT8192_MMSYS_OVL_MOUT_EN;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL0 && next =3D=3D DDP_COMPONENT_OV=
L_2L0)
> +               value =3D DISP_OVL0_GO_BG;
> +       else if (cur =3D=3D DDP_COMPONENT_OVL_2L0 && next =3D=3D DDP_COMP=
ONENT_OVL0)
> +               value =3D DISP_OVL0_2L_GO_BG;
> +       else if (cur =3D=3D DDP_COMPONENT_OVL0)
> +               value =3D DISP_OVL0_GO_BLEND;
> +       else if (cur =3D=3D DDP_COMPONENT_OVL_2L0)
> +               value =3D DISP_OVL0_2L_GO_BLEND;
> +       else
> +               value =3D -1;
> +
> +       return value;
> +}
> +
>  static struct mtk_mmsys_conn_funcs mmsys_funcs =3D {
>         .mout_en =3D mtk_mmsys_ddp_mout_en,
>         .sel_in =3D mtk_mmsys_ddp_sel_in,
>         .sout_sel =3D mtk_mmsys_ddp_sout_sel,
> +       .ovl_mout_en =3D mtk_mmsys_ovl_mout_en,
>  };
>
>  static int mmsys_probe(struct platform_device *pdev)
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 828d59e..1362d01 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -76,6 +76,14 @@ void mtk_mmsys_ddp_connect(struct device *dev,
>                 reg =3D readl_relaxed(config_regs + addr) | value;
>                 writel_relaxed(reg, config_regs + addr);
>         }
> +
> +       if (priv_funcs->ovl_mout_en) {
> +               value =3D priv_funcs->ovl_mout_en(cur, next, &addr);
> +               if (value >=3D 0) {
> +                       reg =3D readl_relaxed(config_regs + addr) | value=
;
> +                       writel_relaxed(reg, config_regs + addr);
> +               }
> +       }

I would like to do routing control like [1].

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/2345186

Regards,
Chun-Kuang.

>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 8ef3eaa..eefc7b1 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -55,6 +55,9 @@ struct mtk_mmsys_conn_funcs {
>         void (*sout_sel)(void __iomem *config_regs,
>                          enum mtk_ddp_comp_id cur,
>                          enum mtk_ddp_comp_id next);
> +       int (*ovl_mout_en)(enum mtk_ddp_comp_id cur,
> +                          enum mtk_ddp_comp_id next,
> +                          unsigned int *addr);
>  };
>
>  void mtk_mmsys_register_conn_funcs(struct device *dev,
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
