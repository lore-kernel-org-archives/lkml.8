Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED8BC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFCA205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3HwZPSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgIHRfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbgIHQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC48C061796
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 04:48:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so386436wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MOD3myDX5YVgSCWPbOM0MI/Bz9e/gthofWOrn9GDODs=;
        b=w3HwZPSlAP6vTHgPGNbJ1UJODKPETw4ntd97KFSwYdtFeo7txe9ylUitmpfb1OFDYr
         lMPJwxe3ebtCFWxApnFbDkIH5PtVjy29un6eV91d+RqtiPphY/Swsgbhs6Netmj1fSkj
         C/XwUR8vXcbjJGjTBbExzhdeJlm4eDt62q2jPxc+kDuwAIGT8PxBSprcZPiUERYQfGuQ
         LhHTk4s/Av7zN2SuCGdpJmA5XljzsmHbkeOSZCZ0UCv7e16IkdI3Oo6CW+g5cDkmHW71
         pq88MXS6xJC++nxsjhnnxhqW9jmkHmsCdZXPj4meJubE2CIMNNgl/IM6pKMhKSLLDafz
         yvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MOD3myDX5YVgSCWPbOM0MI/Bz9e/gthofWOrn9GDODs=;
        b=Lb9yxwui3r/H+qLr7/IelxSv8XdS96l5zC728ZuLx9pvpdq+g7r/YsWUzc11dN6h0k
         TdwTId4A6QwBh9Rx9O1fI3UiutGlPVzPaA7aMUjEyTDZZNbSFayEX6f51kq+TjusllFm
         001JuYbFXs1PDkRzUiGHhL6Tyo6K5dtM/8ovKD+UY8/pLcKIsz+HDu0H6S/FIIofAOeW
         sr0qi0eww2Qcb4JzwFZOJOEl0DLwFgHlTImWuHQWeSwHIWaNhAet9zUGVLzMYlZ/PK+q
         LGlB9t9OSB0iVNSCT/lKtD3GeY2i9JZONbBBCaQr7bmlNAfoLBsTUkLlODlcORDX1xhb
         nW7w==
X-Gm-Message-State: AOAM533TcxJvgNmnb7p5boz1sny1KjQ/988sXMFTcs2DdqEHwuSqCTft
        FaPBeGm5D3glsm7mMsWQxZMtkg==
X-Google-Smtp-Source: ABdhPJwSUZRXvDpDN21AesLjjEhCOKb66RbXY49H7pR60AfMm3M/qabkE9LDWvxs/X+mLiKedGotbQ==
X-Received: by 2002:a5d:458e:: with SMTP id p14mr26713354wrq.61.1599565702035;
        Tue, 08 Sep 2020 04:48:22 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id i1sm40833436wrc.49.2020.09.08.04.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 04:48:21 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:48:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4 9/9] mfd: mt6360: Merge different sub-devices I2C
 read/write
Message-ID: <20200908114819.GO4400@dell>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597661277-27862-10-git-send-email-gene.chen.richtek@gmail.com>
 <20200828104053.GM1826686@dell>
 <CAE+NS37uFoDhWyGkw0WTu+tR+_85EwzYRqecNMG6nK6b2J=9jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS37uFoDhWyGkw0WTu+tR+_85EwzYRqecNMG6nK6b2J=9jg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Sep 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年8月28日 週五 下午6:40寫道：
> >
> > On Mon, 17 Aug 2020, Gene Chen wrote:
> >
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Remove unuse register definition.
> >
> > This should be in a separate patch.
> >
> > > Merge different sub-devices I2C read/write functions into one Regmap,
> > > because PMIC and LDO part need CRC bits for access protection.
> > >
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > ---
> > >  drivers/mfd/Kconfig        |   1 +
> > >  drivers/mfd/mt6360-core.c  | 260 +++++++++++++++++++++++++++++++++++++++------
> > >  include/linux/mfd/mt6360.h | 240 -----------------------------------------
> > >  3 files changed, 226 insertions(+), 275 deletions(-)
> > >  delete mode 100644 include/linux/mfd/mt6360.h
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index a37d7d1..0684ddc 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -913,6 +913,7 @@ config MFD_MT6360
> > >       select MFD_CORE
> > >       select REGMAP_I2C
> > >       select REGMAP_IRQ
> > > +     select CRC8
> > >       depends on I2C
> > >       help
> > >         Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
> > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > index 677c974..e995220 100644
> > > --- a/drivers/mfd/mt6360-core.c
> > > +++ b/drivers/mfd/mt6360-core.c
> > > @@ -14,7 +14,53 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/slab.h>
> > >
> > > -#include <linux/mfd/mt6360.h>
> > > +enum {
> > > +     MT6360_SLAVE_TCPC = 0,
> > > +     MT6360_SLAVE_PMIC,
> > > +     MT6360_SLAVE_LDO,
> > > +     MT6360_SLAVE_PMU,
> > > +     MT6360_SLAVE_MAX,
> > > +};
> > > +
> > > +struct mt6360_ddata {
> > > +     struct i2c_client *i2c[MT6360_SLAVE_MAX];
> > > +     struct device *dev;
> > > +     struct regmap *regmap;
> > > +     struct regmap_irq_chip_data *irq_data;
> > > +     unsigned int chip_rev;
> > > +     u8 crc8_tbl[CRC8_TABLE_SIZE];
> > > +};
> >
> > This is not a new structure, right?  Where was this before?  Surely it
> > should be removed from wherever it was in the same patch that places
> > it here?
> >
> 
> No, it is merge from header file to source code for unuse in other sub-module.

So where did it come from and why don't I see the removal in this
patch?

[...]

> > > -static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
> > > -     MT6360_PMU_SLAVEID,
> > > +static const u16 mt6360_slave_addrs[MT6360_SLAVE_MAX] = {
> >
> > Why are you changing the data type?
> >
> 
> Easy to read.
> I think it's the same?

It's an unrelated change and should not be in this patch.

Please separate patches into functional changes.

> > > +     MT6360_TCPC_SLAVEID,
> > >       MT6360_PMIC_SLAVEID,
> > >       MT6360_LDO_SLAVEID,
> > > -     MT6360_TCPC_SLAVEID,
> > > +     MT6360_PMU_SLAVEID,
> > > +};

[...]

> > >  static int mt6360_probe(struct i2c_client *client)
> > > @@ -329,9 +521,23 @@ static int mt6360_probe(struct i2c_client *client)
> > >               return -ENOMEM;
> > >
> > >       ddata->dev = &client->dev;
> > > -     i2c_set_clientdata(client, ddata);
> > >
> > > -     ddata->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
> > > +     for (i = 0; i < MT6360_SLAVE_MAX - 1; i++) {
> > > +             ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
> > > +                                                       client->adapter,
> > > +                                                       mt6360_slave_addrs[i]);
> > > +             if (IS_ERR(ddata->i2c[i])) {
> > > +                     dev_err(&client->dev,
> > > +                             "Failed to get new dummy I2C device for address 0x%x",
> > > +                             mt6360_slave_addrs[i]);
> > > +                     return PTR_ERR(ddata->i2c[i]);
> >
> > Do you have to free the new devices you just allocated?
> >
> 
> Usually no need to free devm_i2c_new_dummy_device,
> Should I use kfree(ddata->i2c[i]);?

You tell me.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
