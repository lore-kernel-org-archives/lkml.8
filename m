Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357DCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1034E207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETImlPnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETMjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:39:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52006 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbgETMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589978337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6IxJUaY43QkE35Obl82njYGSv+t+Pu46kA9gMEngx7s=;
        b=ETImlPnR8RN/eyLRU6+T+tlQIuDW4EM5g3lwT0Q5bumJKxOnRkUDhG+r5IUwC7vBD5F0an
        zwxaqaD936cvgqsqFJxTH0ieBqS8wkpnFN847B/DSSE8I9m2jZZUfTfSuL9udtSt6HnOJe
        tpZ+++x/yOtq9urB3gddLnH4ILTxNUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-wpClntVhOFurX1hZrVuPCw-1; Wed, 20 May 2020 08:38:54 -0400
X-MC-Unique: wpClntVhOFurX1hZrVuPCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E131F108C309;
        Wed, 20 May 2020 12:38:52 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1EF8525277;
        Wed, 20 May 2020 12:38:50 +0000 (UTC)
Date:   Wed, 20 May 2020 14:38:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/9] perf stat: factor out event handling loop into a
 function
Message-ID: <20200520123850.GI157452@krava>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <dcb0b0f5-4c92-3027-a508-c3946c51f3d1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb0b0f5-4c92-3027-a508-c3946c51f3d1@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:00:47AM +0300, Alexey Budankov wrote:
> 
> Factor out event handling loop into handle_events() function.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 85 +++++++++++++++++++++++----------------
>  1 file changed, 50 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e0c1ad23c768..9775b0905146 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -371,6 +371,16 @@ static void process_interval(void)
>  	print_counters(&rs, 0, NULL);
>  }
>  
> +static bool print_interval_and_stop(struct perf_stat_config *config, int *times)
> +{
> +	if (config->interval) {
> +		process_interval();
> +		if (interval_count && !(--(*times)))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static void enable_counters(void)
>  {
>  	if (stat_config.initial_delay)
> @@ -436,6 +446,42 @@ static bool is_target_alive(struct target *_target,
>  	return false;
>  }
>  
> +static int handle_events(pid_t pid, struct perf_stat_config *config)
> +{
> +	pid_t child = 0;
> +	bool res, stop = false;
> +	struct timespec time_to_sleep;
> +	int sleep_time, status = 0, times = config->times;
> +
> +	if (config->interval)
> +		sleep_time = config->interval;
> +	else if (config->timeout)
> +		sleep_time = config->timeout;
> +	else
> +		sleep_time = 1000;
> +
> +	time_to_sleep.tv_sec  = sleep_time / MSEC_PER_SEC;
> +	time_to_sleep.tv_nsec = (sleep_time % MSEC_PER_SEC) * NSEC_PER_MSEC;
> +
> +	do {
> +		if (pid != -1)
> +			child = waitpid(pid, &status, WNOHANG);
> +		if (child || stop || done)
> +			break;
> +		nanosleep(&time_to_sleep, NULL);
> +		if (pid == -1)
> +			stop = !is_target_alive(&target, evsel_list->core.threads);
> +		if (config->timeout) {
> +			stop = !stop ? true : stop;
> +		} else {
> +			res = print_interval_and_stop(config, &times);
> +			stop = !stop ? res : stop;
> +		}
> +	} while (1);
> +
> +	return status;
> +}
> +
>  enum counter_recovery {
>  	COUNTER_SKIP,
>  	COUNTER_RETRY,
> @@ -494,12 +540,10 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>  	int interval = stat_config.interval;
> -	int times = stat_config.times;
>  	int timeout = stat_config.timeout;
>  	char msg[BUFSIZ];
>  	unsigned long long t0, t1;
>  	struct evsel *counter;
> -	struct timespec ts;
>  	size_t l;
>  	int status = 0;
>  	const bool forks = (argc > 0);
> @@ -508,17 +552,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	int i, cpu;
>  	bool second_pass = false;
>  
> -	if (interval) {
> -		ts.tv_sec  = interval / USEC_PER_MSEC;
> -		ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
> -	} else if (timeout) {
> -		ts.tv_sec  = timeout / USEC_PER_MSEC;
> -		ts.tv_nsec = (timeout % USEC_PER_MSEC) * NSEC_PER_MSEC;
> -	} else {
> -		ts.tv_sec  = 1;
> -		ts.tv_nsec = 0;
> -	}
> -
>  	if (forks) {
>  		if (perf_evlist__prepare_workload(evsel_list, &target, argv, is_pipe,
>  						  workload_exec_failed_signal) < 0) {
> @@ -675,16 +708,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		perf_evlist__start_workload(evsel_list);
>  		enable_counters();
>  
> -		if (interval || timeout) {
> -			while (!waitpid(child_pid, &status, WNOHANG)) {
> -				nanosleep(&ts, NULL);
> -				if (timeout)
> -					break;
> -				process_interval();
> -				if (interval_count && !(--times))
> -					break;
> -			}
> -		}
> +		if (interval || timeout)
> +			handle_events(child_pid, &stat_config);
> +
>  		if (child_pid != -1) {
>  			if (timeout)
>  				kill(child_pid, SIGTERM);
> @@ -701,18 +727,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			psignal(WTERMSIG(status), argv[0]);
>  	} else {
>  		enable_counters();
> -		while (!done) {
> -			nanosleep(&ts, NULL);
> -			if (!is_target_alive(&target, evsel_list->core.threads))
> -				break;
> -			if (timeout)
> -				break;
> -			if (interval) {
> -				process_interval();
> -				if (interval_count && !(--times))
> -					break;
> -			}
> -		}
> +		handle_events(-1, &stat_config);

this makes me worried.. I'm not sure if it's good idea
to squash these 2 looops into one, because they are already
complex as they are.. and one of you following patches is
making it even more complex

wouldn't it be better if you just add single call into
each of them.. that would poll on your fd and process the
commands if needed?

jirka

