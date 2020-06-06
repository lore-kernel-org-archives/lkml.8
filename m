Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA40C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725BC206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6sxyi2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgFFOPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFFOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:15:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD14C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:15:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so4841344plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fDQJpkKZEXmAuqjv4w1Kkv6CjCyfB9HUyHc7hX4xqE=;
        b=G6sxyi2+yqDVRRXFHKPsPEyoMVyRMJH7XC1RsJaaO9jiGZMABYmMTQ/YlHt6mMRTKH
         H5H814YAoFwnhk1Q5CMqefMINRYTu4ABfOhRw7Jqnb/EQbtB5x7J3EoaJ3n8kX65yTap
         aoJHEochUfduRBTlnLUVLrGeyKaN9YiHxtpzuxwRuWZH8TbBNUyYtL8pzYIqGVhUumWR
         t0LD3cieseRuQeVF1wquhXca++ZZhUakKEePct1OeVKHaFEiZlAvuf0rfbNWQoJz2lhA
         sit6X30Mrw9pHCEfDKh8uidtIRbWirVquQSUOYcBFAMtIApciZwPfWbcQriT0oYQA8H7
         butQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fDQJpkKZEXmAuqjv4w1Kkv6CjCyfB9HUyHc7hX4xqE=;
        b=XC2+1GMEY8RowNS5QoTvjmUJlfmftwtCfnuoloaE0U+bh3TzVcJV3NI8faqawtCxnI
         Lz+9eNSi7Bgmsl0KQPSG4W401SUbhhqmjWEsxRlEZpZZCZJMQwRVV522jvzSBQV5cuH1
         /pqvDzKENZo1bNEBMICLfr6shF4R3fRpNHyLYj1mMvSsP9iZzRjUEdzXIBYcEEtavQb2
         DkIHi6WM2MOpAREhLhkQMd+BZjYV8DAIxLljo/2MOzlxtimVtcNnJWFnb4nZw5z7qNmL
         vwALb5x2sOS6WetHVtafnDuF4o9lZ/u/qVXY0326+BkqCdY5NFJ2d8/JFrpzY24jYCaI
         RbwQ==
X-Gm-Message-State: AOAM5304RlVtJoYMzZks2SE/30jok6MBSzYLeGKpWUIYOOGvPu7TMhjW
        1DUbaTSCDH49//Mk8IMk1NQQspEkuO9uyQ==
X-Google-Smtp-Source: ABdhPJwwaP9VaS3kNgHQgTaLGUCyFDgZZavYBF157tBQfQkeFIVT/cOz6VwZToWQEUCU1QOGp1LpNQ==
X-Received: by 2002:a17:90a:64cb:: with SMTP id i11mr7445182pjm.193.1591452902759;
        Sat, 06 Jun 2020 07:15:02 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id z140sm2585963pfc.135.2020.06.06.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:15:01 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:14:51 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] perf ftrace: add option -l/--long-info to show
 more info
Message-ID: <20200606141451.m6gi7scp2tf5errj@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-9-changbin.du@gmail.com>
 <20200520210257.GV32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520210257.GV32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:02:57PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:17PM +0800, Changbin Du escreveu:
> > Sometimes we want ftrace display more and longer information about trace.
> 
> Humm, -v? Or that would bring too much stuff from other parts of perf?
> I guess so, perhaps as an option to the function-graph tracer, one that
> combines, as you do, several options provided by that tracer?
>
yes, this option enables mutiple trace options onetime, which will make the
function tracer or graph tracer output as much as more information per-line. So I call it
as 'long'.

> - Arnaldo
>  
> > $ sudo perf ftrace -G -l
> >  6800.190937 |   4)   <...>-7683   |   2.072 us    |  mutex_unlock();
> >  6800.190941 |   4)   <...>-7683   |   2.171 us    |  __fsnotify_parent();
> >  6800.190943 |   4)   <...>-7683   |   1.497 us    |  fsnotify();
> >  6800.190944 |   4)   <...>-7683   |   0.775 us    |  __sb_end_write();
> >  6800.190945 |   4)   <...>-7683   |   0.854 us    |  fpregs_assert_state_consistent();
> >  6800.190947 |   4)   <...>-7683   |               |  do_syscall_64() {
> >  6800.190948 |   4)   <...>-7683   |               |    __x64_sys_close() {
> >  6800.190948 |   4)   <...>-7683   |               |      __close_fd() {
> >  6800.190948 |   4)   <...>-7683   |   0.322 us    |        _raw_spin_lock();
> >  6800.190949 |   4)   <...>-7683   |               |        filp_close() {
> >  6800.190949 |   4)   <...>-7683   |   0.320 us    |          dnotify_flush();
> >  6800.190950 |   4)   <...>-7683   |   0.325 us    |          locks_remove_posix();
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index b16600a16efa..f11f2d3431b0 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -42,6 +42,7 @@ struct perf_ftrace {
> >  	bool			func_stack_trace;
> >  	bool			nosleep_time;
> >  	bool			nofuncgraph_irqs;
> > +	bool			long_info;
> >  };
> >  
> >  struct filter_entry {
> > @@ -190,6 +191,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> >  	write_tracing_option_file("func_stack_trace", "0");
> >  	write_tracing_option_file("sleep-time", "1");
> >  	write_tracing_option_file("funcgraph-irqs", "1");
> > +	write_tracing_option_file("funcgraph-proc", "0");
> > +	write_tracing_option_file("funcgraph-abstime", "0");
> > +	write_tracing_option_file("irq-info", "0");
> >  }
> >  
> >  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> > @@ -371,6 +375,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
> >  	return 0;
> >  }
> >  
> > +static int set_tracing_long_info(struct perf_ftrace *ftrace)
> > +{
> > +	if (!ftrace->long_info)
> > +		return 0;
> > +
> > +	if (write_tracing_option_file("funcgraph-proc", "1") < 0)
> > +		return -1;
> > +
> > +	if (write_tracing_option_file("funcgraph-abstime", "1") < 0)
> > +		return -1;
> > +
> > +	if (write_tracing_option_file("irq-info", "1") < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  {
> >  	char *trace_file;
> > @@ -449,6 +470,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		goto out_reset;
> >  	}
> >  
> > +	if (set_tracing_long_info(ftrace) < 0) {
> > +		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime/irq-info\n");
> > +		goto out_reset;
> > +	}
> > +
> >  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
> >  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
> >  		goto out_reset;
> > @@ -588,6 +614,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		    "Measure on-CPU time only (function_graph only)"),
> >  	OPT_BOOLEAN(0, "nofuncgraph-irqs", &ftrace.nofuncgraph_irqs,
> >  		    "Ignore functions that happen inside interrupt (function_graph only)"),
> > +	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
> > +		    "Show process names, PIDs, timestamps, irq-info if available"),
> >  	OPT_END()
> >  	};
> >  
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
