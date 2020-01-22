Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EFAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A2D24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579712385;
	bh=axCIRA2Fp40xz/PdCBrqisOsaXQORO761mDIdm/EdF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kvj5Ftcr4DVWYaaffl7649VePrwj3tW7xDqNouDhq3nbsR4oPip2bVyq2cZ2Wsf6W
	 DZHEPL6JbsKox1Iao0AXsf4xujeAxyRb7In9b8Of2SoXjTpoKrjyVfdtIAHrCXfZBU
	 Lxqo54drjUq/pNN6dpMmzU4bGj7iDtSFTnlBcoqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAVQ7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgAVQ7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:59:44 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12FE21569;
        Wed, 22 Jan 2020 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579712383;
        bh=axCIRA2Fp40xz/PdCBrqisOsaXQORO761mDIdm/EdF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCzGgx/3vnrSJJuVUl7qDvT6q3vrPzmFP2jhpCD5p16G6vIJ0G1RmelNZl8L+ChQq
         YvNxtFTXPdfCfTyvyDIze5uxkYkOyVaBo4tu0bKT1bgCQqxJrYm29QJ8YhQvXTt0Di
         14RsZw9x+SkRtVfLQ1Bfmwe18/9oZKd5Dj9LB1go=
Date:   Wed, 22 Jan 2020 16:59:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, peterz@infradead.org, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200122165938.GA16974@willie-the-truck>
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
> 
> which points to those lines in osq_wait_next(),
> 
>   next = xchg(&node->next, NULL);
>   if (next)
> 	break;
> 
> Since only the read is outside of critical sections, fixed it by adding
> a READ_ONCE().
> 
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

I don't understand this; 'next' is a local variable.

Not keen on the onslaught of random "add a READ_ONCE() to shut the
sanitiser up" patches we're going to get from kcsan :(

Will
