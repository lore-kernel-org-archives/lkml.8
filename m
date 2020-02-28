Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B0C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2433246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUvAXdKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1JRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:17:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38835 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1JRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:17:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so1415818pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zI5jGxPKWZopGzcv8defovjFjujVgFtOE2duoJV0Wp0=;
        b=GUvAXdKOo7OyFPS2kf6v3BkSN+skvXBZ7JcrJYs69tz3ANL8je5hZ0EjTayeqE8wNu
         psy0bfo0H+WJ0wdJFS5wuzxG66IGW/o13shpERXrIEpovfQMt4ugk+Wvr/e0JshDNzAI
         foQ4gFsTs4If8U9DrkoguvGEJlkfLhx1vqjl0zN5WbRspK7mF1nXpiFUe5KQUF448Bgv
         dIwhOfLlBnzGK9OIrMZt7BvMflJ1xo1hvMwCuwRuE++Wvz1mk7rSIR/1hwPm2Uqlom45
         iN8oIOlJopcnzWSiy+7rOC0BZIU5NN9Z4SQ+MxkxYUkGZbiCPe3xlcBXZYo7lE8K5/a7
         JN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zI5jGxPKWZopGzcv8defovjFjujVgFtOE2duoJV0Wp0=;
        b=qbIER1pm0LnQsAUSPO+z7rDL51zAxGPb5V7GGKrOUSr8jP9wt1B1+fcs20de/Cq+BD
         KM9tXQelwpCWkAnm0opa8oVJXw+c6ALv8utWqVhkcqPDXGAvJDswyfH1TK5dZP7HV9fw
         Vdy/aakBznoKuTKdeLQZNrhcvyunqpxOwKk5Rz7GA3GbiF9F2obE9F7RKvyyLWEGOeS0
         5hHnbAmU3c3Eq+HaNcEJj5ghieu7llPE/4Arny/mgk9SM/W/gxUX/A1xxqKA8ztPfDdE
         DhhUtC6q2XSbjvj/NP3a3Ls4niCdljlJ1pZENcr9cIJE+y+T/NkKq9tkQtcpRTV2hxBa
         /9Zg==
X-Gm-Message-State: APjAAAX4hV5pW0RBcTNYLmglK86L9bQHLlVHdAjCT/FGVJn/RUGz9sH6
        CUByxYo0cvFIaSsqb0TUCE8=
X-Google-Smtp-Source: APXvYqzab6CgvwhYVpxAhMnw2skAcbQpWu4HxLaqCT1KtGcHPYjurfX0ws/oKB6VUNDMj8KBWL2pAQ==
X-Received: by 2002:a63:a351:: with SMTP id v17mr3557592pgn.319.1582881428708;
        Fri, 28 Feb 2020 01:17:08 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id x70sm1492356pgd.37.2020.02.28.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 01:17:07 -0800 (PST)
Date:   Fri, 28 Feb 2020 17:17:00 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-ID: <20200228091700.GA675567@ziqianlu-desktop.localdomain>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org>
 <20200228032358.GB634650@ziqianlu-desktop.localdomain>
 <20200228040214.GA21040@js1304-desktop>
 <20200228055726.GA674737@ziqianlu-desktop.localdomain>
 <20200228065214.GA17349@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228065214.GA17349@js1304-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 03:52:59PM +0900, Joonsoo Kim wrote:
> On Fri, Feb 28, 2020 at 01:57:26PM +0800, Aaron Lu wrote:
> > On Fri, Feb 28, 2020 at 01:03:03PM +0900, Joonsoo Kim wrote:
> > > Hello,
> > > 
> > > On Fri, Feb 28, 2020 at 11:23:58AM +0800, Aaron Lu wrote:
> > > > On Thu, Feb 27, 2020 at 08:48:06AM -0500, Johannes Weiner wrote:
> > > > > On Wed, Feb 26, 2020 at 07:39:42PM -0800, Andrew Morton wrote:
> > > > > > It sounds like the above simple aging changes provide most of the
> > > > > > improvement, and that the workingset changes are less beneficial and a
> > > > > > bit more risky/speculative?
> > > > > > 
> > > > > > If so, would it be best for us to concentrate on the aging changes
> > > > > > first, let that settle in and spread out and then turn attention to the
> > > > > > workingset changes?
> > > > > 
> > > > > Those two patches work well for some workloads (like the benchmark),
> > > > > but not for others. The full patchset makes sure both types work well.
> > > > > 
> > > > > Specifically, the existing aging strategy for anon assumes that most
> > > > > anon pages allocated are hot. That's why they all start active and we
> > > > > then do second-chance with the small inactive LRU to filter out the
> > > > > few cold ones to swap out. This is true for many common workloads.
> > > > > 
> > > > > The benchmark creates a larger-than-memory set of anon pages with a
> > > > > flat access profile - to the VM a flood of one-off pages. Joonsoo's
> > > > 
> > > > test: swap-w-rand-mt, which is a multi thread swap write intensive
> > > > workload so there will be swap out and swap ins.
> > > > 
> > > > > first two patches allow the VM to usher those pages in and out of
> > > > 
> > > > Weird part is, the robot says the performance gain comes from the 1st
> > > > patch only, which adjust the ratio, not including the 2nd patch which
> > > > makes anon page starting from inactive list.
> > > > 
> > > > I find the performance gain hard to explain...
> > > 
> > > Let me explain the reason of the performance gain.
> > > 
> > > 1st patch provides more second chance to the anonymous pages.
> > 
> > By second chance, do I understand correctely this refers to pages on 
> > inactive list get moved back to active list?
> 
> Yes.
> 
> > 
> > > In swap-w-rand-mt test, memory used by all threads is greater than the
> > > amount of the system memory, but, memory used by each thread would
> > > not be much. So, although it is a rand test, there is a locality
> > > in each thread's job. More second chance helps to exploit this
> > > locality so performance could be improved.
> > 
> > Does this mean there should be fewer vmstat.pswpout and vmstat.pswpin
> > with patch1 compared to vanilla?
> 
> It depends on the workload. If the workload consists of anonymous

This swap-rand-w-mt workload is anon only.

> pages only, I think, yes, pswpout/pswpin would be lower than vanilla

I think LKP robot has captured these two metrics but the report didn't
show them, which means the number is about the same with or without
patch #1.

> with patch #1. With large inactive list, we can easily find the
> frequently referenced page and it would result in less swap in/out.

But with small inactive list, the pages that would be on inactive list
will stay on active list? I think the larger inactive list is mainly
used to give the anon page a chance to be promoted to active list now
that anon pages land on inactive list first, but on reclaim, I don't see
how a larger inactive list can cause fewer swap outs.

Forgive me for my curiosity and feel free to ignore my question as I
don't want to waste your time on this. Your patchset looks a worthwhile
thing to do, it's just the robot's report on patch1 seems er...
