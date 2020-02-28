Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3747C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBC4246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR8NbMyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgB1J4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:56:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39575 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgB1J4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:56:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so1048926plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2QsN/rdxaIqssMADaDVe6NhtTvdzMSkrjVDdCt3Mft0=;
        b=DR8NbMyb++08TCBQlly9aRtr9w0nv3yapNpXlboIXFtQZesGe3XoJJeub7sPgN56bU
         5TLsME80pB8gXS96LhC9qYSuYsn2vF1+JpUHhcZ7FVaUnratWGpLtu9U+Vtn9ouetWXV
         8/3PdSZT5pZUaJbNdn60fCkiJ4h0XzVPAz0asLKAnNUGrkEhEhtmVW4Iu3q2eYTcBnwG
         Q989urBANB1Jcv0a9M8KUSIR8fZmgoTzU7vT7gWfCLBrdS3Hd96+nV9BmRqoPbrIv6mS
         WMQlyvhLG3+D51lebvfBLHHgNPkoMWvcBg4wdDezX1uQPgBm+w+MgII6dddqffH8qZsy
         N9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2QsN/rdxaIqssMADaDVe6NhtTvdzMSkrjVDdCt3Mft0=;
        b=qp94dzizz3csohfeGe97zR0QiPpHz/dYWfQ977QzX0qJWy1E004eLN3TKrek8FzQ+T
         lmIDURYbVWsw9TfZJoL9NKkuhzVAgrYrPZbBqHhtMnkDqpirt6nXXfEyNbOKBdyScAp3
         jdo993LttINJkVnGf4L0TmoqqqpvO386stK0XI9Tk7PwsyM9MIVlkbcKil3yLSofWJI6
         tPzvKyAZEL7TkZdKbhQNpCX+KzqWz3Ezswdy5gYAwLgV9SlO62zZ3Fw/WqFSXnZbl7Av
         CfSMeiExh5MuiUE6OQ7GJlBh1lzIxSfhNkG1b/V+nrZ9HtsW7TnX3VYCkja7qAm1KuzK
         FG4Q==
X-Gm-Message-State: APjAAAWLtWIYHaBog5KXJqF3KL4JUdCvOVsFrAaaQ4lw90VxdNSa0l1J
        cL5XzIURKFKi5inlz7uNJZs=
X-Google-Smtp-Source: APXvYqzeq5AJZwfx4VpkyGRwt33tMRUzv7T+620AVSjU/lm/WxAKYskVCMbi96DqbZTCn8vH3HbcOQ==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr3364412ply.68.1582883778836;
        Fri, 28 Feb 2020 01:56:18 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 13sm10090469pfj.68.2020.02.28.01.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 01:56:18 -0800 (PST)
Date:   Fri, 28 Feb 2020 18:56:11 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Aaron Lu <aaron.lwe@gmail.com>
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
Message-ID: <20200228095534.GA30796@js1304-desktop>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org>
 <20200228032358.GB634650@ziqianlu-desktop.localdomain>
 <20200228040214.GA21040@js1304-desktop>
 <20200228055726.GA674737@ziqianlu-desktop.localdomain>
 <20200228065214.GA17349@js1304-desktop>
 <20200228091700.GA675567@ziqianlu-desktop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228091700.GA675567@ziqianlu-desktop.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 05:17:00PM +0800, Aaron Lu wrote:
> On Fri, Feb 28, 2020 at 03:52:59PM +0900, Joonsoo Kim wrote:
> > On Fri, Feb 28, 2020 at 01:57:26PM +0800, Aaron Lu wrote:
> > > On Fri, Feb 28, 2020 at 01:03:03PM +0900, Joonsoo Kim wrote:
> > > > Hello,
> > > > 
> > > > On Fri, Feb 28, 2020 at 11:23:58AM +0800, Aaron Lu wrote:
> > > > > On Thu, Feb 27, 2020 at 08:48:06AM -0500, Johannes Weiner wrote:
> > > > > > On Wed, Feb 26, 2020 at 07:39:42PM -0800, Andrew Morton wrote:
> > > > > > > It sounds like the above simple aging changes provide most of the
> > > > > > > improvement, and that the workingset changes are less beneficial and a
> > > > > > > bit more risky/speculative?
> > > > > > > 
> > > > > > > If so, would it be best for us to concentrate on the aging changes
> > > > > > > first, let that settle in and spread out and then turn attention to the
> > > > > > > workingset changes?
> > > > > > 
> > > > > > Those two patches work well for some workloads (like the benchmark),
> > > > > > but not for others. The full patchset makes sure both types work well.
> > > > > > 
> > > > > > Specifically, the existing aging strategy for anon assumes that most
> > > > > > anon pages allocated are hot. That's why they all start active and we
> > > > > > then do second-chance with the small inactive LRU to filter out the
> > > > > > few cold ones to swap out. This is true for many common workloads.
> > > > > > 
> > > > > > The benchmark creates a larger-than-memory set of anon pages with a
> > > > > > flat access profile - to the VM a flood of one-off pages. Joonsoo's
> > > > > 
> > > > > test: swap-w-rand-mt, which is a multi thread swap write intensive
> > > > > workload so there will be swap out and swap ins.
> > > > > 
> > > > > > first two patches allow the VM to usher those pages in and out of
> > > > > 
> > > > > Weird part is, the robot says the performance gain comes from the 1st
> > > > > patch only, which adjust the ratio, not including the 2nd patch which
> > > > > makes anon page starting from inactive list.
> > > > > 
> > > > > I find the performance gain hard to explain...
> > > > 
> > > > Let me explain the reason of the performance gain.
> > > > 
> > > > 1st patch provides more second chance to the anonymous pages.
> > > 
> > > By second chance, do I understand correctely this refers to pages on 
> > > inactive list get moved back to active list?
> > 
> > Yes.
> > 
> > > 
> > > > In swap-w-rand-mt test, memory used by all threads is greater than the
> > > > amount of the system memory, but, memory used by each thread would
> > > > not be much. So, although it is a rand test, there is a locality
> > > > in each thread's job. More second chance helps to exploit this
> > > > locality so performance could be improved.
> > > 
> > > Does this mean there should be fewer vmstat.pswpout and vmstat.pswpin
> > > with patch1 compared to vanilla?
> > 
> > It depends on the workload. If the workload consists of anonymous
> 
> This swap-rand-w-mt workload is anon only.

Yes, I know.

> 
> > pages only, I think, yes, pswpout/pswpin would be lower than vanilla
> 
> I think LKP robot has captured these two metrics but the report didn't
> show them, which means the number is about the same with or without
> patch #1.

robot showed these two metrics. See below.

  50190319 ± 31%     -35.7%   32291856 ± 14%  proc-vmstat.pswpin
  56429784 ± 21%     -42.6%   32386842 ± 14%  proc-vmstat.pswpout

pswpin/out are improved.

> > with patch #1. With large inactive list, we can easily find the
> > frequently referenced page and it would result in less swap in/out.
> 
> But with small inactive list, the pages that would be on inactive list
> will stay on active list? I think the larger inactive list is mainly
> used to give the anon page a chance to be promoted to active list now
> that anon pages land on inactive list first, but on reclaim, I don't see
> how a larger inactive list can cause fewer swap outs.

Point is that larger inactive LRU helps to find hot pages and these
hot pages leads to more cache hits.

When a cache hit happens, no swap outs happens. But, if a cache miss
happens, a new page is added to the LRU and then it causes the reclaim
and swap out.

> Forgive me for my curiosity and feel free to ignore my question as I
> don't want to waste your time on this. Your patchset looks a worthwhile
> thing to do, it's just the robot's report on patch1 seems er...

I appreciate your attention. Feel free to ask. :)

Thanks.
