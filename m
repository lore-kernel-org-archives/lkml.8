Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B90CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDF92081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgERKcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:32:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:54562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgERKcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:32:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66A57AA4F;
        Mon, 18 May 2020 10:32:07 +0000 (UTC)
Subject: Re: [PATCH v5 06/10] mmap locking API: convert nested write lock
 sites
To:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-7-walken@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6a23fcce-181b-01ad-4a83-ea24d07ac724@suse.cz>
Date:   Mon, 18 May 2020 12:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-7-walken@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 2:14 AM, Michel Lespinasse wrote:
> Add API for nested write locks and convert the few call sites doing that.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Perhaps we could even move SINGLE_DEPTH_NESTING into the wrapper? It's unlikely
there will be a new user with a different subclass?

> ---
>  arch/um/include/asm/mmu_context.h | 3 ++-
>  include/linux/mmap_lock.h         | 5 +++++
>  kernel/fork.c                     | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
> index 62262c5c7785..17ddd4edf875 100644
> --- a/arch/um/include/asm/mmu_context.h
> +++ b/arch/um/include/asm/mmu_context.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/mm_types.h>
> +#include <linux/mmap_lock.h>
>  
>  #include <asm/mmu.h>
>  
> @@ -47,7 +48,7 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
>  	 * when the new ->mm is used for the first time.
>  	 */
>  	__switch_mm(&new->context.id);
> -	down_write_nested(&new->mmap_sem, 1);
> +	mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
>  	uml_setup_stubs(new);
>  	mmap_write_unlock(new);
>  }
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 97ac53b66052..a757cb30ae77 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -11,6 +11,11 @@ static inline void mmap_write_lock(struct mm_struct *mm)
>  	down_write(&mm->mmap_sem);
>  }
>  
> +static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
> +{
> +	down_write_nested(&mm->mmap_sem, subclass);
> +}
> +
>  static inline int mmap_write_lock_killable(struct mm_struct *mm)
>  {
>  	return down_write_killable(&mm->mmap_sem);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 41d3f45c058e..a5d1d20ccba7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -499,7 +499,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	/*
>  	 * Not linked in yet - no deadlock potential:
>  	 */
> -	down_write_nested(&mm->mmap_sem, SINGLE_DEPTH_NESTING);
> +	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
>  
>  	/* No ordering required: file already has been exposed. */
>  	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
> 

