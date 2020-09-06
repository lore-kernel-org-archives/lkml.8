Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA53CC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8B120714
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hyT1PpOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgIFPXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgIFPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:22:41 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10F3C061574
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 08:22:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t16so10365978ilf.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwN/BVu2qRKl2g6ZpjOhiQKz73AB4SfyAtuVoOPIeRA=;
        b=hyT1PpOwkbC8e2AEOu/g9Z60NoTSWolqKqKILsHgaokzrv9DdzWF0iGZC3eIzCBK6D
         mjAV6ZT2C9Vxh1Ly7plpKR9in9PGAr0OEPu+GfdJwmNnPeW0Dd3/ZQzAc66HYh71aN5C
         VMfFGFfcDlIVIrRL1ePqttKFQ8qYgoqpHy8PXzMGR/gYqjK1Qpv8zkGw2kUyK/2HoiD2
         VwYvqKKAGM0Zf21f+GjMTO1todjKALyPIATfQQRalp63mcX01/Jwa3v1QyCeUgemW6VI
         XKlHKjJMx4dpYPWcKV5ts7aO03e7y9HLhoDz5h9FvJKcMQt7mUFEElQYlObrgEwpsp4N
         gXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwN/BVu2qRKl2g6ZpjOhiQKz73AB4SfyAtuVoOPIeRA=;
        b=oDN3e6GUg9uulhZdK5l/SwhMom4BfQch1ajgdXvZN8glaMpPqjB/z/1WltlLadpRWO
         dDUoBI7Pg9NyIJ+Vm7eh2JwVMqUVUn7KvDSTlaZdFrjDmgzO9li5r7iXZtpatspAWuaS
         oyN7psUb8pcLqHaD+iZmLcqJtLZoWC1SsvI2RUFwEx5pJ9FUA+UAxbv7OopBJ+FAtrt9
         oyj1nbRrY3HzdbagqL2VVOknHeT5LYU2fxROroSMKfBe6jVyaa/MSdsZKilvSBPdrusC
         PKR/5lbyAuv2XJ6uE+co0Z6uglzVfDAWmByNPEROTj5MQE5R7hHaerLiPkqGangxiJ1g
         SpwQ==
X-Gm-Message-State: AOAM532PDi2e510XXyH4Z642yW4dA+1hPEm9CB2EcfF484kPIZe7gZ+x
        cMIM2h4hHD0dEzxCNUbqv/8hcoDPt5fr+0EVLNz7nQ==
X-Google-Smtp-Source: ABdhPJzKi00xRmsMGDFQSGHtnb/nykiYPK9LVtj52+aSMZYX3f63ZtwA74l54mZTa9IRhJphwOhsRh/ztDf7FIB2f5s=
X-Received: by 2002:a92:d8c2:: with SMTP id l2mr16266090ilo.301.1599405746941;
 Sun, 06 Sep 2020 08:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200906151928.881209-1-fparent@baylibre.com> <20200906151928.881209-3-fparent@baylibre.com>
In-Reply-To: <20200906151928.881209-3-fparent@baylibre.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Sun, 6 Sep 2020 17:22:16 +0200
Message-ID: <CAOwMV_xzeTXjvay32av9buJeJzSewnOGVWNdte8r-awiQr148g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iommu/mediatek: add support for MT8167
To:     iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     joro@8bytes.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, yong.wu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 6, 2020 at 5:19 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add support for the IOMMU on MT8167
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> V3:
>         * use LEGACY_IVRP_PADDR flag instead of using a platform data member

Forgot to mention a change here: .larbid_remap has been fixed to only
contain the number of larb present on MT8167

> V2:
>         * removed if based on m4u_plat, and using instead the new
>           has_legacy_ivrp_paddr member that was introduced in patch 2.
>
> ---
>  drivers/iommu/mtk_iommu.c | 8 ++++++++
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index b1f85a7e9346..6079f6a23c74 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -817,6 +817,13 @@ static const struct mtk_iommu_plat_data mt6779_data = {
>         .larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
>  };
>
> +static const struct mtk_iommu_plat_data mt8167_data = {
> +       .m4u_plat     = M4U_MT8167,
> +       .flags        = HAS_4GB_MODE | RESET_AXI | HAS_LEGACY_IVRP_PADDR,
> +       .inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +       .larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
> +};
> +
>  static const struct mtk_iommu_plat_data mt8173_data = {
>         .m4u_plat     = M4U_MT8173,
>         .flags        = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> @@ -835,6 +842,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>         { .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>         { .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
> +       { .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>         { .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>         { .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>         {}
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 122925dbe547..df32b3e3408b 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,6 +39,7 @@ enum mtk_iommu_plat {
>         M4U_MT2701,
>         M4U_MT2712,
>         M4U_MT6779,
> +       M4U_MT8167,
>         M4U_MT8173,
>         M4U_MT8183,
>  };
> --
> 2.28.0
>
