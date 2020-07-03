Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB30C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC0E206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCLyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:54:41 -0400
Received: from foss.arm.com ([217.140.110.172]:54492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGCLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:54:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DEDB2F;
        Fri,  3 Jul 2020 04:54:40 -0700 (PDT)
Received: from [10.163.85.168] (unknown [10.163.85.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64ED53F68F;
        Fri,  3 Jul 2020 04:54:37 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1,
 ID_MMFR5 and other changes
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        mark.rutland@arm.com, suzuki.poulose@arm.com,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1590548619-3441-1-git-send-email-anshuman.khandual@arm.com>
 <20200702173403.GI22241@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5a66d9a0-7ada-d0b0-f768-9901494175e4@arm.com>
Date:   Fri, 3 Jul 2020 17:24:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200702173403.GI22241@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2020 11:04 PM, Catalin Marinas wrote:
> On Wed, May 27, 2020 at 08:33:35AM +0530, Anshuman Khandual wrote:
>> These are remaining patches from V4 series which had some pending reviews
>> from Suzuki (https://patchwork.kernel.org/cover/11557333/). Also dropped
>> [PATCH 15/17] as that will need some more investigation and rework.
>>
>> This series applies on arm64/for-next/cpufeature.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com> 
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
> 
> Thanks Suzuki for review.
> 
> Anshuman, could you please rebase this series on top of 5.8-rc3? It no
> longer applies cleanly.

Already posted here.

https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=312281
