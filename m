Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E39C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F582098B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgEKL0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:26:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729864AbgEKL0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:26:16 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3774A85C518BDB71CCA5;
        Mon, 11 May 2020 12:26:15 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.142) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 11 May
 2020 12:26:13 +0100
Subject: Re: [PATCH RFC v3 09/12] perf metricgroup: Split up
 metricgroup__add_metric()
To:     Jiri Olsa <jolsa@redhat.com>, <qiangqing.zhang@nxp.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <irogers@google.com>, <robin.murphy@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-10-git-send-email-john.garry@huawei.com>
 <20200511110118.GA2986380@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <eeb29c90-52fc-fd17-6ad0-745372a1a15d@huawei.com>
Date:   Mon, 11 May 2020 12:25:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200511110118.GA2986380@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.142]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 12:01, Jiri Olsa wrote:
> On Thu, May 07, 2020 at 07:57:48PM +0800, John Garry wrote:
>> To aid supporting system event metric groups, break up the function
>> metricgroup__add_metric() into a part which iterates metrics and a part
>> which actually "adds" the metric.
>>
>> No functional change intended.
> 
> this no longer applied on Arnaldo's perf/core,


Hi jirka,

> it's very busy part now :-\

Right.

So I could rebase and resend, but I rather avoid that if possible since 
the metric code is so busy.

The point is that I would like to see progress on the kernel part first 
(to expose per-PMU sysfs identifier file). Once we agreement there, then 
I can promote this series to non-RFC and ensure I'm based on acme tip.

Hi Joakim, can you progress 
https://lore.kernel.org/linux-arm-kernel/20200226073433.5834-1-qiangqing.zhang@nxp.com/ 
to non-RFC now?

Thanks,
John


> 
> jirka
> 
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   tools/perf/util/metricgroup.c | 75 ++++++++++++++++++++++++++-----------------
>>   1 file changed, 45 insertions(+), 30 deletions(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 926449a7cdbf..d1033756a1bc 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -231,6 +231,12 @@ static bool match_metric(const char *n, const char *list)
>>   	return false;
>>   }
>>   
>> +static bool match_pe_metric(struct pmu_event *pe, const char *metric)
>> +{
>> +	return match_metric(pe->metric_group, metric) ||
>> +	       match_metric(pe->metric_name, metric);
>> +}
>> +
>>   struct mep {
>>   	struct rb_node nd;
>>   	const char *name;
>> @@ -485,6 +491,40 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>>   	return false;
>>   }
>>   
>> +static int metricgroup__add_metric_pmu_event(struct pmu_event *pe,
>> +					     struct strbuf *events,
>> +					     struct list_head *group_list)
>> +{
>> +	const char **ids;
>> +	int idnum;
>> +	struct egroup *eg;
>> +
>> +	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>> +
>> +	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum) < 0)
>> +		return 0;
>> +
>> +	if (events->len > 0)
>> +		strbuf_addf(events, ",");
>> +
>> +	if (metricgroup__has_constraint(pe))
>> +		metricgroup__add_metric_non_group(events, ids, idnum);
>> +	else
>> +		metricgroup__add_metric_weak_group(events, ids, idnum);
>> +
>> +	eg = malloc(sizeof(*eg));
>> +	if (!eg)
>> +		return -ENOMEM;
>> +	eg->ids = ids;
>> +	eg->idnum = idnum;
>> +	eg->metric_name = pe->metric_name;
>> +	eg->metric_expr = pe->metric_expr;
>> +	eg->metric_unit = pe->unit;
>> +	list_add_tail(&eg->nd, group_list);
>> +
>> +	return 0;
>> +}
>> +
>>   static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>>   				   struct list_head *group_list)
>>   {
>> @@ -502,37 +542,12 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>>   			break;
>>   		if (!pe->metric_expr)
>>   			continue;
>> -		if (match_metric(pe->metric_group, metric) ||
>> -		    match_metric(pe->metric_name, metric)) {
>> -			const char **ids;
>> -			int idnum;
>> -			struct egroup *eg;
>> -
>> -			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>>   
>> -			if (expr__find_other(pe->metric_expr,
>> -					     NULL, &ids, &idnum) < 0)
>> -				continue;
>> -			if (events->len > 0)
>> -				strbuf_addf(events, ",");
>> -
>> -			if (metricgroup__has_constraint(pe))
>> -				metricgroup__add_metric_non_group(events, ids, idnum);
>> -			else
>> -				metricgroup__add_metric_weak_group(events, ids, idnum);
>> -
>> -			eg = malloc(sizeof(struct egroup));
>> -			if (!eg) {
>> -				ret = -ENOMEM;
>> -				break;
>> -			}
>> -			eg->ids = ids;
>> -			eg->idnum = idnum;
>> -			eg->metric_name = pe->metric_name;
>> -			eg->metric_expr = pe->metric_expr;
>> -			eg->metric_unit = pe->unit;
>> -			list_add_tail(&eg->nd, group_list);
>> -			ret = 0;
>> +		if (match_pe_metric(pe, metric)) {
>> +			ret = metricgroup__add_metric_pmu_event(pe, events,
>> +								group_list);
>> +			if (ret)
>> +				return ret;
>>   		}
>>   	}
>>   	return ret;
>> -- 
>> 2.16.4
>>
> 
> .
> 

