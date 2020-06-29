Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DC920842
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vgyw8ooe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgF2Tmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbgF2Tmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0DFC02F01C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2qpcCa8MJg4RGNN56Q/d+ivYnFyOiwqo1KyRA7BzBV0=; b=vgyw8ooeBxvbbx1tvGAqheUNpE
        iZm0cPR07NIHG88nl21+XoWVDFANiLlRND6iBxJr7mLKh/64vEy/ByvsVvp5Ha5GuEmA8DfCCSNHh
        yd9yeSfEplwNyhkTrJRg22LHUmOVBeLx8vVFgx01np+u8kynp5NmZIXGrXQ4t6EDDS5zVXjcwQpi1
        pjTOrWQNGJAdVq3sGLX/bb5XiqlVrv6PmZyAGWkyYF/R10vHSuaCGFnguuqBrwInV6dEY380+4Ngc
        fzzcNRM79hCVFnyavLL00eNYmD3dir0sKvN8fLZVx9FMUWAsolwiYBZbePDHfa6CE9vP9iF2T4oev
        oU4cYKAw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpv9X-0002I4-HS; Mon, 29 Jun 2020 14:52:59 +0000
Date:   Mon, 29 Jun 2020 15:52:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Long Li <lonuxli.64@gmail.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm:free unused pages in kmalloc_order
Message-ID: <20200629145259.GD25523@casper.infradead.org>
References: <20200627045507.GA57675@lilong>
 <alpine.DEB.2.22.394.2006291446560.27163@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006291446560.27163@www.lameter.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:48:06PM +0000, Christopher Lameter wrote:
> On Sat, 27 Jun 2020, Long Li wrote:
> > Environment using the slub allocator, 1G memory in my ARM32.
> > kmalloc(1024, GFP_HIGHUSER) can allocate memory normally,
> > kmalloc(64*1024, GFP_HIGHUSER) will cause a memory leak, because
> > alloc_pages returns highmem physical pages, but it cannot be directly
> > converted into a virtual address and return NULL, the pages has not
> > been released. Usually driver developers will not use the
> > GFP_HIGHUSER flag to allocate memory in kmalloc, but I think this
> > memory leak is not perfect, it is best to be fixed. This is the
> > first time I have posted a patch, there may be something wrong.
> 
> Highmem is not supported by the slab allocators. Please ensure that there
> is a warning generated if someone attempts to do such an allocation. We
> used to check for that.

Sounds like we need a test somewhere that checks this behaviour.

> In order to make such allocations possible one would have to create yet
> another kmalloc array for high memory.

Not for this case because it goes straight to kmalloc_order().  What does
make this particular case impossible is that we can't kmap() a compound
page.  We could vmap it, but why are we bothering?
