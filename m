Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28400C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDB5207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008882;
	bh=C3eLWDyOPein2shgCJHm4Hf7jANdUU9Z2764xm3IXxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m1NS1QhJVolMSMYqJ4eXtUdRb8foF35qJFUAC+g/5x5JeGWjlysEI90Pf1Jq3P0Ty
	 XM/DaaXt8ARyLMvh+2b8ARmxSfsES+zE4z+og3DM7rGYChPI/VWf9Qhdc5aRaCNOZN
	 BQbpPypNagNQYAUc1m2cSoQndlAt0dlPx50rvVE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgETVIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:08:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA47720829;
        Wed, 20 May 2020 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008879;
        bh=C3eLWDyOPein2shgCJHm4Hf7jANdUU9Z2764xm3IXxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cb8SMlYJU3FWj1MqcEnKAu8tp4WlBQd0feNKOt7+WV3kyeQR3aIxdJp12LMSg30Rd
         XHJlcv7YeCgOHdekGHYwzlssTon0VCU7ob8U/pjgNxaagzpmvYVS3wwZTKPLwRaOza
         8KVZpS/MyOEP+AA9cAitUATa1e4KR+VW0oR6c1Es=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3A3140AFD; Wed, 20 May 2020 18:07:57 -0300 (-03)
Date:   Wed, 20 May 2020 18:07:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/19] perf ftrace: add support for tracing children
 processes
Message-ID: <20200520210757.GA32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-13-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200510150628.16610-13-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:21PM +0800, Changbin Du escreveu:
> This adds an option '--trace-children' to allow us trace children
> processes spawned by our target.

--inherit

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index ab76ba66bd9e..8fd95c109fe8 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -46,6 +46,7 @@ struct perf_ftrace {
>  	bool			funcgraph_tail;
>  	bool			long_info;
>  	unsigned		tracing_thresh;
> +	bool			trace_children;
>  };
>  
>  struct filter_entry {
> @@ -200,6 +201,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  	write_tracing_option_file("irq-info", "0");
>  	write_tracing_option_file("userstacktrace", "0");
>  	write_tracing_option_file("sym-userobj", "0");
> +	write_tracing_option_file("function-fork", "0");
>  }
>  
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -441,6 +443,17 @@ static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_trace_children(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->trace_children)
> +		return 0;
> +
> +	if (write_tracing_option_file("function-fork", "1") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -539,6 +552,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_trace_children(ftrace) < 0) {
> +		pr_err("failed to set tracing option function-fork\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -686,6 +704,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Show process names, PIDs, timestamps, irq-info if available"),
>  	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
>  		     "Only show functions of which the duration is greater than <n>µs"),
> +	OPT_BOOLEAN(0, "trace-children", &ftrace.trace_children,
> +		    "Trace children processes"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
