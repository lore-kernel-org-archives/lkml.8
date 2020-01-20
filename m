Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0D9C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1EF207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmx/4xWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgATJ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:29:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgATJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579512579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2AyZJjezQPayOoYoOZDjEemml5k2ADZSs5c/XlCC8U=;
        b=Tmx/4xWozigOVvRqXg4lM299C/5sP+UIbw9T2vnDnGPcZfgAro0JDyRBrlx9IdcpotS5ur
        s/cgukkB9mKMvGAnxKyY4MIDVVvAp73sIrsvY2WiKStVoFRueYcy2tqHaz+URL74LEIQGR
        5zeuvdFgMtGC14wqfhODsGPRefC6eu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-sFTa31syPk-YGwtq8dhJxQ-1; Mon, 20 Jan 2020 04:29:35 -0500
X-MC-Unique: sFTa31syPk-YGwtq8dhJxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A83A0DB21;
        Mon, 20 Jan 2020 09:29:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B25A360C05;
        Mon, 20 Jan 2020 09:29:30 +0000 (UTC)
Date:   Mon, 20 Jan 2020 10:29:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf stat: don't report a null stalled cycles per
 insn metric
Message-ID: <20200120092928.GD608405@krava>
References: <20200115222949.7247-1-kim.phillips@amd.com>
 <20200115222949.7247-2-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115222949.7247-2-kim.phillips@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:29:49PM -0600, Kim Phillips wrote:
> For data collected on machines with front end stalled cycles supported,
> such as found on modern AMD CPU families, commit 146540fb545b ("perf
> stat: Always separate stalled cycles per insn") introduces a new line
> in CSV output with a leading comma that upsets some automated scripts.
> Scripts have to use "-e ex_ret_instr" to work around this issue, after
> upgrading to a version of perf with that commit.
> 
> We could add "if (have_frontend_stalled && !config->csv_sep)"
> to the not (total && avg) else clause, to emphasize that CSV users
> are usually scripts, and are written to do only what is needed, i.e.,
> they wouldn't typically invoke "perf stat" without specifying an
> explicit event list.
> 
> But - let alone CSV output - why should users now tolerate a constant
> 0-reporting extra line in regular terminal output?:
> 
> BEFORE:
> 
> $ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        181,110,981      instructions              #    0.58  insn per cycle
>                                                   #    0.00  stalled cycles per insn
>        309,876,469      cycles
> 
>        1.002202582 seconds time elapsed
> 
> The user would not like to see the now permanent
> "0.00  stalled cycles per insn" line fixture, as it gives
> no useful information.
> 
> So this patch removes the printing of the zeroed stalled cycles
> line altogether, almost reverting the very original commit fb4605ba47e7
> ("perf stat: Check for frontend stalled for metrics"), which seems
> like it was written to normalize --metric-only column output
> of common Intel machines at the time: modern Intel machines
> have ceased to support the genericised frontend stalled metrics AFAICT.
> 
> AFTER:
> 
> $ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        244,071,432      instructions              #    0.69  insn per cycle
>        355,353,490      cycles
> 
>        1.001862516 seconds time elapsed
> 
> Output behaviour when stalled cycles is indeed measured is not affected
> (BEFORE == AFTER):
> 
> $ sudo perf stat --all-cpus -einstructions,cycles,stalled-cycles-frontend -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        247,227,799      instructions              #    0.63  insn per cycle
>                                                   #    0.26  stalled cycles per insn
>        394,745,636      cycles
>         63,194,485      stalled-cycles-frontend   #   16.01% frontend cycles idle
> 
>        1.002079770 seconds time elapsed

looks reasonable to me, Andi, are you ok with this?

Acked-by: Jiri Olsa <jolsa@redhat.com

thanks,
jirka

> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 146540fb545b ("perf stat: Always separate stalled cycles per insn")
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  tools/perf/util/stat-shadow.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 2c41d47f6f83..90d23cc3c8d4 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -18,7 +18,6 @@
>   * AGGR_NONE: Use matching CPU
>   * AGGR_THREAD: Not supported?
>   */
> -static bool have_frontend_stalled;
>  
>  struct runtime_stat rt_stat;
>  struct stats walltime_nsecs_stats;
> @@ -144,7 +143,6 @@ void runtime_stat__exit(struct runtime_stat *st)
>  
>  void perf_stat__init_shadow_stats(void)
>  {
> -	have_frontend_stalled = pmu_have_event("cpu", "stalled-cycles-frontend");
>  	runtime_stat__init(&rt_stat);
>  }
>  
> @@ -853,10 +851,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  			print_metric(config, ctxp, NULL, "%7.2f ",
>  					"stalled cycles per insn",
>  					ratio);
> -		} else if (have_frontend_stalled) {
> -			out->new_line(config, ctxp);
> -			print_metric(config, ctxp, NULL, "%7.2f ",
> -				     "stalled cycles per insn", 0);
>  		}
>  	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
>  		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
> -- 
> 2.24.1
> 

