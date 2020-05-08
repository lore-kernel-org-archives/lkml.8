Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4BBC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A15124960
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cf51VBGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEHNZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbgEHNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:25:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944EC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:25:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so1415944lfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYFngmQuiKj7kYwyJTK5tfHqOHjbxR0GHIB5m/n0A4s=;
        b=Cf51VBGpTVncNyypzafaMswErlBVVkKsuBZHqtPhOLPKowx6U319ToIwP6m5e6mpRh
         reAGFanDQBRdo0yq41C6od6xAcZ3/qy1z3Bn4i8/fn9QosxBRl1AWBOQsEvxs/PXTKSK
         WYEEG4rCEnNKBoipBN5aEhix/DSOgIhR0Bq3b9LfzMFlV/0L5H+QXWEVBsbUzqXrvVIu
         UJHUplKW+tyy4K5X1A9O2cOqWFbdEjE1XlleUvVb9Lg1AImgfisqVJB002wj0XqGmRdi
         tZKlPOwCqdV29jhgvG6M3tYzkVD3sYNM5uPHzsEL0GGBYsGYGKwvTh0a3K0cjHgZxayu
         4tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYFngmQuiKj7kYwyJTK5tfHqOHjbxR0GHIB5m/n0A4s=;
        b=UMhac4+wJ2wt5rjh7p1f5QJ8OvGlJ0tyecOi/n6j1jLLAy+QEW+zkfTVJo41A0fHbI
         4QV/nc4wQ6fVeU1JtD4YGC14WXynIkNOCPf74SkSsmODA+Awm1jOe1S+XSOrrYlGO2Qi
         7yN9qeASZu3iFoxUv389n37+KaKPd7q6dr/vvIgiib1bLBbU4QyQ3VPNVfAyxo5/fK5m
         zGwRhQZq+6Vm0Ln875FYmpInLnX24Wq6UIIc3ioVeeWQKFaAdfQSUo6EqeLqKtQsg+f3
         mH19y5VtEoPRfbUZ472VihYviQJiDB4Ed7aCEQrF9XaeCvL5EZ4xa6QECgi7sTL8q+n2
         1foQ==
X-Gm-Message-State: AOAM5332xNMe2w243Dm4SdiaTqDwWq+PfscDcePtYMYh7bnXMWTNFbfD
        ppW4Vhh1WbgaBKuqBZxqRP/LKEWgJwPtL57adrOiVw==
X-Google-Smtp-Source: ABdhPJy6STE2g2CuqlHSTfXqMy2kaHraheaovmbyST2t58vLi5VdRwyOUao8r55gn8pDJZpHRCgsAIkY7YDBnznXW2o=
X-Received: by 2002:a19:ee19:: with SMTP id g25mr1933226lfb.124.1588944325982;
 Fri, 08 May 2020 06:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200507204913.18661-1-shakeelb@google.com> <CALOAHbAHK4b2p0oWXY6oHG+WQzK3+TEa46=dPabhYT8ab=65zA@mail.gmail.com>
In-Reply-To: <CALOAHbAHK4b2p0oWXY6oHG+WQzK3+TEa46=dPabhYT8ab=65zA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 8 May 2020 06:25:14 -0700
Message-ID: <CALvZod7VujYgU=6XfgjSZnzLqDpbHwEYsp2Xbq9MK7w_z=LphA@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgsteal and pgscan
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 3:34 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Fri, May 8, 2020 at 4:49 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > One way to measure the efficiency of memory reclaim is to look at the
> > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > not updated consistently at the system level and the ratio of these are
> > not very meaningful. The pgsteal and pgscan are updated for only global
> > reclaim while pgrefill gets updated for global as well as cgroup
> > reclaim.
> >
>
> Hi Shakeel,
>
> We always use pgscan and pgsteal for monitoring the system level
> memory pressure, for example, by using sysstat(sar) or some other
> monitor tools.

Don't you need pgrefill in addition to pgscan and pgsteal to get the
full picture of the reclaim activity?

> But with this change, these two counters include the memcg pressure as
> well. It is not easy to know whether the pgscan and pgsteal are caused
> by system level pressure or only some specific memcgs reaching their
> memory limit.
>
> How about adding  cgroup_reclaim() to pgrefill as well ?
>

I am looking for all the reclaim activity on the system. Adding
!cgroup_reclaim to pgrefill will skip the cgroup reclaim activity.
Maybe adding pgsteal_cgroup and pgscan_cgroup would be better.

> > Please note that this difference is only for system level vmstats. The
> > cgroup stats returned by memory.stat are actually consistent. The
> > cgroup's pgsteal contains number of reclaimed pages for global as well
> > as cgroup reclaim. So, one way to get the system level stats is to get
> > these stats from root's memory.stat but root does not expose that
> > interface. Also for !CONFIG_MEMCG machines /proc/vmstat is the only way
> > to get these stats. So, make these stats consistent.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  mm/vmscan.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index cc555903a332..51f7d1efc912 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1943,8 +1943,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
> >         reclaim_stat->recent_scanned[file] += nr_taken;
> >
> >         item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> > -       if (!cgroup_reclaim(sc))
> > -               __count_vm_events(item, nr_scanned);
> > +       __count_vm_events(item, nr_scanned);
> >         __count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
> >         spin_unlock_irq(&pgdat->lru_lock);
> >
> > @@ -1957,8 +1956,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
> >         spin_lock_irq(&pgdat->lru_lock);
> >
> >         item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> > -       if (!cgroup_reclaim(sc))
> > -               __count_vm_events(item, nr_reclaimed);
> > +       __count_vm_events(item, nr_reclaimed);
> >         __count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> >         reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
> >         reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
> >
>
>
> --
> Thanks
> Yafang
