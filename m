Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85383C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5293C222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBNWst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:48:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNWst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:48:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629A62081E;
        Fri, 14 Feb 2020 22:48:47 +0000 (UTC)
Date:   Fri, 14 Feb 2020 17:48:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Message-ID: <20200214174845.715de27b@gandalf.local.home>
In-Reply-To: <121a6b11-2fe1-6d9b-2861-a8ef8b42c452@amd.com>
References: <20200212210139.382424693@infradead.org>
        <20200212210750.312024711@infradead.org>
        <121a6b11-2fe1-6d9b-2861-a8ef8b42c452@amd.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 14:38:14 -0600
Kim Phillips <kim.phillips@amd.com> wrote:

> On 2/12/20 3:01 PM, Peter Zijlstra wrote:
> > Since perf is now able to deal with !rcu_is_watching() contexts,
> > remove the restraint.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/trace/trace_event_perf.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/kernel/trace/trace_event_perf.c
> > +++ b/kernel/trace/trace_event_perf.c
> > @@ -477,7 +477,7 @@ static int perf_ftrace_function_register
> >  {
> >  	struct ftrace_ops *ops = &event->ftrace_ops;
> >  
> > -	ops->flags   = FTRACE_OPS_FL_RCU;
> > +	ops->flags   = 0;
> >  	ops->func    = perf_ftrace_function_call;
> >  	ops->private = (void *)(unsigned long)nr_cpu_ids;  
> 
> If this is the last user of the flag, should all remaining
> FTRACE_OPS_FL_RCU references be removed, too?

Let's wait till Peter's patches goes through a merge cycle or two. I
want to make sure there's no other RCU issues that pop up before we
remove this infrastructure.

-- Steve

