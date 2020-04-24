Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D5C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9384A2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cba/kur7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgDXQni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:43:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9730 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbgDXQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:43:37 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OGbOfX004529;
        Fri, 24 Apr 2020 18:43:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=PLCBR/0LsB/9qRzLc0EfWDTDQckjp7MG8NRjJdLWuGo=;
 b=cba/kur7T3oK3eHTO5riac9CUGH4UD9hV/VsGq0htRODrtDcHSow/itRRfaoxLSvyLHv
 4uRbYElcIw79SLs7QmjhPgioclZ+Z7urFPWNeqPUa8iwppNwCl/6MrX4IH727yRRuJn7
 mQcGgdS78JPgMzEOZY/zcfJvTB/+B0zv2IfDlX/xSi0boItMDcdA0ufhueajVrv09tc0
 qfNEOcLdfpA/4WuDRraf5a6YT8ddu+I8AWH3JDoiNEuRgLz08WdRvgKO3FnrYjSELucK
 1XQCEy0LnOddw/bbbVdronw6jodFz9GnC+6arDcCg6jXa90m4F7Yr2vbWEMhsvUH9Est cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fqawv4uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 18:43:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D48D6100034;
        Fri, 24 Apr 2020 18:43:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4FCE2C322C;
        Fri, 24 Apr 2020 18:43:02 +0200 (CEST)
Received: from [10.211.2.59] (10.75.127.48) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Apr
 2020 18:43:00 +0200
Subject: Re: [PATCH v2 02/12] mfd: stm32-fmc2: add STM32 FMC2 controller
 driver
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <vigneshr@ti.com>, <tony@atomide.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-3-git-send-email-christophe.kerello@st.com>
 <20200424074517.GN3612@dell> <8b625f1c-9ded-c07a-a20e-8cd44c1ca46d@denx.de>
 <20200424105053.GC8414@dell> <e5e6c279-28d0-f423-aa6d-5c7aca563352@denx.de>
 <268ea231-eb4a-6144-c632-1bc8e9f21582@st.com>
 <20200424171412.5f65ff05@collabora.com>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <b136632f-51ce-f72e-f145-1b6b4cba485c@st.com>
Date:   Fri, 24 Apr 2020 18:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200424171412.5f65ff05@collabora.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_08:2020-04-24,2020-04-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 5:14 PM, Boris Brezillon wrote:
> On Fri, 24 Apr 2020 13:47:34 +0200
> Christophe Kerello <christophe.kerello@st.com> wrote:
> 
>> On 4/24/20 1:06 PM, Marek Vasut wrote:
>>> On 4/24/20 12:50 PM, Lee Jones wrote:
>>>> On Fri, 24 Apr 2020, Marek Vasut wrote:
>>>>   
>>>>> On 4/24/20 9:45 AM, Lee Jones wrote:
>>>>>> On Wed, 15 Apr 2020, Christophe Kerello wrote:
>>>>>>   
>>>>>>> The driver adds the support for the STMicroelectronics FMC2 controller
>>>>>>> found on STM32MP SOCs.
>>>>>>>
>>>>>>> The FMC2 functional block makes the interface with: synchronous and
>>>>>>> asynchronous static memories (such as PSNOR, PSRAM or other
>>>>>>> memory-mapped peripherals) and NAND flash memories.
>>>>>>>
>>>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>>    - remove ops from stm32_fmc2 structure
>>>>>>>    - add 2 APIs to manage FMC2 enable/disable
>>>>>>>    - add 2 APIs to manage FMC2 NWAIT shared signal
>>>>>>>
>>>>>>>    drivers/mfd/Kconfig            |  12 +++
>>>>>>>    drivers/mfd/Makefile           |   1 +
>>>>>>>    drivers/mfd/stm32-fmc2.c       | 136 +++++++++++++++++++++++++
>>>>>>>    include/linux/mfd/stm32-fmc2.h | 225 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>    4 files changed, 374 insertions(+)
>>>>>>>    create mode 100644 drivers/mfd/stm32-fmc2.c
>>>>>>>    create mode 100644 include/linux/mfd/stm32-fmc2.h
>>>>>>>
>>>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>>>> index 2b20329..5260582 100644
>>>>>>> --- a/drivers/mfd/Kconfig
>>>>>>> +++ b/drivers/mfd/Kconfig
>>>>>>> @@ -1922,6 +1922,18 @@ config MFD_ROHM_BD71828
>>>>>>>    	  Also included is a Coulomb counter, a real-time clock (RTC), and
>>>>>>>    	  a 32.768 kHz clock gate.
>>>>>>>    
>>>>>>> +config MFD_STM32_FMC2
>>>>>>> +	tristate "Support for FMC2 controllers on STM32MP SoCs"
>>>>>>> +	depends on MACH_STM32MP157 || COMPILE_TEST
>>>>>>> +	select MFD_CORE
>>>>>>> +	select REGMAP
>>>>>>> +	select REGMAP_MMIO
>>>>>>> +	help
>>>>>>> +	  Select this option to enable STM32 FMC2 driver used for FMC2 External
>>>>>>> +	  Bus Interface controller and FMC2 NAND flash controller. This driver
>>>>>>> +	  provides core support for the STM32 FMC2 controllers, in order to use
>>>>>>> +	  the actual functionality of the device other drivers must be enabled.
>>>>>>
>>>>>> Not sure how many times I have to say this before people stop
>>>>>> attempting to pass these kinds of relationships off as MFDs:
>>>>>>
>>>>>> A memory device and its bus is not an MFD.  In a similar vain to the
>>>>>> thousands of USB, I2C, SPI, PCI and the like devices that aren't MFDs
>>>>>> either.
>>>>>>
>>>>>> Please find another way to associate your device with its bus.
>>>>>
>>>>> This FMC2 is however an IP which can either operate external devices
>>>>> (like ethernet chip on this parallel bus) or external flashes (like NOR
>>>>> and NAND chips).
>>>>
>>>> I'm sure that it *can*.  Although that's not its main purpose.
>>>
>>> I use it to operate KSZ8851-16MLL ethernet chip, which has async bus
>>> interface. Linux just didn't have support for that mode of operation
>>> thus far and the FMC was used to operate NANDs and NORs only. This
>>> series, or rather, the first three patches in this series, add support
>>> for operating other bus devices, like this ethernet controller.
>>>    
>>>> The
>>>> clue is in the nomenclature ("Flexible *Memory* Controller").  Nor is
>>>> it how the device is being used in this submission:
>>>>
>>>>     "The FMC2 functional block makes the interface with: synchronous and
>>>>      asynchronous static memories (such as PSNOR, PSRAM or other
>>>>      memory-mapped peripherals) and NAND flash memories."
>>>>
>>>> As I mentioned, this is just another memory device and its bus.
>>>
>>> I don't think it's _just_ a memory controller, it's more universal than
>>> that, see above. Note that SRAM interface basically boils down to
>>> anything which has external parallel bus, e.g. Davicom DM9000, that
>>> KSZ8851-16MLL etc.
>>>    
>>>>> Can you provide a suggestion how this should be handled, if not as MFD?
>>>>> It seems to me, that this is a Multi-Function Device .
>>>>
>>>> Simply move it into the MTD or Memory subsystems and set up the
>>>> dependencies via Kconfig.
>>>>   
>>>>> If this discussion is a recurring topic, is there some documentation
>>>>> which explains how such devices should be handled ?
>>>>
>>>> Not that I'm aware of.
>>>
>>> I see.
>>>   
>>
>> Hi Lee, Marek,
>>
>> I will move this source code in the FMC2 bus driver. I think that I
>> should be able to manage the 2 controllers with 2 drivers (the FMC2 bus
>> driver and the FMC2 raw NAND driver).
> 
> FWIW, that's what I did for the Atmel EBI (External Bus Interface)
> controller (see [1]).
> 
> [1]https://elixir.bootlin.com/linux/v5.6/source/drivers/memory/atmel-ebi.c
> 

Hi Boris,

Thanks for your help.

I was thinking about the bindings and I think that the bindings below 
are close to what has been done for Atmel EBI/Raw NAND bindings (in 
terms of structure of bindings if I have well understood).
I think that these proposed bindings are very close to the first 
proposed version (V1/V2).

     fmc@58002000 {
       #address-cells = <2>;
       #size-cells = <1>;
       compatible = "st,stm32mp1-fmc2";
       reg = <0x58002000 0x1000>;
       clocks = <&rcc FMC_K>;
       resets = <&rcc FMC_R>;

       ranges = <0 0 0x60000000 0x4000000>, /* EBI bank 1 */
                <1 0 0x64000000 0x4000000>, /* EBI bank 2 */
                <2 0 0x68000000 0x4000000>, /* EBI bank 3 */
                <3 0 0x6c000000 0x4000000>, /* EBI bank 4 */
                <4 0 0x80000000 0x4000000>, /* NAND common memory space */
                <5 0 0x88000000 0x4000000>; /* NAND attribute memory 
space */
	
       psram@0 {
         compatible = "mtd-ram";
         reg = <0 0x00000000 0x100000>;
         bank-width = <2>;

         st,fmc2_ebi_cs_transaction_type = <1>;
         st,fmc2_ebi_cs_address_setup = <60>;
         st,fmc2_ebi_cs_data_setup = <30>;
         st,fmc2_ebi_cs_bus_turnaround = <5>;
       };

       nand-controller@4 {
         #address-cells = <1>;
         #size-cells = <0>;
         compatible = "st,stm32mp15-fmc2";
         reg = <4 0x00000000 0x1000>,
               <5 0x00010000 0x1000>,
               <5 0x00020000 0x1000>,
               <4 0x01000000 0x1000>,
               <5 0x01010000 0x1000>,
               <5 0x01020000 0x1000>;
         interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
         dmas = <&mdma1 20 0x2 0x12000a02 0x0 0x0>,
                <&mdma1 20 0x2 0x12000a08 0x0 0x0>,
                <&mdma1 21 0x2 0x12000a0a 0x0 0x0>;
         dma-names = "tx", "rx", "ecc";

         nand@0 {
           reg = <0>;
           nand-on-flash-bbt;
           #address-cells = <1>;
           #size-cells = <1>;
         };
       };
     };

Regards,
Christophe Kerello.

