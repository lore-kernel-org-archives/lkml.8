Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EA7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50BC2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939794;
	bh=Y7EH9B4J3pPvRK+Oiyd+RxJJodgxldJeQhf1yPY4zUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XiuR698TntSDXM5jvj6V3aKJ0dPCfPtDLDNvX8fPOlwZJisjknwITutKXn4BWkyrw
	 i9egDng2GLPI3K/o5yXmWzi4WcV81PVtxA3J4+q4XNvSsE8nSZAFOmOeC7vpxGg0AU
	 /3VloUdZbpN3ZeyLN/X0OpEh2TcXY+Zts74Ni7dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgG1Mgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgG1Mgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:36:33 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B39206D7;
        Tue, 28 Jul 2020 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939792;
        bh=Y7EH9B4J3pPvRK+Oiyd+RxJJodgxldJeQhf1yPY4zUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3HAtjNPTZx54UAL4NwcFz9jc44zE5TMgc+W6hjdM+eN9pjKEwlz6GUGao9dQntOJ
         xvB4EpIbzDl2axDAFSsCj0s628tEb04Ia6ktSgzm2BlSY9q2bnXRvzWt6Y5jPh92TS
         gKDo/Pk4siUYrXu893FDAKQAOZtlXSvXVzjm9vDk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A8B8404B1; Tue, 28 Jul 2020 09:36:29 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:36:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 16/19] perf metric: Make compute_single function more
 precise
Message-ID: <20200728123629.GW40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-17-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719181320.785305-17-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 19, 2020 at 08:13:17PM +0200, Jiri Olsa escreveu:
> So far compute_single function relies on the fact, that
> there's only single metric defined within evlist in all
> tests. In following patch we will add test for metric
> group, so we need to be able to compute metric by given
> name.
> 
> Adding the name argument to compute_single and iterating
> evlist and evsel's expression to find the given metric.

Applied, thanks.

Ian, Kajol, I didn't notice your Acked-by or Reviewed-by, like for the
other patches, can you check?

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/parse-metric.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 01370ccb9ed9..5ac32f80f8ea 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -108,17 +108,21 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
>  }
>  
>  static double compute_single(struct rblist *metric_events, struct evlist *evlist,
> -			     struct runtime_stat *st)
> +			     struct runtime_stat *st, const char *name)
>  {
> -	struct evsel *evsel = evlist__first(evlist);
> +	struct metric_expr *mexp;
>  	struct metric_event *me;
> +	struct evsel *evsel;
>  
> -	me = metricgroup__lookup(metric_events, evsel, false);
> -	if (me != NULL) {
> -		struct metric_expr *mexp;
> -
> -		mexp = list_first_entry(&me->head, struct metric_expr, nd);
> -		return test_generic_metric(mexp, 0, st);
> +	evlist__for_each_entry(evlist, evsel) {
> +		me = metricgroup__lookup(metric_events, evsel, false);
> +		if (me != NULL) {
> +			list_for_each_entry (mexp, &me->head, nd) {
> +				if (strcmp(mexp->metric_name, name))
> +					continue;
> +				return test_generic_metric(mexp, 0, st);
> +			}
> +		}
>  	}
>  	return 0.;
>  }
> @@ -162,7 +166,7 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
>  	load_runtime_stat(&st, evlist, vals);
>  
>  	/* And execute the metric */
> -	*ratio = compute_single(&metric_events, evlist, &st);
> +	*ratio = compute_single(&metric_events, evlist, &st, name);
>  
>  	/* ... clenup. */
>  	metricgroup__rblist_exit(&metric_events);
> -- 
> 2.25.4
> 

-- 

- Arnaldo
