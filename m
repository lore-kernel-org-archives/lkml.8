Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF6CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A5F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008595;
	bh=SBUiOIx2KjFTYdpaOV6/FsM6KzAmcEnDPhSPp16qsvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cg+ffx9HbKpXuIMBlidaCe7lTAlTkOnlxKemPCXpi481YLD9noq7YBkLGQITJBQVQ
	 iFgXCMIZf/oXLtmpLLzdDu4snuk5mG7AnuWFoj168LV4Ekq0MfYWU0RLQpkH18PsdL
	 GK8WZ8iDfyw4ikHfFVPO3uFpFZH23Aw5mC9wER1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgETVDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:03:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FAA42084C;
        Wed, 20 May 2020 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008593;
        bh=SBUiOIx2KjFTYdpaOV6/FsM6KzAmcEnDPhSPp16qsvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHlXw6xxm/weg4Uhvcy011U1a3gw3idnijKcdJeb0AjynRsRfro7/SYsE6+e/HY9z
         2A1/hYUlrMsQxsCZjV29VwRTFjfbKGi3WeebzEn9668nbP2DflzCxe5mk38DX2y2yg
         x7MzBeB3vviOy1hVRoqTjJMKBOPciXz1omQTKoIc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2FBB40AFD; Wed, 20 May 2020 18:03:11 -0300 (-03)
Date:   Wed, 20 May 2020 18:03:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/19] perf ftrace: add support for trace option
 tracing_thresh
Message-ID: <20200520210311.GW32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-10-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200510150628.16610-10-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:18PM +0800, Changbin Du escreveu:
> This adds an option '--tracing-thresh' to setup trace duration threshold
> for funcgraph tracer.

Ditto
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index f11f2d3431b0..20bc14d6c5fb 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -43,6 +43,7 @@ struct perf_ftrace {
>  	bool			nosleep_time;
>  	bool			nofuncgraph_irqs;
>  	bool			long_info;
> +	unsigned		tracing_thresh;
>  };
>  
>  struct filter_entry {
> @@ -213,6 +214,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  	if (write_tracing_file("max_graph_depth", "0") < 0)
>  		return -1;
>  
> +	if (write_tracing_file("tracing_thresh", "0") < 0)
> +		return -1;
> +
>  	reset_tracing_filters();
>  	reset_tracing_options(ftrace);
>  	return 0;
> @@ -392,6 +396,21 @@ static int set_tracing_long_info(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_thresh(struct perf_ftrace *ftrace)
> +{
> +	char buf[16];
> +
> +	if (ftrace->tracing_thresh == 0)
> +		return 0;
> +
> +	snprintf(buf, sizeof(buf), "%d", ftrace->tracing_thresh);
> +
> +	if (write_tracing_file("tracing_thresh", buf) < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -475,6 +494,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_thresh(ftrace) < 0) {
> +		pr_err("failed to set tracing thresh\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -616,6 +640,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Ignore functions that happen inside interrupt (function_graph only)"),
>  	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
>  		    "Show process names, PIDs, timestamps, irq-info if available"),
> +	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
> +		     "Only show functions of which the duration is greater than <n>µs"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
