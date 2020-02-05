Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A2C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C788F2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="I1ycIKZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgBEV7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:59:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37854 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:59:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so1913130pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmqShO+oicTB5Tq9SUtiS1B0Y2ynlqicj6cz0OZE5pE=;
        b=I1ycIKZvIH/lI0zJi4VMZd0NzIKrLnsr6jHp9SyuTYdhiWZb/wCPJAf323z8594a/j
         CTRTqaEOga4GWtOJJtvV5i98leyXlIAEoLggdl/cBN+uFArL9wHG6tk4Hdt930O9ZXqO
         hu+OVhcihoGIhLB2nHXOlXXWlGIHwmNoor2f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmqShO+oicTB5Tq9SUtiS1B0Y2ynlqicj6cz0OZE5pE=;
        b=JLBNeXGmw8wdAsUJOh5A4+skSg5Jb+g2bx194ajxBsqiAq7nh+wNNf6knm8uisrqRv
         XMDkKkY/YhxryqlQuRpCCkee0xTZ9t1j8Mn08B6Ec0hkxExodsylGEAEfW4QGKE5BlML
         kKrT43xFPejca1s8GHD70KJdL6JYGCryTCKuludJQfsWP9nzfsvQIaEq1qlNb2wozAtT
         ezgX8BErM2WsIdJDhGVEsIxhrOD3F4tO/AAX44LULAzgQsQfU0nB1Zu+cT3C3J/RmEp3
         mshbZwwviIKg6FlzyksWg6fmqKCF9NGXYHEEL7NgrAwKnqbE8FD3HzBFaOAa9Q0cPcbM
         2O4w==
X-Gm-Message-State: APjAAAUQd4wVZtmwSqGnuPALbIpjkNJdfPBs0rW2K1Ev3eia0mUWVoUU
        Pr5wnCkXOoy4ERYIAZIAWygz0A==
X-Google-Smtp-Source: APXvYqzp6EMs++PCZVw9L5h+0mXFyZtulozuW3dJZ5d0nZ8qOqvEs2W4obyq5jOFO2JR4cpoy8vnXg==
X-Received: by 2002:aa7:9891:: with SMTP id r17mr48679pfl.205.1580939957953;
        Wed, 05 Feb 2020 13:59:17 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g7sm479938pfq.33.2020.02.05.13.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 13:59:17 -0800 (PST)
Date:   Wed, 5 Feb 2020 16:59:16 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Add comment to why
 rcu_dereference_sched() is open coded
Message-ID: <20200205215916.GL142103@google.com>
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

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


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
> 
