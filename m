Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC338C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5AB2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXFwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:52:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgGXFwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:52:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O5Won1029108;
        Fri, 24 Jul 2020 01:52:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fadfrm8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 01:52:36 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06O5YTCI033082;
        Fri, 24 Jul 2020 01:52:35 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fadfrm84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 01:52:35 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O5neQO026741;
        Fri, 24 Jul 2020 05:52:35 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 32brq9j3mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 05:52:35 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06O5qWfA23134974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 05:52:32 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 469AD136053;
        Fri, 24 Jul 2020 05:52:34 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09CF613604F;
        Fri, 24 Jul 2020 05:52:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.212.181])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 05:52:29 +0000 (GMT)
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
 <20200720072237.GC760733@krava>
 <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
 <20200720081943.GE760733@krava>
 <dd465647-da63-c473-9944-bdfec2abe484@linux.ibm.com>
 <20200720191625.GL760733@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <eec934d1-5f45-739e-d5df-847a4b995fa5@linux.ibm.com>
Date:   Fri, 24 Jul 2020 11:22:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720191625.GL760733@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_01:2020-07-24,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 12:46 AM, Jiri Olsa wrote:
> On Mon, Jul 20, 2020 at 02:32:40PM +0530, kajoljain wrote:
>>
>>
>> On 7/20/20 1:49 PM, Jiri Olsa wrote:
>>> On Mon, Jul 20, 2020 at 01:39:24PM +0530, kajoljain wrote:
>>>
>>> SNIP
>>>
>>>> This is with your perf/metric branch:
>>>> command# ./perf stat -M PowerBUS_Frequency -C 0 -I 1000
>>>> assertion failed at util/metricgroup.c:709
>>>> #           time             counts unit events
>>>>      1.000054545          7,807,505      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
>>>>      1.000054545          7,807,485      hv_24x7/pm_pb_cyc,chip=1/                                   
>>>>      2.000232761          7,807,500      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
>>>>      2.000232761          7,807,478      hv_24x7/pm_pb_cyc,chip=1/                                   
>>>>      3.000363762          7,799,665      hv_24x7/pm_pb_cyc,chip=0/ #      1.9 GHz  PowerBUS_Frequency_0
>>>>      3.000363762          7,807,502      hv_24x7/pm_pb_cyc,chip=1/                                   
>>>> ^C     3.259418599          2,022,150      hv_24x7/pm_pb_cyc,chip=0/ #      0.5 GHz  PowerBUS_Frequency_0
>>>>      3.259418599          2,022,164      hv_24x7/pm_pb_cyc,chip=1/                                   
>>>>
>>>>  Performance counter stats for 'CPU(s) 0':
>>>>
>>>>         25,436,820      hv_24x7/pm_pb_cyc,chip=0/ #      6.4 GHz  PowerBUS_Frequency_0
>>>>         25,444,629      hv_24x7/pm_pb_cyc,chip=1/                                   
>>>>
>>>>        3.259505529 seconds time elapsed
>>>
>>> I found the bug, we are not adding runtime metrics as standalone ones,
>>> but as referenced metrics.. will fix and try to add test for that
>>>
>>> as for testing.. do I need some special ppc server to have support for this? 
>>
>> Hi jiri,
>>     We need power9 lpar machine and need to make sure `CONFIG_HV_PERF_CTRS` is
>> enabled.
> 
> could you please try with following patch on top?

Hi Jiri,
       The change looks good to me. I tried with adding this patch on top of your perf/metric branch. It did resolve the issue of not printing
all chips data. And now I can see proper values for hv-24x7 metric events.

I was also trying by adding new metric using the feature added in this patchset with something like this:

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
index 8383a37647ad..dfe4bd63b587 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -16,6 +16,11 @@
         "MetricName": "PowerBUS_Frequency",
         "ScaleUnit": "2.5e-7GHz"
     },
+    {
+       "MetricExpr": "Memory_WR_BW_Chip + Memory_RD_BW_Chip",
+        "MetricName": "Total_Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },

I guess as we have dependency on '?' symbol, I am not able to see all chips data for Total_Memory_BW.
I am not sure if Its expected behavior?

This is what I am getting:

[root@ltc-zz189-lp4 perf]# ./perf stat --metric-only -M Total_Memory_BW,Memory_WR_BW_Chip,Memory_RD_BW_Chip -I 1000 -C 0
#           time  MB  Total_Memory_BW MB  Memory_RD_BW_Chip_1 MB  Memory_WR_BW_Chip_1 MB  Memory_WR_BW_Chip_0 MB  Memory_RD_BW_Chip_0 
     1.000067388                 36.4                      0.2                     36.3                     65.0                     72.1 
     2.000374276                 36.2                      0.3                     35.9                     65.4                     77.9 
     3.000543202                 36.3                      0.3                     36.0                     68.7                     81.2 
     4.000702855                 36.3                      0.3                     36.0                     70.9                     93.3 
     5.000856837                 36.0                      0.2                     35.8                     67.4                     81.5 
^C     5.367865273                 13.2                      0.1                     13.1                     23.5                     28.3 
 Performance counter stats for 'CPU(s) 0':
               194.4                      1.3                    193.1                    361.0                    434.3 
       5.368039176 seconds time elapsed

We can only get single chip data's sum in Total_Memory_BW. Please let me know if I am missing something.

Thanks,
Kajol Jain
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 6f179b9903a0..03aa4bd4a38b 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -820,11 +820,11 @@ static int add_metric(struct list_head *metric_list,
>  		      struct expr_id *parent,
>  		      struct expr_ids *ids);
>  
> -static int resolve_metric(struct metric *m,
> -			  bool metric_no_group,
> -			  struct list_head *metric_list,
> -			  struct pmu_events_map *map,
> -			  struct expr_ids *ids)
> +static int __resolve_metric(struct metric *m,
> +			    bool metric_no_group,
> +			    struct list_head *metric_list,
> +			    struct pmu_events_map *map,
> +			    struct expr_ids *ids)
>  {
>  	struct hashmap_entry *cur;
>  	size_t bkt;
> @@ -869,6 +869,23 @@ static int resolve_metric(struct metric *m,
>  	return 0;
>  }
>  
> +static int resolve_metric(bool metric_no_group,
> +			  struct list_head *metric_list,
> +			  struct pmu_events_map *map,
> +			  struct expr_ids *ids)
> +{
> +	struct metric *m;
> +	int err;
> +
> +	list_for_each_entry(m, metric_list, nd) {
> +		err = __resolve_metric(m, metric_no_group, metric_list, map, ids);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int add_metric(struct list_head *metric_list,
>  		      struct pmu_event *pe,
>  		      bool metric_no_group,
> @@ -876,6 +893,7 @@ static int add_metric(struct list_head *metric_list,
>  		      struct expr_id *parent,
>  		      struct expr_ids *ids)
>  {
> +	struct metric *orig = *m;
>  	int ret = 0;
>  
>  	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> @@ -892,7 +910,7 @@ static int add_metric(struct list_head *metric_list,
>  		 * those events to metric_list.
>  		 */
>  
> -		for (j = 0; j < count && !ret; j++) {
> +		for (j = 0; j < count && !ret; j++, *m = orig) {
>  			ret = __add_metric(metric_list, pe, metric_no_group, j, m, parent, ids);
>  		}
>  	}
> @@ -907,8 +925,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  
>  {
>  	struct expr_ids ids = { 0 };
> +	struct metric *m = NULL;
>  	struct pmu_event *pe;
> -	struct metric *m;
>  	LIST_HEAD(list);
>  	int i, ret;
>  	bool has_match = false;
> @@ -925,7 +943,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  		 * Process any possible referenced metrics
>  		 * included in the expression.
>  		 */
> -		ret = resolve_metric(m, metric_no_group,
> +		ret = resolve_metric(metric_no_group,
>  				     &list, map, &ids);
>  		if (ret)
>  			return ret;
> 
