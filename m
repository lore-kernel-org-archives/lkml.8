Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAEF2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585793605;
	bh=klz9eliX+7OT0FFYqY405/cf6rLKmbUmvzr4pvm6U58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VUy/dF7XSFGSFfHXwSf454hq5iLxcE1lky9LCW1/6rcuKyv8q3iAKiQha24kxUBEk
	 20wr5mU1mofhjf6zE8LNUh6ZZAuBD9cxHYgSvMvOwiwNWWNGvTsT5xEeMplFD0dhHW
	 nzBS9HGxvPAWBp6vFeQCa9Y9Io5krYU2XjmIQsxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbgDBCNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgDBCNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:13:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4350520719;
        Thu,  2 Apr 2020 02:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585793603;
        bh=klz9eliX+7OT0FFYqY405/cf6rLKmbUmvzr4pvm6U58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=smW3DrLtRQS4C3UmhDTRI2xaz4Yx8dDbtgpWlIbH4LPogR2WjWbeR7teiV6G6Tzey
         zjQ0EPNKzfOZCKea1LJL3kKZwOSMeVSGiFmb0g3IuJeYrcQ6bPMDfGlBOZZNq/tGY+
         1ujqrGItLOSS62tzbcR9oVu8SSRALuRM4T0ygyPs=
Date:   Wed, 1 Apr 2020 19:13:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-Id: <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org>
In-Reply-To: <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
        <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
        <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
        <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 10:41:28 +0900 Joonsoo Kim <js1304@gmail.com> wrote:

> Hello, Roman.
> 
> 2020년 3월 12일 (목) 오전 2:35, Roman Gushchin <guro@fb.com>님이 작성:
> >
> > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > Posting this one for Roman so I can deal with any upstream feedback and
> > > > create a v2 if needed, while scratching my head over the next piece of
> > > > this puzzle :)
> > > >
> > > > ---8<---
> > > >
> > > > From: Roman Gushchin <guro@fb.com>
> > > >
> > > > Currently a cma area is barely used by the page allocator because
> > > > it's used only as a fallback from movable, however kswapd tries
> > > > hard to make sure that the fallback path isn't used.
> > >
> > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
> > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
> > > unresolved bugs. Perhaps the idea could be resurrected now?
> >
> > Hi Vlastimil!
> >
> > Thank you for this reminder! I actually looked at it and also asked Joonsoo in private
> > about the state of this patch(set). As I understand, Joonsoo plans to resubmit
> > it later this year.
> >
> > What Rik and I are suggesting seems to be much simpler, however it's perfectly
> > possible that Joonsoo's solution is preferable long-term.
> >
> > So if the proposed patch looks ok for now, I'd suggest to go with it and return
> > to this question once we'll have a new version of ZONE_MOVABLE solution.
> 
> Hmm... utilization is not the only matter for CMA user. The more
> important one is
> success guarantee of cma_alloc() and this patch would have a bad impact on it.
> 
> A few years ago, I have tested this kind of approach and found that increasing
> utilization increases cma_alloc() failure. Reason is that the page
> allocated with
> __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by someone.
> 
> Until now, cma memory isn't used much so this problem doesn't occur easily.
> However, with this patch, it would happen.

So I guess we keep Roman's patch on hold pending clarification of this
risk?
