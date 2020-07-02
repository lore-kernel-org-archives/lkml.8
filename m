Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6749EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBD32085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="HZaoPNov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGBHCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:02:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:48969 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgGBHCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:02:12 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 905E6226F6;
        Thu,  2 Jul 2020 09:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1593673328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQTu4YMfujJ6SsFKBNKHKnCTWInZclRPA0DmiPcnXYk=;
        b=HZaoPNovjNwu6Yk/SOwWYw1fhIdC38F9BrryUbHU8llqhJMlKSvgQMMyA0Z8KtxVxvD9P1
        2VZfRjm8Vl+MptUj/8XoC1+VWT58nEGQfdbsgKadyjtWyWGEaYmau91kEkBY0Lv1qkJOJ1
        gcCM9ZC/sJFsMEnIEVAO3Pa0kWmJliU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 09:02:05 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
In-Reply-To: <20200702065412.GO1179328@dell>
References: <20200622075145.1464020-1-lee.jones@linaro.org>
 <e436fd60bf0ebb6d72a76034d0fc35de@walle.cc>
 <f505c52d565ba7dbf05eef895782c410@walle.cc> <20200701070434.GP1179328@dell>
 <5d1d41504172d86d395b0135923f6f02@walle.cc> <20200702065412.GO1179328@dell>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <c20e8009fadbdc032090a493074396c8@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-07-02 08:54, schrieb Lee Jones:
> On Wed, 01 Jul 2020, Michael Walle wrote:
> 
>> Am 2020-07-01 09:04, schrieb Lee Jones:
>> > On Wed, 01 Jul 2020, Michael Walle wrote:
>> >
>> > > Hi Lee,
>> > >
>> > > Am 2020-06-30 11:16, schrieb Michael Walle:
>> > > > I'm just trying to use this for my sl28 driver. Some remarks, see below.
>> > > >
>> > > > Am 2020-06-22 09:51, schrieb Lee Jones:
>> > > > > The existing SYSCON implementation only supports MMIO (memory mapped)
>> > > > > accesses, facilitated by Regmap.  This extends support for registers
>> > > > > held behind I2C busses.
>> > > > >
>> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > > > > ---
>> > > > > Changelog:
>> > > > >
>> > > > > v3 => v4
>> > > > >   - Add ability to provide a non-default Regmap configuration
>> > > > >
>> > > > > v2 => v3
>> > > > >   - Change 'is CONFIG' present check to include loadable modules
>> > > > >     - s/#ifdef CONFIG_MFD_SYSCON_I2C/#if
>> > > > > IS_ENABLED(CONFIG_MFD_SYSCON_I2C)/
>> > > > >
>> > > > > v1 => v2
>> > > > >   - Remove legacy references to OF
>> > > > >   - Allow building as a module (fixes h8300 0-day issue)
>> > > > >
>> > > > > drivers/mfd/Kconfig            |   7 +++
>> > > > >  drivers/mfd/Makefile           |   1 +
>> > > > >  drivers/mfd/syscon-i2c.c       | 104
>> > > > > +++++++++++++++++++++++++++++++++
>> > > > >  include/linux/mfd/syscon-i2c.h |  36 ++++++++++++
>> > > > >  4 files changed, 148 insertions(+)
>> > > > >  create mode 100644 drivers/mfd/syscon-i2c.c
>> > > > >  create mode 100644 include/linux/mfd/syscon-i2c.h
> 
> [...]
> 
>> > > > This way, (a) a driver doesn't have to use "#include <linux/i2c.h>" just
>> > > > to call to_i2c_client() (or i2c_verify_client()) and (b) you won't do it
>> > > > all over again in all sub drivers.
>> > > >
>> > > > So you could just do a
>> > > >   regmap = syscon_i2c_to_regmap(pdev->dev.parent);
>> > > >
>> > > > I've also noticed that the mmio syscon uses device_node as parameter.
>> > > > What
>> > > > was the reason to divert from that? Just curious.
>> > >
>> > > How is this supposed to be used?
>> > >
>> > > I had something like the following in mind:
>> > >
>> > > &i2c {
>> > >   cpld@4a {
>> > >     compatible = "simple-mfd";
>> > >     reg = <0x4a>;
>> > >
>> > >     gpio@4 {
>> > >       compatible = "vendor,gpio";
>> > >       reg = <0x4>;
>> > >     };
>> > >   };
>> > > };
>> >
>> > Yes, that was the idea.
>> >
>> > > But I think the childen are not enumerated if its an I2C device. And
>> > > the actual i2c driver is also missing.
>> >
>> > What do you mean?  Can you elaborate?
>> 
>> There is no i2c_driver instance who would create the regmap.
> 
> The regmap is created by the first caller of:
> 
>  syscon_i2c_to_regmap{_config}()

But which one is an i2c_driver? All the sub devices are platform drivers
and there should be no need for them to know that they are behind an
i2c driver (or spi driver or just mmio). All they have to know is how
to access the registers.

>> If I'm
>> reading the I2C code correctly, it won't probe any i2c device of a
>> bus if there is no i2c_driver with an associated .probe() or
>> .probe_new().
> 
> Why wouldn't the children be registered using i2c_driver?

Where is the code which enumerates the children?

>> And even if it is probed, its subnodes won't be
>> enumerated; the "simple-mfd" code only works for MMIO busses, right?
>> Or I'm getting something really wrong here..
> 
> Then how are these I2C based devices able to call 
> of_platform_populate()?

I don't mean they can't do it, I mean, I'm calling 
of_platform_populate()
myself. But who is actually calling it when one uses the this patch
series?

-michael

>  drivers/mfd/gateworks-gsc.c
>  drivers/mfd/lochnagar-i2c.c
>  drivers/mfd/palmas.c
>  drivers/mfd/smsc-ece1099.c
>  drivers/mfd/stpmic1.c
>  drivers/mfd/twl-core.c
> 
> Might require some more research into where your use-case is breaking
> down.
