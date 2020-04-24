Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672CCC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513EC20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgDXK1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:27:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56651 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDXK1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:27:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 497r383075z1r3dY;
        Fri, 24 Apr 2020 12:27:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 497r381DwHz1qr4s;
        Fri, 24 Apr 2020 12:27:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dolzM1ggvfB3; Fri, 24 Apr 2020 12:27:45 +0200 (CEST)
X-Auth-Info: sKNCq0LDWdPK1vCn4vD4jzbxqTdPHMFIWhlETY4t0i0=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 24 Apr 2020 12:27:45 +0200 (CEST)
Subject: Re: [PATCH v2 02/12] mfd: stm32-fmc2: add STM32 FMC2 controller
 driver
To:     Lee Jones <lee.jones@linaro.org>,
        Christophe Kerello <christophe.kerello@st.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-3-git-send-email-christophe.kerello@st.com>
 <20200424074517.GN3612@dell>
From:   Marek Vasut <marex@denx.de>
Message-ID: <8b625f1c-9ded-c07a-a20e-8cd44c1ca46d@denx.de>
Date:   Fri, 24 Apr 2020 12:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200424074517.GN3612@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 9:45 AM, Lee Jones wrote:
> On Wed, 15 Apr 2020, Christophe Kerello wrote:
> 
>> The driver adds the support for the STMicroelectronics FMC2 controller
>> found on STM32MP SOCs.
>>
>> The FMC2 functional block makes the interface with: synchronous and
>> asynchronous static memories (such as PSNOR, PSRAM or other
>> memory-mapped peripherals) and NAND flash memories.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
>> Changes in v2:
>>  - remove ops from stm32_fmc2 structure
>>  - add 2 APIs to manage FMC2 enable/disable
>>  - add 2 APIs to manage FMC2 NWAIT shared signal
>>
>>  drivers/mfd/Kconfig            |  12 +++
>>  drivers/mfd/Makefile           |   1 +
>>  drivers/mfd/stm32-fmc2.c       | 136 +++++++++++++++++++++++++
>>  include/linux/mfd/stm32-fmc2.h | 225 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 374 insertions(+)
>>  create mode 100644 drivers/mfd/stm32-fmc2.c
>>  create mode 100644 include/linux/mfd/stm32-fmc2.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 2b20329..5260582 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1922,6 +1922,18 @@ config MFD_ROHM_BD71828
>>  	  Also included is a Coulomb counter, a real-time clock (RTC), and
>>  	  a 32.768 kHz clock gate.
>>  
>> +config MFD_STM32_FMC2
>> +	tristate "Support for FMC2 controllers on STM32MP SoCs"
>> +	depends on MACH_STM32MP157 || COMPILE_TEST
>> +	select MFD_CORE
>> +	select REGMAP
>> +	select REGMAP_MMIO
>> +	help
>> +	  Select this option to enable STM32 FMC2 driver used for FMC2 External
>> +	  Bus Interface controller and FMC2 NAND flash controller. This driver
>> +	  provides core support for the STM32 FMC2 controllers, in order to use
>> +	  the actual functionality of the device other drivers must be enabled.
> 
> Not sure how many times I have to say this before people stop
> attempting to pass these kinds of relationships off as MFDs:
> 
> A memory device and its bus is not an MFD.  In a similar vain to the
> thousands of USB, I2C, SPI, PCI and the like devices that aren't MFDs
> either.
> 
> Please find another way to associate your device with its bus.

This FMC2 is however an IP which can either operate external devices
(like ethernet chip on this parallel bus) or external flashes (like NOR
and NAND chips).

Can you provide a suggestion how this should be handled, if not as MFD?
It seems to me, that this is a Multi-Function Device .

If this discussion is a recurring topic, is there some documentation
which explains how such devices should be handled ?

Thank you
