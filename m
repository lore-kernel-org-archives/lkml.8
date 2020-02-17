Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F4C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346F9208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yhzn7389"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgBQPMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:12:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBQPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f+3OGTXOU6Agins356Z5AqkAfZFQT+Vwt5LSeJBahwY=; b=Yhzn7389uoyG2+7V8Fg9PmlgDb
        5bYbLZ/YhuQkPbtChlCW9wTPERlwg3vWvvg1jtDb+bt2j66rhlb4ufs7Gjri/eY031IdSgjJcal+f
        qqsAVPoj1+HJlTuPgNagW5d8nfIatiUiKzzKoUpGKhnCLFhIUuB+QwR39vFKUXKIywH4yMXqAauBi
        kle3ZaZDoDbvzy/N7U69zqKn0ZXGkpV2EinV+sTF0qKeFNMACG9rdpCqwRRet55sCmCJ+5TboAv7G
        EBk0cuKHtDcYPh0NettgFQxFVGR+kJgX5GHYl3NmnXJaUHhueLo9wvyw/j9RH/dWZ+7yU59CmmH6b
        r2OLORXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3i4m-0004bd-1D; Mon, 17 Feb 2020 15:12:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93254304D2C;
        Mon, 17 Feb 2020 16:10:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 147682B910502; Mon, 17 Feb 2020 16:12:46 +0100 (CET)
Date:   Mon, 17 Feb 2020 16:12:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RESEND] lockdep: Pass lockdep expression to RCU lists
Message-ID: <20200217151246.GS14897@hirez.programming.kicks-ass.net>
References: <20200216074636.GB14025@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216074636.GB14025@workstation-portable>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 01:16:36PM +0530, Amol Grover wrote:
> Data is traversed using hlist_for_each_entry_rcu outside an
> RCU read-side critical section but under the protection
> of either lockdep_lock or with irqs disabled.
> 
> Hence, add corresponding lockdep expression to silence false-positive
> lockdep warnings, and harden RCU lists. Also add macro for
> corresponding lockdep expression.
> 
> Two things to note:
> - RCU traversals protected under both, irqs disabled and
> graph lock, have both the checks in the lockdep expression.
> - RCU traversals under the protection of just disabled irqs
> don't have a corresponding lockdep expression as it is implicitly
> checked for.
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  kernel/locking/lockdep.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 32282e7112d3..696ad5d4daed 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -85,6 +85,8 @@ module_param(lock_stat, int, 0644);
>   * code to recurse back into the lockdep code...
>   */
>  static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
> +#define graph_lock_held() \
> +	arch_spin_is_locked(&lockdep_lock)
>  static struct task_struct *lockdep_selftest_task_struct;
>  
>  static int graph_lock(void)
> @@ -1009,7 +1011,7 @@ static bool __check_data_structures(void)
>  	/* Check the chain_key of all lock chains. */
>  	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
>  		head = chainhash_table + i;
> -		hlist_for_each_entry_rcu(chain, head, entry) {
> +		hlist_for_each_entry_rcu(chain, head, entry, graph_lock_held()) {
>  			if (!check_lock_chain_key(chain))
>  				return false;
>  		}

URGH.. this patch combines two horribles to create a horrific :/

 - spin_is_locked() is an abomination
 - this RCU list stuff is just plain annoying

I'm tempted to do something like:

#define STFU (true)

	hlist_for_each_entry_rcu(chain, head, entry, STFU) {

Paul, are we going a little over-board with this stuff? Do we really
have to annotate all of this?
