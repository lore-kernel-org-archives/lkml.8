Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EBCC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90874214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Cr7P8fhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBEVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:54:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38827 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:54:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so1616580pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lwQzYGWQiSO8R2tnjh/HUN/vNTtkdu/IlYzNsMB0TDw=;
        b=Cr7P8fhZt8etP09vpJRSkAOTdKjH5X2yS9e6aMJbS33Ox5E9u5i/JPuli5iNQ1mo1G
         kj6YHX7KNOa5KSCMrD28QoW6f1OySWzNqW+9r+QRkr7DXxwGXzsctVik8+ovLP5FIS91
         PvIPBvwv5Q1VUZU44TVmimJqVp3QZH1XdNqq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lwQzYGWQiSO8R2tnjh/HUN/vNTtkdu/IlYzNsMB0TDw=;
        b=kFbEaNusqo83v59HJehJOTZPSQ7S8nn/cd8cyXzqR3s5DUY0Fp3QgJoUuBPp7yTV+V
         tiOzga4PlIa7d7QKMTbgVsNTJnWk7+Tuq5RnKBZ71MMvoyEKyp/Zk1ROPUrYiRPmtyVt
         MzJsmSvAwBTDxfWZFSpuKCZHgq+QQaC59ZXcqGWySiYiNZTNGL9F15wZL7+rwRF18fAV
         QNbvnMHnY8FgUe6XEyX+lpvRFdf+ExmMQpvToa8YsUlLtqRy34O2YddXE++g4TseDETe
         Ira4mTeOiufTEmi3meBuQK2cqBhjWUC65SJCm4RJS9UW2lB5aM+WxE0WyRuWKXMHxrFJ
         3iIw==
X-Gm-Message-State: APjAAAU7aoHHH0vrK5oHvRQYgsFcdmfgXbW/ZGr6ixUgWzJO99ymRlqX
        m76j6Z3tHUjc9vhxm4phEW9KdA==
X-Google-Smtp-Source: APXvYqz0FIqZfKc6sJvdfphUvGBnnud1jE4G1L7omf6jOQxlxG+8Gx4bdpgj312LJaiDM2kYOy3CHw==
X-Received: by 2002:a63:751e:: with SMTP id q30mr37020562pgc.390.1580939674127;
        Wed, 05 Feb 2020 13:54:34 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id fz21sm712197pjb.15.2020.02.05.13.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 13:54:33 -0800 (PST)
Date:   Wed, 5 Feb 2020 16:54:32 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Add comment to why
 rcu_dereference_sched() is open coded
Message-ID: <20200205215432.GJ142103@google.com>
References: <20200205104929.313040579@goodmis.org>
 <20200205105113.283672584@goodmis.org>
 <20200205063349.4c3df2c0@oasis.local.home>
 <20200205141915.GA194021@google.com>
 <20200205092847.0b650972@oasis.local.home>
 <20200205154212.GC142103@google.com>
 <20200205104945.4a6f85de@oasis.local.home>
 <20200205160824.GH142103@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205160824.GH142103@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:08:24AM -0500, Joel Fernandes wrote:
> On Wed, Feb 05, 2020 at 10:49:45AM -0500, Steven Rostedt wrote:
> > On Wed, 5 Feb 2020 10:42:12 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Wed, Feb 05, 2020 at 09:28:47AM -0500, Steven Rostedt wrote:
> > > > On Wed, 5 Feb 2020 09:19:15 -0500
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >   
> > > > > Could you paste the stack here when RCU is not watching? In trace event code
> > > > > IIRC we call rcu_enter_irqs_on() to have RCU temporarily watch, since that
> > > > > code can be called from idle loop. Should we doing the same here as well?  
> > > > 
> > > > Unfortunately I lost the stack trace. And the last time we tried to use
> > > > rcu_enter_irqs_on() for ftrace, we couldn't find a way to do this
> > > > properly. Ftrace is much more invasive then going into idle. The
> > > > problem is that ftrace traces RCU itself, and calling
> > > > "rcu_enter_irqs_on()" in pretty much any place in the RCU code caused
> > > > lots of bugs ;-)
> > > > 
> > > > This is why we have the schedule_on_each_cpu(ftrace_sync) hack.  
> > > 
> > > The "schedule a task on each CPU" trick works on !PREEMPT though right?
> > 
> > It works on both, as I care more about the PREEMPT=y case then
> > the !PREEMPT, and the PREEMPT_RT which is even more preemptive than
> > PREEMPT!
> > 
> > > 
> > > Because it is possible in PREEMPT=y to get preempted in the middle of a
> > > read-side critical section, switch to the worker thread executing the
> > > ftrace_sync() and then switch back. But RCU still has to watch that CPU since
> > > the read-side critical section was not completed.
> > > 
> > > Or is there a subtlety here with ftrace that I missed?
> > > 
> > 
> > Hence Amol's patch:
> > 
> > > +       notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
> > > +                                                !preemptible());
> > 
> > It checks to make sure preemption is off. There is no chance of being
> > preempted in the read side critical section.
> 
> Yes, this makes sense. Sorry for the noise.  For "sched" RCU cases,
> scheduling on each CPU would work regardless of PREEMPT configuration.
> 
> ( I guess I was confusing this case with the non-sched RCU usages (such as using
> rcu_read_lock()) where scheduling a task on each CPU obviously would not work
> with PREEMPT=y. )
> 
> By the way would SRCU not work instead of the ftrace_sync() technique? Or is
> the concern that SRCU cannot be used from NMI?

Answering my own question, SRCU would likely slow down ftrace_graph_addr()
unnecessarily so is probably not worth doing so in this path (especially
because ftrace_graph_addr() already starts an implict read-side critical
section anyway via preempt_disable()).

thanks,

 - Joel

