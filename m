Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0295BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B02465A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQrBhwNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAUTV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:21:58 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38855 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:21:58 -0500
Received: by mail-ed1-f68.google.com with SMTP id i16so4180206edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzWsi17wngFlVBcJsP9nUk5E3aeur+/x4VKyjnHng+c=;
        b=XQrBhwNx6uU78ybFgPe20OvAMypHfT2fcrGv5LUFRBzWaiShcX8nEREiM0SdZNN3KK
         k+89TokQLhj0il21U4n36EB6RdhDRD2ZITJ3LJ5pu/O17Qr5UVeBHcNdEkWytwtDuRrb
         AakjvEv0p0vcjE4OBCj3iTTR94gAvM/RjkKzZVcawLQPA6twaD85/p7bHA9pI7bjYZUh
         NEvvclZof6pJlIGqqUGnQr8BldxsIlRu3HynDi4wycojMhwl6RG/HrSY79m9AoeFWahK
         trvekdcu0JuDG/991yEfczOfptVBcaeKwgxYzRdt0crhVBxHG+ppwkJT+c52HIau5cB5
         2mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzWsi17wngFlVBcJsP9nUk5E3aeur+/x4VKyjnHng+c=;
        b=OhIGIBQCIPojCUEtxENSPPYEwKz1yLK4pYLdLYN8eOXEblS6uhP9A6LhMj7qEapnji
         bvw/883vkOfPigIjYjYt0NnzJohYW7SfErTnjBusIJUlf/cHqh6KKZRlNctwQZXdqfL5
         sFKOWXeZmNYW+aZ719QcEmYrkMz2dOFb45iDgEziuBuwU//PD5WyiAIsEFry+l5W2WQZ
         lm20ucwIJZSs49J0RRFq36No2E/qwLqHukQ0JG6bdUYK48nU0nlIBYnFxnEb+XmKDBZL
         wpkogP6Awhviveisq0NwJCT0k7KnlPr1ZO2lQEvBknyXcAJN8gHrqkEaeelTvHVoQxiG
         dYXA==
X-Gm-Message-State: APjAAAUoiMEkdu0HyXRrqJHuL/XWR+qxwqg0BTSbhnS3Xea0kvLsB37N
        +cR6z3jfmc75Z+RQjfE/zdLVM82dAlbE53/pSEM=
X-Google-Smtp-Source: APXvYqzYuAhnmZmw6MhZ6Fk5KaUQC1Sr7zu0i3bl9llypXaYfgAqJPs9YHi7yyHllX0ZRbKazhaBJdGyfMB6WZ+8Ljc=
X-Received: by 2002:a17:906:7e41:: with SMTP id z1mr5978619ejr.23.1579634515466;
 Tue, 21 Jan 2020 11:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110092256.GN3466@techsingularity.net> <CAM_iQpWfnFD9YUetACbYf0u-be6u3m3Y62iAcbWSc1Ykrf4XCA@mail.gmail.com>
In-Reply-To: <CAM_iQpWfnFD9YUetACbYf0u-be6u3m3Y62iAcbWSc1Ykrf4XCA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Jan 2020 11:21:37 -0800
Message-ID: <CAHbLzkrY5uffkJ4t=O8mZerJZCKvtGfd035PQkAf4q5QCCzvqg@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 2:42 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Fri, Jan 10, 2020 at 1:22 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Thu, Jan 09, 2020 at 02:56:46PM -0800, Cong Wang wrote:
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
> > >
> > > I think for memory compaction, it is a best effort to migrate the pages,
> > > so it doesn't have to wait for I/O to complete. It is fine to call
> > > trylock_page() here, which is pretty much similar to
> > > buffer_migrate_lock_buffers().
> > >
> > > Given MIGRATE_SYNC_LIGHT is used on compaction path, just relax the
> > > check for it.
> > >
> >
> > Is this a single page being locked for a long time or multiple pages
> > being locked without reaching a reschedule point?
>
> Not sure whether it is single page or multiple pages, but I successfully
> located the process locking the page (or pages), and I used perf to
> capture its stack trace:
>
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
> This process got stuck in this situation for a long time (since I sent out
> this patch) without making any progress. It behaves like stuck in an infinite
> loop, although the EIP still moves around within mem_cgroup_try_charge().
>
> I also enabled trace event mm_vmscan_lru_shrink_inactive(), here is what
> I collected:
>
>            <...>-455459 [003] .... 2691911.664706:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664711:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664714:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=2 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=3
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664717:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664720:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664725:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=7 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664730:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664732:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664736:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664739:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=2 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=3
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664744:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664747:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=4 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664752:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=12 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activa
> te=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664755:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664761:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664762:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664764:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664770:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=4 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664777:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=21 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activa
> te=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664780:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>            <...>-455459 [003] .... 2691911.664783:
> mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=2 nr_reclaimed=0
> nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
> e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=3
> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

Thanks for sharing the tracing result. I suspect the case might be:

                       CPU A                                CPU B
page fault
    locked the page
        try charge
            do limit reclaim
                                                           compaction
tried to isolate the locked page


But it looks the limit reclaim took forever without reclaiming any
page, and no oom or bail out correctly. And, according to the tracing
result, it seems the inactive lru is very short since it just scanned
a few pages even with very high priority.

So, other than Michal's suggestion, I'd suggest you inspect what the
jobs are doing in that memcg.

>
>
> >
> > If it's a single page being locked, it's important to identify what held
> > page lock for 2 minutes because that is potentially a missing
> > unlock_page. The kernel in question is old -- 4.19.56. Are there any
> > other modifications to that kernel?
>
> We only backported some networking and hardware driver patches,
> not any MM change.
>
> Please let me know if I can collect any other information you need,
> before it gets rebooted.
>
> Thanks.
>
