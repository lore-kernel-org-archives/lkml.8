Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DCFC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AB8206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aB/oSUg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgDCSxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:53:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VqvVhPvHFq4lBIHfv0NJ8OXLyWZIl0c+q0r5PoMjHew=; b=aB/oSUg/BG9dAe19FX/m3mnB7F
        vXYmVWdoSHIr4uDgi+qE+BkoSyQY6gLVwu+zVsw1BiZYnUklnWcJAfY0eNq+B1wB2+eGzsA/ozmMm
        IZ63gA2/ylClwDhYdjDCiYD3Nj8pmmY6eDzx3an6YkCNQly0aCxIOUpsUJ8y8NtNco1ULgNbpcF1e
        qRte2mA/3gDRCg0+PZUKb22MzR2ZU3KO05oG1LYt4e3aGw0G3NOnMJw7GRIEX1G44zwxbNdEMACG7
        OIW0cuB1346hEQrSQKGcvtWmOgWwnC9tx3JqRO1dJ4QcNY/zVfdLtntqnNbGG5KYWSkt0m3Pm24Al
        27I8oXYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKRR9-0005W2-Ob; Fri, 03 Apr 2020 18:53:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2026E3010BC;
        Fri,  3 Apr 2020 20:53:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 014AB2B124C7F; Fri,  3 Apr 2020 20:53:00 +0200 (CEST)
Date:   Fri, 3 Apr 2020 20:53:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200403185300.GD20730@hirez.programming.kicks-ass.net>
References: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
 <20200403181818.GA5538@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403181818.GA5538@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 08:18:18PM +0200, Uladzislau Rezki wrote:
> On Fri, Apr 03, 2020 at 06:32:53PM +0200, Peter Zijlstra wrote:
> > 
> > __get_vm_area() is an exported symbol, make sure the callers stay in
> > the expected memory range. When calling this function with memory
> > ranges outside of the VMALLOC range *bad* things can happen.
> > 
> > (I noticed this when I managed to corrupt the kernel text by accident)
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  mm/vmalloc.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2130,6 +2130,13 @@ static struct vm_struct *__get_vm_area_n
> >  struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
> >  				unsigned long start, unsigned long end)
> >  {
> > +	/*
> > +	 * Ensure callers stay in the vmalloc range.
> > +	 */
> > +	if (WARN_ON(start < VMALLOC_START || start > VMALLOC_END ||
> > +		    end < VMALLOC_START || end > VMALLOC_END))
> > +		return NULL;
> > +
> >  	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
> >  				  GFP_KERNEL, __builtin_return_address(0));
> >  }
> Peter, could you please clarify what kind of issues you had and how you
> tested?

Well, I had a bug and corrupted text; but then I tested:

	__get_vm_area(PAGE_SIZE, VM_ALLOC, __START_KERNEL_map,
		      __START_KERNEL_map + KERNEL_IMAGE_SIZE);

and that *works*.

> __get_vm_area() is not limited by allocating only with vmalloc space,
> it can use whole virtual address space/range, i.e. 1 - ULONG_MAX.

Yeah, I know, I'm saying it perhaps should be, because not limiting it
while exposing it to modules seems risky at best, downright dangerous if
you consider map_vm_area() is also exported.

And while I know the machinery works for the complete virtual address
space, architectures do set aside explicit VA ranges for specific
purposes, we had better respect that, esp. for modules.


