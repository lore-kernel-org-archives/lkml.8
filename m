Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D70DC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B55221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="05cVSUqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgDQDbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbgDQDbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:31:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C6C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:31:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so1146255qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BySWgsJ3K5C1hO+GKN/Cp5xXu2o+1t4dyBhvdV/4NTI=;
        b=05cVSUqZ/hbRiPR2cBmfOUTZtXTNRFi+v3MiyjRrLTEplvRoWSpGQdbOwALipW+GaC
         R2G2vaUOVxr85gV/hww/jDQSjppKYq2WImYEBm5gzPvggrlQlKLDXa8z0/Tjz/zGo9eB
         sUuwijPI4NLMsbiPUfVmAQz17hDnIlAwYzU/XdjZss0D0egL9Oygwj+3zmIGlmM1YVnw
         qMU82EscWgBBGkLihNxlyt+A6YpP9w8i+3WjxD+uXYKSrgvgEAlCoi94Pky2QOIUm9ru
         p0gXz1XSpspNOB7H1umZpeaOXpTD3BHhRsVW6onmMdsQIC1F7vdecWd3LvCn6K+gIvmK
         KF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BySWgsJ3K5C1hO+GKN/Cp5xXu2o+1t4dyBhvdV/4NTI=;
        b=MFSBdDUCGuraOEkbNVbgfNuMLuzqnNRsmxlL5NsmVsavL+PK+ljcvPOSFK28ra7dOY
         8J2xoYok2whOCTn3KKFpKxb4znyzOUSAp0/1Wdygp3zg2V2+BRJtFZkvAsMMZsSxGmCi
         DafEKJzGSU7ffTO4drYx76ph+X55VnBJNPOY2dGpHBGWdIlVPbgnzhVb2sBwDf0mHLbp
         U8dzTs/sJgXwppKFs3kiqzY/8gSXasPzfe2HXA0iTn/ieMLeftre5GgtZNXyo9qXZx/8
         ydUhrKxDZ/xkqMy7oL55CkzDffRXtQTKsTYgfePFI6BqYb6ewxcr8RSz+A6npOkaWrKG
         mR2g==
X-Gm-Message-State: AGi0PuaEBAZvm8+fw+4FAhEWBO2s0HzVXXP+ueobJ2aGO13YVSm+Ugd+
        G3bVmA63IoxWnvtGIufU81hcgg==
X-Google-Smtp-Source: APiQypLkJ/KUrwWihLCaKHnI/hB7giwXXJ6GAUo3JAjfr14iQ7JCYjfMKyXR3eAq+YvCETCKT0AaLQ==
X-Received: by 2002:a37:881:: with SMTP id 123mr1247883qki.185.1587094278363;
        Thu, 16 Apr 2020 20:31:18 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id j14sm16477125qtv.27.2020.04.16.20.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 20:31:17 -0700 (PDT)
Date:   Thu, 16 Apr 2020 23:31:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the
 swap cache
Message-ID: <20200417033116.GJ195132@cmpxchg.org>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20200416161133.GA178028@cmpxchg.org>
 <CAAmzW4M5EBXDarx-Xkryrf+BKgdOJqBr7aBaB=4P3gBRN-v30Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4M5EBXDarx-Xkryrf+BKgdOJqBr7aBaB=4P3gBRN-v30Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:38:53AM +0900, Joonsoo Kim wrote:
> 2020년 4월 17일 (금) 오전 1:11, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> >
> > Hello Joonsoo,
> >
> > On Fri, Apr 03, 2020 at 02:40:43PM +0900, js1304@gmail.com wrote:
> > > @@ -112,7 +112,7 @@ void show_swap_cache_info(void)
> > >   * but sets SwapCache flag and private instead of mapping and index.
> > >   */
> > >  int add_to_swap_cache(struct page *page, swp_entry_t entry,
> > > -                     gfp_t gfp, void **shadowp)
> > > +                     struct vm_area_struct *vma, gfp_t gfp, void **shadowp)
> > >  {
> > >       struct address_space *address_space = swap_address_space(entry);
> > >       pgoff_t idx = swp_offset(entry);
> > > @@ -120,14 +120,26 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
> > >       unsigned long i, nr = compound_nr(page);
> > >       unsigned long nrexceptional = 0;
> > >       void *old;
> > > +     bool compound = !!compound_order(page);
> > > +     int error;
> > > +     struct mm_struct *mm = vma ? vma->vm_mm : current->mm;
> > > +     struct mem_cgroup *memcg;
> > >
> > >       VM_BUG_ON_PAGE(!PageLocked(page), page);
> > >       VM_BUG_ON_PAGE(PageSwapCache(page), page);
> > >       VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
> > >
> > >       page_ref_add(page, nr);
> > > +     /* PageSwapCache() prevent the page from being re-charged */
> > >       SetPageSwapCache(page);
> > >
> > > +     error = mem_cgroup_try_charge(page, mm, gfp, &memcg, compound);
> > > +     if (error) {
> > > +             ClearPageSwapCache(page);
> > > +             page_ref_sub(page, nr);
> > > +             return error;
> > > +     }
> > > +
> > >       do {
> > >               xas_lock_irq(&xas);
> > >               xas_create_range(&xas);
> > > @@ -153,11 +165,16 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
> > >               xas_unlock_irq(&xas);
> > >       } while (xas_nomem(&xas, gfp));
> > >
> > > -     if (!xas_error(&xas))
> > > +     if (!xas_error(&xas)) {
> > > +             mem_cgroup_commit_charge(page, memcg, false, compound);
> >
> > Unfortunately you cannot commit here yet because the rmap isn't set up
> > and that will cause memcg_charge_statistics() to account the page
> > incorrectly as file. And rmap is only set up during a page fault.
> 
> I also found this problem a few days ago. In my investigation, what we need for
> anonymous page to make accounting correct is a way to find the type of the page,
> file or anon, since there is no special code to use the rmap. And, I
> think that it
> could be done by checking NULL mapping or something else.

page->mapping is NULL for truncated file pages, file pages before they
are inserted into the page cache, and anon pages before the rmap. It's
not straight-forward to robustly tell those apart inside memcg.

But fundamentally, it's a silly problem to fix. We only need to tell
page types apart to maintain the MEMCG_CACHE and MEMCG_RSS
counters. But these are unnecessary duplicates of the NR_FILE_PAGES
and NR_ANON_MAPPED vmstat counters - counters for which we already
have accounting sites in generic code, and that already exist in the
per-cgroup vmstat arrays. We just need to link them.

So that's what I'm fixing instead: I'm adjusting the charging sequence
slightly so that page->mem_cgroup is stable when the core VM code
accounts pages by type. And then I'm hooking into these places with
mod_lruvec_page_state and friends, and ditching MEMCG_CACHE/MEMCG_RSS.

After that, memcg doesn't have to know about the types of pages at
all. It can focus on maintaining page_counters and page->mem_cgroup,
and leave the vmstat breakdown to generic VM code.

Then we can charge pages right after allocation, regardless of type.

[ Eventually, the memcg accounting interface shouldn't be much more
  than GFP_ACCOUNT (with memalloc_use_memcg() for faults, swap etc.),
  and the vmstat hooks. My patches don't quite get there, but that's
  the direction they're pushing. ]

> Is there anything I missed? And, I cannot find the function,
> memcg_charge_statistics(). Please let me know the file name of this
> function.

The correct name is mem_cgroup_charge_statistics(), my apologies.

> > This needs a bit of a rework of the memcg charging code that appears
> > out of scope for your patches. I'm preparing a series right now to do
> > just that. It'll also fix the swap ownership tracking problem when the
> > swap controller is disabled, so we don't have to choose between
> > charging the wrong cgroup or hampering swap readahead efficiency.
> 
> Sound good! I also think that these patches are out of scope of my series.
> I will wait your patches. Could you let me know when your series is submitted?
> I'd like to plan my work schedule based on your patch schedule.

I just finished the first draft of the series a few minutes ago. I'll
polish it a bit, make sure it compiles etc. ;-), and send it out for
review, testing and rebasing, hopefully tomorrow or early next week.
