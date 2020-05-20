Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A63C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D292084C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590009065;
	bh=hflv9D/ewCbvGOGfUbWrB/6ZmXnSpNbs2fD9e+QeJ94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sRrAtYMzSa0yM5evf0NlqZsc6qoaQWhAEqTrkXAWYSTZfK4XNB543k3FxmKomQcUV
	 4fpl/y2xvLlLk6M31ucrjX/pfQF57HzqnYkScyNVyhgddL5yX3nzOna1MppKiEjkMa
	 /CZd9ffNYcmflbQ51tIxNWx2gjknz+dqqNQ1k1Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgETVLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:11:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB063207E8;
        Wed, 20 May 2020 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590009063;
        bh=hflv9D/ewCbvGOGfUbWrB/6ZmXnSpNbs2fD9e+QeJ94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0TTT5R8xkRSeM2zQlQhvG253SvNDGItqkYE38QJNR6i1n3ybBIwCqw2t1+CdtWxb
         Q9rjhFYKJosr2calfx4BsUyiwyEf6pxMknMHs7JblAqqZjBZCxGZ21i48c6lDyZwGe
         WwNZoMerkMWZeisk6P/c7v0hqiaTDB0rfgC3ci1w=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF32740AFD; Wed, 20 May 2020 18:11:01 -0300 (-03)
Date:   Wed, 20 May 2020 18:11:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/19] perf ftrace: show trace column header
Message-ID: <20200520211101.GD32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-16-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-16-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:24PM +0800, Changbin Du escreveu:
> This makes perf-ftrace display column header before printing trace.

[acme@five perf]$ perf report -h header

 Usage: perf report [<options>]

        --header          Show data header.
        --header-only     Show only data header.

[acme@five perf]$

Perhaps there is value in --header-only to show the default that will be
setup when using some set of options.

- Arnaldo

> $ sudo perf ftrace
> \# tracer: function
> \#
> \# entries-in-buffer/entries-written: 0/0   #P:8
> \#
> \#           TASK-PID     CPU#   TIMESTAMP  FUNCTION
> \#              | |         |       |         |
>            <...>-9246  [006]  10726.262760: mutex_unlock <-rb_simple_write
>            <...>-9246  [006]  10726.262764: __fsnotify_parent <-vfs_write
>            <...>-9246  [006]  10726.262765: fsnotify <-vfs_write
>            <...>-9246  [006]  10726.262766: __sb_end_write <-vfs_write
>            <...>-9246  [006]  10726.262767: fpregs_assert_state_consistent <-do_syscall_64
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 64c22f367ba2..0b39b6a88026 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -614,6 +614,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
>  	pollfd.fd = trace_fd;
>  
> +	/* display column headers */
> +	read_tracing_file_to_stdout("trace");
> +
>  	if (write_tracing_file("tracing_on", "1") < 0) {
>  		pr_err("can't enable tracing\n");
>  		goto out_close_fd;
> -- 
> 2.25.1
> 

-- 

- Arnaldo
