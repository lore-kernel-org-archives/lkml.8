Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D829EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9B22067D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lnaq3z9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgGQN1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgGQN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:27:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DDAC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:27:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so6365511pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zq4eLLHEPFYePLYsXs6ch0tfK/nwjUC8UEFOw6QoLa4=;
        b=Lnaq3z9kEZHMV2ApMiDweXrRyPWYk31gywhdPzee8VL9Y1liBih4Qdlsx1mxPcWIo6
         msRB1swgM/ShishzCGdhje5EFoPZq2aEwMyHoME5q/2aF/2LUVgaMyH1zxpV7anczIVe
         ffsLlpvh48FxHxgUaCQ0gWER9ya+fyVtXqq2vgbEp5H4fLz65bgzbSutlRqupte0bCN1
         cwriX2q6wlUg8NzCRvy3SHgAkAVTbzaD+BRmT6Pr0cSpn0WFv6+2Y+VfXeK9Y5QCodQW
         7sQLVVFXDeAZDj4i8sZa2B/IZZgu4FS1DVOKB7Y0MkKgV698rIJwOT0JrIzQwS8z1ZaT
         ThVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zq4eLLHEPFYePLYsXs6ch0tfK/nwjUC8UEFOw6QoLa4=;
        b=t81NLHbLjVa9nP5X6kdSto/YTKXIuHved+9P2WL+Q2ckjYQ/mxb5wChCGWqR9SpeLq
         P88VL4QGOByJbs4DfnLSGySsJcNdWWAZSQ31A/hG0mg4UvtmQyFK8w6cdrllWk876ikd
         ZyhblrrEWPglKTYtgivlYJkTuaaSXKp3Z+AGLXlfe/suLPJXtODPYOkAM1cTYXcxhO7J
         9BFRNy81hnEoqq1FtXXC3tiYJIWiT1j1RcS8sq6hKtAAKUWJKlk/9hRXc3eB6XgMNXrE
         oCPt4NVvqT2O7VczYhTgyWjZDehLkLvBvd+u8iwnEQ8B9QArRX+B1zilaffLc5C2qZoI
         JI4A==
X-Gm-Message-State: AOAM532PnHBG3eWGzgjm3rGBQEs0kepfkR4cNfILufyX41bc9PK1TysW
        zZRO8trgidrP7HW1SbRICZ4=
X-Google-Smtp-Source: ABdhPJz+mYdiWoy/UhbS6h4VA5AJY9KMK4o0CTUuYibW3x9Kg9pZURkVluqLVuzmBoFmY82ceB+pkw==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr7541416plf.191.1594992420594;
        Fri, 17 Jul 2020 06:27:00 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id d16sm7877616pfo.156.2020.07.17.06.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:26:59 -0700 (PDT)
Date:   Fri, 17 Jul 2020 21:26:50 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200717132650.i32oovllal22b35i@mail.google.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-4-changbin.du@gmail.com>
 <20200716153630.GD374956@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716153630.GD374956@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:36:30PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Jul 11, 2020 at 08:40:21PM +0800, Changbin Du escreveu:
> > This allows us to trace single thread instead of the whole process.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt | 4 ++++
> >  tools/perf/builtin-ftrace.c              | 2 ++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index d79560dea19f..e204bf6d50d8 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -38,6 +38,10 @@ OPTIONS
> >  --pid=::
> >  	Trace on existing process id (comma separated list).
> >  
> > +-t::
> > +--tid=::
> > +	Trace on existing thread id (comma separated list).
> > +
> 
> 
> Humm, I just  tried:
> 
> [root@five ~]# yes > /dev/null &
> [1] 18265
> [root@five ~]# perf ftrace --tid 18265
> ^C[root@five ~]#
> 
> After waiting for a while, nothing, what am I doing wrong?
>
I got it wrong. Currently ftrace only can filter by pid. If the pid is not
the main thread it won't work.

So this patch makes no sense. will drop this.

> - Arnaldo
> 
> 
> >  -a::
> >  --all-cpus::
> >  	Force system-wide collection.  Scripts run without a <command>
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 244cc8e6bd60..1188b82c6541 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -515,6 +515,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		    "Show available functions to filter"),
> >  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
> >  		   "trace on existing process id"),
> > +	OPT_STRING('t', "tid", &ftrace.target.tid, "tid",
> > +		   "trace on existing thread id (exclusive to --pid)"),
> >  	OPT_INCR('v', "verbose", &verbose,
> >  		 "be more verbose"),
> >  	OPT_BOOLEAN('a', "all-cpus", &ftrace.target.system_wide,
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
