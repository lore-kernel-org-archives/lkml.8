Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18103C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6AF214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596829420;
	bh=Ftdhsb3H6qJhQyahdeeBWTcthc7Mzk8dcuLldkGb378=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XAAx0iFYFx8kS4/ceH2qoFD26wuG4yRxEvrV97b2hUDPKmwtndwp3C93GSJdU/N4b
	 Rlk1rG9Gr+92lebGTFnrpo+iGbLSjbvQiujd+VyA/8pRh5Vx2ncKgC9gWIS9LjEl86
	 jbLsfuZRulz0pXGGmcwii3dgFoZo/CFvNc9uWJu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHGTnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGTnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:43:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9ADD2075A;
        Fri,  7 Aug 2020 19:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596829418;
        bh=Ftdhsb3H6qJhQyahdeeBWTcthc7Mzk8dcuLldkGb378=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtfxNr9mJ2tWhxlG8dwrnOZLjiyvkhvObekOHJ0x8LenMLLxDVeDnNbb+vqfTKdGk
         jYqKF6epR0+rUxvsYYvcudj1e7DPfXmXPY9p9rXrqiNGDmz2JCMCY8cnZlo5HcJeJT
         xofPKsBVK19yXBsNXbC+OMMEmTep+uybJlBHI0LQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0377C40481; Fri,  7 Aug 2020 16:43:36 -0300 (-03)
Date:   Fri, 7 Aug 2020 16:43:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH 1/2] perf sched: Prefer sched_waking event when it exists
Message-ID: <20200807194335.GF2456573@kernel.org>
References: <20200807164844.44870-1-dsahern@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807164844.44870-1-dsahern@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 07, 2020 at 10:48:44AM -0600, David Ahern escreveu:
> Commit fbd705a0c618 ("sched: Introduce the 'trace_sched_waking' tracepoint")
> added sched_waking tracepoint which should be preferred over sched_wakeup
> when analyzing scheduling delays.
> 
> Update 'perf sched record' to collect sched_waking events if it exists
> and fallback to sched_wakeup if it does not. Similarly, update timehist
> command to skip sched_wakeup events if the session includes
> sched_waking (ie., sched_waking is preferred over sched_wakeup).
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  tools/perf/builtin-sched.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 459e4229945e..0c7d599fa555 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2398,6 +2398,15 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
>  	printf("\n");
>  }
>  
> +static int timehist_sched_wakeup_ignore(struct perf_tool *tool __maybe_unused,
> +					union perf_event *event __maybe_unused,
> +					struct evsel *evsel __maybe_unused,
> +					struct perf_sample *sample __maybe_unused,
> +					struct machine *machine __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  static int timehist_sched_wakeup_event(struct perf_tool *tool,
>  				       union perf_event *event __maybe_unused,
>  				       struct evsel *evsel,
> @@ -2958,9 +2967,10 @@ static int timehist_check_attr(struct perf_sched *sched,
>  
>  static int perf_sched__timehist(struct perf_sched *sched)
>  {
> -	const struct evsel_str_handler handlers[] = {
> +	struct evsel_str_handler handlers[] = {
>  		{ "sched:sched_switch",       timehist_sched_switch_event, },
>  		{ "sched:sched_wakeup",	      timehist_sched_wakeup_event, },
> +		{ "sched:sched_waking",       timehist_sched_wakeup_event, },
>  		{ "sched:sched_wakeup_new",   timehist_sched_wakeup_event, },
>  	};
>  	const struct evsel_str_handler migrate_handlers[] = {
> @@ -3018,6 +3028,11 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  
>  	setup_pager();
>  
> +	/* prefer sched_waking if it is captured */
> +	if (perf_evlist__find_tracepoint_by_name(session->evlist,
> +						  "sched:sched_waking"))
> +		handlers[1].handler = timehist_sched_wakeup_ignore;
> +


ouch, can't we figure out if its present and then don't ask for the
wakeup one to be recorded?

- Arnaldo

>  	/* setup per-evsel handlers */
>  	if (perf_session__set_tracepoints_handlers(session, handlers))
>  		goto out;
> @@ -3330,12 +3345,16 @@ static int __cmd_record(int argc, const char **argv)
>  		"-e", "sched:sched_stat_iowait",
>  		"-e", "sched:sched_stat_runtime",
>  		"-e", "sched:sched_process_fork",
> -		"-e", "sched:sched_wakeup",
>  		"-e", "sched:sched_wakeup_new",
>  		"-e", "sched:sched_migrate_task",
>  	};
> +	struct tep_event *waking_event;
>  
> -	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
> +	/*
> +	 * +2 for either "-e", "sched:sched_wakeup" or
> +	 * "-e", "sched:sched_waking"
> +	 */
> +	rec_argc = ARRAY_SIZE(record_args) + 2 + argc - 1;
>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
>  
>  	if (rec_argv == NULL)
> @@ -3344,6 +3363,13 @@ static int __cmd_record(int argc, const char **argv)
>  	for (i = 0; i < ARRAY_SIZE(record_args); i++)
>  		rec_argv[i] = strdup(record_args[i]);
>  
> +	rec_argv[i++] = "-e";
> +	waking_event = trace_event__tp_format("sched", "sched_waking");
> +	if (!IS_ERR(waking_event))
> +		rec_argv[i++] = strdup("sched:sched_waking");
> +	else
> +		rec_argv[i++] = strdup("sched:sched_wakeup");
> +
>  	for (j = 1; j < (unsigned int)argc; j++, i++)
>  		rec_argv[i] = argv[j];
>  
> -- 
> 2.17.1
> 

-- 

- Arnaldo
