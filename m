Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A583C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA3720780
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K1OXLz9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCUNlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 09:41:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51608 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgCUNlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 09:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bRhGgZCvp+D4IKpka0PHEQGPnYx9eAOjKg1+y/QaM30=; b=K1OXLz9sfQ+ACTqiK7MkHAVbS5
        026OiPFEg73Ok4OLqafT/rzM84uihbVArbnkF5c/v2xlgIuKYwPr8zV4mBaj66RxUGbNh4a1vXZ4R
        0WwCEMBhNNVrZPJGHH4+IiRoldJLPEiYENMP76yMT8QSaOipQhIpbZJQ2HtgWj3nr2F1tcFxwchVf
        9kxD/XScw4m0J0Iltqviq2nG3F8i4Qh6TyuYCRJGFOiBivACE0Frj6VErT7/gN+uRHJQ1oipJbSPC
        wRLrCRhTLuMLq3geLW+tuZPLclyY8tswQLQZCwu0ew/1PWWd+tAy5e/kB9WU/CKosNCg6JILCc5o5
        gXq2naGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFeMx-0001j7-Kb; Sat, 21 Mar 2020 13:40:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EB89303C41;
        Sat, 21 Mar 2020 14:40:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAB1E28B4E0DE; Sat, 21 Mar 2020 14:40:53 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:40:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test x86: address multiplexing in rdpmc test
Message-ID: <20200321134053.GJ20696@hirez.programming.kicks-ass.net>
References: <20200321001400.245121-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321001400.245121-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 05:14:00PM -0700, Ian Rogers wrote:
> Counters may be being used for pinned or other events which inhibit the
> instruction counter in the test from being scheduled - time_enabled > 0
> but time_running == 0. This causes the test to fail with division by 0.
> Add a sleep loop to ensure that the counter is run before computing
> the count.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/tests/rdpmc.c | 45 ++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
> index 1ea916656a2d..0b0792ae67f7 100644
> --- a/tools/perf/arch/x86/tests/rdpmc.c
> +++ b/tools/perf/arch/x86/tests/rdpmc.c
> @@ -34,19 +34,35 @@ static u64 rdtsc(void)
>  	return low | ((u64)high) << 32;
>  }
>  
> -static u64 mmap_read_self(void *addr)
> +static u64 mmap_read_self(void *addr, bool *error)
>  {
>  	struct perf_event_mmap_page *pc = addr;
> -	u32 seq, idx, time_mult = 0, time_shift = 0;
> +	u32 seq, idx, time_mult = 0, time_shift = 0, sleep_count = 0;
>  	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
>  
> +	*error = false;
>  	do {
> -		seq = pc->lock;
> -		barrier();
> -
> -		enabled = pc->time_enabled;
> -		running = pc->time_running;
> -
> +		do {
> +			seq = pc->lock;
> +			barrier();
> +
> +			enabled = pc->time_enabled;
> +			running = pc->time_running;
> +
> +			if (running == 0) {

This is not in fact the condition the Changelog calls out.

> +				/*
> +				 * Event hasn't run, this may be caused by
> +				 * multiplexing.
> +				 */
> +				sleep_count++;
> +				if (sleep_count > 60) {
> +					pr_err("Event failed to run. Are higher priority counters being sampled by a different process?\n");
> +					*error = true;
> +					return 0;
> +				}
> +				sleep(1);
> +			}
> +		} while (running == 0);


Also, I would much prefer this test to be in the caller of this
function, and not deface this function.

I'd prefer this function to stay representative of the outlines in
uapi/linux/perf_event.h and an example of how to actually use it.

>  		if (enabled != running) {
>  			cyc = rdtsc();
>  			time_mult = pc->time_mult;
> @@ -131,13 +147,22 @@ static int __test__rdpmc(void)
>  
>  	for (n = 0; n < 6; n++) {
>  		u64 stamp, now, delta;
> +		bool error;
>  
> -		stamp = mmap_read_self(addr);
> +		stamp = mmap_read_self(addr, &error);
> +		if (error) {
> +			delta_sum = 0;
> +			goto out_close;
> +		}
>  
>  		for (i = 0; i < loops; i++)
>  			tmp++;
>  
> -		now = mmap_read_self(addr);
> +		now = mmap_read_self(addr, &error);
> +		if (error) {
> +			delta_sum = 0;
> +			goto out_close;
> +		}
>  		loops *= 10;
>  
>  		delta = now - stamp;
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
