Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AF8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA79021941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mxPEXmvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgIIMtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730210AbgIIMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:33:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6035C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=86Vts+a71dWWDQCbqMDPk65irApXstrc4Jva6mMa9j4=; b=mxPEXmvW6dLmp8afstEn5L2C9x
        UPeTEC2eXMglXiHSyiCYPEcju/5nSSEku/258tGj6XwmFRo2juuyTKL/gyEn2wNL9KGL7KWtkI2PC
        4C4UaVpitfbtAAivQsWxll0iiYJRlmH7fPxy9Llu2e6Bt7PHynaa7lzDP4Wk2boKGjWiYHQjKEauz
        wZePj5P4FfHP+xjSCFSjRpFJB7eNL3pIjfkxRpFkfdJAr/yIzJrSMA1H8fnQbPBU+iR5B6xajg0C5
        1llZnmbI6G7MMs556RfjjfWGuIqcn1M/PloKOmSbOAyc6wZpAEdYQtzFaeFjYx5PfU4AQq2U/Gnlh
        j6HvuvqA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFzHI-0000UW-LE; Wed, 09 Sep 2020 12:32:44 +0000
Date:   Wed, 9 Sep 2020 13:32:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200909123244.GD6583@casper.infradead.org>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908142758.GF27537@casper.infradead.org>
 <20200909121117.GD87483@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909121117.GD87483@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 09:11:17AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 08, 2020 at 03:27:58PM +0100, Matthew Wilcox wrote:
> > I could also see there being an app which benefits from 1GB for
> > one mapping and prefers 2GB for a different mapping, so I think the
> > per-mapping madvise flag is best.
> 
> I wonder if apps really care about the specific page size?
> Particularly from a portability view?

No, they don't.  They just want to run as fast as possible ;-)

> The general app desire seems to be the need for 'efficient' memory (eg
> because it is highly accessed) and I suspect comes with a desire to
> populate the pages too.

The problem with a MAP_GOES_FASTER flag is that everybody sets it.
Any flag name needs to convey its drawbacks as well as its advantages.
Maybe MAP_EXTREMELY_COARSE_WORKINGSET would do that -- the VM will work
in terms of 1GB pages for this mapping, so any swap-out is going to take
out an entire 1GB at once.

But here's the thing ... we already allow
	mmap(MAP_POPULATE | MAP_HUGETLB | MAP_HUGE_1GB)

So if we're not doing THP, what's the point of this thread?
My understanding of THP is "Application doesn't need to change, kernel
makes a decision about what page size is best based on entire system
state and process's behaviour".

An madvise flag is a different beast; that's just letting the kernel
know what the app thinks its behaviour will be.  The kernel can pay
as much (or as little) attention to that hint as it sees fit.  And of
course, it can change over time (either by kernel release as we change
the algorithms, or simple from one minute to the next as more or less
memory comes available).
