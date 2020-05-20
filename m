Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E99C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5D52084C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590009151;
	bh=zLuusxvkC3SyINCgh0xthoz+hc/q1pInV443m0AO10A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rNI/gqfH5e9m17oxj4WmC3M/ilLoueqCLVDXAs6d8nAUygCZ3eg3GmVIO7mjyPbG/
	 4A9Hx4OFnIb1U5H7DXgoo6evBguxofF3jBwVU4wwRJZ9pOp/wCNrrfILLd6RH88fBP
	 W2XU+UWFwXSEJiIGhGuE1GWrKccouIDbJP5MIv/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgETVMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:12:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A85B207E8;
        Wed, 20 May 2020 21:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590009150;
        bh=zLuusxvkC3SyINCgh0xthoz+hc/q1pInV443m0AO10A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sj9iEj94CxDfU5vwFNq0cHwmX8CyIAFqswgo9D+tK56EkCGAS37Bxte6eQaJyka4F
         doxTjqswFaaXcd9IsCCG3QQaGKdtz1TmH8MEdcDKik/mw4UOVO36nOyb+VdLo41LsM
         m/DXofwQqusL1ChxV6Vp6JrFys1BIrWunQjkLLsk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E04E40AFD; Wed, 20 May 2020 18:12:28 -0300 (-03)
Date:   Wed, 20 May 2020 18:12:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/19] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200520211228.GE32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-17-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-17-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:25PM +0800, Changbin Du escreveu:
> This allows us to trace single thread instead of the whole process.

I was going to adjust the patch to add, but you forgot to add the entry
to tools/perf/Documentation/perf-ftrace.txt,

Please do so,

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 0b39b6a88026..8d04e5afe2d3 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -707,6 +707,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "List available functions to filter"),
>  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>  		   "trace on existing process id"),
> +	OPT_STRING('t', "tid", &ftrace.target.tid, "tid",
> +		   "trace on existing thread id (exclusive to --pid)"),
>  	OPT_INCR('v', "verbose", &verbose,
>  		 "be more verbose"),
>  	OPT_BOOLEAN('a', "all-cpus", &ftrace.target.system_wide,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
