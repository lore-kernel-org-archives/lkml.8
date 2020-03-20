Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D10C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4351220774
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgCTGpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:45:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726603AbgCTGpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:45:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02K6Y6ri108467;
        Fri, 20 Mar 2020 02:44:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7ftvnu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 02:44:43 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02K6YAX4108968;
        Fri, 20 Mar 2020 02:44:42 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7ftvnty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 02:44:42 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02K6ZB9j014696;
        Fri, 20 Mar 2020 06:44:42 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2yrpw7hysa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 06:44:42 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02K6if9K40829294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 06:44:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23390B2064;
        Fri, 20 Mar 2020 06:44:41 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 826D0B205F;
        Fri, 20 Mar 2020 06:44:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.36.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 20 Mar 2020 06:44:37 +0000 (GMT)
Subject: Re: [PATCH v6] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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
 <20200318192856.GQ11531@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <caf17575-423a-b3f3-8fd5-e2e9925bb3bd@linux.ibm.com>
Date:   Fri, 20 Mar 2020 12:14:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200318192856.GQ11531@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_01:2020-03-19,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/20 12:58 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 21, 2020 at 03:41:21PM +0530, Kajol Jain escreveu:
>> Commit f01642e4912b ("perf metricgroup: Support multiple
>> events for metricgroup") introduced support for multiple events
>> in a metric group. But with the current upstream, metric events
>> names are not printed properly incase we try to run multiple
>> metric groups with overlapping event.
>>
>> With current upstream version, incase of overlapping metric events
>> issue is, we always start our comparision logic from start.
>> So, the events which already matched with some metric group also
>> take part in comparision logic. Because of that when we have overlapping
>> events, we end up matching current metric group event with already matched
>> one.
>>
>> For example, in skylake machine we have metric event CoreIPC and
>> Instructions. Both of them need 'inst_retired.any' event value.
>> As events in Instructions is subset of events in CoreIPC, they
>> endup in pointing to same 'inst_retired.any' value.
>>
>> In skylake platform:
>>
>> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>      1,254,992,790      inst_retired.any          # 1254992790.0
>>                                                     Instructions
>>                                                   #      1.3 CoreIPC
>>        977,172,805      cycles
>>      1,254,992,756      inst_retired.any
>>
>>        1.000802596 seconds time elapsed
>>
>> command:# sudo ./perf stat -M UPI,IPC sleep 1
>>
>>    Performance counter stats for 'sleep 1':
>>            948,650      uops_retired.retire_slots
>>            866,182      inst_retired.any          #      0.7 IPC
>>            866,182      inst_retired.any
>>          1,175,671      cpu_clk_unhalted.thread
>>
>> Patch fixes the issue by adding a new bool pointer 'evlist_used' to keep
>> track of events which already matched with some group by setting it true.
>> So, we skip all used events in list when we start comparision logic.
>> Patch also make some changes in comparision logic, incase we get a match
>> miss, we discard the whole match and start again with first event id in
>> metric event.
>>
>> With this patch:
>> In skylake platform:
>>
>> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>          3,348,415      inst_retired.any          #      0.3 CoreIPC
>>         11,779,026      cycles
>>          3,348,381      inst_retired.any          # 3348381.0
>>                                                     Instructions
>>
>>        1.001649056 seconds time elapsed
>>
>> command:# ./perf stat -M UPI,IPC sleep 1
>>
>>  Performance counter stats for 'sleep 1':
>>
>>          1,023,148      uops_retired.retire_slots #      1.1 UPI
>>            924,976      inst_retired.any
>>            924,976      inst_retired.any          #      0.6 IPC
>>          1,489,414      cpu_clk_unhalted.thread
>>
>>        1.003064672 seconds time elapsed
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> This is an area I think needs some improvement, look how it ends up
> setting up the inst_retired.any multiple times:
> 
> [root@seventh ~]# perf stat -vv -M CoreIPC,Instructions  -C 0 sleep 1
> Using CPUID GenuineIntel-6-9E-9
> metric expr inst_retired.any / cycles for CoreIPC
> found event inst_retired.any
> found event cycles
> metric expr inst_retired.any for Instructions
> found event inst_retired.any
> adding {inst_retired.any,cycles}:W,{inst_retired.any}:W
> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> inst_retired.any -> cpu/event=0xc0,(null)=0x1e8483/
> inst_retired.any -> cpu/event=0xc0,(null)=0x1e8483/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4
>   size                             120
>   config                           0xc0
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
> ------------------------------------------------------------
> perf_event_attr:
>   size                             120
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd 3  flags 0x8 = 4
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4
>   size                             120
>   config                           0xc0
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> inst_retired.any: 0: 507070 1000948076 1000948076
> cycles: 0: 1250258 1000948076 1000948076
> inst_retired.any: 0: 507038 1000953052 1000953052
> inst_retired.any: 507070 1000948076 1000948076
> cycles: 1250258 1000948076 1000948076
> inst_retired.any: 507038 1000953052 1000953052
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>            507,070      inst_retired.any          #      0.4 CoreIPC
>          1,250,258      cycles
>            507,038      inst_retired.any          # 507038.0 Instructions
> 
>        1.000964961 seconds time elapsed
> 
> [root@seventh ~]#
> 
> And it ends up printing the "inst_retired.any" multiple times, with
> different values, as after all two events were allocated, can't we
> notice this and set just one inst_retired.any and then when calculating
> the metrics just do something like:
> 
>   # perf stat -M CoreIPC,Instructions -C 0 sleep 1
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>            507,070      inst_retired.any          #      0.4 CoreIPC,
> 						  #  507,070 Instructions
>          1,250,258      cycles
> 
>        1.000964961 seconds time elapsed
> #
> 
> ?
> 
> Ditto for:
> 
>     command:# perf stat -M UPI,IPC sleep 1
> 
>      Performance counter stats for 'sleep 1':
> 
>              1,023,148      uops_retired.retire_slots #      1.1 UPI
>                924,976      inst_retired.any
>                924,976      inst_retired.any          #      0.6 IPC
>              1,489,414      cpu_clk_unhalted.thread
> 
>            1.003064672 seconds time elapsed
> 
> Wouldn't this be better as:
> 
>     command:# perf stat -M UPI,IPC sleep 1
> 
>      Performance counter stats for 'sleep 1':
> 
>              1,023,148      uops_retired.retire_slots #      1.1 UPI
>                924,976      inst_retired.any
>              1,489,414      cpu_clk_unhalted.thread   #      0.6 IPC
> 
>            1.003064672 seconds time elapsed
> 
> This should help to look at many metrics at the same time by requiring
> less counters to be allocated, etc, or am I missing something here?

Hi Arnaldo,
	Yes that will be better. I will look into it from my end.

Thanks,
Kajol

> 
> Since this went thru multiple versions and Jiri is satisfied with it,
> I'm applying the patch, but please consider this suggestion.
> 
> - Arnaldo
> 
