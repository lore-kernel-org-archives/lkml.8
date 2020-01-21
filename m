Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEF4C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CC2217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579597254;
	bh=YojLrIYPDy/yEPBwFDCXtBT3yaxoPQhck0F3alYtcyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gf1icYlKEva1iS0NAzuvNA7IepmcC6tpKYSLUUol4XnXAHeYX5ZfwtwBRFor0mAbV
	 2QmNdKJuedxMONlbDm8yrXDyCQuPX5lHzmEFEhFpSdu/BGtbzqJ8xhFBtZpGXH4lSN
	 I4OEUgrvfMzOA8HPOXPypeBoIQVFJX/ZilfpPBcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAUJAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:00:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51422 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:00:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so2051763wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2lqF7a8plZ8V2KVyRIs80uv+I50WzzSKH8CLyPZhybY=;
        b=I5vVuGt7CkNPsqA3FGyR5dyQf+g5xwTC2PbwjByEK5dViTehJ2IAPEpO+WMOiboDvj
         zO08y2kQ7QxCcvtUJC8t0XaJC949t9OYSIWvjYfKMmk6v9y3vEifhUU8XoGTozgmZHfh
         2f08H02Emw2l5GjdeXn2UYcqNAJs053fyCzbVXMHgrEZqlTAqQ+CY+jVHUoIWu5ufxm/
         zAJFy+25Q3xqCaYYbOMDeA8WhUQX0hYn19RHqS/oLX53cEM9iWMOBVZCjQvaXBQouArS
         aTJ+X81Gs4XglD7gJQSXvx6IxrE9LO2LF6PdsfTgKBWaZpRU608Mdra7RVRgrb7e7rdy
         mORg==
X-Gm-Message-State: APjAAAUs/0/bgRurUUsfpHJ4kaGQpQRams4OXn12fZvixBwhDcLYDLwO
        Bgo1TVZxuuyDqEdLmrLActs=
X-Google-Smtp-Source: APXvYqwwT2fszaSN+hspfYkrHGm4hGdKvDJG9i/v0amOZy7O+n/Kuo41UfeG82AoV+zBTIHM0CrJSg==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr3390379wmi.10.1579597250018;
        Tue, 21 Jan 2020 01:00:50 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j12sm55633547wrw.54.2020.01.21.01.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 01:00:49 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:00:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200121090048.GG29276@dhcp22.suse.cz>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 14:48:05, Cong Wang wrote:
> Hi, Michal
> 
> On Thu, Jan 9, 2020 at 11:38 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > [CC Mel and Vlastimil]
> >
> > On Thu 09-01-20 14:56:46, Cong Wang wrote:
> > > We observed kcompactd hung at __lock_page():
> > >
> > >  INFO: task kcompactd0:57 blocked for more than 120 seconds.
> > >        Not tainted 4.19.56.x86_64 #1
> > >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > >  kcompactd0      D    0    57      2 0x80000000
> > >  Call Trace:
> > >   ? __schedule+0x236/0x860
> > >   schedule+0x28/0x80
> > >   io_schedule+0x12/0x40
> > >   __lock_page+0xf9/0x120
> > >   ? page_cache_tree_insert+0xb0/0xb0
> > >   ? update_pageblock_skip+0xb0/0xb0
> > >   migrate_pages+0x88c/0xb90
> > >   ? isolate_freepages_block+0x3b0/0x3b0
> > >   compact_zone+0x5f1/0x870
> > >   kcompactd_do_work+0x130/0x2c0
> > >   ? __switch_to_asm+0x35/0x70
> > >   ? __switch_to_asm+0x41/0x70
> > >   ? kcompactd_do_work+0x2c0/0x2c0
> > >   ? kcompactd+0x73/0x180
> > >   kcompactd+0x73/0x180
> > >   ? finish_wait+0x80/0x80
> > >   kthread+0x113/0x130
> > >   ? kthread_create_worker_on_cpu+0x50/0x50
> > >   ret_from_fork+0x35/0x40
> > >
> > > which faddr2line maps to:
> > >
> > >   migrate_pages+0x88c/0xb90:
> > >   lock_page at include/linux/pagemap.h:483
> > >   (inlined by) __unmap_and_move at mm/migrate.c:1024
> > >   (inlined by) unmap_and_move at mm/migrate.c:1189
> > >   (inlined by) migrate_pages at mm/migrate.c:1419
> > >
> > > Sometimes kcompactd eventually got out of this situation, sometimes not.
> >
> > What does this mean exactly? Who is holding the page lock?
> 
> As I explained in other email, I didn't locate the process holding the page
> lock before I sent out this patch, as I was fooled by /proc/X/stack.
> 
> But now I got its stack trace with `perf`:
> 
>  ffffffffa722aa06 shrink_inactive_list
>  ffffffffa722b3d7 shrink_node_memcg
>  ffffffffa722b85f shrink_node
>  ffffffffa722bc89 do_try_to_free_pages
>  ffffffffa722c179 try_to_free_mem_cgroup_pages
>  ffffffffa7298703 try_charge
>  ffffffffa729a886 mem_cgroup_try_charge
>  ffffffffa720ec03 __add_to_page_cache_locked
>  ffffffffa720ee3a add_to_page_cache_lru
>  ffffffffa7312ddb iomap_readpages_actor
>  ffffffffa73133f7 iomap_apply
>  ffffffffa73135da iomap_readpages
>  ffffffffa722062e read_pages
>  ffffffffa7220b3f __do_page_cache_readahead
>  ffffffffa7210554 filemap_fault
>  ffffffffc039e41f __xfs_filemap_fault
>  ffffffffa724f5e7 __do_fault
>  ffffffffa724c5f2 __handle_mm_fault
>  ffffffffa724cbc6 handle_mm_fault
>  ffffffffa70a313e __do_page_fault
>  ffffffffa7a00dfe page_fault
> 
> It got stuck somewhere along the call path of mem_cgroup_try_charge(),
> and the trace events of mm_vmscan_lru_shrink_inactive() indicates this
> too:

So it seems that you are condending on the page lock. It is really
unexpected that the reclaim would take that long though. Please try to
enable more vmscan tracepoints to see where the time is spent.

Thanks!
-- 
Michal Hocko
SUSE Labs
