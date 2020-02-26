Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A761AC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBD121556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbYSTEbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgBZRBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:01:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43089 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgBZRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:01:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so50039oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VW6ry/recRSjstAhgd9IHAJ1qGHrxOyE270eFkPmjt8=;
        b=TbYSTEbY9mx/BwJIJncwOFE8193J4bVFp3qh+YNX4sdKcBgDkwafsfcr8X7VOODEFc
         9Q3yDkALDFXoJKC9xKw4SIla3ILAM2kV8T+MH+EI16bIq1jvfQGwh4cbeKvGdL1jb3CO
         wH65vfwFskDDttPYABVm2zrRdc0vQorfws3lKOJHBqNjyzzKs2D9j0kTrqV3+Z5fHwpu
         88L4l7ozO7v/bI8I4y8QTlSG7LoMC20cvVt/wJN9HFEKnT3su7BSulkHHFcMR9PdeGe/
         i0V6obuHVl9Rc+9vz3E/392JlxgkVhBp3L+HjHw9zkQUdZtRnO8V8jNqn/tFrM5VdMoF
         /MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VW6ry/recRSjstAhgd9IHAJ1qGHrxOyE270eFkPmjt8=;
        b=fhArWRYcRNlyw4ZfD0lgobxIdSrvlRfgsorE7LxySxOrwh87GdFJRRQJCHBucd0ArY
         xvfcALS8JTXelitIaOzHH0eFEMB8jlTVqRPkNH+1Nfjwd6lromluT1GmmMvydwXZOZZt
         ayYJGQLckd8m3RAu3BhPu/WP1jOW1FGq9XV5aNmL2uUrytohFeoEp5Bpn4g5uez8ENbu
         SD1dU7vHUeS53WQEK6IfoeIRwiUSyhi/9KXkshVIcMhbMzNuvGFy/XDaKkci5Q8NSl3X
         uaeO0J5GpyUz4bf25tyGFVu9W+WXPFUU+FG1+18eg4gj8jJ2ei6DDEK/X+GyQ1X6LNgd
         cq2Q==
X-Gm-Message-State: APjAAAWTkC8qUhtVVK3YMoVo/xWmUD2b7BqC2jJj4ap40zqADVslBoaA
        93l81M0C3r4IFRlYPyhB8mhiaNVyCC+KfeRLOJ+0KUiBac8=
X-Google-Smtp-Source: APXvYqyQ+ukFeXhC1ZBScIcKYTArHmQ2QAiHWx3w0xFtCsEyxl99sghYoMMgfj29M7ZBXEOa9SOWnnBpf1sxl2Kzmrw=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr3658219otq.124.1582736469964;
 Wed, 26 Feb 2020 09:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20200219200527.GF11847@dhcp22.suse.cz> <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de> <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de> <20200221042232.GA2197@sultan-book.localdomain>
 <20200221080737.GK20509@dhcp22.suse.cz> <20200221210824.GA3605@sultan-book.localdomain>
 <20200225090945.GJ22443@dhcp22.suse.cz> <CALvZod6MW62-+nEw-d0jKxFK9mspOY_tt2JRTDYOrOVyM9_QHw@mail.gmail.com>
 <20200226090853.GC3771@dhcp22.suse.cz>
In-Reply-To: <20200226090853.GC3771@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Feb 2020 09:00:57 -0800
Message-ID: <CALvZod7BDcHTNY1-yc041nZnKHR2Wo0R-=QXAOYOUEPeyQG4DA@mail.gmail.com>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 1:08 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 25-02-20 14:30:03, Shakeel Butt wrote:
> > On Tue, Feb 25, 2020 at 1:10 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > [snip]
> > >
> > > The proper fix should, however, check the amount of reclaimable pages
> > > and back off if they cannot meet the target IMO. We cannot rely on the
> > > general reclaimability here because that could really be thrashing.
> > >
> >
> > "check the amount of reclaimable pages" vs "cannot rely on the general
> > reclaimability"? Can you clarify?
>
> kswapd targets the high watermark and if your reclaimable memory (aka
> zone_reclaimable_pages) is lower than the high wmark then it cannot
> simply satisfy that target, right? Keeping reclaim in that situations
> seems counter productive to me because you keep evicting pages that
> might be reused without any feedback mechanism on the actual usage.
> Please see my other reply.
>

I understand and agree with the argument that if reclaimable pages are
less than high wmark then no need to reclaim. Regarding not depending
on general reclaimability, I thought you meant that even if
reclaimable pages are over high wmark, we might not want to continue
the reclaim to not cause thrashing. Is that right?

> > BTW we are seeing a similar situation in our production environment.
> > We have swappiness=0, no swap from kswapd (because we don't swapout on
> > pressure, only on cold age) and too few file pages, the kswapd goes
> > crazy on shrink_slab and spends 100% cpu on it.
>
> I am not sure this is the same problem. It seems that the slab shrinkers
> are not really a bottle neck here. I would recommend you to identify
> which shrinkers are eating the cpu time in your case.
>

The perf profile shows that the kswapd is spending almost all its time
in list_lru_count_one and memcg tree traversal. So, it's not just one
shrinker.

Yes, it's not exactly the same problem but I would say it is similar.
For Sultan's issue, even if there are many reclaimable pages, we don't
want to thrash. In this issue, thrashing is not happening but kswapd
is going nuts on slab shrinkers.

Shakeel
