Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC69C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A552524654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579597578;
	bh=re9xoH7jsrRDPgJEgMYpkeOonxM2NOQUlOaKRifg530=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WurRTiI9vrC/O3OVq3VUkVzvquHeuJxx+6GtxTt6/Sj6+VXBQtiaPs3TrC2GcmzmR
	 p2I+1TqvqkxZL429R3kLf2RnnXGk6wvd8aTZo3hCdGrk4MstreaBcmnkhISN+3rIms
	 Vy/XyRiN1nxcm1bD4wppVyP5/9Qu1NnklWx5PNpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgAUJGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:06:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37693 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUJGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:06:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so2251515wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vme6Q9xtaUwaAF50k2ZYymvH7ujyLW66SHMhF0t0zLA=;
        b=MnYDtCtieMCasBBQFlTgBKR6kx6VobyR6lx+ZWAWiA+LSGYXSR2UHhQ7wTvyFqJCuL
         iZGkAEYevqBJ3hSK0kfsnsC5DByWrLTiS28R450VY0fg/nHXT0fjx1+yqjDAhBz+d/Np
         BzvxjhAZF+nK3WpV2lj9/MudE++JhyjDLtXNFqQzL1myhvmCtn8oYra6cmjho9W034IS
         /HTLNRMvdlG4ncukEH+0F9Mn5ubXDdajeh0qqZLNlYUD18Je4B4/xstIe9ktQWvrFS3D
         ZQW4oJN5cUO/kJI9tqvUfByi19H7WPGcQKdF9gnYuiij4Lf+HVocMfMnTK57vqN7ccF9
         7TpA==
X-Gm-Message-State: APjAAAXZmqNa3LsGjbeb2ZAt9CRiZVWRvBTuQlSjytTc0LG+KfG5P2qU
        jEwX/fovCbajA9gF5UGm7R5b1i7q
X-Google-Smtp-Source: APXvYqxDhb96NitakL/tObA4UbtJCxw7XFbXysjr1baDjdNyLwHiwE6aAYTW8YRBeifAYW5BIfNzJw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr3890370wrq.37.1579597574300;
        Tue, 21 Jan 2020 01:06:14 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v22sm2946531wml.11.2020.01.21.01.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 01:06:13 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:06:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200121090612.GH29276@dhcp22.suse.cz>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110092256.GN3466@techsingularity.net>
 <20200121082624.12608-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121082624.12608-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-01-20 16:26:24, Hillf Danton wrote:
> 
> On Mon, 20 Jan 2020 14:41:50 -0800 Cong Wang wrote:
> > On Fri, Jan 10, 2020 at 1:22 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Thu, Jan 09, 2020 at 02:56:46PM -0800, Cong Wang wrote:
> > > > We observed kcompactd hung at __lock_page():
> > > >
> > > >  INFO: task kcompactd0:57 blocked for more than 120 seconds.
> > > >        Not tainted 4.19.56.x86_64 #1
> > > >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > >  kcompactd0      D    0    57      2 0x80000000
> > > >  Call Trace:
> > > >   ? __schedule+0x236/0x860
> > > >   schedule+0x28/0x80
> > > >   io_schedule+0x12/0x40
> > > >   __lock_page+0xf9/0x120
> > > >   ? page_cache_tree_insert+0xb0/0xb0
> > > >   ? update_pageblock_skip+0xb0/0xb0
> > > >   migrate_pages+0x88c/0xb90
> > > >   ? isolate_freepages_block+0x3b0/0x3b0
> > > >   compact_zone+0x5f1/0x870
> > > >   kcompactd_do_work+0x130/0x2c0
> > > >   ? __switch_to_asm+0x35/0x70
> > > >   ? __switch_to_asm+0x41/0x70
> > > >   ? kcompactd_do_work+0x2c0/0x2c0
> > > >   ? kcompactd+0x73/0x180
> > > >   kcompactd+0x73/0x180
> > > >   ? finish_wait+0x80/0x80
> > > >   kthread+0x113/0x130
> > > >   ? kthread_create_worker_on_cpu+0x50/0x50
> > > >   ret_from_fork+0x35/0x40
> > > >
> > > > which faddr2line maps to:
> > > >
> > > >   migrate_pages+0x88c/0xb90:
> > > >   lock_page at include/linux/pagemap.h:483
> > > >   (inlined by) __unmap_and_move at mm/migrate.c:1024
> > > >   (inlined by) unmap_and_move at mm/migrate.c:1189
> > > >   (inlined by) migrate_pages at mm/migrate.c:1419
> > > >
> > > > Sometimes kcompactd eventually got out of this situation, sometimes not.
> > > >
> > > > I think for memory compaction, it is a best effort to migrate the pages,
> > > > so it doesn't have to wait for I/O to complete. It is fine to call
> > > > trylock_page() here, which is pretty much similar to
> > > > buffer_migrate_lock_buffers().
> > > >
> > > > Given MIGRATE_SYNC_LIGHT is used on compaction path, just relax the
> > > > check for it.
> > > >
> > >
> > > Is this a single page being locked for a long time or multiple pages
> > > being locked without reaching a reschedule point?
> > 
> > Not sure whether it is single page or multiple pages, but I successfully
> > located the process locking the page (or pages), and I used perf to
> > capture its stack trace:
> > 
> > 
> >  ffffffffa722aa06 shrink_inactive_list
> >  ffffffffa722b3d7 shrink_node_memcg
> >  ffffffffa722b85f shrink_node
> >  ffffffffa722bc89 do_try_to_free_pages
> >  ffffffffa722c179 try_to_free_mem_cgroup_pages
> >  ffffffffa7298703 try_charge
> >  ffffffffa729a886 mem_cgroup_try_charge
> >  ffffffffa720ec03 __add_to_page_cache_locked
> >  ffffffffa720ee3a add_to_page_cache_lru
> >  ffffffffa7312ddb iomap_readpages_actor
> >  ffffffffa73133f7 iomap_apply
> >  ffffffffa73135da iomap_readpages
> >  ffffffffa722062e read_pages
> >  ffffffffa7220b3f __do_page_cache_readahead
> >  ffffffffa7210554 filemap_fault
> >  ffffffffc039e41f __xfs_filemap_fault
> >  ffffffffa724f5e7 __do_fault
> >  ffffffffa724c5f2 __handle_mm_fault
> >  ffffffffa724cbc6 handle_mm_fault
> >  ffffffffa70a313e __do_page_fault
> >  ffffffffa7a00dfe page_fault
> > 
> > This process got stuck in this situation for a long time (since I sent out
> > this patch) without making any progress. It behaves like stuck in an infinite
> > loop, although the EIP still moves around within mem_cgroup_try_charge().
> 
> Make page reclaim in try_charge() async assuming sync reclaim is unnecessary
> without memory pressure and it does not help much under heavy pressure. Skipping
> reclaim is only confined in page fault context to avoid adding too much a time.
> 
> --- linux-5.5-rc3/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2525,6 +2525,12 @@ force:
>  	if (do_memsw_account())
>  		page_counter_charge(&memcg->memsw, nr_pages);
>  	css_get_many(&memcg->css, nr_pages);
> +	/*
> +	 * reclaim high limit pages soon without holding resources like
> +	 * page lock e.g in page fault context
> +	 */
> +	if (unlikely(current->flags & PF_MEMALLOC))
> +		schedule_work(&memcg->high_work);
>  
>  	return 0;
>  
> --- linux-5.5-rc3/mm/filemap.c	
> +++ b/mm/filemap.c
> @@ -863,8 +863,14 @@ static int __add_to_page_cache_locked(st
>  	mapping_set_update(&xas, mapping);
>  
>  	if (!huge) {
> +		bool was_set = current->flags & PF_MEMALLOC;
> +		if (!was_set)
> +			current->flags |= PF_MEMALLOC;
> +
>  		error = mem_cgroup_try_charge(page, current->mm,
>  					      gfp_mask, &memcg, false);
> +		if (!was_set)
> +			current->flags &= ~PF_MEMALLOC;
>  		if (error)
>  			return error;

Not only this doesn't help at all because the direct reclaim for the
hard limit is done already. The high limit is also already handled
properly when we are under the hard limit. So this patch doesn't really
make much sense to me.
-- 
Michal Hocko
SUSE Labs
