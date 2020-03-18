Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B7C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCD520753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCRMqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:46:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgCRMqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:46:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICXtwC135294;
        Wed, 18 Mar 2020 08:46:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu7d9h146-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 08:46:26 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02ICY2Sj136053;
        Wed, 18 Mar 2020 08:46:26 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu7d9h13w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 08:46:25 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02ICduoF015937;
        Wed, 18 Mar 2020 12:46:25 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 2yrpw70eat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 12:46:25 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ICkOSr53346610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 12:46:24 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B7F113604F;
        Wed, 18 Mar 2020 12:46:24 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD3D8136061;
        Wed, 18 Mar 2020 12:46:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.107])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Mar 2020 12:46:00 +0000 (GMT)
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com> <20200317150647.GA757893@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <15a73fa0-4c94-221f-020d-687f91d08de6@linux.ibm.com>
Date:   Wed, 18 Mar 2020 18:15:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200317150647.GA757893@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_05:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003180059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 8:36 PM, Jiri Olsa wrote:
> On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
>> index 0938ad166ece..7786829b048b 100644
>> --- a/tools/perf/util/expr.h
>> +++ b/tools/perf/util/expr.h
>> @@ -17,12 +17,13 @@ struct expr_parse_ctx {
>>  
>>  struct expr_scanner_ctx {
>>  	int start_token;
>> +	int expr__runtimeparam;
> 
> no need for expr__ prefix in here.. jsut runtime_param

Hi Jiri,
	Will take care for this part.
> 
>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>> index 402af3e8d287..85ac6d913782 100644
>> --- a/tools/perf/util/stat-shadow.c
>> +++ b/tools/perf/util/stat-shadow.c
>> @@ -336,7 +336,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
>>  		metric_events = counter->metric_events;
>>  		if (!metric_events) {
>>  			if (expr__find_other(counter->metric_expr, counter->name,
>> -						&metric_names, &num_metric_names) < 0)
>> +						&metric_names, &num_metric_names, 1) < 0)
>>  				continue;
>>  
>>  			metric_events = calloc(sizeof(struct evsel *),
>> @@ -777,7 +777,15 @@ static void generic_metric(struct perf_stat_config *config,
>>  	}
>>  
>>  	if (!metric_events[i]) {
>> -		if (expr__parse(&ratio, &pctx, metric_expr) == 0) {
>> +		int param = 1;
>> +		if (strstr(metric_expr, "?")) {
>> +			char *tmp = strrchr(metric_name, '_');
>> +
>> +			tmp++;
>> +			param = strtol(tmp, &tmp, 10);
>> +		}
> 
> so, if metric_expr contains '?' you go and search metric_name for '_'
> and use the number after '_' ... ugh.. what's the logic? 
> 
> I understand you create as many metrics as the magic runtime param
> tells you.. but what's the connection to this?
> 
> could you please outline in the changelog or comment the whole scheme
> of how this all should work? like step by step on some simple example?

Sure, will add that part as comment in my next patch series.
So, you are right, basically right now I am trying to create as many metric events
as define by runtime_param.

To do that, I add one loop in function `metricgroup__add_metric_runtime_param`
where, we are actually passing this parameter value as part of `expr__find_other` function
and changing "?" present in metric expression with this value.

And then adding this metric event to the tail of group_list.

As in our json file, there gonna be single metric event, and out of which we are creating
multiple events, I am also merging this value to the original metric name to specify parameter value.

For example,
command:# ./perf stat  -M PowerBUS_Frequency -C 0 -I 1000
#           time             counts unit events
     1.000101867          9,356,933      hv_24x7/pm_pb_cyc,chip=0/ #      2.3 GHz  PowerBUS_Frequency_0
     1.000101867          9,366,134      hv_24x7/pm_pb_cyc,chip=1/ #      2.3 GHz  PowerBUS_Frequency_1
     2.000314878          9,365,868      hv_24x7/pm_pb_cyc,chip=0/ #      2.3 GHz  PowerBUS_Frequency_0
     2.000314878          9,366,092      hv_24x7/pm_pb_cyc,chip=1/ #      2.3 GHz  PowerBUS_Frequency_1

So, here _0 and _1 after PowerBUS_Frequency specify parameter value.

So, after adding this to group_list, again we call expr__parse in generic_metric function present in
util/stat-display.c. By this time again we need to pass this parameter value. So, now to get this value actually
I am trying to extract it from metric name itself. Not sure if its good way to do that.

Is it sound fine, or should I add param as part of structure evsel as well. So, another way to do that
is adding this parameter in `evsel` structure and also egroup structure. So, I will update this value
in metricgroup.c and access it in stat-shadow?

Thanks,
Kajol
  

> 
> thanks,
> jirka
> 
