Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDCC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E751820873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgBNFRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:17:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbgBNFRE (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:17:04 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E59BE6106432
        for <Linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:17:03 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y57at2jns-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <Linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:17:03 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <Linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 14 Feb 2020 05:17:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Feb 2020 05:16:57 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01E5GuAI65208380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 05:16:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1017A405C;
        Fri, 14 Feb 2020 05:16:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B13A4064;
        Fri, 14 Feb 2020 05:16:54 +0000 (GMT)
Received: from [9.124.31.100] (unknown [9.124.31.100])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Feb 2020 05:16:53 +0000 (GMT)
Subject: Re: [PATCH v3] perf stat: Show percore counts in per CPU output
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200213071555.17239-1-yao.jin@linux.intel.com>
 <54bea6fe-26a1-a08c-7a61-ac5f5d43ad8c@linux.ibm.com>
 <b2139560-f123-61bb-3ea2-0033b3f892a3@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 14 Feb 2020 10:46:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b2139560-f123-61bb-3ea2-0033b3f892a3@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021405-0020-0000-0000-000003A9FB09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021405-0021-0000-0000-00002201E848
Message-Id: <8a80b138-77c1-682a-340e-f32d6779d446@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_10:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/20 8:40 PM, Jin, Yao wrote:
> 
> 
> On 2/13/2020 9:20 PM, Ravi Bangoria wrote:
>> Hi Jin,
>>
>> On 2/13/20 12:45 PM, Jin Yao wrote:
>>> With this patch, for example,
>>>
>>>   # perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -- sleep 1
>>>
>>>    Performance counter stats for 'system wide':
>>>
>>>   CPU0               2,453,061      cpu/event=cpu-cycles,percore/
>>>   CPU1               1,823,921      cpu/event=cpu-cycles,percore/
>>>   CPU2               1,383,166      cpu/event=cpu-cycles,percore/
>>>   CPU3               1,102,652      cpu/event=cpu-cycles,percore/
>>>   CPU4               2,453,061      cpu/event=cpu-cycles,percore/
>>>   CPU5               1,823,921      cpu/event=cpu-cycles,percore/
>>>   CPU6               1,383,166      cpu/event=cpu-cycles,percore/
>>>   CPU7               1,102,652      cpu/event=cpu-cycles,percore/
>>>
>>> We can see counts are duplicated in CPU pairs
>>> (CPU0/CPU4, CPU1/CPU5, CPU2/CPU6, CPU3/CPU7).
>>>
>>
>> I was trying this patch and I am getting bit weird results when any cpu
>> is offline. Ex,
>>
>>    $ lscpu | grep list
>>    On-line CPU(s) list:             0-4,6,7
>>    Off-line CPU(s) list:            5
>>
>>    $ sudo ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread -vv -- sleep 1
>>      ...
>>    cpu/event=cpu-cycles,percore/: 0: 23746491 1001189836 1001189836
>>    cpu/event=cpu-cycles,percore/: 1: 19802666 1001291299 1001291299
>>    cpu/event=cpu-cycles,percore/: 2: 24211983 1001394318 1001394318
>>    cpu/event=cpu-cycles,percore/: 3: 54051396 1001516816 1001516816
>>    cpu/event=cpu-cycles,percore/: 4: 6378825 1001064048 1001064048
>>    cpu/event=cpu-cycles,percore/: 5: 21299840 1001166297 1001166297
>>    cpu/event=cpu-cycles,percore/: 6: 13075410 1001274535 1001274535
>>     Performance counter stats for 'system wide':
>>    CPU0              30,125,316      cpu/event=cpu-cycles,percore/
>>    CPU1              19,802,666      cpu/event=cpu-cycles,percore/
>>    CPU2              45,511,823      cpu/event=cpu-cycles,percore/
>>    CPU3              67,126,806      cpu/event=cpu-cycles,percore/
>>    CPU4              30,125,316      cpu/event=cpu-cycles,percore/
>>    CPU7              67,126,806      cpu/event=cpu-cycles,percore/
>>    CPU0              30,125,316      cpu/event=cpu-cycles,percore/
>>           1.001918764 seconds time elapsed
>>
>> I see proper result without --percore-show-thread:
>>
>>    $ sudo ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A -vv -- sleep 1
>>      ...
>>    cpu/event=cpu-cycles,percore/: 0: 11676414 1001190709 1001190709
>>    cpu/event=cpu-cycles,percore/: 1: 39119617 1001291459 1001291459
>>    cpu/event=cpu-cycles,percore/: 2: 41821512 1001391158 1001391158
>>    cpu/event=cpu-cycles,percore/: 3: 46853730 1001492799 1001492799
>>    cpu/event=cpu-cycles,percore/: 4: 14448274 1001095948 1001095948
>>    cpu/event=cpu-cycles,percore/: 5: 42238217 1001191187 1001191187
>>    cpu/event=cpu-cycles,percore/: 6: 33129641 1001292072 1001292072
>>     Performance counter stats for 'system wide':
>>    S0-D0-C0             26,124,688      cpu/event=cpu-cycles,percore/
>>    S0-D0-C1             39,119,617      cpu/event=cpu-cycles,percore/
>>    S0-D0-C2             84,059,729      cpu/event=cpu-cycles,percore/
>>    S0-D0-C3             79,983,371      cpu/event=cpu-cycles,percore/
>>           1.001961563 seconds time elapsed
>>
>> [...]
>>
> 
> Thanks so much for reporting this issue!
> 
> It looks I should use the cpu idx in print_percore_thread. I can't use the cpu value. I have a fix:
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 7eb3643a97ae..d89cb0da90f8 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1149,13 +1149,11 @@ static void print_footer(struct perf_stat_config *config)
>   static void print_percore_thread(struct perf_stat_config *config,
>                                   struct evsel *counter, char *prefix)
>   {
> -       int cpu, s, s2, id;
> +       int s, s2, id;
>          bool first = true;
> 
>          for (int i = 0; i < perf_evsel__nr_cpus(counter); i++) {
> -               cpu = perf_cpu_map__cpu(evsel__cpus(counter), i);
> -               s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
> -
> +               s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
>                  for (s = 0; s < config->aggr_map->nr; s++) {
>                          id = config->aggr_map->map[s];
>                          if (s2 == id)
> @@ -1164,7 +1162,7 @@ static void print_percore_thread(struct perf_stat_config *config,
> 
>                  print_counter_aggrdata(config, counter, s,
>                                         prefix, false,
> -                                      &first, cpu);
> +                                      &first, i);
>          }
>   }

LGTM.

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Ravi

