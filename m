Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90061C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DBE2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TUVADCLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCQMJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:09:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgCQMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q/GK4+6m5lw1qmSosNNukTctCn2OhFMDvaxhnUz5s/E=; b=TUVADCLrKEE8VyknwEYEQ0UYdT
        u9A/5XJjJrnMqqk+qjL1RIZthjoUtX+eBU+A7CfInYWhqGjFymvbMciO2wZSoVjMxQAdUD8OH4THK
        0AkBL1KPEfz+2CzB8rMplaOk9iP8TFZ2VpEfCJiFY7ybjLpoza7xNmXcvXuPeibzE+BHKF4y8K4mN
        ZF1fUAxQPe49+lYj1MZm/5nsJPwZkmcHV4niOD1KJk12OyykwGR1CmTbgTBNfOv2wpeHpPwSA8j/Z
        IGScVWlfuQlVUMJbxVwvZJ3NRR93X8yz0NBQqDmLmTCRKYUrcS3MfMPt/tAZe1K7oOI3cnVDZf0Yu
        zdbk9eVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEB2I-0000M8-F7; Tue, 17 Mar 2020 12:09:30 +0000
Date:   Tue, 17 Mar 2020 05:09:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
Message-ID: <20200317120930.GA435@infradead.org>
References: <1584333244-10480-3-git-send-email-kernelfans@gmail.com>
 <1584445652-30064-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584445652-30064-1-git-send-email-kernelfans@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 07:47:32PM +0800, Pingfan Liu wrote:
> FOLL_LONGTERM is a special case of FOLL_PIN. It suggests a pin which is
> going to be given to hardware and can't move. It would truncate CMA
> permanently and should be excluded.
> 
> In gup slow path, slow path, where
> __gup_longterm_locked->check_and_migrate_cma_pages() handles FOLL_LONGTERM,
> but in fast path, there lacks such a check, which means a possible leak of
> CMA page to longterm pinned.
> 
> Place a check in try_grab_compound_head() in the fast path to fix the leak,
> and if FOLL_LONGTERM happens on CMA, it will fall back to slow path to
> migrate the page.
> 
> Some note about the check:
> Huge page's subpages have the same migrate type due to either
> allocation from a free_list[] or alloc_contig_range() with param
> MIGRATE_MOVABLE. So it is enough to check on a single subpage
> by is_migrate_cma_page(subpage)

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
