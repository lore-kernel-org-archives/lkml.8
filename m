Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CD1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6893D207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7Zg9x+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgHTW43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgHTW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:56:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069D8C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:56:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id di22so2926321edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aim7ZV7VxtAqstOLObh/dmvDlBTIjwC/vQNJeLjw2SY=;
        b=k7Zg9x+tf+PmQarKuJnmu7Zwgp9XjnbEqKdxZSAL93vsY5Bc8y7XC5gDsRf7vb/nhr
         Yc9bO2RL1EHlua9v6qybcCDd+lQ3pFyHYAYMRarzK9QkiZhiLe1R177NiOHCG5W8hnA/
         6LJ12Q0oH/h1wF3qwUdFH5WsLLntlRwyXATzzGAFLeTiVHY7CT64faa1RLTC1xuCzTA3
         52mwyV0U8/ItJZky9BqT/HnoE23xX6P+Ehx8JL7HXYy//EBM+XYTf0oeNy43rhENuPts
         wgK8Q00uYl2ZichfLQEq24UuYAVdibEKlafnaSV+MuGczzV5SqQ4YkW52pReCZaW4PoG
         IWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aim7ZV7VxtAqstOLObh/dmvDlBTIjwC/vQNJeLjw2SY=;
        b=ap3sU64n3qsrCXyqFX5A3ev+ZrVbK0JtJsPQvqsLZhbPTuA2hsPTK+9xtr3mCT9JW4
         m1BBCYk3S2S66EJOgGnzfBTqcc4uHUSTphWaFbEw+EDyfH2IL9d4mnfmSMNyUSLx1QNY
         52cQRCilnHUtmEFKW1o9FXKLBwY+BF4EYnffvcLVYrGZQ3n2xkdyf4nuWejhuTmvxdSU
         IQtOBOr8vwonKIk5+a//sBbDw+rH4T+789iwi4z1+9mT4VaRJOXNuBVICr+iRkbDtzSp
         zHRSH44Nih3Dn5TmZgK4JiO/O7q2lSpkj/YAVw4JvuYi50qPkEaUnhQf6b98sxp2R7JH
         GWtQ==
X-Gm-Message-State: AOAM530V9KGJMJHJrHfSJqDEJjgy+9nyDWL0ogkomTgfa+rs2Jgg4ITY
        x3Mki6FX9Wv1iK7cV58BvR85TE60Q/EP916li8s=
X-Google-Smtp-Source: ABdhPJzq0HtqtlANNIeHA9f4OjwvT96Pj6Ads7F9L1lX5AbAw6f5cOiTX8WoQsmIp+9r5LDEX1isFWSicGgDbBIbt9E=
X-Received: by 2002:aa7:d9d0:: with SMTP id v16mr144465eds.137.1597964186662;
 Thu, 20 Aug 2020 15:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184133.DCF58B5F@viggo.jf.intel.com>
In-Reply-To: <20200818184133.DCF58B5F@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Aug 2020 15:56:15 -0700
Message-ID: <CAHbLzkowZgcXc9Oqcr0yr6X0TPmU5T55FLXJpV=5q+_NK8O4iQ@mail.gmail.com>
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

BTW we'd better add promotion counters as well. The NUMA balancing
could promote pages to local nodes without any modification. We could
argue it may be optimized for PMEM usecases, but it does work. And it
makes the patchset more self-contained.

You could refer to:
https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/

>
> [ daveh:
>    - __count_vm_events() a bit, and made them look at the THP
>      size directly rather than getting data from migrate_pages()
> ]
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
