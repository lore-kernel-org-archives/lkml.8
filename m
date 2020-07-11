Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C977C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E322078B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7P0dNpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgGKBzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgGKBzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:55:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DAFC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:55:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i4so7952016iov.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHI4iXtmX01yNpRFDCOqzvlBSYR9wvdFvILVM3jzt4w=;
        b=M7P0dNpcggbgMq8M3ZUKrRzfuzHd/DzMtIcX7NdMEr00hAR/QZ8gt5RoDEUgT1yOxK
         px4ROFrpvTlpcSBMIMFpfZzmLQxIPjab+7WvXPLMWWZzjghjraS92SqCf6bTARF55h6F
         6lUI+pieHU7pOZjluSZcZ0NCsGMSZ3qjzBpM/dfPFHQB6JBGG3pG9g57SsnS+xx017up
         OVdNzDD6+oFnkmXyclJYkItOLkzZlfybaEfvA7vnpYcFQ3AJalyhdgL0F2aDpZGwDrwM
         NQIU+H9g9Y5ufClFM/5bwUhV9ABYhzjWAOJwqtxpZx46WosAw1d6pqlhBRkAkmsGYCXB
         27LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHI4iXtmX01yNpRFDCOqzvlBSYR9wvdFvILVM3jzt4w=;
        b=AoE8+8y7URKR1LvCzHtwchRFOiwDS7Xd98ekpaXEifGziGhXSAgUMWbFTmF45QYGcI
         zFjKuUye5yER5stqL0LFUjZOqf6qUgZzWGKY0sYycRrBB8RAVtE5QkRMcgvGl+L3k4SO
         5/G8E6V9H8RVOOiqkzt7dNRaY/PEtYgkAU57zCG9DG4AZk1GhX52hqogN6I1ZhdfIE5M
         SRqOPLmcBLoWQ9X3Pz/s++Bkjbz00rCe+b6V2/IJvzJAC70pM8HM/ghdEyLkswbral05
         8PI7sAd7t44U8tx6GpRMGF1h9rjJhxGnEA/cLvwRBkh+1T24X+YTda8fpxUgET9Up3Es
         m/dg==
X-Gm-Message-State: AOAM533SFHH6mdPw4bW45fZrxH53WodOzXix/bFUBIQc3GDYrvRbAexd
        qjneam6j/uFY3AEqJHf+OC+qHQEWWdVg+fIKffs=
X-Google-Smtp-Source: ABdhPJz6XuX2EPyiuy7Eq7m/T1DuQ4iZ2Gio4juwxIYfQIGYc6DsjbM7fcsqWQUrfO4N3DLRieTnx6j+OPbH0z0oIk4=
X-Received: by 2002:a5d:9752:: with SMTP id c18mr26549080ioo.10.1594432504271;
 Fri, 10 Jul 2020 18:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200711011459.1159929-1-shakeelb@google.com>
In-Reply-To: <20200711011459.1159929-1-shakeelb@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 11 Jul 2020 09:54:28 +0800
Message-ID: <CALOAHbDWA2p_FhFHf227ie8djuY3ugkDsQq+v20BAUoJdXiH6Q@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgrefill
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 9:15 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> The vmstat pgrefill is useful together with pgscan and pgsteal stats to
> measure the reclaim efficiency. However vmstat's pgrefill is not updated
> consistently at system level. It gets updated for both global and memcg
> reclaim however pgscan and pgsteal are updated for only global reclaim.
> So, update pgrefill only for global reclaim. If someone is interested in
> the stats representing both system level as well as memcg level reclaim,
> then consult the root memcg's memory.stat instead of /proc/vmstat.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  mm/vmscan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5215840ee217..4167b0cc1784 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2030,7 +2030,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
>
>         __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
>
> -       __count_vm_events(PGREFILL, nr_scanned);
> +       if (!cgroup_reclaim(sc))
> +               __count_vm_events(PGREFILL, nr_scanned);
>         __count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
>
>         spin_unlock_irq(&pgdat->lru_lock);
> --
> 2.27.0.383.g050319c2ae-goog
>


-- 
Thanks
Yafang
