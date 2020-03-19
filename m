Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E68FC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A442072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/OjG0aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCSIb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:31:56 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43464 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:31:56 -0400
Received: by mail-qv1-f68.google.com with SMTP id c28so544723qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0hH/8ZvXQv+Mfjqbb5U9DwxAPHLEKJbYdC6hBHVijbk=;
        b=O/OjG0aZGy9yhc1+2BMb27k6RQk2H0/k26Ns7y1G3IFc6qr4OIEx5piUhcRJD2rrPj
         JLSsocLIQqmFxF54te+uwug86NBcBvub9X2UfmlhWFqDQVw95MuNkzvPIBu4a2aCX/c4
         dlN422LAV9iN812kP8M+XPow4V6+xhnacsrgYj/ujY1vu/lOVmWNVTDWBcN4HeB0k77k
         mq4wajr830ub2bBwNBgHgl87GdRjap86D0xoYm3HNXGavHg1fXOR4EwiKMU2PL0CCJ8i
         N518pbqhpIXrRaVAYmz+pJLJE4jrq77v++MEc2DZxRQciS0FSYV4gHj7qojBGVOYDOAV
         L9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0hH/8ZvXQv+Mfjqbb5U9DwxAPHLEKJbYdC6hBHVijbk=;
        b=XzhOIRSTEcvJYA5UHatr1XC+9LKgmxmXJAwLr4YxDou6s2HpImJ+cEzMaxH3V0kdTe
         CLBhSC63aDQrt8VzVqc6Q6EMD6mfcNwOzWe9D6H9EIGblq4tIlwBit5Y1xWuaLMb7m+W
         JO2SQHEmaXOgecgsfFCQIXJP5qliK9mxGdkNipHP6gDzcDYcITPGZUQ+eq/wPnrSfzhe
         fWb1+U6yJsVDSQCSEocktdHuIhY9RITgiRZT9bYGaXFES6MVHrEuAMfdTLLWfiMxIUzc
         k9kFEIjgxCogPeHf6CYKYSNiNO5MFLcfSV94YZrJmpIdjyxG03QSC9m9ANQM1VVARNlV
         FUlQ==
X-Gm-Message-State: ANhLgQ1zCkIa/bz3VXfOPm8R42b9OTrzR49YKEQDS+8t8J3KWcapa6KW
        Ylz+VTWgWNUHb6CoLatyfWcTb0lezSujws9W9yI=
X-Google-Smtp-Source: ADFU+vvuRpn8VDUE6NrbjQLgwjoXTyQY98piTROb9Kh6G6elugJxnjNozpur/smZvr97PrgmTTVHwhR39cngLVVQSOM=
X-Received: by 2002:a05:6214:11f4:: with SMTP id e20mr1862550qvu.66.1584606715035;
 Thu, 19 Mar 2020 01:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-7-git-send-email-iamjoonsoo.kim@lge.com> <20200318195911.GF154135@cmpxchg.org>
In-Reply-To: <20200318195911.GF154135@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 19 Mar 2020 17:31:44 +0900
Message-ID: <CAAmzW4MBQP56=RNxUfKYJ10WAEp-m2bKhC-WVVF8Nt6PZ+JuJw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] mm/workingset: handle the page without memcg
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

2020=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:59, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Mar 17, 2020 at 02:41:54PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > When implementing workingset detection for anonymous page, I found
> > some swapcache pages with NULL memcg. From the code reading, I found
> > two reasons.
> >
> > One is the case that swap-in readahead happens. The other is the
> > corner case related to the shmem cache. These two problems should be
> > fixed, but, it's not straight-forward to fix. For example, when swap-of=
f,
> > all swapped-out pages are read into swapcache. In this case, who's the
> > owner of the swapcache page?
> >
> > Since this problem doesn't look trivial, I decide to leave the issue an=
d
> > handles this corner case on the place where the error occurs.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> It wouldn't be hard to find out who owns this page. The code in
> mem_cgroup_try_charge() is only a few lines:

lookup_swap_cgroup_id() uses additional memory and is only
usable if CONFIG_MEMCG_SWAP is on.

>                         swp_entry_t ent =3D { .val =3D page_private(page)=
, };
>                         unsigned short id =3D lookup_swap_cgroup_id(ent);
>
>                         rcu_read_lock();
>                         memcg =3D mem_cgroup_from_id(id);
>                         if (memcg && !css_tryget_online(&memcg->css))
>                                 memcg =3D NULL;
>                         rcu_read_unlock();
>
> THAT BEING SAID, I don't think we actually *want* to know the original
> cgroup for readahead pages. Because before they are accessed and
> charged to the original owner, the pages are sitting on the root
> cgroup LRU list and follow the root group's aging speed and LRU order.

Okay. Sound reasonable.

> Eviction and refault tracking is about the LRU that hosts the pages.
>
> So IMO your patch is much less of a hack than you might think.

Good!

> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index a9f474a..8d2e83a 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -257,6 +257,10 @@ void *workingset_eviction(struct page *page, struc=
t mem_cgroup *target_memcg)
> >       VM_BUG_ON_PAGE(page_count(page), page);
> >       VM_BUG_ON_PAGE(!PageLocked(page), page);
> >
> > +     /* page_memcg() can be NULL if swap-in readahead happens */
> > +     if (!page_memcg(page))
> > +             return NULL;
> > +
> >       advance_inactive_age(page_memcg(page), pgdat, is_file);
> >
> >       lruvec =3D mem_cgroup_lruvec(target_memcg, pgdat);
>
> This means a readahead page that hasn't been accessed will actively
> not be tracked as an eviction and later as a refault.
>
> I think that's the right thing to do, but I would expand the comment:

Okay. I will add the following comment.

Thanks.

> /*
>  * A page can be without a cgroup here when it was brought in by swap
>  * readahead and nobody has touched it since.
>  *
>  * The idea behind the workingset code is to tell on page fault time
>  * whether pages have been previously used or not. Since this page
>  * hasn't been used, don't store a shadow entry for it; when it later
>  * faults back in, we treat it as the new page that it is.
>  */
