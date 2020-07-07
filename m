Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE7CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D792073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGGQJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGQJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:09:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35872065D;
        Tue,  7 Jul 2020 16:09:24 +0000 (UTC)
Date:   Tue, 7 Jul 2020 12:09:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] perf ftrace: factor out function
 write_tracing_file_int()
Message-ID: <20200707120923.26f7e349@oasis.local.home>
In-Reply-To: <20200627133654.64863-6-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
        <20200627133654.64863-6-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 21:36:44 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> We will reuse this function later.
> 

BTW, trace-cmd.git now has a libtracefs.so library, which I'm hoping
within a month to have as a stand alone (probably along with
libtraceevent and even a libtracecmd).

  https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tree/lib/tracefs

This is a library made to interact with the tracefs directory to remove
reimplementing it all over the place.

-- Steve



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
>  
>  	return 0;

