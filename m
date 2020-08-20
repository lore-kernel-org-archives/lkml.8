Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C701120674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJPIJwYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgHTX6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTX6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:58:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE8C061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:58:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g19so251923ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ltcYHArLoQsXGDP1rWIfO3JC1jU/kmH+fninhb3r4g=;
        b=SJPIJwYZjsRJxH4Pn77CD1kcgeTKqIBrjfgQVHsEaGWg83JrJ/HTxJ0gS716H9ovsf
         /deLlRPB51HyyaPivrGC3anTMg9qz3/tbTtxF8rjrpRjBiYlt4yFDYpW+WlfvOIJHyOO
         rG+lOQ95fkHxVLr2dVbh9HD76wBiGfZKXa0xfRrGXRc6itTcMFGXsvHhTj2chFwfjTyL
         Lay4jQW0LmR0ISZsJgjWgWuU94A6cov9c7/E76MEUoVy/UZth0T0hbPx//waWSaTm1mp
         ZWwBzGwViIIT3OChKsRLirQn5MyczBcGTeNp66+lBCbqcM63lcfID2KeqyB6AK71IM4o
         jWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ltcYHArLoQsXGDP1rWIfO3JC1jU/kmH+fninhb3r4g=;
        b=VdUO63yzqFyXlkn7FYCG+QTriO44S7IkCXVzLBXz7+kvB+dotGF8oDosEmcxSfVy2g
         4fmliWlZeC3dqCHiKpw5OeXYQu5Gef1kqseYDA4IVbyBaBID1kMD9mhDs+EBmrl7BWw4
         CMhMyQ8XW9ZwcLp/z50yklnKpKfvw+Sr+6DVqWcCq4LNQB6gh2JosAEQstdYERNgJ8D/
         NbscDflcbhykLKWP6sLCSf3JHWr24KWFPROOnQWJm4+NoqEyOOVA2Mb4mCoPrwrU+s1C
         Y3GV6leM7VEnKwDH+6N0M2XHqiR6pFTYoG7KWnm8GKvgXXIURrxepCL12M4lbeJs8GYl
         Zzjg==
X-Gm-Message-State: AOAM530AagDYcI5DPLE/ZD+9a510q2Y7+YzF+ZsLFYD0yShW6LsKnTk1
        nx3U2uAK3612h+aTG38WYo4fSu3+3SFYegB8els=
X-Google-Smtp-Source: ABdhPJygQxAD9qVjNupDU9Kr1vqIEkpfD/cXfrhzy23tM7H2GrHaBRFPSCPF6djU8jDGjzviojaxKjo/Z1momWXrysU=
X-Received: by 2002:a17:906:c2c8:: with SMTP id ch8mr331592ejb.161.1597967914213;
 Thu, 20 Aug 2020 16:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184133.DCF58B5F@viggo.jf.intel.com>
 <CAHbLzkr9e=hsT-Fw14cwmBoK7p=GsbzAmVqo6HFCFRXz6sa0iw@mail.gmail.com>
In-Reply-To: <CAHbLzkr9e=hsT-Fw14cwmBoK7p=GsbzAmVqo6HFCFRXz6sa0iw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Aug 2020 16:58:22 -0700
Message-ID: <CAHbLzkpHwbUTnmLvK17mzRGR3DSjiXVEVbz9YLQb5CoEbmMDsw@mail.gmail.com>
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

On Thu, Aug 20, 2020 at 3:26 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Aug 18, 2020 at 11:53 AM Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
> >
> >
> > From: Yang Shi <yang.shi@linux.alibaba.com>
> >
> > Account the number of demoted pages into reclaim_state->nr_demoted.
> >
> > Add pgdemote_kswapd and pgdemote_direct VM counters showed in
> > /proc/vmstat.
> >
> > [ daveh:
> >    - __count_vm_events() a bit, and made them look at the THP
> >      size directly rather than getting data from migrate_pages()
> > ]
>
> This reminds me that we'd better to make migrate_pages() return the
> number of base pages. Now both nr_failed and nr_succeeded is inc'ed
> regardless of whether it is THP.
>
> A quick look finds the callers of migrate_pages() seem not care about
> the exact returned number, they just care if it is positive or not.
>
> And reclaim code depends on correct nr_succeeded to avoid over reclaim.
>
> I will come up with a patch to post to the mailing list.

I looks this problem has been fixed by commit
1a5bae25e3cf95c4e83a97f87a6b5280d9acbb22 ("mm/vmstat: add events for
THP migration without split") in v5.9-rc1. With that commit,
nr_succeeded will be bumped by 512 if a THP is migrated successfully
(without split). So, we don't need worry about this anymore.

>
> >
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > ---
> >
> >  b/include/linux/vm_event_item.h |    2 ++
> >  b/mm/vmscan.c                   |    6 ++++++
> >  b/mm/vmstat.c                   |    2 ++
> >  3 files changed, 10 insertions(+)
> >
> > diff -puN include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter include/linux/vm_event_item.h
> > --- a/include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter 2020-08-18 11:36:54.062583176 -0700
> > +++ b/include/linux/vm_event_item.h     2020-08-18 11:36:54.070583176 -0700
> > @@ -32,6 +32,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
> >                 PGREFILL,
> >                 PGSTEAL_KSWAPD,
> >                 PGSTEAL_DIRECT,
> > +               PGDEMOTE_KSWAPD,
> > +               PGDEMOTE_DIRECT,
> >                 PGSCAN_KSWAPD,
> >                 PGSCAN_DIRECT,
> >                 PGSCAN_DIRECT_THROTTLE,
> > diff -puN mm/vmscan.c~mm-vmscan-add-page-demotion-counter mm/vmscan.c
> > --- a/mm/vmscan.c~mm-vmscan-add-page-demotion-counter   2020-08-18 11:36:54.064583176 -0700
> > +++ b/mm/vmscan.c       2020-08-18 11:36:54.072583176 -0700
> > @@ -147,6 +147,7 @@ struct scan_control {
> >                 unsigned int immediate;
> >                 unsigned int file_taken;
> >                 unsigned int taken;
> > +               unsigned int demoted;
> >         } nr;
> >
> >         /* for recording the reclaimed slab by now */
> > @@ -1146,6 +1147,11 @@ static unsigned int demote_page_list(str
> >                 list_splice(ret_list, demote_pages);
> >         }
> >
> > +       if (current_is_kswapd())
> > +               __count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
> > +       else
> > +               __count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
> > +
> >         return nr_succeeded;
> >  }
> >
> > diff -puN mm/vmstat.c~mm-vmscan-add-page-demotion-counter mm/vmstat.c
> > --- a/mm/vmstat.c~mm-vmscan-add-page-demotion-counter   2020-08-18 11:36:54.067583176 -0700
> > +++ b/mm/vmstat.c       2020-08-18 11:36:54.072583176 -0700
> > @@ -1200,6 +1200,8 @@ const char * const vmstat_text[] = {
> >         "pgrefill",
> >         "pgsteal_kswapd",
> >         "pgsteal_direct",
> > +       "pgdemote_kswapd",
> > +       "pgdemote_direct",
> >         "pgscan_kswapd",
> >         "pgscan_direct",
> >         "pgscan_direct_throttle",
> > _
