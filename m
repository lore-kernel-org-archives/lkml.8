Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAD1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA76C2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqnt56rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgFSGlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgFSGlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 02:41:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6122FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 23:41:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d128so8018579wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 23:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zjTgpvlZoTMqly8ZeswQThHMqwpruwtDmzNEvVZw/qQ=;
        b=vqnt56rMvv8CFA31p493VSrcPev/9lBxJ3mwGDNEJqQ+Q69v+8vNZw5F8G7bzOo7Kg
         rlOqJYsSlI/Cu98RDZCPCxqTCaGNDdGEGEOvLAOdQF6juGmAxXhjvsJUkhC0rjBMZJPn
         YEpxOrDp8z7X1s/bGM8yYn89B2lnKhUh3aCXBe8RsevQ1AyrZ2KfOdvIm/NL7zi5DNW1
         vk7ymnv5xLKTPW8MeoDMv+rmL6wC6QSu7SxTSllIltkBT3dqCkBZZTdniAYENrNMQsTg
         L/4FghH8cUAe7L2LnvldLWprP8X1EOwrJuPRPykpeUK6xwEzr43RCrU0h1dm46SvwR2V
         f50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zjTgpvlZoTMqly8ZeswQThHMqwpruwtDmzNEvVZw/qQ=;
        b=pGTNTTT/GvsWRIgy6eMEPx1hTFPTga8rdLEVm+i95r/EROhEAJ1FUum+jA64C5pAks
         HJSywm12NjgeMeEHvU3qoF4AYI/S2VcTBfmpv2vFLa3YjfvGYlreQhAQ6IEJYm4QtUNw
         HVAZuYcfsnIEQDJo7JcXMnhJEGjtKky5599mEsIPyDKb8htKMbOXNbNclbOcHb23DqPs
         HiKodZddQqmfUYjd697KypLHuM76KKc5/O8OrEvn7pqcm7jGznsePum9Pbca5JWACsHl
         ydi4pT/Ai7dfuZ5UwDejn7JOnxrcgzZMx2hPFhyPtknCrxAqIKoHWXnzRl9gp9otu1Xo
         uwLA==
X-Gm-Message-State: AOAM531yDPpFHpzaqQOHVXhuMiGwSHYMMWvmuZy4N3+v8vqV/C8YQFEk
        dtQudU6FtWb8m3wS1cbd3eZFUQ==
X-Google-Smtp-Source: ABdhPJxLzoPL6ztzrQ12+0O9ZkYOHQowqhk0hClejeA2lTwZpJsYkV7bKmLIgtLySZqrkaKQ6wd8Ng==
X-Received: by 2002:a1c:4189:: with SMTP id o131mr2164427wma.110.1592548903958;
        Thu, 18 Jun 2020 23:41:43 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f11sm6157182wrj.2.2020.06.18.23.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 23:41:43 -0700 (PDT)
Date:   Fri, 19 Jun 2020 07:41:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, DTML <devicetree@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        michael@walle.cc, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
Message-ID: <20200619064141.GK954398@dell>
References: <20200618080223.951737-1-lee.jones@linaro.org>
 <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
 <20200618100704.GC954398@dell>
 <CAGb2v67GJUzomptOzzvafcQ-wAqrJvNNeEZsY7gVQ_kByqBT8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v67GJUzomptOzzvafcQ-wAqrJvNNeEZsY7gVQ_kByqBT8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020, Chen-Yu Tsai wrote:

> On Thu, Jun 18, 2020 at 6:07 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 18 Jun 2020, Arnd Bergmann wrote:
> >
> > > On Thu, Jun 18, 2020 at 10:03 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > The existing SYSCON implementation only supports MMIO (memory mapped)
> > > > accesses, facilitated by Regmap.  This extends support for registers
> > > > held behind I2C busses.
> > > >
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > >
> > > The implementation looks fine to me, but can you explain how this is going to
> > > be used, and what the advantage is over open-coding the devm_regmap_init_i2c()
> > > in each driver that would use this?
> >
> > Does Regmap let you register/initialise an I2C address more than once?
> >
> > When I attempt it, I get:
> >
> > [    0.522988] i2c i2c-0: Failed to register i2c client tmp105 at 0x32 (-16)
> > [    0.523341] i2c i2c-0: of_i2c: Failure registering /bus@4000000/motherboard/iofpga@7,00000000/i2c@16000/temp@32
> > [    0.523691] i2c i2c-0: Failed to create I2C device for /bus@4000000/motherboard/iofpga@7,00000000/i2c@16000/temp@32
> >
> > > Is this about using proper locking through the regmap framework for
> > > shared i2c clients, or to reduce memory consumption when lots of drivers
> > > access the same regmap?
> >
> > All of those things are valid.
> >
> > My use-case is regarding MFDs sharing an I2C interfaced address space
> > with their children.
> 
> Is that an issue with the standard mfd + regmap pattern?

There is no relationship between MFD and Regmap.  It is not more
closely related to Regmap than it is any other public API provided
within the kernel.  *Some* parent drivers initialise one large,
encompassing Regmap address space and pass it to their children, but
this isn't suitable in all cases.

> For the AXP20x PMICs, we register the regmap in the parent mfd driver [1],
> and store that in dev_data for child drivers to fetch [2]. You could
> easily just fetch the regmap with dev_get_regmap() and a pointer to the
> parent device.

Remember, not all use-cases are the same.  Just because your H/W fits
well within the current framework, doesn't mean all will.

Initialising in the parent is no problem if the driver is meaningful
in other ways, but what if that's all the parent driver does?  In
these cases Syscon can be used instead, rendering the driver
superfluous. Meaning it can (and *should*) then be omitted.

> > > My impression of the existing syscon code is that the main value-add over
> > > other ways of doing the same is the syscon_regmap_lookup_by_phandle()
> > > interface that gives other drivers a much simpler way of getting the
> > > regmap just based on the DT node. Are you planning to add something
> > > like that here as well? An ideal driver interface might allow
> > > syscon_regmap_lookup_by_phandle() to work for both mmio and i2c
> > > based syscons, or additional ones as well, but implementing this would
> > > be rather tricky when the i2c core is a loadable module.
> 
> The current MMIO syscon is decoupled from the DM, and there is no way
> for drivers to export or register a syscon, meaning I have to open code
> syscon_regmap_lookup_by_phandle() [3] if I want to only expose certain
> registers and not the full address range, or if I want to share the
> regmap with the existing driver (for locking purposes), or both [4].

Not sure I understand the problem.

Could you explain why the current implementation doesn't work for you?

Open coding your own implementation of Syscon is non-optimal.

> Maybe there's room for improvement here? The same applies to the new
> I2C case, and likely any other future syscon variants.
> 
> IMHO people are getting it wrong if they have both a syscon and a driver
> for the same device.

Syscon is just a means to obtain a group of registers either a)
without a dedicated driver OR b) to share amongst more than 1,
potentially unrelated, user.  So in the case of a) which appears to
sit well with-in your use-case and expectations, you are correct.
Whereas in the case of b) you are not.

I hope that helps clarity the situation somewhat.

> > I expect the API would be expanded to cover other use-cases.  This is
> > a bare bones implementation which has been kept as atomic as possible
> > for ease of review.
> 
> Regards
> ChenYu
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/mfd/axp20x-i2c.c#L43
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/pinctrl-axp209.c#L433
> [3] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c#L1093
> [4] https://elixir.bootlin.com/linux/latest/source/drivers/clk/sunxi-ng/ccu-sun8i-r40.c#L1333

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
