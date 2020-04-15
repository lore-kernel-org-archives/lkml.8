Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D87CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1392076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586987084;
	bh=d70WE9UrG3WG2ng9rKQE35xkTHOeB3Njfu1omBSNyRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aZWoEHCuNnah+EozfoxAKI6ia0uC6FMWcm3/ieY2SIiF5EJA51pgSvWJAcl1emI77
	 GGrOCBaVvWKLenuzvxNnf+1SOKqM1X1Xk3xGMmJdjO3osQnlAh+bpEvgyBdLbJ0N9X
	 PRDKL/60ZFv1kdb1oUfTB1yVZAjvGPAIA+iIm1BE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgDOVok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730409AbgDOVo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:44:29 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF8B2076C;
        Wed, 15 Apr 2020 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586987067;
        bh=d70WE9UrG3WG2ng9rKQE35xkTHOeB3Njfu1omBSNyRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vv6K5mdGmd/tAm9iNBNZO+qoEN/QyNrfO/tcJVi+jO+e318ZSnVlh3a7LaFjvzYxP
         Hg0aPElrm+JCbdWq9R49xgZt3N/ZJfgz4jszW8zlBcfl9JX5+PTRhhlNi01fwNO20+
         IfqccJ45QkqnX+0Zgl3VuuM/GdgPGCoa+e6ZkelU=
Date:   Wed, 15 Apr 2020 14:44:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3, RESEND 6/8] khugepaged: Allow to collapse PTE-mapped
 compound pages
Message-Id: <20200415144426.a146ef173140f5bc396a6dcd@linux-foundation.org>
In-Reply-To: <20200413125220.663-7-kirill.shutemov@linux.intel.com>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
        <20200413125220.663-7-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 15:52:18 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> We can collapse PTE-mapped compound pages. We only need to avoid
> handling them more than once: lock/unlock page only once if it's present
> in the PMD range multiple times as it handled on compound level. The
> same goes for LRU isolation and putback.
> 
> ...
>
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -515,17 +515,30 @@ void __khugepaged_exit(struct mm_struct *mm)
>  
>  static void release_pte_page(struct page *page)
>  {
> -	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));

I have

	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_lru(page));

here.  Is there some prerequisite which I wasn't able to find?


