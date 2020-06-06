Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714DDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA2120723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmaR+Yx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgFFOnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgFFOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:43:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82028C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:43:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n9so4885981plk.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Yl5B71x5WRVLHY9W7Cygav4B233CiJaZgXz0nwScr1k=;
        b=nmaR+Yx16ZjKd4987CctgQlRiXBAarBAYrESs0qnk4hOuejlJHIaCnBTE4LyDJRAtV
         2gApuzJp7sBDEzKVtYcsZYoA1fI3EH6fbk4KKpNS5hC9XkaiT2+8CUaEakAkwq89VUi1
         +yfvMFxMexAVK5huM1fOu6m4sbDe2pbCeFpnh4Z3zyqihFg+j0+ctveq8gcIv4AYqFyF
         We4MUAhJtkj39ZphDK2MXX47OLD4OyIGRicLM0nkH+zWo6CjZCPrbC6Y8lMbSfkR3g60
         domcYIOyPha9iNLfzUI4V4sTXF2tTfWojKbokml3gHD6yPRE/WW+Q+SS6nAjadEUNzMf
         5BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Yl5B71x5WRVLHY9W7Cygav4B233CiJaZgXz0nwScr1k=;
        b=egy2q64l9YVhMW2bWGG2pX5VcTgMWWHr/Ho+TAecGLRHOnOE/LlU6jtWMmJz2PpzzB
         a2mAX09wY9ukRpye4wQDioDAPOHIfFJNKeOlI8LRVx67CfFM2HGEtkEiJ1PrGhjktnal
         IjXN8cLNgiEcx4iiNkPD60YzB+oFRN9E7FV8enAcRcYcFZxPuXvpN5m525K59R3wrInc
         IMvJNWL2zRKTwkYtLiJiYIwUwK24EY12Itid/hpGgNQReQNtLlLwNs5M8GEhh5NjRENm
         N3YrVytLQO6EmXJaNFhJFzWAuADtx+AxJvYq+mUrW/5ZOPsdU/f/H9WyoSll9htiSbF2
         4XYQ==
X-Gm-Message-State: AOAM53169FxAqE/VXOInrCJiiQdPKE8Uk8yW3FyUpLkVkd3Ai6G3RUof
        3vOcWOlabShscQtpQSxcgnA=
X-Google-Smtp-Source: ABdhPJy/0V3hV9sjcZWZaG1l826/LBrZHpl+dR6t5xULcD/GRwSzFhV/crvumHrjdD9J86PAr0e3TA==
X-Received: by 2002:a17:90a:65c9:: with SMTP id i9mr8477138pjs.201.1591454629003;
        Sat, 06 Jun 2020 07:43:49 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id l63sm2553795pfd.122.2020.06.06.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:43:48 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:43:38 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] perf ftrace: add option '-b/--buffer-size' to set
 per-cpu buffer size
Message-ID: <20200606144338.fz6soq2sirjiyi7w@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-14-changbin.du@gmail.com>
 <20200520210814.GB32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520210814.GB32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:08:14PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:22PM +0800, Changbin Du escreveu:
> > This adds an option '-b/--buffer-size' to allow us set the size of per-cpu
> > tracing buffer.
> 
> -m
>
sure.

> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 45 ++++++++++++++++++++++++++++---------
> >  1 file changed, 35 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 8fd95c109fe8..a93fbdac6aa4 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -47,6 +47,7 @@ struct perf_ftrace {
> >  	bool			long_info;
> >  	unsigned		tracing_thresh;
> >  	bool			trace_children;
> > +	unsigned		buffer_size_kb;
> >  };
> >  
> >  struct filter_entry {
> > @@ -187,6 +188,17 @@ static int read_tracing_file_to_stdout(const char *name)
> >  	return ret;
> >  }
> >  
> > +static int write_tracing_file_int(const char *name, int value)
> > +{
> > +	char buf[16];
> > +
> > +	snprintf(buf, sizeof(buf), "%d", value);
> > +	if (write_tracing_file(name, buf) < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int reset_tracing_cpu(void);
> >  static void reset_tracing_filters(void);
> >  
> > @@ -360,8 +372,6 @@ static void reset_tracing_filters(void)
> >  
> >  static int set_tracing_depth(struct perf_ftrace *ftrace)
> >  {
> > -	char buf[16];
> > -
> >  	if (ftrace->graph_depth == 0)
> >  		return 0;
> >  
> > @@ -370,9 +380,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
> >  		return -1;
> >  	}
> >  
> > -	snprintf(buf, sizeof(buf), "%d", ftrace->graph_depth);
> > -
> > -	if (write_tracing_file("max_graph_depth", buf) < 0)
> > +	if (write_tracing_file_int("max_graph_depth", ftrace->graph_depth) < 0)
> >  		return -1;
> >  
> >  	return 0;
> > @@ -419,14 +427,10 @@ static int set_tracing_long_info(struct perf_ftrace *ftrace)
> >  
> >  static int set_tracing_thresh(struct perf_ftrace *ftrace)
> >  {
> > -	char buf[16];
> > -
> >  	if (ftrace->tracing_thresh == 0)
> >  		return 0;
> >  
> > -	snprintf(buf, sizeof(buf), "%d", ftrace->tracing_thresh);
> > -
> > -	if (write_tracing_file("tracing_thresh", buf) < 0)
> > +	if (write_tracing_file_int("tracing_thresh", ftrace->tracing_thresh) < 0)
> >  		return -1;
> >  
> >  	return 0;
> > @@ -454,6 +458,20 @@ static int set_tracing_trace_children(struct perf_ftrace *ftrace)
> >  	return 0;
> >  }
> >  
> > +static int set_tracing_buffer_size_kb(struct perf_ftrace *ftrace)
> > +{
> > +	int ret;
> > +
> > +	if (ftrace->buffer_size_kb == 0)
> > +		return 0;
> > +
> > +	ret = write_tracing_file_int("buffer_size_kb", ftrace->buffer_size_kb);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> >  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  {
> >  	char *trace_file;
> > @@ -557,6 +575,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		goto out_reset;
> >  	}
> >  
> > +	if (set_tracing_buffer_size_kb(ftrace) < 0) {
> > +		pr_err("failed to set tracing per-cpu buffer size\n");
> > +		goto out_reset;
> > +	}
> > +
> >  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
> >  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
> >  		goto out_reset;
> > @@ -706,6 +729,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		     "Only show functions of which the duration is greater than <n>µs"),
> >  	OPT_BOOLEAN(0, "trace-children", &ftrace.trace_children,
> >  		    "Trace children processes"),
> > +	OPT_UINTEGER('b', "buffer-size", &ftrace.buffer_size_kb,
> > +		     "size of per cpu buffer in kb"),
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
