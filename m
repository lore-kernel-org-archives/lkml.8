Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D7AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EA82080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jL687RAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBJRIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:08:34 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36762 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgBJRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:08:34 -0500
Received: by mail-qv1-f65.google.com with SMTP id db9so3518523qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GRCpHDtsJ67okeGwIgvsSL9BK++UHh+4kCyjcA9A5ko=;
        b=jL687RAj+iaak76ia5BKrsjyleZ1AAx1iBnkuLt78MsrLOJrzMy4Tp/apdLbl5u/Ue
         z3M0jAHM6lzdCdKUMwwux1yN4cR0lDtY6RmTTmmCO+g+M+XapAiVjSWdKMwO6UTq4qg0
         2stXVsIUZ6fn45H16Y/WnaeBPXm3xzJgQHwIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GRCpHDtsJ67okeGwIgvsSL9BK++UHh+4kCyjcA9A5ko=;
        b=FcPTkwCOQUSgqMMwpjSRREfPEyn+eRyKL6R4wl+jGfTE5Buj2FTrjKINCoEb6X61gT
         7hVogix//OzB0Nq/BDbIvwqC245kGZQn65QlvLun3/tcqfs61vhMWbJ8LoP9zhKJ93is
         rZuB3OTJ9M0mF6Gb7m5VB+QVSxW8d/xpJsxV/8ayzH25vAMYEfXqa8blC9RlT5mNuXYz
         jEUf1k4Ev9ZtxXjk7reaH7iXSj/AuoN6j4/0H/ujrtTW+C/nwvxBCIwlF2ZqD5W4oNDP
         at07A1Nh/bsXq7yhwaw/lFQATEqDvTvhBg+qZF1sU1jyBdb90+U0npL8xCagHLHdhr7T
         wZVg==
X-Gm-Message-State: APjAAAXBoadSsU3wPJlwddymEba1p3zsTZGCvT87VVk993pm8j/CUkoy
        voORR6l/EhsapW/kF38TiEkHlO1v2oI=
X-Google-Smtp-Source: APXvYqyAsa/Yuaz4Sthqxvxv0EOkdXiR67YD1PrHVZecispmb2P7AFBrE1WFe68M8DbMUKHQdWxUdQ==
X-Received: by 2002:ad4:4e24:: with SMTP id dm4mr10644914qvb.170.1581354513305;
        Mon, 10 Feb 2020 09:08:33 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o55sm497974qtf.46.2020.02.10.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 09:08:31 -0800 (PST)
Date:   Mon, 10 Feb 2020 12:08:31 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] events: Annotate parent_ctx with __rcu
Message-ID: <20200210170831.GB246160@google.com>
References: <20200208144648.18833-1-frextrite@gmail.com>
 <20200210093624.GB14879@hirez.programming.kicks-ass.net>
 <20200210125948.GA16485@workstation-portable>
 <20200210133459.GJ14897@hirez.programming.kicks-ass.net>
 <20200210164727.GA22283@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210164727.GA22283@workstation-portable>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:17:27PM +0530, Amol Grover wrote:
> On Mon, Feb 10, 2020 at 02:34:59PM +0100, Peter Zijlstra wrote:
> > On Mon, Feb 10, 2020 at 06:29:48PM +0530, Amol Grover wrote:
> > > On Mon, Feb 10, 2020 at 10:36:24AM +0100, Peter Zijlstra wrote:
> > > > On Sat, Feb 08, 2020 at 08:16:49PM +0530, Amol Grover wrote:
> > 
> > > > > @@ -3106,26 +3106,31 @@ static void ctx_sched_out(struct perf_event_context *ctx,
> > > > >  static int context_equiv(struct perf_event_context *ctx1,
> > > > >  			 struct perf_event_context *ctx2)
> > > > >  {
> > > > > +	struct perf_event_context *parent_ctx1, *parent_ctx2;
> > > > > +
> > > > >  	lockdep_assert_held(&ctx1->lock);
> > > > >  	lockdep_assert_held(&ctx2->lock);
> > > > >  
> > > > > +	parent_ctx1 = rcu_dereference(ctx1->parent_ctx);
> > > > > +	parent_ctx2 = rcu_dereference(ctx2->parent_ctx);

You can probably remove the earlier lockdep_assert_held(s) if you're going to
use rcu_dereference_protected() here, since that would do the checking anyway.

> > > > 
> > > > Bah.
> > > > 
> > > > Why are you  fixing all this sparse crap and making the code worse?
> > > 
> > > Hi Peter,
> > > 
> > > Sparse is quite noisy and we need to eliminate false-positives, right?
> > 
> > Dunno, I've been happy just ignoring it all.

FWIW some of the sparse fixes Amol made recently did uncover so existing
"bugs" :) (Not in perf but other code).

> > > __rcu will tell the developer, this pointer could change and he needs to
> > > take the required steps to make sure the code doesn't break.
> > 
> > I know what it does; what I don't know is why you need to make the code
> > worse. In paricular, __rcu doesn't mandate rcu_dereference(), esp. not
> > when you're actually holding the write side lock.
> 
> I might've misinterpreted the code. How does replacing rcu_dereference()
> with
> parent_ctx1 = rcu_dereference_protected(ctx1->parent_ctx,
> 					lockdep_is_held(&ctx1->lock));
> sound?

FWIW, some maintainers do hate calling RCU APIs when write side lock is held.
Evidently it does make the code readability a bit worse and I can see Peter's
point of view because the existing code is correct. I leave it to you guys to
decide how you want to handle it.

thanks!

 - Joel

