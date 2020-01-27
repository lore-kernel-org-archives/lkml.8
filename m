Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E35C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914A120716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580132517;
	bh=MRJLdRh7z3SHmbo3oqQc1u7bXszFdZ9N+Qi2BQSJx5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T8DWznhrYV9qEkBCUYRO8yurI051wHcS4340s1ESpL+e7vOSwZDOpGpZdd29UHwpl
	 YuG1h9zeklU6ygo7nwEnDJHxa7jXgr73njVUPbd+TVoFW295cZ5FA7cCBCxYDtdePj
	 0IbyDi3iIP2EuHwljUGsTwW0AfL4LNGO8AEmhW9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgA0Nl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:41:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42044 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgA0Nl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:41:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so11296219wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 05:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X9sWXuRrlazIboGJWLim1601zyUMaWqCoyalnc3sI4w=;
        b=sxARoPRftf57DHUwPWflhYVTJG1LdgNGA0Fl9Uvp/3FoiHj02I7MXulpxXwEJMnBaM
         m2uFhLa5rEn8w3K5RqjQVT5jEYFpz8dV54nst0y77oNAFRHezXMVMInJcxdCe5Ri6WOy
         h6El2ItL4wWnBX11mH8zNwdzCrVj69EY2Zk+3811J11eT8JlQqnc+MOlOF5KMJfR37Lc
         JhNv2bKB5CkB33XNbXbkT3rE+PIrprfnLBM4hJRwymCKUyN1lcltOdUJOow+Z5Nigo1z
         bMi1E1TeuZFIcrD4SwWDQ/3wN+bE7Tbo8GaJ7q0JwZdaDIYSGwdjR1uVlDGKe5XzWi1f
         HcKA==
X-Gm-Message-State: APjAAAXi4uQDTnHodlMLgzEQuot93qj7eZ4GDGEZafg/mRqycYf8yVpX
        WbzyQovobM13lWRhyE44HAVUrrlu
X-Google-Smtp-Source: APXvYqxFwaUCOnbrDKNWtIar19bvhaSXawt7e+gpETHXp2n9TFJc8gHbW74FsFMl++dXfwdQ0oue/g==
X-Received: by 2002:adf:ee52:: with SMTP id w18mr22336231wro.416.1580132513646;
        Mon, 27 Jan 2020 05:41:53 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a5sm18582701wmb.37.2020.01.27.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:41:52 -0800 (PST)
Date:   Mon, 27 Jan 2020 14:41:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Vishal Verma <vishal.l.verma@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mm/memory_hotplug: Fix remove_memory() lockdep splat
Message-ID: <20200127134152.GI1183@dhcp22.suse.cz>
References: <157991441887.2763922.4770790047389427325.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157991441887.2763922.4770790047389427325.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-01-20 17:07:21, Dan Williams wrote:
> The daxctl unit test for the dax_kmem driver currently triggers the
> (false positive) lockdep splat below. It results from the fact that
> remove_memory_block_devices() is invoked under the mem_hotplug_lock()
> causing lockdep entanglements with cpu_hotplug_lock() and sysfs (kernfs
> active state tracking). It is a false positive because the sysfs
> attribute path triggering the memory remove is not the same attribute
> path associated with memory-block device.
> 
> sysfs_break_active_protection() is not applicable since there is no real
> deadlock conflict, instead move memory-block device removal outside the
> lock. The mem_hotplug_lock() is not needed to synchronize the
> memory-block device removal vs the page online state, that is already
> handled by lock_device_hotplug(). Specifically, lock_device_hotplug() is
> sufficient to allow try_remove_memory() to check the offline state of
> the memblocks and be assured that any in progress online attempts are
> flushed / blocked by kernfs_drain() / attribute removal.
> 
> The add_memory() path safely creates memblock devices under the
> mem_hotplug_lock(). There is no kernfs active state synchronization in
> the memblock device_register() path, so nothing to fix there.
> 
> This change is only possible thanks to the recent change that refactored
> memory block device removal out of arch_remove_memory() (commit
> 4c4b7f9ba948 mm/memory_hotplug: remove memory block devices before
> arch_remove_memory()), and David's due diligence tracking down the
> guarantees afforded by kernfs_drain(). Not flagged for -stable since
> this only impacts ongoing development and lockdep validation, not a
> runtime issue.
> 
>     ======================================================
>     WARNING: possible circular locking dependency detected
>     5.5.0-rc3+ #230 Tainted: G           OE
>     ------------------------------------------------------
>     lt-daxctl/6459 is trying to acquire lock:
>     ffff99c7f0003510 (kn->count#241){++++}, at: kernfs_remove_by_name_ns+0x41/0x80
> 
>     but task is already holding lock:
>     ffffffffa76a5450 (mem_hotplug_lock.rw_sem){++++}, at: percpu_down_write+0x20/0xe0
> 
>     which lock already depends on the new lock.
> 
> 
>     the existing dependency chain (in reverse order) is:
> 
>     -> #2 (mem_hotplug_lock.rw_sem){++++}:
>            __lock_acquire+0x39c/0x790
>            lock_acquire+0xa2/0x1b0
>            get_online_mems+0x3e/0xb0
>            kmem_cache_create_usercopy+0x2e/0x260
>            kmem_cache_create+0x12/0x20
>            ptlock_cache_init+0x20/0x28
>            start_kernel+0x243/0x547
>            secondary_startup_64+0xb6/0xc0
> 
>     -> #1 (cpu_hotplug_lock.rw_sem){++++}:
>            __lock_acquire+0x39c/0x790
>            lock_acquire+0xa2/0x1b0
>            cpus_read_lock+0x3e/0xb0
>            online_pages+0x37/0x300
>            memory_subsys_online+0x17d/0x1c0
>            device_online+0x60/0x80
>            state_store+0x65/0xd0
>            kernfs_fop_write+0xcf/0x1c0
>            vfs_write+0xdb/0x1d0
>            ksys_write+0x65/0xe0
>            do_syscall_64+0x5c/0xa0
>            entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>     -> #0 (kn->count#241){++++}:
>            check_prev_add+0x98/0xa40
>            validate_chain+0x576/0x860
>            __lock_acquire+0x39c/0x790
>            lock_acquire+0xa2/0x1b0
>            __kernfs_remove+0x25f/0x2e0
>            kernfs_remove_by_name_ns+0x41/0x80
>            remove_files.isra.0+0x30/0x70
>            sysfs_remove_group+0x3d/0x80
>            sysfs_remove_groups+0x29/0x40
>            device_remove_attrs+0x39/0x70
>            device_del+0x16a/0x3f0
>            device_unregister+0x16/0x60
>            remove_memory_block_devices+0x82/0xb0
>            try_remove_memory+0xb5/0x130
>            remove_memory+0x26/0x40
>            dev_dax_kmem_remove+0x44/0x6a [kmem]
>            device_release_driver_internal+0xe4/0x1c0
>            unbind_store+0xef/0x120
>            kernfs_fop_write+0xcf/0x1c0
>            vfs_write+0xdb/0x1d0
>            ksys_write+0x65/0xe0
>            do_syscall_64+0x5c/0xa0
>            entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>     other info that might help us debug this:
> 
>     Chain exists of:
>       kn->count#241 --> cpu_hotplug_lock.rw_sem --> mem_hotplug_lock.rw_sem
> 
>      Possible unsafe locking scenario:
> 
>            CPU0                    CPU1
>            ----                    ----
>       lock(mem_hotplug_lock.rw_sem);
>                                    lock(cpu_hotplug_lock.rw_sem);
>                                    lock(mem_hotplug_lock.rw_sem);
>       lock(kn->count#241);
> 
>      *** DEADLOCK ***
> 
> No fixes tag as this has been a long standing issue that predated the
> addition of kernfs lockdep annotations.
> 
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> Changes since v4 [1]:
> - Drop the unnecessary consideration of mem->section_count.
>   kernfs_drain() + lock_device_hotplug() is sufficient protection
>   (David)
> 
> [1]: http://lore.kernel.org/r/157869128062.2451572.4093315441083744888.stgit@dwillia2-desk3.amr.corp.intel.com
> 
>  mm/memory_hotplug.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55ac23ef11c1..65ddaf3a2a12 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1763,8 +1763,6 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> -	mem_hotplug_begin();
> -
>  	/*
>  	 * All memory blocks must be offlined before removing memory.  Check
>  	 * whether all memory blocks in question are offline and return error
> @@ -1777,9 +1775,14 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
>  
> -	/* remove memory block devices before removing memory */
> +	/*
> +	 * Memory block device removal under the device_hotplug_lock is
> +	 * a barrier against racing online attempts.
> +	 */
>  	remove_memory_block_devices(start, size);
>  
> +	mem_hotplug_begin();
> +
>  	arch_remove_memory(nid, start, size, NULL);
>  	memblock_free(start, size);
>  	memblock_remove(start, size);

-- 
Michal Hocko
SUSE Labs
