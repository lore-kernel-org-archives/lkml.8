Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB032073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbgF3KLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:11:40 -0400
Received: from foss.arm.com ([217.140.110.172]:34892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgF3KLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:11:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDAEB30E;
        Tue, 30 Jun 2020 03:11:38 -0700 (PDT)
Received: from [10.37.12.90] (unknown [10.37.12.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1205A3F68F;
        Tue, 30 Jun 2020 03:11:36 -0700 (PDT)
Subject: Re: [PATCH] arm64/cpufeature: Validate feature bits spacing in
 arm64_ftr_regs[]
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1592274331-19006-1-git-send-email-anshuman.khandual@arm.com>
 <ec04ed20-1ad8-6130-ebd9-0157e5753ef6@arm.com>
 <25fd985f-65b8-3884-02f4-10311d3f55fe@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9c2a5410-044e-03cb-9233-900389d0dfea@arm.com>
Date:   Tue, 30 Jun 2020 11:16:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <25fd985f-65b8-3884-02f4-10311d3f55fe@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/2020 02:49 AM, Anshuman Khandual wrote:
> 
> 
> On 06/29/2020 04:12 PM, Suzuki K Poulose wrote:
>> On 06/16/2020 03:25 AM, Anshuman Khandual wrote:
>>> arm64_feature_bits for a register in arm64_ftr_regs[] are in a descending
>>> order as per their shift values. Validate that these features bits are
>>> defined correctly and do not overlap with each other. This check protects
>>> against any inadvertent erroneous changes to the register definitions.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> Applies on 5.8-rc1.
>>>
>>>    arch/arm64/kernel/cpufeature.c | 45 +++++++++++++++++++++++++++++++---
>>>    1 file changed, 42 insertions(+), 3 deletions(-)

>>> +        }
>>>    -    /* Check that the array is sorted so that we can do the binary search */
>>> -    for (i = 1; i < ARRAY_SIZE(arm64_ftr_regs); i++)
>>> +        /*
>>> +         * Skip the first register. There is nothing to
>>> +         * compare against for now.
>>> +         */
>>> +        if (i == 0)
>>> +            continue;
>>
>> You are starting at 1 already, so you may skip this check.
> 
> Actually, now we are starting with 0 instead for both i and j.
> Hence this check would be required.

Sorry, ignore that.

Suzuki



