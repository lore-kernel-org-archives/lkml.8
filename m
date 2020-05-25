Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF68DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30FE2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbgEYGzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:55:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388385AbgEYGzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:55:03 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2471DDA1EE3F82EA9BC0;
        Mon, 25 May 2020 14:55:01 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 25 May 2020
 14:54:53 +0800
Subject: Re: [PATCH v2 2/6] arm64: Add level-hinted TLB invalidation helper
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <akpm@linux-foundation.org>,
        <npiggin@gmail.com>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-3-yezhenyu2@huawei.com> <20200522155017.GG26492@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <3852291c-37cf-39b6-564d-8b4f50f9d86e@huawei.com>
Date:   Mon, 25 May 2020 14:54:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200522155017.GG26492@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/22 23:50, Catalin Marinas wrote:
> On Thu, Apr 23, 2020 at 09:56:52PM +0800, Zhenyu Ye wrote:
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index bc3949064725..5f9f189bc6d2 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -10,6 +10,7 @@
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> +#include <linux/bitfield.h>
>>  #include <linux/mm_types.h>
>>  #include <linux/sched.h>
>>  #include <asm/cputype.h>
>> @@ -59,6 +60,35 @@
>>  		__ta;						\
>>  	})
>>  
>> +#define TLBI_TTL_MASK	GENMASK_ULL(47, 44)
>> +
>> +#define __tlbi_level(op, addr, level)					\
>> +	do {								\
> 
> Nitpick: move "do {" on the same line as __tlbi_level() to reduce the
> indentation levels of the whole block.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 

OK.

