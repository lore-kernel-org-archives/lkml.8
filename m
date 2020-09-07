Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E6C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835BD2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599495666;
	bh=zCSFPl/bVyJEOtJqE/X/0a0Sh3/8r5uhJmDZTmPKcmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zY7t1lCFnbSRMVaLhfqlu/R8kS1ZIDxOI7fUDo9N6L2k97B0MYk7v1OcNFueG6CG2
	 IeDpGRasQxcNR0c5bDJ4/bNjDjvt1kmEysDetWKHkAy8BE9GVVXruLP09WITWBE9EH
	 UkqVlFu+qPaMsPskxIPzNRc006mUt65wwW7GYCg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgIGQVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbgIGQUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:20:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDFF2207DE;
        Mon,  7 Sep 2020 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495635;
        bh=zCSFPl/bVyJEOtJqE/X/0a0Sh3/8r5uhJmDZTmPKcmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xo9Jhn0iwN69oqre/7j5ssBiF2Lf5ngeRytPZ8gUVsMXkYmU93SFnKWw67dKBqfKR
         qRPxZ0/iIenaYqUL6DIBDDIiGBuePXta0Am5i9258BeJOUIktD6PFYRpfPMSLb3UCB
         aMHNAXvV6lFwpVmcqGBZncZlp0rbi5gwqGZv32LU=
Date:   Mon, 7 Sep 2020 17:20:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] locking/mutex: Don't hog RCU read lock while
 optimistically spinning
Message-ID: <20200907162031.GA13172@willie-the-truck>
References: <20200807191636.75045-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807191636.75045-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 12:16:35PM -0700, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> There's no reason to hold an RCU read lock the entire time while
> optimistically spinning for a mutex lock. This can needlessly lengthen
> RCU grace periods and slow down synchronize_rcu() when it doesn't brute
> force the RCU grace period via rcupdate.rcu_expedited=1.

Would be good to demonstrate this with numbers if you can.

> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  kernel/locking/mutex.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 5352ce50a97e..cc5676712458 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -552,21 +552,31 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
>  {
>  	bool ret = true;
>  
> -	rcu_read_lock();
> -	while (__mutex_owner(lock) == owner) {
> +	for (;;) {
> +		unsigned int cpu;
> +		bool same_owner;
> +
>  		/*
> -		 * Ensure we emit the owner->on_cpu, dereference _after_
> -		 * checking lock->owner still matches owner. If that fails,
> +		 * Ensure lock->owner still matches owner. If that fails,
>  		 * owner might point to freed memory. If it still matches,
>  		 * the rcu_read_lock() ensures the memory stays valid.
>  		 */
> -		barrier();
> +		rcu_read_lock();
> +		same_owner = __mutex_owner(lock) == owner;
> +		if (same_owner) {
> +			ret = owner->on_cpu;
> +			if (ret)
> +				cpu = task_cpu(owner);
> +		}
> +		rcu_read_unlock();

Are you sure this doesn't break the ww mutex spinning? That thing also goes
and looks at the owner, but now it's called outside of the read-side
critical section.

Will
