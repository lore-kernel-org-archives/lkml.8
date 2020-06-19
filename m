Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E5AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5115720776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oeJ1FTSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgFSIac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgFSIa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:30:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB63C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MNa77Uka+uPnWc2u/Leq2Ulhe8baLYyiuRmc3agmOt0=; b=oeJ1FTStEQBysI1B1Hq5UE1IdN
        8ElI9XqQz6k9cGSfGCzFJBxRnRuATG34FvbvuUPNasgdmnpg9SyPUCJmSqPSPo95ZKOqbWPrCyhpf
        WbhoIZeu6QMKfHm299rhCaDGBiMSHW/nW3tXm/yxWUbxJ+ws6roeqSrXM2d6/JLkDVNSSD/rDERMk
        spsxSU2Ua0f2DmQR4Rvg4PAH9Ocvd3InwpmQ+ioSw+8LrJvm5aUhstLc3Tzu5P6rR8dQ5RRHwSTQq
        V0K5XQDw06XyLkiN+f6Wmv5b3zI+eJOtoPq3oJ0Z1AB/JLbwmo734BUjZ+judVqJrWqtmOGnTDHGJ
        JMxg1SUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmCPp-00059Q-Hu; Fri, 19 Jun 2020 08:30:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D136630604B;
        Fri, 19 Jun 2020 10:30:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C27DD2038B22F; Fri, 19 Jun 2020 10:30:23 +0200 (CEST)
Date:   Fri, 19 Jun 2020 10:30:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Michel Lespinasse <walken@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Adams <jwadams@google.com>,
        David Rientjes <rientjes@google.com>,
        Ying Han <yinghan@google.com>
Subject: Re: [RFC PATCH v3 1/1] mmap_lock: add tracepoints around mmap_lock
 acquisition
Message-ID: <20200619083023.GS576905@hirez.programming.kicks-ass.net>
References: <20200618222225.102337-1-axelrasmussen@google.com>
 <20200618222225.102337-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618222225.102337-2-axelrasmussen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 03:22:25PM -0700, Axel Rasmussen wrote:
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index f11b9bd3431d..6aabea1cbc5d 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1495,6 +1495,20 @@ void __sched down_read(struct rw_semaphore *sem)
>  }
>  EXPORT_SYMBOL(down_read);
> 
> +/*
> + * lock for reading
> + */
> +void __sched down_read_contended_hook(struct rw_semaphore *sem,
> +				      void (*pre)(void *),
> +				      void (*post)(void *), void *arg)
> +{
> +	might_sleep();
> +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> +	LOCK_CONTENDED_HOOK(sem, __down_read_trylock, __down_read, pre, post,
> +			    arg);
> +}
> +EXPORT_SYMBOL(down_read_contended_hook);
> +
>  int __sched down_read_killable(struct rw_semaphore *sem)
>  {
>  	might_sleep();
> @@ -1509,6 +1523,24 @@ int __sched down_read_killable(struct rw_semaphore *sem)
>  }
>  EXPORT_SYMBOL(down_read_killable);
> 
> +int __sched down_read_killable_contended_hook(struct rw_semaphore *sem,
> +					      void (*pre)(void *),
> +					      void (*post)(void *, int),
> +					      void *arg)
> +{
> +	might_sleep();
> +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> +
> +	if (LOCK_CONTENDED_HOOK_RETURN(sem, __down_read_trylock,
> +				       __down_read_killable, pre, post, arg)) {
> +		rwsem_release(&sem->dep_map, _RET_IP_);
> +		return -EINTR;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(down_read_killable_contended_hook);
> +
>  /*
>   * trylock for reading -- returns 1 if successful, 0 if contention
>   */
> @@ -1533,6 +1565,20 @@ void __sched down_write(struct rw_semaphore *sem)
>  }
>  EXPORT_SYMBOL(down_write);
> 
> +/*
> + * lock for writing
> + */
> +void __sched down_write_contended_hook(struct rw_semaphore *sem,
> +				       void (*pre)(void *),
> +				       void (*post)(void *), void *arg)
> +{
> +	might_sleep();
> +	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> +	LOCK_CONTENDED_HOOK(sem, __down_write_trylock, __down_write, pre, post,
> +			    arg);
> +}
> +EXPORT_SYMBOL(down_write_contended_hook);
> +
>  /*
>   * lock for writing
>   */
> @@ -1551,6 +1597,24 @@ int __sched down_write_killable(struct rw_semaphore *sem)
>  }
>  EXPORT_SYMBOL(down_write_killable);
> 
> +int __sched down_write_killable_contended_hook(struct rw_semaphore *sem,
> +					       void (*pre)(void *),
> +					       void (*post)(void *, int),
> +					       void *arg)
> +{
> +	might_sleep();
> +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> +
> +	if (LOCK_CONTENDED_HOOK_RETURN(sem, __down_write_trylock,
> +				       __down_write_killable, pre, post, arg)) {
> +		rwsem_release(&sem->dep_map, _RET_IP_);
> +		return -EINTR;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(down_write_killable_contended_hook);
> +
>  /*
>   * trylock for writing -- returns 1 if successful, 0 if contention
>   */

NAK, absolutely not going to happen. This is an atrocious API to expose,
worse you're exporting.
