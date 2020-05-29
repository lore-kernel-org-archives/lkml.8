Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9606C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF2F20897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgE2WOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgE2WOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:14:05 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F4420776;
        Fri, 29 May 2020 22:14:03 +0000 (UTC)
Date:   Fri, 29 May 2020 18:14:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        bigeasy@linutronix.de
Subject: Re: [PATCH 13/14] lockdep: Prepare for NMI IRQ state tracking
Message-ID: <20200529181401.1f01bdc5@oasis.local.home>
In-Reply-To: <20200529213321.471984676@infradead.org>
References: <20200529212728.795169701@infradead.org>
        <20200529213321.471984676@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 23:27:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> There is no reason not to always, accurately, track IRQ state.
> 
> This change also makes IRQ state tracking ignore lockdep_off().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/lockdep.c |   33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3646,7 +3646,13 @@ static void __trace_hardirqs_on_caller(v
>   */
>  void lockdep_hardirqs_on_prepare(unsigned long ip)
>  {
> -	if (unlikely(!debug_locks || current->lockdep_recursion))

Why remove the check for debug_locks? Isn't that there to disable
everything at once to prevent more warnings to be printed?

Also, isn't there other ways that we could have recursion besides NMIs?
Say we do a printk inside here, or call something that may also enable
interrupts? I thought the recursion check was also to prevent lockdep
infrastructure calling something that lockdep monitors being a problem?

Or am I missing something?

-- Steve


> +	/*
> +	 * NMIs do not (and cannot) track lock dependencies, nothing to do.
> +	 */
> +	if (in_nmi())
> +		return;
> +
> +	if (DEBUG_LOCKS_WARN_ON(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
>  		return;
>  
>  	if (unlikely(current->hardirqs_enabled)) {
> @@ -3692,7 +3698,24 @@ void noinstr lockdep_hardirqs_on(unsigne
>  {
>  	struct task_struct *curr = current;
>  
> -	if (unlikely(!debug_locks || curr->lockdep_recursion))
> +	/*
> +	 * NMIs can happen in the middle of local_irq_{en,dis}able() where the
> +	 * tracking state and hardware state are out of sync.
> +	 *
> +	 * NMIs must save lockdep_hardirqs_enabled() to restore IRQ state from,
> +	 * and not rely on hardware state like normal interrupts.
> +	 */
> +	if (in_nmi()) {
> +		/*
> +		 * Skip:
> +		 *  - recursion check, because NMI can hit lockdep;
> +		 *  - hardware state check, because above;
> +		 *  - chain_key check, see lockdep_hardirqs_on_prepare().
> +		 */
> +		goto skip_checks;
> +	}
> +
> +	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_recursion & LOCKDEP_RECURSION_MASK))
>  		return;
>  
>  	if (curr->hardirqs_enabled) {
> @@ -3720,6 +3743,7 @@ void noinstr lockdep_hardirqs_on(unsigne
>  	DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key !=
>  			    current->curr_chain_key);
>  
> +skip_checks:
>  	/* we'll do an OFF -> ON transition: */
>  	curr->hardirqs_enabled = 1;
>  	curr->hardirq_enable_ip = ip;
> @@ -3735,7 +3759,10 @@ void noinstr lockdep_hardirqs_off(unsign
>  {
>  	struct task_struct *curr = current;
>  
> -	if (unlikely(!debug_locks || curr->lockdep_recursion))
> +	/*
> +	 * NMIs can happen in lockdep.
> +	 */
> +	if (!in_nmi() && DEBUG_LOCKS_WARN_ON(curr->lockdep_recursion & LOCKDEP_RECURSION_MASK))
>  		return;
>  
>  	/*
> 

