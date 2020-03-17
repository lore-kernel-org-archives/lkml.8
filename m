Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A687C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F095520719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCQK76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:59:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgCQK7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:59:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CC8CE9A663F0575FBBF9;
        Tue, 17 Mar 2020 18:59:51 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Mar 2020
 18:59:42 +0800
Subject: Re: [RFC PATCH v1 0/3] arm64: tlb: add support for TTL field
To:     Marc Zyngier <maz@kernel.org>
CC:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <aneesh.kumar@linux.ibm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
References: <20200311025309.1743-1-yezhenyu2@huawei.com>
 <247ad619edf17eb266f856d937dac826@kernel.org>
From:   "yezhenyu (A)" <yezhenyu2@huawei.com>
Message-ID: <e155d744-4433-b9a6-109f-f665316dd928@huawei.com>
Date:   Tue, 17 Mar 2020 18:59:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <247ad619edf17eb266f856d937dac826@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/3/11 17:12, Marc Zyngier wrote:
> Zhenyu,
> 
> On 2020-03-11 02:53, Zhenyu Ye wrote:
>> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
>> the level of translation table walk holding the leaf entry for the
>> address that is being invalidated. Hardware can use this information
>> to determine if there was a risk of splintering.
>>
>> This set of patches adds TTL field to __TLBI_ADDR, and uses
>> Architecture-specific MM context to pass the TTL value to tlb interface.
>>
>> The default value of TTL is 0, which will not have any impact on the
>> TLB maintenance instructions. The last patch trys to use TTL field in
>> some obviously tlb-flush interface.
> 
> I have already posted some support for ARMv8.4-TTL as part of my NV series [1],
> patches 62, 67, 68 and 69. This only deals with Stage-2 translation so far.
> If you intend to add Stage-1, please build on top of what I have already posted
> (I can extract the patches on a separate branch if you want).
> 
> Thanks,
> 
>         M.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-1-maz@kernel.org/

I have sent the PATCH v2 on 2020-03-12 [1]. Do you have any suggestion
for my code?  Is it appropriate to post my code based on your branch?

Looking forward to your suggestions.


Thanks,

	zhenyu

[1] https://lkml.org/lkml/2020/3/12/2
	

