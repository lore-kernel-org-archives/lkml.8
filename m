Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5709C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F10B2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504539AbgDNS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:59:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:39425 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504522AbgDNS6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:58:30 -0400
IronPort-SDR: VrIxCfimzZEQKlxuvWd0gOG98KIpeAmmbosVD6zcMMUu0AR9SRBs7NWXnMBKN5w+acii105O6j
 E1yyKdffa9BQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 11:58:29 -0700
IronPort-SDR: 9FdJBCeUopAL3U0NX9fEzeH7rCHULi9c/wWB2l5KrUFQeiImXxzjYOb/RwWVJIJ05/Njn3phr7
 Xv9yFwxQowyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; 
   d="scan'208";a="427167843"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2020 11:58:29 -0700
Date:   Tue, 14 Apr 2020 11:58:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/gup: dereference page table entry using helper
Message-ID: <20200414185829.GB1853609@iweiny-DESK2.sc.intel.com>
References: <1586877001-19138-1-git-send-email-agordeev@linux.ibm.com>
 <20200414163234.GG5100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414163234.GG5100@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 01:32:34PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 14, 2020 at 05:10:01PM +0200, Alexander Gordeev wrote:
> > Commit 0005d20 ("mm/gup: Move page table entry dereference
> > into helper function") wrapped access to page table entries
> > larger than sizeof(long) into a race-aware accessor. One of
> > the two dereferences in gup_fast path was however overlooked.
> > 
> > CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > CC: linux-mm@kvack.org
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> >  mm/gup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index d53f7dd..eceb98b 100644
> > +++ b/mm/gup.c
> > @@ -2208,7 +2208,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >  		if (!head)
> >  			goto pte_unmap;
> >  
> > -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > +		if (unlikely(pte_val(pte) != pte_val(gup_get_pte(ptep)))) {
> 
> It doesn't seem like this needs the special helper as it is just
> checking that the pte hasn't changed, it doesn't need to be read
> exactly.
> 
> But it probably should technically still be a READ_ONCE. Although I
> think the atomic inside try_grab_compound_head prevents any real
> problems.

I think we should go for consistency here and use the helper function.

Ira

> 
> Jason
> 
