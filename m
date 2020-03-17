Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1CDC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BFF2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCQQlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:41:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgCQQlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:41:17 -0400
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1A452863AE7971EC315C;
        Tue, 17 Mar 2020 16:41:16 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Mar 2020 16:41:15 +0000
Received: from [127.0.0.1] (10.47.11.44) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Mar
 2020 16:41:14 +0000
Subject: Re: [PATCH v2 7/7] perf test: Test pmu-events aliases
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <james.clark@arm.com>, <qiangqing.zhang@nxp.com>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
 <1584442939-8911-8-git-send-email-john.garry@huawei.com>
 <20200317162043.GC759708@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <01dd565b-931c-e853-a721-aa995f87469c@huawei.com>
Date:   Tue, 17 Mar 2020 16:41:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200317162043.GC759708@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.44]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2020 16:20, Jiri Olsa wrote:
> On Tue, Mar 17, 2020 at 07:02:19PM +0800, John Garry wrote:
> 
> SNIP
> 
>>   struct perf_pmu_test_event {
>>   	struct pmu_event event;
>> +
>> +	/* extra events for aliases */
>> +	const char *alias_str;
>> +
>> +	/*
>> +	 * Note: For when PublicDescription does not exist in the JSON, we
>> +	 * will have no long_desc in pmu_event.long_desc, but long_desc may
>> +	 * be set in the alias.
>> +	 */
>> +	const char *alias_long_desc;
>>   };
>> +
>>   static struct perf_pmu_test_event test_cpu_events[] = {
>>   	{
>>   		.event = {
>> @@ -20,6 +31,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
>>   			.desc = "L1 BTB Correction",
>>   			.topic = "branch",
>>   		},
>> +		.alias_str = "event=0x8a",
>> +		.alias_long_desc = "L1 BTB Correction",
>>   	},
>>   	{
>>   		.event = {
>> @@ -28,6 +41,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
>>   			.desc = "L2 BTB Correction",
>>   			.topic = "branch",
>>   		},
>> +		.alias_str = "event=0x8b",
>> +		.alias_long_desc = "L2 BTB Correction",
>>   	},
>>   	{
>>   		.event = {
>> @@ -36,6 +51,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
>>   			.desc = "Number of segment register loads",
>>   			.topic = "other",
>>   		},
>> +		.alias_str = "umask=0x80,(null)=0x30d40,event=0x6",
> 
> ah so we are using other pmus because of the format definitions
> 

Hi jirka,

> why is there the '(null)' in there?
>

Well this is just coming from the generated alias string in the pmu 
code, and it does not seem to be handling "period" argument properly. It 
needs to be checked.
Thanks,
John
