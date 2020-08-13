Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE2CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CE820838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597360995;
	bh=EF/BQjTohXyx9VE5DQ/ITuXE4RPxFZdWjxUAUMPQgis=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=UIKiQC6yTk61MQEDnG0A2KtX3WCbec9GaB8FD8fJP+UA6csD5dcixwUzmg08ZSAeC
	 3sPL5l0CI/usHl9tdtpnCCykFJMoEn8AicsQoyXQ8ytqDdUC2DzqBjmbKPmqz+0NFk
	 3gXZZn3KFFCTDmNGGldyi0t+FqxjP7rwsg2Kizsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHMXXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 19:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgHMXXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 19:23:12 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE6F2078B;
        Thu, 13 Aug 2020 23:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597360992;
        bh=EF/BQjTohXyx9VE5DQ/ITuXE4RPxFZdWjxUAUMPQgis=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OaolggrC6srwXS8tGt+JS42uCRCpec88GQCLh5QhHajIEVXDFMShzGP7TW190sPDr
         pE+gnLxrebTbmEzgL+JxQ/PdE7R008T4SWLfTEVxp0xpcNg+0fiBEUqmrspPhUKZ3v
         OoXglsjuwb9N5DsG9S6DlUNTRtGdWbr5XqFwVD8w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E3E15352279C; Thu, 13 Aug 2020 16:23:11 -0700 (PDT)
Date:   Thu, 13 Aug 2020 16:23:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813232311.GJ4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813220619.GA2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:06:19AM +0200, peterz@infradead.org wrote:
> On Thu, Aug 13, 2020 at 11:52:57AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 13, 2020 at 08:26:18PM +0200, peterz@infradead.org wrote:
> 
> > > I thought the rule was:
> > > 
> > >  - No allocators (alloc/free) inside raw_spinlock_t, full-stop.
> > > 
> > > Why are we trying to craft an exception?
> > 
> > So that we can reduce post-grace-period cache misses by a factor of
> > eight when invoking RCU callbacks.  This reduction in cache misses also
> > makes it more difficult to overrun RCU with floods of either call_rcu()
> > or kfree_rcu() invocations.
> > 
> > The idea is to allocate page-sized arrays of pointers so that the callback
> > invocation can sequence through the array instead of walking a linked
> > list, hence the reduction in cache misses.
> 
> I'm still not getting it, how do we end up trying to allocate memory
> from under raw spinlocks if you're not allowed to use kfree_rcu() under
> one ?

You are indeed not allowed to use kfree() under a raw spinlock, given
that it can acquire a non-raw spinlock.

But kfree_rcu() was just a wrapper around call_rcu(), which can be and
is called from raw atomic context.

> Can someone please spell out the actual problem?

And as noted above, reducing the kfree()-time cache misses would be
a good thing.

						Thanx, Paul
