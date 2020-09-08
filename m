Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97621C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6325521D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgIHIMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:12:32 -0400
Received: from foss.arm.com ([217.140.110.172]:49900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgIHIMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:12:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0ED41045;
        Tue,  8 Sep 2020 01:12:21 -0700 (PDT)
Received: from [10.163.71.211] (unknown [10.163.71.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8B523F66E;
        Tue,  8 Sep 2020 01:12:18 -0700 (PDT)
Subject: Re: [PATCH V3] arm64/cpuinfo: Define HWCAP name arrays per their
 actual bit definitions
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1597665863-564-1-git-send-email-anshuman.khandual@arm.com>
 <20200907121611.GA12237@willie-the-truck>
 <ae17dbf4-c3e2-c853-13e3-ab38332a7beb@arm.com>
 <20200908074059.GA14790@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2daa3ea9-b9f0-3549-6458-158410576dff@arm.com>
Date:   Tue, 8 Sep 2020 13:41:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200908074059.GA14790@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2020 01:11 PM, Will Deacon wrote:
> On Tue, Sep 08, 2020 at 10:43:12AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 09/07/2020 05:46 PM, Will Deacon wrote:
>>> On Mon, Aug 17, 2020 at 05:34:23PM +0530, Anshuman Khandual wrote:
>>>> HWCAP name arrays (hwcap_str, compat_hwcap_str, compat_hwcap2_str) that are
>>>> scanned for /proc/cpuinfo are detached from their bit definitions making it
>>>> vulnerable and difficult to correlate. It is also bit problematic because
>>>> during /proc/cpuinfo dump these arrays get traversed sequentially assuming
>>>> they reflect and match actual HWCAP bit sequence, to test various features
>>>> for a given CPU. This redefines name arrays per their HWCAP bit definitions
>>>> . It also warns after detecting any feature which is not expected on arm64.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Mark Brown <broonie@kernel.org>
>>>> Cc: Dave Martin <Dave.Martin@arm.com>
>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> This applies on 5.9-rc1
>>>>
>>>> Mark, since the patch has changed I have dropped your Acked-by: tag. Are you
>>>> happy to give a new one ?
>>>>
>>>> Changes in V3:
>>>>
>>>> - Moved name arrays to (arch/arm64/kernel/cpuinfo.c) to prevent a build warning
>>>> - Replaced string values with NULL for all compat features not possible on arm64
>>>> - Changed compat_hwcap_str[] iteration on size as some NULL values are expected
>>>> - Warn once after detecting any feature on arm64 that is not expected
>>>>
>>>> Changes in V2: (https://patchwork.kernel.org/patch/11533755/)
>>>>
>>>> - Defined COMPAT_KERNEL_HWCAP[2] and updated the name arrays per Mark
>>>> - Updated the commit message as required
>>>>
>>>> Changes in V1: (https://patchwork.kernel.org/patch/11532945/)
>>>>
>>>>  arch/arm64/include/asm/hwcap.h |   9 +++
>>>>  arch/arm64/kernel/cpuinfo.c    | 172 ++++++++++++++++++++++-------------------
>>>>  2 files changed, 100 insertions(+), 81 deletions(-)
>>>
>>> [...]
>>>
>>>> +	[KERNEL_HWCAP_FP]		= "fp",
>>>> +	[KERNEL_HWCAP_ASIMD]		= "asimd",
>>>> +	[KERNEL_HWCAP_EVTSTRM]		= "evtstrm",
>>>> +	[KERNEL_HWCAP_AES]		= "aes",
>>>
>>> It would be nice if the cap and the string were generated by the same
>>> macro, along the lines of:
>>>
>>> #define KERNEL_HWCAP(c)	[KERNEL_HWCAP_##c] = #c,
>>>
>>> Does making the constants mixed case break anything, or is it just really
>>> churny to do?
>>
>> Currently all existing HWCAP feature strings are lower case, above change
>> will make them into upper case instead. I could not find a method to force
>> convert #c into lower case constant strings in the macro definition. Would
>> not changing the HWCAP string case here, break user interface ?
> 
> Yes, we can't change the user-visible strings, but what's wrong with
> having e.g. KERNEL_HWCAP_fp instead of KERNEL_HWCAP_FP?

Unlike the new compat macros i.e COMPAT_KERNEL_HWCAP[2] in this patch,
KERNEL_HWCAP_XXX macros are already defined and are getting used else
where (arch/arm64/kernel/cpufeature.c) as well. [KERNEL_HWCAP_##c] can
only be used here, if the input string is in upper case. Otherwise all
these existing macros need to be changed first, which will result in
too much code churn.
