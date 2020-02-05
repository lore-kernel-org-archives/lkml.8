Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4283AC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EF120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GkLvMT9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBEQI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:08:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46572 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:08:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so1160772pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IQ0LqXwzYIq/RIEjeyUZMtI4bHSK7/6tJxNP1rWP+Ek=;
        b=GkLvMT9NrS7AxPd/IIWMyUcv8MsWPiuEzO5yI0FM+y48pF/GU/ExpX60pXFh0BPH2U
         5RDU5tnMNQjAtfaxngttSg/nI7Stf1+UhVfgQ0laB+O9GmUUj4kHqR9G0CZxyxcHAVTd
         W5YHoVoOBjs3Nw3T/Ne5bzDy2u/QkU6e51z5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IQ0LqXwzYIq/RIEjeyUZMtI4bHSK7/6tJxNP1rWP+Ek=;
        b=GwfEzq7qHDZHIoQ2hLbH61cI35GNGqyxq6qIbm5cNEF+65WQtUHqawedqWzuRQh6/I
         cQMDtGxRRJ1+M743T61YyX8sjbfYZPHm9CnUU3QHaz4PMaBFEeqqoYc2CcRO9xdwxJN6
         VxaqC41f5EHvMe8qf1YrRO188Xh78qemp6VIph05+7KjG7jxywHsoL9RUohV98OrsP2p
         2mLjN3JgAh5jTf4YkjxfrnLZBjE/Azv1ER/dDzLcLpMnBHCeGB1EpD03vYRlbXFd8Uyu
         Bnn6X/6Lo64Li3iLi2SpNBaOLm2jTkgP+ia7QSyLNeV9bH4qub+audCqkWg5wfh1YRY5
         934A==
X-Gm-Message-State: APjAAAVqULcsxsntLx/Ci32r9VKLZ66fbWATm3RbvnNXgmGGm+rErzQ6
        zImEn7/9ayh3fCJRYQxTTm3bXg==
X-Google-Smtp-Source: APXvYqzpMyOPlIpMZJuUb5O4W6qjUWTCGuUmoDDDlbAe95wppLAUpLYf2bzqmETk1yuDjJ0NZhOYNA==
X-Received: by 2002:aa7:9633:: with SMTP id r19mr38593939pfg.90.1580918906212;
        Wed, 05 Feb 2020 08:08:26 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r7sm29713322pfg.34.2020.02.05.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:08:25 -0800 (PST)
Date:   Wed, 5 Feb 2020 11:08:24 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Add comment to why
 rcu_dereference_sched() is open coded
Message-ID: <20200205160824.GH142103@google.com>
References: <20200205104929.313040579@goodmis.org>
 <20200205105113.283672584@goodmis.org>
 <20200205063349.4c3df2c0@oasis.local.home>
 <20200205141915.GA194021@google.com>
 <20200205092847.0b650972@oasis.local.home>
 <20200205154212.GC142103@google.com>
 <20200205104945.4a6f85de@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205104945.4a6f85de@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:49:45AM -0500, Steven Rostedt wrote:
> On Wed, 5 Feb 2020 10:42:12 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Wed, Feb 05, 2020 at 09:28:47AM -0500, Steven Rostedt wrote:
> > > On Wed, 5 Feb 2020 09:19:15 -0500
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > >   
> > > > Could you paste the stack here when RCU is not watching? In trace event code
> > > > IIRC we call rcu_enter_irqs_on() to have RCU temporarily watch, since that
> > > > code can be called from idle loop. Should we doing the same here as well?  
> > > 
> > > Unfortunately I lost the stack trace. And the last time we tried to use
> > > rcu_enter_irqs_on() for ftrace, we couldn't find a way to do this
> > > properly. Ftrace is much more invasive then going into idle. The
> > > problem is that ftrace traces RCU itself, and calling
> > > "rcu_enter_irqs_on()" in pretty much any place in the RCU code caused
> > > lots of bugs ;-)
> > > 
> > > This is why we have the schedule_on_each_cpu(ftrace_sync) hack.  
> > 
> > The "schedule a task on each CPU" trick works on !PREEMPT though right?
> 
> It works on both, as I care more about the PREEMPT=y case then
> the !PREEMPT, and the PREEMPT_RT which is even more preemptive than
> PREEMPT!
> 
> > 
> > Because it is possible in PREEMPT=y to get preempted in the middle of a
> > read-side critical section, switch to the worker thread executing the
> > ftrace_sync() and then switch back. But RCU still has to watch that CPU since
> > the read-side critical section was not completed.
> > 
> > Or is there a subtlety here with ftrace that I missed?
> > 
> 
> Hence Amol's patch:
> 
> > +       notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
> > +                                                !preemptible());
> 
> It checks to make sure preemption is off. There is no chance of being
> preempted in the read side critical section.

Yes, this makes sense. Sorry for the noise.  For "sched" RCU cases,
scheduling on each CPU would work regardless of PREEMPT configuration.

( I guess I was confusing this case with the non-sched RCU usages (such as using
rcu_read_lock()) where scheduling a task on each CPU obviously would not work
with PREEMPT=y. )

By the way would SRCU not work instead of the ftrace_sync() technique? Or is
the concern that SRCU cannot be used from NMI?

thanks,

 - Joel

