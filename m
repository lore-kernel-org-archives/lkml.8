Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128A4C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4652064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgB1QDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:03:36 -0500
Received: from foss.arm.com ([217.140.110.172]:40738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgB1QDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:03:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6065731B;
        Fri, 28 Feb 2020 08:03:35 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98A693F73B;
        Fri, 28 Feb 2020 08:03:33 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:03:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     adrian.hunter@intel.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com, Tan Xiaojun <tanxiaojun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 4/4] perf tools: Support "branch-misses:pp" on arm64
Message-ID: <20200228160331.GJ36089@lakrids.cambridge.arm.com>
References: <768a33f2-8694-270e-d3e8-3da4c65e96b3@intel.com>
 <20200225115739.18740-1-james.clark@arm.com>
 <20200225115739.18740-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225115739.18740-5-james.clark@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Sorry, I missed this v5 when replying to v4 just now, but my comments
there equally apply here: I don't think that we should be silently
overriding the event requested by the user, and I think that we can make
that request explicit without being too painful for the user.

Thanks,
Mark.

On Tue, Feb 25, 2020 at 11:57:39AM +0000, James Clark wrote:
> From: Tan Xiaojun <tanxiaojun@huawei.com>
> 
> At the suggestion of James Clark, use spe to support the precise
> ip of some events. Currently its support event is:
> branch-misses.
> 
> Example usage:
> 
> $ ./perf record -e branch-misses:pp dd if=/dev/zero of=/dev/null count=10000
> (:p/pp/ppp is same for this case.)
> 
> $ ./perf report --stdio
> ("--stdio is not necessary")
> 
> --------------------------------------------------------------------
> ...
>  # Samples: 14  of event 'branch-misses:pp'
>  # Event count (approx.): 14
>  #
>  # Children      Self  Command  Shared Object      Symbol
>  # ........  ........  .......  .................  ..........................
>  #
>     14.29%    14.29%  dd       [kernel.kallsyms]  [k] __arch_copy_from_user
>     14.29%    14.29%  dd       libc-2.28.so       [.] _dl_addr
>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] __free_pages
>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] __pi_memcpy
>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] pagecache_get_page
>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] unmap_single_vma
>      7.14%     7.14%  dd       dd                 [.] 0x00000000000025ec
>      7.14%     7.14%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
>      7.14%     7.14%  dd       ld-2.28.so         [.] check_match
>      7.14%     7.14%  dd       libc-2.28.so       [.] __mpn_rshift
>      7.14%     7.14%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>      7.14%     7.14%  dd       libc-2.28.so       [.] read_alias_file
> ...
> --------------------------------------------------------------------
> 
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
> Suggested-by: James Clark <James.Clark@arm.com>
> Tested-by: Qi Liu <liuqi115@hisilicon.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/arm/util/auxtrace.c | 39 +++++++++++++++++++++++++++++
>  tools/perf/builtin-record.c         |  5 ++++
>  tools/perf/util/arm-spe.c           |  9 +++++++
>  tools/perf/util/arm-spe.h           |  3 +++
>  tools/perf/util/auxtrace.h          |  6 +++++
>  5 files changed, 62 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 0a6e75b8777a..7f412b7894ab 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -10,11 +10,25 @@
>  
>  #include "../../util/auxtrace.h"
>  #include "../../util/debug.h"
> +#include "../../util/env.h"
>  #include "../../util/evlist.h"
>  #include "../../util/pmu.h"
>  #include "cs-etm.h"
>  #include "arm-spe.h"
>  
> +#define SPE_ATTR_TS_ENABLE		BIT(0)
> +#define SPE_ATTR_PA_ENABLE		BIT(1)
> +#define SPE_ATTR_PCT_ENABLE		BIT(2)
> +#define SPE_ATTR_JITTER			BIT(16)
> +#define SPE_ATTR_BRANCH_FILTER		BIT(32)
> +#define SPE_ATTR_LOAD_FILTER		BIT(33)
> +#define SPE_ATTR_STORE_FILTER		BIT(34)
> +
> +#define SPE_ATTR_EV_RETIRED		BIT(1)
> +#define SPE_ATTR_EV_CACHE		BIT(3)
> +#define SPE_ATTR_EV_TLB			BIT(5)
> +#define SPE_ATTR_EV_BRANCH		BIT(7)
> +
>  static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>  {
>  	struct perf_pmu **arm_spe_pmus = NULL;
> @@ -108,3 +122,28 @@ struct auxtrace_record
>  	*err = 0;
>  	return NULL;
>  }
> +
> +void auxtrace__preprocess_evlist(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +	struct perf_pmu *pmu;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		/* Currently only supports precise_ip for branch-misses on arm64 */
> +		if (!strcmp(perf_env__arch(evlist->env), "arm64")
> +			&& evsel->core.attr.config == PERF_COUNT_HW_BRANCH_MISSES
> +			&& evsel->core.attr.type == PERF_TYPE_HARDWARE
> +			&& evsel->core.attr.precise_ip)
> +		{
> +			pmu = perf_pmu__find("arm_spe_0");
> +			if (pmu) {
> +				evsel->pmu_name = pmu->name;
> +				evsel->core.attr.type = pmu->type;
> +				evsel->core.attr.config = SPE_ATTR_TS_ENABLE
> +							| SPE_ATTR_BRANCH_FILTER;
> +				evsel->core.attr.config1 = SPE_ATTR_EV_BRANCH;
> +				evsel->core.attr.precise_ip = 0;
> +			}
> +		}
> +	}
> +}
> \ No newline at end of file
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4c301466101b..3bc61f03d572 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2451,6 +2451,11 @@ int cmd_record(int argc, const char **argv)
>  
>  	argc = parse_options(argc, argv, record_options, record_usage,
>  			    PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	if (auxtrace__preprocess_evlist) {
> +		auxtrace__preprocess_evlist(rec->evlist);
> +	}
> +
>  	if (quiet)
>  		perf_quiet_option();
>  
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 4ef22a0775a9..b21806c97dd8 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -778,6 +778,15 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	attr.sample_id_all = evsel->core.attr.sample_id_all;
>  	attr.read_format = evsel->core.attr.read_format;
>  
> +	/* If it is in the precise ip mode, there is no need to
> +	 * synthesize new events. */
> +	if (!strncmp(evsel->name, "branch-misses", 13)) {
> +		spe->sample_branch_miss = true;
> +		spe->branch_miss_id = evsel->core.id[0];
> +
> +		return 0;
> +	}
> +
>  	/* create new id val to be a fixed offset from evsel id */
>  	id = evsel->core.id[0] + 1000000000;
>  
> diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
> index 98d3235781c3..8b1fb191d03a 100644
> --- a/tools/perf/util/arm-spe.h
> +++ b/tools/perf/util/arm-spe.h
> @@ -20,6 +20,8 @@ enum {
>  union perf_event;
>  struct perf_session;
>  struct perf_pmu;
> +struct evlist;
> +struct evsel;
>  
>  struct auxtrace_record *arm_spe_recording_init(int *err,
>  					       struct perf_pmu *arm_spe_pmu);
> @@ -28,4 +30,5 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session);
>  
>  struct perf_event_attr *arm_spe_pmu_default_config(struct perf_pmu *arm_spe_pmu);
> +void arm_spe_precise_ip_support(struct evlist *evlist, struct evsel *evsel);
>  #endif
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 52e148eea7f8..4be56bca54dc 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -584,6 +584,7 @@ void auxtrace__dump_auxtrace_sample(struct perf_session *session,
>  int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
>  void auxtrace__free_events(struct perf_session *session);
>  void auxtrace__free(struct perf_session *session);
> +void auxtrace__preprocess_evlist(struct evlist *evlist) __attribute__((weak));
>  
>  #define ITRACE_HELP \
>  "				i:	    		synthesize instructions events\n"		\
> @@ -731,6 +732,11 @@ void auxtrace__free(struct perf_session *session __maybe_unused)
>  {
>  }
>  
> +static inline
> +void auxtrace__preprocess_evlist(struct evlist *evlist __maybe_unused)
> +{
> +}
> +
>  static inline
>  int auxtrace_index__write(int fd __maybe_unused,
>  			  struct list_head *head __maybe_unused)
> -- 
> 2.17.1
> 
