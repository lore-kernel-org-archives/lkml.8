Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69274C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D0920714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581498326;
	bh=O7MMgsy03Ezcr3ZCIyqko76Jimj76XrYEkzHssp7KVE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FIA0Lw0wQy3/9WXfO9LkJMB7gbTiLlRLKYO5ZJzxyjZfNDJdIWUbU+GfDCU2w3e+l
	 6fTRCz/COoBHb/B3SXoireg811pdDkvdaOS4qzzPV9DHjv1TPXalT1nfaHmmYW27n/
	 /q7b9aSOPpwtMS50hnbI+Qw2XUEsI2O+0+R7d7j0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgBLJFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgBLJFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:05:25 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A8F206ED;
        Wed, 12 Feb 2020 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581498324;
        bh=O7MMgsy03Ezcr3ZCIyqko76Jimj76XrYEkzHssp7KVE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OGG3VVBjmJr1q41KjrXw8NaXlumcmIdtsFWdMdrKOGwheNh1UiMvmHUiSDLBZKmpF
         drXsnRtC7xvvaEWoTz5wz79mC8ql2yzo0xMgAH3s+5E8Ce44IZvNA9c4lycLlLQ02/
         FQPl7YknySrinaboasfxYZfo6wK+Gl51h9pH06P8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A370F352298C; Wed, 12 Feb 2020 01:05:20 -0800 (PST)
Date:   Wed, 12 Feb 2020 01:05:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
Message-ID: <20200212090520.GQ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200211095047.58ddf750@gandalf.local.home>
 <20200211153452.GW14914@hirez.programming.kicks-ass.net>
 <20200211111828.48058768@gandalf.local.home>
 <20200211172952.GY14914@hirez.programming.kicks-ass.net>
 <20200211173213.GX14946@hirez.programming.kicks-ass.net>
 <20200211185457.GN2935@paulmck-ThinkPad-P72>
 <20200212080522.GP14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212080522.GP14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:05:22AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2020 at 10:54:57AM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 11, 2020 at 06:32:13PM +0100, Peter Zijlstra wrote:
> > > On Tue, Feb 11, 2020 at 06:29:52PM +0100, Peter Zijlstra wrote:
> > > > +#define trace_rcu_enter()					\
> > > > +({								\
> > > > +	unsigned long state = 0;				\
> > > > +	if (!rcu_is_watching())	{				\
> > > 
> > > Also, afaict rcu_is_watching() itself needs more love, the functio has
> > > notrace, but calls other stuff that does not have notrace or inline.
> > 
> > Good catch!  Like this?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 1f5fdf7..51616e72 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -295,7 +295,7 @@ static void rcu_dynticks_eqs_online(void)
> >   *
> >   * No ordering, as we are sampling CPU-local information.
> >   */
> > -static bool rcu_dynticks_curr_cpu_in_eqs(void)
> > +static bool notrace rcu_dynticks_curr_cpu_in_eqs(void)
> 
> Right, except that, given the size of the thing, I'd opt for 'inline'
> over 'notrace'.

Like this, then?

							Thanx, Paul

------------------------------------------------------------------------

commit 164a7e5204cf32d22d0e444efd97ac7f2243b8d2
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Feb 11 11:10:00 2020 -0800

    rcu: Make rcu_dynticks_curr_cpu_in_eqs() be inline
    
    The rcu_is_watching() function is and must be notrace in order to allow
    it to be used by the tracing infrastructure.  However, it also invokes
    rcu_dynticks_curr_cpu_in_eqs(), which therefore needs to be either
    notrace or inline.  But isn't.
    
    This commit therefore adds "inline" to the rcu_dynticks_curr_cpu_in_eqs()
    definition.
    
    Reported-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1f5fdf7..16fd113 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -295,7 +295,7 @@ static void rcu_dynticks_eqs_online(void)
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static bool rcu_dynticks_curr_cpu_in_eqs(void)
+static bool inline rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
