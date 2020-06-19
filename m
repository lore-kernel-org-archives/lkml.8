Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7484C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C344420888
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592535828;
	bh=cKmkcpfwXu1EEI1wr7eaNKoi2kDhEga2lWfhy3FeS4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i2045xbubKPPZiTeMYMpPYwkv2osJefm51y8curttSZlULlRt6LpXNMz6h2kbRveG
	 EHFrOntA/eUt0lL62wthzxMZh5RLI0tkGnnK3oJj9JH66WjG9x1ZnSRAHimq8lVCzy
	 2X6ZbQvnRLqLX9I2JEfrDLTO0oegFjtFlOXQwrMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgFSDDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbgFSDDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:03:43 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B01020899;
        Fri, 19 Jun 2020 03:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592535822;
        bh=cKmkcpfwXu1EEI1wr7eaNKoi2kDhEga2lWfhy3FeS4U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iPpKgB/117h3Y6qYN+jag1kQRFU7Sl9dl/4pWbUk0ct8ldUZD+/4PxSfo+rAbJWlH
         m4k4zuL0YLAxx4WDNSwZp4MJtinDuBUGlCcFOamlv/9KvkGw0tgSydY9CgiyyG7rUi
         wa3229W8qrw8OGIm8qgdDy3QglaO8gZga9tJmCOk=
Received: by mail-lj1-f175.google.com with SMTP id e4so9765457ljn.4;
        Thu, 18 Jun 2020 20:03:42 -0700 (PDT)
X-Gm-Message-State: AOAM5306lweGZvO8DYHdToZmXLaLeOjodhOL8o+o66vMkFwBIOJDf82u
        7qu5ziDrEQOnnmfcWfNfhAO9uZyA/j5vpmF+SIY=
X-Google-Smtp-Source: ABdhPJwUS3CfyyNgp9baw02jk9HY+mRQomJJpWTbnU+aTkCqWgtcVr2+ACHYLw+MGcZtosKAdMsANaqnzNV2zgw9sJI=
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr708200ljk.273.1592535820451;
 Thu, 18 Jun 2020 20:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200618080223.951737-1-lee.jones@linaro.org> <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
 <20200618100704.GC954398@dell>
In-Reply-To: <20200618100704.GC954398@dell>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 19 Jun 2020 11:03:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v67GJUzomptOzzvafcQ-wAqrJvNNeEZsY7gVQ_kByqBT8w@mail.gmail.com>
Message-ID: <CAGb2v67GJUzomptOzzvafcQ-wAqrJvNNeEZsY7gVQ_kByqBT8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mfd: Add I2C based System Configuaration (SYSCON) access
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, DTML <devicetree@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        michael@walle.cc, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 6:07 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 18 Jun 2020, Arnd Bergmann wrote:
>
> > On Thu, Jun 18, 2020 at 10:03 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > The existing SYSCON implementation only supports MMIO (memory mapped)
> > > accesses, facilitated by Regmap.  This extends support for registers
> > > held behind I2C busses.
> > >
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > The implementation looks fine to me, but can you explain how this is going to
> > be used, and what the advantage is over open-coding the devm_regmap_init_i2c()
> > in each driver that would use this?
>
> Does Regmap let you register/initialise an I2C address more than once?
>
> When I attempt it, I get:
>
> [    0.522988] i2c i2c-0: Failed to register i2c client tmp105 at 0x32 (-16)
> [    0.523341] i2c i2c-0: of_i2c: Failure registering /bus@4000000/motherboard/iofpga@7,00000000/i2c@16000/temp@32
> [    0.523691] i2c i2c-0: Failed to create I2C device for /bus@4000000/motherboard/iofpga@7,00000000/i2c@16000/temp@32
>
> > Is this about using proper locking through the regmap framework for
> > shared i2c clients, or to reduce memory consumption when lots of drivers
> > access the same regmap?
>
> All of those things are valid.
>
> My use-case is regarding MFDs sharing an I2C interfaced address space
> with their children.

Is that an issue with the standard mfd + regmap pattern?

For the AXP20x PMICs, we register the regmap in the parent mfd driver [1],
and store that in dev_data for child drivers to fetch [2]. You could
easily just fetch the regmap with dev_get_regmap() and a pointer to the
parent device.

> > My impression of the existing syscon code is that the main value-add over
> > other ways of doing the same is the syscon_regmap_lookup_by_phandle()
> > interface that gives other drivers a much simpler way of getting the
> > regmap just based on the DT node. Are you planning to add something
> > like that here as well? An ideal driver interface might allow
> > syscon_regmap_lookup_by_phandle() to work for both mmio and i2c
> > based syscons, or additional ones as well, but implementing this would
> > be rather tricky when the i2c core is a loadable module.

The current MMIO syscon is decoupled from the DM, and there is no way
for drivers to export or register a syscon, meaning I have to open code
syscon_regmap_lookup_by_phandle() [3] if I want to only expose certain
registers and not the full address range, or if I want to share the
regmap with the existing driver (for locking purposes), or both [4].
Maybe there's room for improvement here? The same applies to the new
I2C case, and likely any other future syscon variants.

IMHO people are getting it wrong if they have both a syscon and a driver
for the same device.

> I expect the API would be expanded to cover other use-cases.  This is
> a bare bones implementation which has been kept as atomic as possible
> for ease of review.

Regards
ChenYu

[1] https://elixir.bootlin.com/linux/latest/source/drivers/mfd/axp20x-i2c.c#L43
[2] https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/pinctrl-axp209.c#L433
[3] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c#L1093
[4] https://elixir.bootlin.com/linux/latest/source/drivers/clk/sunxi-ng/ccu-sun8i-r40.c#L1333
