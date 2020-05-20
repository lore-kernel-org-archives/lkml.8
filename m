Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C51C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE3620874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008958;
	bh=ptqItCDH9o9pF0WAAEe7vrVWcF72lf1db3H1PlvvZBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R0CHUglQorCktNLCyXOgaioTi1YrS3N4Q+CI97WwaPKTVE6ZMW9dhZV2KqHsP7XiE
	 GyTXsxsE5IVV2OcjKlxLcTG2MgZxrG7owJoDzoXvZtpFDbbFeDsEOieDtbsftIRQ6T
	 aFt453T/bb5comr+UQJOtdmD0telz5ILJkPg33tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgETVJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgETVJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:09:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1549207E8;
        Wed, 20 May 2020 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008956;
        bh=ptqItCDH9o9pF0WAAEe7vrVWcF72lf1db3H1PlvvZBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIX6dy2uSkCaZ2ZWGiTohSWyIBcIUVDfHCgMwKaYLKy/xHaqmVCqC+QEm7GCJtqgE
         hM7FAdVBM0uSXlrg3366o6ZRc6IhD9ONoKGuXHJJdasKurTCFEJKcmNrsQvGZSu1jW
         1gJMaXGRSwH/nGj978U79DnXinPmbxQAy0rqhzUA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D4B9A40AFD; Wed, 20 May 2020 18:09:14 -0300 (-03)
Date:   Wed, 20 May 2020 18:09:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/19] perf ftrace: add option -P/--no-pager to disable
 pager
Message-ID: <20200520210914.GC32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-15-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-15-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:23PM +0800, Changbin Du escreveu:
> Sometimes we want perf displays trace immediately. So this adds an option
> '-P/--no-pager' to disable pager if needed.


Try:

perf record sleep 5
perf script

Then:

perf --no-pager script

I.e. its there already.

- Arnaldo

> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index a93fbdac6aa4..64c22f367ba2 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -48,6 +48,7 @@ struct perf_ftrace {
>  	unsigned		tracing_thresh;
>  	bool			trace_children;
>  	unsigned		buffer_size_kb;
> +	bool			no_pager;
>  };
>  
>  struct filter_entry {
> @@ -56,6 +57,7 @@ struct filter_entry {
>  };
>  
>  static volatile int workload_exec_errno;
> +static bool interrupted;
>  static bool done;
>  
>  static void sig_handler(int sig __maybe_unused)
> @@ -63,6 +65,12 @@ static void sig_handler(int sig __maybe_unused)
>  	done = true;
>  }
>  
> +static void sig_handler_int(int sig __maybe_unused)
> +{
> +	sig_handler(sig);
> +	interrupted = 1;
> +}
> +
>  /*
>   * perf_evlist__prepare_workload will send a SIGUSR1 if the fork fails, since
>   * we asked by setting its exec_error to the function below,
> @@ -492,7 +500,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		return -1;
>  	}
>  
> -	signal(SIGINT, sig_handler);
> +	signal(SIGINT, sig_handler_int);
>  	signal(SIGUSR1, sig_handler);
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGPIPE, sig_handler);
> @@ -585,7 +593,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> -	setup_pager();
> +	if (!ftrace->no_pager)
> +		setup_pager();
>  
>  	trace_file = get_tracing_file("trace_pipe");
>  	if (!trace_file) {
> @@ -636,7 +645,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	}
>  
>  	/* read remaining buffer contents */
> -	while (true) {
> +	while (true && !interrupted) {
>  		int n = read(trace_fd, buf, sizeof(buf));
>  		if (n <= 0)
>  			break;
> @@ -731,6 +740,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Trace children processes"),
>  	OPT_UINTEGER('b', "buffer-size", &ftrace.buffer_size_kb,
>  		     "size of per cpu buffer in kb"),
> +	OPT_BOOLEAN('P', "no-pager", &ftrace.no_pager,
> +		    "Do not use pager"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
