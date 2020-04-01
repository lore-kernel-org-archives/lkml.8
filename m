Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C58C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E304020747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cx66ohga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbgDAU1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:27:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38596 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgDAU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:27:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5so1494737edq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OC9PgTsBjtl+ylJzd7l+Sywlv6FT4l8sZkj2c0W8znk=;
        b=cx66ohgaUHaRjaRje4/IRGEh9viPuavu+pjiysUzScydyWXf17BsEL/edlAaWb6gm5
         5TPSXQZlaWqNNaGkCW1t4SB7YYkDnUTJdfTAysErd1A0wsdZ/G7bJQ7c6vNRq/ghz/en
         ZKpsZGdHbwrQXbEKwWfQlkvBY0YkUEudsZRuxkDnQbFsuBL8TyuviKplD7YBowU3Fpbz
         QKsdw4URzuu50/6+xG36rBq36v2V4Mm4oYOE9F4fwObgfhFGiue9lIlIL0MWI6jcHKXQ
         lZkN6fQLwifC10Qn8SXS/jaKzzBQ2AYCCBWZ9QtIVPxJXJN3iOEBi5rRSSowSG5hiJqF
         wbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OC9PgTsBjtl+ylJzd7l+Sywlv6FT4l8sZkj2c0W8znk=;
        b=Tm5PRS0JJqAmogSterL+5je4eQTNMtfEw7WpSuNoL3yL+2SxsmcjM2pGo69ImPZ1Me
         8qP283OmUvYdXNZLkzY0DtZBH+9qGHdsCu5KmtYDTyaVjpFSLanp+d4ec4TSfZd7WKMC
         WLpSsrioTJkWV7DS8juoeWOZL/XQFsp1+DiyCzD0gC4ofFTcQAc/0ShIk2OTiUI5NSHq
         PiJOxewhgDWvoVnik8tTPa2ufsYxdsU+LB1OO+3tN3RtXA9psX2Emii664Vge+DKilZg
         mQRT8Wtmu2ev3HX9v+phH3UE0pl2DX7j1Qdj+RKYBrnvl3O//xTG2AMrVcJXiHkhvohw
         4GoQ==
X-Gm-Message-State: ANhLgQ3npWwEE1xrXZSVFhdF4EL9Nwq8m37PJ8EdEGnHxSuFGsCe6M/Z
        55CE7eXSv6q+L2SZs8Gax2OUwUE/KO+4oqcHFr1Ong==
X-Google-Smtp-Source: ADFU+vuq2n4NZBybGxSChO9XkYchxC522ouicWJM9YoOZLujuNAFo22lGfjl8sfv2MWIh69kl1QrZm8eHaoDtRCKsEE=
X-Received: by 2002:aa7:c359:: with SMTP id j25mr22523968edr.85.1585772864144;
 Wed, 01 Apr 2020 13:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200401193238.22544-1-pasha.tatashin@soleen.com> <20200401195721.GZ22681@dhcp22.suse.cz>
In-Reply-To: <20200401195721.GZ22681@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 1 Apr 2020 16:27:33 -0400
Message-ID: <CA+CK2bBC-KBRuCBjJminVp+NmYSK3mhRZgmTmcBY5C5a-xVoMw@mail.gmail.com>
Subject: Re: [PATCH] mm: initialize deferred pages with interrupts enabled
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 3:57 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 01-04-20 15:32:38, Pavel Tatashin wrote:
> > Initializing struct pages is a long task and keeping interrupts disabled
> > for the duration of this operation introduces a number of problems.
> >
> > 1. jiffies are not updated for long period of time, and thus incorrect time
> >    is reported. See proposed solution and discussion here:
> >    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
>
> http://lkml.kernel.org/r/20200311123848.118638-1-shile.zhang@linux.alibaba.com
>
> > 2. It prevents farther improving deferred page initialization by allowing
> >    inter-node multi-threading.
> >
> > We are keeping interrupts disabled to solve a rather theoretical problem
> > that was never observed in real world (See 3a2d7fa8a3d5).
> >
> > Lets keep interrupts enabled. In case we ever encounter a scenario where
> > an interrupt thread wants to allocate large amount of memory this early in
> > boot we can deal with that by growing zone (see deferred_grow_zone()) by
> > the needed amount before starting deferred_init_memmap() threads.
> >
> > Before:
> > [    1.232459] node 0 initialised, 12058412 pages in 1ms
> >
> > After:
> > [    1.632580] node 0 initialised, 12051227 pages in 436ms
> >
>
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> I would much rather see pgdat_resize_lock completely out of both the
> allocator and deferred init path altogether but this can be done in a
> separate patch. This one looks slightly safer for stable backports.

This is what I wanted to do, but after studying deferred_grow_zone(),
I do not see a simple way to solve this. It is one thing to fail an
allocation, and it is another thing to have a corruption because of
race.

> To be completely honest I would love to see the resize lock go away
> completely. That might need a deeper thought but I believe it is
> something that has never been done properly.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you,
Pasha


>
> Thanks!
>
> > ---
> >  mm/page_alloc.c | 21 +++++++--------------
> >  1 file changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3c4eb750a199..4498a13b372d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1792,6 +1792,13 @@ static int __init deferred_init_memmap(void *data)
> >       BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
> >       pgdat->first_deferred_pfn = ULONG_MAX;
> >
> > +     /*
> > +      * Once we unlock here, the zone cannot be grown anymore, thus if an
> > +      * interrupt thread must allocate this early in boot, zone must be
> > +      * pre-grown prior to start of deferred page initialization.
> > +      */
> > +     pgdat_resize_unlock(pgdat, &flags);
> > +
> >       /* Only the highest zone is deferred so find it */
> >       for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> >               zone = pgdat->node_zones + zid;
> > @@ -1812,8 +1819,6 @@ static int __init deferred_init_memmap(void *data)
> >       while (spfn < epfn)
> >               nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> >  zone_empty:
> > -     pgdat_resize_unlock(pgdat, &flags);
> > -
> >       /* Sanity check that the next zone really is unpopulated */
> >       WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
> >
> > @@ -1854,18 +1859,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
> >               return false;
> >
> >       pgdat_resize_lock(pgdat, &flags);
> > -
> > -     /*
> > -      * If deferred pages have been initialized while we were waiting for
> > -      * the lock, return true, as the zone was grown.  The caller will retry
> > -      * this zone.  We won't return to this function since the caller also
> > -      * has this static branch.
> > -      */
> > -     if (!static_branch_unlikely(&deferred_pages)) {
> > -             pgdat_resize_unlock(pgdat, &flags);
> > -             return true;
> > -     }
> > -
> >       /*
> >        * If someone grew this zone while we were waiting for spinlock, return
> >        * true, as there might be enough pages already.
> > --
> > 2.17.1
> >
>
> --
> Michal Hocko
> SUSE Labs
