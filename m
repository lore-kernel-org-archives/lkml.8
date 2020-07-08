Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B78C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFD220786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594229668;
	bh=egVfuy6iOekqiSH22QXuiFu08jOEbh0iJ7MSMjUwZLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v84D1FvAj0hcnn+dQ/TdjM/FAdkXcJKQVpouC7HnD1yr4D3aaI/zOSha7bLeq1hNF
	 uArKVDVpFpKkZgATmzdwGIbESCY20bDYCsGSoYzw0YfLwwsWQN6hdO9fmCwFqLEGcN
	 CPhXNxF9KMoB8CMf0kDMzf9uCg4tbe7pCjeEcJOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgGHRe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGHRe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:34:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0962C206F6;
        Wed,  8 Jul 2020 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594229665;
        bh=egVfuy6iOekqiSH22QXuiFu08jOEbh0iJ7MSMjUwZLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOV8VbXOhu9siNg5AI14LM0vN/dqQHHU1SXSh/uAmQCScGtSUQMEroHoSEgrgSl2R
         94oeTrtBAGDl3AIF5gXSz085WluYp2mRwcIgG0eJ1X/8kTyr1fj5V4mcaufPrw3KJ+
         yZRPGpGIyVZi5QUwxZzDN0Ui0nmUoB6HiQbL88uA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 17CC5405FF; Wed,  8 Jul 2020 14:34:23 -0300 (-03)
Date:   Wed, 8 Jul 2020 14:34:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/17] perf: util: add general function to parse
 sublevel options
Message-ID: <20200708173423.GC22437@kernel.org>
References: <20200708164605.31245-1-changbin.du@gmail.com>
 <20200708164605.31245-10-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708164605.31245-10-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 09, 2020 at 12:45:57AM +0800, Changbin Du escreveu:
> This factors out a general function perf_parse_sublevel_options() to parse
> sublevel options. The 'sublevel' options is something like the '--debug'
> options which allow more sublevel options.

Please don't add stuff to util.h/util.c, its too generic a name and
we've been trying to move things to more appropriate locations, so
follow the example of:

  [acme@quaco perf]$ ls -la tools/perf/util/parse-regs-options.*
  -rw-rw-r--. 1 acme acme 1932 Feb 12 15:11 tools/perf/util/parse-regs-options.c
  -rw-rw-r--. 1 acme acme  316 Dec 20  2019 tools/perf/util/parse-regs-options.h
  [acme@quaco perf]$
 
Good job identifying this code and reusing it!

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/util/debug.c | 61 ++++++++++++-----------------------------
>  tools/perf/util/util.c  | 56 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/util.h  |  7 +++++
>  3 files changed, 80 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index adb656745ecc..79999c57a609 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -20,6 +20,7 @@
>  #include "target.h"
>  #include "ui/helpline.h"
>  #include "ui/ui.h"
> +#include "util/util.h"
>  
>  #include <linux/ctype.h>
>  
> @@ -173,65 +174,37 @@ void trace_event(union perf_event *event)
>  		     trace_event_printer, event);
>  }
>  
> -static struct debug_variable {
> -	const char *name;
> -	int *ptr;
> -} debug_variables[] = {
> -	{ .name = "verbose",		.ptr = &verbose },
> -	{ .name = "ordered-events",	.ptr = &debug_ordered_events},
> -	{ .name = "stderr",		.ptr = &redirect_to_stderr},
> -	{ .name = "data-convert",	.ptr = &debug_data_convert },
> -	{ .name = "perf-event-open",	.ptr = &debug_peo_args },
> +static struct sublevel_option debug_opts[] = {
> +	{ .name = "verbose",		.value_ptr = &verbose },
> +	{ .name = "ordered-events",	.value_ptr = &debug_ordered_events},
> +	{ .name = "stderr",		.value_ptr = &redirect_to_stderr},
> +	{ .name = "data-convert",	.value_ptr = &debug_data_convert },
> +	{ .name = "perf-event-open",	.value_ptr = &debug_peo_args },
>  	{ .name = NULL, }
>  };
>  
>  int perf_debug_option(const char *str)
>  {
> -	struct debug_variable *var = &debug_variables[0];
> -	char *vstr, *s = strdup(str);
> -	int v = 1;
> -
> -	vstr = strchr(s, '=');
> -	if (vstr)
> -		*vstr++ = 0;
> -
> -	while (var->name) {
> -		if (!strcmp(s, var->name))
> -			break;
> -		var++;
> -	}
> -
> -	if (!var->name) {
> -		pr_err("Unknown debug variable name '%s'\n", s);
> -		free(s);
> -		return -1;
> -	}
> +	int ret;
>  
> -	if (vstr) {
> -		v = atoi(vstr);
> -		/*
> -		 * Allow only values in range (0, 10),
> -		 * otherwise set 0.
> -		 */
> -		v = (v < 0) || (v > 10) ? 0 : v;
> -	}
> +	ret = perf_parse_sublevel_options(str, debug_opts);
> +	if (ret)
> +		return ret;
>  
> -	if (quiet)
> -		v = -1;
> +	/* Allow only verbose value in range (0, 10), otherwise set 0. */
> +	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
>  
> -	*var->ptr = v;
> -	free(s);
>  	return 0;
>  }
>  
>  int perf_quiet_option(void)
>  {
> -	struct debug_variable *var = &debug_variables[0];
> +	struct sublevel_option *opt = &debug_opts[0];
>  
>  	/* disable all debug messages */
> -	while (var->name) {
> -		*var->ptr = -1;
> -		var++;
> +	while (opt->name) {
> +		*opt->value_ptr = -1;
> +		opt++;
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 37a9492edb3e..7e532a93835b 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -416,3 +416,59 @@ char *perf_exe(char *buf, int len)
>  	}
>  	return strcpy(buf, "perf");
>  }
> +
> +static int parse_one_sublevel_option(const char *str,
> +				     struct sublevel_option *opts)
> +{
> +	struct sublevel_option *opt = &opts[0];
> +	char *vstr, *s = strdup(str);
> +	int v = 1;
> +
> +	vstr = strchr(s, '=');
> +	if (vstr)
> +		*vstr++ = 0;
> +
> +	while (opt->name) {
> +		if (!strcmp(s, opt->name))
> +			break;
> +		opt++;
> +	}
> +
> +	if (!opt->name) {
> +		pr_err("Unknown option name '%s'\n", s);
> +		free(s);
> +		return -1;
> +	}
> +
> +	if (vstr)
> +		v = atoi(vstr);
> +
> +	*opt->value_ptr = v;
> +	free(s);
> +	return 0;
> +}
> +
> +/* parse options like --foo a=<n>,b,c... */
> +int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts)
> +{
> +	char *s = strdup(str);
> +	char *p = NULL;
> +	int ret;
> +
> +	if (!s)
> +		return -1;
> +
> +	p = strtok(s, ",");
> +	while (p) {
> +		ret = parse_one_sublevel_option(p, opts);
> +		if (ret) {
> +			free(s);
> +			return ret;
> +		}
> +
> +		p = strtok(NULL, ",");
> +	}
> +
> +	free(s);
> +	return 0;
> +}
> \ No newline at end of file
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index f486fdd3a538..8cb1f980935c 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -52,6 +52,13 @@ void perf_set_multithreaded(void);
>  
>  char *perf_exe(char *buf, int len);
>  
> +struct sublevel_option {
> +	const char *name;
> +	int *value_ptr;
> +};
> +
> +int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
> +
>  #ifndef O_CLOEXEC
>  #ifdef __sparc__
>  #define O_CLOEXEC      0x400000
> -- 
> 2.25.1
> 

-- 

- Arnaldo
