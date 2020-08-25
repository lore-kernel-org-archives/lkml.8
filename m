Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF11C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D742075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BEu8CJSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHYWxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHYWxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:53:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A0BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:53:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n18so27543qtw.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WEE3G9povgJWPCtYpPqFiQBf651eDMpa+71/slW/h98=;
        b=BEu8CJSVBli/z0qbfaqpochzBmN0GZzDkrHjJSWt89ZURiB0L2nUlQbj+fuo8tW1TT
         5/BBKHljCrW0hTKQK5nU0M59+rb/NPI1E+Elvt5t5HcF6lkkv/Bqrqm+0DrrAs4rCjXX
         XbGLNvOqk5K8KNTCFJ4zAlT1VVk5lGBMBfDKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WEE3G9povgJWPCtYpPqFiQBf651eDMpa+71/slW/h98=;
        b=GupB5Vhq1Wn/rrAN168L606ZGJ5VL0T7IoN6d6gq/rZW9Aek1soNtIkN4oMJQbb8Je
         WJi+kS4ILBka9WkTbMZbw2RjmXMCJ0OeQ6Kx/BAR/8pOqezXKKYtcOn+bjLwFZroTHU0
         DYXUdkBO+nEfXzyYgzHCG9k6jfb8vNqr+JhlinQ2Y0nNZPuiQ3nzTEfWaxQ35qJuJ5eV
         2NJDj+SmR+4QxYOiiiMqtIjaQn0LYGffpJUQGw0f0eV+zXtliFq3MNIMUXMp46m8COKp
         FTpH7x6dcx/IM/5jZ5TJhosE4DtXxmIaiJEUu6siY/JKQUpm06WCeG14fwMUqqIpo2Xz
         3gBw==
X-Gm-Message-State: AOAM5317Dbc00DK827RCx1zDOaa4Py/gNlvK4ocg0HprukzMqLL1lTsd
        4aX4B7WdRPzEu1WjTh9Ger4Q5Q==
X-Google-Smtp-Source: ABdhPJy/rtz/jM7D4+DuSv7oTaW8xYvaWG7TlTJV3jYQ2IVRSMNT+lcrvzaxz70DvqzIquKijC+STg==
X-Received: by 2002:ac8:6bc2:: with SMTP id b2mr11687288qtt.115.1598395991672;
        Tue, 25 Aug 2020 15:53:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id i14sm424928qtq.33.2020.08.25.15.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:53:11 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:53:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 4/4] rcu/trace: Add tracing for how segcb list
 changes
Message-ID: <20200825225310.GD579506@google.com>
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-5-joel@joelfernandes.org>
 <20200825215553.GB16846@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825215553.GB16846@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:55:53PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 24, 2020 at 10:48:42PM -0400, Joel Fernandes (Google) wrote:
> > Track how the segcb list changes before/after acceleration, during
> > queuing and during dequeuing.
> > 
> > This has proved useful to discover an optimization to avoid unwanted GP
> > requests when there are no callbacks accelerated. The overhead is minimal as
> > each segment's length is now stored in the respective segment.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Speaking of tracing, diagnostics, and debugging, a few instances of
> ASSERT_EXCLUSIVE_WRITER() in the previous patch might save a lot
> of debugging.  Help KCSAN help us.

Ok, I will look into it, thanks.

> >  include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
> >  kernel/rcu/rcu_segcblist.c | 27 +++++++++++++++++++++++++++
> >  kernel/rcu/rcu_segcblist.h |  7 +++++++
> >  kernel/rcu/tree.c          | 23 +++++++++++++++++++++++
> >  4 files changed, 82 insertions(+)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 155b5cb43cfd..7b84df3c95df 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
> >  		  __entry->qlen)
> >  );
> >  
> > +TRACE_EVENT_RCU(rcu_segcb,
> > +
> > +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> > +
> > +		TP_ARGS(ctx, cb_count, gp_seq),
> > +
> > +		TP_STRUCT__entry(
> > +			__field(const char *, ctx)
> > +			__array(int, cb_count, 4)
> > +			__array(unsigned long, gp_seq, 4)
> > +		),
> > +
> > +		TP_fast_assign(
> > +			__entry->ctx = ctx;
> > +			memcpy(__entry->cb_count, cb_count, 4 * sizeof(int));
> > +			memcpy(__entry->gp_seq, gp_seq, 4 * sizeof(unsigned long));
> > +		),
> > +
> > +		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
> > +			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> > +			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
> > +			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
> > +
> > +);
> > +
> >  /*
> >   * Tracepoint for the registration of a single RCU callback of the special
> >   * kvfree() form.  The first argument is the RCU type, the second argument
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 73a103464ea4..6419dbbaecde 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -378,6 +378,33 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >  	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> >  }
> >  
> > +/*
> > + * Return how many CBs each segment along with their gp_seq values.
> > + *
> > + * This function is O(N) where N is the number of callbacks. Only used from
> > + * tracing code which is usually disabled in production.
> > + */
> > +#ifdef CONFIG_RCU_TRACE
> > +void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > +			 int cbcount[RCU_CBLIST_NSEGS],
> > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > +{
> 
> Why not declare the arrays here and invoke the new trace event from
> here also?  That would simplify the usage and save a few lines of code.

True! I will do it that way.

thanks,

 - Joel

