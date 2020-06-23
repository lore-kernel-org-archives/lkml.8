Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E342AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CD0206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592896291;
	bh=hXROL7UzJiGkYdFuAE42xXobmEFNFKKELtV90ojl1Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y1phMkZJc1u70zviCRdX2ofmsjkHcZJieBz66vxHybLtGqpSipAwgucsDugSNCrzE
	 tXgDarK010HbMHEqSmQ3iD4LVUi4N7GsXna+X9RN45cxkJWDlVrYlHLdJVahZ01hFe
	 hg/r3AYWP9zTmbN1cNyTqS4Kjh4VwIPnvKHr/epQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgFWHLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:11:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34831 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbgFWHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:11:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id g21so2045502wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRfic2uNti/UNHIf238bWji3fE0ROmFtREqb8C//tds=;
        b=qr/r8LGx+ZStv1B//2nqrbCGN08vyxsjcFOICMCS8KCalpnNMVRGtL9cGNLiYL4+43
         XcUEbVFtamSj8phL9xQt9OQ8PTuCAk23+etotZZEd6XPqQZh2QFS8FhJ72BqVR1B3dkA
         sJ+A7GLtgSqATkZ9s2V62TOV5vzvKP1OhoPtqwdaxHgxb/LaP6Q47H0BWQlnDvHHds19
         nyNQSSSmICTVWIJu+k5/z8ro8HABQKd0Yem7yqJQZiR10zMRg2uImHyFVmVzo8/g5/0W
         ekYg0ScdpKFUePhS1a1eUrK8Tp958NH8M0T9PTQIom2lkDT0igkbmZ1kej5Fiz5FAo5H
         hloQ==
X-Gm-Message-State: AOAM531+JWwGuA33DfJxAJRYzK+o7soxWqglOYvRW6EydyaMowAvB8Ri
        R5QlRO3ZG44ecvPqOhHTosc=
X-Google-Smtp-Source: ABdhPJwlcKGX++SM+FitUS1vo58YQ6EWJR/y/ywqmrhoh5WmOu/OTqIuhLOHeK/Zp0i63GrfHFDr2g==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr23073532wmj.180.1592896287624;
        Tue, 23 Jun 2020 00:11:27 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id l190sm2452668wml.12.2020.06.23.00.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:11:26 -0700 (PDT)
Date:   Tue, 23 Jun 2020 09:11:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        ????????? <jaewon31.kim@samsung.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        ????????? <ytk.lee@samsung.com>,
        ????????? <cmlaika.kim@samsung.com>
Subject: Re: [PATCH v4] page_alloc: consider highatomic reserve in watermark
 fast
Message-ID: <20200623071125.GP31426@dhcp22.suse.cz>
References: <20200622091107.GC31426@dhcp22.suse.cz>
 <20200619235958.11283-1-jaewon31.kim@samsung.com>
 <CGME20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca@epcms1p6>
 <20200622094020epcms1p639cc33933fbb7a9d578adb16a6ea0734@epcms1p6>
 <20200622100439.GQ3183@techsingularity.net>
 <20200622142304.GD31426@dhcp22.suse.cz>
 <20200622162501.GJ3129@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622162501.GJ3129@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-06-20 17:25:01, Mel Gorman wrote:
> On Mon, Jun 22, 2020 at 04:23:04PM +0200, Michal Hocko wrote:
> > On Mon 22-06-20 11:04:39, Mel Gorman wrote:
> > > On Mon, Jun 22, 2020 at 06:40:20PM +0900, ????????? wrote:
> > > > >But more importantly, I have hard time to follow why we need both
> > > > >zone_watermark_fast and zone_watermark_ok now. They should be
> > > > >essentially the same for anything but order == 0. For order 0 the
> > > > >only difference between the two is that zone_watermark_ok checks for
> > > > >ALLOC_HIGH resp ALLOC_HARDER, ALLOC_OOM. So what is exactly fast about
> > > > >the former and why do we need it these days?
> > > > > 
> > > > 
> > > > I think the author, Mel, may ansewr. But I think the wmark_fast may
> > > > fast by 1) not checking more condition about wmark and 2) using inline
> > > > rather than function. According to description on commit 48ee5f3696f6,
> > > > it seems to bring about 4% improvement.
> > > > 
> > > 
> > > The original intent was that watermark checks were expensive as some of the
> > > calculations are only necessary when a zone is relatively low on memory
> > > and the check does not always have to be 100% accurate. This is probably
> > > still true given that __zone_watermark_ok() makes a number of calculations
> > > depending on alloc flags even if a zone is almost completely free.
> > 
> > OK, so we are talking about 
> > 	if (alloc_flags & ALLOC_HIGH)
> > 		min -= min / 2;
> > 
> > 	if (unlikely((alloc_flags & (ALLOC_HARDER|ALLOC_OOM))) {
> > 		/*
> > 		 * OOM victims can try even harder than normal ALLOC_HARDER
> > 		 * users on the grounds that it's definitely going to be in
> > 		 * the exit path shortly and free memory. Any allocation it
> > 		 * makes during the free path will be small and short-lived.
> > 		 */
> > 		if (alloc_flags & ALLOC_OOM)
> > 			min -= min / 2;
> > 		else
> > 			min -= min / 4;
> > 	}
> > 
> > Is this something even measurable and something that would justify a
> > complex code? If we really want to keep it even after these changes
> > which are making the two closer in the cost then can we have it
> > documented at least?
> 
> It was originally documented as being roughly 4% for a page allocator
> micro-benchmark but that was 4 years ago and I do not even remember what
> type of machine that was on. Chances are the relative cost is different
> now but I haven't measured it as the microbenchmark in question doesn't
> even compile with recent kernels.

Thanks for the clarification.

> For many allocations, the bulk of the
> allocation cost is zeroing the page so I have no particular objection
> to zone_watermark_fast being removed if it makes the code easier to
> read. While I have not looked recently, the cost of allocation in general
> and the increasing scope of the zone->lock with larger NUMA nodes for
> high-order allocations like THP are more of a concern than two branches
> and potentially two minor calculations.

OK, then I would rather go with the code simplification for the future
maintainability. If somebody can test this and provide good numbers then
we can reintroduce a fast check.

Thanks!
-- 
Michal Hocko
SUSE Labs
