Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA99C20748
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dbCCC3Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHJWry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgHJWry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:47:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K3+SuTqg7entB9Y6bJ/tYvrfsYaRjh4IcY0CFouemU4=; b=dbCCC3Y6qjK93UrfiO2J5XwTOV
        dCmS8V+l1Di/pbiahsxif2AmynjKHPUmQn7JYJfI8E8Tr5Csts/lu19dJxNqgZYlU9vK6YvrzQ7Gt
        OAcHkVk+47zbr06HOVW2xpoX0gCP5zek2fh8VaVj2RweAbqrbdjnp6R1C+tHNefDoFb3uQP4xfSzJ
        +r6zCH2XUegfWBtkPGyRUocEClOIqrYK7UOLCzG81Zex60WUhwWliGw8PO58fd4i7L/tL5QETWFy2
        SbwkY1hhw8waRI/tVxrD5pVUB4HZn/Ss7SCi5nhhZnyrKtLvyIlvmaLIdiKi8bTbSRP+NtLS6t/rb
        4aCQ7afA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5GZr-0005c1-S3; Mon, 10 Aug 2020 22:47:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDE8F980BF8; Tue, 11 Aug 2020 00:47:34 +0200 (CEST)
Date:   Tue, 11 Aug 2020 00:47:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, acme@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH V6 01/16] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20200810224734.GO3982@worktop.programming.kicks-ass.net>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-2-kan.liang@linux.intel.com>
 <b5422d70-f5d3-f2eb-0b39-4efd050d8828@intel.com>
 <298cfc4d-4a9b-7886-1006-09f2bc24d789@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298cfc4d-4a9b-7886-1006-09f2bc24d789@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 06:38:35PM -0400, Liang, Kan wrote:
> On 8/10/2020 5:47 PM, Dave Hansen wrote:

> > It's probably best if we very carefully define up front what is getting
> > reported here.  For instance, I believe we already have some fun cases
> > with huge tmpfs where a compound page is mapped with 4k PTEs.  Kirill
> > also found a few drivers doing this as well.  I think there were also
> > some weird cases for ARM hugetlbfs where there were multiple hardware
> > page table entries mapping a single hugetlbfs page.  These would be
> > cases where compound_head() size would be greater than the size of the
> > leaf paging structure entry.
> > 
> > This is also why we have KerelPageSize and MMUPageSize in /proc/$pid/smaps.
> > 
> > So, is this returning the kernel software page size or the MMU size?
> > 
> 
> This tries to return the kernel software page size. I will add a commit to
> the function. For the above cases, I think they can be detected by
> PageCompound(page). The current code should already cover them. Is my
> understanding correct?

But the rationale for the whole feature was to measure and possibly
drive large page promotion/demotion, which requires the mmu page-size.

