Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D6C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E4620637
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRSRh7ZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgBZREs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:04:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37682 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgBZREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:04:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so102563otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWGLFPb2JDmIkjCUPJN84txliHWIiSJvGLA5caQAIDY=;
        b=pRSRh7ZOElvt8MZ/XbjZd2EjwBs38ZohNIN09f86phdUa0OSrWstsvCpmIYkIhAyjE
         vGSLpfV8w33qWriFyNQjb+wdCrNN1nBfLj3OMK04kdIWa8EmPnvWxPQ8wfV4EfkHdFCR
         irTFAQFPGvgt1+iYzPRy4bGwoZKQ2IVxsrmV/EJmz4bq3aHIR8cm4EQxolr1/lE8XKtO
         ayKD+XugXPZxJT0SJj5oX4AeSWwMgIo/JkN3xGiNiDxe25sIo7XsxvGvXhWW8+nswFyn
         NmdE3PV2TBfU7wMqz3QAJ8Nq0fwrja/FPGPKSXo6ltR/1JgMB4qcYCCP60KaUwQWCJqN
         Zcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWGLFPb2JDmIkjCUPJN84txliHWIiSJvGLA5caQAIDY=;
        b=hslpcj1jIIoni/28BUxY/lmUS2JNyCbhh1LaFvYk3Co7OUjFNIPyQHzK6DjmuBjglJ
         9IgnoXhRZB09gfUbjo+ytrqt3MtWQXbH1rEmT2xLO/Pv370qbZLsAdIseDOS+DJrIwOF
         lMJ79rR61jFraOVY3OV7GvIhos3GaZvmh4SRMXddZICLv7JCw3zjiPiw+2um7B5mcHqe
         sNjwzQk0QCo/tnZIwoxqRPYx3up30jv1PZkxeBtfaC25/DzzkSyTZ/EhUHcqqKDh4Yh5
         YRXaVbKmbLq0ME0No4ZGeHHaYaVlMhmyoFyOHct9ugNeKQw4Dbwl2gzrUhKGB/nc9xHC
         A6yg==
X-Gm-Message-State: APjAAAVuvMljGeXcJ2flbW5QkOchr4ZwKyHNw9XwzOw7D3ThSzp7eHHy
        VTIIuSWzGaVx+MdOLb6PQE5ByH/1MnWBEOgf1CJpiA==
X-Google-Smtp-Source: APXvYqxkotkHZJmj2vI4NdG74QtkRm4F+5ukci8HBKZyVQ5ld8N+4pLKqR2xKJbHGuJAhgVIWG1xHgI9V6Xvqsp3QDU=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr3927552otq.191.1582736685661;
 Wed, 26 Feb 2020 09:04:45 -0800 (PST)
MIME-Version: 1.0
References: <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain> <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain> <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain> <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain> <20200221080737.GK20509@dhcp22.suse.cz>
 <20200221210824.GA3605@sultan-book.localdomain> <20200225090945.GJ22443@dhcp22.suse.cz>
 <20200226105137.9088-1-hdanton@sina.com>
In-Reply-To: <20200226105137.9088-1-hdanton@sina.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Feb 2020 09:04:34 -0800
Message-ID: <CALvZod6aFgsT+z3f_dj7691p=-J3pB+BXMV1x-uHXJWRFVr0gQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 4:15 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Tue, 25 Feb 2020 14:30:03 -0800 Shakeel Butt wrote:
> >
> > BTW we are seeing a similar situation in our production environment.
> > We have swappiness=0, no swap from kswapd (because we don't swapout on
> > pressure, only on cold age) and too few file pages, the kswapd goes
> > crazy on shrink_slab and spends 100% cpu on it.
>
> Dunno if swappiness is able to put peace on your kswapd.
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2631,8 +2631,14 @@ static inline bool should_continue_recla
>          */
>         pages_for_compaction = compact_gap(sc->order);
>         inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
> -       if (get_nr_swap_pages() > 0)
> -               inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
> +       do {
> +               struct lruvec *lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
> +               struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +               int swappiness = mem_cgroup_swappiness(memcg);
> +
> +               if (swappiness && get_nr_swap_pages() > 0)

Thanks for finding this. I think we also need to check sc->may_swap as
well. Can you please send a signed-off patch? It may or maynot help
kswapd but I think this is needed.

> +                       inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
> +       } while (0);
>
>         return inactive_lru_pages > pages_for_compaction;
>  }
>
