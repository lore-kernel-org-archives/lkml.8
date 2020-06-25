Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39529C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B89D20706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD13Y4F8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404184AbgFYLVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404042AbgFYLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:21:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50FC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:21:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g17so2656017plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B+iYWxPbM605MmMCarfRXtG7OCCzOW/gCwuctRCZbcA=;
        b=pD13Y4F8y9OE8bUS+1powfFO28r0Ji45xEg0ie+y0/jILIAkc54ObCK1/8FXx7T7oY
         CTkOwHHJsnv+M5xitxgM2lskNxszk8lwOPiHZyb0G+e5ojB0czr2VZ1Ee5M6J4p0FRcO
         NadYG1tQ2MkkE/XVEDMdk2KpDGH9FCZFtDy0Yb5zqgRCAtyp2tObHrVo8c1pwuz1IWcF
         BkM58K/T1fTGYpEUwSPaqRa629e6HWfx7P1tC7iL61FCcdaPy5K8RjoeY4HJa9G1g6lp
         gmRnEnwtcwxJo3c9XBHuzPlZPtmlp03PBeX1G4e2CCRWrtAarveqSRzLfqX0w781Wp8u
         JWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+iYWxPbM605MmMCarfRXtG7OCCzOW/gCwuctRCZbcA=;
        b=m9cTbmsiJNxSF9hxjzFTxBHIViZNmLko7wXA02GYJWoYxpRtdxsrwYv50nkdECrIW3
         HSHoEUKS1J74l4ge4gkU3Ab35iHYN+ZVmE2lprepMLt+MIz52aOakyxEzNpy88AhUn50
         VVVBGRArTL3mQrGFbS4td5MTWSSH8Yy9TF6VrNIR+Jn5Qcr/WxH02Yw0SdrydNW3i2k0
         PdY/9TrmAwZ7DUM+BZyp9lzejldLA6DSLaepfscu3EJ10xuxdn1OtyGm8zgpFBlsXinT
         AP1xg2bMEt/xYEGSTc6K10/uBzej0Dpdev6jhviHgn1S7qzXLbQ//1L3kDlC4lyHgJoQ
         mYZg==
X-Gm-Message-State: AOAM533rHK+sS9XlCImZJJh+gfgto04F5IMLKLAf7FmECZMFIAuWLLIb
        bEhDBcaHnSAzsUMUjfrlpGsYeCF2eEg=
X-Google-Smtp-Source: ABdhPJyNykasiKY1878HOtzs/TTtMiPOmhHdCuyewzqxF2GA9psd4bDyqHrMcOcGMZGPn5YlTICAzQ==
X-Received: by 2002:a17:90a:b781:: with SMTP id m1mr2593864pjr.14.1593084090755;
        Thu, 25 Jun 2020 04:21:30 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 191sm5167603pfw.150.2020.06.25.04.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:21:29 -0700 (PDT)
Date:   Thu, 25 Jun 2020 19:21:22 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/19] perf ftrace: add support for trace option
 funcgraph-tail
Message-ID: <20200625112122.v3gcd7xto7y4ste6@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-11-changbin.du@gmail.com>
 <20200520210509.GY32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520210509.GY32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arnaldo,
First appologize for so long dealy! Maybe you have forgot the context of this
serias ;)

On Wed, May 20, 2020 at 06:05:09PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:19PM +0800, Changbin Du escreveu:
> > This adds an option '--funcgraph-tail' for function graph tracer.
> 
> And I think we should make these available in a compact way, as Intel PT
> has, i.e. instead of doing something like:
> 
>    --function-graph-options nosleep_time,noirqs,no_tail,long_info
> 
> We could have:
> 
>    -G ns,ni,nt,li
> 
> To save on typing, or something like that.
>
I just noticed that there is an existing graph tracer option:
	--graph-depth <n>

Then our new option would be:
	--graph-options depth=<n>,nosleep_time,noirqs,no_tail,long_info

This makes it a little complex to parse such options (need to parse key-vale
pairs).

So can we follow the existing style instead? I mean we can have below options:
	-D --graph-depth <n>
	-G --graph-funcs <func>

	--graph-nosleep-time
	--graph-noirqs
	--graph-notail
	--graph-longinfo

All graph tracer options are prefixed with '--graph-'.

> - Arnaldo
>  
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 20bc14d6c5fb..2ef5d1c4b23c 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -42,6 +42,7 @@ struct perf_ftrace {
> >  	bool			func_stack_trace;
> >  	bool			nosleep_time;
> >  	bool			nofuncgraph_irqs;
> > +	bool			funcgraph_tail;
> >  	bool			long_info;
> >  	unsigned		tracing_thresh;
> >  };
> > @@ -192,6 +193,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> >  	write_tracing_option_file("func_stack_trace", "0");
> >  	write_tracing_option_file("sleep-time", "1");
> >  	write_tracing_option_file("funcgraph-irqs", "1");
> > +	write_tracing_option_file("funcgraph-tail", "0");
> >  	write_tracing_option_file("funcgraph-proc", "0");
> >  	write_tracing_option_file("funcgraph-abstime", "0");
> >  	write_tracing_option_file("irq-info", "0");
> > @@ -411,6 +413,17 @@ static int set_tracing_thresh(struct perf_ftrace *ftrace)
> >  	return 0;
> >  }
> >  
> > +static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
> > +{
> > +	if (!ftrace->funcgraph_tail)
> > +		return 0;
> > +
> > +	if (write_tracing_option_file("funcgraph-tail", "1") < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  {
> >  	char *trace_file;
> > @@ -499,6 +512,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		goto out_reset;
> >  	}
> >  
> > +	if (set_tracing_funcgraph_tail(ftrace) < 0) {
> > +		pr_err("failed to set tracing option funcgraph-tail\n");
> > +		goto out_reset;
> > +	}
> > +
> >  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
> >  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
> >  		goto out_reset;
> > @@ -638,6 +656,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		    "Measure on-CPU time only (function_graph only)"),
> >  	OPT_BOOLEAN(0, "nofuncgraph-irqs", &ftrace.nofuncgraph_irqs,
> >  		    "Ignore functions that happen inside interrupt (function_graph only)"),
> > +	OPT_BOOLEAN(0, "funcgraph-tail", &ftrace.funcgraph_tail,
> > +		    "Show function tails comment (function_graph only)"),
> >  	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
> >  		    "Show process names, PIDs, timestamps, irq-info if available"),
> >  	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
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
