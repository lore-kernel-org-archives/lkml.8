Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373652073E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRaR2Pgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgFFOa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgFFOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:30:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382CEC03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:30:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so4058945pje.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q9ACHO/wqUnF1zJ7y6x8firkYJLD6+Czjoa4v+iXsOw=;
        b=dRaR2PggpUpkrojrzCcfbeVo5j59uju93fEO9CDVhTFooFQsBcSuiq6hDz85hqZmWj
         vOh9y/aJME6ffIiGynBcWATosuiUoIhImhCJ9j7KBvLe1ySIDf4jKx+j1NQt2ht+5OfN
         vZjaO3SsH+UFRKn3VbmyzIV601h/y4BsezeoJg6nz4v8a9balK2zSVrnj1r/S59c6xnC
         fo7VZ12i+QdEDsv9HK6abBHu2KfroJA9g5gsyBdRoBsfXjACbeV3Tck2C11EOFdF/pIV
         0j3fZeAYHnGqpPPsd0GZk7Gwsl9gMkuR8z8eXfe1/3OlO3W7aa2b7l2VwxwFCM7VFox3
         Yr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9ACHO/wqUnF1zJ7y6x8firkYJLD6+Czjoa4v+iXsOw=;
        b=daWy9al9AAAIk5/tShjv91kJySUzhHqxmPn31dO+D01CNPiEBTfCHLTNMgU234mwH4
         k1tuZdQowCcMIWFwhFNPGrVPSLcQjBx6Hehw9Bsc+Z+fEilbn514AM9vLmKffZDRwJZ3
         wcZMpr4QjS8CvfBcKur0boe+pjW9E/HgdFnfxCIe0Vo6me81JngXxzTEt2o7oBhfFH5/
         et/oIZtx2y3dZThTMmUPmtBsUy0/UXc2nxmtTKCwwRd+HNwWHzDk195+kmAI1TtpUwFo
         OUjHbNsHCh6Ea44/QNQmicJBJl/rfp0tS2khA1XMJbJq3FiYcKrP784Vs1x219AebwtY
         gmEw==
X-Gm-Message-State: AOAM531ftpJygq017i/Rlknkj6rAAchxTPo5eHscUCTFB9tLsnmizFO8
        /5uJ4VciN89Ta2T7Yg0oIGA=
X-Google-Smtp-Source: ABdhPJzypgnds9sW1mosLPOWtZWuJOr8jl8jHopAWfr0CdUH6kjgkY+8WnComQ0NF7G3L86B8ezL9w==
X-Received: by 2002:a17:902:74cb:: with SMTP id f11mr14083386plt.239.1591453857699;
        Sat, 06 Jun 2020 07:30:57 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id j19sm2519104pfn.109.2020.06.06.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:30:56 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:30:49 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/19] perf ftrace: add option -d/--delay to delay tracing
Message-ID: <20200606143049.xvszf32j2bbpi4yx@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-18-changbin.du@gmail.com>
 <20200520211331.GA3898@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520211331.GA3898@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:13:31PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:26PM +0800, Changbin Du escreveu:
> > This adds an option '-d/--delay' to allow us to start tracing some
> > times later after workload is launched.
> 
> [acme@five perf]$ perf record -h delay
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -D, --delay <n>       ms to wait before starting measurement after program start
> 
> [acme@five perf]$
>
Sure, will change the short option name.

> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 8d04e5afe2d3..d376b37c53fc 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -49,6 +49,7 @@ struct perf_ftrace {
> >  	bool			trace_children;
> >  	unsigned		buffer_size_kb;
> >  	bool			no_pager;
> > +	unsigned		initial_delay;
> >  };
> >  
> >  struct filter_entry {
> > @@ -617,13 +618,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  	/* display column headers */
> >  	read_tracing_file_to_stdout("trace");
> >  
> > -	if (write_tracing_file("tracing_on", "1") < 0) {
> > -		pr_err("can't enable tracing\n");
> > -		goto out_close_fd;
> > +	if (!ftrace->initial_delay) {
> > +		if (write_tracing_file("tracing_on", "1") < 0) {
> > +			pr_err("can't enable tracing\n");
> > +			goto out_close_fd;
> > +		}
> >  	}
> >  
> >  	perf_evlist__start_workload(ftrace->evlist);
> >  
> > +	if (ftrace->initial_delay) {
> > +		usleep(ftrace->initial_delay * 1000);
> > +		if (write_tracing_file("tracing_on", "1") < 0) {
> > +			pr_err("can't enable tracing\n");
> > +			goto out_close_fd;
> > +		}
> > +	}
> > +
> >  	while (!done) {
> >  		if (poll(&pollfd, 1, -1) < 0)
> >  			break;
> > @@ -747,6 +758,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		     "size of per cpu buffer in kb"),
> >  	OPT_BOOLEAN('P', "no-pager", &ftrace.no_pager,
> >  		    "Do not use pager"),
> > +	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
> > +		     "Wait <n> ms before tracing"),
> >  	OPT_END()
> >  	};
> >  
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
