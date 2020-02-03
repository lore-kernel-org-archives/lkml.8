Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D834FC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB26A2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JzREuCGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgBCR3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:29:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgBCR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gFDzfUt/zIrwKYXfbfbbfiYoV5dvTOmOKE3QH7upgwE=; b=JzREuCGKb6Jh0bEUWRoficKAvf
        rdEsn/r/MyvDseFhxLc13AWyXPQfqAsNyWGRA5cpxBup+/+RNtoK6sQm6TD2NczVw6ckX7ecAGeaY
        6gO12yzT+iNxkEyAo9zrI8htTxdFbqAvWDQOUYOoS0Nm8FvtoPPVm8zOcJojLnegnB5CgK1sSieoG
        J0gn5SHn6oyKQ8GhtzlJaHaAe84StwMwMza0OSE4nm6EzDuCuViqxYvRh7bbIrQLhSeBbNVe88dWt
        laFLQ5vB/ZBCz9P9Km7yXln1udx3NqZYnpxLPGzuV4Gm4/CGObPtB1anCUuPcXuwpC8GRmlJROanA
        bNYYAcUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyfX3-00063t-Fx; Mon, 03 Feb 2020 17:29:09 +0000
Date:   Mon, 3 Feb 2020 09:29:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Steve Capper <steve.capper@linaro.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/16] page-flags: define PG_reserved behavior on
 compound pages
Message-ID: <20200203172909.GA22353@infradead.org>
References: <1426784902-125149-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1426784902-125149-10-git-send-email-kirill.shutemov@linux.intel.com>
 <158048425224.2430.4905670949721797624@skylake-alporthouse-com>
 <20200203151844.mmgcwzz3igo7h6wj@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203151844.mmgcwzz3igo7h6wj@box>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 06:18:44PM +0300, Kirill A. Shutemov wrote:
> > Much later than you would ever expect, but we just had a user update an
> > ancient device and trip over this.
> > https://gitlab.freedesktop.org/drm/intel/issues/1027
> > 
> > In drm_pci_alloc() we allocate a high-order page (for it to be physically
> > contiguous) and mark each page as Reserved.
> > 
> >         dmah->vaddr = dma_alloc_coherent(&dev->pdev->dev, size,
> >                                          &dmah->busaddr,
> >                                          GFP_KERNEL | __GFP_COMP);
> > 
> >         /* XXX - Is virt_to_page() legal for consistent mem? */
> >         /* Reserve */
> >         for (addr = (unsigned long)dmah->vaddr, sz = size;
> >              sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
> >                 SetPageReserved(virt_to_page((void *)addr));
> >         }
> > 
> > It's been doing that since

This code is completely and utterly broken.  Drivers were never allowed
to call virt_to_page() on the memory returned from dma_alloc_coherent
(or pci_alloc_consistent before that), as many implementations return
virtual addresses that are not in the kernel mapping.  So this code
needs to go away and not papered over.
