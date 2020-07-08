Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A46206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9dvpCwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgGHMxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgGHMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:53:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79802C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:53:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so3685436ply.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nt3qTrfL3Oc3SKltAUjm2R67rDXYlaY4OLtCQF8HQtU=;
        b=M9dvpCwF3EprLTnDngv6SRlQiNaXkkzP4cAz7UFFE9+R+GfYQmDcMbmKPCPb3ChDkW
         R0hFwenP4OmSfVCtIVFAWnxYAef0q8Y6Uw5r1PAVtupHREdouUgr4wYmggC4HdD3JF2o
         koknIR/yb6NymJYc/BuTsniPwv2xVNqHGcwiDvlVbzKZz6zf18EbPtxHYIMhRVaOimix
         wvN9qLebmT6FOGEfThZLtvONL7Tvje2x5PIdGTIgCopw2fKXRnbuS43Z/fLJDY97khRd
         lXanwl+XUCb5KuI2WNHXHhouu5EoZYMRu6hMBxUn4vph1kgkH7cvoZlfZI7nbuuLaHx0
         VHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nt3qTrfL3Oc3SKltAUjm2R67rDXYlaY4OLtCQF8HQtU=;
        b=h/xuhmfBtWoBYx7gu2cDyDnucR5ehcPUV7kWCfC3HTvSidFEEUz/CXv/4wobtDItKG
         spzqDP6or4XBT2n5/2Ooy76jLxefish6VdBIMnCGhnoQjG1ELAn7uKYw0eHafSUD1y2G
         F2I6JS8BliDiS5pDQwVAEiqst1/Ii5heTLnCKUeo3FjUByWZCnXwZ58csz80i4E4eWhQ
         S4QzGaue7NkD2x6MGeO4MQUBNqYw2b8+ZkFQv1g/MZjDxH01UQdRpWsspdFn/FWPbupr
         mRPatzYbPdyQzenwv4rFnSAWgkEfMI8FhC8npCR3XqPehgqNSOvOxxNmq/zmZYc1IW3H
         aH2A==
X-Gm-Message-State: AOAM533ot63iIhJS2CSATGh+xCEJvgLPr6g/lnXNfy4vowwWBoSys21z
        jnrxFjqa9dSDxthzKosLVxI=
X-Google-Smtp-Source: ABdhPJyM8WLej3ZMu6kK0XIornoquuDGJ5y3XYqLfrwLhFqLBgsBbchjfs3115xlt44xR1uTjW/wPQ==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr9627045pjv.11.1594212833935;
        Wed, 08 Jul 2020 05:53:53 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id u19sm26864985pfk.98.2020.07.08.05.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:53:53 -0700 (PDT)
Date:   Wed, 8 Jul 2020 20:53:46 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] perf ftrace: factor out function
 write_tracing_file_int()
Message-ID: <20200708125346.vnljbd2ntzuoofwl@mail.google.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-6-changbin.du@gmail.com>
 <20200707120923.26f7e349@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707120923.26f7e349@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 12:09:23PM -0400, Steven Rostedt wrote:
> On Sat, 27 Jun 2020 21:36:44 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > We will reuse this function later.
> > 
> 
> BTW, trace-cmd.git now has a libtracefs.so library, which I'm hoping
> within a month to have as a stand alone (probably along with
> libtraceevent and even a libtracecmd).
> 
>   https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tree/lib/tracefs
> 
> This is a library made to interact with the tracefs directory to remove
> reimplementing it all over the place.
>
Nice! This will make implementing a tracing tool much simpler. Look forward
to seeing it appears in most Linux distributions.

> -- Steve
> 
> 
> 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index dceae70c3a22..003efa756322 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -166,6 +166,17 @@ static int read_tracing_file_to_stdout(const char *name)
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
> > @@ -296,8 +307,6 @@ static void reset_tracing_filters(void)
> >  
> >  static int set_tracing_depth(struct perf_ftrace *ftrace)
> >  {
> > -	char buf[16];
> > -
> >  	if (ftrace->graph_depth == 0)
> >  		return 0;
> >  
> > @@ -306,9 +315,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
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
> 

-- 
Cheers,
Changbin Du
