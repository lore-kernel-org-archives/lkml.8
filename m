Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2498520721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgDBCiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:38:51 -0400
Received: from foss.arm.com ([217.140.110.172]:36356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgDBCiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:38:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18D2D30E;
        Wed,  1 Apr 2020 19:38:50 -0700 (PDT)
Received: from [10.163.1.8] (unknown [10.163.1.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D6533F71E;
        Wed,  1 Apr 2020 19:38:47 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm64/cpufeature: Add remaining feature bits in
 ID_MMFR4 register
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-4-git-send-email-anshuman.khandual@arm.com>
 <54e53bb4-beb3-1a36-e8a4-2f3bda433739@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a728417c-a0b4-d1dc-5257-19e869085bd3@arm.com>
Date:   Thu, 2 Apr 2020 08:08:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <54e53bb4-beb3-1a36-e8a4-2f3bda433739@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2020 11:41 PM, Suzuki K Poulose wrote:
> On 01/28/2020 12:39 PM, Anshuman Khandual wrote:
>> Enable all remaining feature bits like EVT, CCIDX, LSM, HPDS, CnP, XNX,
>> SpecSEI in ID_MMFR4 register per ARM DDI 0487E.a.
> 
> It might be worth adding a comment here mentioning why SpecSEI is
> HIGHER_SAFE, unlike the majority.

Sure, will do.

> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> With that:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
