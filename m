Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C235EC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C5E20857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgDWPLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:11:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2089 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728928AbgDWPLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:11:46 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id D021C53A5824996A9CC9;
        Thu, 23 Apr 2020 16:11:44 +0100 (IST)
Received: from [127.0.0.1] (10.47.5.255) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Apr
 2020 16:11:43 +0100
Subject: Re: [PATCH v2 11/11] perf test: add expr test for pmu metrics
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-12-irogers@google.com>
 <20200423112847.GF1136647@krava>
 <CAP-5=fVwfu0s8Sqhs7+aTqN1Gh2SaEu=feOEQssSu9MB+7hk8Q@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0edf66da-bedf-c5e9-aa2b-e9073a2d0203@huawei.com>
Date:   Thu, 23 Apr 2020 16:11:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVwfu0s8Sqhs7+aTqN1Gh2SaEu=feOEQssSu9MB+7hk8Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.5.255]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2020 15:22, Ian Rogers wrote:
> On Thu, Apr 23, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>>
>> On Wed, Apr 22, 2020 at 03:04:30PM -0700, Ian Rogers wrote:
>>
>> SNIP
>>
>>> +
>>> +static int pmu_tests(void)
>>> +{
>>> +     struct pmu_events_map *map;
>>> +     struct pmu_event *pe;
>>> +     int i, j, k;
>>> +     const char **ids;
>>> +     int idnum;
>>> +     int ret = 0;
>>> +     struct expr_parse_ctx ctx;
>>> +     double result;
>>> +
>>> +     i = 0;
>>> +     for (;;) {
>>> +             map = &pmu_events_map[i++];
>>> +             if (!map->table) {
>>> +                     map = NULL;
>>> +                     break;
>>> +             }
>>> +             j = 0;
>>> +             for (;;) {
>>> +                     pe = &map->table[j++];
>>> +                     if (!pe->name && !pe->metric_group && !pe->metric_name)
>>> +                             break;
>>> +                     if (!pe->metric_expr)
>>> +                             continue;
>>
>> so we go throught all the metrics for the current cpu
>> and test the parsing on them.. great!
> 
> It's not just the current CPU (such as skylake) it is every map
> (skylake, cascade lake, etc), but this only works for the architecture
> that jevents built.
> If jevents built all architectures then this could check them as well.
> Perhaps there should be a jevents test suite, but I think even then
> this test has value.

note: there is test__pmu_events(), which verifies that some test events 
generated in pmu-events.c are as expected, and also verifies that we 
create PMU events aliases as expected (for those test events). Nothing 
is done for metrics, ATM.

Thanks,
John
