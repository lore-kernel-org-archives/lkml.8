Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D98C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1E0217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lkomPsKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgBEOTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:19:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38355 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgBEOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:19:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so1058218pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EF5azVm17B4N3OwsRCXVrI4EuCLTUDFgy1VYYMCZm7E=;
        b=lkomPsKvF9AbvIEijT+xZBsoKXbi062ylvxZexLNRTuLVdyT+ISZ47Dz5pL71XjynX
         KoIkv0DFyBFH2DvP37ygfwVqTO8M1D2VFgKX5+dN+rWtGQpUEBidlby1dPWDjyMTjKp5
         mlXF20vI1fcDeoGRT1PQXRpQObHTW/oxjHzi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EF5azVm17B4N3OwsRCXVrI4EuCLTUDFgy1VYYMCZm7E=;
        b=b36XjXiyWmeXjGBYPokc4LtlDnaN8wuP0C6BoPypH1FpvJShuS/10ZoFnvRLyw0ybr
         eNtpIFW0sQtWg9oktfFXJaqEuU0pkUqbbsgSdeI+2R8NWQK2otIzwmc2EG+NqJohlz4G
         rXM7P1g+L66T/uHUthg5ncf6rCeQ9QSzo1L7oeUYopJX/jTFBHYiolkk8xO+dZBBIi9R
         Eqeh0l5tU7P9OM5ivigCXu7RkP57hmjj4+zMQZXzISDoDep0woY+VQOpC9nMEKSlRiAB
         5SU2KhkV+4iSYbT9hWibDC9WI2mFbszWKkCUXP4kDbBrgLrVFULE3frk+QEKRybQ6mK+
         hjdQ==
X-Gm-Message-State: APjAAAW11ghggd7fIVya3l2NCcIhBj5q0m5BJbkwWs1blTFl2u744T4J
        fR1LLz3xZskB7UGOy20RmuwojQ==
X-Google-Smtp-Source: APXvYqzZYFdoBQSOmdw0WKwR7L0jmNcdpUZ0MIfdx64/YCIfmfiNlXpLXxI8ab8UVrTaNnywBds+1Q==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20mr36122609plo.62.1580912356737;
        Wed, 05 Feb 2020 06:19:16 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g21sm29824293pfb.126.2020.02.05.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 06:19:16 -0800 (PST)
Date:   Wed, 5 Feb 2020 09:19:15 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Add comment to why
 rcu_dereference_sched() is open coded
Message-ID: <20200205141915.GA194021@google.com>
References: <20200205104929.313040579@goodmis.org>
 <20200205105113.283672584@goodmis.org>
 <20200205063349.4c3df2c0@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205063349.4c3df2c0@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 06:33:49AM -0500, Steven Rostedt wrote:
> 
> Paul and Joel,
> 
> Care to ack this patch (or complain about it ;-) ?
> 
> -- Steve
> 
> 
> On Wed, 05 Feb 2020 05:49:33 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Because the function graph tracer can execute in sections where RCU is not
> > "watching", the rcu_dereference_sched() for the has needs to be open coded.
> > This is fine because the RCU "flavor" of the ftrace hash is protected by
> > its own RCU handling (it does its own little synchronization on every CPU
> > and does not rely on RCU sched).
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/trace.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 022def96d307..8c52f5de9384 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -975,6 +975,11 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
> >  
> >  	preempt_disable_notrace();
> >  
> > +	/*
> > +	 * Have to open code "rcu_dereference_sched()" because the
> > +	 * function graph tracer can be called when RCU is not
> > +	 * "watching".
> > +	 */
> >  	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
> >  
> >  	if (ftrace_hash_empty(hash)) {
> > @@ -1022,6 +1027,11 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
> >  
> >  	preempt_disable_notrace();
> >  
> > +	/*
> > +	 * Have to open code "rcu_dereference_sched()" because the
> > +	 * function graph tracer can be called when RCU is not
> > +	 * "watching".
> > +	 */
> >  	notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
> >  						 !preemptible());
> >  

Could you paste the stack here when RCU is not watching? In trace event code
IIRC we call rcu_enter_irqs_on() to have RCU temporarily watch, since that
code can be called from idle loop. Should we doing the same here as well?

thanks,

 - Joel

