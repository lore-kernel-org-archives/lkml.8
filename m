Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E534BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BC52073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584468419;
	bh=fhqjdz2SvIhTwHee1s+CAJH/QHf5hlfSHLnF2fRjfGU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZzmRLISaegiVFqQDGCBOizH08DhfQb4Gnpl4sjZuyHgHgQ/1QX4+JRSfURhHppHU8
	 BI/0Y6h7qFCWHOovROVgqGKjXVzwswXgOOOq+v/vUDf9dKOPG0gAfNdps0EbkeRBy1
	 BR5Ti+Bkr/7JzUwyutJqMiVhh2Nd6jN9Id01p13g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCQSG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQSG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:06:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395ED20735;
        Tue, 17 Mar 2020 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584468417;
        bh=fhqjdz2SvIhTwHee1s+CAJH/QHf5hlfSHLnF2fRjfGU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=luetIUBFQICDZtksurUpeGOYGQrt/b7Tf8MmcXq39WlD7ZlkDj62dp65npBxzbsr5
         9MUE83I4cKdHMLctV02DyR8xL7Pyb3PIcKdHFq5OZ9RUKvPwaFruwMAyd/0hVLzh+t
         kDsqW9CSjvZLNCzj5a9oT9dtV73kKgJR6Hg4Cw2U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0BD0835226E2; Tue, 17 Mar 2020 11:06:57 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:06:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, jgg@ziepe.ca, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: silence PROVE_RCU_LIST warnings
Message-ID: <20200317180657.GK3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200317175640.2047-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317175640.2047-1-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 01:56:40PM -0400, Qian Cai wrote:
> It is safe to traverse mm->notifier_subscriptions->list either under
> SRCU read lock or mm->notifier_subscriptions->lock using
> hlist_for_each_entry_rcu(). Silence the PROVE_RCU_LIST false positives,
> for example,
> 
>  WARNING: suspicious RCU usage
>  -----------------------------
>  mm/mmu_notifier.c:484 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  3 locks held by libvirtd/802:
>   #0: ffff9321e3f58148 (&mm->mmap_sem#2){++++}, at: do_mprotect_pkey+0xe1/0x3e0
>   #1: ffffffff91ae6160 (mmu_notifier_invalidate_range_start){+.+.}, at: change_p4d_range+0x5fa/0x800
>   #2: ffffffff91ae6e08 (srcu){....}, at: __mmu_notifier_invalidate_range_start+0x178/0x460
> 
>  stack backtrace:
>  CPU: 7 PID: 802 Comm: libvirtd Tainted: G          I       5.6.0-rc6-next-20200317+ #2
>  Hardware name: HP ProLiant BL460c Gen8, BIOS I31 11/02/2014
>  Call Trace:
>   dump_stack+0xa4/0xfe
>   lockdep_rcu_suspicious+0xeb/0xf5
>   __mmu_notifier_invalidate_range_start+0x3ff/0x460
>   change_p4d_range+0x746/0x800
>   change_protection+0x1df/0x300
>   mprotect_fixup+0x245/0x3e0
>   do_mprotect_pkey+0x23b/0x3e0
>   __x64_sys_mprotect+0x51/0x70
>   do_syscall_64+0x91/0xae8
>   entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

From an RCU perspective:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  mm/mmu_notifier.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index ef3973a5d34a..06852b896fa6 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -307,7 +307,8 @@ static void mn_hlist_release(struct mmu_notifier_subscriptions *subscriptions,
>  	 * ->release returns.
>  	 */
>  	id = srcu_read_lock(&srcu);
> -	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist)
> +	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist,
> +				 srcu_read_lock_held(&srcu))
>  		/*
>  		 * If ->release runs before mmu_notifier_unregister it must be
>  		 * handled, as it's the only way for the driver to flush all
> @@ -370,7 +371,8 @@ int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
>  
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_rcu(subscription,
> -				 &mm->notifier_subscriptions->list, hlist) {
> +				 &mm->notifier_subscriptions->list, hlist,
> +				 srcu_read_lock_held(&srcu)) {
>  		if (subscription->ops->clear_flush_young)
>  			young |= subscription->ops->clear_flush_young(
>  				subscription, mm, start, end);
> @@ -389,7 +391,8 @@ int __mmu_notifier_clear_young(struct mm_struct *mm,
>  
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_rcu(subscription,
> -				 &mm->notifier_subscriptions->list, hlist) {
> +				 &mm->notifier_subscriptions->list, hlist,
> +				 srcu_read_lock_held(&srcu)) {
>  		if (subscription->ops->clear_young)
>  			young |= subscription->ops->clear_young(subscription,
>  								mm, start, end);
> @@ -407,7 +410,8 @@ int __mmu_notifier_test_young(struct mm_struct *mm,
>  
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_rcu(subscription,
> -				 &mm->notifier_subscriptions->list, hlist) {
> +				 &mm->notifier_subscriptions->list, hlist,
> +				 srcu_read_lock_held(&srcu)) {
>  		if (subscription->ops->test_young) {
>  			young = subscription->ops->test_young(subscription, mm,
>  							      address);
> @@ -428,7 +432,8 @@ void __mmu_notifier_change_pte(struct mm_struct *mm, unsigned long address,
>  
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_rcu(subscription,
> -				 &mm->notifier_subscriptions->list, hlist) {
> +				 &mm->notifier_subscriptions->list, hlist,
> +				 srcu_read_lock_held(&srcu)) {
>  		if (subscription->ops->change_pte)
>  			subscription->ops->change_pte(subscription, mm, address,
>  						      pte);
> @@ -476,7 +481,8 @@ static int mn_hlist_invalidate_range_start(
>  	int id;
>  
>  	id = srcu_read_lock(&srcu);
> -	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist) {
> +	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist,
> +				 srcu_read_lock_held(&srcu)) {
>  		const struct mmu_notifier_ops *ops = subscription->ops;
>  
>  		if (ops->invalidate_range_start) {
> @@ -528,7 +534,8 @@ mn_hlist_invalidate_end(struct mmu_notifier_subscriptions *subscriptions,
>  	int id;
>  
>  	id = srcu_read_lock(&srcu);
> -	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist) {
> +	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist,
> +				 srcu_read_lock_held(&srcu)) {
>  		/*
>  		 * Call invalidate_range here too to avoid the need for the
>  		 * subsystem of having to register an invalidate_range_end
> @@ -582,7 +589,8 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
>  
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_rcu(subscription,
> -				 &mm->notifier_subscriptions->list, hlist) {
> +				 &mm->notifier_subscriptions->list, hlist,
> +				 srcu_read_lock_held(&srcu)) {
>  		if (subscription->ops->invalidate_range)
>  			subscription->ops->invalidate_range(subscription, mm,
>  							    start, end);
> @@ -714,7 +722,8 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
>  
>  	spin_lock(&mm->notifier_subscriptions->lock);
>  	hlist_for_each_entry_rcu(subscription,
> -				 &mm->notifier_subscriptions->list, hlist) {
> +				 &mm->notifier_subscriptions->list, hlist,
> +				 lockdep_is_held(&mm->notifier_subscriptions->lock)) {
>  		if (subscription->ops != ops)
>  			continue;
>  
> -- 
> 2.21.0 (Apple Git-122.2)
> 
