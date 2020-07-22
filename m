Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBA9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08E72084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hkW41v1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgGVSE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgGVSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:04:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236ADC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CMMHY0mGrSS0LIPSa86C/P5gTx9E8xNlElv3H254r/Y=; b=hkW41v1dZGPXp3JpYDiAnmZM7x
        ZjLtYMCIG9CeT6hkLnYFS7YBZt/vgnic8P9UVkqooMc8IuSeSFTEowFUIxWWgNuF4wgUSq+dzh+j4
        SngfppWE6/AolYAeyZz1F9L3dUfG8RXgY3+8eA143q+IY32ex5yKNMJ+rpxorDqWHEbs1OtL+m+69
        IGxAeOfxxvpg/iAoEFbF0eUkG0l0W1siBSDRporQIY8hNbR7Mhn8VPaH2ySK+hTHkPyYONgOVcLjn
        it4zZLfXECP6ZzYftwlMS9oJsKEyXx3VRenvKKxiG4ddyM5K6x1D5qj1+w1J7ieSyN3cb+hbwGsO6
        s8TXNMXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyJ6P-0008RR-S5; Wed, 22 Jul 2020 18:04:25 +0000
Date:   Wed, 22 Jul 2020 19:04:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: do not wait for lock_page() in
 unuse_pte_range()
Message-ID: <20200722180425.GP15516@casper.infradead.org>
References: <20200722174436.GB841369@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722174436.GB841369@xps-13>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 07:44:36PM +0200, Andrea Righi wrote:
> Waiting for lock_page() with mm->mmap_sem held in unuse_pte_range() can
> lead to stalls while running swapoff (i.e., not being able to ssh into
> the system, inability to execute simple commands like 'ps', etc.).
> 
> Replace lock_page() with trylock_page() and release mm->mmap_sem if we
> fail to lock it, giving other tasks a chance to continue and prevent
> the stall.

I think you've removed the warning at the expense of turning a stall
into a potential livelock.

> @@ -1977,7 +1977,11 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  			return -ENOMEM;
>  		}
>  
> -		lock_page(page);
> +		if (!trylock_page(page)) {
> +			ret = -EAGAIN;
> +			put_page(page);
> +			goto out;
> +		}

If you look at the patterns we have elsewhere in the MM for doing
this kind of thing (eg truncate_inode_pages_range()), we iterate over the
entire range, take care of the easy cases, then go back and deal with the
hard cases later.

So that would argue for skipping any page that we can't trylock, but
continue over at least the VMA, and quite possibly the entire MM until
we're convinced that we have unused all of the required pages.

Another thing we could do is drop the MM semaphore _here_, sleep on this
page until it's unlocked, then go around again.

		if (!trylock_page(page)) {
			mmap_read_unlock(mm);
			lock_page(page);
			unlock_page(page);
			put_page(page);
			ret = -EAGAIN;
			goto out;
		}

(I haven't checked the call paths; maybe you can't do this because
sometimes it's called with the mmap sem held for write)

Also, if we're trying to scale this better, there are some fun
workloads where readers block writers who block subsequent readers
and we shouldn't wait for I/O in swapin_readahead().  See patches like
6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11 for more on this kind of thing.
