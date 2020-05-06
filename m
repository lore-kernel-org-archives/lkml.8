Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B8C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC0D206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEFGoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:44:16 -0400
Received: from foss.arm.com ([217.140.110.172]:57066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgEFGoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:44:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7D430E;
        Tue,  5 May 2020 23:44:15 -0700 (PDT)
Received: from [10.163.71.196] (unknown [10.163.71.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5BC3F68F;
        Tue,  5 May 2020 23:44:13 -0700 (PDT)
Subject: Re: [PATCH V3 08/16] arm64/cpufeature: Add remaining feature bits in
 ID_MMFR4 register
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-9-git-send-email-anshuman.khandual@arm.com>
 <20200505111417.GG19710@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ae1a105d-65aa-7225-38d3-3839a7d4aa19@arm.com>
Date:   Wed, 6 May 2020 12:13:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200505111417.GG19710@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 04:44 PM, Will Deacon wrote:
> On Sat, May 02, 2020 at 07:03:57PM +0530, Anshuman Khandual wrote:
>> Enable all remaining feature bits like EVT, CCIDX, LSM, HPDS, CnP, XNX,
>> SpecSEI in ID_MMFR4 register per ARM DDI 0487F.a.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/sysreg.h |  8 ++++++++
>>  arch/arm64/kernel/cpufeature.c  | 13 +++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index f9e3b9350540..0f34927f52b9 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -790,6 +790,14 @@
>>  #define ID_ISAR6_DP_SHIFT		4
>>  #define ID_ISAR6_JSCVT_SHIFT		0
>>  
>> +#define ID_MMFR4_EVT_SHIFT		28
>> +#define ID_MMFR4_CCIDX_SHIFT		24
>> +#define ID_MMFR4_LSM_SHIFT		20
>> +#define ID_MMFR4_HPDS_SHIFT		16
>> +#define ID_MMFR4_CNP_SHIFT		12
>> +#define ID_MMFR4_XNX_SHIFT		8
> 
> Why didn't you add ID_MMFR4_AC2_SHIFT as well?

ID_MMFR4_AC2_SHIFT, which will be the replacement for an existing hard
coded bits shift encoding ('4') is being added via [PATCH 16/16] where
we replace all existing open encodings.
