Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A579FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797092245F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xs8pQ0Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgFVHkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:40:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56648 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbgFVHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:40:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05M7dnKn051599;
        Mon, 22 Jun 2020 02:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592811589;
        bh=fCZLwQLl1dKhVCSvVo/xXTvv6C6GozmwvIPOhBfSi/E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Xs8pQ0Q/z2kF47RXVYwcxp3ebVDuwTw5B53iXjLItRa1zbNtLMqK7u3ccbqJhWp9Q
         WO7zQb1pQDNBRko6aWK8U15hduAmgqEvWpXRqnH9/D4yIa0Ijzlzd89y7JjbsPPEBE
         bcFzG5wP6I8wmXh4o9BE7FWaobdC3yMkCocAPJpw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05M7dni8071605
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 02:39:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Jun 2020 02:39:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Jun 2020 02:39:48 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05M7dkWn038301;
        Mon, 22 Jun 2020 02:39:47 -0500
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3: add platforms chipid module nodes
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Dave Gerlach <d-gerlach@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200613164346.28852-1-grygorii.strashko@ti.com>
 <8b8f7f92-571d-4a44-4858-7d79676a6375@ti.com>
 <1dcd2e6c-924d-8151-8100-0b42f154a59c@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <35f0f680-f612-0c14-024c-7f2251650d85@ti.com>
Date:   Mon, 22 Jun 2020 10:39:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1dcd2e6c-924d-8151-8100-0b42f154a59c@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2020 19:26, Grygorii Strashko wrote:
> 
> 
> On 15/06/2020 10:47, Peter Ujfalusi wrote:
>> Hi Grygorii,
>>
>> On 13/06/2020 19.43, Grygorii Strashko wrote:
>>> Hi Tero,
>>>
>>> Hence k3 platforms chipid module driver was merged, there is follow 
>>> up series
>>> to add corresponding DT chipid nodes.
>>>
>>> [1] https://lkml.org/lkml/2020/5/29/979
>>>
>>> Grygorii Strashko (2):
>>>    arm64: dts: ti: k3-am65-wakeup: add k3 platforms chipid module node
>>>    arm64: dts: ti: k3-j721e-mcu-wakeup: add k3 platforms chipid 
>>> module node
>>
>> Can you also send a patch to enable the socinfo build?
> 
> Posted.
> 
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 8dd05b2a925c..1d3710e3626a 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -98,6 +98,7 @@ config ARCH_K3
>>       select TI_SCI_PROTOCOL
>>       select TI_SCI_INTR_IRQCHIP
>>       select TI_SCI_INTA_IRQCHIP
>> +    select TI_K3_SOCINFO
>>       help
>>         This enables support for Texas Instruments' K3 multicore SoC
>>         architecture.
>>
>> With this added:
>> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tero: FYI. There is no dependecies for this series.

Queued for 5.9, thanks.

-Tero

> 
> Best regards,
> grygorii

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
