Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC16C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 11:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9130A2068E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 11:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDzm80tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgFNLP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 07:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgFNLP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 07:15:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F0C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 04:15:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v14so1327663pgl.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eBlVedxbnk0zmCSE3D/dt+HsodVO7NisY+35aq1wEbc=;
        b=RDzm80tkjqd34Q70BUzo6XAV/GZKBxISFxQmgs+sQD7GdJDFtrsO0xgPTgCyD8Qnz6
         Yc9mWptsiVMhwEL8rvcf2v5uBkY9i28bWsXS33kIH5QRWiSKzd8FOveWNJ6nV/hP9EvS
         y+JJBojebhau6lN11/YnGTSFdTYkQ7SVGsHcJkWNsS1BQT7g46NEt5Q3uqEvW+kucYO/
         v9yZjFkQacSEF4KbQoMvqZEzMd6CrROEI5RVHjy+eZYIKNtKphBcLcLfQDdF3Fchx6ZN
         I1uJb3iNvROsF2A5h/Ydn82sxlu4BDCdXk4gY9/+7OAyQmAKGNNnpb5MX0BtTDWisBNU
         qfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBlVedxbnk0zmCSE3D/dt+HsodVO7NisY+35aq1wEbc=;
        b=bk619bTltQ7nsuQbxcclIs20lUukkLKf0Up57R+4grUOGXxr0YZxmGB77uIbw1ww+/
         QLop2wS1d94Y79GtwADyrYDaOiyHIao2Q0atST93LhegnUryb3ldZ1LH1NQuZWkOSQhB
         Fc8qv3PEK1NzVmLv89YsvQxVT4NA73qSHZDOiO1uwitmWghujlJUuWrq1VPc/if14jy8
         /EScfR4k1fFy6cEe0/eSpcu88hJ5iY+HuzaFN1Fw8jiW3E1Y88c0qoclzY+d41uYIhc5
         6QoZ1SSQ1QmfWGfbE2RYj3+V9GrTf/CdGCegyhpyqfDipz1fSMv89vj5w/Z5hxwZ06fj
         QcAA==
X-Gm-Message-State: AOAM533+zckc6fB66aNBbye8PF5NPZ7bmwUHO5lYsu256J/HajalJ5Vw
        RpoA02NkNXqEyySnJNUty50=
X-Google-Smtp-Source: ABdhPJyj86GFpriO+MfpNcUwEAYkO7qm85C3RaX/x33Ygeqby3va5JjmV0M0zSKXblgV5KvpsfT7Sg==
X-Received: by 2002:a62:2cd7:: with SMTP id s206mr18692176pfs.305.1592133356502;
        Sun, 14 Jun 2020 04:15:56 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id l14sm10061825pjh.50.2020.06.14.04.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 04:15:55 -0700 (PDT)
Date:   Sun, 14 Jun 2020 19:15:49 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] perf ftrace: add option '-u/--userstacktrace' to
 show userspace stacktrace
Message-ID: <20200614111549.57lqs5tulu4frmgr@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-12-changbin.du@gmail.com>
 <20200520210741.GZ32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520210741.GZ32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:07:41PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:20PM +0800, Changbin Du escreveu:
> > This adds an option ''-u/--userstacktrace' for function tracer to display
> > userspace back trace.
> 
> Probably we should have this as a term, an option to --call-graph?
> 
> For --call-graph the way to suppress this is to ask for the event to be
> in the kernel only, i.e. something like:
> 
> 	perf record -e cycles:k --call-graph
> 
> So perhaps we should have something like:
> 
> 	perf ftrace --call-graph 
> 
> With some default, possibly a bit different than the other perf tools,
> just including the kernel, and accepting:
> 
> 	perf ftrace --call-graph
> 	perf ftrace --call-graph k
> 	perf ftrace --call-graph u
> 	perf ftrace --call-graph uk
> 
> - Arnaldo
>
I just found userstacktrace is not supported by ftrace yet. It is not
hard to add this feature in kernel and I have done it locally. So I will
drop this option before it is upstreamed.

> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 2ef5d1c4b23c..ab76ba66bd9e 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -40,6 +40,7 @@ struct perf_ftrace {
> >  	struct list_head	nograph_funcs;
> >  	int			graph_depth;
> >  	bool			func_stack_trace;
> > +	bool			userstacktrace;
> >  	bool			nosleep_time;
> >  	bool			nofuncgraph_irqs;
> >  	bool			funcgraph_tail;
> > @@ -197,6 +198,8 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> >  	write_tracing_option_file("funcgraph-proc", "0");
> >  	write_tracing_option_file("funcgraph-abstime", "0");
> >  	write_tracing_option_file("irq-info", "0");
> > +	write_tracing_option_file("userstacktrace", "0");
> > +	write_tracing_option_file("sym-userobj", "0");
> >  }
> >  
> >  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> > @@ -287,6 +290,20 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
> >  	return 0;
> >  }
> >  
> > +static int set_tracing_userstacktrace(struct perf_ftrace *ftrace)
> > +{
> > +	if (!ftrace->userstacktrace)
> > +		return 0;
> > +
> > +	if (write_tracing_option_file("userstacktrace", "1") < 0)
> > +		return -1;
> > +
> > +	if (write_tracing_option_file("sym-userobj", "1") < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int reset_tracing_cpu(void)
> >  {
> >  	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
> > @@ -482,6 +499,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		goto out_reset;
> >  	}
> >  
> > +	if (set_tracing_userstacktrace(ftrace) < 0) {
> > +		pr_err("failed to set tracing option userstacktrace\n");
> > +		goto out_reset;
> > +	}
> > +
> >  	if (set_tracing_filters(ftrace) < 0) {
> >  		pr_err("failed to set tracing filters\n");
> >  		goto out_reset;
> > @@ -644,6 +666,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		     "do not trace given functions", parse_filter_func),
> >  	OPT_BOOLEAN('s', "func-stack-trace", &ftrace.func_stack_trace,
> >  		    "Show kernel stack trace for function tracer"),
> > +	OPT_BOOLEAN('u', "userstacktrace", &ftrace.userstacktrace,
> > +		    "Show stacktrace of the current user space thread"),
> >  	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
> >  		     "Set graph filter on given functions (imply to use function_graph tracer)",
> >  		     parse_filter_func, "*"),
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
