Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CC5C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D405920728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZSjPsri7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDXLsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:48:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55682 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbgDXLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:48:08 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OBko3N010590;
        Fri, 24 Apr 2020 13:47:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=eDUxGG9O4i5CdabzQ9g1DJn7cKAT0JlJmvP3BX0WRjc=;
 b=ZSjPsri72sQVac67WI7XcR73DLBOrEs+IFxub11JXnwGf/+djrmTBhHTPpY+jfiQ/WAJ
 u32nNodWmPwoNX27zKntZ+3BHTLirru6VZddRYA+HX+41Kysw0D/eE5QzvjM0To7pD/3
 zL/F/eiZLOilSNGdzRUyeNtn5Dip/94O0Oqi5WGfthyxetjorWr04UQMfZFrY730V6PK
 ZhR/d3m8q4ZsaXGVo+NXpyXb3YGmJ4dzAA3LZOQ4+iCj3Bfn6NbBOEc3e3pPXNjpyuBl
 SEbJvwzKhBXtYPy/9I0jWnbm2dZU1cWGOCgLAsZHRTt6hg+iqM3q8EPTDHvCkwGT38df qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30freh31er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 13:47:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EBD19100034;
        Fri, 24 Apr 2020 13:47:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B19E52B47A0;
        Fri, 24 Apr 2020 13:47:36 +0200 (CEST)
Received: from [10.211.2.59] (10.75.127.51) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Apr
 2020 13:47:35 +0200
Subject: Re: [PATCH v2 02/12] mfd: stm32-fmc2: add STM32 FMC2 controller
 driver
To:     Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-3-git-send-email-christophe.kerello@st.com>
 <20200424074517.GN3612@dell> <8b625f1c-9ded-c07a-a20e-8cd44c1ca46d@denx.de>
 <20200424105053.GC8414@dell> <e5e6c279-28d0-f423-aa6d-5c7aca563352@denx.de>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <268ea231-eb4a-6144-c632-1bc8e9f21582@st.com>
Date:   Fri, 24 Apr 2020 13:47:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e5e6c279-28d0-f423-aa6d-5c7aca563352@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 1:06 PM, Marek Vasut wrote:
> On 4/24/20 12:50 PM, Lee Jones wrote:
>> On Fri, 24 Apr 2020, Marek Vasut wrote:
>>
>>> On 4/24/20 9:45 AM, Lee Jones wrote:
>>>> On Wed, 15 Apr 2020, Christophe Kerello wrote:
>>>>
>>>>> The driver adds the support for the STMicroelectronics FMC2 controller
>>>>> found on STM32MP SOCs.
>>>>>
>>>>> The FMC2 functional block makes the interface with: synchronous and
>>>>> asynchronous static memories (such as PSNOR, PSRAM or other
>>>>> memory-mapped peripherals) and NAND flash memories.
>>>>>
>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>   - remove ops from stm32_fmc2 structure
>>>>>   - add 2 APIs to manage FMC2 enable/disable
>>>>>   - add 2 APIs to manage FMC2 NWAIT shared signal
>>>>>
>>>>>   drivers/mfd/Kconfig            |  12 +++
>>>>>   drivers/mfd/Makefile           |   1 +
>>>>>   drivers/mfd/stm32-fmc2.c       | 136 +++++++++++++++++++++++++
>>>>>   include/linux/mfd/stm32-fmc2.h | 225 +++++++++++++++++++++++++++++++++++++++++
>>>>>   4 files changed, 374 insertions(+)
>>>>>   create mode 100644 drivers/mfd/stm32-fmc2.c
>>>>>   create mode 100644 include/linux/mfd/stm32-fmc2.h
>>>>>
>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>> index 2b20329..5260582 100644
>>>>> --- a/drivers/mfd/Kconfig
>>>>> +++ b/drivers/mfd/Kconfig
>>>>> @@ -1922,6 +1922,18 @@ config MFD_ROHM_BD71828
>>>>>   	  Also included is a Coulomb counter, a real-time clock (RTC), and
>>>>>   	  a 32.768 kHz clock gate.
>>>>>   
>>>>> +config MFD_STM32_FMC2
>>>>> +	tristate "Support for FMC2 controllers on STM32MP SoCs"
>>>>> +	depends on MACH_STM32MP157 || COMPILE_TEST
>>>>> +	select MFD_CORE
>>>>> +	select REGMAP
>>>>> +	select REGMAP_MMIO
>>>>> +	help
>>>>> +	  Select this option to enable STM32 FMC2 driver used for FMC2 External
>>>>> +	  Bus Interface controller and FMC2 NAND flash controller. This driver
>>>>> +	  provides core support for the STM32 FMC2 controllers, in order to use
>>>>> +	  the actual functionality of the device other drivers must be enabled.
>>>>
>>>> Not sure how many times I have to say this before people stop
>>>> attempting to pass these kinds of relationships off as MFDs:
>>>>
>>>> A memory device and its bus is not an MFD.  In a similar vain to the
>>>> thousands of USB, I2C, SPI, PCI and the like devices that aren't MFDs
>>>> either.
>>>>
>>>> Please find another way to associate your device with its bus.
>>>
>>> This FMC2 is however an IP which can either operate external devices
>>> (like ethernet chip on this parallel bus) or external flashes (like NOR
>>> and NAND chips).
>>
>> I'm sure that it *can*.  Although that's not its main purpose.
> 
> I use it to operate KSZ8851-16MLL ethernet chip, which has async bus
> interface. Linux just didn't have support for that mode of operation
> thus far and the FMC was used to operate NANDs and NORs only. This
> series, or rather, the first three patches in this series, add support
> for operating other bus devices, like this ethernet controller.
> 
>> The
>> clue is in the nomenclature ("Flexible *Memory* Controller").  Nor is
>> it how the device is being used in this submission:
>>
>>    "The FMC2 functional block makes the interface with: synchronous and
>>     asynchronous static memories (such as PSNOR, PSRAM or other
>>     memory-mapped peripherals) and NAND flash memories."
>>
>> As I mentioned, this is just another memory device and its bus.
> 
> I don't think it's _just_ a memory controller, it's more universal than
> that, see above. Note that SRAM interface basically boils down to
> anything which has external parallel bus, e.g. Davicom DM9000, that
> KSZ8851-16MLL etc.
> 
>>> Can you provide a suggestion how this should be handled, if not as MFD?
>>> It seems to me, that this is a Multi-Function Device .
>>
>> Simply move it into the MTD or Memory subsystems and set up the
>> dependencies via Kconfig.
>>
>>> If this discussion is a recurring topic, is there some documentation
>>> which explains how such devices should be handled ?
>>
>> Not that I'm aware of.
> 
> I see.
>

Hi Lee, Marek,

I will move this source code in the FMC2 bus driver. I think that I 
should be able to manage the 2 controllers with 2 drivers (the FMC2 bus 
driver and the FMC2 raw NAND driver). I will have to modify some part of 
the proposed bindings, and some updates will have to be done in the FMC2 
bus driver. All these modifications will be part of V3.

Regards,
Christophe Kerello.
