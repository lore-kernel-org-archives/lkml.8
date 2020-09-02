Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9620C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB91420767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MnyrJeZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgIBO36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgIBO1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:27:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5669FC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:27:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ba12so5139711edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OOrr3ankKVwxGGNXToxy8jZJ4HxhbpceY6NaN50tLo=;
        b=MnyrJeZWxNanxx+EeVE/LB7iSafmhLfk8zHRAK7voOONuaQFQEp8FWuNryGn4WlrvK
         YiaPAiGMbL43ABgId2yZdBMutBWeYG80LAvLktNAUeReCRCAZKhDQWdZkH1TmA9HM64N
         97zfvWaoPMpVrPbgWPW1wqg0HWi1CpGicWQ3wAt15K5BXPdJSkrWz8XKHqA6CzYunlJJ
         Ku9rD8Q0Iw5rjGvtQN99M3OpzxqqRu/OB1JoIRpo8DeZHDJ+oSIz3AjII/VHvkAxOYtx
         6GwaI7NjueIhnz9V2rhOZmvj6CETY7E8dvX0Gzl7zMZbpyVd2hEnFU55UESMBey8sU0O
         dHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OOrr3ankKVwxGGNXToxy8jZJ4HxhbpceY6NaN50tLo=;
        b=uXWeYotZ3DPGLnA9eQFCjuHbGiclLGFyO34CMVokelj0Y5paaNzdpBeK+f9LQrkIpq
         FxuxxLKeQLPB80AnSkppXtsHA88dvjGUL8E2d6mRVDp9o+zkJY0mw7eqwRDad/r4Lduc
         9uE6QeQEwrxHWF8YJvRq/YFLV1QPkBO+Ug8a7EVO1QwIW6X6g+1SwDHulQgwaNY5R5uo
         rkeW178cwylEC54Lk5rhmARD/kHTverBxqlc7+naZaGq9sE6FkRrigH0cHxZVmbHerIx
         F33Tr9UqUfs9IOtsH/vm9vCi/5j6KlmCKbbj97sMw6AjuCO1Y5JkWuTC6p6mMklNRzwV
         OCYA==
X-Gm-Message-State: AOAM530nG7ug/khQCIF0sf4WOQ168fmwC3/RwhUpRDSmvEbCxnHuMPce
        4LLXrJxYD5WDrFO3EmQNK9M9ewtbLlEMYey1xEApkQ==
X-Google-Smtp-Source: ABdhPJzNVkeIY5bugg1hnssT2HP/1orWqIA4ATC5qddKjKxgYam+9CmN4LlIuehn0Ap7B63fkyLj5KnhXd2jZIkpPrM=
X-Received: by 2002:a05:6402:1d0f:: with SMTP id dg15mr352913edb.342.1599056840905;
 Wed, 02 Sep 2020 07:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200901124615.137200-1-pasha.tatashin@soleen.com> <20200902140851.GJ4617@dhcp22.suse.cz>
In-Reply-To: <20200902140851.GJ4617@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Sep 2020 10:26:44 -0400
Message-ID: <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 10:08 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 01-09-20 08:46:15, Pavel Tatashin wrote:
> > There is a race during page offline that can lead to infinite loop:
> > a page never ends up on a buddy list and __offline_pages() keeps
> > retrying infinitely or until a termination signal is received.
> >
> > Thread#1 - a new process:
> >
> > load_elf_binary
> >  begin_new_exec
> >   exec_mmap
> >    mmput
> >     exit_mmap
> >      tlb_finish_mmu
> >       tlb_flush_mmu
> >        release_pages
> >         free_unref_page_list
> >          free_unref_page_prepare
> >           set_pcppage_migratetype(page, migratetype);
> >              // Set page->index migration type below  MIGRATE_PCPTYPES
> >
> > Thread#2 - hot-removes memory
> > __offline_pages
> >   start_isolate_page_range
> >     set_migratetype_isolate
> >       set_pageblock_migratetype(page, MIGRATE_ISOLATE);
> >         Set migration type to MIGRATE_ISOLATE-> set
> >         drain_all_pages(zone);
> >              // drain per-cpu page lists to buddy allocator.
>
> It is not really clear to me how we could have passed
> has_unmovable_pages at this stage when the page is not PageBuddy. Is
> this because you are using Movable Zones?

Yes, we hot-remove memory from the movable zone.

>
> >
> > Thread#1 - continue
> >          free_unref_page_commit
> >            migratetype = get_pcppage_migratetype(page);
> >               // get old migration type
> >            list_add(&page->lru, &pcp->lists[migratetype]);
> >               // add new page to already drained pcp list
> >
> > Thread#2
> > Never drains pcp again, and therefore gets stuck in the loop.
> >
> > The fix is to try to drain per-cpu lists again after
> > check_pages_isolated_cb() fails.
>
> But this means that the page is not isolated and so it could be reused
> for something else. No?

The page is in a movable zone, has zero references, and the section is
isolated (i.e. set_pageblock_migratetype(page, MIGRATE_ISOLATE);) is
set. The page should be offlinable, but it is lost in a pcp list as
that list is never drained again after the first failure to migrate
all pages in the range.

>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/memory_hotplug.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index e9d5ab5d3ca0..d6d54922bfce 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1575,6 +1575,15 @@ static int __ref __offline_pages(unsigned long start_pfn,
> >               /* check again */
> >               ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> >                                           NULL, check_pages_isolated_cb);
> > +             /*
> > +              * per-cpu pages are drained in start_isolate_page_range, but if
> > +              * there are still pages that are not free, make sure that we
> > +              * drain again, because when we isolated range we might
> > +              * have raced with another thread that was adding pages to
> > +              * pcp list.
> > +              */
> > +             if (ret)
> > +                     drain_all_pages(zone);
> >       } while (ret);
> >
> >       /* Ok, all of our target is isolated.
> > --
> > 2.25.1
> >
>
> --
> Michal Hocko
> SUSE Labs
