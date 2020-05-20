Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576EC20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008898;
	bh=c0V7GL4Nb2G+qi++78RB/y2wHCzv87xFGlB6Wz+fgi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=izzbSyj3ILYPZ9oVZ5ZaVxahLrbOojkGSek4M2tt4KFlTV37TZPoxLu1ZqujGUlIe
	 h0ubc3diSJOSzVvJxjrtHrdDrKqeIOzsePAxVdwWPmvjMAjIbHmpXR2KAFFdlKtqxO
	 byzH9o8L3LbEM2GQT+HpNGV1NMDwFIM2SylRlYYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgETVIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:08:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835FC207E8;
        Wed, 20 May 2020 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008896;
        bh=c0V7GL4Nb2G+qi++78RB/y2wHCzv87xFGlB6Wz+fgi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWvh2OYjJ8q4o1t8obrsRMY94HKGKV8cmHxBBxtVQee24+dPxXoP/SShe7Zvq6isG
         6rAsKIlc6nC2z6lk9ifH//A7oAxdgvKYPcEhPxRAkw5CdCjUxlJmCOt1dXlY0u7iMc
         IQnWZVIf7YA5z4AkFfNWujMNARHFKrf3pY//W8fQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5DB440AFD; Wed, 20 May 2020 18:08:14 -0300 (-03)
Date:   Wed, 20 May 2020 18:08:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] perf ftrace: add option '-b/--buffer-size' to set
 per-cpu buffer size
Message-ID: <20200520210814.GB32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-14-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200510150628.16610-14-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:22PM +0800, Changbin Du escreveu:
> This adds an option '-b/--buffer-size' to allow us set the size of per-cpu
> tracing buffer.

-m
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 45 ++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 8fd95c109fe8..a93fbdac6aa4 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -47,6 +47,7 @@ struct perf_ftrace {
>  	bool			long_info;
>  	unsigned		tracing_thresh;
>  	bool			trace_children;
> +	unsigned		buffer_size_kb;
>  };
>  
>  struct filter_entry {
> @@ -187,6 +188,17 @@ static int read_tracing_file_to_stdout(const char *name)
>  	return ret;
>  }
>  
> +static int write_tracing_file_int(const char *name, int value)
> +{
> +	char buf[16];
> +
> +	snprintf(buf, sizeof(buf), "%d", value);
> +	if (write_tracing_file(name, buf) < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int reset_tracing_cpu(void);
>  static void reset_tracing_filters(void);
>  
> @@ -360,8 +372,6 @@ static void reset_tracing_filters(void)
>  
>  static int set_tracing_depth(struct perf_ftrace *ftrace)
>  {
> -	char buf[16];
> -
>  	if (ftrace->graph_depth == 0)
>  		return 0;
>  
> @@ -370,9 +380,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
>  		return -1;
>  	}
>  
> -	snprintf(buf, sizeof(buf), "%d", ftrace->graph_depth);
> -
> -	if (write_tracing_file("max_graph_depth", buf) < 0)
> +	if (write_tracing_file_int("max_graph_depth", ftrace->graph_depth) < 0)
>  		return -1;
>  
>  	return 0;
> @@ -419,14 +427,10 @@ static int set_tracing_long_info(struct perf_ftrace *ftrace)
>  
>  static int set_tracing_thresh(struct perf_ftrace *ftrace)
>  {
> -	char buf[16];
> -
>  	if (ftrace->tracing_thresh == 0)
>  		return 0;
>  
> -	snprintf(buf, sizeof(buf), "%d", ftrace->tracing_thresh);
> -
> -	if (write_tracing_file("tracing_thresh", buf) < 0)
> +	if (write_tracing_file_int("tracing_thresh", ftrace->tracing_thresh) < 0)
>  		return -1;
>  
>  	return 0;
> @@ -454,6 +458,20 @@ static int set_tracing_trace_children(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_buffer_size_kb(struct perf_ftrace *ftrace)
> +{
> +	int ret;
> +
> +	if (ftrace->buffer_size_kb == 0)
> +		return 0;
> +
> +	ret = write_tracing_file_int("buffer_size_kb", ftrace->buffer_size_kb);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -557,6 +575,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_buffer_size_kb(ftrace) < 0) {
> +		pr_err("failed to set tracing per-cpu buffer size\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -706,6 +729,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "Only show functions of which the duration is greater than <n>µs"),
>  	OPT_BOOLEAN(0, "trace-children", &ftrace.trace_children,
>  		    "Trace children processes"),
> +	OPT_UINTEGER('b', "buffer-size", &ftrace.buffer_size_kb,
> +		     "size of per cpu buffer in kb"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
