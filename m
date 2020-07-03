Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA458C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9344020936
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuKWwJVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGCLA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:00:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39302 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgGCLA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593774053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCwNwIJLk7+4g1qLA90x2U92e+ugEUwZVEI97T0FP7M=;
        b=KuKWwJVwgivU6vm2j5UQizq8L6b2nhAVVMPcmX3NtmJ44yeWK0RIX8KM0kOeoKwX+fVXV3
        m4J83OYOR/2jsYkO/+nLaemyoOQzqfJI2g8IrWnsNI2NuNlEMpUYMm4nHCSHC5wH+Kv12B
        l/peo3UzNigKxdkCz3Xps/VUQW7rMcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-DP4n7I3QNvWyx4p150F86w-1; Fri, 03 Jul 2020 07:00:47 -0400
X-MC-Unique: DP4n7I3QNvWyx4p150F86w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED094804002;
        Fri,  3 Jul 2020 11:00:45 +0000 (UTC)
Received: from krava (unknown [10.40.194.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 060A52DE76;
        Fri,  3 Jul 2020 11:00:42 +0000 (UTC)
Date:   Fri, 3 Jul 2020 13:00:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf evsel: Don't set sample_regs_intr/sample_regs_user
 for dummy event
Message-ID: <20200703110042.GA3282312@krava>
References: <20200703004215.24418-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703004215.24418-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 08:42:15AM +0800, Jin Yao wrote:
> Since commit 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis"),
> a dummy event is added to capture mmaps.
> 
> But if we run perf-record as,
> 
>  # perf record -e cycles:p -IXMM0 -a -- sleep 1
>  Error:
>  dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> 
> The issue is, if we enable the extended regs (-IXMM0), but the
> pmu->capabilities is not set with PERF_PMU_CAP_EXTENDED_REGS, the kernel
> will return -EOPNOTSUPP error.
> 
> See following code pieces.
> 
> /* in kernel/events/core.c */
> static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
> 
> {
> 	....
> 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
> 	    has_extended_regs(event))
> 		ret = -EOPNOTSUPP;
> 	....
> }
> 
> For software dummy event, the PMU should be not set with
> PERF_PMU_CAP_EXTENDED_REGS. But unfortunately in current code, the dummy
> event has possibility to be set with PERF_REG_EXTENDED_MASK bit.
> 
> In evsel__config, /* tools/perf/util/evsel.c */
> 
> if (opts->sample_intr_regs) {
> 	attr->sample_regs_intr = opts->sample_intr_regs;
> }
> 
> If we use -IXMM0, the attr>sample_regs_intr will be set with
> PERF_REG_EXTENDED_MASK bit.
> 
> It doesn't make sense to set attr->sample_regs_intr for a
> software dummy event.
> 
> This patch adds dummy event checking before setting
> attr->sample_regs_intr.
> 
> After:
>   # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]

LGTM, Adrian (cc-ed) just added another check to the same place,
but it looks like both of them should be there:

  https://lore.kernel.org/lkml/20200630133935.11150-2-adrian.hunter@intel.com/

jirka

> 
> Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 96e5171dce41..df3315543e86 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1020,12 +1020,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	if (callchain && callchain->enabled && !evsel->no_aux_samples)
>  		evsel__config_callchain(evsel, opts, callchain);
>  
> -	if (opts->sample_intr_regs) {
> +	if (opts->sample_intr_regs && !is_dummy_event(evsel)) {
>  		attr->sample_regs_intr = opts->sample_intr_regs;
>  		evsel__set_sample_bit(evsel, REGS_INTR);
>  	}
>  
> -	if (opts->sample_user_regs) {
> +	if (opts->sample_user_regs && !is_dummy_event(evsel)) {
>  		attr->sample_regs_user |= opts->sample_user_regs;
>  		evsel__set_sample_bit(evsel, REGS_USER);
>  	}
> -- 
> 2.17.1
> 

