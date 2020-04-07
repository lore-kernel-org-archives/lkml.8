Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E69C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A5A20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586267940;
	bh=zgIl4KNNN6OWsbD0xSxLoKEN7YLQTkq95W9kbwneqdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=otWFAO97hSusTPAm/A5B0wsqqrJ0Vtj+x7NPOSIXuQDrv8yLrY/Y9t1fY9PDiDvNV
	 7FCDWrvvcyz7uvenrGFRt8zkZSkK6KJ0wQ1dXTuCqCUZYLZV0KGZZJsAcL0K9vM8ew
	 8jCa4+RDYBUZLazMJa7DhjkyjQQcFXepLPfEzf5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgDGN67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:58:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43039 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgDGN67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:58:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id w15so3993755wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 06:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7oMqieg8pNA5U1Gqo/zdJwJNHWJR141xdDvdPejtqTI=;
        b=b4su2Sw+PKa3q4vSvSRGFjpf72kXH1D3IlZmGQIL6U9jMNvviqxohwJiPO8ZDji01u
         WLjgCGk/fSXkNWEnzPNwjS77xx73vHj3OwtHpbR0+izLOAf7E+sDzPaT9+RgVpXrFjT/
         Ut7WHOMNAdIsfCT1+oUliZmJNhx3d5xDslX0/Wj8mbHtDDrUc8HfHDl5uIpTN+k3B01G
         E3+7zt6YxMauV+S088j/RHwAnLFaGVf4IMhkrFPjXX7Nfn28RVjWMBCe0N7OKE2Kb28e
         tb6X+k99hlzYHIB8cl5qtETibgdQTQ9M8EOWDyMkBkCc+t3tAT9RNgAio7cHAgVNRo3t
         tHvw==
X-Gm-Message-State: AGi0Pub5qyQCtDIscGQDivE8JoV86g8fmeF1BtOi7E+MLvp6gFswOl30
        1Tr/kPsRgRYmrqkqXexeNi8=
X-Google-Smtp-Source: APiQypIdi/9iwz570aPHnT8xTis1j6JkFOGqdxShbVn1+GBG3wNO5p8MwoE4Mp2kP0hFvEiBaR1e7w==
X-Received: by 2002:adf:bbc5:: with SMTP id z5mr2992228wrg.168.1586267935643;
        Tue, 07 Apr 2020 06:58:55 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id v186sm2357359wme.24.2020.04.07.06.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 06:58:54 -0700 (PDT)
Date:   Tue, 7 Apr 2020 15:58:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] powerpc/pseries/hotplug-memory: stop checking
 is_mem_section_removable()
Message-ID: <20200407135853.GQ18914@dhcp22.suse.cz>
References: <20200407135416.24093-1-david@redhat.com>
 <20200407135416.24093-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407135416.24093-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-04-20 15:54:15, David Hildenbrand wrote:
> In commit 53cdc1cb29e8 ("drivers/base/memory.c: indicate all memory
> blocks as removable"), the user space interface to compute whether a memory
> block can be offlined (exposed via
> /sys/devices/system/memory/memoryX/removable) has effectively been
> deprecated. We want to remove the leftovers of the kernel implementation.
> 
> When offlining a memory block (mm/memory_hotplug.c:__offline_pages()),
> we'll start by:
> 1. Testing if it contains any holes, and reject if so
> 2. Testing if pages belong to different zones, and reject if so
> 3. Isolating the page range, checking if it contains any unmovable pages
> 
> Using is_mem_section_removable() before trying to offline is not only racy,
> it can easily result in false positives/negatives. Let's stop manually
> checking is_mem_section_removable(), and let device_offline() handle it
> completely instead. We can remove the racy is_mem_section_removable()
> implementation next.
> 
> We now take more locks (e.g., memory hotplug lock when offlining and the
> zone lock when isolating), but maybe we should optimize that
> implementation instead if this ever becomes a real problem (after all,
> memory unplug is already an expensive operation). We started using
> is_mem_section_removable() in commit 51925fb3c5c9 ("powerpc/pseries:
> Implement memory hotplug remove in the kernel"), with the initial
> hotremove support of lmbs.

I am not familiar with this code but it makes sense to make it sync with
the global behavior.

> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  .../platforms/pseries/hotplug-memory.c        | 26 +++----------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index b2cde1732301..5ace2f9a277e 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -337,39 +337,19 @@ static int pseries_remove_mem_node(struct device_node *np)
>  
>  static bool lmb_is_removable(struct drmem_lmb *lmb)
>  {
> -	int i, scns_per_block;
> -	bool rc = true;
> -	unsigned long pfn, block_sz;
> -	u64 phys_addr;
> -
>  	if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
>  		return false;
>  
> -	block_sz = memory_block_size_bytes();
> -	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
> -	phys_addr = lmb->base_addr;
> -
>  #ifdef CONFIG_FA_DUMP
>  	/*
>  	 * Don't hot-remove memory that falls in fadump boot memory area
>  	 * and memory that is reserved for capturing old kernel memory.
>  	 */
> -	if (is_fadump_memory_area(phys_addr, block_sz))
> +	if (is_fadump_memory_area(lmb->base_addr, memory_block_size_bytes()))
>  		return false;
>  #endif
> -
> -	for (i = 0; i < scns_per_block; i++) {
> -		pfn = PFN_DOWN(phys_addr);
> -		if (!pfn_in_present_section(pfn)) {
> -			phys_addr += MIN_MEMORY_BLOCK_SIZE;
> -			continue;
> -		}
> -
> -		rc = rc && is_mem_section_removable(pfn, PAGES_PER_SECTION);
> -		phys_addr += MIN_MEMORY_BLOCK_SIZE;
> -	}
> -
> -	return rc;
> +	/* device_offline() will determine if we can actually remove this lmb */
> +	return true;
>  }
>  
>  static int dlpar_add_lmb(struct drmem_lmb *);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
