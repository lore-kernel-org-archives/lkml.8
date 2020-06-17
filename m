Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26268C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009A521548
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592434047;
	bh=GuBEAyJbQnr0mMqGZwEJ3Eq1JvZWz9/H6Cpc9CBqpHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rYlewUMi4VZp6+CGg9oeRAHwlAiGsIAuPy5yCRWCWJ/iDiHJUfBG0M5UAZS9CJG0g
	 nuxThTHrSeTDCyPkdUpjbyIELomRKlRvqB3QFBbWLikEsGYufv7ky/ZBme1rFOBrxF
	 Mex9Srtjd9p6H0bJsVA1+ABO/5bO4xlo+7VCug7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFQWrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgFQWrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:47:25 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEDC20885;
        Wed, 17 Jun 2020 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592434045;
        bh=GuBEAyJbQnr0mMqGZwEJ3Eq1JvZWz9/H6Cpc9CBqpHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uBYpo0VwLtxQfYmjHGoGYG2143Bfa2P5b85h+4Imij6SLLKLbvYZq8D4i19w1MrzO
         KrB/sLTItAv1rlR3p6wPbfLXV9OE9cHqoXEZLe2oO6zMbTQSpmcLjx06LMisahZ+Y/
         /ZckaT/mIMGnPq4pQ1QubH4uU5+3Wekfrz+6a4w0=
Date:   Wed, 17 Jun 2020 15:47:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kaiyu Zhang <zhangalex@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory.c: make remap_pfn_range() reject unaligned
 addr
Message-Id: <20200617154724.1b4d8a0353c7b8d0d7c79c0b@linux-foundation.org>
In-Reply-To: <20200617223414.165923-1-zhangalex@google.com>
References: <20200617223414.165923-1-zhangalex@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 15:34:14 -0700 Kaiyu Zhang <zhangalex@google.com> wrote:

> From: Alex Zhang <zhangalex@google.com>
> 
> This function implicitly assumes that the addr passed in is page aligned.
> A non page aligned addr could ultimately cause a kernel bug in
> remap_pte_range as the exit condition in the logic loop may never be
> satisfied.  This patch documents the need for the requirement, as
> well as explicitly adding a check for it.
> 
> ...
>
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2081,7 +2081,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
>  /**
>   * remap_pfn_range - remap kernel memory to userspace
>   * @vma: user vma to map to
> - * @addr: target user address to start at
> + * @addr: target page aligned user address to start at
>   * @pfn: page frame number of kernel physical memory address
>   * @size: size of mapping area
>   * @prot: page protection flags for this mapping
> @@ -2100,6 +2100,9 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
>  	unsigned long remap_pfn = pfn;
>  	int err;
>  
> +	if (!PAGE_ALIGN(addr))
> +		return -EINVAL;
> +

That won't work.  PAGE_ALIGNED() will do so.

Also, as this is an error in the calling code it would be better to do

	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
		return -EINVAL;

so that the offending code can be fixed up.

Is there any code in the kernel tree which actually has this error?
