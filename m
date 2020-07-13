Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFD7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7660A20720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mn5gncYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgGMHe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:34:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1511C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:34:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so15257890ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mv5WdsbJHcmRfr1CWAqVLgCzyD2WDHyCcH3cW9CT870=;
        b=mn5gncYvlT0Ikasjdu4y+nGbhp8qf0g/S/fJiCGf6woiq1WyBZiFigDT3Qp1D2tYTI
         pmW6YdaDNjwHR3PrL+IiKlbCPjioM14hSjLWkaH1Hv6Cac70Zw6Oxga2x9v5s8SMy/5x
         GmsD0Ru1j+a4thlGopDDg3e8+Sd1/EIjJPBh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mv5WdsbJHcmRfr1CWAqVLgCzyD2WDHyCcH3cW9CT870=;
        b=VQ1n/+RmV/IdYdjgBXSBBiV0w3fc0ne2DmuRWeknKRwCqMnYKs6lT0zmcpAHRZaXrI
         ABAywKenS/KKdnGiXSDdUk9KYigKJy95RLiWqak2yOpGP0w3MURyhyTwmq2OV5zgMNPG
         XRNEox3FB1GisPZnGRIWlAZZCLdh4oanIFio4epZ+xKUIEv2JTPSiPCQHZ0zT6Wh0wgX
         mO6bvnG/XK7Hv4FXS5KIg1SIkfv/hB0RA9FroKNz9pmn9OWD3SF3GY6ldN4RzItxxVZ7
         mQIiIMMYvYdJfWxG2bnspin5M5AJRjFNqwLF4MaF3W/f/UFOo78SSUFzirv+M3eAl6qw
         1DRw==
X-Gm-Message-State: AOAM532kfCGh8YaRl1qA8ww3Urq5usj8CjrpYafKK/ZUqF3FCjy/CQbL
        /rJdanKtAOyAsTKx/Ny4qmT60xs6WQTZZ+GWYZ9ajQ==
X-Google-Smtp-Source: ABdhPJz7YORADPzpZtFVoxEClRzjUf3OF/9u0ANmR6SeAWwU4pfqH4KGc+q797K0VN2/NzCee6zahEJc92V4Gk3su/c=
X-Received: by 2002:a17:906:1db1:: with SMTP id u17mr64544271ejh.72.1594625666473;
 Mon, 13 Jul 2020 00:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200711064846.16007-1-yong.wu@mediatek.com> <20200711064846.16007-13-yong.wu@mediatek.com>
In-Reply-To: <20200711064846.16007-13-yong.wu@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 13 Jul 2020 15:33:50 +0800
Message-ID: <CANdKZ0d8CSWQepCj9RFFxrvYq8K8G=oZCnskRiA3aY3gY-DD=w@mail.gmail.com>
Subject: Re: [PATCH 12/21] iommu/mediatek: Add iova reserved function
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Hao Chao <hao.chao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 2:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> For multiple iommu_domains, we need to reserve some iova regions, so we
> will add mtk_iommu_iova_region structure. It includes the base address
> and size of the range.
> This is a preparing patch for supporting multi-domain.
>
> Signed-off-by: Anan sun<anan.sun@mediatek.com>
> Signed-off-by: Hao Chao<hao.chao@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/mtk_iommu.h |  5 +++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 03a6d66f4bef..fdfdb75706e0 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -151,6 +151,11 @@ static LIST_HEAD(m4ulist); /* List all the M4U HWs */
> ...
> +
> +static void mtk_iommu_put_resv_regions(struct device *dev,
> +                                      struct list_head *head)
> +{
> +       struct iommu_resv_region *entry, *next;
> +
> +       list_for_each_entry_safe(entry, next, head, list)
> +               kfree(entry);
> +}
> +

This is the same as generic_iommu_put_resv_regions, use that as the
.put_resv_regions callback instead?

> ...
> --
> 2.18.0
