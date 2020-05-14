Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D675C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669F020675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cIxk/9B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgENQfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:35:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36512 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgENQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:35:23 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EGX9LD016146;
        Thu, 14 May 2020 18:34:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=6CWTZEVuPSh18Gx/dEw+pHe2HNLYt2f856wC0oo8ZZs=;
 b=cIxk/9B0oAGAeKm62YX9t0NG7W/KMHFKjA5dyFQF37+EeX0MB4mo0hNR4z/RS8e0b5vR
 EdJL3EODjAONumZPR8ECm+MFUHtLVBnomkx0w9QNoSpV2Il2jUWBDGAnKF8O/KghUqBa
 45EzhCuopvvmzsYCHsaiqJxy4cFetWdNLv8TP4OZYjOMgMRd28/g/prkc6U3IkGv7SMC
 wgZbBxMcoIT1SpJcq3EEhwB2mXiiLIewFd0MeSoGcporBlDjWaeFGQti9NpJrSmm7xqB
 /OfUcZj72DSxJ5ax8frY5vrK9eYTkAEcbbwHn6+LKTMR71MFvsPoDebwVYr8WggjsSeZ 2Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vymmu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 18:34:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C044A10002A;
        Thu, 14 May 2020 18:34:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AACFD2A7CEA;
        Thu, 14 May 2020 18:34:51 +0200 (CEST)
Received: from [10.211.8.23] (10.75.127.45) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 May
 2020 18:34:49 +0200
Subject: Re: [PATCH v4 06/10] dt-bindings: mtd: update STM32 FMC2 NAND
 controller documentation
To:     Rob Herring <robh@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
 <1588756279-17289-7-git-send-email-christophe.kerello@st.com>
 <20200514150028.GB28489@bogus>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <9ffc04cf-137f-5ee5-57ff-39a876abfb34@st.com>
Date:   Thu, 14 May 2020 18:34:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200514150028.GB28489@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 5/14/20 5:00 PM, Rob Herring wrote:
> On Wed, May 06, 2020 at 11:11:15AM +0200, Christophe Kerello wrote:
>> These bindings can be used on SOCs where the FMC2 NAND controller is
>> in standalone. In case that the FMC2 embeds 2 controllers (an external
>> bus controller and a raw NAND controller), the register base and the
>> clock will be defined in the parent node. It is the reason why the
>> register base address and the clock are now optional.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
>>   .../devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml   | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
>> index b059267..68fac1a 100644
>> --- a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
>> @@ -18,13 +18,15 @@ properties:
>>   
>>     reg:
>>       items:
>> -      - description: Registers
>> +      - description: Registers (optional)
> 
> The only thing that can be optional are the last entries. You have to do
> a 'oneOf' with 6 entries and 7 entries.

Ok, so the way to describe the reg property in my case should be:
        reg:
          oneOf:
            - description: FMC2 embeds the NFC controller in standalone.
              items:
                - description: Registers
                - description: Chip select 0 data
                - description: Chip select 0 command
                - description: Chip select 0 address space
                - description: Chip select 1 data
                - description: Chip select 1 command
                - description: Chip select 1 address space

            - description: FMC2 embeds the NFC controller and the EBI
                controller.
              items:
                - description: Chip select 0 data
                - description: Chip select 0 command
                - description: Chip select 0 address space
                - description: Chip select 1 data
                - description: Chip select 1 command
                - description: Chip select 1 address space

> 
> And where's your new compatible string for this different h/w?

 From NFC controller point of view, it is the same HW.
In the case that we have 2 controllers embedded, the register base is 
shared.
The NFC driver will check at probe time the compatible string of its 
parent node.
In case that it is "st,stm32mp1-fmc2-ebi", then the driver will find the 
register base in the parent node (EBI node), otherwise it will find it 
in the NFC node.
Is it better to have 2 compatible strings (one for each reg description) 
than checking the parent's compatible string and have only one 
compatible string?

Regards,
Christophe Kerello.

> 
>>         - description: Chip select 0 data
>>         - description: Chip select 0 command
>>         - description: Chip select 0 address space
>>         - description: Chip select 1 data
>>         - description: Chip select 1 command
>>         - description: Chip select 1 address space
>> +    minItems: 6
>> +    maxItems: 7
>>   
>>     interrupts:
>>       maxItems: 1
>> @@ -61,7 +63,6 @@ required:
>>     - compatible
>>     - reg
>>     - interrupts
>> -  - clocks
>>   
>>   examples:
>>     - |
>> @@ -77,13 +78,13 @@ examples:
>>               <0x81000000 0x1000>,
>>               <0x89010000 0x1000>,
>>               <0x89020000 0x1000>;
>> -            interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>> -            dmas = <&mdma1 20 0x10 0x12000a02 0x0 0x0>,
>> -                   <&mdma1 20 0x10 0x12000a08 0x0 0x0>,
>> -                   <&mdma1 21 0x10 0x12000a0a 0x0 0x0>;
>> -            dma-names = "tx", "rx", "ecc";
>> -            clocks = <&rcc FMC_K>;
>> -            resets = <&rcc FMC_R>;
>> +      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>> +      dmas = <&mdma1 20 0x2 0x12000a02 0x0 0x0>,
>> +             <&mdma1 20 0x2 0x12000a08 0x0 0x0>,
>> +             <&mdma1 21 0x2 0x12000a0a 0x0 0x0>;
>> +      dma-names = "tx", "rx", "ecc";
>> +      clocks = <&rcc FMC_K>;
>> +      resets = <&rcc FMC_R>;
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>>   
>> -- 
>> 1.9.1
>>
