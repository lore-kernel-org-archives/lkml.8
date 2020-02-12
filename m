Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B19AC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CDC21739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgBLVJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbgBLVJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:09:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9093121739;
        Wed, 12 Feb 2020 21:09:00 +0000 (UTC)
Date:   Wed, 12 Feb 2020 16:08:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tzanussi@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [PATCH v2] tracing: Remove bogus 64-bit synth_event_trace()
 vararg assumption
Message-ID: <20200212160859.705723d2@gandalf.local.home>
In-Reply-To: <1581538382.25773.5.camel@gmail.com>
References: <1581538382.25773.5.camel@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 14:13:02 -0600
Tom Zanussi <tzanussi@gmail.com> wrote:

> The vararg code in synth_event_trace() assumed the args were 64 bit
> which is not the case on 32-bit systems.  Just use long which should
> work on every system.
> 
> Also remove all the u64 casts from the synth event test module, which
> also cause compile warnings on 32-bit compiles.
> 
> This fixes the bug reported by the kernel test robot/Rong Chen as
> reported here:
> 
> https://lore.kernel.org/lkml/20200212113444.GS12867@shao2-debian/
> 
> With this commit, the lkp-tests tests now pass, as do the synth/kprobe
> event test modules and selftests on x86_64.

Did you test this on 32 bit? I just ran it on a 32 bit kernel, and I
get this in the tracing output:

        modprobe-1731  [003] ....   919.039758: gen_synth_test: next_pid_field=777(null)next_comm_field=hula hoops ts_ns=1000000 ts_ms=1000 cpu=3(null)my_string_field=thneed my_int_field=598(null)
        modprobe-1731  [003] ....   919.039904: empty_synth_test: next_pid_field=777(null)next_comm_field=tiddlywinks ts_ns=1000000 ts_ms=1000 cpu=3(null)my_string_field=thneed_2.0 my_int_field=399(null)
        modprobe-1731  [003] ....   919.040055: create_synth_test: next_pid_field=777(null)next_comm_field=tiddlywinks ts_ns=1000000 ts_ms=1000 cpu=3(null)my_string_field=thneed my_int_field=398(null)
        modprobe-1731  [003] ....   919.040055: gen_synth_test: next_pid_field=777(null)next_comm_field=slinky ts_ns=1000000 ts_ms=1000 cpu=3(null)my_string_field=thneed_2.01 my_int_field=395(null)
        modprobe-1731  [003] ....   919.040056: gen_synth_test: next_pid_field=777(null)next_comm_field=silly putty ts_ns=1000000 ts_ms=1000 cpu=3(null)my_string_field=thneed_9 my_int_field=3999(null)
        modprobe-1731  [003] ....   919.040057: create_synth_test: next_pid_field=444(null)next_comm_field=clackers ts_ns=1000000 ts_ms=1000 cpu=3(null)my_string_field=Thneed my_int_field=999(null)

-- Steve

> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/synth_event_gen_test.c | 24 ++++++++++++------------
>  kernel/trace/trace_events_hist.c    |  6 +++---
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
> index 4aefe003cb7c..f0e14106048c 100644
> --- a/kernel/trace/synth_event_gen_test.c
> +++ b/kernel/trace/synth_event_gen_test.c
> @@ -111,11 +111,11 @@ static int __init test_gen_synth_cmd(void)
>  	/* Create some bogus values just for testing */
>  
>  	vals[0] = 777;			/* next_pid_field */
> -	vals[1] = (u64)"hula hoops";	/* next_comm_field */
> +	vals[1] = (long)"hula hoops";	/* next_comm_field */
>  	vals[2] = 1000000;		/* ts_ns */
>  	vals[3] = 1000;			/* ts_ms */
>  	vals[4] = smp_processor_id();	/* cpu */
> -	vals[5] = (u64)"thneed";	/* my_string_field */
> +	vals[5] = (long)"thneed";	/* my_string_field */
>  	vals[6] = 598;			/* my_int_field */
>  
>  	/* Now generate a gen_synth_test event */
> @@ -218,11 +218,11 @@ static int __init test_empty_synth_event(void)
>  	/* Create some bogus values just for testing */
>  
>  	vals[0] = 777;			/* next_pid_field */
> -	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
> +	vals[1] = (long)"tiddlywinks";	/* next_comm_field */
>  	vals[2] = 1000000;		/* ts_ns */
>  	vals[3] = 1000;			/* ts_ms */
>  	vals[4] = smp_processor_id();	/* cpu */
> -	vals[5] = (u64)"thneed_2.0";	/* my_string_field */
> +	vals[5] = (long)"thneed_2.0";	/* my_string_field */
>  	vals[6] = 399;			/* my_int_field */
>  
>  	/* Now trace an empty_synth_test event */
> @@ -290,11 +290,11 @@ static int __init test_create_synth_event(void)
>  	/* Create some bogus values just for testing */
>  
>  	vals[0] = 777;			/* next_pid_field */
> -	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
> +	vals[1] = (long)"tiddlywinks";	/* next_comm_field */
>  	vals[2] = 1000000;		/* ts_ns */
>  	vals[3] = 1000;			/* ts_ms */
>  	vals[4] = smp_processor_id();	/* cpu */
> -	vals[5] = (u64)"thneed";	/* my_string_field */
> +	vals[5] = (long)"thneed";	/* my_string_field */
>  	vals[6] = 398;			/* my_int_field */
>  
>  	/* Now generate a create_synth_test event */
> @@ -330,7 +330,7 @@ static int __init test_add_next_synth_val(void)
>  		goto out;
>  
>  	/* next_comm_field */
> -	ret = synth_event_add_next_val((u64)"slinky", &trace_state);
> +	ret = synth_event_add_next_val((long)"slinky", &trace_state);
>  	if (ret)
>  		goto out;
>  
> @@ -350,7 +350,7 @@ static int __init test_add_next_synth_val(void)
>  		goto out;
>  
>  	/* my_string_field */
> -	ret = synth_event_add_next_val((u64)"thneed_2.01", &trace_state);
> +	ret = synth_event_add_next_val((long)"thneed_2.01", &trace_state);
>  	if (ret)
>  		goto out;
>  
> @@ -396,12 +396,12 @@ static int __init test_add_synth_val(void)
>  	if (ret)
>  		goto out;
>  
> -	ret = synth_event_add_val("next_comm_field", (u64)"silly putty",
> +	ret = synth_event_add_val("next_comm_field", (long)"silly putty",
>  				  &trace_state);
>  	if (ret)
>  		goto out;
>  
> -	ret = synth_event_add_val("my_string_field", (u64)"thneed_9",
> +	ret = synth_event_add_val("my_string_field", (long)"thneed_9",
>  				  &trace_state);
>  	if (ret)
>  		goto out;
> @@ -424,11 +424,11 @@ static int __init test_trace_synth_event(void)
>  	/* Trace some bogus values just for testing */
>  	ret = synth_event_trace(create_synth_test, 7,	/* number of values */
>  				444,			/* next_pid_field */
> -				(u64)"clackers",	/* next_comm_field */
> +				"clackers",		/* next_comm_field */
>  				1000000,		/* ts_ns */
>  				1000,			/* ts_ms */
>  				smp_processor_id(),	/* cpu */
> -				(u64)"Thneed",		/* my_string_field */
> +				"Thneed",		/* my_string_field */
>  				999);			/* my_int_field */
>  	return ret;
>  }
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 483b3fd1094f..b8dd28f546d8 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1887,12 +1887,12 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
>  
>  	va_start(args, n_vals);
>  	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
> -		u64 val;
> +		long val;
>  
> -		val = va_arg(args, u64);
> +		val = va_arg(args, long);
>  
>  		if (state.event->fields[i]->is_string) {
> -			char *str_val = (char *)(long)val;
> +			char *str_val = (char *)val;
>  			char *str_field = (char *)&state.entry->fields[n_u64];
>  
>  			strscpy(str_field, str_val, STR_VAR_LEN_MAX);

