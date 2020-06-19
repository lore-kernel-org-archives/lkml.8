Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D2AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D12820890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoWK/3kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbgFSJHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbgFSJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:07:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD35C0613F0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:07:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so6968074wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=An0/1Yz6hizQTR4fj1ifS1TO4fEjpitZbgWOcyK/IZY=;
        b=xoWK/3kNajghFrZozDbLkZ+9+1h4rMZRk4i/g1WFQfGERECbt04srXH5UJiGrrbyKu
         h9LnBp9ynJIbsmyXcVy6mZmjnjmoawF0OI4WWZTtX7qllMcrF1Q82TpgA9Ldf0b9TY54
         PCEtzLpxZsJSzyvXo5nZIzHAW+IT0av9VSakipBADy4JSffgRW7dlODsp4Ipw9fSjPHz
         Zlft2GrVjOwhXt3+if3NEAqx/2zfC8NPd2shaYvo5p8c3MRL/WQH9t9UBCHdNshXkpsm
         IBMT/ylXZAGudAqfbOO7vXR6sQBQ49XrgUHCZ/r3uZ+Dx3iBfk8YDVKK97nveHNxpcUo
         iw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=An0/1Yz6hizQTR4fj1ifS1TO4fEjpitZbgWOcyK/IZY=;
        b=mMJzUszdrShelUWP8EEhysv7DqYooV50fxAmMtG0SPcoSNxeB8hdEvV8axQn0D46GA
         BRmcu5lU2KPEo+jxmhGvq4P0kUyD0R5fef6joou7Itk7n8geO+WwhdOAwzwjZkmdRFiK
         sIaNmyI7MnsVqg6hlrY/jiXDT4H/4H8d09rvqQNYIvNGrEbnc0E/MDvXDoChTn6LLo2p
         jY4+Bz6zMq+jNLlrsk/dtnFSYKERUJ6uKcH985SjVaFQzgadGssgQ+Ea0Rk4CgciZLwK
         XNONHrKZAbSs5jiEx+mZseo5rxJENHIvHuBiFmjI2McigK24ulNB4Zjrp84w1VQRnsuA
         0RBA==
X-Gm-Message-State: AOAM533Dj+PGJne+XG5S1g5ipA7oFTbMX2K+yMMLMRLgOlg1dfhz9b/B
        clSkA3NtKMXFJ+c2HI6xP0Owiw==
X-Google-Smtp-Source: ABdhPJya5CT4h4LEpPiFHKoiDP1NdZBtAKWO81GUFvApmmIdbuZgnssYXSgixGojtFmF7wmOkDbpXA==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr2934774wrq.222.1592557620112;
        Fri, 19 Jun 2020 02:07:00 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id b18sm6376150wrn.88.2020.06.19.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 02:06:59 -0700 (PDT)
Date:   Fri, 19 Jun 2020 10:06:57 +0100
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
Message-ID: <20200619090657.GL954398@dell>
References: <20200618080223.951737-1-lee.jones@linaro.org>
 <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
 <20200618100704.GC954398@dell>
 <CAGb2v67GJUzomptOzzvafcQ-wAqrJvNNeEZsY7gVQ_kByqBT8w@mail.gmail.com>
 <20200619064141.GK954398@dell>
 <CAGb2v65aAAegOCdMYF=VkTT8pWwuT9d=mhVKCSwztecMJa-ung@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v65aAAegOCdMYF=VkTT8pWwuT9d=mhVKCSwztecMJa-ung@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020, Chen-Yu Tsai wrote:

> On Fri, Jun 19, 2020 at 2:41 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 19 Jun 2020, Chen-Yu Tsai wrote:
> >
> > > On Thu, Jun 18, 2020 at 6:07 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Thu, 18 Jun 2020, Arnd Bergmann wrote:
> > > >
> > > > > On Thu, Jun 18, 2020 at 10:03 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > >
> > > > > > The existing SYSCON implementation only supports MMIO (memory mapped)
> > > > > > accesses, facilitated by Regmap.  This extends support for registers
> > > > > > held behind I2C busses.
> > > > > >
> > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > >
> > > > > The implementation looks fine to me, but can you explain how this is going to
> > > > > be used, and what the advantage is over open-coding the devm_regmap_init_i2c()
> > > > > in each driver that would use this?
> > > >
> > > > Does Regmap let you register/initialise an I2C address more than once?
> > > >
> > > > When I attempt it, I get:
> > > >
> > > > [    0.522988] i2c i2c-0: Failed to register i2c client tmp105 at 0x32 (-16)
> > > > [    0.523341] i2c i2c-0: of_i2c: Failure registering /bus@4000000/motherboard/iofpga@7,00000000/i2c@16000/temp@32
> > > > [    0.523691] i2c i2c-0: Failed to create I2C device for /bus@4000000/motherboard/iofpga@7,00000000/i2c@16000/temp@32
> > > >
> > > > > Is this about using proper locking through the regmap framework for
> > > > > shared i2c clients, or to reduce memory consumption when lots of drivers
> > > > > access the same regmap?
> > > >
> > > > All of those things are valid.
> > > >
> > > > My use-case is regarding MFDs sharing an I2C interfaced address space
> > > > with their children.
> > >
> > > Is that an issue with the standard mfd + regmap pattern?
> >
> > There is no relationship between MFD and Regmap.  It is not more
> > closely related to Regmap than it is any other public API provided
> > within the kernel.  *Some* parent drivers initialise one large,
> > encompassing Regmap address space and pass it to their children, but
> > this isn't suitable in all cases.
> >
> > > For the AXP20x PMICs, we register the regmap in the parent mfd driver [1],
> > > and store that in dev_data for child drivers to fetch [2]. You could
> > > easily just fetch the regmap with dev_get_regmap() and a pointer to the
> > > parent device.
> >
> > Remember, not all use-cases are the same.  Just because your H/W fits
> > well within the current framework, doesn't mean all will.
> >
> > Initialising in the parent is no problem if the driver is meaningful
> > in other ways, but what if that's all the parent driver does?  In
> > these cases Syscon can be used instead, rendering the driver
> > superfluous. Meaning it can (and *should*) then be omitted.
> 
> I'm guessing in your use case there isn't a need for a parent driver,
> and you are looking for something like "simple-mfd", but for listing
> sub-devices within an I2C slave device? In that case I understand.

Bingo!

Actually this will be used *with* "simple-mfd".  "simple-mfd" will
ensure the sub-devices are probed and "syscon" will allow them to
share an address space.  This is currently possible for MMIO, but not
so for register maps located behind an I2C interface.

> > > > > My impression of the existing syscon code is that the main value-add over
> > > > > other ways of doing the same is the syscon_regmap_lookup_by_phandle()
> > > > > interface that gives other drivers a much simpler way of getting the
> > > > > regmap just based on the DT node. Are you planning to add something
> > > > > like that here as well? An ideal driver interface might allow
> > > > > syscon_regmap_lookup_by_phandle() to work for both mmio and i2c
> > > > > based syscons, or additional ones as well, but implementing this would
> > > > > be rather tricky when the i2c core is a loadable module.
> > >
> > > The current MMIO syscon is decoupled from the DM, and there is no way
> > > for drivers to export or register a syscon, meaning I have to open code
> > > syscon_regmap_lookup_by_phandle() [3] if I want to only expose certain
> > > registers and not the full address range, or if I want to share the
> > > regmap with the existing driver (for locking purposes), or both [4].
> >
> > Not sure I understand the problem.
> >
> > Could you explain why the current implementation doesn't work for you?
> >
> > Open coding your own implementation of Syscon is non-optimal.
> 
> For the DWMAC Ethernet controllers, the platform glue almost always has
> a register for tuning the delays of the TX and RX clocks. In almost all
> later Allwinner chips, this is in a separate area, which we use a syscon
> for. However in one hybrid chip, this is located in the clock controller.
> We deemed it risky to also have the whole clock controller address range
> mapped as a syscon, and so we export a custom regmap.
> 
> The Ethernet driver has to deal with both cases.
> 
> Looking at it again, since syscon still has a platform driver, maybe I
> should just use the dev_get_regmap() route for both cases.
> 
> > > Maybe there's room for improvement here? The same applies to the new
> > > I2C case, and likely any other future syscon variants.
> > >
> > > IMHO people are getting it wrong if they have both a syscon and a driver
> > > for the same device.
> >
> > Syscon is just a means to obtain a group of registers either a)
> > without a dedicated driver OR b) to share amongst more than 1,
> > potentially unrelated, user.  So in the case of a) which appears to
> > sit well with-in your use-case and expectations, you are correct.
> > Whereas in the case of b) you are not.
> >
> > I hope that helps clarity the situation somewhat.
> 
> The concern was mostly due to the commit message of
> 
>     bdb0066df96e mfd: syscon: Decouple syscon interface from platform devices
> 
> which mentions
> 
>    there is a need to have a dedicated driver for such system controller
>    but also share registers with other drivers. The latter is where the
>    syscon interface is helpful.
> 
> But does not provide any sort of coordination between the dedicated driver
> and the syscon. I suppose the intention might have been that the driver
> would get a syscon using its own device node. We avoided that but I wonder
> if the extra code is worth it or not. Other platforms seem to do ok.

What sort of co-ordination do you require beyond what is offered?

> Thank you for helping me clear things up.

Never a problem.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
