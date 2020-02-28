Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA98AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBBD2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgB1QBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:01:32 -0500
Received: from foss.arm.com ([217.140.110.172]:40674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbgB1QBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:01:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A8BD31B;
        Fri, 28 Feb 2020 08:01:30 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D53753F73B;
        Fri, 28 Feb 2020 08:01:28 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:01:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com, Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 4/4] perf tools: Support "branch-misses:pp" on arm64
Message-ID: <20200228160126.GI36089@lakrids.cambridge.arm.com>
References: <20200210122509.GA2005279@krava>
 <20200211140445.21986-1-james.clark@arm.com>
 <20200211140445.21986-5-james.clark@arm.com>
 <3114ea3a-5d9b-2c25-af41-cead352b6a02@intel.com>
 <96a814b2-23b8-2ac0-9dc5-0a4b70ddf895@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a814b2-23b8-2ac0-9dc5-0a4b70ddf895@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Feb 24, 2020 at 05:08:26PM +0000, James Clark wrote:
> On 2/17/20 11:42 AM, Adrian Hunter wrote:
> > On 11/02/20 4:04 pm, James Clark wrote:
> >> From: Tan Xiaojun <tanxiaojun@huawei.com>
> >>
> >> At the suggestion of James Clark, use spe to support the precise
> >> ip of some events. Currently its support event is:
> >> branch-misses.
> >>
> >> Example usage:
> >>
> >> $ ./perf record -e branch-misses:pp dd if=/dev/zero of=/dev/null count=10000
> >> (:p/pp/ppp is same for this case.)
> >>
> >> $ ./perf report --stdio
> >> ("--stdio is not necessary")
> >>
> >> --------------------------------------------------------------------
> >> ...
> >>  # Samples: 14  of event 'branch-misses:pp'
> >>  # Event count (approx.): 14
> >>  #
> >>  # Children      Self  Command  Shared Object      Symbol
> >>  # ........  ........  .......  .................  ..........................
> >>  #
> >>     14.29%    14.29%  dd       [kernel.kallsyms]  [k] __arch_copy_from_user
> >>     14.29%    14.29%  dd       libc-2.28.so       [.] _dl_addr
> >>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] __free_pages
> >>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] __pi_memcpy
> >>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] pagecache_get_page
> >>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] unmap_single_vma
> >>      7.14%     7.14%  dd       dd                 [.] 0x00000000000025ec
> >>      7.14%     7.14%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
> >>      7.14%     7.14%  dd       ld-2.28.so         [.] check_match
> >>      7.14%     7.14%  dd       libc-2.28.so       [.] __mpn_rshift
> >>      7.14%     7.14%  dd       libc-2.28.so       [.] _nl_intern_locale_data
> >>      7.14%     7.14%  dd       libc-2.28.so       [.] read_alias_file
> >> ...
> >> --------------------------------------------------------------------
> >>
> >> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
> >> Suggested-by: James Clark <James.Clark@arm.com>
> >> Tested-by: Qi Liu <liuqi115@hisilicon.com>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Jiri Olsa <jolsa@redhat.com>
> >> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> >> Cc: Al Grant <al.grant@arm.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> ---
> >>  tools/perf/arch/arm/util/auxtrace.c | 38 +++++++++++++++++++++++++++++
> >>  tools/perf/builtin-record.c         |  5 ++++
> >>  tools/perf/util/arm-spe.c           |  9 +++++++
> >>  tools/perf/util/arm-spe.h           |  3 +++
> >>  tools/perf/util/auxtrace.h          |  6 +++++
> >>  5 files changed, 61 insertions(+)
> >>
> >> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> >> index 0a6e75b8777a..18f0ea7556e7 100644
> >> --- a/tools/perf/arch/arm/util/auxtrace.c
> >> +++ b/tools/perf/arch/arm/util/auxtrace.c
> >> @@ -10,11 +10,25 @@
> >>  
> >>  #include "../../util/auxtrace.h"
> >>  #include "../../util/debug.h"
> >> +#include "../../util/env.h"
> >>  #include "../../util/evlist.h"
> >>  #include "../../util/pmu.h"
> >>  #include "cs-etm.h"
> >>  #include "arm-spe.h"
> >>  
> >> +#define SPE_ATTR_TS_ENABLE		BIT(0)
> >> +#define SPE_ATTR_PA_ENABLE		BIT(1)
> >> +#define SPE_ATTR_PCT_ENABLE		BIT(2)
> >> +#define SPE_ATTR_JITTER			BIT(16)
> >> +#define SPE_ATTR_BRANCH_FILTER		BIT(32)
> >> +#define SPE_ATTR_LOAD_FILTER		BIT(33)
> >> +#define SPE_ATTR_STORE_FILTER		BIT(34)
> >> +
> >> +#define SPE_ATTR_EV_RETIRED		BIT(1)
> >> +#define SPE_ATTR_EV_CACHE		BIT(3)
> >> +#define SPE_ATTR_EV_TLB			BIT(5)
> >> +#define SPE_ATTR_EV_BRANCH		BIT(7)
> >> +
> >>  static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
> >>  {
> >>  	struct perf_pmu **arm_spe_pmus = NULL;
> >> @@ -108,3 +122,27 @@ struct auxtrace_record
> >>  	*err = 0;
> >>  	return NULL;
> >>  }
> >> +
> >> +void auxtrace__preprocess_evlist(struct evlist *evlist)
> >> +{
> >> +	struct evsel *evsel;
> >> +	struct perf_pmu *pmu;
> >> +
> >> +	evlist__for_each_entry(evlist, evsel) {
> >> +		/* Currently only supports precise_ip for branch-misses on arm64 */
> >> +		if (!strcmp(perf_env__arch(evlist->env), "arm64")
> > 
> > Isn't config ambiguous unless you also check type i.e.
> > 
> > 			&& evsel->core.attr.type == PERF_TYPE_HARDWARE
> > 
> 
> Yes you're right I will add this.
> 
> >> +			&& evsel->core.attr.config == PERF_COUNT_HW_BRANCH_MISSES
> >> +			&& evsel->core.attr.precise_ip)
> >> +		{
> >> +			pmu = perf_pmu__find("arm_spe_0");
> >> +			if (pmu) {
> > 
> > Changing the event seems a bit weird.
> > 
> 
> This is because there is no support in the kernel for the precise_ip attribute on Arm.
> SPE can give you precise ip data for the same event, but changing the event is required.

I don't think this is the right level to override the event.

It's true that contemporary CPU PMUs can't generate synchronous events,
and hence the kernel doesn't have a precise IP, but that's not
necessarily going to be the case in future. I'd rather we didn't
silently override the event requested by the user, as I think that is
going to cause more problems for us in future.

When the SPE buffer overflows, events will be silently dropped, which I
don't believe is in keeping with the usual semantics of precise events.
Additionally, hard-coding the "arm_spe_0" name means that this will not
work reliably on big.LITTLE systems.

Instead, can we have the user explicitly request to use the SPE PMU in
this way? If the perf tool could be smart with the "_%d" suffix, and
collate PMUs differing only by that, the user would only need to do
something like:

  perf record -e arm_spe/branch-misses/pp

... which doesn't seem to onerous.

Is something like that possible?

Thanks,
Mark.

