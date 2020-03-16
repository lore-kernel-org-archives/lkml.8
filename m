Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B79C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1AE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ogCPnHc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgCPIyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:54:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbgCPIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YMlc//ixq3XAz7bfU0iD/j/ZWWxHdyHVImyXy4+oj0w=; b=ogCPnHc8p7k5lQZBIXRcSs4Vtj
        hSpr0xLcM6zm2Q96u233tsR/wyxtUEzekj5Cc5cl6ro8AbRkl7dwiuVs2cv99SY2DERFiokTi7Ql6
        WoDNj23VZ3e9297ZfSxiKEcfRGPdeVxoEzd4uDWjDf2gQdLAtLU5EvSAwTf+ucjjwLvDRV3vLkVoD
        pDnK4L/kNyqnmK+yL8xW6e1VPius7Qi3ze3rWSPCuIOcefGMbjJ/ctX4e+hlng47ZPNSqUXCzMaIe
        XWYVrMgAZA/+lKQGCI8a3rIOU5Dyr9acWqr8LgvRjJDMRBAo6/WN04LT5217b+J1MtIMA+T1ql2xw
        4LMc1Ehg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDlVl-0001ty-Hu; Mon, 16 Mar 2020 08:54:13 +0000
Date:   Mon, 16 Mar 2020 01:54:13 -0700
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
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 1/3] mm/gup: rename nr as nr_pinned in
 get_user_pages_fast()
Message-ID: <20200316085413.GA1831@infradead.org>
References: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
 <1584333244-10480-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584333244-10480-2-git-send-email-kernelfans@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 12:34:02PM +0800, Pingfan Liu wrote:
> To better reflect the held state of pages and make code self-explaining,
> rename nr as nr_pinned.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
