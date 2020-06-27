Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B75C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A672080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgF0IPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:15:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2365 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbgF0IPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:15:02 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 572573B0E92068A8C89E;
        Sat, 27 Jun 2020 09:15:01 +0100 (IST)
Received: from [127.0.0.1] (10.210.171.165) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 27 Jun
 2020 09:15:00 +0100
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
References: <20200626194720.2915044-1-jolsa@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b1fd3b2d-9312-bbb1-7803-426dbb737866@huawei.com>
Date:   Sat, 27 Jun 2020 09:13:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200626194720.2915044-1-jolsa@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.165]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 20:47, Jiri Olsa wrote:
> hi,
> this patchset is adding the support to reused metric in another
> metric. The metric needs to be referenced by 'metric:' prefix.
> 

I notice that there is much repetition in the x86 metric JSONs between CPUs.

So I know it's not the same as what you propose here, but jevents 
standard arch events feature could be used to reduce the repetition.

I'm guessing that those metric JSONs are human generated, so would be 
suitable; unlike the regular JSONs, which are automated.

Thanks,
John

> For example, to define IPC by using CPI with change like:
> 
>           "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
>   -       "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
>   +       "MetricExpr": "1/metric:CPI",
>           "MetricGroup": "TopDownL1",
>           "MetricName": "IPC"
> 
> I won't be able to find all the possible places we could
> use this at, so I wonder you guys (who was asking for this)
> would try it and come up with comments if there's something
> missing or we could already use it at some places.
> 
> It's based on Arnaldo's tmp.perf/core.
> 
> Also available in here:
>    git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>    perf/metric
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (10):
>        perf tools: Rename expr__add_id to expr__add_val
>        perf tools: Add struct expr_parse_data to keep expr value
>        perf tools: Add expr__add_id function
>        perf tools: Change expr__get_id to return struct expr_parse_data
>        perf tools: Add expr__del_id function
>        perf tools: Collect other metrics in struct egroup
>        perf tools: Collect other metrics in struct metric_expr
>        perf tools: Add other metrics to hash data
>        perf tools: Compute other metrics
>        perf tests: Add cache_miss_cycles to metric parse test
> 
>   tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json |   2 +-
>   tools/perf/tests/expr.c                                 |   7 ++--
>   tools/perf/tests/parse-metric.c                         |  33 +++++++++++++++++
>   tools/perf/tests/pmu-events.c                           |   4 +--
>   tools/perf/util/expr.c                                  | 115 +++++++++++++++++++++++++++++++++++++++++++++-------------
>   tools/perf/util/expr.h                                  |  24 +++++++++++--
>   tools/perf/util/expr.y                                  |  34 ++++++++++++++----
>   tools/perf/util/metricgroup.c                           | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>   tools/perf/util/metricgroup.h                           |   6 ++++
>   tools/perf/util/stat-shadow.c                           |  23 +++++++-----
>   10 files changed, 374 insertions(+), 61 deletions(-)
> 
> .
> 

