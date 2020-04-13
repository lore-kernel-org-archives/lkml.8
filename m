Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB7C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638C32073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IIjP61BG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgDMNe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:34:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgDMNez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jqFyF+Qkv728WejXRPzLGFyWUEajDNdOQOunjo8qzkk=; b=IIjP61BGLSRSTL1For7dpJyFXF
        GJYQR9Bs7CQ5m5GF7aF60GsTqwYCVOLqvYv5A6y2sKAjwnwKXz51Jkz5CUEeYZWJ/xIwegh5p4Fye
        tRUcl6EdEdFBI0gLKC48+jpU9iKYAPLIOmWiHW1fd3NwxUCJZazlhTnFz4om643rN+pi/sBj85KGb
        VHcidbpAUv9ONepY+OThp6nfw7aLJrWs74MSNZSR+4mZY4yuTKFMnh0Dk7aiaSA1sjBmG7ORx+6Uo
        kPk/Dq0Zx8xWptNHSTRoDArc2vGI+t9USHqjBQJ7HANPMlLfAkxUNkjUbfzstUuOwOEQTJbK+ygnG
        nY5A+VHQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNzEa-0003wD-Ft; Mon, 13 Apr 2020 13:34:44 +0000
Date:   Mon, 13 Apr 2020 06:34:44 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/4] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
Message-ID: <20200413133444.GM21484@bombadil.infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125303.423864-2-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:53:00PM +1000, Nicholas Piggin wrote:
> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
> Whether or not a vmap is huge depends on the architecture details,
> alignments, boot options, etc., which the caller can not be expected
> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
> 
> This change teaches vmalloc_to_page about larger pages, and returns
> the struct page that corresponds to the offset within the large page.
> This makes the API agnostic to mapping implementation details.

I'm trying to get us away from returning tail pages from various
functions.  How much of a pain would it be to return the head page
instead of the tail page?  Obviously the implementation gets simpler,
but can the callers cope?  I've been focusing on the page cache, so I
haven't been looking at the vmalloc side of things at all.
