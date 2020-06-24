Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC48EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+qiZfi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbgFXLYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390564AbgFXLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:24:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFF2C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:24:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so2145438wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NrvSiaDLXTBfKnuOt7hk8LUvf/vD6JGQ7WAbFA5i7Uc=;
        b=h+qiZfi0OhOnDkgTLpZizeUC5IOa97wx3ik8VofmQ5pfxMjOrV/QZdQ1bzH0PCVdiU
         UgreOMhRLysmM+bBtebPY7anIyh5Ho7OoqBtQmM4nX9hm9SZdRD6PwLqtvezCvD5x2bP
         yKLL3oYAOG9YVSUhAPv2B0YkFFu+XrIW2mOMZL0AxwspP7uIhMzfAKKRW5Sjn3PfuI7I
         8tUEK+4WbXF6HcnEghMiSEhm2Z6Z58auYOW96L/YLupOfUvseYw9YDjMWDUdRzEAqj/T
         mPxbp9qt//mWBrqgyYQmdqSzcji9eNyItiQcmo1Ts9oa2hmbhVVJiBaLSzhtiyZR1Cab
         UiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NrvSiaDLXTBfKnuOt7hk8LUvf/vD6JGQ7WAbFA5i7Uc=;
        b=bJJgtUTEfoLtG/vJFRSSzxdEAi5osV4mqAfAWiB1NQ72LiJHay+ReDB3pl/e6rgFqe
         Mp4MeFPEKeUnDuI7O4RLDCRb1o8GGGj1yL9tVkRZ+/9yQOQXz60maFUHqrNKJoI+jMe/
         BehsZQJJ1ozNXo4bRByqistlVvvoVWYZixMEu2n9o4Nr3oMFuObOTyI72jCMlKiR2C7Z
         jmmakYdEYHYx6/NzCsYqah1eyxPrcZSdXgsrBGFjwAvERr3hndoPA3QbFS5CxoP/34uA
         +yZoEh4DACfID1DQdVWQ4+OVrl1e6fxsE8RSMmj4RZuv6VEkxV7OTtqLIseF8xl6L/p5
         zI9A==
X-Gm-Message-State: AOAM5309Xl/efi5eaeEa2rT7/mDSi1I/hEpK3FvnvMJSShzQcbhJPpfc
        AkReiOXl8e0WBSPA6OfXHEUwNQ==
X-Google-Smtp-Source: ABdhPJxnvJ/bAKboWQS8u3ig+E2OSp3FrtA0y0gJWgzooZABsBXHuo/PhR/sGO75JnZcwGDW//Wkaw==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr8696211wmk.126.1592997857631;
        Wed, 24 Jun 2020 04:24:17 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x5sm7962485wmg.2.2020.06.24.04.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 04:24:16 -0700 (PDT)
Date:   Wed, 24 Jun 2020 12:24:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Frank Rowand <frowand.list@gmail.com>, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200624112414.GG954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <30f03734-61fd-1b6b-bf11-21b6423a7c50@gmail.com>
 <20200624064145.GC954398@dell>
 <7a31b34940984b3f0921ed2d4fb29a58@walle.cc>
 <20200624082352.GF954398@dell>
 <c0a8ebd32ae07ae98fa56728c77f8e79@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0a8ebd32ae07ae98fa56728c77f8e79@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Michael Walle wrote:

> Am 2020-06-24 10:23, schrieb Lee Jones:
> > On Wed, 24 Jun 2020, Michael Walle wrote:
> 
> [..]
> 
> > > Although Rob mentioned to maybe relax that, but I sill fail to see
> > > the advantage to have an arbitrary reg property instead of a unique
> > > node name.
> > 
> > I don't have a strong opinion either way.
> > 
> > We can *also* add node name matching if Rob deems it fit.
> 
> Where do you see a use of the reg property?

The vast proportion of devices do and will have 'reg' properties.

> You already expressed
> that you see exposing the internal offset as a hack:
> 
>  "Placing "internal offsets" into the 'reg' property is a hack." [1]
> 
> So what are you putting into reg instead? Rob suggested "anything"
> documented in the hardware manual. But isn't this just also something
> we make up and especially for the MFD driver. Thus IMHO it doesn't
> qualify as a unit-address, which - as far as I understand it - is
> unique on the parent bus. To repeat my argument, its not a defined
> thing like an I2C address.

So our argument in the past (although this is going back the best part
of 10 years) has always been that; if devices are different, there is
almost always a documented (in the H/W manual/datasheet) way to
differentiate/address them.  Whether that's a physical address, an
offset, a bank ID, an I2C/SPI address or whatever.

As to not being able to use that address/ID due to the DT rules
surrounding address space as per the example in your previous email,
well that's a rule specific to DT and makes little sense in some real
world cases (such as, dare I say it, the AB8500).

You'll have to take the aforementioned point and the point about using
node names instead of 'reg' properties up with Rob and the other
interested DT folk.

Again, I'm happy to extend that functionality if it becomes acceptable
practice.

> [1] https://lore.kernel.org/linux-devicetree/20200609185231.GO4106@dell/
> 
> -michael

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
