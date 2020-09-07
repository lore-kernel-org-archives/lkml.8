Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1632145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPwdRjoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgIGISI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgIGISA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:18:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973F9C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:17:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o68so8260540pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpbU7xvNSX910XDJmyKFuqPe3lKfo6Zq4NRSI2f54Ac=;
        b=kPwdRjoWHdEjiToNXIEHWkJaD+jtrlJh4uxqrHxIUX/wi59Sl4xDvQSdwd3OmnbgBF
         Q/D2UP3vHUrAYNAzcDzGkWOJbjj4s3jTuV/nF4d74s9aux39zGZKaWjewxerIQPfRuo3
         uOju2PDDRY3+/M/Ogy/JNCi5IcjhUh+ZJrTeKVtVX6FM6RAux8xxCUoXYHRkAy4gF2KK
         lzKSLGpZTWsji+nIOC+qTwoX3uK2z3U8GuHtK3t2vgCtJPf52RZAnf8uUegEhFZFAkW/
         Mm+Lf20iJr57fwK7uj6TjObbAThI4UeB9f5wliqzWGCKhhkTReTcUIZkhr/LKAfzEYNl
         ZHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpbU7xvNSX910XDJmyKFuqPe3lKfo6Zq4NRSI2f54Ac=;
        b=SDJbRIVRR/ZdYC8GxLJfJ+opSMElPi5wOxzTKG3ZHhVVQcguQr6AzEctP55Ge+LjXS
         IkmAd/Oq6ex7FFQMS7m0J2t4I9WaqfeM50Wz8zXWXOVOvZCSr3zn4zvjxKmdrWFn6BPw
         h6yHGC+Kg7Ftb4yB12RRWd7vs20Vm0p+ctXqKKwIIdNOmph3zJdsCELee+MkCC9hu5+T
         MuojVKpRZLr3MsDGl2G7m9LyFEgY0s75LUsHxc3sn0PB2CD2ayVAKjTuOiwlL7QC5KSt
         XWwkvlF//VSMs8gXhs5ibGMrCoURSM0HJ+BqTuN9DAcM6dJTXmc4q5kChG/rwMh0+aU+
         OIVA==
X-Gm-Message-State: AOAM531tfpNbbF+BAwhV5MhggLqaQXjnDlk6/szTSFG5RO/0nRWsIjmm
        Q/F/wa615krqju/VeaLyz1nXBg==
X-Google-Smtp-Source: ABdhPJwdTWTgPv1uouiu2Q5zKA0MSPc2ResUVGw4FmXenrWf8sX25toC7NZqtgBS2EYm4bfifzqaXA==
X-Received: by 2002:a65:6701:: with SMTP id u1mr5892104pgf.357.1599466679039;
        Mon, 07 Sep 2020 01:17:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id n7sm8588540pfq.114.2020.09.07.01.17.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 01:17:58 -0700 (PDT)
Date:   Mon, 7 Sep 2020 16:17:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] perf mem: Introduce weak function
 perf_mem_events__ptr()
Message-ID: <20200907081747.GC25511@leoy-ThinkPad-X240s>
References: <20200901083815.13755-1-leo.yan@linaro.org>
 <20200901083815.13755-3-leo.yan@linaro.org>
 <20200903135054.GD713364@krava>
 <20200904003447.GB5979@leoy-ThinkPad-X240s>
 <20200904155251.GC939481@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904155251.GC939481@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 05:52:51PM +0200, Jiri Olsa wrote:
> On Fri, Sep 04, 2020 at 08:34:47AM +0800, Leo Yan wrote:
> > Hi Jiri,
> > 
> > On Thu, Sep 03, 2020 at 03:50:54PM +0200, Jiri Olsa wrote:
> > > On Tue, Sep 01, 2020 at 09:38:03AM +0100, Leo Yan wrote:
> > > 
> > > SNIP
> > > 
> > > > @@ -2941,30 +2942,38 @@ static int perf_c2c__record(int argc, const char **argv)
> > > >  	rec_argv[i++] = "record";
> > > >  
> > > >  	if (!event_set) {
> > > > -		perf_mem_events[PERF_MEM_EVENTS__LOAD].record  = true;
> > > > -		perf_mem_events[PERF_MEM_EVENTS__STORE].record = true;
> > > > +		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> > > > +		e->record = true;
> > > > +
> > > > +		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
> > > > +		e->record = true;
> > > >  	}
> > > >  
> > > > -	if (perf_mem_events[PERF_MEM_EVENTS__LOAD].record)
> > > > +	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> > > > +	if (e->record)
> > > >  		rec_argv[i++] = "-W";
> > > >  
> > > >  	rec_argv[i++] = "-d";
> > > >  	rec_argv[i++] = "--phys-data";
> > > >  	rec_argv[i++] = "--sample-cpu";
> > > >  
> > > > -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > > > -		if (!perf_mem_events[j].record)
> > > > +	j = 0;
> > > > +	while ((e = perf_mem_events__ptr(j)) != NULL) {
> > > > +		if (!e->record) {
> > > 
> > > you could keep the above 'for loop' in here, it seems better
> > > than taking care of j++
> > 
> > Actually in patch v1 I did this way :)  I followed James' suggestion to
> > encapsulate PERF_MEM_EVENTS__MAX into perf_mem_events__ptr(), thus
> > builtin-mem.c and buildin-c2c.c are not necessary to use
> > PERF_MEM_EVENTS__MAX in the loop and only needs to detect if the
> > pointer is NULL or not when return from perf_mem_events__ptr().
> 
> ah because u added that load_store event

Yes.

> > 
> > How about change as below?
> > 
> >         for (j = 0; (e = perf_mem_events__ptr(j)) != NULL; j++) {
> >                 [...]
> 
> will this work? e will be NULL for first iteration no?
> 
> there are still other for loops with PERF_MEM_EVENTS__MAX used
> in the patch.. you overload the perf_mem_events access for arm,
> and add missing load_store NULL item to generic version, so there's
> always PERF_MEM_EVENTS__MAX items in the array

Yes, exactly.

> can we just use the current for loop and check for e->tag != NULL
> or any other field

Understood.  This would be directive, will keep current code and will
check 'e->record' field.

Thanks,
Leo
