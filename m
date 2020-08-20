Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA3FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75CB2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHTDF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:05:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9791 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbgHTDF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:05:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 23525C6B728D206F4065;
        Thu, 20 Aug 2020 11:05:26 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 11:05:18 +0800
From:   "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH v2 2/4] perf arm_arch_timer: Convert between counter and
 timestamp
To:     Leo Yan <leo.yan@linaro.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        <linux-kernel@vger.kernel.org>
References: <20200807071620.11907-1-leo.yan@linaro.org>
 <20200807071620.11907-3-leo.yan@linaro.org>
Message-ID: <56b274bc-7154-2baf-d1e0-c537c260761d@huawei.com>
Date:   Thu, 20 Aug 2020 11:05:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200807071620.11907-3-leo.yan@linaro.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2020/8/7 15:16, Leo Yan wrote:
> This patch introduces two new APIs, one is to calculate from converting
> counter to timestamp and provides a reverse flow to convert timestamp
> to counter.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/Build            |  1 +
>  tools/perf/util/arm_arch_timer.c | 28 ++++++++++++++++++++++++++++
>  tools/perf/util/arm_arch_timer.h |  3 +++
>  3 files changed, 32 insertions(+)
>  create mode 100644 tools/perf/util/arm_arch_timer.c
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8d18380ecd10..ba504549844f 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -101,6 +101,7 @@ perf-y += call-path.o
>  perf-y += rwsem.o
>  perf-y += thread-stack.o
>  perf-y += spark.o
> +perf-y += arm_arch_timer.o
>  perf-$(CONFIG_AUXTRACE) += auxtrace.o
>  perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
>  perf-$(CONFIG_AUXTRACE) += intel-pt.o
> diff --git a/tools/perf/util/arm_arch_timer.c b/tools/perf/util/arm_arch_timer.c
> new file mode 100644
> index 000000000000..c37ffa4d9710
> --- /dev/null
> +++ b/tools/perf/util/arm_arch_timer.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
> +#include "arm_arch_timer.h"
> +
> +u64 perf_time_to_arch_timer_cyc(u64 ns, struct perf_arch_timer_conversion *tc)
> +{
> +	u64 t, quot, rem;
> +
> +	t = ns - tc->time_zero;
> +	quot = t / tc->time_mult;
> +	rem  = t % tc->time_mult;
> +	return (quot << tc->time_shift) +
> +	       (rem << tc->time_shift) / tc->time_mult;
> +}
> +
> +u64 arch_timer_cyc_to_perf_time(u64 cyc, struct perf_arch_timer_conversion *tc)
> +{
> +	u64 quot, rem;
> +
> +	cyc = tc->time_cycles + ((cyc - tc->time_cycles) & tc->time_mask);
> +
> +	quot = cyc >> tc->time_shift;
> +	rem  = cyc & (((u64)1 << tc->time_shift) - 1);
> +	return tc->time_zero + quot * tc->time_mult +
> +	       ((rem * tc->time_mult) >> tc->time_shift);
> +}

Can we merge these methods with 'tools/perf/util/tsc.c'?  I think the converting
between arch timestamp and the perf time should be arch independent. And in fact, we
have built tsc_to_perf_time() into the perf on arm64. So maybe we can add
cap_user_time_xxx into 'struct perf_tsc_conversion', then dispatch for different
capabilities.

Thanks,
Wei

> diff --git a/tools/perf/util/arm_arch_timer.h b/tools/perf/util/arm_arch_timer.h
> index a3263cc4e5cf..7d9271f544f2 100644
> --- a/tools/perf/util/arm_arch_timer.h
> +++ b/tools/perf/util/arm_arch_timer.h
> @@ -17,4 +17,7 @@ struct perf_event_mmap_page;
>  int perf_read_arch_timer_conversion(const struct perf_event_mmap_page *pc,
>  				    struct perf_arch_timer_conversion *tc);
>  
> +u64 arch_timer_cyc_to_perf_time(u64 cyc, struct perf_arch_timer_conversion *tc);
> +u64 perf_time_to_arch_timer_cyc(u64 ns, struct perf_arch_timer_conversion *tc);
> +
>  #endif // __PERF_ARM_ARCH_TIMER_H
> 
