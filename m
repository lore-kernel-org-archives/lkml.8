Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4677EC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069AF24650
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX7kVLC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgATWsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:48:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33161 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:48:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id q81so865038oig.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOoVGkQMG9fuwyzXF2YxAVM9YDkWy55LOJb/1iZw5qU=;
        b=eX7kVLC+58ObqoGtxmSj130wp9vSbUgZcr/cntFCWZR0hUR6CkQoRjtvksdsSMl2u/
         ERLboz6bqKqGjDBVnwY8JFQu4I+LU4JZO/TQgZtmLRUau7J9t5l25h+b+i00+7Zhcowb
         f2WSoBXIdtXGTA5uBreRTt0cdiZaQVzjtGEB0+piP8A1lKXlFfCmhvGzxNIK45KhiNIn
         R4QdnT0U6LcXdlipWoImYHFEq+xYxXW9of/m/S8tsxOIuUk3dHHa54NkefQ9GY3NcOFk
         AH/yDhBqy91937AZsUJSiGXvhybSCFwl1b9kmbJzi5GYNyFd73GNGZsN3N+71y/ZOUfd
         exCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOoVGkQMG9fuwyzXF2YxAVM9YDkWy55LOJb/1iZw5qU=;
        b=F/4Fa++p5kynskLaeNAAiI2pdVYKg8cKr3pgj/kGxsHH+ox3sW7Lp+jTtZ4dA/L+tb
         K0oko2lj1TqMKkpcg2gON/j7qlK1oc6CAmPF82vU6Pe+mZLSxYM428bu0yJ3MiTGvR1Z
         SSbhew7BZeqlMYY9zlhdUsZDHABNRyXB3e7FqaihaFdAxWClQf+dHGpqnbc3JCMfkJhs
         u4uJiUmWE7siNKtuEubMAZBKrxghLJ1X8/xdYZKhm5R+xQhael+0XYSzUHNUBLqCmJbL
         2XIHt479s5EISlulKSTWGS2F3WehioGfU0ey/DuI3zfMRfU/gzvWG6h2w31Yq5hRNCUy
         R4Yg==
X-Gm-Message-State: APjAAAXUxgfCyjpSkNVSVxGcundsWT+46KoYr24S3iA0Onyytzrs3nJq
        lhR4bCoOJekpxucqbNz8OZE0NQcYk1DSh3fvm8WC2y7tHHQ=
X-Google-Smtp-Source: APXvYqzvzNK9x6La6mouCmLMZHBDParGylYVzMRXv71w//GmMzmC9teOzHpOqd9QUxWTA2MDZWi94lDSjAXSbhnQ1iI=
X-Received: by 2002:aca:3cd7:: with SMTP id j206mr878192oia.142.1579560496300;
 Mon, 20 Jan 2020 14:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com> <20200110073822.GC29802@dhcp22.suse.cz>
In-Reply-To: <20200110073822.GC29802@dhcp22.suse.cz>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 20 Jan 2020 14:48:05 -0800
Message-ID: <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal

On Thu, Jan 9, 2020 at 11:38 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> [CC Mel and Vlastimil]
>
> On Thu 09-01-20 14:56:46, Cong Wang wrote:
> > We observed kcompactd hung at __lock_page():
> >
> >  INFO: task kcompactd0:57 blocked for more than 120 seconds.
> >        Not tainted 4.19.56.x86_64 #1
> >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >  kcompactd0      D    0    57      2 0x80000000
> >  Call Trace:
> >   ? __schedule+0x236/0x860
> >   schedule+0x28/0x80
> >   io_schedule+0x12/0x40
> >   __lock_page+0xf9/0x120
> >   ? page_cache_tree_insert+0xb0/0xb0
> >   ? update_pageblock_skip+0xb0/0xb0
> >   migrate_pages+0x88c/0xb90
> >   ? isolate_freepages_block+0x3b0/0x3b0
> >   compact_zone+0x5f1/0x870
> >   kcompactd_do_work+0x130/0x2c0
> >   ? __switch_to_asm+0x35/0x70
> >   ? __switch_to_asm+0x41/0x70
> >   ? kcompactd_do_work+0x2c0/0x2c0
> >   ? kcompactd+0x73/0x180
> >   kcompactd+0x73/0x180
> >   ? finish_wait+0x80/0x80
> >   kthread+0x113/0x130
> >   ? kthread_create_worker_on_cpu+0x50/0x50
> >   ret_from_fork+0x35/0x40
> >
> > which faddr2line maps to:
> >
> >   migrate_pages+0x88c/0xb90:
> >   lock_page at include/linux/pagemap.h:483
> >   (inlined by) __unmap_and_move at mm/migrate.c:1024
> >   (inlined by) unmap_and_move at mm/migrate.c:1189
> >   (inlined by) migrate_pages at mm/migrate.c:1419
> >
> > Sometimes kcompactd eventually got out of this situation, sometimes not.
>
> What does this mean exactly? Who is holding the page lock?

As I explained in other email, I didn't locate the process holding the page
lock before I sent out this patch, as I was fooled by /proc/X/stack.

But now I got its stack trace with `perf`:

 ffffffffa722aa06 shrink_inactive_list
 ffffffffa722b3d7 shrink_node_memcg
 ffffffffa722b85f shrink_node
 ffffffffa722bc89 do_try_to_free_pages
 ffffffffa722c179 try_to_free_mem_cgroup_pages
 ffffffffa7298703 try_charge
 ffffffffa729a886 mem_cgroup_try_charge
 ffffffffa720ec03 __add_to_page_cache_locked
 ffffffffa720ee3a add_to_page_cache_lru
 ffffffffa7312ddb iomap_readpages_actor
 ffffffffa73133f7 iomap_apply
 ffffffffa73135da iomap_readpages
 ffffffffa722062e read_pages
 ffffffffa7220b3f __do_page_cache_readahead
 ffffffffa7210554 filemap_fault
 ffffffffc039e41f __xfs_filemap_fault
 ffffffffa724f5e7 __do_fault
 ffffffffa724c5f2 __handle_mm_fault
 ffffffffa724cbc6 handle_mm_fault
 ffffffffa70a313e __do_page_fault
 ffffffffa7a00dfe page_fault

It got stuck somewhere along the call path of mem_cgroup_try_charge(),
and the trace events of mm_vmscan_lru_shrink_inactive() indicates this
too:

         <...>-455459 [003] .... 2691911.664706:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664711:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664714:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=2 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=3
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664717:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664720:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664725:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=7 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664730:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664732:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664736:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664739:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=2 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=3
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664744:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664747:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=4 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664752:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=12 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activa
te=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664755:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664761:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664762:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664764:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664770:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=4 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664777:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=21 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activa
te=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664780:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455459 [003] .... 2691911.664783:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=2 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=3
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

Thanks.
