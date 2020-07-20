Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3C9C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1E82080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIdaHUO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgGTJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:18:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727120AbgGTJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595236678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U5qfFxwwSEo+sHv8EIt1ToPwApxh7XWdqe+2zXTQAJg=;
        b=UIdaHUO+BoWcQ9GC7GX5DudWgvYXqmXWx3ZblX9PNNlDNq5NjSZBVh8+XGEwtXFmqW2A5w
        eYFYG4RjG/vqPYYX9wWJCGAsSegxrxQLj0cozTdsoDVIBIsnw+KmeqPsrvBiI01jHlx6PI
        ZigeeyOYWNYJJrbWgrStKa1JL2wt1C4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Q8mviLGMNcKWn9sXq_rfdQ-1; Mon, 20 Jul 2020 05:17:54 -0400
X-MC-Unique: Q8mviLGMNcKWn9sXq_rfdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A6CF1081;
        Mon, 20 Jul 2020 09:17:52 +0000 (UTC)
Received: from krava (unknown [10.40.195.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id 430707303C;
        Mon, 20 Jul 2020 09:17:49 +0000 (UTC)
Date:   Mon, 20 Jul 2020 11:17:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] perf evsel: Don't set
 sample_regs_intr/sample_regs_user for dummy event
Message-ID: <20200720091748.GH760733@krava>
References: <20200720010013.18238-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720010013.18238-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:00:13AM +0800, Jin Yao wrote:
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
> See following code:
> 
> /* in kernel/events/core.c */
> static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
> 
> {
>         ....
>         if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
>             has_extended_regs(event))
>                 ret = -EOPNOTSUPP;
>         ....
> }
> 
> For software dummy event, the PMU should not be set with
> PERF_PMU_CAP_EXTENDED_REGS. But unfortunately now, the dummy
> event has possibility to be set with PERF_REG_EXTENDED_MASK bit.
> 
> In evsel__config, /* tools/perf/util/evsel.c */
> 
> if (opts->sample_intr_regs) {
>         attr->sample_regs_intr = opts->sample_intr_regs;
> }
> 
> If we use -IXMM0, the attr>sample_regs_intr will be set with
> PERF_REG_EXTENDED_MASK bit.
> 
> It doesn't make sense to set attr->sample_regs_intr for a
> software dummy event.
> 
> This patch adds dummy event checking before setting
> attr->sample_regs_intr and attr->sample_regs_user.
> 
> After:
>   # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]
> 
>  v2:
>  ---
>  Rebase to perf/core
> 
> Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9aa51a65593d..11794d3b7879 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1014,12 +1014,14 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	if (callchain && callchain->enabled && !evsel->no_aux_samples)
>  		evsel__config_callchain(evsel, opts, callchain);
>  
> -	if (opts->sample_intr_regs && !evsel->no_aux_samples) {
> +	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
> +	    !evsel__is_dummy_event(evsel)) {

hum, I thought it'd look something like this:

  if (opts->sample_intr_regs && (!evsel->no_aux_samples || !evsel__is_dummy_event(evsel)) 

but I'm not sure how no_aux_samples flag works exactly.. so it might be
correct.. just making sure ;-)

cc-ing Adrian

jirka


>  		attr->sample_regs_intr = opts->sample_intr_regs;
>  		evsel__set_sample_bit(evsel, REGS_INTR);
>  	}
>  
> -	if (opts->sample_user_regs && !evsel->no_aux_samples) {
> +	if (opts->sample_user_regs && !evsel->no_aux_samples &&
> +	    !evsel__is_dummy_event(evsel)) {
>  		attr->sample_regs_user |= opts->sample_user_regs;
>  		evsel__set_sample_bit(evsel, REGS_USER);
>  	}
> -- 
> 2.17.1
> 

