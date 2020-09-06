Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E528C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 14:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2737B20760
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599402586;
	bh=kk8tvuDP9hC/7aRZ33FULqCWUjta7ZZ0o/f5KhDoo6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YHsViJt4qtqLnbNoac3iW+S9Ch2KYzn3yQ3b1dSTP3sBhEox4/cOTIp+Rfy0im2BX
	 MyEK/cU7ys+5PqXP4gdGx/xnGAMxSGspd/Ae87f5/zK3nCC/hDAf6McAbHZAr93MJ5
	 w8sd0OtlfdESxVSWrJIOpcJshtMQmmCcYetN3Z1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgIFO3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 10:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgIFO1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 10:27:10 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0FCB20714;
        Sun,  6 Sep 2020 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599402411;
        bh=kk8tvuDP9hC/7aRZ33FULqCWUjta7ZZ0o/f5KhDoo6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cF69c5qc4w5+kMLmw1DlRKZQdvFUM+3fCtjTMRqBaOO4ZE2JPgdAjLbDZClTteuhE
         wnpY2T1UVE7n9xSNdiKz7vnzyDd+uOOEd42tuQJRrtvBYONVwLKhXSi8xlFVTmerrx
         NgKaP2n5kRm1BCH/0vl1ZCXhfBxKLvs9s0HxJtVM=
Date:   Sun, 6 Sep 2020 17:26:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/mmu_notifier.c: micro-optimization substitute kzalloc
 with kmalloc
Message-ID: <20200906142645.GA1976319@kernel.org>
References: <20200906114321.16493-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906114321.16493-1-mateusznosek0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 06, 2020 at 01:43:21PM +0200, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Most fields in struct pointed by 'subscriptions' are initialized explicitly
> after the allocation. By changing kzalloc to kmalloc the call to memset
> is avoided. As the only new code consists of 2 simple memory accesses,
> the performance is increased.

Is there a measurable performance increase?

The __mmu_notifier_register() is not used that frequently to trade off
robustness of kzalloc() for slight (if visible at all) performance gain.

> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> ---
>  mm/mmu_notifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 4fc918163dd3..190e198dc5be 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -625,7 +625,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>  		 * know that mm->notifier_subscriptions can't change while we
>  		 * hold the write side of the mmap_lock.
>  		 */
> -		subscriptions = kzalloc(
> +		subscriptions = kmalloc(
>  			sizeof(struct mmu_notifier_subscriptions), GFP_KERNEL);
>  		if (!subscriptions)
>  			return -ENOMEM;
> @@ -636,6 +636,8 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>  		subscriptions->itree = RB_ROOT_CACHED;
>  		init_waitqueue_head(&subscriptions->wq);
>  		INIT_HLIST_HEAD(&subscriptions->deferred_list);
> +		subscriptions->active_invalidate_ranges = 0;
> +		subscriptions->has_itree = false;
>  	}
>  
>  	ret = mm_take_all_locks(mm);
> -- 
> 2.20.1
> 
> 

-- 
Sincerely yours,
Mike.
