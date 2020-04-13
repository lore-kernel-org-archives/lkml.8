Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1097C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:35:39 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5646A206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5646A206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgDMDfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 23:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgDMDfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 23:35:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7349DC0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:35:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4227230E;
        Sun, 12 Apr 2020 20:35:37 -0700 (PDT)
Received: from [10.163.1.49] (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 811A43F6C4;
        Sun, 12 Apr 2020 20:35:35 -0700 (PDT)
Subject: Re: [PATCH 2/6] arm64/cpufeature: Add DIT and CSV2 feature bits in
 ID_PFR0 register
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-3-git-send-email-anshuman.khandual@arm.com>
 <20200409125526.GC13078@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a6c8042f-bca7-22a9-287f-cee05ae347a8@arm.com>
Date:   Mon, 13 Apr 2020 09:05:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200409125526.GC13078@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2020 06:25 PM, Will Deacon wrote:
> On Tue, Jan 28, 2020 at 06:09:05PM +0530, Anshuman Khandual wrote:
>> Enable DIT and CSV2 feature bits in ID_PFR0 register as per ARM DDI 0487E.a
>> specification. Except RAS and AMU, all other feature bits are now enabled.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/sysreg.h | 3 +++
>>  arch/arm64/kernel/cpufeature.c  | 2 ++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 054aab7ebf1b..469d61c8fabf 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -718,6 +718,9 @@
>>  #define ID_ISAR6_DP_SHIFT		4
>>  #define ID_ISAR6_JSCVT_SHIFT		0
>>  
>> +#define ID_PFR0_DIT_SHIFT		24
>> +#define ID_PFR0_CSV2_SHIFT		16
>> +
>>  #define ID_PFR2_SSBS_SHIFT		4
>>  #define ID_PFR2_CSV3_SHIFT		0
>>  
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index c1e837fc8f97..9e4dab15c608 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -341,6 +341,8 @@ static const struct arm64_ftr_bits ftr_id_isar6[] = {
>>  };
>>  
>>  static const struct arm64_ftr_bits ftr_id_pfr0[] = {
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_DIT_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_CSV2_SHIFT, 4, 0),
> 
> Same comment as CSV3 here. Why is CSV2 being treated as strict here, but not
> in the aa64* register?

Sure, will change.

> 
> Will
> 
