Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4563C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7405620829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008387;
	bh=cSZ3Z6xbm0qHdC2Xdd4hiTxmk5VZQtJFQqZpQGd27Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E/J9IuNEuPo+ehZ2fo9Oy+nj8OlvMDtfUTNsk0UuM0QzAbF1eE9VzbsDorzPQp3uk
	 inXghmEyAAeqXxx9LM3EpXiOzaoK8y+/Gzcdsh8fs/+dHLey/tSMkNb6H3Y5ZuJ7Zl
	 xSsc18auMDPlX4QnYcJcf+ITCTtu+6o9q5sRNN50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgETU7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgETU7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:59:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E73520758;
        Wed, 20 May 2020 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008382;
        bh=cSZ3Z6xbm0qHdC2Xdd4hiTxmk5VZQtJFQqZpQGd27Tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJyJcZvk0+x9lSpU8GCPbcmNFNtUF7MxRW44vYHH9cckOkVPctXDu7BgmDzeZroi7
         Rr+VLRLQt52wT3QGSUe5gXDkfxD2rlbnrmtLTJPF7qZc85/tJ4nqxUDuEzxlbJ7ah3
         ibJlLVmQgkj9OATZvx/PKniu/mIRzho/2iTrv7Bs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F17040AFD; Wed, 20 May 2020 17:59:40 -0300 (-03)
Date:   Wed, 20 May 2020 17:59:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] perf ftrace: add option '-l/--list-functions' to
 list available functions
Message-ID: <20200520205940.GS32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-6-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-6-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:14PM +0800, Changbin Du escreveu:
> This adds an option '-l/--list-functions' to list all available functions
> which is read from tracing file 'available_filter_functions'.

Here, in 'perf probe' we have:

[acme@five perf]$ perf probe -F tcp_* | head
tcp_abort
tcp_ack
tcp_ack_update_rtt.isra.0
tcp_add_backlog
tcp_add_reno_sack
tcp_adjust_pcount
tcp_alloc_md5sig_pool
tcp_any_retrans_done.part.0
tcp_assign_congestion_control
tcp_bpf_clone
[acme@five perf]$ perf probe -h -F

 Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
    or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
    or: perf probe [<options>] --del '[GROUP:]EVENT' ...
    or: perf probe --list [GROUP:]EVENT ...
    or: perf probe [<options>] --line 'LINEDESC'
    or: perf probe [<options>] --vars 'PROBEPOINT'
    or: perf probe [<options>] --funcs

    -F, --funcs <[FILTER]>
                          Show potential probe-able functions.

[acme@five perf]$

So I think we should align with this.

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 43 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 1d30c2d5f88b..8133d910d5d8 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -33,6 +33,7 @@ struct perf_ftrace {
>  	struct evlist		*evlist;
>  	struct target		target;
>  	const char		*tracer;
> +	bool			list_avail_functions;
>  	struct list_head	filters;
>  	struct list_head	notrace;
>  	struct list_head	graph_funcs;
> @@ -142,6 +143,43 @@ static int write_tracing_option_file(const char *name, const char *val)
>  	return ret;
>  }
>  
> +static int read_tracing_file_to_stdout(const char *name)
> +{
> +	char buf[4096];
> +	char *file;
> +	int fd;
> +	int ret = -1;
> +
> +	file = get_tracing_file(name);
> +	if (!file) {
> +		pr_debug("cannot get tracing file: %s\n", name);
> +		return -1;
> +	}
> +
> +	fd = open(file, O_RDONLY);
> +	if (fd < 0) {
> +		pr_debug("cannot open tracing file: %s: %s\n",
> +			 name, str_error_r(errno, buf, sizeof(buf)));
> +		goto out;
> +	}
> +
> +	/* read contents to stdout */
> +	while (true) {
> +		int n = read(fd, buf, sizeof(buf));
> +		if (n <= 0)
> +			goto out_close;
> +		if (fwrite(buf, n, 1, stdout) != 1)
> +			goto out_close;
> +	}
> +	ret = 0;
> +
> +out_close:
> +	close(fd);
> +out:
> +	put_tracing_file(file);
> +	return ret;
> +}
> +
>  static int reset_tracing_cpu(void);
>  static void reset_tracing_filters(void);
>  
> @@ -332,6 +370,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGPIPE, sig_handler);
>  
> +	if (ftrace->list_avail_functions)
> +		return read_tracing_file_to_stdout("available_filter_functions");
> +
>  	if (reset_tracing_files(ftrace) < 0) {
>  		pr_err("failed to reset ftrace\n");
>  		goto out;
> @@ -483,6 +524,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		NULL
>  	};
>  	const struct option ftrace_options[] = {
> +	OPT_BOOLEAN('L', "list-functions", &ftrace.list_avail_functions,
> +		    "List available functions to filter"),
>  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>  		   "trace on existing process id"),
>  	OPT_INCR('v', "verbose", &verbose,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
