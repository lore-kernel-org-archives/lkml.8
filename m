Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB17C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81D120936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgDQPbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:31:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57512 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgDQPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:31:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 493g7D0JF5z1rtyg;
        Fri, 17 Apr 2020 17:31:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 493g7C5ZqDz1qr4G;
        Fri, 17 Apr 2020 17:31:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id GUUUdMPMKaWa; Fri, 17 Apr 2020 17:31:50 +0200 (CEST)
X-Auth-Info: ukL+QQvR1R43aIroK+RGm7l/Kp938KyMrR7ZkknM+ig=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 17 Apr 2020 17:31:50 +0200 (CEST)
Subject: Re: [PATCH v2 03/12] bus: stm32-fmc2-ebi: add STM32 FMC2 EBI
 controller driver
To:     Christophe Kerello <christophe.kerello@st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-4-git-send-email-christophe.kerello@st.com>
 <20200416215328.53982fef@collabora.com>
 <e4a21df4-b01b-1215-7a3b-fea94f099b8f@st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <c69f86f4-5904-3f35-dac1-87080402a096@denx.de>
Date:   Fri, 17 Apr 2020 17:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e4a21df4-b01b-1215-7a3b-fea94f099b8f@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/20 5:29 PM, Christophe Kerello wrote:
> 
> 
> On 4/16/20 9:53 PM, Boris Brezillon wrote:
>> On Wed, 15 Apr 2020 17:57:27 +0200
>> Christophe Kerello <christophe.kerello@st.com> wrote:
>>
>>> The driver adds the support for the STMicroelectronics FMC2 EBI
>>> controller
>>> found on STM32MP SOCs.
>>>
>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>>> Tested-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Changes in v2:
>>>   - call 2 APIs to manage FMC2 enable/disable instead of ops
>>>   - call 2 APIs to manage FMC2 NWAIT shared signal instead of ops
>>>
>>>   drivers/bus/Kconfig          |   11 +
>>>   drivers/bus/Makefile         |    1 +
>>>   drivers/bus/stm32-fmc2-ebi.c | 1091
>>> ++++++++++++++++++++++++++++++++++++++++++
>>
>> Hm, I see that other memory bus controller drivers are placed under
>> drivers/memory/, any reason for choosing drivers/bus/? If that's where
>> we want to have all generic memory bus controllers to live it might be
>> worth moving existing drivers to the drivers/bus/ directory at some
>> point.
>>
> 
> Hi Boris,
> 
> I see this controller as an external bus interface as we are able to
> attach different devices on it, like a PSRAM, an ethernet controller, a
> FPGA, a LCD display, ...
> 
> When I had a look at bus/Kconfig file, I have found similar drivers
> (like IMX_WEIM or QCOM_EBI2 drivers). These drivers are able to connect
> devices like NAND Flash, SRAM, ethernet adapters, FPGAs and LCD displays
> as it is written in the Kconfig file.
> 
> But, after checking memory/Kconfig file, it is also possible to find
> similar drivers (like ATMEL_EBI driver that is inspired by the WEIM bus
> driver).
> 
> So, I will follow the recommendation and I will move it to
> drivers/memory folder if it is the place where this driver should be.

The EBI isn't a memory bus, you can very well have a non-memory device,
like an external parallel bus memory controller on it. So why should it
be in drivers/memory ?
