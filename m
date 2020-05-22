Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421ABC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1588120825
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/5/rz0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgEVBQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVBQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:16:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B7CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 18:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f2s5odHQw6uTCgXrfk2HuZPh6AawOvx7KQxg5Yxb65k=; b=S/5/rz0f0ZckO8sFQWboHKGGi3
        4WGvUJaz0VDiZOXrWm8+1F8HFrVm6ckWfZgBy8svxUY/BH51uCq1WCf3nC1s0aBf/QDComjwU9OTn
        esDpdCqoedW8NM9apLE4Ljf6o//aqBuABcDV86QW0QbUQSTPdgW8rPiUhxsoqaezppD46CYfzrUG7
        gAqRVmnv+MITPXcAtFeFsb2TyGn1q/XVsCYfPlI2SsyxycbgftXfUkxsIHmhbyhlnIL2qyaVY+dDq
        mi9ylHygZNM3GNVsmGwYp0J6Z/ahwMgMY96M+lP7m2z8Vhod6E+x9o7g+m30QsrwlIzezu/6l4FHA
        KZAwh9tw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbwI4-0006PT-GU; Fri, 22 May 2020 01:16:00 +0000
Date:   Thu, 21 May 2020 18:16:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jgg@ziepe.ca,
        Liam.Howlett@oracle.com, daniel.m.jordan@oracle.com,
        dave@stgolabs.net, hughd@google.com, jglisse@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org, rientjes@google.com,
        vbabka@suse.cz, walken@google.com, yinghan@google.com
Subject: Re: [PATCH] mm/gup: might_lock_read(mmap_sem) in
 get_user_pages_fast()
Message-ID: <20200522011600.GJ28818@bombadil.infradead.org>
References: <20200522010443.1290485-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522010443.1290485-1-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 06:04:43PM -0700, John Hubbard wrote:
> Instead of scattering these assertions across the drivers,
> do this assertion inside the core of get_user_pages_fast*()
> functions. That also includes pin_user_pages_fast*()
> routines.
> 
> Add a might_lock_read(mmap_sem) call to internal_get_user_pages_fast().
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>

Yup, this is exactly what I meant.  Feel free to transform this into
an Acked-by: or Reviewed-by: if that's the appropriate tag.

Thanks, John!
