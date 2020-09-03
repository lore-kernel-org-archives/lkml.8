Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C45C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F90520716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vgjn0x5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgICSYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgICSYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:24:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2CBC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 11:24:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l63so3635108edl.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYzegE1TrUesOvgJj7wxlo2/SZ1cjWBeZ/7cromDBhA=;
        b=Vgjn0x5T8wExJqnxkReGGH31IpzXLF6ysqaefBcSuMhV/mIdF7PRQFF/AqqPzMGOlP
         EzZH0fS1XK/waHqNfDMfNMDcTwMDfp+RTTU3Z/TLpMJ0rzOoCwnsAX6UYMVVSSjhqw2u
         FdlqQ00dFrco23zHwXpzUd1/tFhMTtV6Xr/5LCDKrbxbt8tlyy9Zwcmk/NVrj+jbGYw5
         LeV/her4znhNS3ydJT2iQEcK5u03GxW8PD7miV17SGFwrz8JhEShGkZDkn+hdMYQorAu
         7zjMzQC5xE8zhQxeZOwzcG41eS7HZBvZLv50TvhP9mUsRjSFwSkJUdHS+djt12oBM8Z4
         jjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYzegE1TrUesOvgJj7wxlo2/SZ1cjWBeZ/7cromDBhA=;
        b=mNZpW+CL+NOTQSiA2Z+7aKTZhvZc2Dq3bdPnEABuf6bUvQ6CSruZeBq0fbr5zyKvNs
         YFO8a3P9rFi3OvWNkQ22pndrIjV5sqXC/lqZviPHemLts0k7BE9gL4gWJR995d44ev5w
         DjreFYph03dBrS9gJqsBFZRC2UKMq5Iv2g6Vq6xEwqbsrtCw99zVlvQETApuAKyDH5WP
         kzCTX9+50ukkq8Y1BxH8X0RifxITDOfVYdILrNvIyS5riNnEpAbwlG00MSEmIWfB4McA
         1/cDbQoAYTv+MEZBTwx+b96Dy6+ZAUnrPJ67S5IZMQ7D1T1rqalSRQlh/fPrsEs21ikt
         SIIA==
X-Gm-Message-State: AOAM532iOsokhp1Oj4I+vcmcfT6c0f8S7bKCRRl5k7rmjaH1M4eM7uMQ
        FQDDdBiob2bcbajl6uqBG3z4ejJJT15rVK5ju6biOeuu0To=
X-Google-Smtp-Source: ABdhPJw2cQ3MBveaBD7gbuOQHuRjWaMGjxlS/z1Wdd/NoipdoD4nd0B491pBg6dl98yFPkiu1jgocEMfy1isesqINhU=
X-Received: by 2002:aa7:de91:: with SMTP id j17mr4508531edv.85.1599157474741;
 Thu, 03 Sep 2020 11:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140851.GJ4617@dhcp22.suse.cz> <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz> <20200902151306.GL4617@dhcp22.suse.cz>
 <e6bf05cb-044c-47a9-3c65-e41b1e42b702@suse.cz> <20200903063806.GM4617@dhcp22.suse.cz>
 <c6b11905-2456-52a0-3b15-d4ceae6e7f54@redhat.com>
In-Reply-To: <c6b11905-2456-52a0-3b15-d4ceae6e7f54@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Sep 2020 14:23:58 -0400
Message-ID: <CA+CK2bBTfmhTWNRrxnVKi=iknqq-iZxNZSnwNA9C9tWAJzRxmw@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 2:20 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 03.09.20 08:38, Michal Hocko wrote:
> > On Wed 02-09-20 19:51:45, Vlastimil Babka wrote:
> >> On 9/2/20 5:13 PM, Michal Hocko wrote:
> >>> On Wed 02-09-20 16:55:05, Vlastimil Babka wrote:
> >>>> On 9/2/20 4:26 PM, Pavel Tatashin wrote:
> >>>>> On Wed, Sep 2, 2020 at 10:08 AM Michal Hocko <mhocko@suse.com> wrote:
> >>>>>>
> >>>>>>>
> >>>>>>> Thread#1 - continue
> >>>>>>>          free_unref_page_commit
> >>>>>>>            migratetype = get_pcppage_migratetype(page);
> >>>>>>>               // get old migration type
> >>>>>>>            list_add(&page->lru, &pcp->lists[migratetype]);
> >>>>>>>               // add new page to already drained pcp list
> >>>>>>>
> >>>>>>> Thread#2
> >>>>>>> Never drains pcp again, and therefore gets stuck in the loop.
> >>>>>>>
> >>>>>>> The fix is to try to drain per-cpu lists again after
> >>>>>>> check_pages_isolated_cb() fails.
> >>>>>>
> >>>>>> But this means that the page is not isolated and so it could be reused
> >>>>>> for something else. No?
> >>>>>
> >>>>> The page is in a movable zone, has zero references, and the section is
> >>>>> isolated (i.e. set_pageblock_migratetype(page, MIGRATE_ISOLATE);) is
> >>>>> set. The page should be offlinable, but it is lost in a pcp list as
> >>>>> that list is never drained again after the first failure to migrate
> >>>>> all pages in the range.
> >>>>
> >>>> Yeah. To answer Michal's "it could be reused for something else" - yes, somebody
> >>>> could allocate it from the pcplist before we do the extra drain. But then it
> >>>> becomes "visible again" and the loop in __offline_pages() should catch it by
> >>>> scan_movable_pages() - do_migrate_range(). And this time the pageblock is
> >>>> already marked as isolated, so the page (freed by migration) won't end up on the
> >>>> pcplist again.
> >>>
> >>> So the page block is marked MIGRATE_ISOLATE but the allocation itself
> >>> could be used for non migrateable objects. Or does anything prevent that
> >>> from happening?
> >>
> >> In a movable zone, the allocation should not be used for non migrateable
> >> objects. E.g. if the zone was not ZONE_MOVABLE, the offlining could fail
> >> regardless of this race (analogically for migrating away from CMA pageblocks).
> >>
> >>> We really do depend on isolation to not allow reuse when offlining.
> >>
> >> This is not really different than if the page on pcplist was allocated just a
> >> moment before the offlining, thus isolation started. We ultimately rely on being
> >> able to migrate any allocated pages away during the isolation. This "freeing to
> >> pcplists" race doesn't fundamentally change anything in this regard. We just
> >> have to guarantee that pages on pcplists will be eventually flushed, to make
> >> forward progress, and there was a bug in this aspect.
> >
> > You are right. I managed to confuse myself yesterday. The race is
> > impossible for !ZONE_MOVABLE because we do PageBuddy check there. And on
> > the movable zone we are not losing the migrateability property.
> >
> > Pavel I think this will be a useful information to add to the changelog.
> > We should also document this in the code to prevent from further
> > confusion. I would suggest something like the following:
> >
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index 242c03121d73..56d4892bceb8 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -170,6 +170,14 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
> >   * pageblocks we may have modified and return -EBUSY to caller. This
> >   * prevents two threads from simultaneously working on overlapping ranges.
> >   *
> > + * Please note that there is no strong synchronization with the page allocator
> > + * either. Pages might be freed while their page blocks are marked ISOLATED.
> > + * In some cases pages might still end up on pcp lists and that would allow
> > + * for their allocation even when they are in fact isolated already. Depending on
> > + * how strong of a guarantee the caller needs drain_all_pages might be needed
> > + * (e.g. __offline_pages will need to call it after check for isolated range for
> > + * a next retry).
> > + *
>
> As expressed in reply to v2, I dislike this hack. There is strong
> synchronization, just PCP is special. Allocating from MIGRATE_ISOLATE is
> just plain ugly.
>
> Can't we temporarily disable PCP (while some pageblock in the zone is
> isolated, which we know e.g., due to the counter), so no new pages get
> put into PCP lists after draining, and re-enable after no pageblocks are
> isolated again? We keep draining the PCP, so it doesn't seem to be of a
> lot of use during that period, no? It's a performance hit already.
>
> Then, we would only need exactly one drain. And we would only have to
> check on the free path whether PCP is temporarily disabled.

Hm, we could use a static branches to disable it, that would keep
release code just as fast, but I am worried it will make code even
uglier. Let's see what others in this thread think about this idea.

Thank you,
Pasha
