Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC24FC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 18:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B5324656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581964114;
	bh=VX6VBdSNbKVS9TKiwcwWl/BkRExmIhlTJuoRPfrgS4A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XeNiDabR5FdLzYVQRrZBonQqjEpBBcrL8n5yfYCsCn6prTabmcc2cdrYm+vLT1oQ6
	 SDp5ax9E3Qfh5RVhUE2HB+T1x4uR9J0ByLveayrBJ0te4ZZW1a56PcQzIOcxrN7waE
	 fv4Kc3PrB3wxPDUU1+npW9AtKWrS1Z9MEzuOe6nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBQS2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgBQS2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:28:33 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0436227BF;
        Mon, 17 Feb 2020 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581964111;
        bh=VX6VBdSNbKVS9TKiwcwWl/BkRExmIhlTJuoRPfrgS4A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ORd/0qL1SPD3b86/Yo1Efg4x74DS5vMT5gyOhni0O69KZ6QcvIex5QAlyLDF0emPk
         aMPaweMZVVzCNzc/9AQPZuI/l0hsEx9VC/NID5+qqsGYpn4fIyTx3usXI4YekdWEcl
         YjINY2b4jXrvlZV3/RbJSRfRJzh3PVtpMZuR0fCw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8A970352273C; Mon, 17 Feb 2020 10:28:31 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:28:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Amol Grover <frextrite@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH RESEND] lockdep: Pass lockdep expression to RCU lists
Message-ID: <20200217182831.GR2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200216074636.GB14025@workstation-portable>
 <20200217151246.GS14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217151246.GS14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Agreed, I would prefer use of lockdep assertions myself.  And yes, I
did try to get rid of spin_is_locked() some time back, but there were
a few use cases that proved stubborn.  :-(

>  - this RCU list stuff is just plain annoying
> 
> I'm tempted to do something like:
> 
> #define STFU (true)
> 
> 	hlist_for_each_entry_rcu(chain, head, entry, STFU) {

Now that is just plain silly.  It is easier to type "true" than "STFU",
satisfying though the latter might feel to you right now.

> Paul, are we going a little over-board with this stuff? Do we really
> have to annotate all of this?

Like rcu_dereference_raw()?  

My goal is to provide infrastructure that allows people to gain the
benefit of automated code review if they so choose.  And a number have
so chosen.  In this case, it is pretty easy to disable the checking by
adding "true" as the last argument, so I am not seeing a real problem.

Just don't come crying to me if doing so ends up hiding a bug.  ;-)

							Thanx, Paul
