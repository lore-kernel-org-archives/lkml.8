Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B0C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7241F2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgD0JEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:04:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2103 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbgD0JEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:04:34 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 61123C1D0363CAD51DE2;
        Mon, 27 Apr 2020 10:04:33 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.137) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Apr
 2020 10:04:31 +0100
Subject: Re: [RFC PATCH v2 01/13] perf parse-events: Fix comparison of evsel
 and leader pmu name
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <qiangqing.zhang@nxp.com>, <irogers@google.com>,
        <robin.murphy@arm.com>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-2-git-send-email-john.garry@huawei.com>
 <20200427081624.GA1431639@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ead36e57-3baf-6af2-57d8-c0fa365926cd@huawei.com>
Date:   Mon, 27 Apr 2020 10:03:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200427081624.GA1431639@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.137]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2020 09:16, Jiri Olsa wrote:
> On Fri, Apr 17, 2020 at 06:41:12PM +0800, John Garry wrote:
>> Since we now strdup() the pmu name for the event selector, use strcmp()
>> instead of pointer equality for comparison.
>>
>> Fixes: d4953f7ef1a2 ("perf parse-events: Fix 3 use after frees found with clang ASANutil/parse-events.c")
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> I don't ee this change in your branch:
>    private-topic-perf-5.6-sys-pmu-events-v2-upstream
> 
> do you have some updated tree?

I have started rebase work here:

https://github.com/hisilicon/kernel-dev/commits/private-topic-perf-5.7-sys-pmu-events-v2

Without this patch, I get this spewed for metric events:

	assertion failed at util/parse-events.c:1637

However, if there was a problem on mainline, I would expect some other 
reports now.

Thanks,
John



> 
>> ---
>>
>> I am not 100% sure that this is the right fix....
>>
>>   tools/perf/util/parse-events.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index 10107747b361..90ddade1ba23 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -1629,7 +1629,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>>   		 * event. That can be used to distinguish the leader from
>>   		 * other members, even they have the same event name.
>>   		 */
>> -		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
>> +		if ((leader != evsel) && !strcmp(leader->pmu_name, evsel->pmu_name)) {
>>   			is_leader = false;
>>   			continue;
>>   		}
>> -- 
>> 2.16.4
>>
> 
> .
> 

