Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D7AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B065520723
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crE08jZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEaSTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:19:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35071 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbgEaSTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590949151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H5l2+GA2OjPwaydxfjF7lz64I5jkXo+Zpuxtapskr0s=;
        b=crE08jZXf48Es8K8Q/rWo2VlZaGgsjWfO4TUH8zsUF279YrjTgzREysgvavCYp867Kx2v8
        E/8V+rOHKCQlADvpx9nrzvlu3KSEGNX5DmdQ/wObYM7gKGbv6IVQ2aub3xx2q9O1SoTi9i
        dGNffrl7w7N0BgljmemUriUkyCFTq08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376--LOextQ6OU2IdSEVQS_5uw-1; Sun, 31 May 2020 14:19:09 -0400
X-MC-Unique: -LOextQ6OU2IdSEVQS_5uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 816FF107ACCA;
        Sun, 31 May 2020 18:19:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id BDA2A5C1D0;
        Sun, 31 May 2020 18:19:06 +0000 (UTC)
Date:   Sun, 31 May 2020 20:19:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/10] perf stat: factor out event handling loop into
 a function
Message-ID: <20200531181905.GB881900@krava>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
 <5f42c6c5-c301-accd-928e-4304fb1c15d0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f42c6c5-c301-accd-928e-4304fb1c15d0@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:19:45PM +0300, Alexey Budankov wrote:

SNIP

> @@ -544,12 +598,10 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
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
> @@ -558,17 +610,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
> @@ -725,16 +766,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
> +			dispatch_events(child_pid, &stat_config);
> +
>  		if (child_pid != -1) {
>  			if (timeout)
>  				kill(child_pid, SIGTERM);
> @@ -751,18 +785,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
> +		dispatch_events(-1, &stat_config);

hum, from the discussion we had on v3  I expected more smaller patches
with easy changes, so the change is more transparent and easy to review

as I said before this part really makes me worried and needs to be as clear
as possible.. please introdce the new function first and replace the factored
places separately, also more verbose changelog would help ;-)

thanks,
jirka


>  	}
>  
>  	disable_counters();
> -- 
> 2.24.1
> 

