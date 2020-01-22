Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D6AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EF324689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmQL+Dm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAVKnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:43:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38318 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726094AbgAVKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579689820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=WoHlwlK5fOZd973wnr6uAtce7fEXaxuq6Ysp5LjUDmA=;
        b=QmQL+Dm0WwA8aOvDrhk0+fHo06HX3BsmLBqxhGRLMCVac0LUxf3tSM40Xsrb4HmvFEdl3n
        pNxGty92yPEzqY15Ti3X0GE70oP06EX9+hvIzDAZbcs7Mmzpd4l6yKfojmkSw6wOUVnIvL
        S74LFigD69WR3mtA4xVFTJHSCZCI7U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-WxYnez-zPqagby63TcaO5A-1; Wed, 22 Jan 2020 05:43:24 -0500
X-MC-Unique: WxYnez-zPqagby63TcaO5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 486018017CC;
        Wed, 22 Jan 2020 10:43:22 +0000 (UTC)
Received: from [10.36.117.205] (ovpn-117-205.ams2.redhat.com [10.36.117.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36B9560E1C;
        Wed, 22 Jan 2020 10:43:20 +0000 (UTC)
Subject: Re: [PATCH v5] drivers/base/memory.c: cache memory blocks in xarray
 to accelerate lookup
To:     Scott Cheloha <cheloha@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        mhocko@suse.com, Scott Cheloha <cheloha@linux.vnet.ibm.com>
References: <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
 <20200121231028.13699-1-cheloha@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <e13c60f1-016d-2369-662d-451c5de89dfa@redhat.com>
Date:   Wed, 22 Jan 2020 11:43:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200121231028.13699-1-cheloha@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.20 00:10, Scott Cheloha wrote:
> From: Scott Cheloha <cheloha@linux.vnet.ibm.com>
> 
> Searching for a particular memory block by id is an O(n) operation
> because each memory block's underlying device is kept in an unsorted
> linked list on the subsystem bus.
> 
> We can cut the lookup cost to O(log n) if we cache each memory block
> in an xarray.  This time complexity improvement is significant on
> systems with many memory blocks.  For example:
> 
> 1. A 128GB POWER9 VM with 256MB memblocks has 512 blocks.  With this
>    change  memory_dev_init() completes ~12ms faster and walk_memory_blocks()
>    completes ~12ms faster.
> 
> Before:
> [    0.005042] memory_dev_init: adding memory blocks
> [    0.021591] memory_dev_init: added memory blocks
> [    0.022699] walk_memory_blocks: walking memory blocks
> [    0.038730] walk_memory_blocks: walked memory blocks 0-511
> 
> After:
> [    0.005057] memory_dev_init: adding memory blocks
> [    0.009415] memory_dev_init: added memory blocks
> [    0.010519] walk_memory_blocks: walking memory blocks
> [    0.014135] walk_memory_blocks: walked memory blocks 0-511
> 
> 2. A 256GB POWER9 LPAR with 256MB memblocks has 1024 blocks.  With
>    this change memory_dev_init() completes ~88ms faster and
>    walk_memory_blocks() completes ~87ms faster.
> 
> Before:
> [    0.252246] memory_dev_init: adding memory blocks
> [    0.395469] memory_dev_init: added memory blocks
> [    0.409413] walk_memory_blocks: walking memory blocks
> [    0.433028] walk_memory_blocks: walked memory blocks 0-511
> [    0.433094] walk_memory_blocks: walking memory blocks
> [    0.500244] walk_memory_blocks: walked memory blocks 131072-131583
> 
> After:
> [    0.245063] memory_dev_init: adding memory blocks
> [    0.299539] memory_dev_init: added memory blocks
> [    0.313609] walk_memory_blocks: walking memory blocks
> [    0.315287] walk_memory_blocks: walked memory blocks 0-511
> [    0.315349] walk_memory_blocks: walking memory blocks
> [    0.316988] walk_memory_blocks: walked memory blocks 131072-131583
> 
> 3. A 32TB POWER9 LPAR with 256MB memblocks has 131072 blocks.  With
>    this change we complete memory_dev_init() ~37 minutes faster and
>    walk_memory_blocks() at least ~30 minutes faster.  The exact timing
>    for walk_memory_blocks() is  missing, though I observed that the
>    soft lockups in walk_memory_blocks() disappeared with the change,
>    suggesting that lower bound.
> 
> Before:
> [   13.703907] memory_dev_init: adding blocks
> [ 2287.406099] memory_dev_init: added all blocks
> [ 2347.494986] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 2527.625378] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 2707.761977] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 2887.899975] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3068.028318] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3248.158764] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3428.287296] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3608.425357] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3788.554572] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3968.695071] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 4148.823970] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> 
> After:
> [   13.696898] memory_dev_init: adding blocks
> [   15.660035] memory_dev_init: added all blocks
> (the walk_memory_blocks traces disappear)
> 
> There should be no significant negative impact for machines with few
> memory blocks.  A sparse xarray has a small footprint and an O(log n)
> lookup is negligibly slower than an O(n) lookup for only the smallest
> number of memory blocks.
> 
> 1. A 16GB x86 machine with 128MB memblocks has 132 blocks.  With this
>    change memory_dev_init() completes ~300us faster and walk_memory_blocks()
>    completes no faster or slower.  The improvement is pretty close to noise.
> 
> Before:
> [    0.224752] memory_dev_init: adding memory blocks
> [    0.227116] memory_dev_init: added memory blocks
> [    0.227183] walk_memory_blocks: walking memory blocks
> [    0.227183] walk_memory_blocks: walked memory blocks 0-131
> 
> After:
> [    0.224911] memory_dev_init: adding memory blocks
> [    0.226935] memory_dev_init: added memory blocks
> [    0.227089] walk_memory_blocks: walking memory blocks
> [    0.227089] walk_memory_blocks: walked memory blocks 0-131
> 
> Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> v2 incorporates suggestions from David Hildenbrand.
> 
> v3 changes:
>   - Rebase atop "drivers/base/memory.c: drop the mem_sysfs_mutex"
> 
>   - Be conservative: don't use radix_tree_for_each_slot() in
>     walk_memory_blocks() yet.  It introduces RCU which could
>     change behavior.  Walking the tree "by hand" with
>     find_memory_block_by_id() is slower but keeps the patch
>     simple.
> 
> v4 changes:
>   - Rewrite commit message to explicitly note the time
>     complexity improvements.
> 
>   - Provide anecdotal accounts of time-savings in changelog
> 
> v5 changes:
>   - Switch from the radix_tree API to the xarray API to conform
>     to current kernel preferences.
> 
>   - Move the time savings accounts into the commit message itself.
>     Remeasure performance changes on the machines I had available.
> 
>     It should be noted that I was not able to get time on the 32TB
>     machine to remeasure the improvements for v5.  The quoted traces
>     are from v4 of the patch.  However, the xarray API is used to
>     implement the radix_tree API, so I expect the performance changes
>     will be identical.
> 
>     I did test v5 of the patch on the other machines mentioned in the
>     commit message to ensure there were no regressions.
> 
>  drivers/base/memory.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 799b43191dea..2178d3e6d063 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -21,6 +21,7 @@
>  #include <linux/mm.h>
>  #include <linux/stat.h>
>  #include <linux/slab.h>
> +#include <linux/xarray.h>
>  
>  #include <linux/atomic.h>
>  #include <linux/uaccess.h>
> @@ -56,6 +57,13 @@ static struct bus_type memory_subsys = {
>  	.offline = memory_subsys_offline,
>  };
>  
> +/*
> + * Memory blocks are cached in a local radix tree to avoid
> + * a costly linear search for the corresponding device on
> + * the subsystem bus.
> + */
> +static DEFINE_XARRAY(memory_blocks);
> +
>  static BLOCKING_NOTIFIER_HEAD(memory_chain);
>  
>  int register_memory_notifier(struct notifier_block *nb)
> @@ -572,20 +580,14 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
>  /* A reference for the returned memory block device is acquired. */
>  static struct memory_block *find_memory_block_by_id(unsigned long block_id)
>  {
> -	struct device *dev;
> +	struct memory_block *mem;
>  
> -	dev = subsys_find_device_by_id(&memory_subsys, block_id, NULL);
> -	return dev ? to_memory_block(dev) : NULL;
> +	mem = xa_load(&memory_blocks, block_id);
> +	if (mem)
> +		get_device(&mem->dev);
> +	return mem;
>  }
>  
> -/*
> - * For now, we have a linear search to go find the appropriate
> - * memory_block corresponding to a particular phys_index. If
> - * this gets to be a real problem, we can always use a radix
> - * tree or something here.
> - *
> - * This could be made generic for all device subsystems.
> - */
>  struct memory_block *find_memory_block(struct mem_section *section)
>  {
>  	unsigned long block_id = base_memory_block_id(__section_nr(section));
> @@ -628,9 +630,16 @@ int register_memory(struct memory_block *memory)
>  	memory->dev.offline = memory->state == MEM_OFFLINE;
>  
>  	ret = device_register(&memory->dev);
> -	if (ret)
> +	if (ret) {
>  		put_device(&memory->dev);
> -
> +		return ret;
> +	}
> +	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
> +			      GFP_KERNEL));
> +	if (ret) {
> +		put_device(&memory->dev);
> +		device_unregister(&memory->dev);
> +	}
>  	return ret;
>  }
>  
> @@ -688,6 +697,8 @@ static void unregister_memory(struct memory_block *memory)
>  	if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
>  		return;
>  
> +	WARN_ON(xa_erase(&memory_blocks, memory->dev.id) == NULL);
> +
>  	/* drop the ref. we got via find_memory_block() */
>  	put_device(&memory->dev);
>  	device_unregister(&memory->dev);
> 

I think only the device_hotplug_lock documentation from me as a fixup
are missing. So this replacing the original patch looks good to me!

Thanks Scott!

-- 
Thanks,

David / dhildenb

