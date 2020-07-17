Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF95C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9FF20775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qzxIl9xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgGQNon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:44:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50372 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgGQNom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:44:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDiYd2116560;
        Fri, 17 Jul 2020 08:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594993474;
        bh=SMXuWJsxmjPAyDIe0p0NeiPV/Q2TG3sFLtbT/0PqEnY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qzxIl9xXQKM6im7cQ5vM1Tw31Um4DZ0oONxaswNz4lHb/NF4LJGCzeIjw3jwZrxkG
         LVy7qIxwoLVf3jsOmYtH34ehFpCKH7F1hNaoCzkKD2RL3Wv19gus4cs9rVkFA+NkGG
         GcINGjzBsnmjVmy7/hVDiRKVOzAFKA9mH7KQ+FaA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HDiXdP057305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 08:44:33 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:44:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:44:33 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDiR2r061930;
        Fri, 17 Jul 2020 08:44:29 -0500
Subject: Re: [PATCH] arm64: arch_k3: enable chipid driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20200619162527.1226-1-grygorii.strashko@ti.com>
 <4bbdfff6-8fba-0568-b243-5da9ee6e29b6@ti.com>
 <5529a5b2-f929-76fe-d27f-43d3e0432b43@ti.com>
 <cf3aa171-fb75-b118-ea02-eb380b48b0cf@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <00f4fd6e-a21d-6100-ee28-1a31f4e16d1d@ti.com>
Date:   Fri, 17 Jul 2020 16:44:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cf3aa171-fb75-b118-ea02-eb380b48b0cf@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 13:03, Grygorii Strashko wrote:
> Hi All,
> 
> On 07/07/2020 10:02, Peter Ujfalusi wrote:
>> On 01/07/2020 13.18, Grygorii Strashko wrote:
>>> On 19/06/2020 19:25, Grygorii Strashko wrote:
>>>> Select TI chip id driver for TI's SoCs based on K3 architecture to
>>>> provide
>>>> this information to user space and Kernel as it is required by other
>>>> drivers to determine SoC revision to function properly.
>>>>
>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>> ---
>>>>    arch/arm64/Kconfig.platforms | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig.platforms 
>>>> b/arch/arm64/Kconfig.platforms
>>>> index 8dd05b2a925c..1d3710e3626a 100644
>>>> --- a/arch/arm64/Kconfig.platforms
>>>> +++ b/arch/arm64/Kconfig.platforms
>>>> @@ -98,6 +98,7 @@ config ARCH_K3
>>>>        select TI_SCI_PROTOCOL
>>>>        select TI_SCI_INTR_IRQCHIP
>>>>        select TI_SCI_INTA_IRQCHIP
>>>> +    select TI_K3_SOCINFO
>>>>        help
>>>>          This enables support for Texas Instruments' K3 multicore SoC
>>>>          architecture.
>>>>
>>>
>>> Are there any comments?
>>
>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>>> The driver and dt changes were merged [1][2] and for adding new 
>>> am654x SoC
>>> revision SR2.0 we need this driver to be enabled always as other drivers
>>> are
>>> going to use SOC Bus API intensively.
>>>
>>> No dependencies.
>>>
>>> [1]
>>> https://lore.kernel.org/lkml/20200512123449.16517-1-grygorii.strashko@ti.com/ 
>>>
>>>
>>> [2]
>>> https://lore.kernel.org/lkml/20200613164346.28852-1-grygorii.strashko@ti.com/ 
>>>
>>>
> 
> Any chances it can be applied for 5.9?

Queuing up for 5.9, thanks.

Sorry there has been some confusion on my behalf regarding the config 
changes.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
