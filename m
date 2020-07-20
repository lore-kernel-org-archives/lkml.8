Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B868C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E92122CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrN7FoGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGTGxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgGTGxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:53:37 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40FC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:53:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so12164502qtm.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qs1cbe46cVElxY/Q1LwL0+3SEDSLDhjdnDiZLYzmQpA=;
        b=nrN7FoGzPXdOvPS9oQHCkzTRZBHfDINd8EiU7EJWQAFx5dMLj9u7Jn+l4kYZAXu4L6
         St7Eqt99nOCXDyBDLkimje1F8ZSm8HOAYuMVYErEbqmplEgZ9xnbXasKoalX9aT2gj9F
         8HmdL3JokxG6oVre95PYVkqcX2IDJKBQGgkCZorlrTlGsw8nqbTUvJTeJrLPgsXWNWYU
         1AJvJZc7YL0ogUpZkUZTV0/5XTG1L2aecZIVATHWLm/eq3diJehH3K2/YlfpVjJFd3gG
         tZss3RqjweUp5sTzc/NQgqmigoghvmkcl3d5bTHsjci+fl+Hpzm2s/j6PXs2bDP3MQyw
         aC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qs1cbe46cVElxY/Q1LwL0+3SEDSLDhjdnDiZLYzmQpA=;
        b=OQqFQEHt1K+BI2hu9d+wDjDwYjZbf+bZTZZmSTyxtnRuKd5aCxvh80S00ussp7G6kJ
         zQyLzOTQb5rl5DmdnhIQIx+NYlhCb0kTV/Yaz6j+oJRbnm5B8o6XYfXQyaOH/ved4q0S
         +5dpyNdYLuK68xJKOAPi5zNVa7DysNcAuMUIbrP8LkwHN2Y1VltfQdEE1qu8Nf57F7Ub
         di95csbnUaqZB7cmfvWnrZJmSks4pgov/ovn3m/dOYfUAN8Ztlvm6xE0CYSEHbOX6GUc
         4NruI1XnfSSSWGaKAb72cPbCn6ALGQFZfSIq0T5iP1XN0/CjF3AoV9v+0/TlqUjpjJDf
         ying==
X-Gm-Message-State: AOAM5336Yh2a1FudMvxDgUt3vZo+JSII6b41ZY8APt4eIgyU7HALx+B8
        790FS6H3qO97MegD1RAywpysXuxWBr3gW/PeZzc=
X-Google-Smtp-Source: ABdhPJxGi5zxL6JpDFNy9iMtWweFL0iBl8jt/EO1VPcigijc5OZQPs3jZrBbRSx8iMGl+Jkxr2awoUISlyE59SAEl5k=
X-Received: by 2002:ac8:7b23:: with SMTP id l3mr22698974qtu.65.1595228016399;
 Sun, 19 Jul 2020 23:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-3-git-send-email-iamjoonsoo.kim@lge.com> <20200717135849.GA265107@cmpxchg.org>
In-Reply-To: <20200717135849.GA265107@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 20 Jul 2020 15:53:25 +0900
Message-ID: <CAAmzW4OeCdcAnj2yUJWw_XuC8eVBF-wWjA+7vJ3J1Oju68kfJA@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mm/vmscan: protect the workingset on anonymous LRU
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 17=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10:59, =
Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Jun 17, 2020 at 02:26:19PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > In current implementation, newly created or swap-in anonymous page
> > is started on active list. Growing active list results in rebalancing
> > active/inactive list so old pages on active list are demoted to inactiv=
e
> > list. Hence, the page on active list isn't protected at all.
> >
> > Following is an example of this situation.
> >
> > Assume that 50 hot pages on active list. Numbers denote the number of
> > pages on active/inactive list (active | inactive).
> >
> > 1. 50 hot pages on active list
> > 50(h) | 0
> >
> > 2. workload: 50 newly created (used-once) pages
> > 50(uo) | 50(h)
> >
> > 3. workload: another 50 newly created (used-once) pages
> > 50(uo) | 50(uo), swap-out 50(h)
> >
> > This patch tries to fix this issue.
> > Like as file LRU, newly created or swap-in anonymous pages will be
> > inserted to the inactive list. They are promoted to active list if
> > enough reference happens. This simple modification changes the above
> > example as following.
> >
> > 1. 50 hot pages on active list
> > 50(h) | 0
> >
> > 2. workload: 50 newly created (used-once) pages
> > 50(h) | 50(uo)
> >
> > 3. workload: another 50 newly created (used-once) pages
> > 50(h) | 50(uo), swap-out 50(uo)
> >
> > As you can see, hot pages on active list would be protected.
> >
> > Note that, this implementation has a drawback that the page cannot
> > be promoted and will be swapped-out if re-access interval is greater th=
an
> > the size of inactive list but less than the size of total(active+inacti=
ve).
> > To solve this potential issue, following patch will apply workingset
> > detection that is applied to file LRU some day before.
> >
> > v6: Before this patch, all anon pages (inactive + active) are considere=
d
> > as workingset. However, with this patch, only active pages are consider=
ed
> > as workingset. So, file refault formula which uses the number of all
> > anon pages is changed to use only the number of active anon pages.
>
> I can see that also from the code, but it doesn't explain why.
>
> And I'm not sure this is correct. I can see two problems with it.
>
> After your patch series, there is still one difference between anon
> and file: cache trim mode. If the "use-once" anon dominate most of
> memory and you have a small set of heavily thrashing files, it would
> not get recognized. File refaults *have* to compare their distance to
> the *entire* anon set, or we could get trapped in cache trimming mode
> even as file pages with access frequencies <=3D RAM are thrashing.
>
> On the anon side, there is no cache trimming mode. But even if we're
> not in cache trimming mode and active file is already being reclaimed,
> we have to recognize thrashing on the anon side when reuse frequencies
> are within available RAM. Otherwise we treat an inactive file that is
> not being reused as having the same value as an anon page that is
> being reused. And then we may reclaim file and anon at the same rate
> even as anon is thrashing and file is not. That's not right.
>
> We need to activate everything with a reuse frequency <=3D RAM. Reuse
> frequency is refault distance plus size of the inactive list the page
> was on. This means anon distances should be compared to active anon +
> inactive file + active file, and file distances should be compared to
> active file + inactive_anon + active anon.

You're right. Maybe, I'm confused about something at that time. I will chan=
ge
it as you suggested.

Thanks.
