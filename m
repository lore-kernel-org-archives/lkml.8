Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E754C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D757520C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgIDJ6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:58:20 -0400
Received: from foss.arm.com ([217.140.110.172]:47472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDJ6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:58:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D168101E;
        Fri,  4 Sep 2020 02:58:16 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAC993F66F;
        Fri,  4 Sep 2020 02:58:15 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: Replace cmpxchg with xchg in queue_iova
To:     Joerg Roedel <joro@8bytes.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     Yuqi Jin <jinyuqi@huawei.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1598517834-30275-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200904093732.GN6714@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <208d2f74-1a04-f01e-b885-c175b0480784@arm.com>
Date:   Fri, 4 Sep 2020 10:58:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904093732.GN6714@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2020-09-04 10:37, Joerg Roedel wrote:
> Adding Robin.

Did you miss that I've reviewed this already? :)

https://lore.kernel.org/linux-iommu/3afcc7b2-0bfb-b79c-513f-1beb66c5f164@arm.com/

Robin.

> On Thu, Aug 27, 2020 at 04:43:54PM +0800, Shaokun Zhang wrote:
>> From: Yuqi Jin <jinyuqi@huawei.com>
>>
>> The performance of the atomic_xchg is better than atomic_cmpxchg because
>> no comparison is required. While the value of @fq_timer_on can only be 0
>> or 1. Let's use atomic_xchg instead of atomic_cmpxchg here because we
>> only need to check that the value changes from 0 to 1 or from 1 to 1.
>>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>   drivers/iommu/iova.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 45a251da5453..30d969a4c5fd 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -579,7 +579,7 @@ void queue_iova(struct iova_domain *iovad,
>>   
>>   	/* Avoid false sharing as much as possible. */
>>   	if (!atomic_read(&iovad->fq_timer_on) &&
>> -	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
>> +	    !atomic_xchg(&iovad->fq_timer_on, 1))
>>   		mod_timer(&iovad->fq_timer,
>>   			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
>>   }
>> -- 
>> 2.7.4
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
