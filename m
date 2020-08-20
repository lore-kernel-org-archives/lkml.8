Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC35C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83A52078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHTC5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:57:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9855 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbgHTC5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:57:07 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A24496F32C173C085B9D;
        Thu, 20 Aug 2020 10:57:04 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 10:56:59 +0800
From:   "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH v2 1/4] perf tools: Support Arm arch timer counter
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
 <20200807071620.11907-2-leo.yan@linaro.org>
Message-ID: <27ed6ebf-d9e6-e0ea-1577-2bba3d6f35c1@huawei.com>
Date:   Thu, 20 Aug 2020 10:56:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200807071620.11907-2-leo.yan@linaro.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo

On 2020/8/7 15:16, Leo Yan wrote:
> The Arm arch timer can be used to calculate timestamp, the basic idea is
> the arch timer's counter value can be recorded in the hardware tracing
> data, e.g. the arch timer's counter value can be used for Arm CoreSight
> (not now but might be implemented later) and Arm SPE.  So we need a way
> to convert the arch timer's counter to the system time, the conversion
> is dependent on some related parameters, e.g. 'time_shift', 'time_mult',
> 'time_offset', etc; furthermore, to handle the counter wrapping issue,
> perf tool needs to know 'time_cycles' and 'time_mask' for correction.
> 
> This patch is to support Arm arch timer by reading out the relevant
> parameters from the head of first mmaped page.  And these parameters
> will be stored into the structure 'perf_arch_timer_conversion' for
> later calculation timestamp.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm64/util/Build        |  1 +
>  tools/perf/arch/arm64/util/arch_timer.c | 50 +++++++++++++++++++++++++
>  tools/perf/util/arm_arch_timer.h        | 20 ++++++++++
>  3 files changed, 71 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/util/arch_timer.c
>  create mode 100644 tools/perf/util/arm_arch_timer.h
> 
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 5c13438c7bd4..77f4d7b30932 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,3 +1,4 @@
> +perf-y += arch_timer.o
>  perf-y += header.o
>  perf-y += machine.o
>  perf-y += perf_regs.o
> diff --git a/tools/perf/arch/arm64/util/arch_timer.c b/tools/perf/arch/arm64/util/arch_timer.c
> new file mode 100644
> index 000000000000..dcc217c294fc
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/arch_timer.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
> +#include <errno.h>
> +
> +#include <linux/stddef.h>
> +#include <linux/perf_event.h>
> +
> +#include <linux/types.h>
> +#include <asm/barrier.h>
> +#include "../../../util/debug.h"
> +#include "../../../util/event.h"
> +#include "../../../util/synthetic-events.h"
> +#include "../../../util/arm_arch_timer.h"
> +
> +int perf_read_arch_timer_conversion(const struct perf_event_mmap_page *pc,
> +				    struct perf_arch_timer_conversion *tc)
> +{
> +	bool cap_user_time_zero, cap_user_time_short;
> +	u32 seq;
> +	int i = 0;
> +
> +	while (1) {
> +		seq = pc->lock;
> +		/* Add barrier between the sequence lock and data accessing */
> +		rmb();
> +
> +		tc->time_mult = pc->time_mult;
> +		tc->time_shift = pc->time_shift;
> +		tc->time_zero = pc->time_zero;
> +		tc->time_cycles = pc->time_cycles;
> +		tc->time_mask = pc->time_mask;
> +		cap_user_time_zero = pc->cap_user_time_zero;
> +		cap_user_time_short = pc->cap_user_time_short;
> +
> +		/* Add barrier between the data accessing and sequence lock */
> +		rmb();
> +		if (pc->lock == seq && !(seq & 1))
> +			break;
> +		if (++i > 10000) {
> +			pr_debug("%s: failed to get perf_event_mmap_page lock\n",
> +				 __func__);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!cap_user_time_zero || !cap_user_time_short)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}

Should we implement the perf_event__synth_time_conv() method? As it can be supported
on arm64 arch now.

These is also a tsc get method called rdtsc(), weak implementation in 'tools/perf/util/tsc.c',
maybe we should rename it to an arch independent name, and implement the arm64 version
(read_cntvct_el0 in patch 3) here. Thus we can also make the testcase generic,
instead of adding a new one for arm64 :).

Thanks,
Wei

> diff --git a/tools/perf/util/arm_arch_timer.h b/tools/perf/util/arm_arch_timer.h
> new file mode 100644
> index 000000000000..a3263cc4e5cf
> --- /dev/null
> +++ b/tools/perf/util/arm_arch_timer.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_ARM_ARCH_TIMER_H
> +#define __PERF_ARM_ARCH_TIMER_H
> +
> +#include <linux/types.h>
> +
> +struct perf_arch_timer_conversion {
> +	u16 time_shift;
> +	u32 time_mult;
> +	u64 time_zero;
> +	u64 time_cycles;
> +	u64 time_mask;
> +};
> +
> +struct perf_event_mmap_page;
> +
> +int perf_read_arch_timer_conversion(const struct perf_event_mmap_page *pc,
> +				    struct perf_arch_timer_conversion *tc);
> +
> +#endif // __PERF_ARM_ARCH_TIMER_H
> 
