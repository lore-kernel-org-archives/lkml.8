Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C69C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C739A208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZwbL/7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHTPIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgHTPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:08:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3634C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:08:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so1086821pjx.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=leRL91dpijQABTpkP8SFvrHLfyleP4uKBhEGSA5loJQ=;
        b=LZwbL/7GzwQZVQle4wCju+vZsK90Z9Zo4pdQRYJQ/dBiAMmvit8KeMnddmCVcgQRtI
         DhR+DG2uWNxBnsEN8IWBKoJb9+WZDSJTuGIL3+zIExEMLEQ5PbAA/WeB1G/CehYFqs9w
         3AppOXYN6p27/V9uF8uThmJ16bC2TwwkH5kRFBEjS5djWk+VYLlAKKkDl4zvBGKht+UE
         Nljbft3LgxGxNp4N7wbVfqnMSNjWPpDKDC+mO8cTgOM+jvTnxExuXIP4pHLvVmNhJ71O
         fYo5wwa4U9TOXCxRKh+AlKJHAV9me/Uotlu9SY4BhnkkdJCIhV+T8Bfwe02id0guZ0Aj
         cX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=leRL91dpijQABTpkP8SFvrHLfyleP4uKBhEGSA5loJQ=;
        b=it2ESembVQn00Qz+aCLdVYNVydNNozCo3SNdAi3QVg+ofD/pNhuJrgIHxy9tmP62hr
         0jFloJkd6UsAivB+S0VsQkUlJTxwe50zYGGgyKO5IhJ/AeSrYHCWFwZ49etQRHzWpKnD
         GnPxkKJ5EV6EasqsGk+Ro+er17GSODj0HLldha78VigUi/p1sCcrZJdwdonkgbsBajbq
         Th4okIv9/uurIhpeZyUCZPrIRvPioQqOvehbCeBSRXooP6ten9EpKA/+S3cGAxPvKd4a
         lFmc9UtyPyzoVpjwkD0ShJkEobZtwD/SpUJNJI4Ov9WTSaSDe2yVRMoWAbzRdPd8yK9c
         IAUA==
X-Gm-Message-State: AOAM5316vpagLd0zrkwXrWeE/sCmwER9Pk/yp6zgGoCh9FapSKJBCq0l
        8VYjr+nVendr4HHm1zQFVwFVTDg7kEoIQQ==
X-Google-Smtp-Source: ABdhPJyM1tGukK0+jaEUj4a8MnXuQzCyh/bm1nOgyczDQvuuTrQts89DkzIJnCguGE1oW/6/g3iHeQ==
X-Received: by 2002:a17:902:7b8c:: with SMTP id w12mr2921348pll.186.1597936117172;
        Thu, 20 Aug 2020 08:08:37 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id q12sm3480560pfg.135.2020.08.20.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:08:36 -0700 (PDT)
Date:   Thu, 20 Aug 2020 23:08:26 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 13/18] perf ftrace: add support for trace option
 tracing_thresh
Message-ID: <20200820150826.fhswvgiodg6udyxk@mail.google.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-14-changbin.du@gmail.com>
 <20200814123310.GC13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814123310.GC13995@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 09:33:10AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Aug 08, 2020 at 10:31:36AM +0800, Changbin Du escreveu:
> > This adds an option '--graph-opts thresh' to setup trace duration
> > threshold for funcgraph tracer.
> 
> Applied, please consider making --duration an alias for this, as this is
> also available in 'perf trace':
> 
> [root@quaco ~]# perf trace --duration 500 --max-events=5
>    369.860 gnome-shell/2084 poll(ufds: 0x559577983080, nfds: 21, timeout_msecs: 7194) = 1
>    493.654 pool-geoclue/386046 futex(uaddr: 0x56024843b610, op: WAIT|PRIVATE_FLAG, val: 1201, utime: 0x7f32bd7f9cc0) = -1 ETIMEDOUT (Connection timed out)
>     71.604 WebRTC_Worker/111634 futex(uaddr: 0x7fb4c364d608, op: WAIT_BITSET|PRIVATE_FLAG, val: 0, utime: 0x7fb4c364d410, val3: MATCH_ANY) = -1 ETIMEDOUT (Connection timed out)
>    601.645 pool-gsd-smart/2469 clock_nanosleep(which_clock: 0, flags: 0, rqtp: 0x7fb82cbd1cf0, rmtp: 0x7fb82cbd1d00) = 0
>    623.823 chromium-brows/92363 futex(uaddr: 0x7ffcfd064e38, op: WAIT_BITSET|PRIVATE_FLAG, val: 0, utime: 0x7ffcfd064c40, val3: MATCH_ANY) = -1 ETIMEDOUT (Connection timed out)
> [root@quaco ~]#
> 
>   $ perf trace -h duration
> 
>         --duration <float>
>                           show only events with duration > N.M ms
> 
>   $
> 
> This way one would be able to do:
> 
>   # perf trace --duration N.M
> 
> To see at syscall level, then add 'f':
> 
>   # perf ftrace --duration N.M
> 
> To see at kernel function level. Switching from one perf tool to another
> with such ease is the main objective here, I'd say :-)
>
Sure. Currently the unit for ftrace is 'ns'. I could change it to 'ms' at perf
level.

> - Arnaldo
>  
> > $ sudo ./perf ftrace -G '*' --graph-opts thresh=100
> >  3) ! 184.060 us  |    } /* schedule */
> >  3) ! 185.600 us  |  } /* exit_to_usermode_loop */
> >  2) ! 225.989 us  |    } /* schedule_idle */
> >  2) # 4140.051 us |  } /* do_idle */
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  1 +
> >  tools/perf/builtin-ftrace.c              | 26 +++++++++++++++++++++++-
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index a2056aaf2ece..6fa927e5971b 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -107,6 +107,7 @@ OPTIONS
> >  	  nosleep-time - Measure on-CPU time only for function_graph tracer.
> >  	  noirqs       - Ignore functions that happen inside interrupt.
> >  	  verbose      - Show process names, PIDs, timestamps, etc.
> > +	  thresh=<n>   - Setup trace duration threshold in microseconds.
> >  
> >  SEE ALSO
> >  --------
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 8ee5287bd84a..ca61f8b8bbf6 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -48,6 +48,7 @@ struct perf_ftrace {
> >  	int			graph_nosleep_time;
> >  	int			graph_noirqs;
> >  	int			graph_verbose;
> > +	int			graph_thresh;
> >  };
> >  
> >  struct filter_entry {
> > @@ -234,6 +235,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> >  	if (write_tracing_file("max_graph_depth", "0") < 0)
> >  		return -1;
> >  
> > +	if (write_tracing_file("tracing_thresh", "0") < 0)
> > +		return -1;
> > +
> >  	reset_tracing_filters();
> >  	reset_tracing_options(ftrace);
> >  	return 0;
> > @@ -446,6 +450,20 @@ static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
> >  	return 0;
> >  }
> >  
> > +static int set_tracing_thresh(struct perf_ftrace *ftrace)
> > +{
> > +	int ret;
> > +
> > +	if (ftrace->graph_thresh == 0)
> > +		return 0;
> > +
> > +	ret = write_tracing_file_int("tracing_thresh", ftrace->graph_thresh);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> >  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  {
> >  	char *trace_file;
> > @@ -545,6 +563,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		goto out_reset;
> >  	}
> >  
> > +	if (set_tracing_thresh(ftrace) < 0) {
> > +		pr_err("failed to set tracing thresh\n");
> > +		goto out_reset;
> > +	}
> > +
> >  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
> >  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
> >  		goto out_reset;
> > @@ -727,6 +750,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
> >  		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
> >  		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
> >  		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
> > +		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
> >  		{ .name = NULL, }
> >  	};
> >  
> > @@ -798,7 +822,7 @@ int cmd_ftrace(int argc, const char **argv)
> >  	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
> >  		    "Max depth for function graph tracer"),
> >  	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> > -		     "graph tracer options, available options: nosleep-time,noirqs,verbose",
> > +		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>",
> >  		     parse_graph_tracer_opts),
> >  	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
> >  		     "size of per cpu buffer", parse_buffer_size),
> > -- 
> > 2.25.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
