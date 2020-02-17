Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356AC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49211215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WGZU4isB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgBQQfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:35:30 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39842 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgBQQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:35:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id a141so6854696qkg.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/RJwWrZ2M5oJXEFSa9WHJkWIFOQLYkCwM2AiEio3Bq0=;
        b=WGZU4isBp4loe6ivVlz1unS9nb4Z/yQ4B1HizjWYAr92VCRJty9h1m6e6b1rDV9W7O
         q/QzXn6pjRZuu2T9DBYA57POc9oN9hCYd7kmX70MlXDzf5HZtwz6UUK89IlwXf6vWj3C
         cvCrNLu+CrVBzzqu3MsbKDHkaiGXDy6Rbtd3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/RJwWrZ2M5oJXEFSa9WHJkWIFOQLYkCwM2AiEio3Bq0=;
        b=b1n5g0oFvjYxI+l4PcWt123NVhVeqmb8hqg1pSiripLstuHx7Qfwu46SiKALCNbuFL
         vlZS9nGqHgtBHdLe6loLmG7GJAZJVLiERgJZ4uYdKZe60O8QDAtPKzp+ynVf45C3cRTF
         ayvEpJzPDTemr20fqsV+RyAYmhuoMc934WrdhdVm8RldiRx+kpVkflPmESQIeIXb05+r
         vgeWg/Rl2bPP6/klwTTgJWjbOjIvr4ZK9INkdRDR9To2AnPSH36B6hxcK4oT6cas5d75
         zhB/btLvhT7P02w1pIXUCMYSVncUquBmX33FyObu3ysRivXndhPYLLRSq1MLMal2YW3X
         6x2g==
X-Gm-Message-State: APjAAAXVjVJ2CFH0FyES4yBbefw83IjU1Q4/8zY2H+NfKruKNno6fjue
        VJwzYTXLLSOm0GvjDM8by3lo1Q==
X-Google-Smtp-Source: APXvYqwPYhiOhDj+6h2cTxfM71WONNAkNdlGR1EhF3qH8+8++w34iTMGStn7eBr51SLAE1hz7U31ZA==
X-Received: by 2002:a37:a649:: with SMTP id p70mr15388221qke.497.1581957328223;
        Mon, 17 Feb 2020 08:35:28 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h9sm406654qtq.61.2020.02.17.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:35:27 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:35:27 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Amol Grover <frextrite@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RESEND] lockdep: Pass lockdep expression to RCU lists
Message-ID: <20200217163527.GB145700@google.com>
References: <20200216074636.GB14025@workstation-portable>
 <20200217151246.GS14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217151246.GS14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 04:12:46PM +0100, Peter Zijlstra wrote:
> On Sun, Feb 16, 2020 at 01:16:36PM +0530, Amol Grover wrote:
> > Data is traversed using hlist_for_each_entry_rcu outside an
> > RCU read-side critical section but under the protection
> > of either lockdep_lock or with irqs disabled.
> > 
> > Hence, add corresponding lockdep expression to silence false-positive
> > lockdep warnings, and harden RCU lists. Also add macro for
> > corresponding lockdep expression.
> > 
> > Two things to note:
> > - RCU traversals protected under both, irqs disabled and
> > graph lock, have both the checks in the lockdep expression.
> > - RCU traversals under the protection of just disabled irqs
> > don't have a corresponding lockdep expression as it is implicitly
> > checked for.
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > ---
> >  kernel/locking/lockdep.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 32282e7112d3..696ad5d4daed 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -85,6 +85,8 @@ module_param(lock_stat, int, 0644);
> >   * code to recurse back into the lockdep code...
> >   */
> >  static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
> > +#define graph_lock_held() \
> > +	arch_spin_is_locked(&lockdep_lock)
> >  static struct task_struct *lockdep_selftest_task_struct;
> >  
> >  static int graph_lock(void)
> > @@ -1009,7 +1011,7 @@ static bool __check_data_structures(void)
> >  	/* Check the chain_key of all lock chains. */
> >  	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
> >  		head = chainhash_table + i;
> > -		hlist_for_each_entry_rcu(chain, head, entry) {
> > +		hlist_for_each_entry_rcu(chain, head, entry, graph_lock_held()) {
> >  			if (!check_lock_chain_key(chain))
> >  				return false;
> >  		}
> 
> URGH.. this patch combines two horribles to create a horrific :/
> 
>  - spin_is_locked() is an abomination
>  - this RCU list stuff is just plain annoying
> 
> I'm tempted to do something like:
> 
> #define STFU (true)
> 
> 	hlist_for_each_entry_rcu(chain, head, entry, STFU) {
> 
> Paul, are we going a little over-board with this stuff? Do we really
> have to annotate all of this?

Could it use hlist_for_each_entry_rcu_notrace() if that's better for this
code? That one does not need the additional condition passed. Though I find
rcu_dereference_raw_nocheck() in that macro a bit odd since it does sparse
checking, where as the rcu_dereference_raw() in hlist_for_each_entry() does
nothing.

And perf can do the same thing if it iss too annoying, like the tracing code
does.

This came up mainly because list_for_each_entry_rcu() does some checking of
it is in a reader section, but it is helpless in its checking when a lock is
held.

thanks,

 - Joel

