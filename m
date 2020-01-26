Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C649CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6D520716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZNDkNhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAZTyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:54:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46272 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZTyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:54:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so6448552otb.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 11:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nf++034O2ADon7l7potoTrFBHiiOGvz0fwI6LSaXWn8=;
        b=RZNDkNhuMM22FTj9GbXxdHr4O2w1mOGNAZqidUvOqtRLeGMJXsgzDn1em7c2/aGlmS
         GppJYD/YUCeC15Oehv7JnaSZOE86wT0lSLHC/H/3vklcGiDg01KdPIhe7zKMguM8xuNv
         ox2X+Twhp1dIVwvS+4YmiqBUPL4tx5BsvY9O3iTBeqSP5ZEqkXICGwbxnFkPEypTuleO
         hw2CH4KCVuDSlTRA1B6QcX/0DIEdKCQZ08HaR5kv1zbOUdCkaOxOcmTs33tR9ArtIai9
         R7UPx5OcwFYkovS0KOV6xC4ZLi+9KGAsrXxr+MISqFzKR+NPnAqFF2Gv3e0IBHnE+MEd
         t/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nf++034O2ADon7l7potoTrFBHiiOGvz0fwI6LSaXWn8=;
        b=A6mMJtwh1jghpit6Im8eTuap1kEZqVt4Q9ruNfQLJ7RmwxFCzfvZkflxkcI5z3iOBc
         tPz0itnbYXJnTfon3gyiBLVnWMbXHsb9+fgv/3G8D+dg7tbI0uphjKom8YzTN/naPF8Y
         txPPpNcR8vqo7FspY7sx6LJY5a9VN/G/ttcWyMGnbSgc64Dbq+xIMVwBKzlk+eHDq6A2
         ZTfRrUmXheHb03/mL6j6wldDtVuxXYziQSbNHd5l98q0h7HjdOrisNCN1/wFzxuLc9Qd
         sj0BcixVrXsOWfDlKn86gUzeaK6/2Dx7kN2yw74FmZJev1LYbiCAYm70eMTorbiAchLp
         yFQg==
X-Gm-Message-State: APjAAAXlfCjpcvgFHqRERJb9Nj477JGh990VhyR0XPGE1mm4aUteCUPn
        YXiKy7KgHGWf4RKBIu38MvkJT3Q81FvBVHFcyys=
X-Google-Smtp-Source: APXvYqynKOvUWZhuA8ehPCuMh2LEfzsm1dZ5rVAdpvRDiV19/rawx79D6p9tyn4hxpU5eR3GSJ9/wjMXRGbTXfTO1jc=
X-Received: by 2002:a05:6830:1e64:: with SMTP id m4mr2233307otr.244.1580068446460;
 Sun, 26 Jan 2020 11:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz> <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
In-Reply-To: <20200121090048.GG29276@dhcp22.suse.cz>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun, 26 Jan 2020 11:53:55 -0800
Message-ID: <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
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

On Tue, Jan 21, 2020 at 1:00 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 20-01-20 14:48:05, Cong Wang wrote:
> > It got stuck somewhere along the call path of mem_cgroup_try_charge(),
> > and the trace events of mm_vmscan_lru_shrink_inactive() indicates this
> > too:
>
> So it seems that you are condending on the page lock. It is really
> unexpected that the reclaim would take that long though. Please try to
> enable more vmscan tracepoints to see where the time is spent.

Sorry for the delay. I have been trying to collect more data in one shot.

This is a a typical round of the loop after enabling all vmscan tracepoints:

           <...>-455450 [007] .... 4048595.842992:
mm_vmscan_memcg_reclaim_begin: order=0 may_writepage=1
gfp_flags=GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE
classzone_idx=
4
           <...>-455450 [007] d... 4048595.842995:
mm_vmscan_lru_isolate: isolate_mode=0 classzone=3 order=0
nr_requested=1 nr_scanned=1 nr_skipped=0 nr_taken=1 lru=inactive_file
           <...>-455450 [007] .... 4048595.842995:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455450 [007] dN.. 4048595.842997:
mm_vmscan_lru_isolate: isolate_mode=0 classzone=3 order=0
nr_requested=1 nr_scanned=1 nr_skipped=0 nr_taken=1 lru=inactive_file
           <...>-455450 [007] .... 4048595.843001:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=1 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=3
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455450 [007] d... 4048595.843002:
mm_vmscan_lru_isolate: isolate_mode=0 classzone=3 order=0
nr_requested=5 nr_scanned=5 nr_skipped=0 nr_taken=5 lru=inactive_file
           <...>-455450 [007] .... 4048595.843004:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455450 [007] d... 4048595.843006:
mm_vmscan_lru_isolate: isolate_mode=0 classzone=3 order=0
nr_requested=9 nr_scanned=9 nr_skipped=0 nr_taken=9 lru=inactive_file
           <...>-455450 [007] .... 4048595.843007:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=9 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activat
e=0 nr_ref_keep=0 nr_unmap_fail=0 priority=1
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455450 [007] d... 4048595.843009:
mm_vmscan_lru_isolate: isolate_mode=0 classzone=3 order=0
nr_requested=17 nr_scanned=15 nr_skipped=0 nr_taken=15
lru=inactive_file
           <...>-455450 [007] .... 4048595.843011:
mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=15 nr_reclaimed=0
nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activa
te=0 nr_ref_keep=0 nr_unmap_fail=0 priority=0
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
           <...>-455450 [007] .... 4048595.843012:
mm_vmscan_memcg_reclaim_end: nr_reclaimed=0

The whole trace output is huge (33M), I can provide it on request.

I suspect the process gets stuck in the retry loop in try_charge(), as
the _shortest_ stacktrace of the perf samples indicated:

cycles:ppp:
        ffffffffa72963db mem_cgroup_iter
        ffffffffa72980ca mem_cgroup_oom_unlock
        ffffffffa7298c15 try_charge
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

But I don't see how it could be, the only possible case is when
mem_cgroup_oom() returns OOM_SUCCESS. However I can't
find any clue in dmesg pointing to OOM. These processes in the
same memcg are either running or sleeping (that is not exiting or
coredump'ing), I don't see how and why they could be selected as
a victim of OOM killer. I don't see any signal pending either from
their /proc/X/status.

Here is the status of the whole memcg:

$ sudo cat /sys/fs/cgroup/memory/system.slice/osqueryd.service/memory.oom_control
oom_kill_disable 0
under_oom 0
oom_kill 0

$ sudo cat /sys/fs/cgroup/memory/system.slice/osqueryd.service/memory.stat
cache 376832
rss 255864832
rss_huge 0
shmem 0
mapped_file 135168
dirty 135168
writeback 0
pgpgin 5327157
pgpgout 5264598
pgfault 4251687
pgmajfault 7491
inactive_anon 4096
active_anon 256184320
inactive_file 32768
active_file 0
unevictable 0
hierarchical_memory_limit 262144000
total_cache 376832
total_rss 255864832
total_rss_huge 0
total_shmem 0
total_mapped_file 135168
total_dirty 135168
total_writeback 0
total_pgpgin 5327157
total_pgpgout 5264598
total_pgfault 4251687
total_pgmajfault 7491
total_inactive_anon 4096
total_active_anon 256184320
total_inactive_file 86016
total_active_file 0
total_unevictable 0

Please let me know if I can provide anything else.

Thanks.
