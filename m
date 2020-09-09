Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D38C2D0A8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11ED120732
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKfNkPvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgIIHhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbgIIHhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:37:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F5C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:37:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so1812837wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wWgDfU9nZzKqdvbVx8y3VyybzRdiTj4qfLQtg4MRrko=;
        b=vKfNkPvSqiCi09QBOevuKE3WTzNxDu6Exs/ueisabXStQuSK3AB5ekMSlyhO5Ekvzn
         Qd42VrxYIuys9XrdUyMAgBTxiOfliJDL/us5t5yVi/CRjDKifwYXMMWmsN6IENcrBNn0
         2u8lOJf7c5sdSWLaXG0j1K1QdQv4UacDhefcSjtVSzcPgMBw8i7Y0T/8F8iaeOaJBbOC
         3HmFIgTcbFfE1C1wPpIcIN6tQoefM20O7EQEn6KaMJVASgtpOz3Z/0JtPUDnMhAB31Ou
         wuNA7DVOA9MllnqftEPlF8ZOYjL6ksA2pJQPP8YeU0qTjxikv/kDs9yYbovFv+EyyUnz
         xU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wWgDfU9nZzKqdvbVx8y3VyybzRdiTj4qfLQtg4MRrko=;
        b=AfeI9zOZmpJKo7/kbgeJskOQVDrVxUHIWOUGGmw3+BdMpUBz/qGs4v9gdegVmseawT
         t+6jk+qwTh5Vv72R6TWknN2WHJg3xcS3uBpeUlspoFhJq+MoMOgt8X8wwEaFgsDidaSV
         WqQSdXfh2CF5IgNQcOYCss+DyT+Ggbko/iNjpQzyuhAsZxYI+q+CU3jt7lAegNXmGukq
         ZbJf64DmQ4NPXC2U+RTA2atlT41Yu4RfFXKLA2ZpCwALWZU2dLfvVnOsJHyEcE39qHUf
         6v/EC/NZvfgoqao23d9yUmAFvwo2beQySuNmsZUM4LZIQIL8jPoYeIFTtVy8o9ePdnOm
         i/lQ==
X-Gm-Message-State: AOAM531bm4bZqmq5WZfaIcvf0X3wpWyTgCg82cqGDLGW/lWO2UVwlemo
        bsGFGUUbP7jqhAZ0LE36AApWoA==
X-Google-Smtp-Source: ABdhPJzwqJgPmAj9vMXTqolup+yM+UOmHtcxAg+FNcdJ6X/69jQchDfjUR+5dlw1mGEfxngwZltkHQ==
X-Received: by 2002:adf:e391:: with SMTP id e17mr2316189wrm.289.1599637022185;
        Wed, 09 Sep 2020 00:37:02 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id 91sm3266190wrq.9.2020.09.09.00.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:37:01 -0700 (PDT)
Date:   Wed, 9 Sep 2020 08:36:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4 9/9] mfd: mt6360: Merge different sub-devices I2C
 read/write
Message-ID: <20200909073659.GA218742@dell>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597661277-27862-10-git-send-email-gene.chen.richtek@gmail.com>
 <20200828104053.GM1826686@dell>
 <CAE+NS37uFoDhWyGkw0WTu+tR+_85EwzYRqecNMG6nK6b2J=9jg@mail.gmail.com>
 <20200908114819.GO4400@dell>
 <CAE+NS36MVA=9e0Ev73gpJ-gOcY+_aNveTr+DhquD6iqY-GKXCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS36MVA=9e0Ev73gpJ-gOcY+_aNveTr+DhquD6iqY-GKXCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Sep 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年9月8日 週二 下午7:48寫道：
> >
> > On Tue, 01 Sep 2020, Gene Chen wrote:
> >
> > > Lee Jones <lee.jones@linaro.org> 於 2020年8月28日 週五 下午6:40寫道：
> > > >
> > > > On Mon, 17 Aug 2020, Gene Chen wrote:
> > > >
> > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > >
> > > > > Remove unuse register definition.
> > > >
> > > > This should be in a separate patch.
> > > >
> > > > > Merge different sub-devices I2C read/write functions into one Regmap,
> > > > > because PMIC and LDO part need CRC bits for access protection.
> > > > >
> > > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > > ---
> > > > >  drivers/mfd/Kconfig        |   1 +
> > > > >  drivers/mfd/mt6360-core.c  | 260 +++++++++++++++++++++++++++++++++++++++------
> > > > >  include/linux/mfd/mt6360.h | 240 -----------------------------------------
> > > > >  3 files changed, 226 insertions(+), 275 deletions(-)
> > > > >  delete mode 100644 include/linux/mfd/mt6360.h
> > > > >
> > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > index a37d7d1..0684ddc 100644
> > > > > --- a/drivers/mfd/Kconfig
> > > > > +++ b/drivers/mfd/Kconfig
> > > > > @@ -913,6 +913,7 @@ config MFD_MT6360
> > > > >       select MFD_CORE
> > > > >       select REGMAP_I2C
> > > > >       select REGMAP_IRQ
> > > > > +     select CRC8
> > > > >       depends on I2C
> > > > >       help
> > > > >         Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
> > > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > > > index 677c974..e995220 100644
> > > > > --- a/drivers/mfd/mt6360-core.c
> > > > > +++ b/drivers/mfd/mt6360-core.c
> > > > > @@ -14,7 +14,53 @@
> > > > >  #include <linux/regmap.h>
> > > > >  #include <linux/slab.h>
> > > > >
> > > > > -#include <linux/mfd/mt6360.h>
> > > > > +enum {
> > > > > +     MT6360_SLAVE_TCPC = 0,
> > > > > +     MT6360_SLAVE_PMIC,
> > > > > +     MT6360_SLAVE_LDO,
> > > > > +     MT6360_SLAVE_PMU,
> > > > > +     MT6360_SLAVE_MAX,
> > > > > +};
> > > > > +
> > > > > +struct mt6360_ddata {
> > > > > +     struct i2c_client *i2c[MT6360_SLAVE_MAX];
> > > > > +     struct device *dev;
> > > > > +     struct regmap *regmap;
> > > > > +     struct regmap_irq_chip_data *irq_data;
> > > > > +     unsigned int chip_rev;
> > > > > +     u8 crc8_tbl[CRC8_TABLE_SIZE];
> > > > > +};
> > > >
> > > > This is not a new structure, right?  Where was this before?  Surely it
> > > > should be removed from wherever it was in the same patch that places
> > > > it here?
> > > >
> > >
> > > No, it is merge from header file to source code for unuse in other sub-module.
> >
> > So where did it come from and why don't I see the removal in this
> > patch?
> >
> 
> Change is in the bottom of this patch.
> There is a little confuse part in "[PATCH v4 5/9] mfd: mt6360: Rename
> mt6360_pmu_data by mt6360_ddata"
> The "PATCH 5/9" change mt6360_pmu_data to mt6360_ddata instead of mt6360_data.
> I will update PATCH v5 to fix it.
> 
> [PATCH v4 9/9]
> diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> -struct mt6360_data {
> -       struct i2c_client *i2c[MT6360_SLAVE_MAX];
> -       struct device *dev;
> -       struct regmap *regmap;
> -       struct regmap_irq_chip_data *irq_data;
> -       unsigned int chip_rev;
> -};
> 
> [PATCH v4 5/9]
> diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> -struct mt6360_pmu_data {
> +struct mt6360_data {
>         struct i2c_client *i2c[MT6360_SLAVE_MAX];
>         struct device *dev;
>         struct regmap *regmap;

Oh, you've renamed it whilst moving it.  That is probably not best
practise, as it causes this kind of confusion.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
