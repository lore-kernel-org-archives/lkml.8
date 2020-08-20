Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00026C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0164204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPnfMgMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgHTPLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgHTPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:09:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835DC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:09:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e4so1100326pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=71XX2veJkKT0YzwmClCc+z80ZFWwKWy5GA8qJO8IZyc=;
        b=hPnfMgMMtVyfrUz89//K6xkkxbZOFny/EDMVqtpoiQpt/h2T8RlAtlhfnLe8eHgbzM
         WMCMdsgyGNgbjc/1ZE6EbjNyEGZr+e+MGoRGAlYOvdZGyOXg8UJsEwRUBvEryn6gUJDV
         WZwjroQEgmVQ4V3zoeWVW0jroqHZyaLrLLlmvnLPFHnIotm/ffXiB28Uo+h9qFg2Cyfi
         JQMIEEtlxsVpm16jcujJ+ncMNBqF4faVaVvPZPcKsWZTiq/HrqzVqDHnlONkMb8TfUVv
         hp67Q6loy2lF49ULJ5hH94C03IHvuiRbXAsvT6WS3H0LmkAfRLL1Jj0C+JMjbHC/+1NU
         KFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=71XX2veJkKT0YzwmClCc+z80ZFWwKWy5GA8qJO8IZyc=;
        b=Yit8z6UR+odinaH5UFCQ4CaYpLUShr+OiC34QxjSp1JKcqUaAoerMvQ15Q93tqiEiC
         +wSSsdILsnpl5FdLVQU/4wZGnz4xNN2zd13+vPQip5Cj8eb/bK5Vp0ccheOIB5vH6dhv
         hbFnPQteo7uqnxQOA+MBRK6dtH4tR5OEnQ6wZJko/7vEB8XcBF6aUj0KGqYRwoUdS3cj
         dqv5nkSSGjM/63bUd2+05aTKX0FC47MhvC+nNcpOMB63PUSdspMFar9/69YIPSPAe2qt
         4gkmGnZeo6d9Lf0qGzGwYASjofgzPLvkTR7zBMQgr/VRxoEuoy7WVO8Z9sJa+wVmdm3a
         Pl9w==
X-Gm-Message-State: AOAM533mu0k1q1b0RnpZnFh7iDG6qDuCquZ1Ofznq8awl7qdmY3rKfjy
        wlPfveVFoL7TU4n5xvwywHh/87d00BTxjQ==
X-Google-Smtp-Source: ABdhPJyIg3RDk70VxXVYxag07JOMUCl79xDsodzJij9LUYJP33yJbMtuYuSEB+EnTRx9lqU8SmkKLA==
X-Received: by 2002:a17:90b:4c0c:: with SMTP id na12mr2747635pjb.24.1597936182749;
        Thu, 20 Aug 2020 08:09:42 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id r77sm3426355pfc.193.2020.08.20.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:09:41 -0700 (PDT)
Date:   Thu, 20 Aug 2020 23:09:32 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/18] perf ftrace: add support for tracing option
 'irq-info'
Message-ID: <20200820150932.nexcjkiys4flf4ov@mail.google.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-12-changbin.du@gmail.com>
 <20200814122807.GB13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814122807.GB13995@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 09:28:07AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Aug 08, 2020 at 10:31:34AM +0800, Changbin Du escreveu:
> > This adds support to display irq context info for function tracer. To do
> > this, just specify a '--func-opts irq-info' option.
> 
> Applied, ditto about adding an example to perf-ftrace.txt
>
no problem, I will do it some days later. Thanks.

> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  1 +
> >  tools/perf/builtin-ftrace.c              | 21 ++++++++++++++++++++-
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index fca55ac55ff3..37ea3ea97922 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -79,6 +79,7 @@ OPTIONS
> >  --func-opts::
> >  	List of options allowed to set:
> >  	  call-graph - Display kernel stack trace for function tracer.
> > +	  irq-info   - Display irq context info for function tracer.
> >  
> >  -G::
> >  --graph-funcs=::
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index b4c821be4fb5..d1241febe143 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -44,6 +44,7 @@ struct perf_ftrace {
> >  	unsigned long		percpu_buffer_size;
> >  	bool			inherit;
> >  	int			func_stack_trace;
> > +	int			func_irq_info;
> >  	int			graph_nosleep_time;
> >  	int			graph_noirqs;
> >  };
> > @@ -209,6 +210,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> >  	write_tracing_option_file("func_stack_trace", "0");
> >  	write_tracing_option_file("sleep-time", "1");
> >  	write_tracing_option_file("funcgraph-irqs", "1");
> > +	write_tracing_option_file("irq-info", "0");
> >  }
> >  
> >  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> > @@ -296,6 +298,17 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
> >  	return 0;
> >  }
> >  
> > +static int set_tracing_func_irqinfo(struct perf_ftrace *ftrace)
> > +{
> > +	if (!ftrace->func_irq_info)
> > +		return 0;
> > +
> > +	if (write_tracing_option_file("irq-info", "1") < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int reset_tracing_cpu(void)
> >  {
> >  	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
> > @@ -471,6 +484,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		goto out_reset;
> >  	}
> >  
> > +	if (set_tracing_func_irqinfo(ftrace) < 0) {
> > +		pr_err("failed to set tracing option irq-info\n");
> > +		goto out_reset;
> > +	}
> > +
> >  	if (set_tracing_filters(ftrace) < 0) {
> >  		pr_err("failed to set tracing filters\n");
> >  		goto out_reset;
> > @@ -660,6 +678,7 @@ static int parse_func_tracer_opts(const struct option *opt,
> >  	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
> >  	struct sublevel_option func_tracer_opts[] = {
> >  		{ .name = "call-graph",	.value_ptr = &ftrace->func_stack_trace },
> > +		{ .name = "irq-info",	.value_ptr = &ftrace->func_irq_info },
> >  		{ .name = NULL, }
> >  	};
> >  
> > @@ -742,7 +761,7 @@ int cmd_ftrace(int argc, const char **argv)
> >  	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
> >  		     "do not trace given functions", parse_filter_func),
> >  	OPT_CALLBACK(0, "func-opts", &ftrace, "options",
> > -		     "function tracer options, available options: call-graph",
> > +		     "function tracer options, available options: call-graph,irq-info",
> >  		     parse_func_tracer_opts),
> >  	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
> >  		     "trace given functions using function_graph tracer",
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
