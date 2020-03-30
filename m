Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBE3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EB5206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgC3Lnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:43:51 -0400
Received: from foss.arm.com ([217.140.110.172]:51394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbgC3Lnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:43:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E58C931B;
        Mon, 30 Mar 2020 04:43:49 -0700 (PDT)
Received: from [10.57.27.249] (unknown [10.57.27.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC943F52E;
        Mon, 30 Mar 2020 04:43:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: Kconfig: ptrauth: Add binutils version check
 to fix mismatch
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        linux-kernel@vger.kernel.org
References: <1585236720-21819-1-git-send-email-amit.kachhap@arm.com>
 <1585236720-21819-2-git-send-email-amit.kachhap@arm.com>
 <20200327125522.GB18117@mbp>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <497d96a1-0532-ca18-8eaa-79fbcfd0b87d@arm.com>
Date:   Mon, 30 Mar 2020 17:13:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200327125522.GB18117@mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/20 6:25 PM, Catalin Marinas wrote:
> On Thu, Mar 26, 2020 at 09:02:00PM +0530, Amit Daniel Kachhap wrote:
>> Recent addition of ARM64_PTR_AUTH exposed a mismatch issue with binutils.
>> 9.1+ versions of gcc inserts a section note .note.gnu.property but this
>> can be used properly by binutils version greater than 2.33.1. If older
>> binutils are used then the following warnings are generated,
>>
>> aarch64-linux-ld: warning: arch/arm64/kernel/vdso/vgettimeofday.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
>> aarch64-linux-objdump: warning: arch/arm64/lib/csum.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
>> aarch64-linux-nm: warning: .tmp_vmlinux1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
>>
>> This patch enables ARM64_PTR_AUTH when gcc and binutils versions are
>> compatible with each other. Older gcc which do not insert such section
>> continue to work as before.
>>
>> This scenario may not occur with clang as a recent commit 3b446c7d27ddd06
>> ("arm64: Kconfig: verify binutils support for ARM64_PTR_AUTH") masks
>> binutils version lesser then 2.34.
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Suggested-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> ---
>>   arch/arm64/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index e6712b6..73135da 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1503,7 +1503,7 @@ config ARM64_PTR_AUTH
>>   	default y
>>   	depends on !KVM || ARM64_VHE
>>   	depends on (CC_HAS_SIGN_RETURN_ADDRESS || CC_HAS_BRANCH_PROT_PAC_RET) && AS_HAS_PAC
>> -	depends on CC_IS_GCC || (CC_IS_CLANG && AS_HAS_CFI_NEGATE_RA_STATE)
>> +	depends on (CC_IS_GCC && (GCC_VERSION < 90100 || LD_VERSION >= 233010000)) || (CC_IS_CLANG && AS_HAS_CFI_NEGATE_RA_STATE)
> 
> We should add some of the comments in the commit log to the Kconfig
> entry. I would also split this in two (equivalent to CC_IS_ implies):
> 
> 	depends on !CC_IS_GCC || GCC_VERSION < 90100 || LD_VERSION >= 233010000
> 	depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE
> 
> and add a comment above the gcc/ld version checking.
> 
> (not entirely identical to the original if CC is neither of them but I
> don't think we have this problem)

Re-posted v2 as per the suggestions.

Thanks,
Amit
> 
