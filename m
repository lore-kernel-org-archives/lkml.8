Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56904C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322E420714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGZJOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:14:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgGZJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:14:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q91WdE014653;
        Sun, 26 Jul 2020 05:14:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ggww5vee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:14:13 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q9ECI0039524;
        Sun, 26 Jul 2020 05:14:12 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ggww5veb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:14:12 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q94NvJ010937;
        Sun, 26 Jul 2020 09:14:12 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 32gcy6b0ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:14:12 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9EBLO52167166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:14:11 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FFCC28064;
        Sun, 26 Jul 2020 09:14:11 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 239332805A;
        Sun, 26 Jul 2020 09:14:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:14:06 +0000 (GMT)
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
 <eec934d1-5f45-739e-d5df-847a4b995fa5@linux.ibm.com>
 <20200725115143.GA1157288@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <906aa237-e300-aaf5-2de3-0041985ae646@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:44:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200725115143.GA1157288@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/20 5:21 PM, Jiri Olsa wrote:
> On Fri, Jul 24, 2020 at 11:22:28AM +0530, kajoljain wrote:
> 
> SNIP
> 
>>
>> Hi Jiri,
>>        The change looks good to me. I tried with adding this patch on top of your perf/metric branch. It did resolve the issue of not printing
>> all chips data. And now I can see proper values for hv-24x7 metric events.
>>
>> I was also trying by adding new metric using the feature added in this patchset with something like this:
>>
>> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
>> index 8383a37647ad..dfe4bd63b587 100644
>> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
>> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
>> @@ -16,6 +16,11 @@
>>          "MetricName": "PowerBUS_Frequency",
>>          "ScaleUnit": "2.5e-7GHz"
>>      },
>> +    {
>> +       "MetricExpr": "Memory_WR_BW_Chip + Memory_RD_BW_Chip",
>> +        "MetricName": "Total_Memory_BW",
>> +        "ScaleUnit": "1.6e-2MB"
>> +    },
> 
> hum, we'll need special case this.. because Memory_WR_BW_Chip will
> unwind to Memory_WR_BW_Chip_[01] and Total_Memory_BW is not aware of
> that.. what's the expected behaviour in here?
> 
> have Total_Memory_BW_[01] for each runtime arg?

Hi Jiri,
    Yes right. So we want Total_Memory_BW to show sum results of both chip 0 and 1 seperately, which is missing here.
> 
> I think this will need to come on top of this changes,
> it's already too big
> 

Yes make sense. We can send separate patches on top of this patch set for this use case. 

Other then that the whole patchset looks good to me with the change to rectify Paul A. Clarke concern.

Tested/Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> thanks,
> jirka
> 
>>
>> I guess as we have dependency on '?' symbol, I am not able to see all chips data for Total_Memory_BW.
>> I am not sure if Its expected behavior?
>>
>> This is what I am getting:
>>
>> [root@ltc-zz189-lp4 perf]# ./perf stat --metric-only -M Total_Memory_BW,Memory_WR_BW_Chip,Memory_RD_BW_Chip -I 1000 -C 0
>> #           time  MB  Total_Memory_BW MB  Memory_RD_BW_Chip_1 MB  Memory_WR_BW_Chip_1 MB  Memory_WR_BW_Chip_0 MB  Memory_RD_BW_Chip_0 
>>      1.000067388                 36.4                      0.2                     36.3                     65.0                     72.1 
>>      2.000374276                 36.2                      0.3                     35.9                     65.4                     77.9 
>>      3.000543202                 36.3                      0.3                     36.0                     68.7                     81.2 
>>      4.000702855                 36.3                      0.3                     36.0                     70.9                     93.3 
>>      5.000856837                 36.0                      0.2                     35.8                     67.4                     81.5 
>> ^C     5.367865273                 13.2                      0.1                     13.1                     23.5                     28.3 
>>  Performance counter stats for 'CPU(s) 0':
>>                194.4                      1.3                    193.1                    361.0                    434.3 
>>        5.368039176 seconds time elapsed
>>
>> We can only get single chip data's sum in Total_Memory_BW. Please let me know if I am missing something.
> 
> SNIP
> 
