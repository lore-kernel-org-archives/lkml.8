Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53921C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C64B2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgGNJJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:09:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgGNJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:09:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06E94i4L059720;
        Tue, 14 Jul 2020 05:09:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32991e9cdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 05:09:28 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06E95IZN063342;
        Tue, 14 Jul 2020 05:09:27 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32991e9cdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 05:09:27 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06E969bQ010626;
        Tue, 14 Jul 2020 09:09:26 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 327528y4y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 09:09:26 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06E99PK748300430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 09:09:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B06DD28059;
        Tue, 14 Jul 2020 09:09:25 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52CC428058;
        Tue, 14 Jul 2020 09:09:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.38.35])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jul 2020 09:09:21 +0000 (GMT)
Subject: Re: [RFC v2 1/5] perf/pmu-events/jevents: Add enum to store
 aggregation like PerPkg
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
References: <20200707122314.624400-1-kjain@linux.ibm.com>
 <20200707122314.624400-2-kjain@linux.ibm.com> <20200712185534.GB147742@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <38d2fd54-41aa-61b0-c396-c58fc1da70da@linux.ibm.com>
Date:   Tue, 14 Jul 2020 14:39:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200712185534.GB147742@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_01:2020-07-13,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/20 12:25 AM, Jiri Olsa wrote:
> On Tue, Jul 07, 2020 at 05:53:10PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>>  			}
>>  
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 93fe72a9dc0b..3cafbb320d68 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -306,7 +306,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>>  static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>  				 char *desc, char *val,
>>  				 char *long_desc, char *topic,
>> -				 char *unit, char *perpkg,
>> +				 char *unit, char *aggr_mode,
>>  				 char *metric_expr,
>>  				 char *metric_name,
>>  				 char *deprecated)
>> @@ -378,7 +378,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>  			return -1;
>>  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>>  	}
>> -	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
>> +	alias->per_pkg = aggr_mode && sscanf(aggr_mode, "%d", &num) == 1 && num == 1;
> 
> should you rather use 'num == PerPkg' instead 'num == 1' ?

Hi Jiri,
     Thanks for reviewing the patchset. Sure I will update it.

Thanks,
Kajol Jain
> 
> jirka
> 
