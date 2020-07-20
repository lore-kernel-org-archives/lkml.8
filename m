Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E70C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B0920709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGTIJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:09:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgGTIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:09:42 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K84XEP013647;
        Mon, 20 Jul 2020 04:09:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqub1g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 04:09:33 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06K85oXn019395;
        Mon, 20 Jul 2020 04:09:32 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqub1f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 04:09:32 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06K89MTr008984;
        Mon, 20 Jul 2020 08:09:31 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 32brq8qfm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 08:09:31 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06K89RB162652750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 08:09:27 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F76F6E04C;
        Mon, 20 Jul 2020 08:09:30 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA91F6E053;
        Mon, 20 Jul 2020 08:09:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.114.242])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 08:09:25 +0000 (GMT)
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
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
Date:   Mon, 20 Jul 2020 13:39:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720072237.GC760733@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_04:2020-07-17,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/20 12:52 PM, Jiri Olsa wrote:
> On Mon, Jul 20, 2020 at 12:14:00PM +0530, kajoljain wrote:
>>
>>
>> On 7/19/20 11:43 PM, Jiri Olsa wrote:
>>> hi,
>>> this patchset is adding the support to reused metric in
>>> another metric.
>>>
>>> For example, to define IPC by using CPI with change like:
>>>
>>>      {
>>>          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
>>> -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
>>> +        "MetricExpr": "1/CPI",
>>>          "MetricGroup": "TopDownL1",
>>>          "MetricName": "IPC"
>>>      },
>>>
>>> I won't be able to find all the possible places we could
>>> use this at, so I wonder you guys (who was asking for this)
>>> would try it and come up with comments if there's something
>>> missing or we could already use it at some places.
>>>
>>> It's based on Arnaldo's tmp.perf/core.
>>>
>>> v3 changes:
>>>   - added some acks
>>>   - some patches got merged
>>>   - added missing zalloc include [John Garry]
>>>   - added ids array outside the egroup object [Ian]
>>>   - removed wrong m->has_constraint assignment [Ian]
>>>   - renamed 'list' to 'metric_list' [Ian]
>>>   - fixed group metric and added test for it [Paul A. Clarke]
>>>   - fixed memory leak [Arnaldo]
>>>   - using lowercase keys for metrics in hashmap, because jevents
>>>     converts metric_expr to lowercase
>>>
>>> Also available in here:
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>>>   perf/metric
>>>
>>
>> Hi Jiri,
>>    I am trying to review these patches and also test it in power box. I am testing your `perf/metric` branch.
>> With your current patches,some of hv-24x7 events not giving appropriate result
>> while doing "--metric-only" command. I can't see corresponding output for all chips.
> 
> hi,
> is that just for --metric-only option?

Hi Jiri,
   So basically, this issue is for both with/without metric-only option. Without metric-only option,
I am not able to see aggregate result for other chips.

This is with upstream kernel:

command# ./perf stat -M PowerBUS_Frequency -C 0 -I 1000
#           time             counts unit events
     1.000076370          7,807,494      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
     1.000076370          7,807,456      hv_24x7/pm_pb_cyc,chip=1/ #      2.0 GHz  PowerBUS_Frequency_1
     2.000259226          7,807,490      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
     2.000259226          7,799,691      hv_24x7/pm_pb_cyc,chip=1/ #      1.9 GHz  PowerBUS_Frequency_1
^C     2.745238246          5,816,562      hv_24x7/pm_pb_cyc,chip=0/ #      1.5 GHz  PowerBUS_Frequency_0
     2.745238246          5,816,580      hv_24x7/pm_pb_cyc,chip=1/ #      1.5 GHz  PowerBUS_Frequency_1

 Performance counter stats for 'CPU(s) 0':

        21,431,546      hv_24x7/pm_pb_cyc,chip=0/ #      5.4 GHz  PowerBUS_Frequency_0
        21,423,727      hv_24x7/pm_pb_cyc,chip=1/ #      5.4 GHz  PowerBUS_Frequency_1

This is with your perf/metric branch:
command# ./perf stat -M PowerBUS_Frequency -C 0 -I 1000
assertion failed at util/metricgroup.c:709
#           time             counts unit events
     1.000054545          7,807,505      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
     1.000054545          7,807,485      hv_24x7/pm_pb_cyc,chip=1/                                   
     2.000232761          7,807,500      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
     2.000232761          7,807,478      hv_24x7/pm_pb_cyc,chip=1/                                   
     3.000363762          7,799,665      hv_24x7/pm_pb_cyc,chip=0/ #      1.9 GHz  PowerBUS_Frequency_0
     3.000363762          7,807,502      hv_24x7/pm_pb_cyc,chip=1/                                   
^C     3.259418599          2,022,150      hv_24x7/pm_pb_cyc,chip=0/ #      0.5 GHz  PowerBUS_Frequency_0
     3.259418599          2,022,164      hv_24x7/pm_pb_cyc,chip=1/                                   

 Performance counter stats for 'CPU(s) 0':

        25,436,820      hv_24x7/pm_pb_cyc,chip=0/ #      6.4 GHz  PowerBUS_Frequency_0
        25,444,629      hv_24x7/pm_pb_cyc,chip=1/                                   

       3.259505529 seconds time elapsed
Thanks,
Kajol Jain
> 
>>
>> This is output on power9 machine:
>>
>> Without your patches on upstream kernel:
>>
>> command# ./perf stat --metric-only -M PowerBUS_Frequency -I 1000 -C 0
>> #           time GHz  PowerBUS_Frequency_0 GHz  PowerBUS_Frequency_1 
>>      1.000073877                        2.0                        2.0 
>>      2.000240551                        2.0                        1.9 
>> ^C     2.452590532                        0.9                        0.9 
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>                        4.8                        4.8 
>>
>>        2.452654834 seconds time elapsed
>>
>> With your patches on perf/metric branch:
>>
>> command# ./perf stat --metric-only -M PowerBUS_Frequency -I 1000 -C 0
>> assertion failed at util/metricgroup.c:709
>> #           time GHz  PowerBUS_Frequency_0 
>>      1.000073875                        2.0 
>>      2.000380706                        2.0 
>> ^C     2.658962182                        1.3 
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>                        5.2 
>>
>> Please let me know, if I am missing something. 
> 
> hum, I'll need to add test for metric with hv-24x7 events
> 
> thanks,
> jirka
> 
