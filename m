Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631EDC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A29A206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y6eQIehs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbgDANqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:46:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57622 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDANqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bTIg9/frqj0tTmLnxet1vx3Kwof9z52T8v82iLta588=; b=y6eQIehsd2lZKBw1GndVjHgXhl
        vWkm5POiPtUDt57kOlC7uLCeVBM6X1K7RdasXLf2u8Njydm09956qElYR5pDt15OJtr+bZs5y74tO
        XApkXUNA98fOOyXuKaDa+sAZ+kZYdKTafno0qXG2AHWhEETysieDAZpfYo2PigDDCcV6d3ZPAZlkK
        fcsDaG/9FI8an+McCvzI/hfHmtPr1IGBN6kpiFwgfQygtv/uS69LKENzXhyGEC5RSGDNFcpFqqT4C
        7KRhSsAHCG6qFH5yQ+IeC0ObsAwoSf0HWQQ9HFcGskVEqKjd8z7EdqBgynfsz1Gk2BvGtTB5e9aGi
        LTgdf+cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJdhU-0005xz-CH; Wed, 01 Apr 2020 13:46:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AF6930610E;
        Wed,  1 Apr 2020 15:46:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0456F29D86172; Wed,  1 Apr 2020 15:46:33 +0200 (CEST)
Date:   Wed, 1 Apr 2020 15:46:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 07/10] mmap locking API: add mmap_read_release() and
 mmap_read_unlock_non_owner()
Message-ID: <20200401134633.GS20696@hirez.programming.kicks-ass.net>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-8-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327225102.25061-8-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:50:59PM -0700, Michel Lespinasse wrote:
> Add a couple APIs to allow splitting mmap_read_unlock() into two calls:
> - mmap_read_release(), called by the task that had taken the mmap lock;
> - mmap_read_unlock_non_owner(), called from a work queue.
> 
> These apis are used by kernel/bpf/stackmap.c only.

That code is an absolute abomination and should never have gotten
merged.

That said; I would prefer a mmap_read_trylock_nonowner() over
mmap_read_release() existing.

> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>  include/linux/mmap_lock.h | 10 ++++++++++
>  kernel/bpf/stackmap.c     |  9 ++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 36fb758401d6..a80cf9695514 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -62,4 +62,14 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
>  	up_read(&mm->mmap_sem);
>  }
>  
> +static inline void mmap_read_release(struct mm_struct *mm, unsigned long ip)
> +{
> +	rwsem_release(&mm->mmap_sem.dep_map, ip);
> +}
> +
> +static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
> +{
> +	up_read_non_owner(&mm->mmap_sem);
> +}
> +
>  #endif /* _LINUX_MMAP_LOCK_H */
