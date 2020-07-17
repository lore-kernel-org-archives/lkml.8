Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF59C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CBB20775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGQL6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:58:11 -0400
Received: from foss.arm.com ([217.140.110.172]:35122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgGQL6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:58:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32E7730E;
        Fri, 17 Jul 2020 04:58:10 -0700 (PDT)
Received: from [10.57.35.46] (unknown [10.57.35.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55CBD3F66E;
        Fri, 17 Jul 2020 04:58:07 -0700 (PDT)
Subject: Re: [PATCH v10 5/5] iommu/arm-smmu: Add global/context fault
 implementation hooks
To:     Will Deacon <will@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>
Cc:     snikam@nvidia.com, devicetree@vger.kernel.org,
        mperttunen@nvidia.com, praithatha@nvidia.com, bhuntsman@nvidia.com,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, nicolinc@nvidia.com,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
        linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-6-vdumpa@nvidia.com>
 <20200713134450.GC2739@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <616235dc-c290-d5c4-47c2-19402213dc11@arm.com>
Date:   Fri, 17 Jul 2020 12:58:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713134450.GC2739@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-13 14:44, Will Deacon wrote:
> On Tue, Jul 07, 2020 at 10:00:17PM -0700, Krishna Reddy wrote:
>> Add global/context fault hooks to allow vendor specific implementations
>> override default fault interrupt handlers.
>>
>> Update NVIDIA implementation to override the default global/context fault
>> interrupt handlers and handle interrupts across the two ARM MMU-500s that
>> are programmed identically.
>>
>> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
>> ---
>>   drivers/iommu/arm-smmu-nvidia.c | 99 +++++++++++++++++++++++++++++++++
>>   drivers/iommu/arm-smmu.c        | 17 +++++-
>>   drivers/iommu/arm-smmu.h        |  3 +
>>   3 files changed, 117 insertions(+), 2 deletions(-)
> 
> Given that faults shouldn't occur during normal operation, is this patch
> actually necessary?

Indeed they shouldn't, but if something *does* happen to go wrong then I 
think it's worth having proper handling in place, since the consequences 
otherwise include a screaming "spurious" fault or just silently losing 
some transactions and possibly locking up part of the system altogether 
(depending on HUPCF at least - I recall MMU-500 also behaving funnily 
WRT TLB maintenance while an IRQ is outstanding, but that was long 
enough ago that it might have been related to the old CFCFG behaviour).

Until we sort out the reserved memory regions thing (the new IORT spec 
is due Real Soon Now(TM)...) some systems are going to keep suffering 
transient context faults during boot - those may make the display 
unhappy until it gets reset, but we certainly don't want to invite the 
possibility of them wedging the SMMU itself.

Robin.
