Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEE8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6494B206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594139055;
	bh=UaVq6NXc0SWYQMR92lAwPLGqN8lj9+wVijOC9r2BLxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P3mpCE4OodH0TmmY4wMEbhs4R6Mpk4bWPrP/A9lKRnnU6kH02fBbGucfIeo89VoNU
	 x/c/wSlo/sLgW9O++vcODoi9inqh61PoFzk12sYWk6ziPM6EshE0oBPQ7mXszibzOZ
	 PhXm9qia9xsk17nqvrrSmBFoj5OeeYzNdFA+CecA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGGQYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgGGQYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:24:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B83C20675;
        Tue,  7 Jul 2020 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594139052;
        bh=UaVq6NXc0SWYQMR92lAwPLGqN8lj9+wVijOC9r2BLxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwwTFk/7e9zN0g4MJS+efLH5J2ZZvXuspKvdcwrWRQmNiqRS0qSaNWyw+6PnMafUR
         RzEQW2MOh2jclE75K34LaeKiYQdZYPlJeAiN9xL9uyhO8nrmY5adX6MtkJf0sktR2R
         VwqfQ9yFtDIt2QrX1w7iRbPedNdyg+321BaO1nQ0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3A979405FF; Tue,  7 Jul 2020 13:24:10 -0300 (-03)
Date:   Tue, 7 Jul 2020 13:24:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] perf ftrace: factor out function
 write_tracing_file_int()
Message-ID: <20200707162410.GC1556@kernel.org>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-6-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627133654.64863-6-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 27, 2020 at 09:36:44PM +0800, Changbin Du escreveu:
> We will reuse this function later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index dceae70c3a22..003efa756322 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -166,6 +166,17 @@ static int read_tracing_file_to_stdout(const char *name)
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
> @@ -296,8 +307,6 @@ static void reset_tracing_filters(void)
>  
>  static int set_tracing_depth(struct perf_ftrace *ftrace)
>  {
> -	char buf[16];
> -
>  	if (ftrace->graph_depth == 0)
>  		return 0;
>  
> @@ -306,9 +315,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
>  		return -1;
>  	}
>  
> -	snprintf(buf, sizeof(buf), "%d", ftrace->graph_depth);
> -
> -	if (write_tracing_file("max_graph_depth", buf) < 0)
> +	if (write_tracing_file_int("max_graph_depth", ftrace->graph_depth) < 0)
>  		return -1;

We've been consolidating these sysfs, tracefs, debugfs, hugetlbfs, etc
in tools/lib/fs/, where we have things like:

[acme@quaco perf]$ grep "int sysfs__" tools/lib/api/fs/fs.c 
static int sysfs__read_ull_base(const char *entry,
int sysfs__read_xll(const char *entry, unsigned long long *value)
int sysfs__read_ull(const char *entry, unsigned long long *value)
int sysfs__read_int(const char *entry, int *value)
int sysfs__read_str(const char *entry, char **buf, size_t *sizep)
int sysfs__read_bool(const char *entry, bool *value)
int sysfs__write_int(const char *entry, int value)
[acme@quaco perf]$ grep "int debugfs__" tools/lib/api/fs/fs.c 
[acme@quaco perf]$ grep "int sysctl__" tools/lib/api/fs/fs.c 
int sysctl__read_int(const char *sysctl, int *value)
[acme@quaco perf]$

Please take a look at tools/lib/api/fs/fs.h it already has the functions
to find the mount points, etc, so adding those there since you're
touchign this area now seems best.

- Arnaldo
