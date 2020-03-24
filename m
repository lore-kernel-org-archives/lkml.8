Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8353BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C64206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pXhARpHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCXNiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:38:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52364 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbgCXNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:38:07 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ODbei2031397;
        Tue, 24 Mar 2020 14:37:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=eQiuzCr6Ulml5kiC7ssdMbg0RnTvDoNBvb95ESMzd7k=;
 b=pXhARpHcYUw1u0xicEqkY8jwk47it6F2IN97o5tr8n+DGklTajANxqS47Wvl0A8Md8xD
 ErkOxHIhcq6uOJVneWyRi4uChPbNhqpcXiPuH5kN25bXXCjpW5FCdzumeRHB8qWTjtT4
 8VPevQumwFWIs7euwQbd+asr3dnBeSB+k57oXhXLG8yabniuZI8HBGEncFMGE1jFYcak
 PjmIlGDjY9jM2Jr5HvmiFYG+VmBEon3YriqkueuWnuADN9WtChY1ksBjdN/OiA6Gtt+J
 iFxU4Ugzm8lX+WNy67KgN8YMdTWRhDUvjbUjfZMnHvTXlgp8nILeP63TWIIhPdnORZBo Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw995fsx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 14:37:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8ED5100039;
        Tue, 24 Mar 2020 14:37:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A47722AE6A4;
        Tue, 24 Mar 2020 14:37:48 +0100 (CET)
Received: from [10.211.5.183] (10.75.127.49) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Mar
 2020 14:37:46 +0100
Subject: Re: [00/12] add STM32 FMC2 controller drivers
To:     Marek Vasut <marex@denx.de>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
 <466cf542-7575-d791-da81-da32c0919505@denx.de>
 <156b55b5-1b09-fa7e-e3bc-a0d5dea870db@st.com>
 <6827412d-1350-5daf-6882-41dc2a9307e5@denx.de>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <dba36415-824f-fab7-ad97-f9f5d804435d@st.com>
Date:   Tue, 24 Mar 2020 14:37:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6827412d-1350-5daf-6882-41dc2a9307e5@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/20 2:27 PM, Marek Vasut wrote:
> On 3/24/20 8:36 AM, Christophe Kerello wrote:
>>
>>
>> On 3/24/20 1:37 AM, Marek Vasut wrote:
>>> On 3/23/20 3:58 PM, Christophe Kerello wrote:
>>>> The FMC2 functional block makes the interface with: synchronous and
>>>> asynchronous static devices (such as PSNOR, PSRAM or other memory-mapped
>>>> peripherals) and NAND flash memories.
>>>> Its main purposes are:
>>>>     - to translate AXI transactions into the appropriate external device
>>>>       protocol
>>>>     - to meet the access time requirements of the external devices
>>>> All external devices share the addresses, data and control signals
>>>> with the
>>>> controller. Each external device is accessed by means of a unique Chip
>>>> Select. The FMC2 performs only one access at a time to an external
>>>> device.
>>>>
>>>> Christophe Kerello (12):
>>>>     dt-bindings: mfd: stm32-fmc2: add STM32 FMC2 controller documentation
>>>>     mfd: stm32-fmc2: add STM32 FMC2 controller driver
>>>>     bus: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
>>>>     mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
>>>>     mtd: rawnand: stm32_fmc2: remove useless inline comments
>>>>     mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
>>>>     mtd: rawnand: stm32_fmc2: cleanup
>>>>     mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros
>>>>     mtd: rawnand: stm32_fmc2: move all registers
>>>>     mtd: rawnand: stm32_fmc2: use regmap APIs
>>>>     mtd: rawnand: stm32_fmc2: use stm32_fmc2 structure in nfc controller
>>>>     mtd: rawnand: stm32_fmc2: add new MP1 compatible string
>>>
>>> This doesn't apply to either next or 5.6-rc7, do you have a tree
>>> somewhere with those patches applied ?
>>>
>>
>> Hi Marek,
> 
> Hi,
> 
>> This implementation has been done on mtd/nand/next branch.
> 
> Of which tree ?
> 

Hi Marek,

I am using https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git

Regards,
Christophe Kerello.
