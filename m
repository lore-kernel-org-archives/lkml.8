Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617D720719
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGZJT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:19:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgGZJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:19:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q8Xeo3065018;
        Sun, 26 Jul 2020 05:19:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32gh8knj11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:19:25 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q906Ll160553;
        Sun, 26 Jul 2020 05:19:24 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32gh8knj0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:19:24 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9FaIX015001;
        Sun, 26 Jul 2020 09:19:23 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 32gcpqrwpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:19:23 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9JM8B52822402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:19:22 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3C212805E;
        Sun, 26 Jul 2020 09:19:22 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2092F28058;
        Sun, 26 Jul 2020 09:19:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:19:17 +0000 (GMT)
Subject: Re: [PATCH 12/19] perf metric: Add events for the current list
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-13-jolsa@kernel.org>
 <CAP-5=fXsspq4xBehRZOBrFAEHAnE1tPnH9FybooiCcTxynh6wg@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <95f982ef-87ac-40f1-dc7e-79929017beeb@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:49:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXsspq4xBehRZOBrFAEHAnE1tPnH9FybooiCcTxynh6wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/20 4:04 AM, Ian Rogers wrote:
> On Sun, Jul 19, 2020 at 11:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> There's no need to iterate the whole list of groups,
>> when adding new events. The currently created groups
>> are the ones we want to add.
>>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> Thanks,
> Ian
> 
>> ---
>>  tools/perf/util/metricgroup.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index bb5757b9419d..332414d93f7a 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -813,6 +813,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>>  {
>>         struct pmu_event *pe;
>>         struct egroup *eg;
>> +       LIST_HEAD(list);
>>         int i, ret;
>>         bool has_match = false;
>>
>> @@ -820,7 +821,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>>                 has_match = true;
>>                 eg = NULL;
>>
>> -               ret = add_metric(group_list, pe, metric_no_group, &eg);
>> +               ret = add_metric(&list, pe, metric_no_group, &eg);
>>                 if (ret)
>>                         return ret;
>>
>> @@ -829,7 +830,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>>                  * included in the expression.
>>                  */
>>                 ret = resolve_metric(eg, metric_no_group,
>> -                                    group_list, map);
>> +                                    &list, map);
>>                 if (ret)
>>                         return ret;
>>         }
>> @@ -838,7 +839,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>>         if (!has_match)
>>                 return -EINVAL;
>>
>> -       list_for_each_entry(eg, group_list, nd) {
>> +       list_for_each_entry(eg, &list, nd) {
>>                 if (events->len > 0)
>>                         strbuf_addf(events, ",");
>>
>> @@ -850,6 +851,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>>                                                            &eg->pctx);
>>                 }
>>         }
>> +
>> +       list_splice(&list, group_list);
>>         return 0;
>>  }
>>
>> --
>> 2.25.4
>>
