Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720A820899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590555147;
	bh=g9E/3oh8BLmGA2vnSGwK3RlCX7bKSJ1TEs8S9N8IiPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WTa1sK2f8CLlnfE+72Aeb1FyA0/9VWB9u2ZJN7sEQcEy3Q+5K88Htc2TpB/3s/kE2
	 wXVSudty0wYUkmGncszG5AZ6H7GjyioE1ThRb96TClXK6PRjU03Pcg6f+hLKgmuSf4
	 S+A+ZWN6U8ZwzeXEoqMXO0WRUeuJbt90go8wKl9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgE0Ew1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 00:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgE0Ew0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 00:52:26 -0400
Received: from kernel.org (unknown [87.70.212.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3783A2078C;
        Wed, 27 May 2020 04:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590555146;
        bh=g9E/3oh8BLmGA2vnSGwK3RlCX7bKSJ1TEs8S9N8IiPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrjBrjdDUZNJQSzIIYIANzlV2wU2224Px8XobZtZWK7nzfw5rmSjOK75Hp0cov2Xv
         891nlgAP9Hr7ZijdAqskear/wAwO/8WBhCvfyRSOKLevoXTZ92zrHwsHaOevxHFimY
         ZTtGUOIgZeDsk5wW/cW9smubJ2jdMZYOhRv495ZE=
Date:   Wed, 27 May 2020 07:52:19 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] sparc32: register memory occupied by kernel as
 memblock.memory
Message-ID: <20200527045219.GG48741@kernel.org>
References: <20200524165358.27188-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524165358.27188-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, David,

Any comments on this?

On Sun, May 24, 2020 at 07:53:58PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> sparc32 never registered the memory occupied by the kernel image with
> memblock_add() and it only reserved this memory with meblock_reserve().
> 
> With openbios as system firmware, the memory occupied by the kernel is
> reserved in openbios and removed from mem.available. The prom setup code in
> the kernel uses mem.available to set up the memory banks and essentially
> there is a hole for the memory occupied by the kernel image.
> 
> Later in bootmem_init() this memory is memblock_reserve()d.
> 
> Up until recently, memmap initialization would call __init_single_page()
> for the pages in that hole, the free_low_memory_core_early() would mark
> them as reserved and everything would be Ok.
> 
> After the change in memmap initialization introduced by the commit "mm:
> memmap_init: iterate over memblock regions rather that check each PFN", the
> hole is skipped and the page structs for it are not initialized. And when
> they are passed from memblock to page allocator as reserved, the latter
> gets confused.
> 
> Simply registering the memory occupied by the kernel with memblock_add()
> resolves this issue.
> 
> Tested on qemu-system-sparc with Debian Etch [1] userspace.
> 
> [1] https://people.debian.org/~aurel32/qemu/sparc/debian_etch_sparc_small.qcow2
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Link: https://lkml.kernel.org/r/20200517000050.GA87467@roeck-us.nlllllet/ 
> ---
> 
> David,
> 
> I'd really appreciate your Ack or an explanation where my analysis is wrong :)
> 
>  arch/sparc/mm/init_32.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index e45160839f79..eb2946b1df8a 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -192,6 +192,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
>  	/* Reserve the kernel text/data/bss. */
>  	size = (start_pfn << PAGE_SHIFT) - phys_base;
>  	memblock_reserve(phys_base, size);
> +	memblock_add(phys_base, size);
>  
>  	size = memblock_phys_mem_size() - memblock_reserved_size();
>  	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
