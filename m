Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9366C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lpFA08sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAVRJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:09:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H41vAC6tCQoCgyqVrd/aoqOng0EACXvJHnhie2BBbxs=; b=lpFA08srx/a08vn7Z2cOK+dBm
        B4hCoXMx/GECzcK00sFT21MD4rAVwG9MQ9GgrArzAWDlCkj0FqAibxVZxE1ejC0lqa65GIvVDSb69
        8Rw+bzy7teRrJsv5W4ZqaJIoup5yWeLBo2x8fwrDB/+bIkc4TPgjhca1SNFnSmhiZxX3qI7F8yrK3
        lqt91rEduGnbLYZ024dgyUicOERWp1S+k29iztYhnX7eqRvhBZElJvLIEy8c0entD16/XuRcZ8+8v
        2xCDCqCNdO3AyxQPyV4krFYi3oJnZvGIe9I5NLlW1NlVm2LIhqB2t2sVzO2ycUUYRBEzlwjzw5iWU
        82442y+hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuJVi-0005pY-R8; Wed, 22 Jan 2020 17:09:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F84E30067C;
        Wed, 22 Jan 2020 18:08:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0E192B7249AA; Wed, 22 Jan 2020 18:09:44 +0100 (CET)
Date:   Wed, 22 Jan 2020 18:09:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, will@kernel.org, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200122170944.GZ14879@hirez.programming.kicks-ass.net>
References: <20200122163857.4605-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122163857.4605-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:38:57AM -0500, Qian Cai wrote:
> KCSAN complains,
> 
>  write (marked) to 0xffff941ca3b3be00 of 8 bytes by task 670 on cpu 6:
>   osq_lock+0x24c/0x340
>   __mutex_lock+0x277/0xd20
>   mutex_lock_nested+0x31/0x40
>   memcg_create_kmem_cache+0x2e/0x190
>   memcg_kmem_cache_create_func+0x40/0x80
>   process_one_work+0x54c/0xbe0
>   worker_thread+0x80/0x650
>   kthread+0x1e0/0x200
>   ret_from_fork+0x27/0x50
> 
>  read to 0xffff941ca3b3be00 of 8 bytes by task 703 on cpu 44:
>   osq_lock+0x18e/0x340
>   __mutex_lock+0x277/0xd20
>   mutex_lock_nested+0x31/0x40
>   memcg_create_kmem_cache+0x2e/0x190
>   memcg_kmem_cache_create_func+0x40/0x80
>   process_one_work+0x54c/0xbe0
>   worker_thread+0x80/0x650
>   kthread+0x1e0/0x200
>   ret_from_fork+0x27/0x50

That's useless gibberish, at the very least run it through some decode
so we get line numbers.

> which points to those lines in osq_wait_next(),
> 
>   next = xchg(&node->next, NULL);
>   if (next)
> 	break;
> 
> Since only the read is outside of critical sections, fixed it by adding
> a READ_ONCE().

What?!?! Did you actually read what you wrote?

Also, you have to stop calling things fixes unless you can prove (and
explain) there is an actual problem.

> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/locking/osq_lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 6ef600aa0f47..8f565165019a 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -77,7 +77,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>  		 */
>  		if (node->next) {
>  			next = xchg(&node->next, NULL);
> -			if (next)
> +			if (READ_ONCE(next))
>  				break;
>  		}
>  

This seems to suggest you ought to maybe brush up on your C skills.
