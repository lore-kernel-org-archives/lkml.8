Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F928C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A38C2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oBSA29ZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgGMHEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:04:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA505C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:04:08 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a1so15042746ejg.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9He2Y/cj2b1yofJp3r0tciWRU0GFm0a2fXfgV5d2ZsM=;
        b=oBSA29ZRXnyX5uNrdKdKimE/m7zWdZXNnhrXmKWKgnyN/SH230LhrcwzyL4D5IYCjQ
         q+j9awO4n+F2erswVyiQg/WMcIkxFh/IgNX4JZT8Q8aB3qp0IaeT4wjmr6f/xn1O58TX
         4LtOfoBBudGY9551aEhRNWgZVLL5lJSfEBVd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9He2Y/cj2b1yofJp3r0tciWRU0GFm0a2fXfgV5d2ZsM=;
        b=FMlJV2vfAdC+zopzUy4qHcXT9pTUs9/HmbLovFEUhCfArfBmSd27cliuJv5UYqsVoU
         4Y1MszZV4+J531JKCxEnVneJz7Y6Gim+CaGwpdFLnlgrHzxUF1XR3xuPVj36pZorMsvr
         AfrgYhOB5DqgvG5DXE4jrLwXILR5tme2PV+M6zQq1aRQPXn+OPrhp70bjodxmcKfgzP1
         OBb9mAJT/3oPYF1v4KZvK25MvnzAIag+i6bjxK3lP2Qu817kvAjLutth/wjBmpE2ojQh
         0MoO2OimubHp2w4JoXDt6rx63OmtB+JncgUi+d/PeBgHx8qPeyG7P/0DUiiOYDOq8SUn
         A7Ww==
X-Gm-Message-State: AOAM532ZFxqIwyaAZqnRDH3fo2GbZ6ZteHIdbwhWoC2l1zkS01O301ev
        a3aMVpdjUFYYO2WLfmCjCXsfBpxCOmVdNYiIlhsLcBPYZMs2bQ==
X-Google-Smtp-Source: ABdhPJxgek6wFGTNWYGWXYoVuA91A7Bl2JN7v5ipfo4T7zContyupAUFj7BG3ePmDatYcqA77vTV3vhHfoLVelT2s64=
X-Received: by 2002:a17:906:f117:: with SMTP id gv23mr43961935ejb.528.1594623847288;
 Mon, 13 Jul 2020 00:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200711064846.16007-1-yong.wu@mediatek.com> <20200711064846.16007-12-yong.wu@mediatek.com>
In-Reply-To: <20200711064846.16007-12-yong.wu@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 13 Jul 2020 15:03:31 +0800
Message-ID: <CANdKZ0e3=AeCxpSHVk7daUE01L7AgJYmZ7jeOQDT169SaowL-g@mail.gmail.com>
Subject: Re: [PATCH 11/21] iommu/mediatek: Add power-domain operation
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
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 2:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In the previous SoC, the M4U HW is in the EMI power domain which is
> always on. the latest M4U is in the display power domain which may be
> turned on/off, thus we have to add pm_runtime interface for it.
>
> we should enable its power before M4U hw initial. and disable it after HW
> initialize.
>
> When the engine work, the engine always enable the power and clocks for
> smi-larb/smi-common, then the M4U's power will always be powered on
> automatically via the device link with smi-common.
>
> Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
> If its power already is on, of course it is ok. if the power is off,
> the main tlb will be reset while M4U power on, thus the tlb flush while
> m4u power off is unnecessary, just skip it.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 54 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 7 deletions(-)
> ...
>         for_each_m4u(data) {
> +               /* skip tlb flush when pm is not active */
> +               if (pm_runtime_enabled(data->dev) &&
> +                   !pm_runtime_active(data->dev))
> +                       continue;
> +

pm_runtime_active(dev) == false implies dev->power.disable_depth == 0,
which implies pm_runtime_enabled(dev) == true, so the
pm_runtime_enabled(data->dev) can be omitted here.

>                 spin_lock_irqsave(&data->tlb_lock, flags);
>                 writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>                                data->base + data->plat_data->inv_sel_reg);
> ...
