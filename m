Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907BAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFBF20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgEUORc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:17:32 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727909AbgEUORb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:17:31 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B7AC5851A8F64C7CAB12;
        Thu, 21 May 2020 15:17:29 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.132) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 21 May
 2020 15:17:28 +0100
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier for
 userspace
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>, <shawnguo@kernel.org>,
        <linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
 <20200519185125.GB453195@bogus> <20200520073304.GA23534@willie-the-truck>
 <20200521132641.GB47848@C02TD0UTHF1T.local>
From:   John Garry <john.garry@huawei.com>
Message-ID: <04e6ed82-d33e-9153-eeab-29986ccf8e1e@huawei.com>
Date:   Thu, 21 May 2020 15:16:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200521132641.GB47848@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.132]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2020 14:26, Mark Rutland wrote:
> On Wed, May 20, 2020 at 08:33:04AM +0100, Will Deacon wrote:
>> On Tue, May 19, 2020 at 12:51:25PM -0600, Rob Herring wrote:
>>> On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
>>>> +static ssize_t ddr_perf_identifier_show(struct device *dev,
>>>> +					struct device_attribute *attr,
>>>> +					char *page)
>>>> +{
>>>> +	struct ddr_pmu *pmu = dev_get_drvdata(dev);
>>>> +
>>>> +	return sprintf(page, "%s\n", pmu->devtype_data->identifier);
>>>
>>> Why do we need yet another way to identify the SoC from userspace?
>>
>> I also really dislike this. What's the preferred way to identify the SoC
>> from userspace? It's needed so that the perf userspace tool can describe
>> perf events that are supported for the PMU, as this isn't probe-able
>> directly from the hardware. We have the same issue with the SMMUv3 PMCG [1],
>> and so we need to solve the problem for both DT and ACPI.
> 
> Worth noting that while in this case it happens to identify the SoC,
> in general you can have distinct instances of system IP in a single
> system, so I do think that we need *something* instance-specific, even
> if that's combined with SoC info.
> 

Hi Mark,

> Where IP gets reused across SoCs, it makes sense for that to not depend
> on top-level SoC info.

This would be quite an uncommon case. Generally most instances of a 
given PMU in a SoC would be identical implementations.

And anyway, we should be able to solve that problem in perf tool, as 
long as the PMU device name is fixed. Like what we have for the SMMUv3 
PMU, where the device name contains the device bus address, i.e don't 
use idr for perf drivers device naming....

Thanks,
John
