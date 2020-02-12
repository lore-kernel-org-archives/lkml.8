Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9232C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD72321739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581538228;
	bh=5tUfKPKeSnEHMpXpar/HVxMpVibvs8mXtMO6HQd8Mt8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=par8pcmBdzoqRLOx5pUTP3s0EyI6ieDrbAvQqgJFQqZ7boVbA1TAbrcHl5qcIFrKp
	 ZgLhMvgi2/e6Rf+n9asCGNe4vXl5LorPAg7NIslYt0u2GY1/aXTY0W7u4e7wA/KgOb
	 IOQKKEL5fzeE66A/ydDrw34+JQk19Y4R33SlBMbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgBLUK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgBLUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:10:27 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE0A021734;
        Wed, 12 Feb 2020 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581538227;
        bh=5tUfKPKeSnEHMpXpar/HVxMpVibvs8mXtMO6HQd8Mt8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k1M/KpjnSNabfpZsKQQ+pjF5h/ws4c/royzSywtlpASUF+715/BAXQ16Xyfy+qM23
         ZGfXmQorlzZH2u5LHHCiD+GOBBz1p2xKpkUXz58v/ZXushPpZuRZoHmB+0fiLwFTdU
         GkZybKnY4d3jPM5+WugjR1l8wGunQ0J6HRtMGW5g=
Message-ID: <1581538225.25773.3.camel@kernel.org>
Subject: Re: [PATCH] tracing: Remove bogus 64-bit synth_event_trace() vararg
  assumption
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Date:   Wed, 12 Feb 2020 14:10:25 -0600
In-Reply-To: <20200212145026.0cbaa86b@gandalf.local.home>
References: <20200212113444.GS12867@shao2-debian>
         <1581523144.8740.8.camel@kernel.org>
         <20200212145026.0cbaa86b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2020-02-12 at 14:50 -0500, Steven Rostedt wrote:
> From: Tom Zanussi <zanussi@kernel.org>
> 
> [ Tom, please send patches normally, and not embedded in a reply.
> Otherwise it will not be picked up by my patchwork, and may be lost.
> ]

Sorry about that.  I just finished getting my 32-bit test system up and
running and this does fix the problem, although I do have an updated
patch that also fixes some compile warnings on 32-bit compiles that I
saw in the test module.

I'll post that as a separate patch, of course.

Tom


> 
> The vararg code in synth_event_trace() assumed the args were 64 bit
> which is not the case on 32 bit systems.  Just use long which should
> work on every system, and remove the u64 casts from the synth event
> test module.
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/synth_event_gen_test.c | 4 ++--
>  kernel/trace/trace_events_hist.c    | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/synth_event_gen_test.c
> b/kernel/trace/synth_event_gen_test.c
> index 4aefe003cb7c..2a7465569a43 100644
> --- a/kernel/trace/synth_event_gen_test.c
> +++ b/kernel/trace/synth_event_gen_test.c
> @@ -424,11 +424,11 @@ static int __init test_trace_synth_event(void)
>  	/* Trace some bogus values just for testing */
>  	ret = synth_event_trace(create_synth_test, 7,	/*
> number of values */
>  				444,			/*
> next_pid_field */
> -				(u64)"clackers",	/*
> next_comm_field */
> +				"clackers",		/*
> next_comm_field */
>  				1000000,		/* ts_ns */
>  				1000,			/*
> ts_ms */
>  				smp_processor_id(),	/* cpu */
> -				(u64)"Thneed",		/*
> my_string_field */
> +				"Thneed",		/*
> my_string_field */
>  				999);			/*
> my_int_field */
>  	return ret;
>  }
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 2fcb755e900a..e65276c3c9d1 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1883,12 +1883,12 @@ int synth_event_trace(struct trace_event_file
> *file, unsigned int n_vals, ...)
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
>  			char *str_field = (char *)&state.entry-
> >fields[n_u64];
>  
>  			strscpy(str_field, str_val,
> STR_VAR_LEN_MAX);
