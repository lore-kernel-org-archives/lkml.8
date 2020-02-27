Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A748C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA13246A6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582846603;
	bh=5WYsINO5sNEHyaFQwn3i+MXTlgu1tZ++rR45XVTJQpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hra/dNI+5vIIIiQLWoao/9qsmY0Yp9AEJkJMSoWJC6SgiSCwrld2oVZ1wgDEPArie
	 cZhVrMei+TD5BxNXwZxvCeNs69IajOURLQtPlTW1DkBHy6STI6NNSs+NuC4Xyw7Y0y
	 Ei8hcmbQLZF3wkOZsimirsVZbc56WPgt4FP9we+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgB0Xgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:36:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgB0Xgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:36:41 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63EB82469B;
        Thu, 27 Feb 2020 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582846600;
        bh=5WYsINO5sNEHyaFQwn3i+MXTlgu1tZ++rR45XVTJQpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tvo+AV/gfIOFHtQN8+WJBG3+9u2Emcse9ki/xDK1Mvgj3t6C9O91qTsWwmh8YFCCM
         dW6hNKVSPqbuBv5Eht+sGvhfFVFcmmz98CQhjLzpqNZGWY3uQTPhrT1LaVJ7pk43uc
         RijK5fz8xP23y0dlZMJIStAxUb14AhNElU69adwY=
Date:   Thu, 27 Feb 2020 15:36:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     js1304@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-Id: <20200227153639.951d6a42080e8d4227872e64@linux-foundation.org>
In-Reply-To: <20200227134806.GC39625@cmpxchg.org>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
        <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
        <20200227134806.GC39625@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 08:48:06 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> > It sounds like the above simple aging changes provide most of the
> > improvement, and that the workingset changes are less beneficial and a
> > bit more risky/speculative?
> > 
> > If so, would it be best for us to concentrate on the aging changes
> > first, let that settle in and spread out and then turn attention to the
> > workingset changes?
> 
> Those two patches work well for some workloads (like the benchmark),
> but not for others. The full patchset makes sure both types work well.
> 
> Specifically, the existing aging strategy for anon assumes that most
> anon pages allocated are hot. That's why they all start active and we
> then do second-chance with the small inactive LRU to filter out the
> few cold ones to swap out. This is true for many common workloads.
> 
> The benchmark creates a larger-than-memory set of anon pages with a
> flat access profile - to the VM a flood of one-off pages. Joonsoo's
> first two patches allow the VM to usher those pages in and out of
> memory very quickly, which explains the throughput boost. But it comes
> at the cost of reducing space available to hot anon pages, which will
> regress others.
> 
> Joonsoo's full patchset makes the VM support both types of workloads
> well: by putting everything on the inactive list first, one-off pages
> can move through the system without disturbing the hot pages. And by
> supplementing the inactive list with non-resident information, he can
> keep it tiny without the risk of one-off pages drowning out new hot
> pages. He can retain today's level of active page protection and
> detection, while allowing one-off pages to move through quickly.

Helpful, thanks.

At v2 with no evident review input I'd normally take a pass at this
stage.  But given all the potential benefits, perhaps I should be more
aggressive here?
