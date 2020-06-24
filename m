Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DB6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5BF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390289AbgFXIQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:16:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2359 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388531AbgFXIQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:16:48 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 047559904F45C9DF72BF;
        Wed, 24 Jun 2020 09:16:46 +0100 (IST)
Received: from [127.0.0.1] (10.210.166.251) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 24 Jun
 2020 09:16:44 +0100
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To:     Robin Murphy <robin.murphy@arm.com>,
        kernel test robot <lkp@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>
CC:     "trivial@kernel.org" <trivial@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <202006230905.3HpPgtSC%lkp@intel.com>
 <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
 <693bfa60-82cf-bcbb-5745-0d001f7d9f9e@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <87f00fa4-c3f0-e057-08ba-56488d9aa34d@huawei.com>
Date:   Wed, 24 Jun 2020 09:15:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <693bfa60-82cf-bcbb-5745-0d001f7d9f9e@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.251]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> I'd say that GENMASK_INPUT_CHECK() should be able to handle a l=0 and
>> h=unsigned value, so I doubt this warn.
>>
>> Using GENMASK((int)cmdq->q.llq.max_n_shift, 0) resolves it, but it looks
>> like GENMASK_INPUT_CHECK() could be improved.
> 
> That said, I think this particular case might be even better off dodging
> GENMASK() entirely, by doing something like this first. Untested...
> 
> Robin.
> 
> ----->8-----
> Subject: [PATCH] iommu/arm-smmu-v3: Streamline queue calculations
> 
> Beyond the initial queue setup based on the log2 values from ID
> registers, the log2 queue size is only ever used in the form of
> (1 << max_n_shift) to repeatedly recalculate the number of queue
> elements. Simply storing it in that form leads to slightly more
> efficient code, particularly in the low-level queue accessors
> where it counts most:
> 
> add/remove: 0/0 grow/shrink: 1/7 up/down: 4/-120 (-116)
> Function                                     old     new   delta
> arm_smmu_init_one_queue                      360     364      +4
> arm_smmu_priq_thread                         512     508      -4
> arm_smmu_evtq_thread                         300     292      -8
> __arm_smmu_cmdq_poll_set_valid_map.isra      296     288      -8
> queue_remove_raw                             180     164     -16
> arm_smmu_gerror_handler                      732     716     -16
> arm_smmu_device_probe                       4312    4284     -28
> arm_smmu_cmdq_issue_cmdlist                 1892    1852     -40
> Total: Before=20135, After=20019, chg -0.58%
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

[...]


>   	}
>   
> -	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
> -					     FIELD_GET(IDR1_EVTQS, reg));
> -	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
> -					     FIELD_GET(IDR1_PRIQS, reg));
> +	max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_EVTQS, reg));
> +	smmu->evtq.q.llq.max_n = 1 << max_n_shift;

So I require the bitmask of this for the prod, which would be (max_n << 
1) - 1.

I don't feel too strongly either way, and the other big changes in this 
series need to be considered first...

Thanks,
John

> +
> +	max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_PRIQS, reg));
> +	smmu->priq.q.llq.max_n = 1 << max_n_shift;
>   
>   	/* SID/SSID sizes */
>   	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
> 

