Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67128C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3808220720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593071852;
	bh=9LdC9d2z4TGRCwdLXGnT6rrq5EKgfc/RxD8p3Phnotw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xduBKuR47fbEfJo9Z6HmziG1SL9g5fW/z9HUGH6NfdVD3SWMH7WYIsxF2cdlBg5qv
	 jSS2mewXcWjXUoANi3Kn1OszBB0yFCXLAlTEpkeu9zJ2Cekoc2PCwqjwhY1FKdFSzT
	 3kEMVj8oo2TH60S/4fjLVzV/0+iw2GQ5R+3MnqTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390396AbgFYH5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:57:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36541 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390224AbgFYH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:57:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id 17so4927590wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=76jtp+TwB1a1n9n3LirBRf2c/ErzhfeJSIfA3xs53ow=;
        b=a5RNun6tU7Hq9TKrbj2pu8rEbiS0u2yna38SQrLqzxeFV0Gce+kZspRxy76rr08F6g
         hz7LCFgPx1hD5UVywat2e5Vio8NcNTb/ygqmcXeID3J3OoD2cJWbrGJcx/eARwHoIJao
         NAHWvmmT6dzZ+lYkVTMlMqUL6npYorf7HvbQY5l6sH6HkcvEX6J4MUc012WpAzUJhMCf
         hNoeAbJC63E6ZrncmEZbV29ncFGI7ZYn9zPPfw3dkcR7cx63PUE34P6cj/XRpM0usDlB
         2aI63E+h8LK9tmZS5JEbtt5N7Avk1mBNX1HWVHQbpPR3r1N9LSqi7N3+fKkpfI1Zs1Qq
         Jlgw==
X-Gm-Message-State: AOAM532pbEbYVV59CYMX3vGv9KYChS2z98If7QVkVmtfofXXAp2ZGhqH
        3gTJ+pakJnuzYxYQQhOqJRM=
X-Google-Smtp-Source: ABdhPJyVo3sL23V3dy9eVB9kTVhLyIFLY0vrnH4sSiseICByNWKLZD2sZsGnuyHw9krpXFUV9RdZSQ==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr1973927wmi.49.1593071847972;
        Thu, 25 Jun 2020 00:57:27 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id n16sm24012639wrq.39.2020.06.25.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 00:57:27 -0700 (PDT)
Date:   Thu, 25 Jun 2020 09:57:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Message-ID: <20200625075725.GC1320@dhcp22.suse.cz>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624191417.16735-1-chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-06-20 20:14:17, Chris Wilson wrote:
> A general rule of thumb is that shrinkers should be fast and effective.
> They are called from direct reclaim at the most incovenient of times when
> the caller is waiting for a page. If we attempt to reclaim a page being
> pinned for active dma [pin_user_pages()], we will incur far greater
> latency than a normal anonymous page mapped multiple times. Worse the
> page may be in use indefinitely by the HW and unable to be reclaimed
> in a timely manner.
> 
> A side effect of the LRU shrinker not being dma aware is that we will
> often attempt to perform direct reclaim on the persistent group of dma
> pages while continuing to use the dma HW (an issue as the HW may already
> be actively waiting for the next user request), and even attempt to
> reclaim a partially allocated dma object in order to satisfy pinning
> the next user page for that object.

You are talking about direct reclaim but this path is shared with the
background reclaim. This is a bit confusing. Maybe you just want to
outline the latency in the reclaim which is more noticeable in the
direct reclaim to the userspace. This would be good to be clarified.

How much memory are we talking about here btw?

> It is to be expected that such pages are made available for reclaim at
> the end of the dma operation [unpin_user_pages()], and for truly
> longterm pins to be proactively recovered via device specific shrinkers
> [i.e. stop the HW, allow the pages to be returned to the system, and
> then compete again for the memory].

Is the later implemented?

Btw. overall intention of the patch is not really clear to me. Do I get
it right that this is going to reduce latency of the reclaim for pages
that are not reclaimable anyway because they are pinned? If yes do we
have any numbers for that.

It would be also good to explain why the bail out is implemented in
try_to_unmap rather than shrink_shrink_page_list.

> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> ---
> This seems perhaps a little devious and overzealous. Is there a more
> appropriate TTU flag? Would there be a way to limit its effect to say
> FOLL_LONGTERM? Doing the migration first would seem to be sensible if
> we disable opportunistic migration for the duration of the pin.
> ---
>  mm/rmap.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5fe2dedce1fc..374c6e65551b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1393,6 +1393,22 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  	    is_zone_device_page(page) && !is_device_private_page(page))
>  		return true;
>  
> +	/*
> +	 * Try and fail early to revoke a costly DMA pinned page.
> +	 *
> +	 * Reclaiming an active DMA page requires stopping the hardware
> +	 * and flushing access. [Hardware that does support pagefaulting,
> +	 * and so can quickly revoke DMA pages at any time, does not need
> +	 * to pin the DMA page.] At worst, the page may be indefinitely in
> +	 * use by the hardware. Even at best it will take far longer to
> +	 * revoke the access via the mmu notifier, forcing that latency
> +	 * onto our callers rather than the consumer of the HW. As we are
> +	 * called during opportunistic direct reclaim, declare the
> +	 * opportunity cost too high and ignore the page.
> +	 */
> +	if (page_maybe_dma_pinned(page))
> +		return true;

I do not understand why the page table walk needs to be done. The page
is going to be pinned no matter how many page tables are mapping it
right?

> +
>  	if (flags & TTU_SPLIT_HUGE_PMD) {
>  		split_huge_pmd_address(vma, address,
>  				flags & TTU_SPLIT_FREEZE, page);
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
