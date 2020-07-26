Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F3C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769F3206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgGZJb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:31:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgGZJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:31:27 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q936HV184067;
        Sun, 26 Jul 2020 05:31:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggcs6fgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:31:18 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q93Gdu184347;
        Sun, 26 Jul 2020 05:31:18 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggcs6fg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:31:18 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9JIb6015664;
        Sun, 26 Jul 2020 09:31:16 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 32gcq08xxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:31:16 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9VGT351904824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:31:16 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48AFF2805A;
        Sun, 26 Jul 2020 09:31:16 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DBF828058;
        Sun, 26 Jul 2020 09:31:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:31:10 +0000 (GMT)
Subject: Re: [PATCH v4 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, ak@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com,
        kan.liang@linux.intel.com, nasastry@in.ibm.com
References: <20200720070127.109234-1-kjain@linux.ibm.com>
 <20200720192133.GM760733@krava> <20200720193149.GA3906670@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <b2830443-8e86-8e70-705b-ac243f7a63f1@linux.ibm.com>
Date:   Sun, 26 Jul 2020 15:01:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720193149.GA3906670@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_03:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 1:01 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 20, 2020 at 09:21:33PM +0200, Jiri Olsa escreveu:
>> On Mon, Jul 20, 2020 at 12:31:22PM +0530, Kajol Jain wrote:
>>> Patchset enhance current runtime parameter support. It introduces new
>>> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
>>> used to specify perpkg events. 
>>>
>>> The "PerCore" and "PerChip" specifies whether its core or chip events.
>>> Based on which we can decide which runtime parameter user want to
>>> access. Now character  '?' can refers different parameter based on user
>>> requirement.
>>>
>>> Initially, every time we want to add new terms like chip, core, thread
>>> etc, we need to create corrsponding fields in pmu_events and event
>>> struct.
>>> This patchset adds an enum called 'aggr_mode_class' which store all these
>>> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
>>> to capture these terms.
>>> Now, if user wants to add any new term, they just need to add it in
>>> the enum defined. I try to test it with  my current setup.
>>>
>>> I also need to replace PerPkg field to AggregationMode in all the
>>> x86 uncore json files. It will great if Andi and team can test it
>>> and let me know if they have any concerns.
>>>
>>> Changelog:
>>> v3 -> v4:
>>> - Include pmu-events.h header file in jevents.c and remove
>>>   redecalaration of enum aggr_mode_class as Suggested by Jiri.
>>> - Add Acked-by tag.
>>
>> looks good to me, but still missing reaction from people maintaining
>> intel's jsons
> 
> Yeah, since this is something trying to be generic enough to describe
> events from different arches, we should not double-fail into
> generalizing this :-\

Hi,
   Yes that make sense. In this patchset we are not doing any logical change from intel side,
as in all the json file "PerPkg" value map to '1', we are using same value in the
enum to not break that use case. And just replacing 'PerPkg' to new added field
`AggregationMode'. 

But you are right, it will be good to have Ack from intel people. Any comments how we can push these
changes?

Thanks,
Kajol Jain
> 
> - Arnaldo
> 
