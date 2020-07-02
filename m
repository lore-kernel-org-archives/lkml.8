Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1939FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D5120702
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Z5NTFwts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGBJM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGBJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:12:59 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8278C08C5C1;
        Thu,  2 Jul 2020 02:12:58 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AC46622EEB;
        Thu,  2 Jul 2020 11:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1593681177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYkGBHvaNTyBI74MG9qO6W/wGpDKi9edSCvGAhgdkmw=;
        b=Z5NTFwtsFTYlze4XpyzMl067BvWkIbwhHTjSbiqKRE16dig9ea7I8Zhk/I9+hsAgGHhoHk
        4pPkMKBrrjJp3+gbmZNXUe5DHCPV8JllhP1smmyGy3tt6bg4fn+kz2tky67/5dmfpzXYK1
        eiaDSv/hOT3BDEbjpFFUsNa07btoD34=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 11:12:56 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Wolfram Sang <wsa@kernel.org>, robh+dt@kernel.org,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
In-Reply-To: <20200702081825.GR1179328@dell>
References: <20200622075145.1464020-1-lee.jones@linaro.org>
 <e436fd60bf0ebb6d72a76034d0fc35de@walle.cc>
 <f505c52d565ba7dbf05eef895782c410@walle.cc> <20200701070434.GP1179328@dell>
 <5d1d41504172d86d395b0135923f6f02@walle.cc> <20200702065412.GO1179328@dell>
 <c20e8009fadbdc032090a493074396c8@walle.cc> <20200702081825.GR1179328@dell>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <58ae64ebf22707ad1725987615b355c2@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-07-02 10:18, schrieb Lee Jones:
> On Thu, 02 Jul 2020, Michael Walle wrote:
> 
>> Am 2020-07-02 08:54, schrieb Lee Jones:
>> > On Wed, 01 Jul 2020, Michael Walle wrote:
>> >
>> > > Am 2020-07-01 09:04, schrieb Lee Jones:
>> > > > On Wed, 01 Jul 2020, Michael Walle wrote:
>> > > >
>> > > > > Hi Lee,
>> > > > >
>> > > > > Am 2020-06-30 11:16, schrieb Michael Walle:
>> > > > > > I'm just trying to use this for my sl28 driver. Some remarks, see below.
>> > > > > >
>> > > > > > Am 2020-06-22 09:51, schrieb Lee Jones:
>> > > > > > > The existing SYSCON implementation only supports MMIO (memory mapped)
>> > > > > > > accesses, facilitated by Regmap.  This extends support for registers
>> > > > > > > held behind I2C busses.
>> > > > > > >
>> > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > > > > > > ---
>> > > > > > > Changelog:
>> > > > > > >
>> > > > > > > v3 => v4
>> > > > > > >   - Add ability to provide a non-default Regmap configuration
>> > > > > > >
>> > > > > > > v2 => v3
>> > > > > > >   - Change 'is CONFIG' present check to include loadable modules
>> > > > > > >     - s/#ifdef CONFIG_MFD_SYSCON_I2C/#if
>> > > > > > > IS_ENABLED(CONFIG_MFD_SYSCON_I2C)/
>> > > > > > >
>> > > > > > > v1 => v2
>> > > > > > >   - Remove legacy references to OF
>> > > > > > >   - Allow building as a module (fixes h8300 0-day issue)
>> > > > > > >
>> > > > > > > drivers/mfd/Kconfig            |   7 +++
>> > > > > > >  drivers/mfd/Makefile           |   1 +
>> > > > > > >  drivers/mfd/syscon-i2c.c       | 104
>> > > > > > > +++++++++++++++++++++++++++++++++
>> > > > > > >  include/linux/mfd/syscon-i2c.h |  36 ++++++++++++
>> > > > > > >  4 files changed, 148 insertions(+)
>> > > > > > >  create mode 100644 drivers/mfd/syscon-i2c.c
>> > > > > > >  create mode 100644 include/linux/mfd/syscon-i2c.h
>> >
>> > [...]
>> >
>> > > > > > This way, (a) a driver doesn't have to use "#include <linux/i2c.h>" just
>> > > > > > to call to_i2c_client() (or i2c_verify_client()) and (b) you won't do it
>> > > > > > all over again in all sub drivers.
>> > > > > >
>> > > > > > So you could just do a
>> > > > > >   regmap = syscon_i2c_to_regmap(pdev->dev.parent);
>> > > > > >
>> > > > > > I've also noticed that the mmio syscon uses device_node as parameter.
>> > > > > > What
>> > > > > > was the reason to divert from that? Just curious.
>> > > > >
>> > > > > How is this supposed to be used?
>> > > > >
>> > > > > I had something like the following in mind:
>> > > > >
>> > > > > &i2c {
>> > > > >   cpld@4a {
>> > > > >     compatible = "simple-mfd";
>> > > > >     reg = <0x4a>;
>> > > > >
>> > > > >     gpio@4 {
>> > > > >       compatible = "vendor,gpio";
>> > > > >       reg = <0x4>;
>> > > > >     };
>> > > > >   };
>> > > > > };
>> > > >
>> > > > Yes, that was the idea.
>> > > >
>> > > > > But I think the childen are not enumerated if its an I2C device. And
>> > > > > the actual i2c driver is also missing.
>> > > >
>> > > > What do you mean?  Can you elaborate?
>> > >
>> > > There is no i2c_driver instance who would create the regmap.
>> >
>> > The regmap is created by the first caller of:
>> >
>> >  syscon_i2c_to_regmap{_config}()
>> 
>> But which one is an i2c_driver? All the sub devices are platform 
>> drivers
>> and there should be no need for them to know that they are behind an
>> i2c driver (or spi driver or just mmio). All they have to know is how
>> to access the registers.
>> 
>> > > If I'm
>> > > reading the I2C code correctly, it won't probe any i2c device of a
>> > > bus if there is no i2c_driver with an associated .probe() or
>> > > .probe_new().
>> >
>> > Why wouldn't the children be registered using i2c_driver?
>> 
>> Where is the code which enumerates the children?
> 
> Yes, I see the problem now.  So I2C devices depend on a device
> registering with the i2c_driver framework, which then probes the
> device accordingly.  Thus a physical driver is required to convert I2C
> devices to platform devices.  So this stops being an MFD problem and
> starts being a 'simple-i2c' issue. :)

Yes, but this is still MFD specifc, because no other normal (in lack of
a better word, think of one-function-devices) I2C device has sub-nodes.
Thus my proposal for that simple-mfd-i2c driver. And keep in mind that
this likely isn't specific to I2C but also to SPI (without having
looked at it). So in theory that simple-mfd-i2c, could also register
a spi_driver which then registers an SPI regmap and enumerates the
children. So this is not only an I2C topic, but IMHO still MFD.

-michael
