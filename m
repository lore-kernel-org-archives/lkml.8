Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8571C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87662075B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHYIQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:16:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbgHYIQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:16:39 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5C7627B498D567DE738A;
        Tue, 25 Aug 2020 09:16:37 +0100 (IST)
Received: from [127.0.0.1] (10.47.8.13) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 25 Aug
 2020 09:16:36 +0100
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
To:     Kajol Jain <kjain@linux.ibm.com>, <acme@kernel.org>
CC:     <jolsa@redhat.com>, <ak@linux.intel.com>,
        <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <maddy@linux.ibm.com>, <ravi.bangoria@linux.ibm.com>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
Date:   Tue, 25 Aug 2020 09:14:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.13]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2020 08:40, Kajol Jain wrote:
> This patch adds new structure called 'json_event' inside jevents.h
> file to improve the callback prototype inside jevent files.
> Initially, whenever user want to add new field, they need to update
> in all function callback which make it more and more complex with
> increased number of parmeters.
> With this change, we just need to add it in new structure 'json_event'.
> 
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>   tools/perf/pmu-events/jevents.c | 188 +++++++++++++-------------------
>   tools/perf/pmu-events/jevents.h |  28 +++--
>   2 files changed, 94 insertions(+), 122 deletions(-)
> 
> This is the initial prototype to include structure for passing
> json fileds. Please, Let me know if this is the right direction
> to go forward.
> This patch doen't include all the changes, like percore/perchip
> field addition. If this looks fine I can send new patch set with
> those changes.
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..606805af69fe 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -318,12 +318,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>   	close_table = 1;
>   }
>   
> -static int print_events_table_entry(void *data, char *name, char *event,
> -				    char *desc, char *long_desc,
> -				    char *pmu, char *unit, char *perpkg,
> -				    char *metric_expr,
> -				    char *metric_name, char *metric_group,
> -				    char *deprecated, char *metric_constraint)

Right, too many paramaetrs of the same type, so looks reasonable to pass 
a struct

[...]

>   		if (arch_std) {
>   			/*
>   			 * An arch standard event is referenced, so try to
>   			 * fixup any unassigned values.
>   			 */
> -			err = try_fixup(fn, arch_std, &event, &desc, &name,
> -					&long_desc, &pmu, &filter, &perpkg,
> -					&unit, &metric_expr, &metric_name,
> -					&metric_group, eventcode,
> -					&deprecated, &metric_constraint);
> +			err = try_fixup(fn, arch_std, eventcode, je);
>   			if (err)
>   				goto free_strings;
>   		}
> -		err = func(data, name, real_event(name, event), desc, long_desc,
> -			   pmu, unit, perpkg, metric_expr, metric_name,
> -			   metric_group, deprecated, metric_constraint);
> +		je->event = real_event(je->name, je->event);
> +		err = func(data, je);
>   free_strings:
> -		free(event);
> -		free(desc);
> -		free(name);
> -		free(long_desc);
>   		free(extra_desc);
> -		free(pmu);
>   		free(filter);
> -		free(perpkg);
> -		free(deprecated);
> -		free(unit);
> -		free(metric_expr);
> -		free(metric_name);
> -		free(metric_group);
> -		free(metric_constraint);
>   		free(arch_std);
> +		free(je);
>   
>   		if (err)
>   			break;
> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> index 2afc8304529e..e696edf70e9a 100644
> --- a/tools/perf/pmu-events/jevents.h
> +++ b/tools/perf/pmu-events/jevents.h

Somewhat unrelated - this file only seems to be included in jevents.c, 
so I don't see why it exists...

> @@ -2,14 +2,28 @@
>   #ifndef JEVENTS_H
>   #define JEVENTS_H 1
>   
> +#include "pmu-events.h"
> +
> +struct json_event {
> +	char *name;
> +	char *event;
> +	char *desc;
> +	char *topic;
> +	char *long_desc;
> +	char *pmu;
> +	char *unit;
> +	char *perpkg;
> +	char *metric_expr;
> +	char *metric_name;
> +	char *metric_group;
> +	char *deprecated;
> +	char *metric_constraint;

This looks very much like struct event_struct, so could look to consolidate:

struct event_struct {
	struct list_head list;
	char *name;
	char *event;
	char *desc;
	char *long_desc;
	char *pmu;
	char *unit;
	char *perpkg;
	char *metric_expr;
	char *metric_name;
	char *metric_group;
	char *deprecated;
	char *metric_constraint;
};

> +};
> +
>   int json_events(const char *fn,
> -		int (*func)(void *data, char *name, char *event, char *desc,
> -				char *long_desc,
> -				char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint),
> -		void *data);
> +		int (*func)(void *data, struct json_event *je),
> +			void *data);
> +
>   char *get_cpu_str(void);
>   
>   #ifndef min
> 

