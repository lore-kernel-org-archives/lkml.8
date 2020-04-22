Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F3BC55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAA520722
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h7vJD4St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDVB6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgDVB6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9ECC0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 18:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nKXhfQ18jg2hKM6qUmLs8kGmEHZGZNmBazd9QGXMFKQ=; b=h7vJD4Sto6MC0Aie/5nOFEwNsk
        TbgAkvk2BBeranKfQyT0XthqxLRk1w+odxdf+L+zKSsP2jV3mXbc5LlkVcSSsSGMhtOrtdK8HOc0A
        BYwuIlTdnxZOZxqpnh9KBot7aVPSeEc5DZxHkuQeGUgaZkDau7ml1CbqWNeJ6+J+cWrZQ6OAneRvR
        HrCjUElgKMAsjIqR0p061fA3MdFRJTNDroRwouKrEWDsUQpdpZDqarx4joLDDLYvNRSL3Xsc6OkAs
        Xm0FQ7ShfZbTXApbR1qkLD1wkmfQnB6l9E5klZFggz6oi8N8emjQMQCFfNRGCsdGS3hqzGKw1sGR1
        IThIfUbQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR4ej-0006uT-EY; Wed, 22 Apr 2020 01:58:29 +0000
Date:   Tue, 21 Apr 2020 18:58:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200422015829.GR5820@bombadil.infradead.org>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422001422.232330-11-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:14:22PM -0700, Michel Lespinasse wrote:
> Rename the mmap_sem field to mmap_lock. Any new uses of this lock

Shouldn't some of these be folded into the previous patch?

(Quoted below are the ones I think should be mmap_assert_locked())

This does illustrate that we also need an mmap_assert_write_locked(),
and lockdep_assert_held_write() doesn't have a non-lockdep counterpart.
We can at least assert that it's not _unlocked_, even if we can't assert
that it's definitely _write_ locked.

> +++ b/arch/x86/events/core.c
> @@ -2179,10 +2179,10 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>  	 * userspace with CR4.PCE clear while another task is still
>  	 * doing on_each_cpu_mask() to propagate CR4.PCE.
>  	 *
> -	 * For now, this can't happen because all callers hold mmap_sem
> +	 * For now, this can't happen because all callers hold mmap_lock
>  	 * for write.  If this changes, we'll need a different solution.
>  	 */
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>  
>  	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
>  		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 280585833adf..8660aec6aafa 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -581,7 +581,7 @@ long hmm_range_fault(struct hmm_range *range)
>  	struct mm_struct *mm = range->notifier->mm;
>  	int ret;
>  
> -	lockdep_assert_held(&mm->mmap_sem);
> +	lockdep_assert_held(&mm->mmap_lock);
>  
>  	do {
>  		/* If range is no longer valid force retry. */
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index cfd0a03bf5cc..6717278d6d49 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -609,7 +609,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>  	struct mmu_notifier_subscriptions *subscriptions = NULL;
>  	int ret;
>  
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>  	BUG_ON(atomic_read(&mm->mm_users) <= 0);
>  
>  	if (IS_ENABLED(CONFIG_LOCKDEP)) {
> @@ -761,7 +761,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
>  	struct mmu_notifier *subscription;
>  	int ret;
>  
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>  
>  	if (mm->notifier_subscriptions) {
>  		subscription = find_get_mmu_notifier(mm, ops);
> @@ -1006,7 +1006,7 @@ int mmu_interval_notifier_insert_locked(
>  		mm->notifier_subscriptions;
>  	int ret;
>  
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>  
>  	if (!subscriptions || !subscriptions->has_itree) {
>  		ret = __mmu_notifier_register(NULL, mm);
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 928df1638c30..d669a3146c0f 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -395,7 +396,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>  	if (!walk.mm)
>  		return -EINVAL;
>  
> -	lockdep_assert_held(&walk.mm->mmap_sem);
> +	lockdep_assert_held(&walk.mm->mmap_lock);
>  
>  	vma = find_vma(walk.mm, start);
>  	do {
> @@ -453,7 +454,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
>  	if (start >= end || !walk.mm)
>  		return -EINVAL;
>  
> -	lockdep_assert_held(&walk.mm->mmap_sem);
> +	lockdep_assert_held(&walk.mm->mmap_lock);
>  
>  	return __walk_page_range(start, end, &walk);
>  }
> @@ -472,7 +473,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>  	if (!walk.mm)
>  		return -EINVAL;
>  
> -	lockdep_assert_held(&walk.mm->mmap_sem);
> +	lockdep_assert_held(&walk.mm->mmap_lock);
>  
>  	err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
>  	if (err > 0)
> diff --git a/mm/util.c b/mm/util.c
> index ea2e15b21446..56c562f7ad19 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -437,7 +437,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>  	unsigned long locked_vm, limit;
>  	int ret = 0;
>  
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>  
>  	locked_vm = mm->locked_vm;
>  	if (inc) {
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
