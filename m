Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8636C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E09208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgEHIdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:33:11 -0400
Received: from foss.arm.com ([217.140.110.172]:45228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgEHIdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:33:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 021CA1FB;
        Fri,  8 May 2020 01:33:10 -0700 (PDT)
Received: from [10.163.73.155] (unknown [10.163.73.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB1ED3F305;
        Fri,  8 May 2020 01:33:06 -0700 (PDT)
Subject: Re: [PATCH V3 04/16] arm64/cpufeature: Introduce ID_PFR2 CPU register
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-5-git-send-email-anshuman.khandual@arm.com>
 <20200505111241.GF19710@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <918e2dfb-4b3b-c1e6-3151-c81ac9f416b6@arm.com>
Date:   Fri, 8 May 2020 14:02:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200505111241.GF19710@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 04:42 PM, Will Deacon wrote:
> On Sat, May 02, 2020 at 07:03:53PM +0530, Anshuman Khandual wrote:
>> This adds basic building blocks required for ID_PFR2 CPU register which
>> provides information about the AArch32 programmers model which must be
>> interpreted along with ID_PFR0 and ID_PFR1 CPU registers. This is added
>> per ARM DDI 0487F.a specification.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/cpu.h    |  1 +
>>  arch/arm64/include/asm/sysreg.h |  4 ++++
>>  arch/arm64/kernel/cpufeature.c  | 11 +++++++++++
>>  arch/arm64/kernel/cpuinfo.c     |  1 +
>>  arch/arm64/kvm/sys_regs.c       |  2 +-
>>  5 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
>> index b4a40535a3d8..464e828a994d 100644
>> --- a/arch/arm64/include/asm/cpu.h
>> +++ b/arch/arm64/include/asm/cpu.h
>> @@ -46,6 +46,7 @@ struct cpuinfo_arm64 {
>>  	u32		reg_id_mmfr3;
>>  	u32		reg_id_pfr0;
>>  	u32		reg_id_pfr1;
>> +	u32		reg_id_pfr2;
>>  
>>  	u32		reg_mvfr0;
>>  	u32		reg_mvfr1;
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index e5317a6367b6..c977449e02db 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -153,6 +153,7 @@
>>  #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
>>  #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
>>  #define SYS_MVFR2_EL1			sys_reg(3, 0, 0, 3, 2)
>> +#define SYS_ID_PFR2_EL1			sys_reg(3, 0, 0, 3, 4)
> 
> nit: but please group these defines by name rather than encoding.

Sure, will do the same for all new register being added in the series.
