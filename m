Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD47C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB12C24954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgEAQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:40:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728443AbgEAQkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:40:53 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C1CF8C4B4B34BF9888AE;
        Fri,  1 May 2020 17:40:51 +0100 (IST)
Received: from [127.0.0.1] (10.47.3.165) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 1 May 2020
 17:40:50 +0100
Subject: Re: [PATCH 5/5] arm/arm64: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        "harb@amperecomputing.com" <harb@amperecomputing.com>,
        Will Deacon <will@kernel.org>
References: <20200430114814.14116-1-sudeep.holla@arm.com>
 <20200430114814.14116-6-sudeep.holla@arm.com>
 <426ff8ab-9c13-4301-a91e-989c19c4ff58@huawei.com>
 <20200501160521.GB24840@bogus>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b5657cc3-a162-742f-f1cb-02c2d80631c9@huawei.com>
Date:   Fri, 1 May 2020 17:40:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200501160521.GB24840@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.165]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2020 17:05, Sudeep Holla wrote:
> On Fri, May 01, 2020 at 04:25:27PM +0100, John Garry wrote:
>> On 30/04/2020 12:48, Sudeep Holla wrote:
>>> +static int __init smccc_soc_init(void)
>>> +{
>>> +	struct device *dev;
>>> +	int ret, soc_id_rev;
>>> +	struct arm_smccc_res res;
>>> +	static char soc_id_str[8], soc_id_rev_str[12];
>>> +
>>> +	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
>>> +		return 0;
>>> +
>>> +	ret = smccc_soc_id_support_check();
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
>>> +
>>> +	ret = smccc_map_error_codes(res.a0);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	soc_id_version = res.a0;
>>> +
>>> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
>>> +
>>> +	ret = smccc_map_error_codes(res.a0);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	soc_id_rev = res.a0;
>>> +
>>> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>>> +	if (!soc_dev_attr)
>>> +		return -ENOMEM;
>>> +
>>> +	sprintf(soc_id_str, "0x%04x", IMP_DEF_SOC_ID(soc_id_version));
>>> +	sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
>>> +
>>> +	soc_dev_attr->soc_id = soc_id_str;
>>> +	soc_dev_attr->revision = soc_id_rev_str;
>>> +
>>> +	soc_dev = soc_device_register(soc_dev_attr);
>>> +	if (IS_ERR(soc_dev)) {
>>> +		ret = PTR_ERR(soc_dev);
>>> +		goto free_soc;
>>> +	}
>>> +
>>> +	dev = soc_device_to_device(soc_dev);
>>> +
>>
>> Just wondering, what about if the platform already had a SoC driver - now it
>> could have another one, such that we may have multiple sysfs soc devices,
>> right?
>>
> 
> Yes I had a quick look at that.
> 
> 1. Such platform has option not to implement this SOC_ID if it doesn't
>     really require it.

True

> 
> 2. If the firmware starts implementing it on some variants, then we can
>     distinguish them with compatibles and blacklist them from the other
>     SoC driver if having both is an issue
> 
> 3. SoC bus layer supports adding multiple SoC ID driver and it may show
>     up as /sys/devices/soc<n> which may or may not be fine.

Yeah, it's this scenario which I'm concerned about, where some userspace 
expects, for example, soc0 to have a soc id from a known, expected list, 
and now may get something else. However it could be argued then that 
userspace is just too fragile then and there is no read problem here.

  But this
>     happens only if neither [1] nor [2] is done. I am happy to see if there's
>     any solution for this. Any suggestions ?

Not sure, but taking a slight deviation, maybe a way could be found to 
supplement this dev attribute info to other ARM soc drivers.

Cheers,
John
