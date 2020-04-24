Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC5C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6AB2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JW615PGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgDXOux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgDXOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:50:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DCCC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:50:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so11170104wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=arbjr4f533qeCGCUfXjG1AwJZCWsc1TMbgG9gTC3+BU=;
        b=JW615PGBkId3Rrx+sIS/Qtame0NNhCqmt0qNHU2XFbJURWQSEIB98K9+6A9yo9Xwwo
         GVlxwOoYW0tgbXzt1dH6VxJpCED3uo/wSrBJPwF2J/YRLAjxEE5GTY6dC7fmCckxWh18
         L6cZGp86UCIuw9xgcBy16AIkG14OfZu8mpSA9F1G0dBhNx5YzkdvnBcQLGMPHmy8G7/Y
         /Ytol1fBWdvenECw8SxiLzwPHJW0+t+MRQL6dlXTCrd21KdWZS2FdCZrQfrw9ZaOcCRI
         H3DwpwVK+1fO5Dqx2rJrMVgToIQ/tPEUh8g/EiLjowojJ5P1nPY2mjEQDk4l9UgE1wzz
         iCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=arbjr4f533qeCGCUfXjG1AwJZCWsc1TMbgG9gTC3+BU=;
        b=NtmI08Le4xbV4Eez3Yt1g+q56I3d3q7AmC2qwjcSfParF42Gw2mJiR5Vo7Zj3oghHx
         5VGATrLJDiVzMsZBXUQc1vi9jEr0P9/tugHN4aDl2SiuNvRRDfy4LAa1NAj5X4kibj5g
         Kyymz5wDKrQF4aIhm9gHIMISD98mMuThTQHSil7r7kR7BOT/Dbw+PCUVey0QkrFCHyOC
         tN55eBJvxfjUheRXgBWDRvbDF0crRGqjeRB5w+GOOyhxFcKNPTJQTL73hbL/rc9gTJW+
         ZOhSl8q7UHW2dxLG67FoVgZHii23a7+XfNsWB1+k73bNLgh757leMLnY477Bd5t1qH9c
         nRbw==
X-Gm-Message-State: AGi0PuYihtIQM8/MCinUsheqDUZm+py+IfDz0KvoEZ8SD3Foca4FSoxe
        C5KxVh1Lm8CojpZfRXcD3NAVpQ==
X-Google-Smtp-Source: APiQypKNlSzxiPCXIPo6RVz6w6o8W/4DZM0rPEnuXAxixbYMV5Gd4ccyEgRYMSuw8bMnFvOrB6o8/w==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr12203073wrw.207.1587739849924;
        Fri, 24 Apr 2020 07:50:49 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id q187sm3088378wma.41.2020.04.24.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:50:49 -0700 (PDT)
Date:   Fri, 24 Apr 2020 15:50:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     Marek Vasut <marex@denx.de>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 02/12] mfd: stm32-fmc2: add STM32 FMC2 controller
 driver
Message-ID: <20200424145047.GE8414@dell>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-3-git-send-email-christophe.kerello@st.com>
 <20200424074517.GN3612@dell>
 <8b625f1c-9ded-c07a-a20e-8cd44c1ca46d@denx.de>
 <20200424105053.GC8414@dell>
 <e5e6c279-28d0-f423-aa6d-5c7aca563352@denx.de>
 <268ea231-eb4a-6144-c632-1bc8e9f21582@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <268ea231-eb4a-6144-c632-1bc8e9f21582@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020, Christophe Kerello wrote:

> 
> 
> On 4/24/20 1:06 PM, Marek Vasut wrote:
> > On 4/24/20 12:50 PM, Lee Jones wrote:
> > > On Fri, 24 Apr 2020, Marek Vasut wrote:
> > > 
> > > > On 4/24/20 9:45 AM, Lee Jones wrote:
> > > > > On Wed, 15 Apr 2020, Christophe Kerello wrote:
> > > > > 
> > > > > > The driver adds the support for the STMicroelectronics FMC2 controller
> > > > > > found on STM32MP SOCs.
> > > > > > 
> > > > > > The FMC2 functional block makes the interface with: synchronous and
> > > > > > asynchronous static memories (such as PSNOR, PSRAM or other
> > > > > > memory-mapped peripherals) and NAND flash memories.
> > > > > > 
> > > > > > Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > >   - remove ops from stm32_fmc2 structure
> > > > > >   - add 2 APIs to manage FMC2 enable/disable
> > > > > >   - add 2 APIs to manage FMC2 NWAIT shared signal
> > > > > > 
> > > > > >   drivers/mfd/Kconfig            |  12 +++
> > > > > >   drivers/mfd/Makefile           |   1 +
> > > > > >   drivers/mfd/stm32-fmc2.c       | 136 +++++++++++++++++++++++++
> > > > > >   include/linux/mfd/stm32-fmc2.h | 225 +++++++++++++++++++++++++++++++++++++++++
> > > > > >   4 files changed, 374 insertions(+)
> > > > > >   create mode 100644 drivers/mfd/stm32-fmc2.c
> > > > > >   create mode 100644 include/linux/mfd/stm32-fmc2.h
> > > > > > 
> > > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > > index 2b20329..5260582 100644
> > > > > > --- a/drivers/mfd/Kconfig
> > > > > > +++ b/drivers/mfd/Kconfig
> > > > > > @@ -1922,6 +1922,18 @@ config MFD_ROHM_BD71828
> > > > > >   	  Also included is a Coulomb counter, a real-time clock (RTC), and
> > > > > >   	  a 32.768 kHz clock gate.
> > > > > > +config MFD_STM32_FMC2
> > > > > > +	tristate "Support for FMC2 controllers on STM32MP SoCs"
> > > > > > +	depends on MACH_STM32MP157 || COMPILE_TEST
> > > > > > +	select MFD_CORE
> > > > > > +	select REGMAP
> > > > > > +	select REGMAP_MMIO
> > > > > > +	help
> > > > > > +	  Select this option to enable STM32 FMC2 driver used for FMC2 External
> > > > > > +	  Bus Interface controller and FMC2 NAND flash controller. This driver
> > > > > > +	  provides core support for the STM32 FMC2 controllers, in order to use
> > > > > > +	  the actual functionality of the device other drivers must be enabled.
> > > > > 
> > > > > Not sure how many times I have to say this before people stop
> > > > > attempting to pass these kinds of relationships off as MFDs:
> > > > > 
> > > > > A memory device and its bus is not an MFD.  In a similar vain to the
> > > > > thousands of USB, I2C, SPI, PCI and the like devices that aren't MFDs
> > > > > either.
> > > > > 
> > > > > Please find another way to associate your device with its bus.
> > > > 
> > > > This FMC2 is however an IP which can either operate external devices
> > > > (like ethernet chip on this parallel bus) or external flashes (like NOR
> > > > and NAND chips).
> > > 
> > > I'm sure that it *can*.  Although that's not its main purpose.
> > 
> > I use it to operate KSZ8851-16MLL ethernet chip, which has async bus
> > interface. Linux just didn't have support for that mode of operation
> > thus far and the FMC was used to operate NANDs and NORs only. This
> > series, or rather, the first three patches in this series, add support
> > for operating other bus devices, like this ethernet controller.
> > 
> > > The
> > > clue is in the nomenclature ("Flexible *Memory* Controller").  Nor is
> > > it how the device is being used in this submission:
> > > 
> > >    "The FMC2 functional block makes the interface with: synchronous and
> > >     asynchronous static memories (such as PSNOR, PSRAM or other
> > >     memory-mapped peripherals) and NAND flash memories."
> > > 
> > > As I mentioned, this is just another memory device and its bus.
> > 
> > I don't think it's _just_ a memory controller, it's more universal than
> > that, see above. Note that SRAM interface basically boils down to
> > anything which has external parallel bus, e.g. Davicom DM9000, that
> > KSZ8851-16MLL etc.
> > 
> > > > Can you provide a suggestion how this should be handled, if not as MFD?
> > > > It seems to me, that this is a Multi-Function Device .
> > > 
> > > Simply move it into the MTD or Memory subsystems and set up the
> > > dependencies via Kconfig.
> > > 
> > > > If this discussion is a recurring topic, is there some documentation
> > > > which explains how such devices should be handled ?
> > > 
> > > Not that I'm aware of.
> > 
> > I see.
> > 
> 
> Hi Lee, Marek,
> 
> I will move this source code in the FMC2 bus driver. I think that I should
> be able to manage the 2 controllers with 2 drivers (the FMC2 bus driver and
> the FMC2 raw NAND driver). I will have to modify some part of the proposed
> bindings, and some updates will have to be done in the FMC2 bus driver. All
> these modifications will be part of V3.

That sounds like a very reasonable solution.

From a purist's PoV, the bindings should not change.  As they should
describe the hardware, rather than the implementation.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
