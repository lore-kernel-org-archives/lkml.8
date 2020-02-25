Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60639C35DEA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D50921927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582591120;
	bh=jq3ODePJ3Q6zoN0OHkVIb2ToZ28VrtYjD3/dPpBAwUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ALE/zX5KkJcXXJnxiAx/Fx43aojZDICRdqm/QN8+KGTquVUh8Ccl178hhoZhNfEXb
	 gWnmYfSL21d+owzuy5fR2Kt85UIMLKgB1nAF63YdPyMoWi5/a7D248I9yDe0bY5mXS
	 zX04UC3fsDEQOOobuolUPOrCdzzwaXMwsGpapfq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgBYAij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:38:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgBYAii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:38:38 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727EC2072D;
        Tue, 25 Feb 2020 00:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582591116;
        bh=jq3ODePJ3Q6zoN0OHkVIb2ToZ28VrtYjD3/dPpBAwUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0bkniVS3jwtRsC+8G6oMWVV5CiKekmBhS3eBDkSEHm1jAB9Mfu7zT2BAsRTwSnOI/
         nif9ExSCKPT2copXKF7CCogu+iOq9LFdzn2HmqT3glMgLZcwi4tcTrNbdL8/+akbXD
         NpvxEngILyVqP2R1oZSb+x6GvzBiTtenwtM26xGI=
Date:   Mon, 24 Feb 2020 16:38:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     dave@stgolabs.net, rpenyaev@suse.de, linux-kernel@vger.kernel.org,
        normalperson@yhbt.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/epoll: make nesting accounting safe for -rt kernel
Message-Id: <20200224163835.08ab964483519052d7c2e39b@linux-foundation.org>
In-Reply-To: <1579288607-11868-1-git-send-email-jbaron@akamai.com>
References: <20200106210104.4hqlgpujqujcbeg7@linux-p48b>
        <1579288607-11868-1-git-send-email-jbaron@akamai.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 14:16:47 -0500 Jason Baron <jbaron@akamai.com> wrote:

> Davidlohr Bueso pointed out that when CONFIG_DEBUG_LOCK_ALLOC is set
> ep_poll_safewake() can take several non-raw spinlocks after disabling
> pre-emption which is no no for the -rt kernel. So let's re-work how we
> determine the nesting level such that it plays nicely with -rt kernel.

"no no" isn't terribly informative, and knowledge of -rt's requirements
isn't widespread.  Can we please spell this requirement out in full
detail, if only to spread the -rt education a bit?

> Let's introduce a 'nests' field in struct eventpoll that records the
> current nesting level during ep_poll_callback(). Then, if we nest again we
> can find the previous struct eventpoll that we were called from and
> increase our count by 1. The 'nests' field is protected by
> ep->poll_wait.lock.
> 
> I've also moved napi_id field into a hole in struct eventpoll as part of
> introduing the nests field. This change reduces the struct eventpoll from
> 184 bytes to 176 bytes on x86_64 for the !CONFIG_DEBUG_LOCK_ALLOC
> production config.
> 
> ...
>
> @@ -551,30 +557,43 @@ static int ep_call_nested(struct nested_calls *ncalls,
>   */
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
> -static DEFINE_PER_CPU(int, wakeup_nest);
> -
> -static void ep_poll_safewake(wait_queue_head_t *wq)
> +static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi)
>  {
> +	struct eventpoll *ep_src;
>  	unsigned long flags;
> -	int subclass;
> +	u8 nests = 0;
>  
> -	local_irq_save(flags);
> -	preempt_disable();
> -	subclass = __this_cpu_read(wakeup_nest);
> -	spin_lock_nested(&wq->lock, subclass + 1);
> -	__this_cpu_inc(wakeup_nest);
> -	wake_up_locked_poll(wq, POLLIN);
> -	__this_cpu_dec(wakeup_nest);
> -	spin_unlock(&wq->lock);
> -	local_irq_restore(flags);
> -	preempt_enable();
> +	/*
> +	 * If we are not being call from ep_poll_callback(), epi is
> +	 * NULL and we are at the first level of nesting, 0. Otherwise,
> +	 * we are being called from ep_poll_callback() and if a previous
> +	 * wakeup source is not an epoll file itself, we are at depth
> +	 * 1 since the wakeup source is depth 0. If the wakeup source
> +	 * is a previous epoll file in the wakeup chain then we use its
> +	 * nests value and record ours as nests + 1. The previous epoll
> +	 * file nests value is stable since its already holding its
> +	 * own poll_wait.lock.
> +	 */

Similarly, it would be helpful if this comment were to explain that
this code exists for -rt's requirements, and to briefly describe what
that requirement is.

> +	if (epi) {
> +		if ((is_file_epoll(epi->ffd.file))) {
> +			ep_src = epi->ffd.file->private_data;
> +			nests = ep_src->nests;
> +		} else {
> +			nests = 1;
> +		}
> +	}
> +	spin_lock_irqsave_nested(&ep->poll_wait.lock, flags, nests);
> +	ep->nests = nests + 1;
> +	wake_up_locked_poll(&ep->poll_wait, EPOLLIN);
> +	ep->nests = 0;
> +	spin_unlock_irqrestore(&ep->poll_wait.lock, flags);
>  }

