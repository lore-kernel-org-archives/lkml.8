Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769C9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583102145D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PL6zETkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgE1DrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgE1DrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:47:00 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C2C08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 20:47:00 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a137so236571oii.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 20:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2qx91aVPuFO0vUiP0/I7F3TMnsxZODsCo0wW/nZA/Ek=;
        b=PL6zETkbGU9mqzrGsocE1HBzwqKl3IMV7yV8wFZbGm4wHOwRBD8OMMG+y5JKGvCgPi
         vm5n3+sf1eGzsQmqX4L8++JRmCX3DzLApuWLh2lFuHx1IPNt0zVceXBi8JMZm08yMjJi
         dgTLtqCBs6olHY2rqJsuK9NL5GyMjlA9kP/Cz6nR6Si2xwGFFoE603kc/Dr53G3rQp6S
         gFBb+PddTEBGiaWOuBvRGs40Im9zVq8VTNmoIb/MzDf19j1pLiqnHKik2BuMsIkBrRbh
         TYnm6OVvmQUcyWzw/IOjcAS7zNs0Q98eBrYT94efLyjDduG9AxjlXGJtnrsATHUpOImZ
         HIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2qx91aVPuFO0vUiP0/I7F3TMnsxZODsCo0wW/nZA/Ek=;
        b=pXDhAE/llim+ESsa+2sIG3PkdQ9Zz9B2lepsZMFI1/GlHkVnFBfNFj+tyPVmfdpJ7s
         zQw8ueqqV54FyBD5dCWTxSKg2ktK4gV1LoMTH+Q1m+joPpx5kyLmjE2/J/Q3eS0cYb6Q
         9050qAZssRHN0DgMJquiEeWRWr6mx8Q68LGiA3X95L0s5el4+H+LXeXp/lZZRM8MdGUl
         zhyzguU7nUFsBzcJQBzqRY+yGF6u9zAw/xpTt0lGc4cIui09WyP53fDp2wAJQ+E/a8Nx
         wMCfxRPENTNdHF9D+nNr1vRgo6tBFHCtPrgnvNO74m2AS1eQy/RmNPS9bqYTRxOeW7Qw
         EncQ==
X-Gm-Message-State: AOAM530VISMGCxLQ27pWfitmiZ+Yb1JQWtmKj9Otd0APbMSIUqLsAV5w
        V2aIEjpYrijxHF8hUI0+VFDEmQ==
X-Google-Smtp-Source: ABdhPJyOlEQNd0DWG0KMQ3iclWevL0B8TV/DHISOzSWHCezO7ksCSIPPniMHO6dFdL8N85bmZfl1CA==
X-Received: by 2002:aca:d856:: with SMTP id p83mr958723oig.38.1590637619384;
        Wed, 27 May 2020 20:46:59 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v10sm1036334oov.15.2020.05.27.20.46.55
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 27 May 2020 20:46:58 -0700 (PDT)
Date:   Wed, 27 May 2020 20:46:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jerome Glisse <jglisse@redhat.com>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Steven Capper <steve.capper@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rabin Vincent <rabinv@axis.com>,
        linux-arm-kernel@lists.infradead.org, rmk+kernel@arm.linux.org.uk,
        Guo Ren <guoren@kernel.org>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>,
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
        Chris Zankel <chris@zankel.net>
Subject: Re: Cache flush issue with page_mapping_file() and swap back shmem
 page ?
In-Reply-To: <20200528002033.GB1992500@redhat.com>
Message-ID: <alpine.LSU.2.11.2005272021220.3857@eggly.anvils>
References: <20200528002033.GB1992500@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Wed, 27 May 2020, Jerome Glisse wrote:
> So any arch code which uses page_mapping_file() might get the wrong
> answer, this function will return NULL for a swap backed page which
> can be a shmem pages. But shmem pages can still be shared among
> multiple process (and possibly at different virtual addresses if
> mremap was use).
> 
> Attached is a patch that changes page_mapping_file() to return the
> shmem mapping for swap backed shmem page. I have not tested it (no
> way for me to test all those architecture) and i spotted this while
> working on something else. So i hope someone can take a closer look.

I'm certainly no expert on flush_dcache_page() and friends, but I'd
be very surprised if such a problem exists, yet has gone unnoticed
for so long.  page_mapping_file() itself is fairly new, added when
a risk of crashing on a race with swapoff came in: but the previous
use of page_mapping() would have suffered equally if there were such
a cache flushinhg problem here.

And I'm afraid your patch won't do anything to help if there is a
problem: very soon after shmem calls add_to_swap_cache(), it calls
shmem_delete_from_page_cache(), which sets page->mapping to NULL.

But I can assure you that a shmem page (unlike an anon page) is never
put into swap cache while it is mapped into userspace, and never
mapped into userspace while it is still in swap cache: does that help?

Hugh

> This might be a shmem page that is in a sense a file that
> can be mapped multiple times in different processes at
> possibly different virtual addresses (fork + mremap). So
> return the shmem mapping that will allow any arch code to
> find all mappings of the page.
> 
> Note that even if page is not anonymous then the page might
> have a NULL page->mapping field if it is being truncated,
> but then it is fine as each pte poiting to the page will be
> remove and cache flushing should be handled properly by that
> part of the code.
> 
> Signed-off-by: Jerome Glisse <jglisse@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> ---
>  mm/util.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 988d11e6c17c..ec8739ab0cc3 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -685,8 +685,24 @@ EXPORT_SYMBOL(page_mapping);
>   */
>  struct address_space *page_mapping_file(struct page *page)
>  {
> -	if (unlikely(PageSwapCache(page)))
> +	if (unlikely(PageSwapCache(page))) {
> +		/*
> +		 * This might be a shmem page that is in a sense a file that
> +		 * can be mapped multiple times in different processes at
> +		 * possibly different virtual addresses (fork + mremap). So
> +		 * return the shmem mapping that will allow any arch code to
> +		 * find all mappings of the page.
> +		 *
> +		 * Note that even if page is not anonymous then the page might
> +		 * have a NULL page->mapping field if it is being truncated,
> +		 * but then it is fine as each pte poiting to the page will be
> +		 * remove and cache flushing should be handled properly by that
> +		 * part of the code.
> +		 */
> +		if (!PageAnon(page))
> +			return page->mapping;
>  		return NULL;
> +	}
>  	return page_mapping(page);
>  }
>  
> -- 
> 2.26.2
