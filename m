Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5F2C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540232078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGPK2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:28:19 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2487 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbgGPK2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:28:19 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3B92680604F5E70695B5;
        Thu, 16 Jul 2020 11:28:18 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 11:28:17 +0100
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To:     Will Deacon <will@kernel.org>
CC:     <robin.murphy@arm.com>, <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <20200716102037.GB7036@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <36fe9596-745b-b01c-181c-b87a544a413b@huawei.com>
Date:   Thu, 16 Jul 2020 11:26:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716102037.GB7036@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2020 11:20, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 01:28:40AM +0800, John Garry wrote:
>> It has been shown that the cmpxchg() for finding space in the cmdq can
>> be a bottleneck:
>> - for more CPUs contending the cmdq, the cmpxchg() will fail more often
>> - since the software-maintained cons pointer is updated on the same 64b
>>    memory region, the chance of cmpxchg() failure increases again
>>
>> The cmpxchg() is removed as part of 2 related changes:
>>
>> - Update prod and cmdq owner in a single atomic add operation. For this, we
>>    count the prod and owner in separate regions in prod memory.
>>
>>    As with simple binary counting, once the prod+wrap fields overflow, they
>>    will zero. They should never overflow into "owner" region, and we zero
>>    the non-owner, prod region for each owner. This maintains the prod
>>    pointer.
>>
>>    As for the "owner", we now count this value, instead of setting a flag.
>>    Similar to before, once the owner has finished gathering, it will clear
>>    a mask. As such, a CPU declares itself as the "owner" when it reads zero
>>    for this region. This zeroing will also clear possible overflow in
>>    wrap+prod region, above.
>>
>>    The owner is now responsible for all cmdq locking to avoid possible
>>    deadlock. The owner will lock the cmdq for all non-owers it has gathered
>>    when they have space in the queue and have written their entries.
>>
>> - Check for space in the cmdq after the prod pointer has been assigned.
>>
>>    We don't bother checking for space in the cmdq before assigning the prod
>>    pointer, as this would be racy.
>>
>>    So since the prod pointer is updated unconditionally, it would be common
>>    for no space to be available in the cmdq when prod is assigned - that
>>    is, according the software-maintained prod and cons pointer. So now
>>    it must be ensured that the entries are not yet written and not until
>>    there is space.
>>
>>    How the prod pointer is maintained also leads to a strange condition
>>    where the prod pointer can wrap past the cons pointer. We can detect this
>>    condition, and report no space here. However, a prod pointer progressed
>>    twice past the cons pointer cannot be detected. But it can be ensured that
>>    this that this scenario does not occur, as we limit the amount of
>>    commands any CPU can issue at any given time, such that we cannot
>>    progress prod pointer further.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 101 ++++++++++++++++++++++--------------
>>   1 file changed, 61 insertions(+), 40 deletions(-)
> 
> I must admit, you made me smile putting trivial@kernel.org on cc for this ;)
> 

Yes, quite ironic :)
