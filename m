Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292BFC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0440621D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGNJMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:12:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgGNJMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:12:32 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06E96wQN162784;
        Tue, 14 Jul 2020 05:12:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792ux94x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 05:12:25 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06E94KWa155061;
        Tue, 14 Jul 2020 05:12:24 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792ux93e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 05:12:24 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06E9BF1e008373;
        Tue, 14 Jul 2020 09:12:22 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 327528f486-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 09:12:22 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06E9CLiY54002164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 09:12:21 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB97A28058;
        Tue, 14 Jul 2020 09:12:21 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C94522805A;
        Tue, 14 Jul 2020 09:12:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.38.35])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jul 2020 09:12:16 +0000 (GMT)
Subject: Re: [RFC v2 3/5] perf jevents: Add support for parsing
 perchip/percore events
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
 <20200707122314.624400-4-kjain@linux.ibm.com> <20200712185523.GA147742@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <92f5fb5e-8abb-64a4-a217-0dc068a2a47b@linux.ibm.com>
Date:   Tue, 14 Jul 2020 14:42:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200712185523.GA147742@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_01:2020-07-13,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/20 12:25 AM, Jiri Olsa wrote:
> On Tue, Jul 07, 2020 at 05:53:12PM +0530, Kajol Jain wrote:
>> Added the "PerChip" field  in enum so that perf knows they are
>> per chip events.
>>
>> Added the "PerCore" field in enum so that perf knows they are
>> per core events and add these fields to pmu_event structure.
>>
>> Similar to the way we had "PerPkg field
>> to specify perpkg events.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  tools/perf/pmu-events/jevents.c    | 8 +++++++-
>>  tools/perf/pmu-events/pmu-events.h | 4 +++-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index b2f59f0af63d..1f65047db000 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -54,13 +54,19 @@ int verbose;
>>  char *prog;
>>  
>>  enum aggr_mode_class {
>> -	PerPkg = 1
>> +	PerChip = 0,
> 
> is there a reason for the values? just wonder if it's wise to have PerChip == 0,
> and why you would not continue with forward when PerPkg is 1

Hi Jiri,
     Yes, there is no reason for having particular values, It just added to get which parameter
we are referring. I can sure continue it after Perpkg.

Thanks,
Kajol Jain

> 
> jirka
> 
>> +	PerPkg = 1,
>> +	PerCore = 2
>>  };
>>  
> 
> SNIP
> 
