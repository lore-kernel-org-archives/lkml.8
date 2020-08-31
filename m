Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870F7208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgHaJDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:03:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbgHaJDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:03:37 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 576012F4CDB1E4693974;
        Mon, 31 Aug 2020 10:03:35 +0100 (IST)
Received: from [127.0.0.1] (10.210.167.41) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 31 Aug
 2020 10:03:34 +0100
Subject: Re: [PATCH v6 1/5] perf/jevents: Remove jevents.h file
To:     Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <pc@us.ibm.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <maddy@linux.ibm.com>, <ravi.bangoria@linux.ibm.com>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-2-kjain@linux.ibm.com> <20200831084348.GB287892@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ca73d0ff-0dfa-8d9e-1cb8-5791a78eb4e2@huawei.com>
Date:   Mon, 31 Aug 2020 10:01:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200831084348.GB287892@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.41]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2020 09:43, Jiri Olsa wrote:
> On Thu, Aug 27, 2020 at 06:39:54PM +0530, Kajol Jain wrote:
>> This patch removes jevents.h file and add its data inside
>> jevents.c as this file is only included there.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>   tools/perf/pmu-events/jevents.c |  9 ++++++++-
>>   tools/perf/pmu-events/jevents.h | 23 -----------------------
>>   2 files changed, 8 insertions(+), 24 deletions(-)
>>   delete mode 100644 tools/perf/pmu-events/jevents.h
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index fa86c5f997cc..1c55cc754b5a 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -48,11 +48,18 @@
>>   #include <linux/list.h>
>>   #include "jsmn.h"
>>   #include "json.h"
>> -#include "jevents.h"
>>   
>>   int verbose;
>>   char *prog;
>>   
>> +#ifndef min
>> +#define min(x, y) ({				\
>> +	typeof(x) _min1 = (x);			\
>> +	typeof(y) _min2 = (y);			\
>> +	(void)(&_min1 == &_min2);		\
>> +	_min1 < _min2 ? _min1 : _min2; })
>> +#endif

Wondering what is special about this definition of min that it's 
required? Compiled ok for me without it.

>> +
>>   int eprintf(int level, int var, const char *fmt, ...)
>>   {
>>   
>> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
>> deleted file mode 100644
>> index 2afc8304529e..000000000000
>> --- a/tools/perf/pmu-events/jevents.h
>> +++ /dev/null
>> @@ -1,23 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef JEVENTS_H
>> -#define JEVENTS_H 1
>> -
>> -int json_events(const char *fn,
>> -		int (*func)(void *data, char *name, char *event, char *desc,
>> -				char *long_desc,
>> -				char *pmu,
>> -				char *unit, char *perpkg, char *metric_expr,
>> -				char *metric_name, char *metric_group,
>> -				char *deprecated, char *metric_constraint),
>> -		void *data);
>> -char *get_cpu_str(void);
> 
> I think you can also remove get_cpu_str from jevents.c
> 
> thanks,
> jirka
> 
> .
> 

