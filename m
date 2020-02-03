Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E33C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64EC2080C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="OpbXPTtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBCW3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:29:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33296 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgBCW3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:29:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so5096941qkm.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HiWmlRMWVj7sRzPe2KD8AIrXAD2vkrWukuq2SfG6Uwg=;
        b=OpbXPTtjqmTYN4t9qU28GHoJ8dhik5Bv1+L2aPpsUKal1RbzmzqNI/e2l1JGpUb8Cj
         B+a+bAmPJW2tff9w2j+fFgZRI1xYUgj33CvU0k8HcDVrRXbiOmO4ZieLS1OYT7IZQaI7
         fC9Tf+E6A+1CaiAv7AXLOg4CYyS5WMnKw//2DwheYI0YL1CwanoujoibzY7r/9e34YQW
         NLPwXp7fVdYU/LphoB7OSEESctY7WijsS4/nW/Xbt0BvEaSj6HoB4GALQXHcqDozimIZ
         /0ncQ8FyS6/fmY9fDU6fg1Ie3IRxFZiYJYK/orhJ8uuDFyo7vJR+NBYdhtXXNrquLDw5
         QjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HiWmlRMWVj7sRzPe2KD8AIrXAD2vkrWukuq2SfG6Uwg=;
        b=r0BSnGntBNhljy5JCUR6obm3WliUoar/rw4r5uDH76hIc6pR6/QmqWzcFEYK0OXm1Z
         KeBi4FXLOUoi/1th3ukM3Zn4slTeEnMjon2NdcMIOsP52o4pOhoa9XAnnjgNhn8qRJxA
         FyLFbem5zSgyeH3nGOykAQDqUZzE3nPKar8k+vg6safoSOfq8r1cMNi3kknWkhnaSXhj
         s7tdAWFi96NoXuz4QEXo6DmkeQmod18m/PKKZKNCMhlqN2d3/1t1DrIsIPyZe8tEZiPQ
         GC/MhpfYw3xaAZxtpKYYyWvz/+sjVDLK3cs8a1No+B+aXhkfkw4aYkyBokKyQm9dVxgN
         p22g==
X-Gm-Message-State: APjAAAVOLH3umhfastHzce1JnOWFCc40qsJUlw/rjK1HpJiFdaV3fonJ
        tllCXcyLKPCEfKYT1LGDLpNcUg==
X-Google-Smtp-Source: APXvYqxuVcXwLNsAQVgKcu3qB/jxgT+R1hxB0GBUtegc2WK/fQTrilfue9DIYJl03JeeecsappceFg==
X-Received: by 2002:a37:488f:: with SMTP id v137mr24982388qka.16.1580768985996;
        Mon, 03 Feb 2020 14:29:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:6320])
        by smtp.gmail.com with ESMTPSA id f26sm10455848qtv.77.2020.02.03.14.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 14:29:45 -0800 (PST)
Date:   Mon, 3 Feb 2020 17:29:44 -0500
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
Message-ID: <20200203222944.GB7345@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-17-guro@fb.com>
 <20200203182756.GG1697@cmpxchg.org>
 <20200203183452.GB3700@xps.dhcp.thefacebook.com>
 <20200203204627.GB6380@cmpxchg.org>
 <20200203211915.GB6781@xps.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203211915.GB6781@xps.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 01:19:15PM -0800, Roman Gushchin wrote:
> On Mon, Feb 03, 2020 at 03:46:27PM -0500, Johannes Weiner wrote:
> > On Mon, Feb 03, 2020 at 10:34:52AM -0800, Roman Gushchin wrote:
> > > On Mon, Feb 03, 2020 at 01:27:56PM -0500, Johannes Weiner wrote:
> > > > On Mon, Jan 27, 2020 at 09:34:41AM -0800, Roman Gushchin wrote:
> > > > > Allocate and release memory to store obj_cgroup pointers for each
> > > > > non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> > > > > to the allocated space.
> > > > > 
> > > > > To distinguish between obj_cgroups and memcg pointers in case
> > > > > when it's not obvious which one is used (as in page_cgroup_ino()),
> > > > > let's always set the lowest bit in the obj_cgroup case.
> > > > > 
> > > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > > ---
> > > > >  include/linux/mm.h       | 25 ++++++++++++++++++--
> > > > >  include/linux/mm_types.h |  5 +++-
> > > > >  mm/memcontrol.c          |  5 ++--
> > > > >  mm/slab.c                |  3 ++-
> > > > >  mm/slab.h                | 51 +++++++++++++++++++++++++++++++++++++++-
> > > > >  mm/slub.c                |  2 +-
> > > > >  6 files changed, 83 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > index 080f8ac8bfb7..65224becc4ca 100644
> > > > > --- a/include/linux/mm.h
> > > > > +++ b/include/linux/mm.h
> > > > > @@ -1264,12 +1264,33 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
> > > > >  #ifdef CONFIG_MEMCG
> > > > >  static inline struct mem_cgroup *page_memcg(struct page *page)
> > > > >  {
> > > > > -	return page->mem_cgroup;
> > > > > +	struct mem_cgroup *memcg = page->mem_cgroup;
> > > > > +
> > > > > +	/*
> > > > > +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> > > > > +	 * but a obj_cgroups pointer. In this case the page is shared and
> > > > > +	 * isn't charged to any specific memory cgroup. Return NULL.
> > > > > +	 */
> > > > > +	if ((unsigned long) memcg & 0x1UL)
> > > > > +		memcg = NULL;
> > > > > +
> > > > > +	return memcg;
> > > > 
> > > > That should really WARN instead of silently returning NULL. Which
> > > > callsite optimistically asks a page's cgroup when it has no idea
> > > > whether that page is actually a userpage or not?
> > > 
> > > For instance, look at page_cgroup_ino() called from the
> > > reading /proc/kpageflags.
> > 
> > But that checks PageSlab() and implements memcg_from_slab_page() to
> > handle that case properly. And that's what we expect all callsites to
> > do: make sure that the question asked actually makes sense, instead of
> > having the interface paper over bogus requests.
> > 
> > If that function is completely racy and PageSlab isn't stable, then it
> > should really just open-code the lookup, rather than require weakening
> > the interface for everybody else.
> 
> Why though?
> 
> Another example: process stack can be depending on the machine config and
> platform a vmalloc allocation, a slab allocation or a "high-order slab allocation",
> which is executed by the page allocator directly.
> 
> It's kinda nice to have a function that hides accounting details
> and returns a valid memcg pointer for any kind of objects.

Hm? I'm not objecting to that, memcg_from_obj() makes perfect sense to
me, to use with kvmalloc() objects for example.

I'm objecting to page_memcg() silently swallowing bogus inputs. That
function shouldn't silently say "there is no cgroup associated with
this page" when the true answer is "this page has MANY cgroups
associated with it, this question doesn't make any sense".

It's not exactly hard to imagine how this could cause bugs, is it?
Where a caller should implement a slab case (exactly like
page_cgroup_ino()) but is confused about the type of page it has,
whether it's charged or not etc.?
