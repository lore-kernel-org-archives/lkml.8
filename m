Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3104FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0767120723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKtjjgSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgFFOkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgFFOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:40:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83238C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:40:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so6379894pfd.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dYkV/jB2F/znlUoptYnRvY3ATn24ojNzwogxoU5kZFs=;
        b=oKtjjgSQzWbp4VcoqPjQwnX9jqqPJYRPLFhLJ6JiTLwJhTFPaCVomGGg8xwIM/8swE
         NJnqqu/340Iyuqtf3htcihMCaZY9KvF6HeH/4+oGgoHNTJAvmbrp1PgxXJIL4xJIYRR+
         0scQwWRlpaGgyO8xFg81k+D9hPKNDiLUXSv/Dr51qzCMT7tPJi4DMJ+yeE4QWEQ6/pIH
         PgPGl1YZAgfs3ehQoiGCoRlYG0aOItgdgJYVTD+RTy+bVhcwD1btctlnd/EKryLwXbLA
         ZzTJDJn9v1a561y2Rhqno6lRp2oReaARUl8rCnpH1e3ZQcUWThN/eKFEBc6RF/2UKahQ
         eJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dYkV/jB2F/znlUoptYnRvY3ATn24ojNzwogxoU5kZFs=;
        b=ZPFt791Vfj0HpsGiAmyOetUpD3nrdgNORh8DGLkOkIt8eB1o87rox18SkWOflUwbCT
         ibKAY8WQfbwfI7x3vg8NhcP0HEa4VdSlot7JP/01QS8HLdObKgmksR/R/EavVm5IgS/J
         6bimJ5Q61czEwrf4Qz7XP9lBqRSP2RckUf6rRcX/FmQB0VQMZ+A1dkHkh9EriXg2787h
         4ZlLrD7Ly6ovQUInJ20Nd9w28HdgzIsnMnxuRVy4aLqBvF0ooimkKQA1tyRyul0WHpFq
         NCn6XSlzNDqTYvoDWi6xPnWj520rSC4PdqjebT8JsLDz+xyFk9fSxwxuBdd+vuJ1uYSL
         Qnkw==
X-Gm-Message-State: AOAM5335P3v1lwvke9SsXH77FqRsAc3glflKjphr6L13nsm0BLwTWcf3
        7pwskCaL7Y3Jpang2xmzybz9oWvMUyGArA==
X-Google-Smtp-Source: ABdhPJxgHpecvz1M4lzfXGJxRZ3NIQ0a5Ayso4TNdnjKubkTQ7feO9UDQ8uADcBzw9C2ThaAhoaxSg==
X-Received: by 2002:a65:4807:: with SMTP id h7mr7372184pgs.123.1591454440068;
        Sat, 06 Jun 2020 07:40:40 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id l4sm2125671pgo.92.2020.06.06.07.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:40:39 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:40:31 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/19] perf ftrace: add option -P/--no-pager to disable
 pager
Message-ID: <20200606144031.vbmo7pjuhd2ltuem@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-15-changbin.du@gmail.com>
 <20200520210914.GC32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520210914.GC32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:09:14PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:23PM +0800, Changbin Du escreveu:
> > Sometimes we want perf displays trace immediately. So this adds an option
> > '-P/--no-pager' to disable pager if needed.
> 
> 
> Try:
> 
> perf record sleep 5
> perf script
> 
> Then:
> 
> perf --no-pager script
> 
> I.e. its there already.
> 
> - Arnaldo
>
Yes, just tried this and it works:
perf --no-pager ftrace

So, the problem is that this option is not documented.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index a93fbdac6aa4..64c22f367ba2 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -48,6 +48,7 @@ struct perf_ftrace {
> >  	unsigned		tracing_thresh;
> >  	bool			trace_children;
> >  	unsigned		buffer_size_kb;
> > +	bool			no_pager;
> >  };
> >  
> >  struct filter_entry {
> > @@ -56,6 +57,7 @@ struct filter_entry {
> >  };
> >  
> >  static volatile int workload_exec_errno;
> > +static bool interrupted;
> >  static bool done;
> >  
> >  static void sig_handler(int sig __maybe_unused)
> > @@ -63,6 +65,12 @@ static void sig_handler(int sig __maybe_unused)
> >  	done = true;
> >  }
> >  
> > +static void sig_handler_int(int sig __maybe_unused)
> > +{
> > +	sig_handler(sig);
> > +	interrupted = 1;
> > +}
> > +
> >  /*
> >   * perf_evlist__prepare_workload will send a SIGUSR1 if the fork fails, since
> >   * we asked by setting its exec_error to the function below,
> > @@ -492,7 +500,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		return -1;
> >  	}
> >  
> > -	signal(SIGINT, sig_handler);
> > +	signal(SIGINT, sig_handler_int);
> >  	signal(SIGUSR1, sig_handler);
> >  	signal(SIGCHLD, sig_handler);
> >  	signal(SIGPIPE, sig_handler);
> > @@ -585,7 +593,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		goto out_reset;
> >  	}
> >  
> > -	setup_pager();
> > +	if (!ftrace->no_pager)
> > +		setup_pager();
> >  
> >  	trace_file = get_tracing_file("trace_pipe");
> >  	if (!trace_file) {
> > @@ -636,7 +645,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  	}
> >  
> >  	/* read remaining buffer contents */
> > -	while (true) {
> > +	while (true && !interrupted) {
> >  		int n = read(trace_fd, buf, sizeof(buf));
> >  		if (n <= 0)
> >  			break;
> > @@ -731,6 +740,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		    "Trace children processes"),
> >  	OPT_UINTEGER('b', "buffer-size", &ftrace.buffer_size_kb,
> >  		     "size of per cpu buffer in kb"),
> > +	OPT_BOOLEAN('P', "no-pager", &ftrace.no_pager,
> > +		    "Do not use pager"),
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
