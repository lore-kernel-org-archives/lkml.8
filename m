Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61677C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE5720721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="HDxZXECh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBCUqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:46:30 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41425 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCUqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:46:30 -0500
Received: by mail-qv1-f66.google.com with SMTP id s7so7493182qvn.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Dyb5P8cYEisIFp4I9bV09OPYylTy1VzXVbN2SCBhjo=;
        b=HDxZXEChqr8YGF0MhKTxj3c2pDA138gHfw/6zgEsOxoFoaRnu9e+rh9ivPg5RvQK04
         rj9iNBrqdXd21ZlvGOGXE82Coh4XHqJnAtVsfX6dlkVF7egKmkzt7by0DHYGUMabuijM
         PR7eVPslVTo/JGx08pjzWnRjui/OWXwkrLRgpJEjJ+z5LFhyWL2RuD0tR25qQYRUJJw2
         tYjKHJSu8Gw6jNRy30qk7Wtdy6B88BX7aBbbaFXoMuL+j2/x4Zgvsyg7HiujAb9MeFis
         c6Kx/xigRFf4tVPdNvIF6ATPDTm1xfDu12fZMtyh8dMrEz+Z4RF1LMLbxzlPrIhb66i3
         rZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Dyb5P8cYEisIFp4I9bV09OPYylTy1VzXVbN2SCBhjo=;
        b=qXf7RgiPsZFl1UNPS0AQNZQFVSElmeafzuPoHKIgbU5kQpRDtqO5yhdIIFYDoxt5oN
         952iQBXvbVi4ECGXtPKL1d6pYhiT6RSyn1lcLkgBowP4EP9LCB/HmcKq749wsfSTd347
         SuKIVBmtCujdkpCPpIVgZhVz5qIrjmtDXA65SgMoL6gnXge0cIXDSJsLbd8tK7g4mHDZ
         Is6gdaCNslkGb8E1wTE7BOEHBIvcqwbKPBGULLJ0aiAQXLukAO+7mrV9fwZQOUucl0IY
         92gLG6Ti/PjwcAGs3LeW0sJTSC6MCpJDXO/zW4SEtHCTpL24qYiznnFnhendVrPotQ0y
         kLHw==
X-Gm-Message-State: APjAAAXqHMD5i+p9HzLDd0qYZwKWkXiok7Ywl7xxXv+avEiTT0Ajiq4l
        BIzRt9FfWodE7NIdIg07uDMkSg==
X-Google-Smtp-Source: APXvYqzszWZ7Ewhr+k+B6rzbBT7wB0PB1LbN/PwaCn/pgpKw44Bck5sSf0IftWxwwNoUQe+6FAYo1g==
X-Received: by 2002:ad4:518d:: with SMTP id b13mr24279887qvp.141.1580762788875;
        Mon, 03 Feb 2020 12:46:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:6320])
        by smtp.gmail.com with ESMTPSA id t15sm9609895qkg.49.2020.02.03.12.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:46:28 -0800 (PST)
Date:   Mon, 3 Feb 2020 15:46:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 16/28] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
Message-ID: <20200203204627.GB6380@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-17-guro@fb.com>
 <20200203182756.GG1697@cmpxchg.org>
 <20200203183452.GB3700@xps.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203183452.GB3700@xps.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:34:52AM -0800, Roman Gushchin wrote:
> On Mon, Feb 03, 2020 at 01:27:56PM -0500, Johannes Weiner wrote:
> > On Mon, Jan 27, 2020 at 09:34:41AM -0800, Roman Gushchin wrote:
> > > Allocate and release memory to store obj_cgroup pointers for each
> > > non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> > > to the allocated space.
> > > 
> > > To distinguish between obj_cgroups and memcg pointers in case
> > > when it's not obvious which one is used (as in page_cgroup_ino()),
> > > let's always set the lowest bit in the obj_cgroup case.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  include/linux/mm.h       | 25 ++++++++++++++++++--
> > >  include/linux/mm_types.h |  5 +++-
> > >  mm/memcontrol.c          |  5 ++--
> > >  mm/slab.c                |  3 ++-
> > >  mm/slab.h                | 51 +++++++++++++++++++++++++++++++++++++++-
> > >  mm/slub.c                |  2 +-
> > >  6 files changed, 83 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 080f8ac8bfb7..65224becc4ca 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -1264,12 +1264,33 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
> > >  #ifdef CONFIG_MEMCG
> > >  static inline struct mem_cgroup *page_memcg(struct page *page)
> > >  {
> > > -	return page->mem_cgroup;
> > > +	struct mem_cgroup *memcg = page->mem_cgroup;
> > > +
> > > +	/*
> > > +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> > > +	 * but a obj_cgroups pointer. In this case the page is shared and
> > > +	 * isn't charged to any specific memory cgroup. Return NULL.
> > > +	 */
> > > +	if ((unsigned long) memcg & 0x1UL)
> > > +		memcg = NULL;
> > > +
> > > +	return memcg;
> > 
> > That should really WARN instead of silently returning NULL. Which
> > callsite optimistically asks a page's cgroup when it has no idea
> > whether that page is actually a userpage or not?
> 
> For instance, look at page_cgroup_ino() called from the
> reading /proc/kpageflags.

But that checks PageSlab() and implements memcg_from_slab_page() to
handle that case properly. And that's what we expect all callsites to
do: make sure that the question asked actually makes sense, instead of
having the interface paper over bogus requests.

If that function is completely racy and PageSlab isn't stable, then it
should really just open-code the lookup, rather than require weakening
the interface for everybody else.

> > >  static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> > >  {
> > > +	struct mem_cgroup *memcg = READ_ONCE(page->mem_cgroup);
> > > +
> > >  	WARN_ON_ONCE(!rcu_read_lock_held());
> > > -	return READ_ONCE(page->mem_cgroup);
> > > +
> > > +	/*
> > > +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> > > +	 * but a obj_cgroups pointer. In this case the page is shared and
> > > +	 * isn't charged to any specific memory cgroup. Return NULL.
> > > +	 */
> > > +	if ((unsigned long) memcg & 0x1UL)
> > > +		memcg = NULL;
> > > +
> > > +	return memcg;
> > 
> > Same here.
> > 
> > >  }
> > >  #else
> > >  static inline struct mem_cgroup *page_memcg(struct page *page)
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 270aa8fd2800..5102f00f3336 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -198,7 +198,10 @@ struct page {
> > >  	atomic_t _refcount;
> > >  
> > >  #ifdef CONFIG_MEMCG
> > > -	struct mem_cgroup *mem_cgroup;
> > > +	union {
> > > +		struct mem_cgroup *mem_cgroup;
> > > +		struct obj_cgroup **obj_cgroups;
> > > +	};
> > 
> > Since you need the casts in both cases anyway, it's safer (and
> > simpler) to do
> > 
> > 	unsigned long mem_cgroup;
> > 
> > to prevent accidental direct derefs in future code.
> 
> Agree. Maybe even mem_cgroup_data?

Personally, I don't think the suffix adds much. The type makes it so
the compiler catches any accidental use, and access is very
centralized so greppability doesn't matter much.
