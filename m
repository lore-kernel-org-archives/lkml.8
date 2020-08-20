Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD14C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C12207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAIB2L0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHTW0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgHTW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:26:17 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45704C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:26:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so2883247edv.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhRf5j3vdObD26X1swOWaXMxZZjJcjsvsmxQNBB1Tsk=;
        b=TAIB2L0yZvDqSwHwg7yrRZsEp0JutwTv7HDFn4IA6Ps261QLkYKlrp9BJdJxvbJ42X
         +/gKblFfOdLk6rr7cOsg+tUvV3jwjLPOOIF2D8/ASgdHBaIkSzBF03Gv+5yfRlZsnx1e
         gv5JYwgmBt88FPfLIMKSLCgN85oZk6Ko/+Y7/p+Tlk52crUCekeY+LvdZh48WlZsz2K+
         JNxEOfA3hcrGElMcLq5UydT79/YmzyA/lfAHFBVSqQkw5oMnWlsnh6H7WzUbopodrByR
         4KdvuPdfx3A6KhGnCXjcKMdCf4C8+cPz8YdsF6H2mOxPTVhAxfrCqrP/PxBcKF8Y+1JL
         cAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhRf5j3vdObD26X1swOWaXMxZZjJcjsvsmxQNBB1Tsk=;
        b=n6mClKu+Fx7ySYss1tU/Ly7cWJHNNl2bJctyrRLScAIO29j/cFaP2XnRzAcG+y4dS7
         ZtsF9S7Y41HBzsPxbExwPExQy+H6UUatJBo/mVQvh9lWp9Og1hIS6ETI3ATw/nnCiOxw
         sXp9rX5q4WY29wyR2xSM01JHouVH4xdOLVmxPOegMUPp3hwTv08r5Iy6qTmn0Iy8TYql
         aDGGykuQycflmsxC5nDZfVu/Dn+qMcClT7RmLCb77nuOMYyra35m7gtpW/1cK4MU0x2/
         HkEQsL9pbCGtcWcuG2JGMqSVMVm6cKIWG9N8YOKNz/FWdAhMHSbjDsjhezJIzU++/314
         pLGQ==
X-Gm-Message-State: AOAM531fC7N0BmN0gfntynxYT98jVKOpSht+4kuQvrlTvKWrCDx2fQv6
        tGgpQPUiDuEtTnKJu7zkvnukJLEp3xPxlldAbGakYWTezZ8=
X-Google-Smtp-Source: ABdhPJyW3Km6Y645JwYgI1WkycEMm6hwqcpSf6ZjHm2OthkhiefcI4IHZ07aumd0ZLsE2wpJAXobLSBM5vZJDSmXF28=
X-Received: by 2002:a05:6402:1c10:: with SMTP id ck16mr51358edb.151.1597962374944;
 Thu, 20 Aug 2020 15:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184133.DCF58B5F@viggo.jf.intel.com>
In-Reply-To: <20200818184133.DCF58B5F@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Aug 2020 15:26:02 -0700
Message-ID: <CAHbLzkr9e=hsT-Fw14cwmBoK7p=GsbzAmVqo6HFCFRXz6sa0iw@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/9] mm/vmscan: add page demotion counter
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:53 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
>
> From: Yang Shi <yang.shi@linux.alibaba.com>
>
> Account the number of demoted pages into reclaim_state->nr_demoted.
>
> Add pgdemote_kswapd and pgdemote_direct VM counters showed in
> /proc/vmstat.
>
> [ daveh:
>    - __count_vm_events() a bit, and made them look at the THP
>      size directly rather than getting data from migrate_pages()
> ]

This reminds me that we'd better to make migrate_pages() return the
number of base pages. Now both nr_failed and nr_succeeded is inc'ed
regardless of whether it is THP.

A quick look finds the callers of migrate_pages() seem not care about
the exact returned number, they just care if it is positive or not.

And reclaim code depends on correct nr_succeeded to avoid over reclaim.

I will come up with a patch to post to the mailing list.

>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>
>  b/include/linux/vm_event_item.h |    2 ++
>  b/mm/vmscan.c                   |    6 ++++++
>  b/mm/vmstat.c                   |    2 ++
>  3 files changed, 10 insertions(+)
>
> diff -puN include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter include/linux/vm_event_item.h
> --- a/include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter 2020-08-18 11:36:54.062583176 -0700
> +++ b/include/linux/vm_event_item.h     2020-08-18 11:36:54.070583176 -0700
> @@ -32,6 +32,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
>                 PGREFILL,
>                 PGSTEAL_KSWAPD,
>                 PGSTEAL_DIRECT,
> +               PGDEMOTE_KSWAPD,
> +               PGDEMOTE_DIRECT,
>                 PGSCAN_KSWAPD,
>                 PGSCAN_DIRECT,
>                 PGSCAN_DIRECT_THROTTLE,
> diff -puN mm/vmscan.c~mm-vmscan-add-page-demotion-counter mm/vmscan.c
> --- a/mm/vmscan.c~mm-vmscan-add-page-demotion-counter   2020-08-18 11:36:54.064583176 -0700
> +++ b/mm/vmscan.c       2020-08-18 11:36:54.072583176 -0700
> @@ -147,6 +147,7 @@ struct scan_control {
>                 unsigned int immediate;
>                 unsigned int file_taken;
>                 unsigned int taken;
> +               unsigned int demoted;
>         } nr;
>
>         /* for recording the reclaimed slab by now */
> @@ -1146,6 +1147,11 @@ static unsigned int demote_page_list(str
>                 list_splice(ret_list, demote_pages);
>         }
>
> +       if (current_is_kswapd())
> +               __count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
> +       else
> +               __count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
> +
>         return nr_succeeded;
>  }
>
> diff -puN mm/vmstat.c~mm-vmscan-add-page-demotion-counter mm/vmstat.c
> --- a/mm/vmstat.c~mm-vmscan-add-page-demotion-counter   2020-08-18 11:36:54.067583176 -0700
> +++ b/mm/vmstat.c       2020-08-18 11:36:54.072583176 -0700
> @@ -1200,6 +1200,8 @@ const char * const vmstat_text[] = {
>         "pgrefill",
>         "pgsteal_kswapd",
>         "pgsteal_direct",
> +       "pgdemote_kswapd",
> +       "pgdemote_direct",
>         "pgscan_kswapd",
>         "pgscan_direct",
>         "pgscan_direct_throttle",
> _
