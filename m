Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBBCC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1047B217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yyrJ5+jL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBMR6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:58:17 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33505 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgBMR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:58:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so5079660qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ipGsEe3/yOsYlV8o1qjdWtTtOYX3RrBOQJnaAHZ74E=;
        b=yyrJ5+jL6U0zkaNRdTW4XuwU+6h5CQnk2Kna+wx5jv/oLlIDtuaHbYHVYKCkC3AygR
         YWYwMBVcOwka2f+bwSLH5UGQ8QqtDRjbEfmYqCzn5CXOf9r+l8xySGHsDT97EoNmJL+Z
         BFqyHHG97LmrX/nEHoQVEjni7ym6/0qgt0zC+8whWuuLAw+gyCIlEm/f28W3B6cMhgm3
         ZdgG+MHFDtKu2Hgkht8OtjfuDsoa/6E1Pt+/dXISLj3RRI2FkFHI1wENiBIY6Mw6tfKq
         weY9CBjvOOr6U205IE39Kt35Lchk9QylIsO67BL1UYFSaY/d0BvAGrrR7FrOAY0TIXHX
         cQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ipGsEe3/yOsYlV8o1qjdWtTtOYX3RrBOQJnaAHZ74E=;
        b=mXp1FSdyPWAykZlHESypU1YyvN2ElrAo2vX/Cv953WzubKLMDuF17dkvo55AutiotT
         nPQpW5A/eUGnLRiB1xq1KibrfZjDkkKHn+KZI37ehE2gAQg6Z7dZ6FIJaO/tCctNwRqi
         yVs7o/byG5SamkVSudxeauMD2hfgesd1Zl21gLsAAIrqP3C9C5mzsYB46FJPfa3sti3u
         XisPe4/YxgDEdKJiVuzpXEndViZ2oUoD1cg7Si1QoCR+gPG7CbNdvXpiGtE5FEuQxSIg
         3D37bUzQljX6FcogYJmcXLkC93bBv9o7qs9mTFEJVFh/0zL4TtMz5zgggkJGMFvDu7uz
         CQTw==
X-Gm-Message-State: APjAAAUCQlumt6KcH/ci4ukvzb04rYkoqKgQj3SYuPb7Jq/OF+YpGdSb
        zgnkbzXeLtxrNNsRrBu8e4xx1A==
X-Google-Smtp-Source: APXvYqwqBCJ0s5vHlwMLwR6mlStPZGgfSbSbbiTotNao1HluWZUM7SNZvKJznowoLfUCWM7jtUryZg==
X-Received: by 2002:aed:25a4:: with SMTP id x33mr13058777qtc.165.1581616694352;
        Thu, 13 Feb 2020 09:58:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::d837])
        by smtp.gmail.com with ESMTPSA id d9sm1826312qth.34.2020.02.13.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:58:13 -0800 (PST)
Date:   Thu, 13 Feb 2020 12:58:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200213175813.GA216470@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213132317.GA208501@cmpxchg.org>
 <20200213154627.GD31689@dhcp22.suse.cz>
 <20200213174135.GC208501@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213174135.GC208501@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 12:41:36PM -0500, Johannes Weiner wrote:
> On Thu, Feb 13, 2020 at 04:46:27PM +0100, Michal Hocko wrote:
> > On Thu 13-02-20 08:23:17, Johannes Weiner wrote:
> > > On Thu, Feb 13, 2020 at 08:40:49AM +0100, Michal Hocko wrote:
> > > > On Wed 12-02-20 12:08:26, Johannes Weiner wrote:
> > > > > On Tue, Feb 11, 2020 at 05:47:53PM +0100, Michal Hocko wrote:
> > > > > > Unless I am missing something then I am afraid it doesn't. Say you have a
> > > > > > default systemd cgroup deployment (aka deeper cgroup hierarchy with
> > > > > > slices and scopes) and now you want to grant a reclaim protection on a
> > > > > > leaf cgroup (or even a whole slice that is not really important). All the
> > > > > > hierarchy up the tree has the protection set to 0 by default, right? You
> > > > > > simply cannot get that protection. You would need to configure the
> > > > > > protection up the hierarchy and that is really cumbersome.
> > > > > 
> > > > > Okay, I think I know what you mean. Let's say you have a tree like
> > > > > this:
> > > > > 
> > > > >                           A
> > > > >                          / \
> > > > >                         B1  B2
> > > > >                        / \   \
> > > > >                       C1 C2   C3

> > > > So let's see how that works in practice, say a multi workload setup
> > > > with a complex/deep cgroup hierachies (e.g. your above example). No
> > > > delegation point this time.
> > > > 
> > > > C1 asks for low=1G while using 500M, C3 low=100M using 80M.  B1 and
> > > > B2 are completely independent workloads and the same applies to C2 which
> > > > doesn't ask for any protection at all? C2 uses 100M. Now the admin has
> > > > to propagate protection upwards so B1 low=1G, B2 low=100M and A low=1G,
> > > > right? Let's say we have a global reclaim due to external pressure that
> > > > originates from outside of A hierarchy (it is not overcommited on the
> > > > protection).
> > > > 
> > > > Unless I miss something C2 would get a protection even though nobody
> > > > asked for it.
> > > 
> > > Good observation, but I think you spotted an unintentional side effect
> > > of how I implemented the "floating protection" calculation rather than
> > > a design problem.
> > > 
> > > My patch still allows explicit downward propagation. So if B1 sets up
> > > 1G, and C1 explicitly claims those 1G (low>=1G, usage>=1G), C2 does
> > > NOT get any protection. There is no "floating" protection left in B1
> > > that could get to C2.
> > 
> > Yeah, the saturated protection works reasonably AFAICS.
> 
> Hm, Tejun raises a good point though: even if you could direct memory
> protection down to one targeted leaf, you can't do the same with IO or
> CPU. Those follow non-conserving weight distribution, and whatever you

                    "work-conserving", obviously.

> allocate to a certain level is available at that level - if one child
> doesn't consume it, the other children can.
> 
> And we know that controlling memory without controlling IO doesn't
> really work in practice. The sibling with less memory allowance will
> just page more.
> 
> So the question becomes: is this even a legit usecase? If every other
> resource is distributed on a level-by-level method already, does it
> buy us anything to make memory work differently?
