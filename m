Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E385EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA0720776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmBbirVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgDXKu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXKu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:50:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40866C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:50:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so9949808wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yf9tP3sNXUsAB/rOddBDtkpZustuUZCD7ZROOWh0ox4=;
        b=VmBbirVEjOgVcz1iLrCDuO5VLXN1951W8re/zO0nzgFYuwEMxoMSE1+bJi8VD1ugrt
         k100zGpG94719MgmRICqnQneLX0yv58hh5Eu4UMybV0Ju088At0DHXnNLHBrNZ3wd4ir
         ZD7sb8FxKGceNRllh8lWxRQJM921TSzHLF/sh9jCuOzooAWoNv9Y8c0eNgG9iXPQJcHo
         UI6hKLFOmog5ICyxUJVBFWjTf1rn4Ep1qEVB2jzkZbhzpnSyDGeM4ygUy/LNdLZriX7H
         9r9BKf31beIDyCBTLhxqlxcPdXdY26KNmj2nRe+DueEx2j8TvXDVpgjU/HC402cddZWP
         tV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yf9tP3sNXUsAB/rOddBDtkpZustuUZCD7ZROOWh0ox4=;
        b=sJjTh3ANRUEtmtYLDWd0Ht8Ga8U7RZ3Qr9AURvK7hUTKSxcY1ApThk9JDML5h3pk0E
         Z+kcGaMBv52F5rBz+9Y1z3YrXIC1LbSGfiQ7jOVh9NJc55CA2dQuqK8IL4iSECRlVZX2
         MJJtXXoExPwEbGgpSg4KuwqRNj+d7ohGpT/JuCbN6SBwZuq9PGd+yvrkaQaxVJwNrtT5
         xFB9N5T3YV8bMrpUB5g154qflMAU96H69aW4eeTIuPmpzTT92U8l02lnwnc8iaui15wy
         JNa3N6H7qBoLKX3NTvgzqHi084KBZGVCcG1qyMn3huQiNFDst/eLGj1Fb9BGQHBBT2El
         lV5Q==
X-Gm-Message-State: AGi0PuZ+5PNv+PsUZjH8mdNufEDdtyAo6EtzdHWLkjthV9AKZzaF6rJ/
        80nxkrkqzxeiVlIEvDwsbaahtg==
X-Google-Smtp-Source: APiQypIA21ZhRcvVCjZ27PG/4HY/Hpz6nTlXLW+I8YNTy6MMWXH+2KzYqqh4CqqJzSqriZ3BH6X/kw==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr10044348wmc.121.1587725455891;
        Fri, 24 Apr 2020 03:50:55 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id o18sm7595925wrp.23.2020.04.24.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 03:50:55 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:50:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 02/12] mfd: stm32-fmc2: add STM32 FMC2 controller
 driver
Message-ID: <20200424105053.GC8414@dell>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-3-git-send-email-christophe.kerello@st.com>
 <20200424074517.GN3612@dell>
 <8b625f1c-9ded-c07a-a20e-8cd44c1ca46d@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b625f1c-9ded-c07a-a20e-8cd44c1ca46d@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020, Marek Vasut wrote:

> On 4/24/20 9:45 AM, Lee Jones wrote:
> > On Wed, 15 Apr 2020, Christophe Kerello wrote:
> > 
> >> The driver adds the support for the STMicroelectronics FMC2 controller
> >> found on STM32MP SOCs.
> >>
> >> The FMC2 functional block makes the interface with: synchronous and
> >> asynchronous static memories (such as PSNOR, PSRAM or other
> >> memory-mapped peripherals) and NAND flash memories.
> >>
> >> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> >> ---
> >> Changes in v2:
> >>  - remove ops from stm32_fmc2 structure
> >>  - add 2 APIs to manage FMC2 enable/disable
> >>  - add 2 APIs to manage FMC2 NWAIT shared signal
> >>
> >>  drivers/mfd/Kconfig            |  12 +++
> >>  drivers/mfd/Makefile           |   1 +
> >>  drivers/mfd/stm32-fmc2.c       | 136 +++++++++++++++++++++++++
> >>  include/linux/mfd/stm32-fmc2.h | 225 +++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 374 insertions(+)
> >>  create mode 100644 drivers/mfd/stm32-fmc2.c
> >>  create mode 100644 include/linux/mfd/stm32-fmc2.h
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index 2b20329..5260582 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -1922,6 +1922,18 @@ config MFD_ROHM_BD71828
> >>  	  Also included is a Coulomb counter, a real-time clock (RTC), and
> >>  	  a 32.768 kHz clock gate.
> >>  
> >> +config MFD_STM32_FMC2
> >> +	tristate "Support for FMC2 controllers on STM32MP SoCs"
> >> +	depends on MACH_STM32MP157 || COMPILE_TEST
> >> +	select MFD_CORE
> >> +	select REGMAP
> >> +	select REGMAP_MMIO
> >> +	help
> >> +	  Select this option to enable STM32 FMC2 driver used for FMC2 External
> >> +	  Bus Interface controller and FMC2 NAND flash controller. This driver
> >> +	  provides core support for the STM32 FMC2 controllers, in order to use
> >> +	  the actual functionality of the device other drivers must be enabled.
> > 
> > Not sure how many times I have to say this before people stop
> > attempting to pass these kinds of relationships off as MFDs:
> > 
> > A memory device and its bus is not an MFD.  In a similar vain to the
> > thousands of USB, I2C, SPI, PCI and the like devices that aren't MFDs
> > either.
> > 
> > Please find another way to associate your device with its bus.
> 
> This FMC2 is however an IP which can either operate external devices
> (like ethernet chip on this parallel bus) or external flashes (like NOR
> and NAND chips).

I'm sure that it *can*.  Although that's not its main purpose.  The
clue is in the nomenclature ("Flexible *Memory* Controller").  Nor is
it how the device is being used in this submission:

  "The FMC2 functional block makes the interface with: synchronous and
   asynchronous static memories (such as PSNOR, PSRAM or other
   memory-mapped peripherals) and NAND flash memories."

As I mentioned, this is just another memory device and its bus.

> Can you provide a suggestion how this should be handled, if not as MFD?
> It seems to me, that this is a Multi-Function Device .

Simply move it into the MTD or Memory subsystems and set up the
dependencies via Kconfig.

> If this discussion is a recurring topic, is there some documentation
> which explains how such devices should be handled ?

Not that I'm aware of.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
