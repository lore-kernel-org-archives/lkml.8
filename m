Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB3FC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378A120702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgA2Gkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 01:40:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgA2Gkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 01:40:39 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00T6chQw071392;
        Wed, 29 Jan 2020 01:40:31 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xu147xu1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 01:40:30 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00T6eU4b077014;
        Wed, 29 Jan 2020 01:40:30 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xu147xu0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 01:40:30 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00T6Z7YB027463;
        Wed, 29 Jan 2020 06:40:29 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2xrda6qk38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 06:40:29 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00T6eRCe47317436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 06:40:28 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE58F136053;
        Wed, 29 Jan 2020 06:40:27 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F21E13604F;
        Wed, 29 Jan 2020 06:40:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.123])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jan 2020 06:40:23 +0000 (GMT)
Subject: Re: [PATCH v2] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200122064721.24276-1-kjain@linux.ibm.com>
 <20200127154110.GF1114818@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <238f6f80-dc3e-3245-2fc0-a10e37e49a74@linux.ibm.com>
Date:   Wed, 29 Jan 2020 12:10:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200127154110.GF1114818@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_09:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001290053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/27/20 9:11 PM, Jiri Olsa wrote:
> On Wed, Jan 22, 2020 at 12:17:21PM +0530, Kajol Jain wrote:
>
> SNIP
>
>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   tools/perf/util/evlist.h      |  1 +
>>   tools/perf/util/metricgroup.c | 14 +++++++++++++-
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> ---
>> Changelog:
>> v1 -> v2
>> - Rather then adding static variable in metricgroup.c,
>>    add a new variable in evlist itself with name 'evlist_iter'
>> ---
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index f5bd5c386df1..255f872aee92 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -54,6 +54,7 @@ struct evlist {
>>   	bool		 enabled;
>>   	int		 id_pos;
>>   	int		 is_pos;
>> +	int		 evlist_iter;
>>   	u64		 combined_sample_type;
>>   	enum bkw_mmap_state bkw_mmap_state;
>>   	struct {
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 02aee946b6c1..911fab4ac04b 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -96,10 +96,13 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>>   				      struct evsel **metric_events)
>>   {
>>   	struct evsel *ev;
>> -	int i = 0;
>> +	int i = 0, j = 0;
>>   	bool leader_found;
>>   
>>   	evlist__for_each_entry (perf_evlist, ev) {
>> +		j++;
>> +		if (j <= perf_evlist->evlist_iter)
>> +			continue;
> hm, but that won't work when event does not match and all
> is rolled over in th next condition, no?

Hi jiri,

     Thanks for the review. Yes you are right. Need to take care of that 
case.

>
> how about something like below.. I only checked I got same
> results as you did in the changelog, but haven't tested
> otherwise.. especially I think that the check I removed
> is redundant
>
> could you please also add test for this testcase?
>
> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 02aee946b6c1..c12f3efccec8 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -93,13 +93,16 @@ struct egroup {
>   static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   				      const char **ids,
>   				      int idnum,
> -				      struct evsel **metric_events)
> +				      struct evsel **metric_events,
> +				      bool used[])
>   {
>   	struct evsel *ev;
> -	int i = 0;
> +	int i = 0, j = 0;
>   	bool leader_found;
>   
>   	evlist__for_each_entry (perf_evlist, ev) {
> +		if (used[j++])
> +			continue;
>   		if (!strcmp(ev->name, ids[i])) {
>   			if (!metric_events[i])
>   				metric_events[i] = ev;
> @@ -107,22 +110,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   			if (i == idnum)
>   				break;
>   		} else {
> -			if (i + 1 == idnum) {
> +			if (i) {
>   				/* Discard the whole match and start again */
>   				i = 0;
>   				memset(metric_events, 0,
>   				       sizeof(struct evsel *) * idnum);
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
>   			}

Incase we have match miss, we need to restart the match comparison again.

But I think we can't totally remove this check as, we also need to make 
sure we take current event in match logic. Maybe something like this:

                 } else {

-                       if (i + 1 == idnum) {
-                               /* Discard the whole match and start 
again */
-                               i = 0;
-                               memset(metric_events, 0,
-                                      sizeof(struct evsel *) * idnum);
-                               continue;
-                       }
-
-                       if (!strcmp(ev->name, ids[i]))
-                               metric_events[i] = ev;
-                       else {
-                               /* Discard the whole match and start 
again */
-                               i = 0;
-                               memset(metric_events, 0,
-                                      sizeof(struct evsel *) * idnum);
-                               continue;

+                       /* Discard the whole match and start again */
+                       i = 0;
+                       memset(metric_events, 0,
+                               sizeof(struct evsel *) * idnum);
+
+                       if (!strcmp(ev->name, ids[i])) {
+                               if (!metric_events[i])
+                                       metric_events[i] = ev;
+                               i++;
+                               if (i == idnum)
+                                       break;
                         }

Please let me know if it sounds fine.

Thanks,

Kajol

>   		}
>   	}
> @@ -144,9 +136,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   			    !strcmp(ev->name, metric_events[i]->name)) {
>   				ev->metric_leader = metric_events[i];
>   			}
> +			j++;
>   		}
> +		ev = metric_events[i];
> +		used[ev->idx] = true;
>   	}
> -
>   	return metric_events[0];
>   }
>   
> @@ -160,6 +154,9 @@ static int metricgroup__setup_events(struct list_head *groups,
>   	int ret = 0;
>   	struct egroup *eg;
>   	struct evsel *evsel;
> +	bool used[perf_evlist->core.nr_entries];
> +
> +	memset(used, 0, perf_evlist->core.nr_entries);
>   
>   	list_for_each_entry (eg, groups, nd) {
>   		struct evsel **metric_events;
> @@ -170,7 +167,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>   			break;
>   		}
>   		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
> -					 metric_events);
> +					 metric_events, used);
>   		if (!evsel) {
>   			pr_debug("Cannot resolve %s: %s\n",
>   					eg->metric_name, eg->metric_expr);
>
