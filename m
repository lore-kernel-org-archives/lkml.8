Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9565C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83F12072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967035;
	bh=12Z/1F9ynfQG7TePTBeyr3mih++Uy7SZRp4TeFeFs00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OonRDWSuRWmanSGcMd3aPzENNqQ8OaD94hT8DG1I4OjREHSCDrNT7NloRJGW6hDYr
	 v9Pptu66DPfxPnD8XgEPVrXPFKQqVG1fBnIkDoSlm/pCIdmmJCtkt9OKqXNnh0iH6P
	 AAFTA+AnySlR9F9YK9+e6Pm/3G7cU8ZZTdJ82Uq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgHTXny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTXnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:43:51 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6683321775;
        Thu, 20 Aug 2020 23:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597967030;
        bh=12Z/1F9ynfQG7TePTBeyr3mih++Uy7SZRp4TeFeFs00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zh7RPShu8RDbXHSq/oO4RIrP7wWBy3WN/odPT+2RPzaYmOP++iCWgSxuDuz7TTrd3
         u/rZq9S0bOYAjczwn4IXAUllxtXntn5divU1ss+SS2VPiDDLGc4BJDg+kWq9wRyLDd
         upGN6rew7AYY0LKvqeSxDvRU14iudWvSn7Kglwvw=
Received: by mail-ej1-f41.google.com with SMTP id jp10so268087ejb.0;
        Thu, 20 Aug 2020 16:43:50 -0700 (PDT)
X-Gm-Message-State: AOAM533FUdPUqyXbftGwAgsZAE9Qo45VS7wLhBtjoBhmgnSJih3YBYZA
        2clSOWRaoJznpiBflTkmFB/NNNoQqzsYWnE40Q==
X-Google-Smtp-Source: ABdhPJwvENKIDffOUlwzID4Z1RX/ZzTkvvhpMC6nA358MClEWoZg7KM+bFIxElWhuhPq+Q71kLgNBHiZNim6++NVVE4=
X-Received: by 2002:a17:906:7492:: with SMTP id e18mr178889ejl.375.1597967028984;
 Thu, 20 Aug 2020 16:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com> <1597903458-8055-8-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1597903458-8055-8-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:43:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8LnY3Tbzhmeia5DS7o1WAxd0kz9oVCeKLvwNCn48j_Dg@mail.gmail.com>
Message-ID: <CAAOTY_8LnY3Tbzhmeia5DS7o1WAxd0kz9oVCeKLvwNCn48j_Dg@mail.gmail.com>
Subject: Re: [PATCH v1 07/21] drm/mediatek: enable OVL_LAYER_SMI_ID_EN for
 multi-layer usecase
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

HI, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 8cf9f3b..427fe7f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -23,6 +23,7 @@
>  #define DISP_REG_OVL_RST                       0x0014
>  #define DISP_REG_OVL_ROI_SIZE                  0x0020
>  #define DISP_REG_OVL_DATAPATH_CON              0x0024
> +#define OVL_LAYER_SMI_ID_EN                            BIT(0)
>  #define OVL_BGCLR_SEL_IN                               BIT(2)
>  #define DISP_REG_OVL_ROI_BGCLR                 0x0028
>  #define DISP_REG_OVL_SRC_CON                   0x002c
> @@ -116,6 +117,8 @@ static void mtk_ovl_disable_vblank(struct mtk_ddp_com=
p *comp)
>  static void mtk_ovl_start(struct mtk_ddp_comp *comp)
>  {
>         writel_relaxed(0x1, comp->regs + DISP_REG_OVL_EN);
> +       mtk_ddp_write_mask(NULL, OVL_LAYER_SMI_ID_EN, comp,

writel_relaxed instead of mtk_ddp_write_mask.

> +                          DISP_REG_OVL_DATAPATH_CON, OVL_LAYER_SMI_ID_EN=
);

If this only should set in mt8192, add a private data to distinguish this.

Regards,
Chun-Kuang.

>  }
>
>  static void mtk_ovl_stop(struct mtk_ddp_comp *comp)
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
