Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16B7C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD0222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhKQSXHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgB1GxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:53:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39205 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgB1GxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:53:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id l7so1225343pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8jcqmZWRuzpY+irIgL2xLgBa8KgqT66J5i07241XqA0=;
        b=LhKQSXHnNWOgbv3WUG1Q+LWA6Bvl74g6d/7JfQDofL2rVfpY9oWb+uCJ8l7L3SwmSH
         oaFoK5hORHEaNN1nWVtl9MR2hbyjh8YUrHDuGpC/7uU8Ojc2PaeuwOp2p8Y4ozAxvWLh
         xOQx2ncZkgSzpKzmK4tP/hoD3U0f7XM7lGSAeGhzHeh7crMQo9lpDo5ZNLru5a9Q+Srd
         Zsbd7NXfMxZdmxVU7x7NcDMSM8sKf1IXQnIQTFOn6yxtRVAMt6Vx+5UiU/QGaOJ1lJRl
         97Jm83mYUxenTTcpiB75oy6nlX45oagdNE6fhUaeP00Jt8Jtp04uuM/cTp2FV5vQbfQZ
         kuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8jcqmZWRuzpY+irIgL2xLgBa8KgqT66J5i07241XqA0=;
        b=WrClrsrAlGqgVptVa2Hn83cxut0Qa0JfrrSdp7JO4UuEKFSBLYM00TABlaaOy0CA4z
         JtesZZg1sqRKiVhpf0QzF7JOgtnM4Ymoos924734x5Ycb3990WJk95iZmHGE8Oo0v+5h
         7OuhqBavXnStsuwgRf+YCol6eA+ZTZ0TOBolB9Mf87HCpC+fiID7mQF52EiDvNpMzqUs
         PTc7Sh7gPTrYWOpWgiyHmWrbCy7gJ6kAoM44p6AcLuTvk6oUu/P40hWTiWEox87vSH1p
         w+mVXS8ktNgDZuKWD5bVD3UBw4c32Aarih7R77DfaUvgwebV5iQrSvQipfjjuWhFXip+
         c8Mg==
X-Gm-Message-State: APjAAAV5lyJ+IYdR3FTpdsnRuniVG0HXShsQu6VOopNHCs041Xw0+ZkD
        kICEQFTNEaTkKJnRii3X3ts=
X-Google-Smtp-Source: APXvYqx6DjkvLom4D6+eR+vEt1Vpx0hDeuYho2m4pWKvA3y2g5GgIXfU5+/m2UvNIh08vbHcXWeNaQ==
X-Received: by 2002:a63:7e09:: with SMTP id z9mr3121039pgc.383.1582872786530;
        Thu, 27 Feb 2020 22:53:06 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id b3sm9829932pft.73.2020.02.27.22.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:53:05 -0800 (PST)
Date:   Fri, 28 Feb 2020 15:52:59 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-ID: <20200228065214.GA17349@js1304-desktop>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org>
 <20200228032358.GB634650@ziqianlu-desktop.localdomain>
 <20200228040214.GA21040@js1304-desktop>
 <20200228055726.GA674737@ziqianlu-desktop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228055726.GA674737@ziqianlu-desktop.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 01:57:26PM +0800, Aaron Lu wrote:
> On Fri, Feb 28, 2020 at 01:03:03PM +0900, Joonsoo Kim wrote:
> > Hello,
> > 
> > On Fri, Feb 28, 2020 at 11:23:58AM +0800, Aaron Lu wrote:
> > > On Thu, Feb 27, 2020 at 08:48:06AM -0500, Johannes Weiner wrote:
> > > > On Wed, Feb 26, 2020 at 07:39:42PM -0800, Andrew Morton wrote:
> > > > > It sounds like the above simple aging changes provide most of the
> > > > > improvement, and that the workingset changes are less beneficial and a
> > > > > bit more risky/speculative?
> > > > > 
> > > > > If so, would it be best for us to concentrate on the aging changes
> > > > > first, let that settle in and spread out and then turn attention to the
> > > > > workingset changes?
> > > > 
> > > > Those two patches work well for some workloads (like the benchmark),
> > > > but not for others. The full patchset makes sure both types work well.
> > > > 
> > > > Specifically, the existing aging strategy for anon assumes that most
> > > > anon pages allocated are hot. That's why they all start active and we
> > > > then do second-chance with the small inactive LRU to filter out the
> > > > few cold ones to swap out. This is true for many common workloads.
> > > > 
> > > > The benchmark creates a larger-than-memory set of anon pages with a
> > > > flat access profile - to the VM a flood of one-off pages. Joonsoo's
> > > 
> > > test: swap-w-rand-mt, which is a multi thread swap write intensive
> > > workload so there will be swap out and swap ins.
> > > 
> > > > first two patches allow the VM to usher those pages in and out of
> > > 
> > > Weird part is, the robot says the performance gain comes from the 1st
> > > patch only, which adjust the ratio, not including the 2nd patch which
> > > makes anon page starting from inactive list.
> > > 
> > > I find the performance gain hard to explain...
> > 
> > Let me explain the reason of the performance gain.
> > 
> > 1st patch provides more second chance to the anonymous pages.
> 
> By second chance, do I understand correctely this refers to pages on 
> inactive list get moved back to active list?

Yes.

> 
> > In swap-w-rand-mt test, memory used by all threads is greater than the
> > amount of the system memory, but, memory used by each thread would
> > not be much. So, although it is a rand test, there is a locality
> > in each thread's job. More second chance helps to exploit this
> > locality so performance could be improved.
> 
> Does this mean there should be fewer vmstat.pswpout and vmstat.pswpin
> with patch1 compared to vanilla?

It depends on the workload. If the workload consists of anonymous
pages only, I think, yes, pswpout/pswpin would be lower than vanilla
with patch #1. With large inactive list, we can easily find the
frequently referenced page and it would result in less swap in/out.

Thanks.
