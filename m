Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF558C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69E820774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvZY0azN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbgFWO4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:56:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27879 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732738AbgFWO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592924196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Bn+y4sHPaKs2wU0UDQKlfOxuLp1yeknEE+KAprK6ac=;
        b=gvZY0azNG2xHiAPQQvdPxsSafmDWJyGAtmZ8/Pu94lr8csUFtGk9Jq5LJRig7l4WsSBjam
        IrC7uepJjPJ0Q2zDUe5TCiMItkbA9pfbp6IaBCN+WC/Nn+I3FXWyiMvtFHHiKG/MMWtnHA
        YZ8iZFq56mGdBRBob+gkOW7zabMVJaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-PhkIi-_OO9-PO5leTvxboA-1; Tue, 23 Jun 2020 10:56:35 -0400
X-MC-Unique: PhkIi-_OO9-PO5leTvxboA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D44193F56A;
        Tue, 23 Jun 2020 14:56:33 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2739D7CCF9;
        Tue, 23 Jun 2020 14:56:30 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:56:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 04/13] perf stat: factor out body of event handling
 loop for system wide
Message-ID: <20200623145630.GK2619137@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <eeeff629-925a-530b-9803-f274337ae473@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeeff629-925a-530b-9803-f274337ae473@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:37:43AM +0300, Alexey Budankov wrote:
> 
> Introduce process_timeout() and process_interval() functions that
> factor out body of event handling loop for attach and system wide
> monitoring use cases.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 9be020e0098a..31f7ccf9537b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -475,6 +475,23 @@ static void process_interval(void)
>  	print_counters(&rs, 0, NULL);
>  }
>  
> +static bool print_interval(unsigned int interval, int *times)
> +{
> +	if (interval) {
> +		process_interval();
> +		if (interval_count && !(--(*times)))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool process_timeout(int timeout, unsigned int interval, int *times)
> +{
> +	if (timeout)
> +		return true;
> +	return print_interval(interval, times);
> +}

I think it's confusing to keep this together, that
process_timeout triggers also interval processing

I think you can keep the timeout separated from interval
processing and rename the print_interval to process_interval
and process_interval to __process_interval

jirka

> +
>  static void enable_counters(void)
>  {
>  	if (stat_config.initial_delay)
> @@ -611,6 +628,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	struct affinity affinity;
>  	int i, cpu;
>  	bool second_pass = false;
> +	bool stop = false;
>  
>  	if (interval) {
>  		ts.tv_sec  = interval / USEC_PER_MSEC;
> @@ -805,17 +823,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			psignal(WTERMSIG(status), argv[0]);
>  	} else {
>  		enable_counters();
> -		while (!done) {
> +		while (!done && !stop) {
>  			nanosleep(&ts, NULL);
>  			if (!is_target_alive(&target, evsel_list->core.threads))
>  				break;
> -			if (timeout)
> -				break;
> -			if (interval) {
> -				process_interval();
> -				if (interval_count && !(--times))
> -					break;
> -			}
> +			stop = process_timeout(timeout, interval, &times);
>  		}
>  	}
>  
> -- 
> 2.24.1
> 
> 

