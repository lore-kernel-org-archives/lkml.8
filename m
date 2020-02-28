Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC7EC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F756246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL50gsyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgB1F5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:57:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44191 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1F5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:57:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so803028plo.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 21:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDf9PnlhMTvp0FbKUb6+UsCf+ZaA2GDDl1RnDtBBeZI=;
        b=eL50gsywJG992MKjFCmOhRUCrYtWTUJmWmtxdrxt7mFqcVxrkNg0x3teOqBLzQdw3K
         VWPNrokcBU2GIYzIcY391LBG3t94oc2N/HJ6wKXB23vFR6SEElXcjgN5Bu3jhGSQl0jS
         7Ac59+xZsCbE92qkMS60Rkpj+9aPanPdpUqe48G7UEL6oa1MdyA4xbMA7f62t2C7ePkS
         dmlwKGMQeDf7HnQn876QJ3MduAtceFwHqGhJrmAWWxAlGRJWKMDlENOixREQiVQPurqi
         M9e257tapsEG00bbWd34TdUwOhNe34pO0y8xf2LhOn+PvMmVD5RnSaG290fwcnbh9uN9
         +z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDf9PnlhMTvp0FbKUb6+UsCf+ZaA2GDDl1RnDtBBeZI=;
        b=pf0Jb1ehBLLvn9+sk8/mP8TXoywTSU6P/7PIZlgZheeFaPXt1DEvNFJfazMiPhjK7c
         XFny2ivCrfNQu14Rtu8GQg3MLo+KQMpdLR1f3JnAxS6vknodQFHB9SuwVKG0PRpEsfB5
         81UsGETAc2VLoSyOnFBeOg+AORBG89AXgq6Q4eC1i9BVE0MotYzANyH5RsIl6sgA3fOX
         Zbh9TXtkLWXz/yFWSJR4z2OCGR1Y+rE3XhB553kIKee0LpU5WLPTvlN+G3/DAAmMVfIE
         RkmvLEtoYul1Gev7QBMX9C+HpuzT0GVZOxxY9F/OvcsWpgw1Dmd9eL4jNByKRWYDYfns
         vVPQ==
X-Gm-Message-State: APjAAAWKePMidAZfnvR5g2hpH8y4H8Dx9R0qu/EkhQcz34SnBDjmJ5Ik
        znoQZwMVdN7OQQxIoyWQk4M=
X-Google-Smtp-Source: APXvYqznEUWY3wWS/MdUdidtwcMXN0RtzCh1PA1ZfTLGtjXyndHk5rUdxAz92kR3Zl9UYTjn8+sJbw==
X-Received: by 2002:a17:90a:be03:: with SMTP id a3mr2732066pjs.99.1582869455279;
        Thu, 27 Feb 2020 21:57:35 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id d69sm10213247pfd.72.2020.02.27.21.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 21:57:34 -0800 (PST)
Date:   Fri, 28 Feb 2020 13:57:26 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-ID: <20200228055726.GA674737@ziqianlu-desktop.localdomain>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org>
 <20200228032358.GB634650@ziqianlu-desktop.localdomain>
 <20200228040214.GA21040@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228040214.GA21040@js1304-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 01:03:03PM +0900, Joonsoo Kim wrote:
> Hello,
> 
> On Fri, Feb 28, 2020 at 11:23:58AM +0800, Aaron Lu wrote:
> > On Thu, Feb 27, 2020 at 08:48:06AM -0500, Johannes Weiner wrote:
> > > On Wed, Feb 26, 2020 at 07:39:42PM -0800, Andrew Morton wrote:
> > > > It sounds like the above simple aging changes provide most of the
> > > > improvement, and that the workingset changes are less beneficial and a
> > > > bit more risky/speculative?
> > > > 
> > > > If so, would it be best for us to concentrate on the aging changes
> > > > first, let that settle in and spread out and then turn attention to the
> > > > workingset changes?
> > > 
> > > Those two patches work well for some workloads (like the benchmark),
> > > but not for others. The full patchset makes sure both types work well.
> > > 
> > > Specifically, the existing aging strategy for anon assumes that most
> > > anon pages allocated are hot. That's why they all start active and we
> > > then do second-chance with the small inactive LRU to filter out the
> > > few cold ones to swap out. This is true for many common workloads.
> > > 
> > > The benchmark creates a larger-than-memory set of anon pages with a
> > > flat access profile - to the VM a flood of one-off pages. Joonsoo's
> > 
> > test: swap-w-rand-mt, which is a multi thread swap write intensive
> > workload so there will be swap out and swap ins.
> > 
> > > first two patches allow the VM to usher those pages in and out of
> > 
> > Weird part is, the robot says the performance gain comes from the 1st
> > patch only, which adjust the ratio, not including the 2nd patch which
> > makes anon page starting from inactive list.
> > 
> > I find the performance gain hard to explain...
> 
> Let me explain the reason of the performance gain.
> 
> 1st patch provides more second chance to the anonymous pages.

By second chance, do I understand correctely this refers to pages on 
inactive list get moved back to active list?

> In swap-w-rand-mt test, memory used by all threads is greater than the
> amount of the system memory, but, memory used by each thread would
> not be much. So, although it is a rand test, there is a locality
> in each thread's job. More second chance helps to exploit this
> locality so performance could be improved.

Does this mean there should be fewer vmstat.pswpout and vmstat.pswpin
with patch1 compared to vanilla?

Thanks.
