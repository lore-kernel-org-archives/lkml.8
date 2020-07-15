Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BE4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1E42064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hb1ZgT3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgGOKDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:03:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42996 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgGOKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:03:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06FA3ZgQ077606;
        Wed, 15 Jul 2020 05:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594807415;
        bh=D8larl3dbl+PbJ+v/s4nG0qJPsOOHSv+qrhP1WAczxM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Hb1ZgT3TLKYhl5M4Txj3DYgLlwHLZAh3XPgepFezpiD8jYBF92iAcMW54ziNRfY5v
         jFEo4v0F8mQDD8mnYHtMd7xjB48KUObELJ4EBkC4/AQ6rQKoORLGLb/sjyykORONrp
         pJ9xNDNoh3vsRT/PBkVQxVRUNGo/byPT/HDendkM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06FA3Z8w106910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 05:03:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 15
 Jul 2020 05:03:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 15 Jul 2020 05:03:35 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06FA3VY6105664;
        Wed, 15 Jul 2020 05:03:32 -0500
Subject: Re: [PATCH] arm64: arch_k3: enable chipid driver
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Will Deacon <will@kernel.org>,
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
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <cf3aa171-fb75-b118-ea02-eb380b48b0cf@ti.com>
Date:   Wed, 15 Jul 2020 13:03:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5529a5b2-f929-76fe-d27f-43d3e0432b43@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 07/07/2020 10:02, Peter Ujfalusi wrote:
> On 01/07/2020 13.18, Grygorii Strashko wrote:
>> On 19/06/2020 19:25, Grygorii Strashko wrote:
>>> Select TI chip id driver for TI's SoCs based on K3 architecture to
>>> provide
>>> this information to user space and Kernel as it is required by other
>>> drivers to determine SoC revision to function properly.
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> ---
>>>    arch/arm64/Kconfig.platforms | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>> index 8dd05b2a925c..1d3710e3626a 100644
>>> --- a/arch/arm64/Kconfig.platforms
>>> +++ b/arch/arm64/Kconfig.platforms
>>> @@ -98,6 +98,7 @@ config ARCH_K3
>>>        select TI_SCI_PROTOCOL
>>>        select TI_SCI_INTR_IRQCHIP
>>>        select TI_SCI_INTA_IRQCHIP
>>> +    select TI_K3_SOCINFO
>>>        help
>>>          This enables support for Texas Instruments' K3 multicore SoC
>>>          architecture.
>>>
>>
>> Are there any comments?
> 
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
>> The driver and dt changes were merged [1][2] and for adding new am654x SoC
>> revision SR2.0 we need this driver to be enabled always as other drivers
>> are
>> going to use SOC Bus API intensively.
>>
>> No dependencies.
>>
>> [1]
>> https://lore.kernel.org/lkml/20200512123449.16517-1-grygorii.strashko@ti.com/
>>
>> [2]
>> https://lore.kernel.org/lkml/20200613164346.28852-1-grygorii.strashko@ti.com/
>>

Any chances it can be applied for 5.9?


Thank you.
-- 
Best regards,
grygorii
