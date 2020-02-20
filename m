Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8E8C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E113F208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582236886;
	bh=J2MbCfDonS40wmJOh8r+oHYwakryQX/yycWiGDWskUg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=mkbGvJzs5amezUq7gYshfWfUPZybjf8cfCoufWEEu3kD7MUIoRhunCADKpO3p38sS
	 FTOxd4R8R7D8zzwDMXF7lNTZxtyha8xp/3vJf49TUgtWPPkb4YegvrQq9KzU1Ns3D1
	 FcKlqeaqVGxvkkbv/NoNLioqoU8p2M+IsRRwRD7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgBTWOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgBTWOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:14:44 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A3120801;
        Thu, 20 Feb 2020 22:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582236883;
        bh=J2MbCfDonS40wmJOh8r+oHYwakryQX/yycWiGDWskUg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MTde41gyYbD+sUfPQFSv8Y/6emGpb9mikERB87npYST3qcYwUbFGYXO/6nV+tU5Xt
         0IAAH3BKnqx3PgAYJa6Q8iCSV8HqGhmec4L1MBom5sh/lQBw+9/Fyono34ABsM7/3U
         PAwADHx9wrEcIcz8wWRthAW/9oUQQ1txU8S9bdfY=
Message-ID: <1582236880.12738.5.camel@kernel.org>
Subject: Re: [PATCH] tracing: Have synthetic event test use
 raw_smp_processor_id()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>
Date:   Thu, 20 Feb 2020 16:14:40 -0600
In-Reply-To: <20200220162950.35162579@gandalf.local.home>
References: <20200220162950.35162579@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2020-02-20 at 16:29 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The test code that tests synthetic event creation pushes in as one of
> its
> test fields the current CPU using "smp_processor_id()". As this is
> just
> something to see if the value is correctly passed in, and the actual
> CPU
> used does not matter, use raw_smp_processor_id(), otherwise with
> debug
> preemption enabled, a warning happens as the smp_processor_id() is
> called
> without preemption enabled.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Makes sense - I guess it's simpler than Masami's and fine for this
purpose.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom

> ---
>  kernel/trace/synth_event_gen_test.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/synth_event_gen_test.c
> b/kernel/trace/synth_event_gen_test.c
> index 6866280a9b10..7d56d621ffea 100644
> --- a/kernel/trace/synth_event_gen_test.c
> +++ b/kernel/trace/synth_event_gen_test.c
> @@ -114,7 +114,7 @@ static int __init test_gen_synth_cmd(void)
>  	vals[1] = (u64)(long)"hula hoops";	/* next_comm_field
> */
>  	vals[2] = 1000000;		/* ts_ns */
>  	vals[3] = 1000;			/* ts_ms */
> -	vals[4] = smp_processor_id();	/* cpu */
> +	vals[4] = raw_smp_processor_id(); /* cpu */
>  	vals[5] = (u64)(long)"thneed";	/* my_string_field */
>  	vals[6] = 598;			/* my_int_field */
>  
> @@ -221,7 +221,7 @@ static int __init test_empty_synth_event(void)
>  	vals[1] = (u64)(long)"tiddlywinks";	/*
> next_comm_field */
>  	vals[2] = 1000000;		/* ts_ns */
>  	vals[3] = 1000;			/* ts_ms */
> -	vals[4] = smp_processor_id();	/* cpu */
> +	vals[4] = raw_smp_processor_id(); /* cpu */
>  	vals[5] = (u64)(long)"thneed_2.0";	/* my_string_field
> */
>  	vals[6] = 399;			/* my_int_field */
>  
> @@ -293,7 +293,7 @@ static int __init test_create_synth_event(void)
>  	vals[1] = (u64)(long)"tiddlywinks";	/*
> next_comm_field */
>  	vals[2] = 1000000;		/* ts_ns */
>  	vals[3] = 1000;			/* ts_ms */
> -	vals[4] = smp_processor_id();	/* cpu */
> +	vals[4] = raw_smp_processor_id(); /* cpu */
>  	vals[5] = (u64)(long)"thneed";	/* my_string_field */
>  	vals[6] = 398;			/* my_int_field */
>  
> @@ -345,7 +345,7 @@ static int __init test_add_next_synth_val(void)
>  		goto out;
>  
>  	/* cpu */
> -	ret = synth_event_add_next_val(smp_processor_id(),
> &trace_state);
> +	ret = synth_event_add_next_val(raw_smp_processor_id(),
> &trace_state);
>  	if (ret)
>  		goto out;
>  
> @@ -388,7 +388,7 @@ static int __init test_add_synth_val(void)
>  	if (ret)
>  		goto out;
>  
> -	ret = synth_event_add_val("cpu", smp_processor_id(),
> &trace_state);
> +	ret = synth_event_add_val("cpu", raw_smp_processor_id(),
> &trace_state);
>  	if (ret)
>  		goto out;
>  
> @@ -427,7 +427,7 @@ static int __init test_trace_synth_event(void)
>  				(u64)(long)"clackers",	/*
> next_comm_field */
>  				(u64)1000000,		/*
> ts_ns */
>  				(u64)1000,		/* ts_ms
> */
> -				(u64)smp_processor_id(),/* cpu */
> +				(u64)raw_smp_processor_id(), /* cpu
> */
>  				(u64)(long)"Thneed",	/*
> my_string_field */
>  				(u64)999);		/*
> my_int_field */
>  	return ret;
