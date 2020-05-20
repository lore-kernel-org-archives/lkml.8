Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33040C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED54E20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590009215;
	bh=h8fC05BVgyXTMfZW2gMKUk11RB5bo0QHQjDfQi04XJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=guOskDz52nAGd3sdELOYJ7jhSBxTozFg8o0+T8DHpTIxPnEARyS3N5qzaYzN+e0hZ
	 zu5/TiAP/jReWwIrSEBmyyjHDwcv6DeI0CK66w4lQv8U6PhxTNSUb0NXMOhRMvYuYD
	 +7faDSUbmplfdMgyWttFKBbhhShOwavwiZ018Gys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgETVNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:13:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 427DE207E8;
        Wed, 20 May 2020 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590009213;
        bh=h8fC05BVgyXTMfZW2gMKUk11RB5bo0QHQjDfQi04XJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLycay3TtfSKG6S+RUYkMr5TyZINOrM1gzs+mppVl3KTUH4qBT0od3ZDKLxCqudSn
         j+CHKmFa67jqXhORNvNzfJTwVSqX9u5i4LCPe6RCKwrBGBPtKZyOJDxRTiR+9S9JkY
         NkDQD4ZMU3j5rFn8gH/1XrwPuuo+YJ/krkEIJwp4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4BF3540AFD; Wed, 20 May 2020 18:13:31 -0300 (-03)
Date:   Wed, 20 May 2020 18:13:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/19] perf ftrace: add option -d/--delay to delay tracing
Message-ID: <20200520211331.GA3898@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-18-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-18-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:26PM +0800, Changbin Du escreveu:
> This adds an option '-d/--delay' to allow us to start tracing some
> times later after workload is launched.

[acme@five perf]$ perf record -h delay

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -D, --delay <n>       ms to wait before starting measurement after program start

[acme@five perf]$
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 8d04e5afe2d3..d376b37c53fc 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -49,6 +49,7 @@ struct perf_ftrace {
>  	bool			trace_children;
>  	unsigned		buffer_size_kb;
>  	bool			no_pager;
> +	unsigned		initial_delay;
>  };
>  
>  struct filter_entry {
> @@ -617,13 +618,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	/* display column headers */
>  	read_tracing_file_to_stdout("trace");
>  
> -	if (write_tracing_file("tracing_on", "1") < 0) {
> -		pr_err("can't enable tracing\n");
> -		goto out_close_fd;
> +	if (!ftrace->initial_delay) {
> +		if (write_tracing_file("tracing_on", "1") < 0) {
> +			pr_err("can't enable tracing\n");
> +			goto out_close_fd;
> +		}
>  	}
>  
>  	perf_evlist__start_workload(ftrace->evlist);
>  
> +	if (ftrace->initial_delay) {
> +		usleep(ftrace->initial_delay * 1000);
> +		if (write_tracing_file("tracing_on", "1") < 0) {
> +			pr_err("can't enable tracing\n");
> +			goto out_close_fd;
> +		}
> +	}
> +
>  	while (!done) {
>  		if (poll(&pollfd, 1, -1) < 0)
>  			break;
> @@ -747,6 +758,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "size of per cpu buffer in kb"),
>  	OPT_BOOLEAN('P', "no-pager", &ftrace.no_pager,
>  		    "Do not use pager"),
> +	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
> +		     "Wait <n> ms before tracing"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
