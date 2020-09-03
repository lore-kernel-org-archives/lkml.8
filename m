Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDAFC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F3520716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TWwaZxX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgICSH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICSH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:07:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C1CC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 11:07:55 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so5118162ejf.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCYaYCtUscxexyh6LWrjL8SmecgFsorLbUTETS26frM=;
        b=TWwaZxX9nUgmxfTZK0ic7NdtN05EQOwCzdn5knBje6r/BjSLp/iw1ZNQronrTsrSz0
         HwF8veMKgh7Gy0MaznsmBo1EDNg0ij/JVAeCe5PoO+W0J7M7SISHc09yx83AaHml1OwE
         kArMQus8Swa9tblteZP1j4BwWJd3cQEk3YaKeTExzIayMT4iTwhp9XpOC1VGWwrd2l10
         8IMPoboPZII5nR6C4ah5KvOLueDiMjbRA2PuF5TfZAlSBE+U49YVrTD6rDqCM9/XnRLi
         BuRCRtsVYPO2wQpj17UlJ0KN20bsKMvVEmFLx1EK3Hnf4xpYD7475tkMaQUxGAOm55pK
         0rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCYaYCtUscxexyh6LWrjL8SmecgFsorLbUTETS26frM=;
        b=Yoccu1vCb+EqFRLUAm3btbTfV3o8VYfzK3SGPYlCHTM2oEW51to2LRt4hZW5nmB9q8
         ASTqE8GSymPQ1UO+vwrON2/ZjDpo7FdJxoNRLicmQXftXxEqVvORdb0PaNTDq1Mt9bWn
         0R4+2r/Qx67Xpk+L3ucMX1m7hiKoCk+Jt+jHe3K1G7knZkacQDdeWAyFFnnTKBzW+i6m
         BFieYq3g78Oppsj1N6blEXybfJ818pHi4v8HMUbVYaAGCmE99kSv2AfMhv3/eyUhplel
         5553KznLSxvq0D9CpxzDzf2eTPb7M42llTqYrI/+iNjPj5/sRU2Z72tb8h6dnlrglqc5
         FbLA==
X-Gm-Message-State: AOAM531nQpF59xODRsKptMLfNwN9IBT21LjXM7PBxUHRmtsJ11Q67luf
        +N7tA4FtVCt1MMVs2UsK8F0LL6+u6FnIQXp3yj9G8Ye0sP3vrw==
X-Google-Smtp-Source: ABdhPJz0SmRsjyf1ZDuga+uE82XO1ty+f2yUzq5TkSUcztFMhfnbEEWUMwjKfbdl/JURAv5bJeHQB0/uOyIvdNdGjS8=
X-Received: by 2002:a17:906:5418:: with SMTP id q24mr3257684ejo.296.1599156474251;
 Thu, 03 Sep 2020 11:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200903140032.380431-1-pasha.tatashin@soleen.com> <6ec66eb9-eeba-5076-af97-cef59ed5cbaa@redhat.com>
In-Reply-To: <6ec66eb9-eeba-5076-af97-cef59ed5cbaa@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Sep 2020 14:07:18 -0400
Message-ID: <CA+CK2bD3APTsm=2RJeXtyVJmZX+0fJRwdFo4sBs4L8AoYsKWLg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 1:36 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 03.09.20 16:00, Pavel Tatashin wrote:
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
> >
> > Fixes: c52e75935f8d ("mm: remove extra drain pages on pcp list")
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: stable@vger.kernel.org
> > Acked-by: David Rientjes <rientjes@google.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/memory_hotplug.c | 14 ++++++++++++++
> >  mm/page_isolation.c |  8 ++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index e9d5ab5d3ca0..b11a269e2356 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1575,6 +1575,20 @@ static int __ref __offline_pages(unsigned long start_pfn,
> >               /* check again */
> >               ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> >                                           NULL, check_pages_isolated_cb);
> > +             /*
> > +              * per-cpu pages are drained in start_isolate_page_range, but if
> > +              * there are still pages that are not free, make sure that we
> > +              * drain again, because when we isolated range we might
> > +              * have raced with another thread that was adding pages to pcp
> > +              * list.
> > +              *
> > +              * Forward progress should be still guaranteed because
> > +              * pages on the pcp list can only belong to MOVABLE_ZONE
> > +              * because has_unmovable_pages explicitly checks for
> > +              * PageBuddy on freed pages on other zones.
> > +              */
> > +             if (ret)
> > +                     drain_all_pages(zone);
> >       } while (ret);
> >
> >       /* Ok, all of our target is isolated.
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index 242c03121d73..63a3db10a8c0 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -170,6 +170,14 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
> >   * pageblocks we may have modified and return -EBUSY to caller. This
> >   * prevents two threads from simultaneously working on overlapping ranges.
> >   *
> > + * Please note that there is no strong synchronization with the page allocator
> > + * either. Pages might be freed while their page blocks are marked ISOLATED.
> > + * In some cases pages might still end up on pcp lists and that would allow
> > + * for their allocation even when they are in fact isolated already. Depending
> > + * on how strong of a guarantee the caller needs drain_all_pages might be needed
> > + * (e.g. __offline_pages will need to call it after check for isolated range for
> > + * a next retry).
> > + *
> >   * Return: the number of isolated pageblocks on success and -EBUSY if any part
> >   * of range cannot be isolated.
> >   */
> >
>
> (still on vacation, back next week on Tuesday)
>
> I didn't look into discussions in v1, but to me this looks like we are
> trying to hide an actual bug by implementing hacks in the caller

Hi David,

Please read discussion in v1 [1], some of the things that you brought
up were covered in that discussion.

> (repeated calls to drain_all_pages()). What about alloc_contig_range()
> users - you get more allocation errors just because PCP code doesn't
> play along.

Yes, I looked at that, and it sounds normal to me: alloc error, try
again if needed, at least we do not get stuck in an infinite loop like
here.

>
> There *is* strong synchronization with the page allocator - however,
> there seems to be one corner case race where we allow to allocate pages
> from isolated pageblocks.
>
> I want that fixed instead if possible, otherwise this is just an ugly
> hack to make the obvious symptoms (offlining looping forever) disappear.

The fix would be to synchronize isolation code with release code,
which would slow down the fastpath of the release code instead of rare
page offline code.

>
> If that is not possible easily, I'd much rather want to see all
> drain_all_pages() calls being moved to the caller and have the expected
> behavior documented instead of specifying "there is no strong
> synchronization with the page allocator" - which is wrong in all but PCP
> cases (and there only in one possible race?).
>
> I do wonder why we hit this issue now and not before - I suspect
> something in PCP code changed that made this race possible.

I suspect because memory hot-remove was never stressed enough? We have
a special use case where we do not hor-remove on every shutdown, and
repro rate was only one in ~400 reboots. This bug and other deadlocks
[2], [3] were tough too root cause partially because of so slow repro
rate.

Pasha

[1] https://lore.kernel.org/lkml/20200901124615.137200-1-pasha.tatashin@soleen.com
[2] https://lore.kernel.org/lkml/CA+CK2bCQcnTpzq2wGFa3D50PtKwBoWbDBm56S9y8c+j+pD+KSw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+CK2bBEHFuLLg79_h6bv4Vey+B0B2YXyBxTBa=Le12OKbNdwA@mail.gmail.com/
