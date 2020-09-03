Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE66EC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC8D2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dTBR0NUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgICRCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgICRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:02:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C3C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zMmFLPhqWER0OTsSWmmyqG3pphhSoq3FXbT4jT7kkiE=; b=dTBR0NUVGVuwmwqmdzhccoXx6r
        5r2nFdbvndAHYrvjwpj2ZMEpF3jDwgE4dt3agLUWBfAzFmEKev7/8ocuqebdks0QUr5i410WCUxxH
        N4TnhSRYDsiRxJm0vMbeLWjGQxVP6z1pY6TsmgxSdgCanRMHE++pHrj8kdp6zhGK7kV1uHoxpTXaD
        PzLxDqodxaV6gu4I4u0VKLS2t7EgqV/2fpfClv2ZzQ0wSVfD4CvF/YnTDQ3x6E/6WX8tOSnlepUJO
        cHNznnLQ9KP5Z7aOb57vWpiCUNlxHaSk/1syoM288tSpw5nfFBcy1aQKHc+Z6fdtz99yaBxdzbs9G
        OyfQpQBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDscX-00074S-AB; Thu, 03 Sep 2020 17:01:57 +0000
Date:   Thu, 3 Sep 2020 18:01:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903170157.GE14765@casper.infradead.org>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
 <20200903165051.GN24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903165051.GN24045@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:50:51PM -0300, Jason Gunthorpe wrote:
> At least from a RDMA NIC perspective I've heard from a lot of users
> that higher order pages at the DMA level is giving big speed ups too.
> 
> It is basically the same dynamic as CPU TLB, except missing a 'TLB'
> cache in a PCI-E device is dramatically more expensive to refill. With
> 200G and soon 400G networking these misses are a growing problem.
> 
> With HPC nodes now pushing 1TB of actual physical RAM and single
> applications basically using all of it, there is definately some
> meaningful return - if pages can be reliably available.
> 
> At least for HPC where the node returns to an idle state after each
> job and most of the 1TB memory becomes freed up again, it seems more
> believable to me that a large cache of 1G pages could be available?

You may be interested in trying out my current THP patchset:

http://git.infradead.org/users/willy/pagecache.git

It doesn't allocate pages larger than PMD size, but it does allocate pages
*up to* PMD size for the page cache which means that larger pages are
easier to create as larger pages aren't fragmented all over the system.

If someone wants to opportunistically allocate pages larger than PMD
size, I've put some preliminary support in for that, but I've never
tested any of it.  That's not my goal at the moment.

I'm not clear whether these HPC users primarily use page cache or
anonymous memory (with O_DIRECT).  Probably a mixture.
