Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960CFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C52722BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgH0KoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:44:00 -0400
Received: from foss.arm.com ([217.140.110.172]:56568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0Kn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:43:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07723101E;
        Thu, 27 Aug 2020 03:43:57 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF7063F66B;
        Thu, 27 Aug 2020 03:43:53 -0700 (PDT)
Subject: Re: [PATCH 22/35] arm64: mte: Enable in-kernel MTE
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
 <6a83a47d9954935d37a654978e96c951cc56a2f6.1597425745.git.andreyknvl@google.com>
 <20200827100155.GD29264@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a9ca504c-70cb-2fea-77dc-c02ba9dd3a7e@arm.com>
Date:   Thu, 27 Aug 2020 11:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827100155.GD29264@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 11:01 AM, Catalin Marinas wrote:
> On Fri, Aug 14, 2020 at 07:27:04PM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 4d3abb51f7d4..4d94af19d8f6 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1670,6 +1670,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>>  	write_sysreg_s(0, SYS_TFSR_EL1);
>>  	write_sysreg_s(0, SYS_TFSRE0_EL1);
>>  
>> +	/* Enable Match-All at EL1 */
>> +	sysreg_clear_set(tcr_el1, 0, SYS_TCR_EL1_TCMA1);
>> +
>>  	/*
>>  	 * CnP must be enabled only after the MAIR_EL1 register has been set
>>  	 * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
>> @@ -1687,6 +1690,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>>  	mair &= ~MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED);
>>  	mair |= MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED, MT_NORMAL_TAGGED);
>>  	write_sysreg_s(mair, SYS_MAIR_EL1);
>> +
>> +	/* Enable MTE Sync Mode for EL1 */
>> +	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> 
> In the 8th incarnation of the user MTE patches, this initialisation
> moved to proc.S before the MMU is initialised. When rebasing, please
> take this into account.
> 

Thank you for the heads up.

-- 
Regards,
Vincenzo
