Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD3D206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgGGLdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:33:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgGGLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:33:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067BWdYn173958;
        Tue, 7 Jul 2020 07:32:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32486cs6gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 07:32:53 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067BWkjb174617;
        Tue, 7 Jul 2020 07:32:46 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32486cs65g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 07:32:46 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067BUggu030281;
        Tue, 7 Jul 2020 11:32:01 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 322hd8yc0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 11:32:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067BW0ZQ35717398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 11:32:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA5D6B206A;
        Tue,  7 Jul 2020 11:32:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4F90B2066;
        Tue,  7 Jul 2020 11:31:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.118.59])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 11:31:55 +0000 (GMT)
Subject: Re: [RFC 1/3] perf jevents: Add support for parsing perchip/percore
 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20200625114718.229911-1-kjain@linux.ibm.com>
 <20200625114718.229911-2-kjain@linux.ibm.com>
 <CAP-5=fWG9rxObKJ38dQ=VUf3_mQbNDCTzgU1kkyw=9uVfBa+qw@mail.gmail.com>
 <512670c2-bb61-7c2f-68bc-7752499300c6@linux.ibm.com>
 <20200706125757.GA3424581@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <d9252cb6-7cb3-9783-a0f2-d879dcc894a7@linux.ibm.com>
Date:   Tue, 7 Jul 2020 17:01:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706125757.GA3424581@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_07:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/20 6:27 PM, Jiri Olsa wrote:
> On Fri, Jul 03, 2020 at 11:50:28AM +0530, kajoljain wrote:
> 
> SNIP
> 
>>  ]
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index fa86c5f997cc..dd2b14cc147c 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -53,6 +53,23 @@
>>  int verbose;
>>  char *prog;
>>  
>> +enum event_class {
>> +	PerChip = 0,
>> +	PerPkg = 1,
>> +	PerCore = 2
>> +};
> 
> could you please split this into patch that changes perpkg
> into the class type string and another that adds new PerChip/PerCore?
> 

Hi Jiri,
   Thanks for reviewing the prototype changes. Sure I will split it and
and send next version out.

>> +
>> +enum event_class convert(const char* event_class_type) {
>> +
>> +	if (!strcmp(event_class_type, "PerCore"))
>> +		return PerCore;
>> +	else if (!strcmp(event_class_type, "PerChip"))
>> +		return PerChip;
>> +	else if (!strcmp(event_class_type, "PerPkg"))
>> +		return PerPkg;
>> +	return -1;
>> +}
>> +
>>  int eprintf(int level, int var, const char *fmt, ...)
>>  {
>>  
>> @@ -320,7 +337,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>>  
>>  static int print_events_table_entry(void *data, char *name, char *event,
>>  				    char *desc, char *long_desc,
>> -				    char *pmu, char *unit, char *perpkg,
>> +				    char *pmu, char *unit, char *event_class_type,
> 
> maybe 'aggregation' or 'aggr_mode' would be better name than event_class_type?
>

Sure, will update.

Thanks,
Kajol Jain
 
> thanks,
> jirka
> 
