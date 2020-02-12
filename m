Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D871DC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA93206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv9y+yX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgBLVXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:23:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45523 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:23:34 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so3924650ioi.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBm9jxOJKL7K7mfSdijnyS76NCTNuRhJsOM5JP08Eas=;
        b=nv9y+yX1IZ/rwss4NpvZsqIliszqPX2AnIFUCdAf/wFKvnZAHwcySO3rLDf9CLQH+c
         AMlr2DWfrJNHMGDah/5SCupEn2VvmMYiveR2kC2dMQgneA8h9NCWVeGbCuvoeB5JV62d
         LMh8dMRnXvajXO8rZrxn8LOrd8skv4pKzzU/qoygDE5IKFhJu3+50KjfPgWB5h4kXgnS
         eJX8gVHGnLBZmoVUwTCGTYTCxV0hHkv+udHGsszVAoKVDZVCokstWeDzhKK2C3Qm16cN
         H2vFpiXLkSPx9F4LuNrrUd7TcKMzKTwUrmq53nZbEaS3nCPuz2H0nE4bl2EbynbvQhiH
         /GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBm9jxOJKL7K7mfSdijnyS76NCTNuRhJsOM5JP08Eas=;
        b=qh85VypMxjAvqIKHhcOIWYcmU/XGNyf+RxyJwOzpUQST24OomrotA1KwpDYRsPHxrO
         3slpAKRSM41ySKQmeZ5jgVGsmyFh+/MJMr14oWPpoD8r1vjwGSPUCCSw6RlqdqKsb7h4
         pt+eBtDMwTmy4Y8rsdagrClz8srCvWKyEhJr9lg2KwOl7yylXX8i5KRSqsglt2IVV/ir
         hRCzI++PqPJdnFljD83JsnSO6jnL5HXir5GuUcHZuz+N5ifPHFrF2itah456BWWc/SC7
         e1MBgbVdujYUKRAab8VV2eea2vA0EulIkH1Gbc5WLiGp0fy9bzvLGb/PicuC5AYNPvqr
         Xxyw==
X-Gm-Message-State: APjAAAWyQcM3C6FBaX3Qot5p008xyo0wScOS+efTUdNJsqSh4wKthVlt
        3FCRFcAZ8QmlUEh1Mvo+8UU=
X-Google-Smtp-Source: APXvYqwbMTdcNvWtqAFcfoqxESf5iJVueiPGNL3jl2sowFmgkFIsxbAiMus20JLU3DcrcN2TemP+qw==
X-Received: by 2002:a6b:6018:: with SMTP id r24mr17383373iog.284.1581542613851;
        Wed, 12 Feb 2020 13:23:33 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:3:ceb0:468:9cb0:2637:feaf])
        by smtp.googlemail.com with ESMTPSA id j17sm83418ild.45.2020.02.12.13.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 13:23:33 -0800 (PST)
Message-ID: <1581542611.25773.7.camel@gmail.com>
Subject: Re: [PATCH v2] tracing: Remove bogus 64-bit synth_event_trace()
 vararg assumption
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Date:   Wed, 12 Feb 2020 15:23:31 -0600
In-Reply-To: <20200212160859.705723d2@gandalf.local.home>
References: <1581538382.25773.5.camel@gmail.com>
         <20200212160859.705723d2@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2020-02-12 at 16:08 -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 14:13:02 -0600
> Tom Zanussi <tzanussi@gmail.com> wrote:
> 
> > The vararg code in synth_event_trace() assumed the args were 64 bit
> > which is not the case on 32-bit systems.  Just use long which
> > should
> > work on every system.
> > 
> > Also remove all the u64 casts from the synth event test module,
> > which
> > also cause compile warnings on 32-bit compiles.
> > 
> > This fixes the bug reported by the kernel test robot/Rong Chen as
> > reported here:
> > 
> > https://lore.kernel.org/lkml/20200212113444.GS12867@shao2-debian/
> > 
> > With this commit, the lkp-tests tests now pass, as do the
> > synth/kprobe
> > event test modules and selftests on x86_64.
> 
> Did you test this on 32 bit? I just ran it on a 32 bit kernel, and I
> get this in the tracing output:

I did run it through the 32-bit lkp-tests, but couldn't figure out how
to get a shell to look at the output.

It looks like the output is fine, just some (null)s being printed that
shouldn't be.  I'll look into it..

Tom

> 
>         modprobe-1731  [003] ....   919.039758: gen_synth_test:
> next_pid_field=777(null)next_comm_field=hula hoops ts_ns=1000000
> ts_ms=1000 cpu=3(null)my_string_field=thneed my_int_field=598(null)
>         modprobe-1731  [003] ....   919.039904: empty_synth_test:
> next_pid_field=777(null)next_comm_field=tiddlywinks ts_ns=1000000
> ts_ms=1000 cpu=3(null)my_string_field=thneed_2.0
> my_int_field=399(null)
>         modprobe-1731  [003] ....   919.040055: create_synth_test:
> next_pid_field=777(null)next_comm_field=tiddlywinks ts_ns=1000000
> ts_ms=1000 cpu=3(null)my_string_field=thneed my_int_field=398(null)
>         modprobe-1731  [003] ....   919.040055: gen_synth_test:
> next_pid_field=777(null)next_comm_field=slinky ts_ns=1000000
> ts_ms=1000 cpu=3(null)my_string_field=thneed_2.01
> my_int_field=395(null)
>         modprobe-1731  [003] ....   919.040056: gen_synth_test:
> next_pid_field=777(null)next_comm_field=silly putty ts_ns=1000000
> ts_ms=1000 cpu=3(null)my_string_field=thneed_9
> my_int_field=3999(null)
>         modprobe-1731  [003] ....   919.040057: create_synth_test:
> next_pid_field=444(null)next_comm_field=clackers ts_ns=1000000
> ts_ms=1000 cpu=3(null)my_string_field=Thneed my_int_field=999(null)
> 
> -- Steve
> 
> > 
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  kernel/trace/synth_event_gen_test.c | 24 ++++++++++++------------
> >  kernel/trace/trace_events_hist.c    |  6 +++---
> >  2 files changed, 15 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/trace/synth_event_gen_test.c
> > b/kernel/trace/synth_event_gen_test.c
> > index 4aefe003cb7c..f0e14106048c 100644
> > --- a/kernel/trace/synth_event_gen_test.c
> > +++ b/kernel/trace/synth_event_gen_test.c
> > @@ -111,11 +111,11 @@ static int __init test_gen_synth_cmd(void)
> >  	/* Create some bogus values just for testing */
> >  
> >  	vals[0] = 777;			/* next_pid_field */
> > -	vals[1] = (u64)"hula hoops";	/* next_comm_field */
> > +	vals[1] = (long)"hula hoops";	/* next_comm_field */
> >  	vals[2] = 1000000;		/* ts_ns */
> >  	vals[3] = 1000;			/* ts_ms */
> >  	vals[4] = smp_processor_id();	/* cpu */
> > -	vals[5] = (u64)"thneed";	/* my_string_field */
> > +	vals[5] = (long)"thneed";	/* my_string_field */
> >  	vals[6] = 598;			/* my_int_field */
> >  
> >  	/* Now generate a gen_synth_test event */
> > @@ -218,11 +218,11 @@ static int __init
> > test_empty_synth_event(void)
> >  	/* Create some bogus values just for testing */
> >  
> >  	vals[0] = 777;			/* next_pid_field */
> > -	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
> > +	vals[1] = (long)"tiddlywinks";	/* next_comm_field
> > */
> >  	vals[2] = 1000000;		/* ts_ns */
> >  	vals[3] = 1000;			/* ts_ms */
> >  	vals[4] = smp_processor_id();	/* cpu */
> > -	vals[5] = (u64)"thneed_2.0";	/* my_string_field */
> > +	vals[5] = (long)"thneed_2.0";	/* my_string_field */
> >  	vals[6] = 399;			/* my_int_field */
> >  
> >  	/* Now trace an empty_synth_test event */
> > @@ -290,11 +290,11 @@ static int __init
> > test_create_synth_event(void)
> >  	/* Create some bogus values just for testing */
> >  
> >  	vals[0] = 777;			/* next_pid_field */
> > -	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
> > +	vals[1] = (long)"tiddlywinks";	/* next_comm_field
> > */
> >  	vals[2] = 1000000;		/* ts_ns */
> >  	vals[3] = 1000;			/* ts_ms */
> >  	vals[4] = smp_processor_id();	/* cpu */
> > -	vals[5] = (u64)"thneed";	/* my_string_field */
> > +	vals[5] = (long)"thneed";	/* my_string_field */
> >  	vals[6] = 398;			/* my_int_field */
> >  
> >  	/* Now generate a create_synth_test event */
> > @@ -330,7 +330,7 @@ static int __init test_add_next_synth_val(void)
> >  		goto out;
> >  
> >  	/* next_comm_field */
> > -	ret = synth_event_add_next_val((u64)"slinky",
> > &trace_state);
> > +	ret = synth_event_add_next_val((long)"slinky",
> > &trace_state);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -350,7 +350,7 @@ static int __init test_add_next_synth_val(void)
> >  		goto out;
> >  
> >  	/* my_string_field */
> > -	ret = synth_event_add_next_val((u64)"thneed_2.01",
> > &trace_state);
> > +	ret = synth_event_add_next_val((long)"thneed_2.01",
> > &trace_state);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -396,12 +396,12 @@ static int __init test_add_synth_val(void)
> >  	if (ret)
> >  		goto out;
> >  
> > -	ret = synth_event_add_val("next_comm_field", (u64)"silly
> > putty",
> > +	ret = synth_event_add_val("next_comm_field", (long)"silly
> > putty",
> >  				  &trace_state);
> >  	if (ret)
> >  		goto out;
> >  
> > -	ret = synth_event_add_val("my_string_field",
> > (u64)"thneed_9",
> > +	ret = synth_event_add_val("my_string_field",
> > (long)"thneed_9",
> >  				  &trace_state);
> >  	if (ret)
> >  		goto out;
> > @@ -424,11 +424,11 @@ static int __init
> > test_trace_synth_event(void)
> >  	/* Trace some bogus values just for testing */
> >  	ret = synth_event_trace(create_synth_test, 7,	/*
> > number of values */
> >  				444,			/*
> > next_pid_field */
> > -				(u64)"clackers",	/*
> > next_comm_field */
> > +				"clackers",		/*
> > next_comm_field */
> >  				1000000,		/* ts_ns
> > */
> >  				1000,			/*
> > ts_ms */
> >  				smp_processor_id(),	/* cpu
> > */
> > -				(u64)"Thneed",		/*
> > my_string_field */
> > +				"Thneed",		/*
> > my_string_field */
> >  				999);			/*
> > my_int_field */
> >  	return ret;
> >  }
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index 483b3fd1094f..b8dd28f546d8 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -1887,12 +1887,12 @@ int synth_event_trace(struct
> > trace_event_file *file, unsigned int n_vals, ...)
> >  
> >  	va_start(args, n_vals);
> >  	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
> > -		u64 val;
> > +		long val;
> >  
> > -		val = va_arg(args, u64);
> > +		val = va_arg(args, long);
> >  
> >  		if (state.event->fields[i]->is_string) {
> > -			char *str_val = (char *)(long)val;
> > +			char *str_val = (char *)val;
> >  			char *str_field = (char *)&state.entry-
> > >fields[n_u64];
> >  
> >  			strscpy(str_field, str_val,
> > STR_VAR_LEN_MAX);
> 
> 
