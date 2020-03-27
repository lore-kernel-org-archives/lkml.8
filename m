Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B745C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA7620714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBagvQ3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgC0JiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:38:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0JiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x9/k7pLBQXCwm7HGvR1QbvLQvbr1hh7C7rCsl4jVIp8=; b=GBagvQ3n3RtUHtNaZr+93PgyTz
        FoC+rqyv0fZwWLad3v3YTDiSA3bQpzsrz7DNe9lYbKu/dzX/LizYBtyQr3OjE6IusokaLyZ2KeYf9
        Jko1nCvSwFcdzQHePIVaHU07umb3Wi7OsPwp3psxL1EJp7dF658jJoaDkIOcMGN4R+hporRkR+ihW
        kDC0SG9iSF0+gVcHHncvw8xzTvnx5HgY3xUcOyAVnP8yjOckwwMuNKqsmW5DNrxd6KWe20YGKXpK+
        FGircB0FvGDmKCAXF6abyVAuu35YJTFUD0BN9MQ5gZdTBNO22i05ybmrmWmrmEpP/ANvWnvoQYQMH
        g3BSVfag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHlR7-0008Ch-Di; Fri, 27 Mar 2020 09:37:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDD1A30066E;
        Fri, 27 Mar 2020 10:37:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD153203B8786; Fri, 27 Mar 2020 10:37:54 +0100 (CET)
Date:   Fri, 27 Mar 2020 10:37:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, will@kernel.org, dbueso@suse.de,
        juri.lelli@redhat.com, longman@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] locking/percpu-rwsem: fix a task_struct refcount
Message-ID: <20200327093754.GS20713@hirez.programming.kicks-ass.net>
References: <20200327031057.10866-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327031057.10866-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 11:10:57PM -0400, Qian Cai wrote:
> There are some memory leaks due to a missing put_task_struct().

This is an absolutely inadequate changelog. There is no explaning what
the actual race is and why this patch is correct.

> Fixes: 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/locking/percpu-rwsem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index a008a1ba21a7..6f487e5d923f 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -123,8 +123,10 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
>  	struct percpu_rw_semaphore *sem = key;
>  
>  	/* concurrent against percpu_down_write(), can get stolen */
> -	if (!__percpu_rwsem_trylock(sem, reader))
> +	if (!__percpu_rwsem_trylock(sem, reader)) {
> +		put_task_struct(p);
>  		return 1;
> +	}


If the trylock fails, someone else got the lock and we remain on the
waitqueue. It seems like a very bad idea to put the task while it
remains on the waitqueue, no?

>  
>  	list_del_init(&wq_entry->entry);
>  	smp_store_release(&wq_entry->private, NULL);
> -- 
> 2.21.0 (Apple Git-122.2)
> 
