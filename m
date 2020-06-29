Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6220F206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FcgBnyLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgF2SzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgF2Sy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:57 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40804C031C40
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rHCxMAr5/QRYYlY+wj4xHleNaD2XeEWYXXCLc6cZruE=; b=FcgBnyLz9Fx+QZO0k3eTm2zZzp
        8EVRqSvt68Krztk0t+uF3tZ21nrcR1yz6hb0G88EzU0qqx9cCe9VWnNBQuZ9EsQON5xIA5iUPrlrI
        UgQ2Q9LXVVjtgKQaAm56BbNT9kDyk0OL6M5HuFqTqSi84OWOamE+BGgDJRAMU5uxhaaR5WZigdX5S
        l3NjtpOxj3DDE8aCdHpgY3vrdxRtd+qyX0keOdatEC/OrFDi/KyyOCSr+haxFZA8JYKTgqSxUVuNX
        mIKdaHVxqriwZ2wsLyjmf2ZqRXLSpA139CGNu1kmPexQ2Lh9oLG761UH4YTiXpRZpYW0rmrrUKIi2
        +N9eW0Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyvK-00006r-AV; Mon, 29 Jun 2020 18:54:35 +0000
Date:   Mon, 29 Jun 2020 19:54:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org
Subject: Re: [PATCH] hugetlb: fix pages per hugetlb calculation
Message-ID: <20200629185434.GI25523@casper.infradead.org>
References: <20200629185003.97202-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629185003.97202-1-mike.kravetz@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:50:03AM -0700, Mike Kravetz wrote:
> The routine hpage_nr_pages() was incorrectly used to calculate the
> number of base pages in a hugetlb page.  hpage_nr_pages is designed
> to be called for THP pages and will return HPAGE_PMD_NR for hugetlb
> pages of any size.
> 
> Due to the context in which hpage_nr_pages was called, it is unlikely
> to produce a user visible error.  The routine with the incorrect call
> is only exercised in the case of hugetlb memory error or migration.
> In addition, this would need to be on an architecture which supports
> huge page sizes less than PMD_SIZE.  And, the vma containing the huge
> page would also need to smaller than PMD_SIZE.
> 
> Fixes: c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization")
> Cc: stable@kernel.org
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Inadvertently-Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>

