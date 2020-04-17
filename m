Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E09C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B14220857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgDQPoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:44:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46560 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgDQPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:44:46 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 493gQ33mVFz1qs3y;
        Fri, 17 Apr 2020 17:44:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 493gQ31pDhz1qr4G;
        Fri, 17 Apr 2020 17:44:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id pu2rDxhfP016; Fri, 17 Apr 2020 17:44:41 +0200 (CEST)
X-Auth-Info: EiS9QEFo0KzXwC4rFmeq9CTThwEot7Y2z7NEORWW5mE=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 17 Apr 2020 17:44:41 +0200 (CEST)
Subject: Re: [PATCH v2 03/12] bus: stm32-fmc2-ebi: add STM32 FMC2 EBI
 controller driver
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-4-git-send-email-christophe.kerello@st.com>
 <20200416215328.53982fef@collabora.com>
 <e4a21df4-b01b-1215-7a3b-fea94f099b8f@st.com>
 <c69f86f4-5904-3f35-dac1-87080402a096@denx.de>
 <20200417174140.00456f36@collabora.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <53011403-49c4-dfcb-2f8c-11cf1ac5e2c1@denx.de>
Date:   Fri, 17 Apr 2020 17:44:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200417174140.00456f36@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/20 5:41 PM, Boris Brezillon wrote:
> On Fri, 17 Apr 2020 17:31:49 +0200
> Marek Vasut <marex@denx.de> wrote:
> 
>> On 4/17/20 5:29 PM, Christophe Kerello wrote:
>>>
>>>
>>> On 4/16/20 9:53 PM, Boris Brezillon wrote:  
>>>> On Wed, 15 Apr 2020 17:57:27 +0200
>>>> Christophe Kerello <christophe.kerello@st.com> wrote:
>>>>  
>>>>> The driver adds the support for the STMicroelectronics FMC2 EBI
>>>>> controller
>>>>> found on STM32MP SOCs.
>>>>>
>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>>>>> Tested-by: Marek Vasut <marex@denx.de>
>>>>> ---
>>>>> Changes in v2:
>>>>>   - call 2 APIs to manage FMC2 enable/disable instead of ops
>>>>>   - call 2 APIs to manage FMC2 NWAIT shared signal instead of ops
>>>>>
>>>>>   drivers/bus/Kconfig          |   11 +
>>>>>   drivers/bus/Makefile         |    1 +
>>>>>   drivers/bus/stm32-fmc2-ebi.c | 1091
>>>>> ++++++++++++++++++++++++++++++++++++++++++  
>>>>
>>>> Hm, I see that other memory bus controller drivers are placed under
>>>> drivers/memory/, any reason for choosing drivers/bus/? If that's where
>>>> we want to have all generic memory bus controllers to live it might be
>>>> worth moving existing drivers to the drivers/bus/ directory at some
>>>> point.
>>>>  
>>>
>>> Hi Boris,
>>>
>>> I see this controller as an external bus interface as we are able to
>>> attach different devices on it, like a PSRAM, an ethernet controller, a
>>> FPGA, a LCD display, ...
>>>
>>> When I had a look at bus/Kconfig file, I have found similar drivers
>>> (like IMX_WEIM or QCOM_EBI2 drivers). These drivers are able to connect
>>> devices like NAND Flash, SRAM, ethernet adapters, FPGAs and LCD displays
>>> as it is written in the Kconfig file.
>>>
>>> But, after checking memory/Kconfig file, it is also possible to find
>>> similar drivers (like ATMEL_EBI driver that is inspired by the WEIM bus
>>> driver).
>>>
>>> So, I will follow the recommendation and I will move it to
>>> drivers/memory folder if it is the place where this driver should be.  
>>
>> The EBI isn't a memory bus, you can very well have a non-memory device,
>> like an external parallel bus memory controller on it. So why should it
>> be in drivers/memory ?
> 
> Just like most of those so-called memory bus controllers we have under
> drivers/memory/ => they are most of the time used to interact with
> memories but can also be used for other things (Christophe listed a few
> uses cases). And I'm not pushing one way or the other, all I said was
> that we should makes things consistent instead of having half of
> those controller drivers in drivers/memory/ and the other half in
> drivers/bus/.

I agree with that.
