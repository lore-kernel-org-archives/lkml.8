Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF74CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BDD206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFoewix3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbgDBOSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:18:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38260 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729213AbgDBOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585837080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGk/XdTx2AmaoUi8dVZJyPw/8pIQ5+8d5IHVPpIgBvk=;
        b=dFoewix3GVlhLi/47Sj8tyeUuiIYj7tg5x8LXA6f/g0rV1AJPVy+S42QcInjzXlOoq/sBH
        a5CtbjhVIbvZlnrNff02jhd6KAa1wcOcpp+9sGIq9delQxSO4Oel+vvZIo+YPqT7m9TZ6x
        /6SL0IpQpxdu2Okylu5YitU10G8+i4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-EuI1sNs8MkOs_7zZZeWt6Q-1; Thu, 02 Apr 2020 10:17:58 -0400
X-MC-Unique: EuI1sNs8MkOs_7zZZeWt6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71861801A22;
        Thu,  2 Apr 2020 14:17:44 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A18B999E08;
        Thu,  2 Apr 2020 14:17:42 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:17:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/8] perf stat: implement resume and pause control
 commands handling
Message-ID: <20200402141740.GO2518490@krava>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
 <20afb83b-efc4-6cba-6512-eebbb4e0707a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20afb83b-efc4-6cba-6512-eebbb4e0707a@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:48:31AM +0300, Alexey Budankov wrote:

SNIP

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
> @@ -688,18 +745,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
> -		if (child_pid != -1)
> +		if (stat_config.ctl_fd == -1 && !interval && !timeout)
>  			wait4(child_pid, &status, 0, &stat_config.ru_data);
> +		else
> +			status = handle_events(child_pid, &stat_config);
>  
>  		if (workload_exec_errno) {
>  			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
> @@ -711,18 +760,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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

could you please separate the change to have:
  - factor out the above too loops to the new function
  - adding control fds handling to that function

so it's more obvious we don't break anything

thanks,
jirka

> +		handle_events(-1, &stat_config);
>  	}
>  
>  	disable_counters();
> -- 
> 2.24.1
> 
> 

