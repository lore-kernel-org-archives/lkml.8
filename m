Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E4CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2612087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgH0PXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:23:14 -0400
Received: from foss.arm.com ([217.140.110.172]:57090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgH0L36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:29:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57705106F;
        Thu, 27 Aug 2020 04:05:17 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 373753F68F;
        Thu, 27 Aug 2020 04:05:15 -0700 (PDT)
Subject: Re: [PATCH 28/35] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1597425745.git.andreyknvl@google.com>
 <07455abaab13824579c1b8e50cc038cf8a0f3369.1597425745.git.andreyknvl@google.com>
 <20200827104147.GG29264@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c0319233-8985-8cc7-ea72-910b42b2b5d0@arm.com>
Date:   Thu, 27 Aug 2020 12:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827104147.GG29264@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/20 11:41 AM, Catalin Marinas wrote:
> On Fri, Aug 14, 2020 at 07:27:10PM +0200, Andrey Konovalov wrote:
>> Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
>> KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  mm/kasan/kasan.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index 1d3c7c6ce771..4d8e229f8e01 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
>> @@ -5,7 +5,13 @@
>>  #include <linux/kasan.h>
>>  #include <linux/stackdepot.h>
>>  
>> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>>  #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
>> +#else
>> +#include <asm/mte.h>
> 
> You could only include the new asm/mte-def.h file (currently mte_asm.h).
>

Agreed, we should only include asm/mte-def.h here since after the suggested
modification will be sufficient for the purpose.

>> +#define KASAN_GRANULE_SIZE	(MTE_GRANULE_SIZE)
>> +#endif
>> +
>>  #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
>>  
>>  #define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
>> -- 
>> 2.28.0.220.ged08abb693-goog
>>
> 

-- 
Regards,
Vincenzo
