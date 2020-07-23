Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4DEC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D1E206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUmgMVV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGWJes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGWJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:34:47 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5DFC0619DC;
        Thu, 23 Jul 2020 02:34:47 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t4so4437874oij.9;
        Thu, 23 Jul 2020 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUOZNRgi2WDMnJstl3822UZz6W+cTtqoXZUUjvczjxY=;
        b=GUmgMVV+0yJv2t6Z8/U6LiDv83RrL6WvPXQzaXMvqS8vXXLmonyC2f/sVYS5y3WgFS
         lu6rgCV0dSB57hhQ+zGsUtViwuNgLJ4Wm7qmLAjXmLIhYKs9InfY8Q9Mg0Z4buKJZJSH
         cnJDaPA48Vl9eEnM8CUeXSmvI0XU1x4mnwVY6JbJTdqm8hHXsl+0cSSgzHYC3UQRL7ek
         FGCLCU4pcz8f6uKd3GfUfubrL0znfhsRCvZCn+xxy/PGfjVBLt1c2u5H4VW4nwTojQti
         twT6bqpOGxsBkLp4efBZayJ0tWmfcim3ZSHR8XUttqsVtES8Gk6Km6KugjNGIC+F8vk6
         P6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUOZNRgi2WDMnJstl3822UZz6W+cTtqoXZUUjvczjxY=;
        b=Z6tb3doRHuU144pmrCJhF1+lNGD5IpuC2zGuL0k5akMbVcJVBFsoRdJ6q989w4kXZw
         nkR2HTpH/57h7J8sEv8LfGM9k2/fGZl7z1CHyWMr3xCkgsV0at9+onbGWa1H70oTgiu7
         3C6ms4pWMjizCsxPIvQ9EY4EsRvYmiYW3ZJnJg2qd5Lsys8m75NLWI2E+xDe/nEA2Xkt
         Z6f/plbKGntm5azU933HJwFcwFlwRQA+jFOX+sHNNgn0cKoMbkwJOM9f6TZf+PQipj7u
         X0/KW6d6y9mrvthoAMm7PwqqQcNBWQreffn5TpoRkiiQvBD5nbfPr4xEovHuxztMZA2d
         RklA==
X-Gm-Message-State: AOAM530bO4HtHMdfTyboL75o7+f4oFGyMSXzFbTwwDY7HFkP8Ol0OMl5
        dNzC6DbuR9hIyGEsp3IjTa3RtBlb46AstcnTdSQ=
X-Google-Smtp-Source: ABdhPJzgqe7CiGqbKBHmABe5mif7/AisJOSoULJ2y82Ij6b5HcCjs5bc/QhzNylG1ab4yxMZWRDIL9nHg85nK/H8kbk=
X-Received: by 2002:aca:ba45:: with SMTP id k66mr3149488oif.47.1595496887048;
 Thu, 23 Jul 2020 02:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com> <1595469798-3824-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1595469798-3824-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 23 Jul 2020 11:34:35 +0200
Message-ID: <CAFqH_50=MkBLHJ23hJo--RG=4560ttOUOjHuEwpevghFZ59xQQ@mail.gmail.com>
Subject: Re: [v7, PATCH 1/7] drm/mediatek: move ddp component defint into mtk_mmsys.h
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongqian Niu,

Thank you for your patch

Missatge de Yongqiang Niu <yongqiang.niu@mediatek.com> del dia dj., 23
de jul. 2020 a les 4:05:
>
> move ddp component defint into mtk_mmsys.h
>

There is a typo, should be "defines". But why you should move these
defines to mtk-mmsys?



> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 34 +----------------------------
>  drivers/soc/mediatek/mtk-mmsys.c            |  4 +---
>  include/linux/soc/mediatek/mtk-mmsys.h      | 33 ++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index debe363..161201f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -7,6 +7,7 @@
>  #define MTK_DRM_DDP_COMP_H
>
>  #include <linux/io.h>
> +#include <linux/soc/mediatek/mtk-mmsys.h>
>
>  struct device;
>  struct device_node;
> @@ -35,39 +36,6 @@ enum mtk_ddp_comp_type {
>         MTK_DDP_COMP_TYPE_MAX,
>  };
>
> -enum mtk_ddp_comp_id {
> -       DDP_COMPONENT_AAL0,
> -       DDP_COMPONENT_AAL1,
> -       DDP_COMPONENT_BLS,
> -       DDP_COMPONENT_CCORR,
> -       DDP_COMPONENT_COLOR0,
> -       DDP_COMPONENT_COLOR1,
> -       DDP_COMPONENT_DITHER,
> -       DDP_COMPONENT_DPI0,
> -       DDP_COMPONENT_DPI1,
> -       DDP_COMPONENT_DSI0,
> -       DDP_COMPONENT_DSI1,
> -       DDP_COMPONENT_DSI2,
> -       DDP_COMPONENT_DSI3,
> -       DDP_COMPONENT_GAMMA,
> -       DDP_COMPONENT_OD0,
> -       DDP_COMPONENT_OD1,
> -       DDP_COMPONENT_OVL0,
> -       DDP_COMPONENT_OVL_2L0,
> -       DDP_COMPONENT_OVL_2L1,
> -       DDP_COMPONENT_OVL1,
> -       DDP_COMPONENT_PWM0,
> -       DDP_COMPONENT_PWM1,
> -       DDP_COMPONENT_PWM2,
> -       DDP_COMPONENT_RDMA0,
> -       DDP_COMPONENT_RDMA1,
> -       DDP_COMPONENT_RDMA2,
> -       DDP_COMPONENT_UFOE,
> -       DDP_COMPONENT_WDMA0,
> -       DDP_COMPONENT_WDMA1,
> -       DDP_COMPONENT_ID_MAX,
> -};
> -
>  struct mtk_ddp_comp;
>  struct cmdq_pkt;
>  struct mtk_ddp_comp_funcs {
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index a55f255..36ad66b 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -5,13 +5,11 @@
>   */
>
>  #include <linux/device.h>
> +#include <linux/io.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/soc/mediatek/mtk-mmsys.h>
>
> -#include "../../gpu/drm/mediatek/mtk_drm_ddp.h"
> -#include "../../gpu/drm/mediatek/mtk_drm_ddp_comp.h"
> -
>  #define DISP_REG_CONFIG_DISP_OVL0_MOUT_EN      0x040
>  #define DISP_REG_CONFIG_DISP_OVL1_MOUT_EN      0x044
>  #define DISP_REG_CONFIG_DISP_OD_MOUT_EN                0x048
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index 7bab5d9..2228bf6 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -9,6 +9,39 @@
>  enum mtk_ddp_comp_id;
>  struct device;
>
> +enum mtk_ddp_comp_id {
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_AAL1,
> +       DDP_COMPONENT_BLS,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_COLOR1,
> +       DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_DPI0,
> +       DDP_COMPONENT_DPI1,
> +       DDP_COMPONENT_DSI0,
> +       DDP_COMPONENT_DSI1,
> +       DDP_COMPONENT_DSI2,
> +       DDP_COMPONENT_DSI3,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_OD0,
> +       DDP_COMPONENT_OD1,
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_OVL_2L0,
> +       DDP_COMPONENT_OVL_2L1,
> +       DDP_COMPONENT_OVL1,
> +       DDP_COMPONENT_PWM0,
> +       DDP_COMPONENT_PWM1,
> +       DDP_COMPONENT_PWM2,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_RDMA1,
> +       DDP_COMPONENT_RDMA2,
> +       DDP_COMPONENT_UFOE,
> +       DDP_COMPONENT_WDMA0,
> +       DDP_COMPONENT_WDMA1,
> +       DDP_COMPONENT_ID_MAX,
> +};
> +
>  void mtk_mmsys_ddp_connect(struct device *dev,
>                            enum mtk_ddp_comp_id cur,
>                            enum mtk_ddp_comp_id next);
> --
> 1.8.1.1.dirty
