Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBD7C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F1D2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W3S1hjTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIGGki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:40:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30926 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbgIGGkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:40:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0876WApM021205;
        Mon, 7 Sep 2020 02:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sUxH6UupmrTzk45VuALJ02RLoMALHR5XkiNic3S6+Zs=;
 b=W3S1hjTNTgKRyCvrvQbWTgp6Td4FlNGWFQ3+HqA1Cmr/Ugm2ad7knV6ZsU2JVahM8xN1
 dqORwbVfvP0QyilLUpP7XnWmhwbn9LNhrrBxZuD9kexbkCZHR+qAhxDTunNSZRvnV0fL
 PlvdjLtjL3Jj8Iljq1lTZVGgkIoPXTq3ov53iil3bRatQmsUl4T3/RX/hS3+1yhYxGUY
 kufMdijIqeKf/GlGZ4x4N7t79E8yVXWOMeh2uJOyZDc6LbJF0LpnDE+9izVJOM/h2LqS
 1V71bTxTOauj6a9Z9/bHInVrHIwzlw9Pkfvd+FKC6JG/maGCsRVm7s+x7+hSLkFm0rXV tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33de6ntdep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 02:40:17 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0876WJGv022007;
        Mon, 7 Sep 2020 02:40:16 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33de6ntddq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 02:40:16 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0876c5YS015446;
        Mon, 7 Sep 2020 06:40:15 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 33c2a8sg3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 06:40:15 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0876e9gR42402062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 06:40:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36CE67805E;
        Mon,  7 Sep 2020 06:40:14 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CC787805C;
        Mon,  7 Sep 2020 06:40:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.49.245])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 06:40:06 +0000 (GMT)
Subject: Re: [PATCH v8 3/5] perf jevents: Add support for parsing
 perchip/percore events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
References: <20200906112004.49574-1-kjain@linux.ibm.com>
 <20200906112004.49574-4-kjain@linux.ibm.com> <20200906125552.GC1199773@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <c414cdac-9051-5e0f-b638-3c3cca5394a6@linux.ibm.com>
Date:   Mon, 7 Sep 2020 12:10:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200906125552.GC1199773@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_01:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=2
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/20 6:25 PM, Jiri Olsa wrote:
> On Sun, Sep 06, 2020 at 04:50:02PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>>  typedef int (*func)(void *data, struct json_event *je);
>>  
>>  int eprintf(int level, int var, const char *fmt, ...)
>> @@ -355,6 +368,8 @@ static int print_events_table_entry(void *data, struct json_event *je)
>>  		fprintf(outfp, "\t.unit = \"%s\",\n", je->unit);
>>  	if (je->perpkg)
>>  		fprintf(outfp, "\t.perpkg = \"%s\",\n", je->perpkg);
>> +	if (je->aggr_mode)
>> +		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(je->aggr_mode));
>>  	if (je->metric_expr)
>>  		fprintf(outfp, "\t.metric_expr = \"%s\",\n", je->metric_expr);
>>  	if (je->metric_name)
>> @@ -379,6 +394,7 @@ struct event_struct {
>>  	char *pmu;
>>  	char *unit;
>>  	char *perpkg;
>> +	char *aggr_mode;
>>  	char *metric_expr;
>>  	char *metric_name;
>>  	char *metric_group;
>> @@ -408,6 +424,7 @@ struct event_struct {
>>  	op(pmu);						\
>>  	op(unit);						\
>>  	op(perpkg);						\
>> +	op(aggr_mode);						\
>>  	op(metric_expr);					\
>>  	op(metric_name);					\
>>  	op(metric_group);					\
>> @@ -613,6 +630,8 @@ static int json_events(const char *fn,
>>  				addfield(map, &je.unit, "", "", val);
>>  			} else if (json_streq(map, field, "PerPkg")) {
>>  				addfield(map, &je.perpkg, "", "", val);
>> +			} else if (json_streq(map, field, "AggregationMode")) {
>> +				addfield(map, &je.aggr_mode, "", "", val);
> 
> I think you should free je.aggr_mode

My bad, missed that part. Will send updated one.

Thanks,
Kajol Jain
> 
> jirka
> 
>>  			} else if (json_streq(map, field, "Deprecated")) {
>>  				addfield(map, &je.deprecated, "", "", val);
>>  			} else if (json_streq(map, field, "MetricName")) {
>> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
>> index c8f306b572f4..7da1a3743b77 100644
>> --- a/tools/perf/pmu-events/pmu-events.h
>> +++ b/tools/perf/pmu-events/pmu-events.h
>> @@ -2,6 +2,11 @@
>>  #ifndef PMU_EVENTS_H
>>  #define PMU_EVENTS_H
>>  
>> +enum aggr_mode_class {
>> +	PerChip = 1,
>> +	PerCore
>> +};
>> +
>>  /*
>>   * Describe each PMU event. Each CPU has a table of PMU events.
>>   */
>> @@ -14,6 +19,7 @@ struct pmu_event {
>>  	const char *pmu;
>>  	const char *unit;
>>  	const char *perpkg;
>> +	const char *aggr_mode;
>>  	const char *metric_expr;
>>  	const char *metric_name;
>>  	const char *metric_group;
>> -- 
>> 2.26.2
>>
> 
