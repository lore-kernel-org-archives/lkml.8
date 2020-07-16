Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C688C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DB42070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGPHwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:52:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgGPHwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:52:46 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id D14F726862762246E102;
        Thu, 16 Jul 2020 08:52:44 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 08:52:43 +0100
Subject: Re: [PATCH 00/18] perf metric: Add support to reuse metric
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
References: <20200712132634.138901-1-jolsa@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b085ecf9-207d-6204-41b7-0937bd95633d@huawei.com>
Date:   Thu, 16 Jul 2020 08:50:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200712132634.138901-1-jolsa@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2020 14:26, Jiri Olsa wrote:
> hi,
> this patchset is adding the support to reused metric in another
> metric. The metric needs to be referenced by 'metric:' prefix.
> 
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
> v2 changes:
>    - collected Ian's acks for few patches [Ian]
>    - renamed expr__add_id to expr__add_id_val [Ian]
>    - renamed expr_parse_data to expr_id_data [Ian]
>    - added recursion check [Ian]
>    - added metric test for DCache_L2 metric [Ian]
>    - added some renames as discussed in review [Ian]
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
> Jiri Olsa (18):
>        perf metric: Rename expr__add_id to expr__add_val
>        perf metric: Add struct expr_id_data to keep expr value
>        perf metric: Add expr__add_id function
>        perf metric: Change expr__get_id to return struct expr_id_data
>        perf metric: Add expr__del_id function
>        perf metric: Add find_metric function
>        perf metric: Add add_metric function
>        perf metric: Rename __metricgroup__add_metric to __add_metric
>        perf metric: Collect referenced metrics in struct metric_ref_node
>        perf metric: Collect referenced metrics in struct metric_expr
>        perf metric: Add referenced metrics to hash data
>        perf metric: Compute referenced metrics
>        perf metric: Add events for the current group
>        perf metric: Add cache_miss_cycles to metric parse test
>        perf metric: Add DCache_L2 to metric parse test
>        perf metric: Add recursion check when processing nested metrics
>        perf metric: Rename struct egroup to metric
>        perf metric: Rename group_list to list

I was thinking that a test metric using this reuse feature could be 
added in pmu-events/arch/test/test_cpu. But since no relevant parsing is 
done in jevents, maybe not a lot of value. Just for a bit more completeness.

Thanks,
John

> 
>   tools/perf/tests/expr.c         |   7 +-
>   tools/perf/tests/parse-metric.c | 131 +++++++++++++++++++++++++++++++++++-
>   tools/perf/tests/pmu-events.c   |   4 +-
>   tools/perf/util/expr.c          | 130 ++++++++++++++++++++++++++++++------
>   tools/perf/util/expr.h          |  34 +++++++++-
>   tools/perf/util/expr.y          |  16 +++--
>   tools/perf/util/metricgroup.c   | 435 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
>   tools/perf/util/metricgroup.h   |   6 ++
>   tools/perf/util/stat-shadow.c   |  24 ++++---
>   9 files changed, 644 insertions(+), 143 deletions(-)
> 
> .
> 

