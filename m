Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A63C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF61206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594230006;
	bh=7TgncNd/NiqsO4GHRPNVvOVc8k/5wsVCi7xJttR0ikw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NnSW50ueB7xmwawKZ3daCTw66/hehWf5gztOTA0yjURT2EZhA0RU6WduEe2l9g7Q9
	 QSDkGX24FfjiWxi5mPlNvJnpTlSaUoO4Ia0KwCQGSLC+X5hFCxTGykE5CkXmYLmN8C
	 j06IQbaNNgtXkyQqwTjZQlRH8vFZUn9kpMOpq5WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGHRkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgGHRkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:40:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40CA206DF;
        Wed,  8 Jul 2020 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594230001;
        bh=7TgncNd/NiqsO4GHRPNVvOVc8k/5wsVCi7xJttR0ikw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0OLVTowkUjHuyrAqJ7KIT/kZgGn8HvzUTWLqt6XaIK3hF6N385o4HxDh3gtt9Cjz
         iMWKk+S5TbzM2ov3JuPVD178v51LlCkSGwBsy0fToOSLu4RMXSBgJDWGdyPdCuBXGt
         hYtobqOuLTK2AE6226Phulx6iKpglcIMQUh+Vv8g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF4DF405FF; Wed,  8 Jul 2020 14:39:59 -0300 (-03)
Date:   Wed, 8 Jul 2020 14:39:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/17] perf: ftrace enhancement
Message-ID: <20200708173959.GD22437@kernel.org>
References: <20200708164605.31245-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 09, 2020 at 12:45:48AM +0800, Changbin Du escreveu:
> Here is a glance of all ftrace functions with this serias:
> 
> $ sudo perf ftrace -h
 
>  Usage: perf ftrace [<options>] [<command>]
>     or: perf ftrace [<options>] -- <command> [<options>]
> 
>     -a, --all-cpus        system-wide collection from all CPUs
>     -C, --cpu <cpu>       list of cpus to monitor
>     -d, --delay <n>       ms to wait before starting tracing after program start
>     -D, --graph-depth <n>
>                           Max depth for function graph tracer (This option is deprecated)
>     -F, --funcs           Show available functions to filter
>     -G, --graph-funcs <func>
>                           trace given functions using function_graph tracer
>     -g, --nograph-funcs <func>
>                           Set nograph filter on given functions
>     -m, --buffer-size <size>
>                           size of per cpu buffer
>     -N, --notrace-funcs <func>
>                           do not trace given functions
>     -p, --pid <pid>       trace on existing process id
>     -t, --tid <tid>       trace on existing thread id (exclusive to --pid)
>     -T, --trace-funcs <func>
>                           trace given functions using function tracer
>     -t, --tracer <tracer>
>                           tracer to use: function or function_graph (This option is deprecated)
>     -v, --verbose         be more verbose
>         --func-opts <options>
>                           function tracer options, available options: call-graph,irq-info
>         --graph-opts <options>
>                           graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>
>         --inherit         trace children processes
> 
> v3:
>   o add --func-opts and --graph-opts to set tracer specific options.
>   o support units as a suffix for option '-m/--buffer-size'.

Thanks for working on this! -d/--delay:

[acme@quaco perf]$ perf record -h delay

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -D, --delay <n>       ms to wait before starting measurement after program start

[acme@quaco perf]$

[acme@quaco perf]$ perf stat -h --delay

 Usage: perf stat [<options>] [<command>]

    -D, --delay <n>       ms to wait before starting measurement after program start

[acme@quaco perf]$

[acme@quaco perf]$ perf trace -h -D

 Usage: perf trace [<options>] [<command>]
    or: perf trace [<options>] -- <command> [<options>]
    or: perf trace record [<options>] [<command>]
    or: perf trace record [<options>] -- <command> [<options>]

    -D, --delay <n>       ms to wait before starting measurement after program start

Perhaps we can move --graph-depth to --graph-opts and make -D/--delay be
just like with 'perf record', 'perf stat' and 'perf trace'?

Will be super nice if one can go from:

	perf stat --delay 100 workload

to see the default set of counters to:

	perf ftrace --delay 100 workload

to get the ftrace output for that.

Ditto seeing the syscalls strace-like with:

	perf trace --delay 100 workload

Regards,

- Arnaldo
