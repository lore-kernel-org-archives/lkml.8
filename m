Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EBDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06D520737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGQILl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:11:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726113AbgGQILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:11:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06H84Ni4186145;
        Fri, 17 Jul 2020 04:11:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32autb2ph8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 04:11:33 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06H84cf4187071;
        Fri, 17 Jul 2020 04:11:32 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32autb2pgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 04:11:32 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06H8Ab8N008393;
        Fri, 17 Jul 2020 08:11:31 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 328ux7w3r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 08:11:31 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06H8BTXV39911930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 08:11:29 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD897BE051;
        Fri, 17 Jul 2020 08:11:29 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3E30BE054;
        Fri, 17 Jul 2020 08:11:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.115.95])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 08:11:23 +0000 (GMT)
Subject: Re: [PATCH v3 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
References: <20200716094216.1418659-1-kjain@linux.ibm.com>
 <20200716152237.GC373728@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <a80eebc2-885c-171d-7c7a-74df727d60b4@linux.ibm.com>
Date:   Fri, 17 Jul 2020 13:41:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716152237.GC373728@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_04:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 spamscore=100
 priorityscore=1501 suspectscore=0 mlxscore=100 phishscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=-1000 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007170061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/20 8:52 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 16, 2020 at 03:12:11PM +0530, Kajol Jain escreveu:
>> Patchset enhance current runtime parameter support. It introduces new
>> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
>> used to specify perpkg events. 
>>
>> The "PerCore" and "PerChip" specifies whether its core or chip events.
>> Based on which we can decide which runtime parameter user want to
>> access. Now character  '?' can refers different parameter based on user
>> requirement.
>>
>> Initially, every time we want to add new terms like chip, core, thread
>> etc, we need to create corrsponding fields in pmu_events and event
>> struct.
>> This patchset adds an enum called 'aggr_mode_class' which store all these
>> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
>> to capture these terms.
>> Now, if user wants to add any new term, they just need to add it in
>> the enum defined. I try to test it with  my current setup.
>>
>> I also need to replace PerPkg field to AggregationMode in all the
>> x86 uncore json files. It will great if Andi and team can test it
>> and let me know if they have any concerns.
>>
>> Changelog:
>> v2 -> v3:
>> - Did some nits changes suggested by Jiri include correction of
>>   indentation, and making PerCore/PerChip values forward after
>>   PerPkg as 1 in the enum.
>> - Rebase the patchset on Arnaldo's tmp.perf/core branch.
>> - Change RFC tag
> 
> Hey, have anybody provided Acked-by/Reviewed-by for previous revisions
> of this patchset? If so you could have collected them for patches
> without changes, was that the case?

Hi Arnaldo,
      I did get "Acked-by: Ian Rogers" on my initial prototype which I send in my RFC.
Link to the patch: https://lkml.org/lkml/2020/7/5/399

After that, I break it down and made some nits changes as suggested by Jiri, that's why I didn't
add his Acked-by tag.
Ian should I add it, if it seems fine to you.

Thanks,
Kajol Jain
> 
> - Arnaldo
>  
>> v1 -> v2:
>> - Rather then adding new field as PerCore/PerChip, created a new enum
>>   to get these fields. And new field as "AggregationMode" which can
>>   be used to capture these fields from json file.
>>   - Suggested By Ian Rogers
>>
>>
>> Kajol Jain (5):
>>   perf/pmu-events/jevents: Add enum to store aggregation like PerPkg
>>   pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86
>>     json files
>>   perf jevents: Add support for parsing perchip/percore events
>>   perf/tools: Pass pmu_event structure as a parameter for
>>     arch_get_runtimeparam
>>   perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events
>>
>>  tools/perf/arch/powerpc/util/header.c         |   7 +-
>>  .../arch/powerpc/power9/nest_metrics.json     |  27 +-
>>  .../arch/x86/broadwellde/uncore-cache.json    |  62 ++--
>>  .../arch/x86/broadwellde/uncore-memory.json   |  18 +-
>>  .../arch/x86/broadwellde/uncore-power.json    |  18 +-
>>  .../arch/x86/broadwellx/uncore-cache.json     |  62 ++--
>>  .../x86/broadwellx/uncore-interconnect.json   |   6 +-
>>  .../arch/x86/broadwellx/uncore-memory.json    |  18 +-
>>  .../arch/x86/broadwellx/uncore-power.json     |  18 +-
>>  .../arch/x86/cascadelakex/uncore-memory.json  |  64 ++--
>>  .../arch/x86/cascadelakex/uncore-other.json   | 332 +++++++++---------
>>  .../arch/x86/haswellx/uncore-cache.json       |  62 ++--
>>  .../x86/haswellx/uncore-interconnect.json     |   6 +-
>>  .../arch/x86/haswellx/uncore-memory.json      |  18 +-
>>  .../arch/x86/haswellx/uncore-power.json       |  18 +-
>>  .../arch/x86/ivytown/uncore-cache.json        |  62 ++--
>>  .../arch/x86/ivytown/uncore-interconnect.json |  10 +-
>>  .../arch/x86/ivytown/uncore-memory.json       |  16 +-
>>  .../arch/x86/ivytown/uncore-power.json        |  52 +--
>>  .../arch/x86/jaketown/uncore-cache.json       |  40 +--
>>  .../x86/jaketown/uncore-interconnect.json     |  10 +-
>>  .../arch/x86/jaketown/uncore-memory.json      |  18 +-
>>  .../arch/x86/jaketown/uncore-power.json       |  52 +--
>>  .../x86/knightslanding/uncore-memory.json     |   8 +-
>>  .../arch/x86/skylakex/uncore-memory.json      |  36 +-
>>  .../arch/x86/skylakex/uncore-other.json       | 220 ++++++------
>>  .../arch/x86/tremontx/uncore-memory.json      |  14 +-
>>  .../arch/x86/tremontx/uncore-other.json       |  70 ++--
>>  .../arch/x86/tremontx/uncore-power.json       |   2 +-
>>  tools/perf/pmu-events/jevents.c               |  45 ++-
>>  tools/perf/pmu-events/jevents.h               |   2 +-
>>  tools/perf/pmu-events/pmu-events.h            |   8 +-
>>  tools/perf/tests/pmu-events.c                 |   8 +-
>>  tools/perf/util/metricgroup.c                 |   5 +-
>>  tools/perf/util/metricgroup.h                 |   3 +-
>>  tools/perf/util/pmu.c                         |   6 +-
>>  36 files changed, 729 insertions(+), 694 deletions(-)
>>
>> -- 
>> 2.26.2
>>
> 
