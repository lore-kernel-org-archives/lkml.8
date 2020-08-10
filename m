Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2ACC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7C520885
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fhfrPCq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHJRly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgHJRly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:41:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985DC061787
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:41:53 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 77so9137141qkm.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZgxUTpC3twfhDgLxDpKH9wmzW30NoIG84L3Ndjm0dhw=;
        b=fhfrPCq0VVBvEn4w+fHNzuo9aiElAafeASu/UEjct9hKGqgabShPFbYIcWRbQuLU/w
         VEHBsfM6ComEV1m62Xtn3WbWZFl4O1F4CLcN+8DPBdZRUdXEP4gdWxwf4ZYagl/4casz
         t+NE9CODfJLwOroS7qijjWFiBjd2DjfFX+saQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZgxUTpC3twfhDgLxDpKH9wmzW30NoIG84L3Ndjm0dhw=;
        b=hFSJ7j9kkAi5lYj4/GDTTcHon3jwUug9UhZIS8BccD+EY25q0vUz4oIBDTSUFR/zkF
         jzp+A/Wt443jAzPzzbZBHM0M4CEXCI76sG2ULlH9qy9gv221G4cffThpIYHsium6/wwJ
         9mlQVu2iW+IlOa+W0CpvzZQ66s2zHDEhtcpkn9mueU+YiMld+rR+pA+Jjn7bk6Uj+Zuw
         F0wj+QQUCrouNVKSI7VzBYPcWM5msyMFc44rJfGWoD8+WZYrGSumgUiRRn5iVLLEeHDu
         C5osmgomwVK6nyudVt8PLhMlcqez1rilobBYs57xV2F8rxI8LJb3IQy/CSZJeBTpUY3T
         VwWg==
X-Gm-Message-State: AOAM532stWh0GQd17+q/cU7zxoaAGF3+HEqQjbs+gn9VnIv/pGIyI5JW
        hxj+XbU6SdWivHVnBU7omtS7bw==
X-Google-Smtp-Source: ABdhPJwT6hEOLcCL1aSm6xou0TMMwI8u550PCMYSuiGAlPRLCiuycGNYyxUhupGBpDcbP7ZhV34yow==
X-Received: by 2002:a37:a746:: with SMTP id q67mr27689424qke.93.1597081312083;
        Mon, 10 Aug 2020 10:41:52 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z197sm14857700qkb.66.2020.08.10.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 10:41:51 -0700 (PDT)
Date:   Mon, 10 Aug 2020 13:41:51 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, "Paul E. McKenney" <paulmck@kernel.org>,
        peterz@infradead.org, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        vineethrp@gmail.com
Subject: Re: [PATCH v4 5/5] docs: Update RCU's hotplug requirements with a
 bit about design
Message-ID: <20200810174151.GC2253395@google.com>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-6-joel@joelfernandes.org>
 <4b8646fd-7644-bd8a-54ad-d0cb80b04317@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8646fd-7644-bd8a-54ad-d0cb80b04317@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 07:10:38PM -0700, Randy Dunlap wrote:
> Hi--
> 
> On 8/7/20 10:07 AM, Joel Fernandes (Google) wrote:
> > RCU's hotplug design will help understand the requirements an RCU
> > implementation needs to fullfill, such as dead-lock avoidance.
> > 
> > The rcu_barrier() section of the "Hotplug CPU" section already talks
> > about deadlocks, however the description of what else can deadlock other
> > than rcu_barrier is rather incomplete.
> > 
> > This commit therefore continues the section by describing how RCU's
> > design handles CPU hotplug in a deadlock-free way.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you Randy for pointing these out. I will fix the nits in the next revision.

Regards,

 - Joel


> >  .../RCU/Design/Requirements/Requirements.rst  | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > index 16c64a2eff93..0a4148b9f743 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -1940,6 +1940,28 @@ deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
> >  during its execution, which results in another type of deadlock when
> >  invoked from a CPU-hotplug notifier.
> >  
> > +Also, RCU's implementation avoids serious deadlocks which could occur due to
> > +interaction between hotplug, timers and grace period processing. It does so by
> > +maintaining its own bookkeeping of every CPU's hotplug state, independent of
> > +the various CPU masks and by reporting quiescent states at explicit points.  It
> > +may come across as a surprise, but the force quiescent state loop (FQS) does
> > +not report quiescent states for offline CPUs and is not required to.
> > +
> > +For an offline CPU, the quiescent state will be reported in either of:
> > +1. During CPU offlining, using RCU's hotplug notifier (``rcu_report_dead()``).
> 
>                         note, uses (), which is good:                      ()
> 
> > +2. During grace period initialization (``rcu_gp_init``) if it detected a race
> 
>       add for consistency & readability:    rcu_gp_init()
> 
> > +   with CPU offlining, or a race with a task unblocking on a node which
> > +   previously had all of its CPUs offlined.
> > +
> > +The CPU onlining path (``rcu_cpu_starting``) does not need to a report
> 
>       ditto:                rcu_cpu_starting()
> 
> > +quiescent state for an offline CPU in fact it would trigger a warning if a
> 
> Missing something; maybe like so:
> 
>                    for an offline CPU; in fact
> 
> > +quiescent state was not already reported for that CPU.
> > +
> > +During the checking/modification of RCU's hotplug bookkeeping, the
> > +corresponding CPU's leaf node lock is held. This avoids race conditions between
> > +RCU's hotplug notifier hooks, grace period initialization code and the FQS loop
> > +which can concurrently refer to or modify the bookkeeping.
> > +
> >  Scheduler and RCU
> >  ~~~~~~~~~~~~~~~~~
> >  
> > 
> 
> cheers.
> -- 
> ~Randy
> 
