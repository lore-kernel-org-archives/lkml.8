Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9489FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F83021473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB+Tw4YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHKel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbgEHKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:34:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7EC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 03:34:40 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i19so1292041ioh.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4Bt4bjxehMk3gJfl5cWg7LmoeINB3VH5yh3MCR/E2Q=;
        b=IB+Tw4YAIP5htJFb4/RhOt9cQtCj/gsj2H9De6ZNAWkRyFbjtd6Vs8RePxxykMGA8L
         JRS0WPL4MGlNK0Gb8kgVF6VgTkbUOC+71977cB3oeolZfa65/5G/9lUerxqT96nYElHo
         OmET902itAyloMrhsJCpPFDXFZIx2/4zHmpRfMEcFVBt8Z0gKaxbBoQOtKIAWvG8To7a
         FB6SOgxUIQhYEoheTiXlKQPHWZHtx3cIYqtvd2JWxpu82TF0Gh+/sq/sxkYiPc+Rne4z
         ScKlCcw7xInfTJJCeotQF1HuaSoerJrRewLKrBYIJNSf1C7fnGIl0DrtxWbbI9Zkffvx
         Py1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4Bt4bjxehMk3gJfl5cWg7LmoeINB3VH5yh3MCR/E2Q=;
        b=LPqQUnuPrJ9AWAyTRP2dIoHYAxoZPb311iCPVpexWCgCBEjXT60xsy/SfrAhC3KxUb
         QDm+5QxisuBPp7U6d//Vx6lktvhoAKptN00O4qwdO/oQiygdWZoAsE2mipV2l7Wd4Rkc
         YNI4nxLnGPQuiuaGheg32nOPaqDQkV6/khmJ68zNlTm9YP9C1rzmsmmJdnm9wcTHQXzz
         Ofuus4mkKT6kjERrk6owf2ZcKgMKWysQzoH1jHGT9eYzzd2q+T3uNyLXrP1tzQK9aYEt
         jYDbtkGfw/emO7jRr1eVNOoNUISVSL7Uzlgm8LQtaUxKFPrgpqsPdyKRIrXrKI32enFE
         c+MA==
X-Gm-Message-State: AGi0PuZfGPWIwQPiLO/AGOv8nnsigit/3XeD59vcJilgDEj5XOoWr341
        mbFKJg38hKjZL+Fyge3KEoEhWcSZ5tljeLGSPSc=
X-Google-Smtp-Source: APiQypKzpPamnAO06g21CAM18FQuJ4zAyl/GSvUXDhfKWGcUema4h82c62k8ni/2vZN2j8k1/CR6Kw6QcXZRuPodTaA=
X-Received: by 2002:a02:a90e:: with SMTP id n14mr1835735jam.97.1588934080300;
 Fri, 08 May 2020 03:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200507204913.18661-1-shakeelb@google.com>
In-Reply-To: <20200507204913.18661-1-shakeelb@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 8 May 2020 18:34:04 +0800
Message-ID: <CALOAHbAHK4b2p0oWXY6oHG+WQzK3+TEa46=dPabhYT8ab=65zA@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgsteal and pgscan
To:     Shakeel Butt <shakeelb@google.com>
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

On Fri, May 8, 2020 at 4:49 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> One way to measure the efficiency of memory reclaim is to look at the
> ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> not updated consistently at the system level and the ratio of these are
> not very meaningful. The pgsteal and pgscan are updated for only global
> reclaim while pgrefill gets updated for global as well as cgroup
> reclaim.
>

Hi Shakeel,

We always use pgscan and pgsteal for monitoring the system level
memory pressure, for example, by using sysstat(sar) or some other
monitor tools.
But with this change, these two counters include the memcg pressure as
well. It is not easy to know whether the pgscan and pgsteal are caused
by system level pressure or only some specific memcgs reaching their
memory limit.

How about adding  cgroup_reclaim() to pgrefill as well ?

> Please note that this difference is only for system level vmstats. The
> cgroup stats returned by memory.stat are actually consistent. The
> cgroup's pgsteal contains number of reclaimed pages for global as well
> as cgroup reclaim. So, one way to get the system level stats is to get
> these stats from root's memory.stat but root does not expose that
> interface. Also for !CONFIG_MEMCG machines /proc/vmstat is the only way
> to get these stats. So, make these stats consistent.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/vmscan.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cc555903a332..51f7d1efc912 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1943,8 +1943,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>         reclaim_stat->recent_scanned[file] += nr_taken;
>
>         item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> -       if (!cgroup_reclaim(sc))
> -               __count_vm_events(item, nr_scanned);
> +       __count_vm_events(item, nr_scanned);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
>         spin_unlock_irq(&pgdat->lru_lock);
>
> @@ -1957,8 +1956,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>         spin_lock_irq(&pgdat->lru_lock);
>
>         item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> -       if (!cgroup_reclaim(sc))
> -               __count_vm_events(item, nr_reclaimed);
> +       __count_vm_events(item, nr_reclaimed);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>         reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
>         reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
> --
> 2.26.2.526.g744177e7f7-goog
>
>


-- 
Thanks
Yafang
