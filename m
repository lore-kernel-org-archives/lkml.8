Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78F0C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FEF20753
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESQp9csY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgCSEBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 00:01:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46859 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgCSEBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 00:01:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id f28so1091924qkk.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 21:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=olaDQ7NlhWJr6NAH6yj+Y1cZnBeT1uBNBs+/2Gulbqg=;
        b=ESQp9csYDRssnztKNkHZNO+i25NosXpZkicdp+ClRgLbxlqYwJmSo+os5sjAPJQDIr
         AnUes+FTiL1v8o0rf+4t9PC0brh7oBwqAJtmXyXu/EKKUZBgoTbo/FOx/yTQ8bdCOEK6
         /zTap4MMVXPkYCfd6aMrLxTT9+72D7c0fUMbPfP/q3IamFWwnsQl8aGQ74mMTDdMxu39
         gTDre0JjMRFBPem7q05aQ+G7fXAJlyG7TGwdQBE6V//XKqda6M36JD+puBknKwnmNyyr
         b3R1Wo6u8SJMGuWTtBPot91oAJYXWFJIOAtZXMCL5vXQKPogoh+vBvgO+h71rlC/7uVj
         XA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=olaDQ7NlhWJr6NAH6yj+Y1cZnBeT1uBNBs+/2Gulbqg=;
        b=VebMwHEJ/03L8Ff5rqteXe6/FMWksEM+jw8N8iKLV6ebPhzYVYU60LpUaN1emEVCYP
         1QmNYnLV+B8syUWh8+09P1qUm1GxZ81AEdJ7chkiNUSmA2q+O3EwNKbzCU6CV/n10rzw
         Zj/UjoarvBkRDqGNPZkW4JGRBDSrRcwQESiO6R2dAYfhVj1tYKrODnLoC9HfOLbIUmtu
         x1M2lKUyNKLaYUFBkfvsu9MFR/RcDl+orYQO0CnBlxpIrBFW2nhh0wOmmHjlQqViSo3U
         M7+3s1YtWmTYJkZ415r21VvFXqCOZ+oOKNqK3ihxExOldzGAYYQ1GBc+NGks1jn+yDH/
         AijA==
X-Gm-Message-State: ANhLgQ1RFSKSsdLaaMgt1sHwujVGwU0hmGKcOnK62UTxjpKxrtcTVb1a
        ++YqvGxuB9tpUXVYoCCtFnC3/bWKgNdQpSm3n08=
X-Google-Smtp-Source: ADFU+vthEQFRF9nzE7lIP/Q0aqp84cLBK7a6eUpv7WfAOx1zEIHx9K46N6bzONy+obrlmPh1AkpbMSjvuJWY3nGoYkI=
X-Received: by 2002:a37:b4c1:: with SMTP id d184mr1190119qkf.452.1584590495495;
 Wed, 18 Mar 2020 21:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-3-git-send-email-iamjoonsoo.kim@lge.com> <20200318175155.GB154135@cmpxchg.org>
In-Reply-To: <20200318175155.GB154135@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 19 Mar 2020 13:01:24 +0900
Message-ID: <CAAmzW4NE30PX27K55o_5kZuXsqM6jTeshd0tEzq+BLRK5kxJXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] mm/vmscan: protect the workingset on anonymous LRU
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

2020=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2:52, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Mar 17, 2020 at 02:41:50PM +0900, js1304@gmail.com wrote:
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
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> > -void lru_cache_add_active_or_unevictable(struct page *page,
> > +void lru_cache_add_inactive_or_unevictable(struct page *page,
> >                                        struct vm_area_struct *vma)
> >  {
> > +     bool evictable;
> > +
> >       VM_BUG_ON_PAGE(PageLRU(page), page);
> >
> > -     if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) !=3D VM_LOC=
KED))
> > -             SetPageActive(page);
> > -     else if (!TestSetPageMlocked(page)) {
> > +     evictable =3D (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) !=3D VM_=
LOCKED;
> > +     if (!evictable && !TestSetPageMlocked(page)) {
>
> Minor point, but in case there is a v4: `unevictable` instead of
> !evictable would be a bit easier to read, match the function name,
> PageUnevictable etc.

Okay. Looks like v4 is needed so I will change it as you said.

Thanks.
