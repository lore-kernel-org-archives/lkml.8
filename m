Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB97C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBCB24658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579051879;
	bh=LGvA/0W7ghitYc3943cy/zC8D1E+WnipXpNG9S0D+no=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZnjwJEdYzSJkkSmaPHzkgTfOGzzH1SGj4jXpxklHtODwlL9BMmT27HgTvypNltd0m
	 urBRNbhqX1yrcrI9hLerpxUfzhQv/wfogJBJeSQXt6TNQqVfsh2G17678GRPcjC9M7
	 n2s4PmM+9FKQGnTDt4ZV1Jtge0UY/i072TuPAiAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAOBbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgAOBbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:31:18 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2075424658;
        Wed, 15 Jan 2020 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579051877;
        bh=LGvA/0W7ghitYc3943cy/zC8D1E+WnipXpNG9S0D+no=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s/M3H3+AtHSmlBygHUk8Jk0yUuo2faG9IVJ2hGHUVCcx106Wy07L8Z9iEnKTRIAM6
         do3kYGtZdWKgjX29MJI2DOgruRJg1z2qHIBDWp7UAV7ef0Er2NvwWxvxCTYOnuln77
         MPETu/YLkDD9cbsYUSjDkr0yEASR+3DmyGktEj5k=
Date:   Wed, 15 Jan 2020 10:31:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>, paulmck@kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V2 2/2] kprobes: Use non RCU traversal APIs on
 kprobe_tables if possible
Message-Id: <20200115103112.fe5dbff75d9e1e422cd60fd3@kernel.org>
In-Reply-To: <20200114135621.GA103493@google.com>
References: <157535316659.16485.11817291759382261088.stgit@devnote2>
        <157535318870.16485.6366477974356032624.stgit@devnote2>
        <20200114135621.GA103493@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 08:56:21 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Tue, Dec 03, 2019 at 03:06:28PM +0900, Masami Hiramatsu wrote:
> > Current kprobes uses RCU traversal APIs on kprobe_tables
> > even if it is safe because kprobe_mutex is locked.
> > 
> > Make those traversals to non-RCU APIs where the kprobe_mutex
> > is locked.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks Joel!
> 
> May be resend both patch with appropriate tags since it has been some time
> since originally posted?

OK, I'll update it on the latest -tip with your reviewed-by.

Thank you,

> 
> thanks,
> 
>  - Joel
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c |   29 ++++++++++++++++++++---------
> >  1 file changed, 20 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index f9ecb6d532fb..4caab01ace30 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -46,6 +46,11 @@
> >  
> >  
> >  static int kprobes_initialized;
> > +/* kprobe_table can be accessed by
> > + * - Normal hlist traversal and RCU add/del under kprobe_mutex is held.
> > + * Or
> > + * - RCU hlist traversal under disabling preempt (breakpoint handlers)
> > + */
> >  static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
> >  static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
> >  
> > @@ -829,7 +834,7 @@ static void optimize_all_kprobes(void)
> >  	kprobes_allow_optimization = true;
> >  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> >  		head = &kprobe_table[i];
> > -		hlist_for_each_entry_rcu(p, head, hlist)
> > +		hlist_for_each_entry(p, head, hlist)
> >  			if (!kprobe_disabled(p))
> >  				optimize_kprobe(p);
> >  	}
> > @@ -856,7 +861,7 @@ static void unoptimize_all_kprobes(void)
> >  	kprobes_allow_optimization = false;
> >  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> >  		head = &kprobe_table[i];
> > -		hlist_for_each_entry_rcu(p, head, hlist) {
> > +		hlist_for_each_entry(p, head, hlist) {
> >  			if (!kprobe_disabled(p))
> >  				unoptimize_kprobe(p, false);
> >  		}
> > @@ -1479,12 +1484,14 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
> >  {
> >  	struct kprobe *ap, *list_p;
> >  
> > +	lockdep_assert_held(&kprobe_mutex);
> > +
> >  	ap = get_kprobe(p->addr);
> >  	if (unlikely(!ap))
> >  		return NULL;
> >  
> >  	if (p != ap) {
> > -		list_for_each_entry_rcu(list_p, &ap->list, list)
> > +		list_for_each_entry(list_p, &ap->list, list)
> >  			if (list_p == p)
> >  			/* kprobe p is a valid probe */
> >  				goto valid;
> > @@ -1649,7 +1656,9 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
> >  {
> >  	struct kprobe *kp;
> >  
> > -	list_for_each_entry_rcu(kp, &ap->list, list)
> > +	lockdep_assert_held(&kprobe_mutex);
> > +
> > +	list_for_each_entry(kp, &ap->list, list)
> >  		if (!kprobe_disabled(kp))
> >  			/*
> >  			 * There is an active probe on the list.
> > @@ -1728,7 +1737,7 @@ static int __unregister_kprobe_top(struct kprobe *p)
> >  	else {
> >  		/* If disabling probe has special handlers, update aggrprobe */
> >  		if (p->post_handler && !kprobe_gone(p)) {
> > -			list_for_each_entry_rcu(list_p, &ap->list, list) {
> > +			list_for_each_entry(list_p, &ap->list, list) {
> >  				if ((list_p != p) && (list_p->post_handler))
> >  					goto noclean;
> >  			}
> > @@ -2042,13 +2051,15 @@ static void kill_kprobe(struct kprobe *p)
> >  {
> >  	struct kprobe *kp;
> >  
> > +	lockdep_assert_held(&kprobe_mutex);
> > +
> >  	p->flags |= KPROBE_FLAG_GONE;
> >  	if (kprobe_aggrprobe(p)) {
> >  		/*
> >  		 * If this is an aggr_kprobe, we have to list all the
> >  		 * chained probes and mark them GONE.
> >  		 */
> > -		list_for_each_entry_rcu(kp, &p->list, list)
> > +		list_for_each_entry(kp, &p->list, list)
> >  			kp->flags |= KPROBE_FLAG_GONE;
> >  		p->post_handler = NULL;
> >  		kill_optimized_kprobe(p);
> > @@ -2217,7 +2228,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
> >  	mutex_lock(&kprobe_mutex);
> >  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> >  		head = &kprobe_table[i];
> > -		hlist_for_each_entry_rcu(p, head, hlist)
> > +		hlist_for_each_entry(p, head, hlist)
> >  			if (within_module_init((unsigned long)p->addr, mod) ||
> >  			    (checkcore &&
> >  			     within_module_core((unsigned long)p->addr, mod))) {
> > @@ -2468,7 +2479,7 @@ static int arm_all_kprobes(void)
> >  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> >  		head = &kprobe_table[i];
> >  		/* Arm all kprobes on a best-effort basis */
> > -		hlist_for_each_entry_rcu(p, head, hlist) {
> > +		hlist_for_each_entry(p, head, hlist) {
> >  			if (!kprobe_disabled(p)) {
> >  				err = arm_kprobe(p);
> >  				if (err)  {
> > @@ -2511,7 +2522,7 @@ static int disarm_all_kprobes(void)
> >  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> >  		head = &kprobe_table[i];
> >  		/* Disarm all kprobes on a best-effort basis */
> > -		hlist_for_each_entry_rcu(p, head, hlist) {
> > +		hlist_for_each_entry(p, head, hlist) {
> >  			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p)) {
> >  				err = disarm_kprobe(p, false);
> >  				if (err) {
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
