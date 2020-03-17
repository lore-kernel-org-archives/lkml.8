Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE2C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77247206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgCQGVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:21:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgCQGVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:21:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02H6KS0Z064726;
        Tue, 17 Mar 2020 02:21:24 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yrue2ngnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 02:21:24 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02H6F2se002586;
        Tue, 17 Mar 2020 06:21:23 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 2yrpw6dvuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 06:21:23 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02H6LMmw13435584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 06:21:22 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C39B5124058;
        Tue, 17 Mar 2020 06:21:22 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20D6E124053;
        Tue, 17 Mar 2020 06:21:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.63.85])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Mar 2020 06:21:17 +0000 (GMT)
Subject: Re: [PATCH v6] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200221101121.28920-1-kjain@linux.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <db7121ca-d188-1516-6516-8b25209078f5@linux.ibm.com>
Date:   Tue, 17 Mar 2020 11:51:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200221101121.28920-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_01:2020-03-12,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=3 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,
	Can you pull this patch if it looks fine to you. Please let
me know if any changes require.

Thanks,
Kajol

On 2/21/20 3:41 PM, Kajol Jain wrote:
> Commit f01642e4912b ("perf metricgroup: Support multiple
> events for metricgroup") introduced support for multiple events
> in a metric group. But with the current upstream, metric events
> names are not printed properly incase we try to run multiple
> metric groups with overlapping event.
> 
> With current upstream version, incase of overlapping metric events
> issue is, we always start our comparision logic from start.
> So, the events which already matched with some metric group also
> take part in comparision logic. Because of that when we have overlapping
> events, we end up matching current metric group event with already matched
> one.
> 
> For example, in skylake machine we have metric event CoreIPC and
> Instructions. Both of them need 'inst_retired.any' event value.
> As events in Instructions is subset of events in CoreIPC, they
> endup in pointing to same 'inst_retired.any' value.
> 
> In skylake platform:
> 
> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>      1,254,992,790      inst_retired.any          # 1254992790.0
>                                                     Instructions
>                                                   #      1.3 CoreIPC
>        977,172,805      cycles
>      1,254,992,756      inst_retired.any
> 
>        1.000802596 seconds time elapsed
> 
> command:# sudo ./perf stat -M UPI,IPC sleep 1
> 
>    Performance counter stats for 'sleep 1':
>            948,650      uops_retired.retire_slots
>            866,182      inst_retired.any          #      0.7 IPC
>            866,182      inst_retired.any
>          1,175,671      cpu_clk_unhalted.thread
> 
> Patch fixes the issue by adding a new bool pointer 'evlist_used' to keep
> track of events which already matched with some group by setting it true.
> So, we skip all used events in list when we start comparision logic.
> Patch also make some changes in comparision logic, incase we get a match
> miss, we discard the whole match and start again with first event id in
> metric event.
> 
> With this patch:
> In skylake platform:
> 
> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>          3,348,415      inst_retired.any          #      0.3 CoreIPC
>         11,779,026      cycles
>          3,348,381      inst_retired.any          # 3348381.0
>                                                     Instructions
> 
>        1.001649056 seconds time elapsed
> 
> command:# ./perf stat -M UPI,IPC sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>          1,023,148      uops_retired.retire_slots #      1.1 UPI
>            924,976      inst_retired.any
>            924,976      inst_retired.any          #      0.6 IPC
>          1,489,414      cpu_clk_unhalted.thread
> 
>        1.003064672 seconds time elapsed
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/util/metricgroup.c | 49 +++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> Changelog:
> v5 -> v6
> - Remove bool cast
> - Add Acked-by tag
> 
> v4 -> v5
> - Made small fix to return from function 'metricgroup__setup_events'
>   in case calloc fail
> 
> v3 -> v4
> - Make 'evlist_used' a bool pointer.
> 
> v2 -> v3
> - Add array in place of variable to keep track of matched events.
>   Because incase we miss match in previous approach, all events will
>   be rolled over in next condition. So, rather we add array and set  
>   it incase that variable already match with some group.
>   - Suggested by Jiri Olsa
> 
> v1 -> v2
> - Rather then adding static variable in metricgroup.c,
>   add a new variable in evlist itself with name 'evlist_iter'
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 02aee946b6c1..33bb138f7902 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -93,13 +93,16 @@ struct egroup {
>  static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>  				      const char **ids,
>  				      int idnum,
> -				      struct evsel **metric_events)
> +				      struct evsel **metric_events,
> +				      bool *evlist_used)
>  {
>  	struct evsel *ev;
> -	int i = 0;
> +	int i = 0, j = 0;
>  	bool leader_found;
>  
>  	evlist__for_each_entry (perf_evlist, ev) {
> +		if (evlist_used[j++])
> +			continue;
>  		if (!strcmp(ev->name, ids[i])) {
>  			if (!metric_events[i])
>  				metric_events[i] = ev;
> @@ -107,22 +110,17 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>  			if (i == idnum)
>  				break;
>  		} else {
> -			if (i + 1 == idnum) {
> -				/* Discard the whole match and start again */
> -				i = 0;
> -				memset(metric_events, 0,
> -				       sizeof(struct evsel *) * idnum);
> -				continue;
> -			}
> -
> -			if (!strcmp(ev->name, ids[i]))
> -				metric_events[i] = ev;
> -			else {
> -				/* Discard the whole match and start again */
> -				i = 0;
> -				memset(metric_events, 0,
> -				       sizeof(struct evsel *) * idnum);
> -				continue;
> +			/* Discard the whole match and start again */
> +			i = 0;
> +			memset(metric_events, 0,
> +				sizeof(struct evsel *) * idnum);
> +
> +			if (!strcmp(ev->name, ids[i])) {
> +				if (!metric_events[i])
> +					metric_events[i] = ev;
> +				i++;
> +				if (i == idnum)
> +					break;
>  			}
>  		}
>  	}
> @@ -144,7 +142,10 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>  			    !strcmp(ev->name, metric_events[i]->name)) {
>  				ev->metric_leader = metric_events[i];
>  			}
> +			j++;
>  		}
> +		ev = metric_events[i];
> +		evlist_used[ev->idx] = true;
>  	}
>  
>  	return metric_events[0];
> @@ -160,6 +161,13 @@ static int metricgroup__setup_events(struct list_head *groups,
>  	int ret = 0;
>  	struct egroup *eg;
>  	struct evsel *evsel;
> +	bool *evlist_used;
> +
> +	evlist_used = calloc(perf_evlist->core.nr_entries, sizeof(bool));
> +	if (!evlist_used) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
>  
>  	list_for_each_entry (eg, groups, nd) {
>  		struct evsel **metric_events;
> @@ -170,7 +178,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  			break;
>  		}
>  		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
> -					 metric_events);
> +					 metric_events, evlist_used);
>  		if (!evsel) {
>  			pr_debug("Cannot resolve %s: %s\n",
>  					eg->metric_name, eg->metric_expr);
> @@ -194,6 +202,9 @@ static int metricgroup__setup_events(struct list_head *groups,
>  		expr->metric_events = metric_events;
>  		list_add(&expr->nd, &me->head);
>  	}
> +
> +	free(evlist_used);
> +
>  	return ret;
>  }
>  
> 
