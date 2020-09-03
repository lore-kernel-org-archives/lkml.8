Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01828C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D718D20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K4bZxN0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgICQ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgICQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:56:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE9C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/1m8FD1Bq3sHl8yu7KCZle+Y3qYoxUKr4gtXUdv0gU0=; b=K4bZxN0zw+2ODOI2cR/HKfTdze
        iSDfdYhJwVooo4MfVxihgS9MLK05R8QxClTPDRG9vku7evCr0Mt8/9+qe5wSJXWWNxuBRR8deu+VH
        rETQn4cRd2SjZ22XhUAc3cK+7OKfNF9Tgn9rnizYPrA/JZ5Eoz5hodDM5LSiZrewZE5bhKxP0Jwoh
        eSy8ejsJy7ANqnPWvse0/hS2+VoaHh2013j6V30h/yIVBrzDVYpqnft2cNga0C5n/DMnLHs2MJzFA
        tZ2xMGZ3qfF6xkfs5OO0z4r2S1uecvdU2BoBPIhut/5KNaGg7wvlWw5O48+ZL3iplW+P/aDCi+gNc
        Jnn3KPtg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDsWl-0006eQ-PQ; Thu, 03 Sep 2020 16:55:59 +0000
Date:   Thu, 3 Sep 2020 17:55:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903165559.GD14765@casper.infradead.org>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902184053.GF24045@ziepe.ca>
 <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
 <20200902184852.GH24045@ziepe.ca>
 <C5EFA1CC-311C-47D5-9506-D087D9AE58D1@nvidia.com>
 <20200902195739.GI24045@ziepe.ca>
 <C12C60A2-43EA-4AD3-9077-FFB61CCC964C@nvidia.com>
 <20200903164032.GM24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903164032.GM24045@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:40:32PM -0300, Jason Gunthorpe wrote:
> However if the sizeof(*pXX) is 8 on a 32 bit platform then load
> tearing is a problem. At lest the various pXX_*() test functions
> operate on a single 32 bit word so don't tear, but to to convert the
> *pXX to a lower level page table pointer a coherent, untorn, read is
> required.
> 
> So, looking again, I remember now, I could never quite figure out why
> gup_pmd_range() was safe to do:
> 
>                 pmd_t pmd = READ_ONCE(*pmdp);
> [..]
>                 } else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
> [..]
>         ptem = ptep = pte_offset_map(&pmd, addr);
> 
> As I don't see what prevents load tearing a 64 bit pmd.. Eg no
> pmd_trans_unstable() or equivalent here.

I don't think there are any 32-bit page tables which support a PUD-sized
page.  Pretty sure x86 doesn't until you get to 4- or 5- level page tables
(which need you to be running in 64-bit mode).  There's not much utility
in having 1GB of your 3GB process address space taken up by a single page.

I'm OK if there are some oddball architectures which support it, but
Linux doesn't.
