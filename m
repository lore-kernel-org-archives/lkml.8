Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA222151B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgE1BfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:35:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgE1BfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:35:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4A5E2CDD85FBA056B940;
        Thu, 28 May 2020 09:35:19 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 28 May 2020
 09:35:12 +0800
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier for
 userspace
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        "Rob Herring" <robh@kernel.org>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
 <20200519185125.GB453195@bogus> <20200520073304.GA23534@willie-the-truck>
 <CAL_JsqJfQ0PFy5mmwSG4aM91ghq5xiAEPR2YZOymws+BfGa+uA@mail.gmail.com>
 <20200521130415.GB5949@willie-the-truck>
 <c3be06c5-781f-384f-768b-d809da99b7e0@huawei.com>
 <51aa7cbc-0ce2-b96d-b056-fcc6013ccecf@huawei.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        "Joakim Zhang" <qiangqing.zhang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <36a5bf0c-fcf5-ad74-b5ee-1b4502705aec@hisilicon.com>
Date:   Thu, 28 May 2020 09:35:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <51aa7cbc-0ce2-b96d-b056-fcc6013ccecf@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/5/27 22:34, John Garry wrote:
>>>>>
>>>>> I also really dislike this. What's the preferred way to identify the SoC
>>>>> from userspace?
>>>>
>>>> /proc/cpuinfo? ;)
>>>
>>> The *SoC*!
>>>
>>>> For an non-firmware specific case, I'd say soc_device should be. I'd
>>>> guess ACPI systems don't use it and for them it's dmidecode typically.
>>>> The other problem I have with soc_device is it is optional.
>>>
>>
>> Hi Will,
>>
>>> John -- what do you think about using soc_device to expose this information,
>>> with ACPI systems using DMI data instead?
>>
>> Generally I don't think that DMI is reliable, and I saw this as the least preferred choice. I'm looking at the sysfs DMI info for my dev board, and I don't even see anything like a SoC identifier.
>>
>> As for the event_source device sysfs identifier file, it would not always contain effectively the same as the SoC ID.
>>
>> Certain PMUs which I'm interested in plan to have probe-able identification info available in future.
>>
> 
> BTW, Shaokun now tells me that the HiSi uncore PMU HW have such registers to identify the implementation. I didn't know.
> 

Right, we have this register which shows the PMU version.

Thanks,
Shaokun


> So we could add that identifier file for those PMUs as proof-of-concept, exposing that register.
> 
> As for other PMUs which I'm interested in, again, future versions should have such registers to self-identify.
> 
> So using something derived from the DT compat string would hopefully be the uncommon case.
> 
> Cheers,
> John
> 
> .
> 

