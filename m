Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B0DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA12D206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgHZLpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:45:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728995AbgHZLgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:36:38 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id D483D9C856A5C6E4C3C4;
        Wed, 26 Aug 2020 12:35:39 +0100 (IST)
Received: from [127.0.0.1] (10.47.10.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 26 Aug
 2020 12:35:39 +0100
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
To:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
CC:     <acme@kernel.org>, <ak@linux.intel.com>, <yao.jin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <irogers@google.com>, <maddy@linux.ibm.com>,
        <ravi.bangoria@linux.ibm.com>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
 <20200826110046.GF703542@krava>
 <5d91b929-cffd-265a-dd0c-f63bc3d1565d@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ac9acc5f-7ce1-c9c9-91f5-598ca13a4a89@huawei.com>
Date:   Wed, 26 Aug 2020 12:33:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <5d91b929-cffd-265a-dd0c-f63bc3d1565d@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.200]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2020 12:24, kajoljain wrote:
> 
> 
> On 8/26/20 4:30 PM, Jiri Olsa wrote:
>> On Tue, Aug 25, 2020 at 09:14:11AM +0100, John Garry wrote:
>>
>> SNIP
>>
>>>>    				goto free_strings;
>>>>    		}
>>>> -		err = func(data, name, real_event(name, event), desc, long_desc,
>>>> -			   pmu, unit, perpkg, metric_expr, metric_name,
>>>> -			   metric_group, deprecated, metric_constraint);
>>>> +		je->event = real_event(je->name, je->event);
>>>> +		err = func(data, je);
>>>>    free_strings:
>>>> -		free(event);
>>>> -		free(desc);
>>>> -		free(name);
>>>> -		free(long_desc);
>>>>    		free(extra_desc);
>>>> -		free(pmu);
>>>>    		free(filter);
>>>> -		free(perpkg);
>>>> -		free(deprecated);
>>>> -		free(unit);
>>>> -		free(metric_expr);
>>>> -		free(metric_name);
>>>> -		free(metric_group);
>>>> -		free(metric_constraint);

Hi Kajol Jain,

Do we need to free je->metric_name and the rest still? From a glance, 
that memory is still separately alloc'ed in addfield.

>>>>    		free(arch_std);
>>>> +		free(je);
>>>>    		if (err)
>>>>    			break;
>>>> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
>>>> index 2afc8304529e..e696edf70e9a 100644
>>>> --- a/tools/perf/pmu-events/jevents.h
>>>> +++ b/tools/perf/pmu-events/jevents.h
>>>
>>> Somewhat unrelated - this file only seems to be included in jevents.c, so I
>>> don't see why it exists...
>>
>> ah right.. I won't mind getting rid of it
> 
> Hi John and  Jiri
>       Thanks for reviewing the patch. I can remove this file and add these structure inside jevents.c

thanks

> 
> Thanks,
> Kajol Jain
>>   
>>>> @@ -2,14 +2,28 @@
>>>>    #ifndef JEVENTS_H
>>>>    #define JEVENTS_H 1
>>>> +#include "pmu-events.h"
>>>> +
>>>> +struct json_event {
>>>> +	char *name;
>>>> +	char *event;
>>>> +	char *desc;
>>>> +	char *topic;
>>>> +	char *long_desc;
>>>> +	char *pmu;
>>>> +	char *unit;
>>>> +	char *perpkg;
>>>> +	char *metric_expr;
>>>> +	char *metric_name;
>>>> +	char *metric_group;
>>>> +	char *deprecated;
>>>> +	char *metric_constraint;
>>>
>>> This looks very much like struct event_struct, so could look to consolidate:
>>>
>>> struct event_struct {
>>> 	struct list_head list;
>>> 	char *name;
>>> 	char *event;
>>> 	char *desc;
>>> 	char *long_desc;
>>> 	char *pmu;
>>> 	char *unit;
>>> 	char *perpkg;
>>> 	char *metric_expr;
>>> 	char *metric_name;
>>> 	char *metric_group;
>>> 	char *deprecated;
>>> 	char *metric_constraint;
>>> };
>>
>> as Andi said they come from different layers, I think it's
>> better to keep them separated even if they share some fields

I was just suggesting to make:
  struct event_struct {
	struct list_head list;
	struct json_event je;
  }

No biggie if against this.

Cheers,
John
