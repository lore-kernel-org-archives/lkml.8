Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52BAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774B2206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plqeZHsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGJNPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgGJNPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:15:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B3C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:15:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so2230516pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g8xtd7zhQVNGIjEK9Fl8Rtctg5K/7TddoLm/+Jva81I=;
        b=plqeZHsnbyfq16f826KOUC1+ujd6YdGAePKrMa8/41ZaA5spKLuBB9HW4bFp9G/pxH
         Q+YRCKfC6lzov7L4JJBqyrREq9ae5ZIddaRstbWzFbbYh1410hxE28brqjSz0zu8Tuhr
         6OtbN8QMt/tcXcRemKmfrWZzEjuoHdmYXT0C5vSqb1cNeHSCwWNJwivqCopN5l3nROQd
         ZJ6tt1sJYj86Sy/YVMBBbAudvUYtdvx7XyJSi5YBFT0xzT/VcJw05Ky/gIhRrA6jDagm
         mCp7pwBPikkYZosbzBeufm/ni1r+BDLdRy/pXYKXVl4EJQE/LKe70yFtzAzzOaQ2tRiO
         w54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g8xtd7zhQVNGIjEK9Fl8Rtctg5K/7TddoLm/+Jva81I=;
        b=SP58L2M2DmVQQLqyu4lx6iJLAWHUeJyiu2zWl1Buq9eL+YYVubB24kIhzViEq8dTK3
         v/UD0qkN73CnLUT8naBtfBLu4QnYGsplG790gd9E+CC5wxe9Y/b/61HIpdI1U2dpYe/p
         PRSr4iqFaaev+nX2ZIJ5NibNoxb1oVfF6lLfH1ZzprJh5MyMq5UlW+reZfiqixCL6sc7
         xCr/6w3B90cs4DbH/nG+n28xgEJqyzB6rBhc0B4SP+jFNy2epSFBOldXSBJxkKeO0FOb
         df+1hBVY2vNVLPrv6ejLojdDTKtWSJ/3hH/k///xcqGZKyuwhkDNEnVpcJzRthT0FTct
         hHJw==
X-Gm-Message-State: AOAM532szs14ZpMNa7X9A7mrhc3BsVviJUOpXdw8hzDr/UE1GZOFmE7T
        n1Y2ecmblFpZCcZcZnVWSRM=
X-Google-Smtp-Source: ABdhPJyM19DC6JB9XOApeebFjGYpLG1p2SeeCr3LxiIrNLZjfpKc+oOGOKe6IKmv2JgK+X7/WjY0jg==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr56173472plr.4.1594386902058;
        Fri, 10 Jul 2020 06:15:02 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 207sm6177859pfa.100.2020.07.10.06.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:15:01 -0700 (PDT)
Date:   Fri, 10 Jul 2020 21:14:53 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/17] perf: util: add general function to parse
 sublevel options
Message-ID: <20200710131453.xnhmpeenprfqcvic@mail.google.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
 <20200708164605.31245-10-changbin.du@gmail.com>
 <20200708173423.GC22437@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708173423.GC22437@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:34:23PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 09, 2020 at 12:45:57AM +0800, Changbin Du escreveu:
> > This factors out a general function perf_parse_sublevel_options() to parse
> > sublevel options. The 'sublevel' options is something like the '--debug'
> > options which allow more sublevel options.
> 
> Please don't add stuff to util.h/util.c, its too generic a name and
> we've been trying to move things to more appropriate locations, so
> follow the example of:
> 
>   [acme@quaco perf]$ ls -la tools/perf/util/parse-regs-options.*
>   -rw-rw-r--. 1 acme acme 1932 Feb 12 15:11 tools/perf/util/parse-regs-options.c
>   -rw-rw-r--. 1 acme acme  316 Dec 20  2019 tools/perf/util/parse-regs-options.h
>   [acme@quaco perf]$
>
I crated files util/parse-sublevel-options.c and util/parse-sublevel-options.h
to hold this new function.

> Good job identifying this code and reusing it!
> 
> - Arnaldo
>  
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/util/debug.c | 61 ++++++++++++-----------------------------
> >  tools/perf/util/util.c  | 56 +++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/util.h  |  7 +++++
> >  3 files changed, 80 insertions(+), 44 deletions(-)
> > 
> > diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> > index adb656745ecc..79999c57a609 100644
> > --- a/tools/perf/util/debug.c
> > +++ b/tools/perf/util/debug.c
> > @@ -20,6 +20,7 @@
> >  #include "target.h"
> >  #include "ui/helpline.h"
> >  #include "ui/ui.h"
> > +#include "util/util.h"
> >  
> >  #include <linux/ctype.h>
> >  
> > @@ -173,65 +174,37 @@ void trace_event(union perf_event *event)
> >  		     trace_event_printer, event);
> >  }
> >  
> > -static struct debug_variable {
> > -	const char *name;
> > -	int *ptr;
> > -} debug_variables[] = {
> > -	{ .name = "verbose",		.ptr = &verbose },
> > -	{ .name = "ordered-events",	.ptr = &debug_ordered_events},
> > -	{ .name = "stderr",		.ptr = &redirect_to_stderr},
> > -	{ .name = "data-convert",	.ptr = &debug_data_convert },
> > -	{ .name = "perf-event-open",	.ptr = &debug_peo_args },
> > +static struct sublevel_option debug_opts[] = {
> > +	{ .name = "verbose",		.value_ptr = &verbose },
> > +	{ .name = "ordered-events",	.value_ptr = &debug_ordered_events},
> > +	{ .name = "stderr",		.value_ptr = &redirect_to_stderr},
> > +	{ .name = "data-convert",	.value_ptr = &debug_data_convert },
> > +	{ .name = "perf-event-open",	.value_ptr = &debug_peo_args },
> >  	{ .name = NULL, }
> >  };
> >  
> >  int perf_debug_option(const char *str)
> >  {
> > -	struct debug_variable *var = &debug_variables[0];
> > -	char *vstr, *s = strdup(str);
> > -	int v = 1;
> > -
> > -	vstr = strchr(s, '=');
> > -	if (vstr)
> > -		*vstr++ = 0;
> > -
> > -	while (var->name) {
> > -		if (!strcmp(s, var->name))
> > -			break;
> > -		var++;
> > -	}
> > -
> > -	if (!var->name) {
> > -		pr_err("Unknown debug variable name '%s'\n", s);
> > -		free(s);
> > -		return -1;
> > -	}
> > +	int ret;
> >  
> > -	if (vstr) {
> > -		v = atoi(vstr);
> > -		/*
> > -		 * Allow only values in range (0, 10),
> > -		 * otherwise set 0.
> > -		 */
> > -		v = (v < 0) || (v > 10) ? 0 : v;
> > -	}
> > +	ret = perf_parse_sublevel_options(str, debug_opts);
> > +	if (ret)
> > +		return ret;
> >  
> > -	if (quiet)
> > -		v = -1;
> > +	/* Allow only verbose value in range (0, 10), otherwise set 0. */
> > +	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
> >  
> > -	*var->ptr = v;
> > -	free(s);
> >  	return 0;
> >  }
> >  
> >  int perf_quiet_option(void)
> >  {
> > -	struct debug_variable *var = &debug_variables[0];
> > +	struct sublevel_option *opt = &debug_opts[0];
> >  
> >  	/* disable all debug messages */
> > -	while (var->name) {
> > -		*var->ptr = -1;
> > -		var++;
> > +	while (opt->name) {
> > +		*opt->value_ptr = -1;
> > +		opt++;
> >  	}
> >  
> >  	return 0;
> > diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> > index 37a9492edb3e..7e532a93835b 100644
> > --- a/tools/perf/util/util.c
> > +++ b/tools/perf/util/util.c
> > @@ -416,3 +416,59 @@ char *perf_exe(char *buf, int len)
> >  	}
> >  	return strcpy(buf, "perf");
> >  }
> > +
> > +static int parse_one_sublevel_option(const char *str,
> > +				     struct sublevel_option *opts)
> > +{
> > +	struct sublevel_option *opt = &opts[0];
> > +	char *vstr, *s = strdup(str);
> > +	int v = 1;
> > +
> > +	vstr = strchr(s, '=');
> > +	if (vstr)
> > +		*vstr++ = 0;
> > +
> > +	while (opt->name) {
> > +		if (!strcmp(s, opt->name))
> > +			break;
> > +		opt++;
> > +	}
> > +
> > +	if (!opt->name) {
> > +		pr_err("Unknown option name '%s'\n", s);
> > +		free(s);
> > +		return -1;
> > +	}
> > +
> > +	if (vstr)
> > +		v = atoi(vstr);
> > +
> > +	*opt->value_ptr = v;
> > +	free(s);
> > +	return 0;
> > +}
> > +
> > +/* parse options like --foo a=<n>,b,c... */
> > +int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts)
> > +{
> > +	char *s = strdup(str);
> > +	char *p = NULL;
> > +	int ret;
> > +
> > +	if (!s)
> > +		return -1;
> > +
> > +	p = strtok(s, ",");
> > +	while (p) {
> > +		ret = parse_one_sublevel_option(p, opts);
> > +		if (ret) {
> > +			free(s);
> > +			return ret;
> > +		}
> > +
> > +		p = strtok(NULL, ",");
> > +	}
> > +
> > +	free(s);
> > +	return 0;
> > +}
> > \ No newline at end of file
> > diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> > index f486fdd3a538..8cb1f980935c 100644
> > --- a/tools/perf/util/util.h
> > +++ b/tools/perf/util/util.h
> > @@ -52,6 +52,13 @@ void perf_set_multithreaded(void);
> >  
> >  char *perf_exe(char *buf, int len);
> >  
> > +struct sublevel_option {
> > +	const char *name;
> > +	int *value_ptr;
> > +};
> > +
> > +int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
> > +
> >  #ifndef O_CLOEXEC
> >  #ifdef __sparc__
> >  #define O_CLOEXEC      0x400000
> > -- 
> > 2.25.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
