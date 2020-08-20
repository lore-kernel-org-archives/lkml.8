Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02349C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5030206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdZLv4IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgHTPTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbgHTPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:18:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D1C061342
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:18:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so1110999pjx.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVIyWvFTHGyvDYVVdK/JSM4b/tVFbxAKyGbndCMmvlg=;
        b=UdZLv4IN2KMCBbeCurS2KoyYmEQdGC5RluFMcPyYEjH6z1p0vD9GpaEEofXDb2RXth
         wump/Y9DZrjxt9iEU7T92P5hIYduhciD5LRz+uwYptM8YaFQBdTn1+ES587hWxv9aAPg
         YmqdemiDSRJKN0QbVeeSr2jiQ1r1tsgCzMXpvpo2UFXEGb28M/O6ibwvJqgwOE+maHS9
         Cb9wtgiH9z+F933iHYhdOj06LyK6ewpJtcUCHLEFOgJa0ucTxgjjIsbVmf71tWPt1/k+
         25Ssha09gJttKJUHrSGyEBy8NjOTrhNm5yGwae5AmhO4E2ET8w/Sc9FK+9n+K3g6sVp6
         c+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVIyWvFTHGyvDYVVdK/JSM4b/tVFbxAKyGbndCMmvlg=;
        b=ZeIiaInf9RypXJzsLBEEXqI88cfv4unzIjz7i1EgYA4dh/Q+gOuy08bDqGjIrC6XgV
         hgKrkl30M2U14JFLlHzcm0m1LvcAHzXBnxAYGN2BQBkp10nIfefDwsMjqaJthz16QKTC
         apWPVQzKbpXHKElzHNd0VdjBk9+1R4vwKQ//z/qvR1WqOfTzgciFjWt2JJ+kzzT6L1HS
         X/PcchI1UR5p//5it+tLD6o7ftt41GGBvcAwJBSV74w9xViZkgyBpGG5EUY34okBHF1G
         uYktt1Xt7rMEW83VKgngXgrQ6M00Lpm1Flu58dW/uf39bYbQVl87hJfe16cidprmKf/a
         wn0A==
X-Gm-Message-State: AOAM531On2FveRF8CbD0Rz+VkPvjHGLait1AgriP9/w8pBDAGVFmcz0Y
        5flwvb/ha98z/zk9gaOxir8=
X-Google-Smtp-Source: ABdhPJy2e1jGeLYp/TqPllDTU9e0h9EnBuJDN7cY8wN//Pr/J48m0z5KwsFby1hY44KyvyEYX60D6g==
X-Received: by 2002:a17:90b:10f:: with SMTP id p15mr2963233pjz.171.1597936722574;
        Thu, 20 Aug 2020 08:18:42 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id y4sm2783205pgb.16.2020.08.20.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:18:41 -0700 (PDT)
Date:   Thu, 20 Aug 2020 23:18:25 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/18] perf ftrace: add option '-F/--funcs' to list
 available functions
Message-ID: <20200820151825.idfidxxbat6e32ur@mail.google.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-3-changbin.du@gmail.com>
 <20200814113535.GS13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814113535.GS13995@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 08:35:35AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Aug 08, 2020 at 10:31:25AM +0800, Changbin Du escreveu:
> > This adds an option '-F/--funcs' to list all available functions to trace,
> > which is read from tracing file 'available_filter_functions'.
> > 
> > $ sudo ./perf ftrace -F | head
> > trace_initcall_finish_cb
> > initcall_blacklisted
> > do_one_initcall
> > do_one_initcall
> > trace_initcall_start_cb
> > run_init_process
> > try_to_run_init_process
> > match_dev_by_label
> > match_dev_by_uuid
> > rootfs_init_fs_context
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > 
> > ---
> > v3: fix return value issue.
> > v2: option name '-l/--list-functions' -> '-F/--funcs'
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  4 +++
> >  tools/perf/builtin-ftrace.c              | 46 ++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index 821d4d334a09..4f5628445a63 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -31,6 +31,10 @@ OPTIONS
> >  --verbose=::
> >          Verbosity level.
> >  
> > +-F::
> > +--funcs::
> > +        List all available functions to trace.
> > +
> >  -p::
> >  --pid=::
> >  	Trace on existing process id (comma separated list).
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 048a11192b59..1ebf71ecc1a8 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -33,6 +33,7 @@ struct perf_ftrace {
> >  	struct evlist		*evlist;
> >  	struct target		target;
> >  	const char		*tracer;
> > +	bool			list_avail_functions;
> >  	struct list_head	filters;
> >  	struct list_head	notrace;
> >  	struct list_head	graph_funcs;
> > @@ -128,6 +129,46 @@ static int append_tracing_file(const char *name, const char *val)
> >  	return __write_tracing_file(name, val, true);
> >  }
> >  
> > +static int read_tracing_file_to_stdout(const char *name)
> > +{
> > +	char buf[4096];
> > +	char *file;
> > +	int fd;
> > +	int ret = -1;
> > +
> > +	file = get_tracing_file(name);
> > +	if (!file) {
> > +		pr_debug("cannot get tracing file: %s\n", name);
> > +		return -1;
> > +	}
> > +
> > +	fd = open(file, O_RDONLY);
> > +	if (fd < 0) {
> > +		pr_debug("cannot open tracing file: %s: %s\n",
> > +			 name, str_error_r(errno, buf, sizeof(buf)));
> > +		goto out;
> > +	}
> > +
> > +	/* read contents to stdout */
> > +	while (true) {
> > +		int n = read(fd, buf, sizeof(buf));
> > +		if (n == 0)
> > +			break;
> > +		else if (n < 0)
> > +			goto out_close;
> > +
> > +		if (fwrite(buf, n, 1, stdout) != 1)
> > +			goto out_close;
> > +	}
> > +	ret = 0;
> > +
> > +out_close:
> > +	close(fd);
> > +out:
> > +	put_tracing_file(file);
> > +	return ret;
> > +}
> > +
> >  static int reset_tracing_cpu(void);
> >  static void reset_tracing_filters(void);
> >  
> > @@ -302,6 +343,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  	signal(SIGCHLD, sig_handler);
> >  	signal(SIGPIPE, sig_handler);
> >  
> > +	if (ftrace->list_avail_functions)
> > +		return read_tracing_file_to_stdout("available_filter_functions");
> > +
> >  	if (reset_tracing_files(ftrace) < 0) {
> >  		pr_err("failed to reset ftrace\n");
> >  		goto out;
> > @@ -487,6 +531,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  	const struct option ftrace_options[] = {
> >  	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
> >  		   "tracer to use: function_graph(default) or function"),
> > +	OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
> > +		    "Show available functions to filter"),
> 
> A boolean? I guess this can be a first step, but why not do it like
> 'perf probe' and accept a patterna? Allows for less typing:
> 
>   # perf probe -h -F
> 
>     -F, --funcs <[FILTER]>
>                           Show potential probe-able functions.
> 
> [root@quaco ~]#
> 
> # perf probe -F '*btf_parse*'
> btf_parse_hdr
> btf_parse_str_sec
> btf_parse_vmlinux
> #
> # perf ftrace -F | grep btf_parse
> btf_parse_str_sec
> btf_parse_hdr
> btf_parse_vmlinux
> #
> 
> I'm applying this to make progress, but please consider sending a patch
> to make this behave in the same way as 'perf probe'.
>
No problem, I'll try to provide similar behaviour for this. Thanks.

> - Arnaldo
> 
> 
> >  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
> >  		   "trace on existing process id"),
> >  	OPT_INCR('v', "verbose", &verbose,
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
