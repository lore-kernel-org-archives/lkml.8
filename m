Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DEC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC332086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgBKPHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:07:36 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728574AbgBKPHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:07:35 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8D03C9F91ED670DD7329;
        Tue, 11 Feb 2020 15:07:33 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Feb 2020 15:07:33 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 11 Feb
 2020 15:07:33 +0000
Subject: Re: [PATCH RFC 5/7] perf pmu: Support matching by sysid
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-6-git-send-email-john.garry@huawei.com>
 <20200210120759.GG1907700@krava>
 <63799909-067b-e5f4-dcf1-9ba1ec145348@huawei.com>
 <20200211134704.GB93194@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2a51ce93-fa68-8088-f31f-2fd692253335@huawei.com>
Date:   Tue, 11 Feb 2020 15:07:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200211134704.GB93194@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2020 13:47, Jiri Olsa wrote:

Hi Jirka,

>>>> +
>>>> +	return buf;
>>>> +}
>>>> +
>>
>> I have another series to add kernel support for a system identifier sysfs
>> entry, which I sent after this series:
>>
>> https://lore.kernel.org/linux-acpi/1580210059-199540-1-git-send-email-john.garry@huawei.com/
>>
>> It is different to what I am relying on here - it uses a kernel soc driver
>> for firmware ACPI PPTT identifier. Progress is somewhat blocked at the
>> moment however and I may have to use a different method:
>>
>> https://lore.kernel.org/linux-acpi/20200128123415.GB36168@bogus/
> 
> I'll try to check ;-)

Summary is that there exists an ACPI firmware field which we could 
expose to userspace via sysfs - this would provide the system id. 
However there is a proposal to deprecate it in the ACPI standard and, as 
such, would prefer that we don't add kernel support for it at this stage.

So I am evaluating the alternative in the meantime, which again is some 
firmware method which should allow us to expose a system id to userspace 
via sysfs. Unfortunately this is arm specific. However, other archs can 
still provide their own method, maybe a soc driver:

Documentation/ABI/testing/sysfs-devices-soc#n15

> 
>>
>>>> +static char *perf_pmu__getsysid(void)
>>>> +{
>>>> +	char *sysid;
>>>> +	static bool printed;
>>>> +
>>>> +	sysid = getenv("PERF_SYSID");
>>>> +	if (sysid)
>>>> +		sysid = strdup(sysid);
>>>> +
>>>> +	if (!sysid)
>>>> +		sysid = get_sysid_str();
>>>> +	if (!sysid)
>>>> +		return NULL;
>>>> +
>>>> +	if (!printed) {
>>>> +		pr_debug("Using SYSID %s\n", sysid);
>>>> +		printed = true;
>>>> +	}
>>>> +	return sysid;
>>>> +}
>>>
>>> this part is getting complicated and AFAIK we have no tests for it
>>>
>>> if you could think of any tests that'd be great.. Perhaps we could
>>> load 'our' json test files and check appropriate events/aliasses
>>> via in pmu object.. or via parse_events interface.. those test aliases
>>> would have to be part of perf, but we have tests compiled in anyway
>>
>> Sorry, I don't fully follow.
>>
>> Are you suggesting that we could load the specific JSONs tables for a system
>> from the host filesystem?
> 
> I wish to see some test for all this.. I can only think about having
> 'test' json files compiled with perf and 'perf test' that looks them
> up and checks that all is in the proper place

OK, let me consider this part for perf test support.

Thanks,
John
