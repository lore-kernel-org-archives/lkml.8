Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0ACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5130120774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgGHNCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:02:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2442 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728918AbgGHNCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:02:37 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6303BD8543793A5CD515;
        Wed,  8 Jul 2020 14:02:36 +0100 (IST)
Received: from [127.0.0.1] (10.210.171.111) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 8 Jul 2020
 14:02:35 +0100
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
Message-ID: <a5f98ff2-2d93-7306-9af9-a7bfc347757e@huawei.com>
Date:   Wed, 8 Jul 2020 14:00:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.111]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2020 18:28, John Garry wrote:

Hi, Can you guys let me know if this is on the radar at all?

I have been talking about this performance issue since Jan, and not 
getting anything really.

thanks

> As mentioned in [0], the CPU may consume many cycles processing
> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
> get space on the queue takes approx 25% of the cycles for this function.
> 
> This series removes that cmpxchg().
> 
> For my NVMe test with 3x NVMe SSDs, I'm getting a ~24% throughput
> increase:
> Before: 1310 IOPs
> After: 1630 IOPs
> 
> I also have a test harness to check the rate of DMA map+unmaps we can
> achieve:
> 
> CPU count	32	64	128
> Before:		63187	19418	10169
> After:		93287	44789	15862
> 
> (unit is map+unmaps per CPU per second)
> 
> [0] https://lore.kernel.org/linux-iommu/B926444035E5E2439431908E3842AFD24B86DB@DGGEMI525-MBS.china.huawei.com/T/#ma02e301c38c3e94b7725e685757c27e39c7cbde3
> 
> John Garry (4):
>    iommu/arm-smmu-v3: Fix trivial typo
>    iommu/arm-smmu-v3: Calculate bits for prod and owner
>    iommu/arm-smmu-v3: Always issue a CMD_SYNC per batch
>    iommu/arm-smmu-v3: Remove cmpxchg() in arm_smmu_cmdq_issue_cmdlist()
> 
>   drivers/iommu/arm-smmu-v3.c | 233 +++++++++++++++++++++++-------------
>   1 file changed, 151 insertions(+), 82 deletions(-)
> 

