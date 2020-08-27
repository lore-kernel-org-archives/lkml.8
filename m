Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9624922B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgH0Me0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:34:26 -0400
Received: from foss.arm.com ([217.140.110.172]:57444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbgH0MJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:09:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B53F131B;
        Thu, 27 Aug 2020 05:09:27 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A751E3F68F;
        Thu, 27 Aug 2020 05:09:24 -0700 (PDT)
Subject: Re: [PATCH 32/35] kasan, arm64: print report from tag fault handler
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
 <4691d6019ef00c11007787f5190841b47ba576c4.1597425745.git.andreyknvl@google.com>
 <20200827104816.GI29264@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <37de7524-b042-831f-6e43-30adf85c83a8@arm.com>
Date:   Thu, 27 Aug 2020 13:11:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827104816.GI29264@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/20 11:48 AM, Catalin Marinas wrote:
> On Fri, Aug 14, 2020 at 07:27:14PM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index c62c8ba85c0e..cf00b3942564 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/hardirq.h>
>>  #include <linux/init.h>
>> +#include <linux/kasan.h>
>>  #include <linux/kprobes.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/page-flags.h>
>> @@ -314,11 +315,19 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
>>  {
>>  	bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
>>  
>> +#ifdef CONFIG_KASAN_HW_TAGS
>> +	/*
>> +	 * SAS bits aren't set for all faults reported in EL1, so we can't
>> +	 * find out access size.
>> +	 */
>> +	kasan_report(addr, 0, is_write, regs->pc);
>> +#else
>>  	pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
>>  	pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
>>  	pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
>>  			mte_get_ptr_tag(addr),
>>  			mte_get_mem_tag((void *)addr));
>> +#endif
>>  }
> 
> More dead code. So what's the point of keeping the pr_alert() introduced
> earlier? CONFIG_KASAN_HW_TAGS is always on for in-kernel MTE. If MTE is
> disabled, this function isn't called anyway.
> 

I agree we should remove them (togheter with '#ifdef CONFIG_KASAN_HW_TAGS') or
integrate them with the kasan code if still meaningful.

-- 
Regards,
Vincenzo
