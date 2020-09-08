Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB37C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAD620658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W+uOF5lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgIHUB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgIHPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B0C08E81C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PZzhQ0xmyYQfpMHZHHd5GnNzCAYxpC+A+FV7AXwOMKk=; b=W+uOF5lY/tdopsPjRe7mLKmCri
        Acosr5r5YgVfCysuQzVEVljjY71K0wpXTumufCEw9J3hZYs4vwRrQx4uOaBlttSxcPQXrSy8WTYt9
        Tt/rnLknYq58ExB5vxP+4AlBk7Vs7u0mqoJORLoUhzLKx9mqd68KEI2QSmKABMGURfsbr3MdG3M+Z
        Rg6e/I4A6U4J/c6N/ySpxq2ZUjqFx8wN+2seTp4JjYtk/h1GtAtPazH3cSIuMKRt7VV+YKR4Tw/kB
        NTEeILB2jzDGa90U8tyZXfuv48xQs3MSZHpA4ofe2nJaio68SM7CY8L8n18c1zPDKRFACnf0//BY1
        usF5PQ8w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFebH-0001aI-3c; Tue, 08 Sep 2020 14:28:27 +0000
Date:   Tue, 8 Sep 2020 15:27:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200908142758.GF27537@casper.infradead.org>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:05:11AM -0400, Zi Yan wrote:
> On 8 Sep 2020, at 7:57, David Hildenbrand wrote:
> > I have concerns if we would silently use 1~GB THPs in most scenarios
> > where be would have used 2~MB THP. I'd appreciate a trigger to
> > explicitly enable that - MADV_HUGEPAGE is not sufficient because some
> > applications relying on that assume that the THP size will be 2~MB
> > (especially, if you want sparse, large VMAs).
> 
> This patchset is not intended to silently use 1GB THP in place of 2MB THP.
> First of all, there is a knob /sys/kernel/mm/transparent_hugepage/enable_1GB
> to enable 1GB THP explicitly. Also, 1GB THP is allocated from a reserved CMA
> region (although I had alloc_contig_pages as a fallback, which can be removed
> in next version), so users need to add hugepage_cma=nG kernel parameter to
> enable 1GB THP allocation. If a finer control is necessary, we can add
> a new MADV_HUGEPAGE_1GB for 1GB THP.

I think we do need that flag.  Machines don't run a single workload
(arguably with VMs, we're getting closer to going back to the single
workload per machine, but that's a different matter).  So if there's
one app that wants 2MB pages and one that wants 1GB pages, we need to
be able to distinguish them.

I could also see there being an app which benefits from 1GB for
one mapping and prefers 2GB for a different mapping, so I think the
per-mapping madvise flag is best.

I'm a little wary of encoding the size of an x86 PUD in the Linux API
though.  Probably best to follow the example set in
include/uapi/asm-generic/hugetlb_encode.h, but I don't love it.  I
don't have a better suggestion though.
