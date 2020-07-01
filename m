Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C3CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A3C20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpBD0gAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgGAPYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbgGAPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:24:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18F3C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g7jjQg54WNq1SN5Cryc74qFMajeVaxInmN7DE9gipZY=; b=gpBD0gAU9h3s5AkQVqbwm5plpx
        i8xSODhrYW7x0JAq8BFcruUeQjbx8Rjp5T43/asALpzcGcBkHxCuoh4XrlSZAdkNplINDySfqsdKh
        c/sKxxDoQBeyMZ9M+laNTV3DCDmVvjC2M9lXSppa6sTJY7R8TSlaK+MJzTqAsRT34WGYOzqw2A9bs
        ohOGiMu8N6qFT1Eld7g5weo+jz4bHkLZcSGpbF+ua3onYTBFa4KE8ClmQO3FQTllmPzmRgBW3Fh9H
        VPMFw4IUQsDHi4ihd6AVP0cb70mcp6AGs3pwt7KbhgZsyn4Q/XBdUAfXHzDTiL2P78r/ALyRtkhEG
        zwzfmB7A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqeb5-00040U-6K; Wed, 01 Jul 2020 15:24:27 +0000
Date:   Wed, 1 Jul 2020 16:24:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Long Li <lonuxli.64@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, slab: Check GFP_SLAB_BUG_MASK before alloc_pages
 in kmalloc_order
Message-ID: <20200701152427.GS25523@casper.infradead.org>
References: <20200701151645.GA26223@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701151645.GA26223@lilong>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 03:16:45PM +0000, Long Li wrote:
> kmalloc cannot allocate memory from HIGHMEM.  Allocating large amounts
> of memory currently bypasses the check and will simply leak the memory
> when page_address() returns NULL.  To fix this, factor the
> GFP_SLAB_BUG_MASK check out of slab & slub, and call it from
> kmalloc_order() as well. In order to make the code clear, the warning
> message is put in one place.
> 
> Signed-off-by: Long Li <lonuxli.64@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
