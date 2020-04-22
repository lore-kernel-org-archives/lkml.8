Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BCFC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D45320787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgDVMBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:01:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbgDVMA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:00:59 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 64EC8B75D221856C0CEB;
        Wed, 22 Apr 2020 13:00:58 +0100 (IST)
Received: from [127.0.0.1] (10.47.10.232) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 22 Apr
 2020 13:00:56 +0100
Subject: Re: [RFC PATCH v2 10/13] perf metricgroup: Split up
 metricgroup__add_metric()
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <qiangqing.zhang@nxp.com>, <irogers@google.com>,
        <robin.murphy@arm.com>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-11-git-send-email-john.garry@huawei.com>
 <20200422114432.GH962614@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b793b75e-0c55-a986-0a5e-a7aac269cae5@huawei.com>
Date:   Wed, 22 Apr 2020 13:00:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200422114432.GH962614@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.232]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 12:44, Jiri Olsa wrote:
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
> also this place got changed just recently a lot,
> so you might want to rebase to the Arnaldo's latest perf/core

Hi jirka,

Yeah, I saw that. I can check.

TBH, apart from that, I would be welcome to opinion on this latter patch 
of the series, concerned with metrics. I just split (butcher) the 
function and call common parts from 2x places now. Maybe there's a more 
fluid way to do this.

Cheers,
John
