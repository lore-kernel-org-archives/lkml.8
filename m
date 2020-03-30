Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC732C2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C12072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0AxAHpo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgC3LWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:22:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51942 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgC3LWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q2n6qPenASCrW6zwwJ/Y7lU7/RnxxUx8uc2DpJ5ezec=; b=0AxAHpo/v9r0VGXe9IeSFWlD6e
        MoHYuPfXujsR6+qJX2jNjyR/T+i+q5INt7FR4VkPs5PcwUb2FtIqO5ILprsqGm0dBvJWE+ewN2vLM
        XDUPmnxeNWPBsf9cZo5o0tLZsOJ7t0IEvPPw+1aI393oazlc5zBZLWhlUn67BNRmSaGs0YFRMty0G
        FzndWtBFkFZ3AWQ0X/NT0KrIw0DxgGpA7Ezfld+kpY2ScH0U5qjyablAZ1CGGiPHKVa4AQHtxqLYM
        vftidEaFGhFGiKJhjkcTL5AMZOUEWRgzffto4GbLKVU13XcNp7x3eIxskmO14YvNrJRITjyZ5jpbV
        BD00nMbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIsUQ-00027j-Hp; Mon, 30 Mar 2020 11:21:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5881D3010C1;
        Mon, 30 Mar 2020 13:21:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BE1229D04D66; Mon, 30 Mar 2020 13:21:57 +0200 (CEST)
Date:   Mon, 30 Mar 2020 13:21:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        boqun.feng@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/4] locking/rtmutex: Remove Comparison to bool
Message-ID: <20200330112157.GI20696@hirez.programming.kicks-ass.net>
References: <0/4>
 <20200330012450.312155-1-jbi.octave@gmail.com>
 <20200330012450.312155-5-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330012450.312155-5-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:24:50AM +0100, Jules Irenge wrote:
> Coccinelle reports a warning inside __sched rt_mutex_slowunlock()
> 
> WARNING: Comparison to bool

I don't mind the patch; but WTH is that a WARNING ?!? Superfluous, but
definitely not wrong or even dangerous AFAICT.

> To fix this,
> a comparison (==) of a bool type function result to value true
> together with the value are removed.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  kernel/locking/rtmutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 851bbb10819d..7289e7b26be4 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1378,7 +1378,7 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
>  	 */
>  	while (!rt_mutex_has_waiters(lock)) {
>  		/* Drops lock->wait_lock ! */
> -		if (unlock_rt_mutex_safe(lock, flags) == true)
> +		if (unlock_rt_mutex_safe(lock, flags))
>  			return false;
>  		/* Relock the rtmutex and try again */
>  		raw_spin_lock_irqsave(&lock->wait_lock, flags);
> -- 
> 2.25.1
> 
