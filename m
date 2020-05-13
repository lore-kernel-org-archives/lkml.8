Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2889DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4811120671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8S4XYxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbgEMPbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:31:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54155 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388928AbgEMPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589383902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XN2h70ioAIDmm/MzchtHJK6S8S+xQzl7MM8tq9EOXu4=;
        b=d8S4XYxDUy0K8z2qdWbXJjgL3mXFY6EwfLYtinNopHbRFKrHsQo2Bfx12BqtgVVrJPUAHX
        LVToPq0v+oYIvOa9vD8T6wemxIz97zJJOGfnYT7zBWB6Dd0dRyxtW4IoLy28tjitNooou1
        jfTlDsbMiEBBSHN/q6u8xi71ofHpnpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-KPOEBu4kOl65mdU3BD8bBQ-1; Wed, 13 May 2020 11:31:38 -0400
X-MC-Unique: KPOEBu4kOl65mdU3BD8bBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BECB3107ACF2;
        Wed, 13 May 2020 15:31:36 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9DAFF6F453;
        Wed, 13 May 2020 15:31:34 +0000 (UTC)
Date:   Wed, 13 May 2020 17:31:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 3/4] perf stat: Copy counts from prev_raw_counts to
 evsel->counts
Message-ID: <20200513153133.GN3158213@krava>
References: <20200508075817.10588-1-yao.jin@linux.intel.com>
 <20200508075817.10588-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508075817.10588-4-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 03:58:16PM +0800, Jin Yao wrote:
> It would be useful to support the overall statistics for perf-stat
> interval mode. For example, report the summary at the end of
> "perf-stat -I" output.
> 
> But since perf-stat can support many aggregation modes, such as
> --per-thread, --per-socket, -M and etc, we need a solution which
> doesn't bring much complexity.
> 
> The idea is to use 'evsel->prev_raw_counts' which is updated in
> each interval and it's saved with the latest counts. Before reporting
> the summary, we copy the counts from evsel->prev_raw_counts to
> evsel->counts, and next we just follow non-interval processing.
> 
> In evsel__compute_deltas, this patch saves counts to the member
> [cpu0,thread0] of perf_counts for AGGR_GLOBAL.
> 
> That's because after copying evsel->prev_raw_counts to evsel->counts,
> perf_counts(evsel->counts, cpu, thread) are all 0 for AGGR_GLOBAL.
> Once we go to process_counter_maps again, all members of perf_counts
> are 0.
> 
> So this patch uses a trick that saves the previous aggr value to
> the member [cpu0,thread0] of perf_counts, then aggr calculation
> in process_counter_values can work correctly.
> 
>  v4:
>  ---
>  Change the commit message.
>  No functional change.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/evsel.c |  1 +
>  tools/perf/util/stat.c  | 24 ++++++++++++++++++++++++
>  tools/perf/util/stat.h  |  1 +
>  3 files changed, 26 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 28683b0eb738..6fae1ec28886 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1283,6 +1283,7 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>  	if (cpu == -1) {
>  		tmp = evsel->prev_raw_counts->aggr;
>  		evsel->prev_raw_counts->aggr = *count;
> +		*perf_counts(evsel->prev_raw_counts, 0, 0) = *count;

ok, I think I understand that now.. it's only for AGGR_GLOBAL mode,
because the perf_stat_process_counter will create aggr values from
per cpu values

but why do we need to do that all the time? can't we just set it up
before you zero prev_raw_counts in next patch?


        if (interval) {
                stat_config.interval = 0;
                stat_config.summary = true;
                perf_evlist__copy_prev_raw_counts(evsel_list);

	-> for AGGR_GLOBAL set the counts[0,0] to prev_raw_counts->aggr

                perf_evlist__reset_prev_raw_counts(evsel_list);
                runtime_stat_reset(&stat_config);
                perf_stat__reset_shadow_per_stat(&rt_stat);
        }


thanks,
jirka

