Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C375C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288162077D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rielDmLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgFFOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgFFOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:43:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE1AC03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:43:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so23757pjd.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6fVvDEg9dvVr8g8jrbspeCmxyGJQxBX/m09SYt/oUAU=;
        b=rielDmLOlMg0ZoTWdM4GwR0ttPSxu9WBcFiRMQITTkSH4i5QJffJbm/qfvrE2FycC1
         Qh0iNyIWji1tg66WmDqXh5c//vuSOoyS/qt+FD/0z1R0tyYtN2HFGK1wyky6lh8DTtRK
         r9w/GNlX7F2tHry31RbTZFtCSoiSQB8NOI5PwJ8UNU/EvVtC3eOY43RV7b+9S/b8JR4e
         +XjAlMvexnMDfw/qsgCV2YwW57MAl6DJiyuK/BTclm4BMr1IqmiDhWB+T8KalXR1ZhtZ
         W4jAoLpRskOLRQVnBygq357pyiI7vkNTLagGb2okzYrB2bic5G5teWE0qfmPhZzlDqxG
         2hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6fVvDEg9dvVr8g8jrbspeCmxyGJQxBX/m09SYt/oUAU=;
        b=byjSH/ijyQipMYQqu2VMf/xMiCQitPKDg/4k+qGXM6624XbCgtJ0dz0f59FYJbHbYs
         8tHODase/ABtlYvOxbBOsDkDM1lJD9ToQ3SmnRMkYlXlxJEgJguGakao8r4KnQ70H55s
         Qn6iEY2cCmS28+xhIeikGRgjfnMg4UnoJVKYCag1i2opX79wOXtuUEqplu5sb/qTcwX2
         +Pzh3Gp/gbNj6PFdlNinxp7wywrDdVZK872b8l95Gopsvml3iCeGD1cPDFrx9rp8k+VF
         rhyZ5Pp6ZC/YfGB/V07r8c5bqjWF+Hey+UsE6azp/B1IZm24Q/S9UgDOlfGqmdwTE98R
         qWrA==
X-Gm-Message-State: AOAM530BXETirVsX1THN1zI/n9s25R+4fOek8oFSOMVMrvhEL/ZXpJFL
        nljJDFn3pBY4gzFiWVVDczE=
X-Google-Smtp-Source: ABdhPJzP/4rbEAovPYdVQyGqKML/PKuPLgzh9zCVQppBY5MXMLcZk7pyUtg3jlTn+/BZfIVUoDMqrQ==
X-Received: by 2002:a17:90a:2270:: with SMTP id c103mr7874875pje.184.1591454583713;
        Sat, 06 Jun 2020 07:43:03 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id j15sm11002967pjj.12.2020.06.06.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:43:02 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:42:53 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] perf ftrace: add option '-l/--list-functions' to
 list available functions
Message-ID: <20200606144253.sdo2f5o54d5zdic7@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-6-changbin.du@gmail.com>
 <20200520205940.GS32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520205940.GS32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:59:40PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:14PM +0800, Changbin Du escreveu:
> > This adds an option '-l/--list-functions' to list all available functions
> > which is read from tracing file 'available_filter_functions'.
> 
> Here, in 'perf probe' we have:
> 
> [acme@five perf]$ perf probe -F tcp_* | head
> tcp_abort
> tcp_ack
> tcp_ack_update_rtt.isra.0
> tcp_add_backlog
> tcp_add_reno_sack
> tcp_adjust_pcount
> tcp_alloc_md5sig_pool
> tcp_any_retrans_done.part.0
> tcp_assign_congestion_control
> tcp_bpf_clone
> [acme@five perf]$ perf probe -h -F
> 
>  Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
>     or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
>     or: perf probe [<options>] --del '[GROUP:]EVENT' ...
>     or: perf probe --list [GROUP:]EVENT ...
>     or: perf probe [<options>] --line 'LINEDESC'
>     or: perf probe [<options>] --vars 'PROBEPOINT'
>     or: perf probe [<options>] --funcs
> 
>     -F, --funcs <[FILTER]>
>                           Show potential probe-able functions.
> 
> [acme@five perf]$
> 
> So I think we should align with this.
> 
> - Arnaldo
>
Agreed. Will do that in next revision.

> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 43 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 1d30c2d5f88b..8133d910d5d8 100644
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
> > @@ -142,6 +143,43 @@ static int write_tracing_option_file(const char *name, const char *val)
> >  	return ret;
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
> > +		if (n <= 0)
> > +			goto out_close;
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
> > @@ -332,6 +370,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  	signal(SIGCHLD, sig_handler);
> >  	signal(SIGPIPE, sig_handler);
> >  
> > +	if (ftrace->list_avail_functions)
> > +		return read_tracing_file_to_stdout("available_filter_functions");
> > +
> >  	if (reset_tracing_files(ftrace) < 0) {
> >  		pr_err("failed to reset ftrace\n");
> >  		goto out;
> > @@ -483,6 +524,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		NULL
> >  	};
> >  	const struct option ftrace_options[] = {
> > +	OPT_BOOLEAN('L', "list-functions", &ftrace.list_avail_functions,
> > +		    "List available functions to filter"),
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
