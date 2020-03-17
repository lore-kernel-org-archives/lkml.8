Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE7C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5624820724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgCQRnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:43:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2571 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbgCQRnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:43:02 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3248716AE0BD38D47F81;
        Tue, 17 Mar 2020 17:42:58 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Mar 2020 17:42:57 +0000
Received: from [127.0.0.1] (10.47.11.44) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Mar
 2020 17:42:56 +0000
Subject: Re: [PATCH v2 2/7] perf jevents: Support test events folder
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <james.clark@arm.com>, <qiangqing.zhang@nxp.com>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
 <1584442939-8911-3-git-send-email-john.garry@huawei.com>
 <20200317162052.GD759708@krava>
 <de5b58ee-980e-973a-16db-73f23c3edfef@huawei.com>
 <20200317170645.GE759708@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dcaf4aa9-213e-47c5-16e2-e7f8af259ce9@huawei.com>
Date:   Tue, 17 Mar 2020 17:42:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200317170645.GE759708@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.11.44]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2020 17:06, Jiri Olsa wrote:
> On Tue, Mar 17, 2020 at 04:25:32PM +0000, John Garry wrote:
>> On 17/03/2020 16:20, Jiri Olsa wrote:
>>> On Tue, Mar 17, 2020 at 07:02:14PM +0800, John Garry wrote:
>>>> With the goal of supporting pmu-events test case, introduce support for a
>>>> test events folder.
>>>>
>>>> These test events can be used for testing generation of pmu-event tables
>>>> and alias creation for any arch.
>>>>
>>>> When running the pmu-events test case, these test events will be used
>>>> as the platform-agnostic events, so aliases can be created per-PMU and
>>>> validated against known expected values.
>>>>
>>>> To support the test events, add a "testcpu" entry in pmu_events_map[].
>>>> The pmu-events test will be able to lookup the events map for "testcpu",
>>>> to verify the generated tables against expected values.
>>>>
>>>> The resultant generated pmu-events.c will now look like the following:
>>>
>>> can't compile this one:
>>>
>>>     HOSTCC   pmu-events/jevents.o
>>> pmu-events/jevents.c: In function ‘main’:
>>> pmu-events/jevents.c:1195:3: error: ‘ret’ undeclared (first use in this function)
>>>    1195 |   ret = 1;
>>>         |   ^~~
>>> pmu-events/jevents.c:1195:3: note: each undeclared identifier is reported only once for each function it appears in
>>> pmu-events/jevents.c:1196:3: error: label ‘out_free_mapfile’ used but not defined
>>>    1196 |   goto out_free_mapfile;
>>>         |   ^~~~
>>> mv: cannot stat 'pmu-events/.jevents.o.tmp': No such file or directory
>>> make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97: pmu-events/jevents.o] Error 1
>>> make[2]: *** [Makefile.perf:619: pmu-events/jevents-in.o] Error 2
>>> make[1]: *** [Makefile.perf:225: sub-make] Error 2
>>> make: *** [Makefile:70: all] Error 2
>>
>> Hi jirka,
>>
>> What baseline are you using? I used v5.6-rc6. The patches are here:
> 
> I applied your patches on Arnaldo's perf/core

My recent fix on jevents.c does not seem to be on that branch, but it is 
on perf/urgent and also included in v5.6-rc6

Thanks,
John

> 
>>
>> https://github.com/hisilicon/kernel-dev/commits/private-topic-perf-5.6-pmu-events-test-upstream-v2
> 
> ok, will check
> 
> jirka
> 
> .
> 

