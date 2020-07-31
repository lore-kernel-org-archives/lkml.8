Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E49C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF092072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Un/qHsaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgGaJGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbgGaJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:06:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:06:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so27275977wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lfnkQfm3GKzU95XwF2JxhE5x/N3AyvhM1u96HkPpQ6s=;
        b=Un/qHsajtmNjsOmCb2mnNKCZnsB5UPu6XobhVc6xxd3nqxAzWj6t50hCNgEd4vTdGo
         mvJ1bgtAOIVAMdbh82+osjwh9TPvAkn4Ge781EHgqcOq3+EeXqkni0j0/1htkPAbUj5f
         OhrmFEFapzJ0E1to8b0HIKVZ1GQ1szmMS57VdH43oD25bjccRrDHN4W+zbI6C09/k3z0
         PDA5t/WdD8bG6gtLLQxi7EJjzT7p72J8GxdLyc81X7vGZMx3UwyiSaXF+/INF6PpgVUY
         lVsmFIihfDiCS9C4xNgXsYX2hHO/4x7e93WW7twv+zu/pZ5PRfmj4pyHC7kciNooqtIf
         WGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lfnkQfm3GKzU95XwF2JxhE5x/N3AyvhM1u96HkPpQ6s=;
        b=JpFHg9Wk2nWZi3AD9hkWuh2rNsCziO/1MhvlUI/U5EXVGMQMk4p4nh3GEzdXj0hfYi
         DztcaANT3aoVZb9iuQLd2RM4aD90ZujAjLrnDxOvX6DZBCAz3aZdRSW4ou7Pk6CNZU8b
         sTj6GUu9uzgxCoo2o8NOrEj4gvNzIcjjrRKQWDhZhSh/v2yiIXuXdu3pAPSpz2lrlyhw
         Ffj19rTAxQaGNBb9j25wERwECXAp1Z2u8gKKRbmTRNIeqv2ZIaT060czjR+7JDl5f/br
         wCu9fTttXi5hpUoJW/FxLQB/QIOWZJY4r/QjEDhnj1oid41eoJ5Ne8d1Di7TKcFF15v0
         0GRg==
X-Gm-Message-State: AOAM530mP1G7bb3FvXMPQdfC9kiBZn6v+3g0L2heQFOVJSQ1N+NCw1S8
        aVgJ/LqGTgUI3lzh921S2zaJJA==
X-Google-Smtp-Source: ABdhPJxvvy10AX5J00BsA51P9Ib9neAMULoBhvxJmXpVuThEekQJMPq47kHsZzAyKsIgo2uMvjo84w==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr2555849wru.211.1596186377988;
        Fri, 31 Jul 2020 02:06:17 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id c24sm13316548wrb.11.2020.07.31.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 02:06:17 -0700 (PDT)
Date:   Fri, 31 Jul 2020 10:06:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 9/9] mfd: mt6360: Merge different sub-devices i2c
 read/write
Message-ID: <20200731090615.GK2419169@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-10-git-send-email-gene.chen.richtek@gmail.com>
 <20200727124306.GP1850026@dell>
 <CAE+NS354H-j5UKa+JxHzvwinpPN9QR176ugFVt+UYyJFsOMg0w@mail.gmail.com>
 <20200729101244.GH2419169@dell>
 <CAE+NS37hURYnWqsewnc+T9yn62pFdSHUTqL4BvdsH_3mRf6Yrg@mail.gmail.com>
 <CAE+NS35bHQkiQroRGOWGNv_jbCiW6p4FfwJXNieEuN40YHdf_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS35bHQkiQroRGOWGNv_jbCiW6p4FfwJXNieEuN40YHdf_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > > > +static const struct regmap_bus mt6360_regmap_bus = {
> > > > > > +     .read           = mt6360_regmap_read,
> > > > > > +     .write          = mt6360_regmap_write,
> > > > > > +
> > > > > > +     /* due to pmic and ldo crc access size limit */
> > > > > > +     .max_raw_read   = 4,
> > > > > > +     .max_raw_write  = 4,
> > > > > > +};
> > > > >
> > > > > Why isn't all of the above in a Regmap driver?
> > > > >
> > > >
> > > > Do you means split out like drivers/base/regmap/regmap-ac97.c?
> > >
> > > Yes, I do.
> > >
> > > [...]
> > >
> >
> > ACK
> >
> 
> After I implement first version of regmap-mt6360.c, I found out ac97
> is a intel standard codec.
> If device follow this spec, it can reuse this api.
> But regmap-mt6360.c may single use only.
> should I try sending patch once to regmap reviewer?

Single use is okay.  Putting Regmap code into MFD is not okay.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
