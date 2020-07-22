Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A08220729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595422610;
	bh=+p3ehp6krkw0+YIDLhWVdy5mv6YilgfqJlckKSNRG5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g6VXdcbuRhf0ZKlWXoowRaI83oc7sP8U4J0VXXE6l/gDBtyY/PbLiJlfb8UdDBeQM
	 6fyMk9xlb9KdScvbAdZ90ZNlnFtXpogZGU1Q4oVpvsz0Lb0jP9kzatHFD+1w4b/KQl
	 Vk+L/mqIuAVshUkvvkmNhV1/EIE4uqv5VQd3Htwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbgGVM4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgGVM4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:56:48 -0400
Received: from quaco.ghostprotocols.net (unknown [177.17.3.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AAD20657;
        Wed, 22 Jul 2020 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595422608;
        bh=+p3ehp6krkw0+YIDLhWVdy5mv6YilgfqJlckKSNRG5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gd3C7VBNxzV5ud6AF5UJxa3n3okjV9J/9msxM4Jfnhph48StT19o9ePKqfvTdZyMI
         FYZ9xlfWXuqhjs/9OpxO7m96gbKoi+LhE9RlIYv/1MfDk0Zuv2IIoCs2T326UHf2w/
         n4XgHDOLMny8B7g1nyYho8ckM+2nE+Exv4E/nq88=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 367A4404B1; Wed, 22 Jul 2020 09:56:24 -0300 (-03)
Date:   Wed, 22 Jul 2020 09:56:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 11/15] perf stat: implement control commands handling
Message-ID: <20200722125624.GM77866@kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <3cb8a826-145f-81f4-fcb2-fa20045c6957@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb8a826-145f-81f4-fcb2-fa20045c6957@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 10:05:06AM +0300, Alexey Budankov escreveu:
> 
> Implement handling of 'enable' and 'disable' control commands coming
> from control file descriptor. If poll event splits initiated timeout
> interval then the reminder is calculated and still waited in the
> following evlist__poll() call.

So the cover letter is not preserved in the git history, only going from
the Link tag to the patch series to then lookup the cover letter and
then find examples of each feature, I'll now have to do that and collect
the parts that are needed to test this specific feature implemented in
this specific patch, add the command here so that we can test patch by
patch, please next time try to have the testing steps in each patch.

This way we avoid introducing bisection regressions, as having the set
of instructions only on the cover letter encourages testing only the
whole patchkit, not patch by patch.

Thanks,

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 83 ++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 9d5c503e698f..5280a45af5dc 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -560,9 +560,61 @@ static bool is_target_alive(struct target *_target,
>  	return false;
>  }
>  
> -static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
> +static void process_evlist(struct evlist *evlist, unsigned int interval)
> +{
> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
> +
> +	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
> +		switch (cmd) {
> +		case EVLIST_CTL_CMD_ENABLE:
> +			pr_info(EVLIST_ENABLED_MSG);
> +			if (interval)
> +				process_interval();
> +			break;
> +		case EVLIST_CTL_CMD_DISABLE:
> +			if (interval)
> +				process_interval();
> +			pr_info(EVLIST_DISABLED_MSG);
> +			break;
> +		case EVLIST_CTL_CMD_ACK:
> +		case EVLIST_CTL_CMD_UNSUPPORTED:
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void compute_tts(struct timespec *time_start, struct timespec *time_stop,
> +			int *time_to_sleep)
> +{
> +	int tts = *time_to_sleep;
> +	struct timespec time_diff;
> +
> +	diff_timespec(&time_diff, time_stop, time_start);
> +
> +	tts -= time_diff.tv_sec * MSEC_PER_SEC +
> +	       time_diff.tv_nsec / NSEC_PER_MSEC;
> +
> +	if (tts < 0)
> +		tts = 0;
> +
> +	*time_to_sleep = tts;
> +}
> +
> +static int dispatch_events(bool forks, int timeout, int interval, int *times)
>  {
>  	int child_exited = 0, status = 0;
> +	int time_to_sleep, sleep_time;
> +	struct timespec time_start, time_stop;
> +
> +	if (interval)
> +		sleep_time = interval;
> +	else if (timeout)
> +		sleep_time = timeout;
> +	else
> +		sleep_time = 1000;
> +
> +	time_to_sleep = sleep_time;
>  
>  	while (!done) {
>  		if (forks)
> @@ -573,9 +625,16 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times, st
>  		if (child_exited)
>  			break;
>  
> -		nanosleep(ts, NULL);
> -		if (timeout || handle_interval(interval, times))
> -			break;
> +		clock_gettime(CLOCK_MONOTONIC, &time_start);
> +		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
> +			if (timeout || handle_interval(interval, times))
> +				break;
> +			time_to_sleep = sleep_time;
> +		} else { /* fd revent */
> +			process_evlist(evsel_list, interval);
> +			clock_gettime(CLOCK_MONOTONIC, &time_stop);
> +			compute_tts(&time_start, &time_stop, &time_to_sleep);
> +		}
>  	}
>  
>  	return status;
> @@ -644,7 +703,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	char msg[BUFSIZ];
>  	unsigned long long t0, t1;
>  	struct evsel *counter;
> -	struct timespec ts;
>  	size_t l;
>  	int status = 0;
>  	const bool forks = (argc > 0);
> @@ -653,17 +711,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
> @@ -821,7 +868,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		enable_counters();
>  
>  		if (interval || timeout)
> -			status = dispatch_events(forks, timeout, interval, &times, &ts);
> +			status = dispatch_events(forks, timeout, interval, &times);
>  		if (child_pid != -1) {
>  			if (timeout)
>  				kill(child_pid, SIGTERM);
> @@ -838,7 +885,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			psignal(WTERMSIG(status), argv[0]);
>  	} else {
>  		enable_counters();
> -		status = dispatch_events(forks, timeout, interval, &times, &ts);
> +		status = dispatch_events(forks, timeout, interval, &times);
>  	}
>  
>  	disable_counters();
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
