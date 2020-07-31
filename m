Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C51C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F542177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbgGaPwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:52:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:33113 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgGaPwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:52:46 -0400
IronPort-SDR: lY21kxDcyeZzg3vgHAEQ9PS6o4k4XMCSNuedkHk2eXi67rI7Uat55xJIWMYxDP4Ld/y85s4wSq
 sxLFHnG1KMKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="213340569"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="213340569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 08:52:46 -0700
IronPort-SDR: 05n9puqT+sY/Yo04hZWBossnIHYOR+L51iUMPgSxPRM5MBl8zIGdNy56xOT3mEqQCKAKDO94qk
 ufI62yuFdVqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="321429958"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2020 08:52:46 -0700
Received: from [10.249.228.225] (abudanko-mobl.ccr.corp.intel.com [10.249.228.225])
        by linux.intel.com (Postfix) with ESMTP id 01CF2580699;
        Fri, 31 Jul 2020 08:52:38 -0700 (PDT)
Subject: Re: [PATCH 2/6] perf tools: Store clock references for -k/--clockid
 option
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Ahern <dsahern@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-3-jolsa@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9be7eb7b-4f73-84cc-95e9-e65101b30819@linux.intel.com>
Date:   Fri, 31 Jul 2020 18:52:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730213950.1503773-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31.07.2020 0:39, Jiri Olsa wrote:
> Adding new CLOCK_DATA feature that stores reference times
> when -k/--clockid option is specified.
> 
> It contains clock id and its reference time together with
> wall clock time taken at the 'same time', both values are
> in nanoseconds.
> 
> The format of data is as below:
> 
>   struct {
>        u32 version;  /* version = 1 */
>        u32 clockid;
>        u64 clockid_time_ns;
>        u64 wall_clock_ns;
>   };
> 
> This clock reference times will be used in following changes
> to display wall clock for perf events.
> 
> It's available only for recording with clockid specified,
> because it's the only case where we can get reference time
> to wallclock time. It's can't do that with perf clock yet.
> 
> Original-patch-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../Documentation/perf.data-file-format.txt   |  13 ++
>  tools/perf/builtin-record.c                   |  41 +++++++
>  tools/perf/util/env.h                         |  12 ++
>  tools/perf/util/header.c                      | 112 ++++++++++++++++++
>  tools/perf/util/header.h                      |   1 +
>  5 files changed, 179 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index b6472e463284..c484e81987c7 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -389,6 +389,19 @@ struct {
>  Example:
>   cpu pmu capabilities: branches=32, max_precise=3, pmu_name=icelake
>  
> +	HEADER_CLOCK_DATA = 29,
> +
> +	Contains clock id and its reference time together with wall clock
> +	time taken at the 'same time', both values are in nanoseconds.
> +	The format of data is as below.
> +
> +struct {
> +	u32 version;  /* version = 1 */
> +	u32 clockid;
> +	u64 clockid_time_ns;
> +	u64 wall_clock_ns;
> +};
> +
>  	other bits are reserved and should ignored for now
>  	HEADER_FEAT_BITS	= 256,
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 468c669519a6..f8280e721e1a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -70,6 +70,7 @@
>  #include <linux/time64.h>
>  #include <linux/zalloc.h>
>  #include <linux/bitmap.h>
> +#include <sys/time.h>
>  
>  struct switch_output {
>  	bool		 enabled;
> @@ -1203,6 +1204,9 @@ static void record__init_features(struct record *rec)
>  	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
>  		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
>  
> +	if (!rec->opts.use_clockid)
> +		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
> +
>  	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
>  	if (!record__comp_enabled(rec))
>  		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
> @@ -1551,6 +1555,40 @@ static int record__setup_sb_evlist(struct record *rec)
>  	return 0;
>  }
>  
> +static int record__init_clock(struct record *rec)
> +{
> +	struct perf_session *session = rec->session;
> +	struct timespec ref_clockid;
> +	struct timeval ref_tod;
> +	u64 ref;
> +
> +	if (!rec->opts.use_clockid)
> +		return 0;
> +
> +	session->header.env.clock.clockid = rec->opts.clockid;
> +
> +	if (gettimeofday(&ref_tod, NULL) != 0) {
> +		pr_err("gettimeofday failed, cannot set reference time.\n");
> +		return -1;
> +	}
> +
> +	if (clock_gettime(rec->opts.clockid, &ref_clockid)) {
> +		pr_err("clock_gettime failed, cannot set reference time.\n");
> +		return -1;
> +	}

It might also want to be implemented in a loop and iteration with minimal
time delta is chosen to improve synchronization accuracy and also mitigate
possible context switches between gettimeofday() and clock_gettime() calls.

Alexei
