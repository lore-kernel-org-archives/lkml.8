Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A8C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD112075A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgEEGvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 02:51:15 -0400
Received: from foss.arm.com ([217.140.110.172]:60766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEGvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 02:51:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCD061FB;
        Mon,  4 May 2020 23:51:14 -0700 (PDT)
Received: from [10.163.71.248] (unknown [10.163.71.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AD753F68F;
        Mon,  4 May 2020 23:51:12 -0700 (PDT)
Subject: Re: [PATCH V3 02/16] arm64/cpufeature: Drop TraceFilt feature
 exposure from ID_DFR0 register
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-3-git-send-email-anshuman.khandual@arm.com>
 <20200504202453.GA5012@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <56cd3062-a0c2-6cdf-b7c6-c2b7bf56d23b@arm.com>
Date:   Tue, 5 May 2020 12:20:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200504202453.GA5012@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 01:54 AM, Will Deacon wrote:
> On Sat, May 02, 2020 at 07:03:51PM +0530, Anshuman Khandual wrote:
>> ID_DFR0 based TraceFilt feature should not be exposed to guests. Hence lets
>> drop it.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kernel/cpufeature.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 6d032fbe416f..51386dade423 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -435,7 +435,6 @@ static const struct arm64_ftr_bits ftr_id_pfr1[] = {
>>  };
>>  
>>  static const struct arm64_ftr_bits ftr_id_dfr0[] = {
>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
> 
> Hmm, this still confuses me. Is this not now FTR_NONSTRICT? Why is that ok?

Mark had mentioned about it earlier (https://patchwork.kernel.org/patch/11287805/)
Did I misinterpret the first part ? Could not figure "capping the emulated debug
features" part. Probably, Mark could give some more details.

From the earlier discussion:

* ID_DFR0 fields need more thought; we should limit what we expose here.
  I don't think it's valid for us to expose TraceFilt, and I suspect we
  need to add capping for debug features we currently emulate.
