Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E9C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8553520737
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbgDAUu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:50:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:15024 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbgDAUu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:50:26 -0400
IronPort-SDR: y95uyv4RLx3QfdXs9mXjuKDz/96+agxYI7IETjYUXy1QxjEn8Js126tQMnx7t6PB5N26avpeHS
 9A4DFNAwNRVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 13:50:25 -0700
IronPort-SDR: SktnP5/rzv4X4X/BkvGlMO3MfTk1FyP5XSd4hL5/ap+KdeCvbha09J/+qeyFfqVK6j9mvTcv8Q
 68bsfUbHTaqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="240626846"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 01 Apr 2020 13:50:25 -0700
Received: from [10.213.137.102] (abudanko-MOBL.ccr.corp.intel.com [10.213.137.102])
        by linux.intel.com (Postfix) with ESMTP id 537EB58077B;
        Wed,  1 Apr 2020 13:50:18 -0700 (PDT)
Subject: Re: [PATCH v6 04/10] perf tool: extend Perf tool with CAP_PERFMON
 capability support
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
 <f6eee965-e35d-e4dd-d794-85b7e152c428@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0c8daba0-bc3c-26bf-e463-b8629403beff@linux.intel.com>
Date:   Wed, 1 Apr 2020 23:50:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f6eee965-e35d-e4dd-d794-85b7e152c428@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arnaldo,

On 28.01.2020 9:09, Alexey Budankov wrote:
> 
> Extend error messages to mention CAP_PERFMON capability as an option
> to substitute CAP_SYS_ADMIN capability for secure system performance
> monitoring and observability operations. Make perf_event_paranoid_check()
> and __cmd_ftrace() to be aware of CAP_PERFMON capability.
> 
> CAP_PERFMON implements the principal of least privilege for performance
> monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39 principle
> of least privilege: A security design principle that states that a process
> or program be granted only those privileges (e.g., capabilities) necessary
> to accomplish its legitimate function, and only for the time that such
> privileges are actually required)
> 
> For backward compatibility reasons access to perf_events subsystem remains
> open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for
> secure perf_events monitoring is discouraged with respect to CAP_PERFMON
> capability.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-ftrace.c |  5 +++--
>  tools/perf/design.txt       |  3 ++-
>  tools/perf/util/cap.h       |  4 ++++
>  tools/perf/util/evsel.c     | 10 +++++-----
>  tools/perf/util/util.c      |  1 +
>  5 files changed, 15 insertions(+), 8 deletions(-)

Could this have you explicit Reviewed-by or Acked-by tag
so the changes could be driven into the kernel?
Latest v7 is here:
https://lore.kernel.org/lkml/c8de937a-0b3a-7147-f5ef-69f467e87a13@linux.intel.com/

Thanks,
Alexey


> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d5adc417a4ca..55eda54240fb 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -284,10 +284,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		.events = POLLIN,
>  	};
>  
> -	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> +	if (!(perf_cap__capable(CAP_PERFMON) ||
> +	      perf_cap__capable(CAP_SYS_ADMIN))) {
>  		pr_err("ftrace only works for %s!\n",
>  #ifdef HAVE_LIBCAP_SUPPORT
> -		"users with the SYS_ADMIN capability"
> +		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
>  #else
>  		"root"
>  #endif
> diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> index 0453ba26cdbd..a42fab308ff6 100644
> --- a/tools/perf/design.txt
> +++ b/tools/perf/design.txt
> @@ -258,7 +258,8 @@ gets schedule to. Per task counters can be created by any user, for
>  their own tasks.
>  
>  A 'pid == -1' and 'cpu == x' counter is a per CPU counter that counts
> -all events on CPU-x. Per CPU counters need CAP_SYS_ADMIN privilege.
> +all events on CPU-x. Per CPU counters need CAP_PERFMON or CAP_SYS_ADMIN
> +privilege.
>  
>  The 'flags' parameter is currently unused and must be zero.
>  
> diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
> index 051dc590ceee..ae52878c0b2e 100644
> --- a/tools/perf/util/cap.h
> +++ b/tools/perf/util/cap.h
> @@ -29,4 +29,8 @@ static inline bool perf_cap__capable(int cap __maybe_unused)
>  #define CAP_SYSLOG	34
>  #endif
>  
> +#ifndef CAP_PERFMON
> +#define CAP_PERFMON	38
> +#endif
> +
>  #endif /* __PERF_CAP_H */
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a69e64236120..a35f17723dd3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2491,14 +2491,14 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
>  		 "You may not have permission to collect %sstats.\n\n"
>  		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
>  		 "which controls use of the performance events system by\n"
> -		 "unprivileged users (without CAP_SYS_ADMIN).\n\n"
> +		 "unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).\n\n"
>  		 "The current value is %d:\n\n"
>  		 "  -1: Allow use of (almost) all events by all users\n"
>  		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
> -		 ">= 0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN\n"
> -		 "      Disallow raw tracepoint access by users without CAP_SYS_ADMIN\n"
> -		 ">= 1: Disallow CPU event access by users without CAP_SYS_ADMIN\n"
> -		 ">= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN\n\n"
> +		 ">= 0: Disallow ftrace function tracepoint by users without CAP_PERFMON or CAP_SYS_ADMIN\n"
> +		 "      Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN\n"
> +		 ">= 1: Disallow CPU event access by users without CAP_PERFMON or CAP_SYS_ADMIN\n"
> +		 ">= 2: Disallow kernel profiling by users without CAP_PERFMON or CAP_SYS_ADMIN\n\n"
>  		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
>  		 "	kernel.perf_event_paranoid = -1\n" ,
>  				 target->system_wide ? "system-wide " : "",
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 969ae560dad9..51cf3071db74 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -272,6 +272,7 @@ int perf_event_paranoid(void)
>  bool perf_event_paranoid_check(int max_level)
>  {
>  	return perf_cap__capable(CAP_SYS_ADMIN) ||
> +			perf_cap__capable(CAP_PERFMON) ||
>  			perf_event_paranoid() <= max_level;
>  }
>  
> 
