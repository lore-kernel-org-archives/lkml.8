Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96218C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789E32075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgG1URP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:17:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgG1URP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:17:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SK2xEG177198;
        Tue, 28 Jul 2020 16:17:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32hs1dc2v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 16:17:09 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06SK4YbO182212;
        Tue, 28 Jul 2020 16:17:09 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32hs1dc2ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 16:17:09 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SKFLhO006492;
        Tue, 28 Jul 2020 20:17:08 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 32gcy3b82q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 20:17:08 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06SKH4c933161526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 20:17:05 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 316CDC6059;
        Tue, 28 Jul 2020 20:17:07 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16D25C6055;
        Tue, 28 Jul 2020 20:17:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.77.202.134])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jul 2020 20:17:02 +0000 (GMT)
Subject: Re: [PATCH 16/19] perf metric: Make compute_single function more
 precise
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
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
 <20200719181320.785305-17-jolsa@kernel.org>
 <20200728123629.GW40195@kernel.org>
 <CAP-5=fWAC4DkKiPzKvAiVpMDFWvf3HPZ5=tiSUbJ50w+kjXhfg@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <8fbc4b4f-1886-0ab6-ee83-cdb0f2caefc9@linux.ibm.com>
Date:   Wed, 29 Jul 2020 01:47:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWAC4DkKiPzKvAiVpMDFWvf3HPZ5=tiSUbJ50w+kjXhfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_16:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/20 10:56 PM, Ian Rogers wrote:
> On Tue, Jul 28, 2020 at 5:36 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Sun, Jul 19, 2020 at 08:13:17PM +0200, Jiri Olsa escreveu:
>>> So far compute_single function relies on the fact, that
>>> there's only single metric defined within evlist in all
>>> tests. In following patch we will add test for metric
>>> group, so we need to be able to compute metric by given
>>> name.
>>>
>>> Adding the name argument to compute_single and iterating
>>> evlist and evsel's expression to find the given metric.
>>
>> Applied, thanks.
>>
>> Ian, Kajol, I didn't notice your Acked-by or Reviewed-by, like for the
>> other patches, can you check?
> 
> 
> Acked-by: Ian Rogers <irogers@google.com>

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> Thanks,
> Ian
> 
>> - Arnaldo
>>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>  tools/perf/tests/parse-metric.c | 22 +++++++++++++---------
>>>  1 file changed, 13 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
>>> index 01370ccb9ed9..5ac32f80f8ea 100644
>>> --- a/tools/perf/tests/parse-metric.c
>>> +++ b/tools/perf/tests/parse-metric.c
>>> @@ -108,17 +108,21 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
>>>  }
>>>
>>>  static double compute_single(struct rblist *metric_events, struct evlist *evlist,
>>> -                          struct runtime_stat *st)
>>> +                          struct runtime_stat *st, const char *name)
>>>  {
>>> -     struct evsel *evsel = evlist__first(evlist);
>>> +     struct metric_expr *mexp;
>>>       struct metric_event *me;
>>> +     struct evsel *evsel;
>>>
>>> -     me = metricgroup__lookup(metric_events, evsel, false);
>>> -     if (me != NULL) {
>>> -             struct metric_expr *mexp;
>>> -
>>> -             mexp = list_first_entry(&me->head, struct metric_expr, nd);
>>> -             return test_generic_metric(mexp, 0, st);
>>> +     evlist__for_each_entry(evlist, evsel) {
>>> +             me = metricgroup__lookup(metric_events, evsel, false);
>>> +             if (me != NULL) {
>>> +                     list_for_each_entry (mexp, &me->head, nd) {
>>> +                             if (strcmp(mexp->metric_name, name))
>>> +                                     continue;
>>> +                             return test_generic_metric(mexp, 0, st);
>>> +                     }
>>> +             }
>>>       }
>>>       return 0.;
>>>  }
>>> @@ -162,7 +166,7 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
>>>       load_runtime_stat(&st, evlist, vals);
>>>
>>>       /* And execute the metric */
>>> -     *ratio = compute_single(&metric_events, evlist, &st);
>>> +     *ratio = compute_single(&metric_events, evlist, &st, name);
>>>
>>>       /* ... clenup. */
>>>       metricgroup__rblist_exit(&metric_events);
>>> --
>>> 2.25.4
>>>
>>
>> --
>>
>> - Arnaldo
