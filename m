Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D173C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C148920748
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4+cAEb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDHCqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:46:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32396 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbgDHCqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586314002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t7WtQTqpQRwbXCbBXBwtx+Gjb6wbq7lij7qXduh5wW4=;
        b=c4+cAEb/eRAIpHwG5pMZFXkUjZ8JQRaqBSKtPTYY28pBhl83HV3ctQJrJfG/hAdAs3qWsf
        a3R5oKpL5ZnSm8YvOarl8PXgy/ypLP6TY5eiF6w37RAmODbkWZp5K+Os1BuqBn705b1TpD
        mwGfGbHm3SpKzy1bSPCK32Az5MjEDc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-8QLOYcr_Mtmnyo-dByffww-1; Tue, 07 Apr 2020 22:46:39 -0400
X-MC-Unique: 8QLOYcr_Mtmnyo-dByffww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BF628017F3;
        Wed,  8 Apr 2020 02:46:37 +0000 (UTC)
Received: from localhost (ovpn-13-77.pek2.redhat.com [10.72.13.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 281CA60BFB;
        Wed,  8 Apr 2020 02:46:33 +0000 (UTC)
Date:   Wed, 8 Apr 2020 10:46:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>, piliu@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] powerpc/pseries/hotplug-memory: stop checking
 is_mem_section_removable()
Message-ID: <20200408024630.GQ2402@MiWiFi-R3L-srv>
References: <20200407135416.24093-1-david@redhat.com>
 <20200407135416.24093-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407135416.24093-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pingfan to CC since he usually handles ppc related bugs for RHEL.

On 04/07/20 at 03:54pm, David Hildenbrand wrote:
> In commit 53cdc1cb29e8 ("drivers/base/memory.c: indicate all memory
> blocks as removable"), the user space interface to compute whether a memory
> block can be offlined (exposed via
> /sys/devices/system/memory/memoryX/removable) has effectively been
> deprecated. We want to remove the leftovers of the kernel implementation.

Pingfan, can you have a look at this change on PPC?  Please feel free to
give comments if any concern, or offer ack if it's OK to you.

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
> 
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
> 

