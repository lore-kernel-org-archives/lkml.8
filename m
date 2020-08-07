Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A652C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDE222D2A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mM2TU/P5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHGPKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHGPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:10:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE8C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wm+FtgUidVQX0/yTlqJZB7OVlh/P6bpND6KCyw+td38=; b=mM2TU/P5Kd/4be8Aklbm/fnP2g
        Zlu8zyrYWUFkyS4nOAOOs1HREitcVN+m/ReHAuU5/0ZuK8pyGOoSAlbIa1rGx14LLAeiihdRJJicA
        XTHfrsdWq0wfsoXf95vaTIi2Wi8ZizPTDRqcM4nYOHnEnNadKsVElaBtb9mpBxjLRwPBhZQ2uzaqG
        gW8A91ELbM7xTQ6V+d8KeMzDagw1PYP8XfWTbIL2660gr7L6UD8k3JXD6yYuBBl6n49MOS/viHkx0
        kWtVsiTZSyYbVUekUY0hcLaplnVQnSyGRSFqB3S8lqe2B0iY3bXEdsjJ3SlUyu2rVVbXjrzhXV6ys
        7NCZuL/A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k440r-0007xU-GF; Fri, 07 Aug 2020 15:10:29 +0000
Date:   Fri, 7 Aug 2020 16:10:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        cai@lca.pw, rppt@linux.ibm.com, vbabka@suse.cz,
        william.kucharski@oracle.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm, dump_page: do not crash with bad
 compound_mapcount()
Message-ID: <20200807151029.GE17456@casper.infradead.org>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
 <20200807143504.4kudtd4xeoqaroqg@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807143504.4kudtd4xeoqaroqg@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 05:35:04PM +0300, Kirill A. Shutemov wrote:
> On Tue, Aug 04, 2020 at 02:48:07PM -0700, John Hubbard wrote:
> > If a compound page is being split while dump_page() is being run on that
> > page, we can end up calling compound_mapcount() on a page that is no
> > longer compound. This leads to a crash (already seen at least once in
> > the field), due to the VM_BUG_ON_PAGE() assertion inside
> > compound_mapcount().

[...]
> > +static inline int head_mapcount(struct page *head)
> > +{
> 
> Do we want VM_BUG_ON_PAGE(!PageHead(head), head) here?

Well, no.  That was the point of the bug report -- by the time we called
compound_mapcount, the page was no longer a head page.

> > A similar problem is possible, via compound_pincount() instead of
> > compound_mapcount().
> > 
> > In order to avoid this kind of crash, make dump_page() slightly more
> > robust, by providing a pair of simpler routines that don't contain
> > assertions: head_mapcount() and head_pincount().
> 
> I find naming misleading. head_mapcount() and head_pincount() sounds like
> a mapcount/pincount of the head page, but it's not. It's mapcount and
> pincount of the compound page.

OK, point taken.  I might go for head_compound_mapcount()?  Or as I
originally suggested, just opencoding it like we do in __page_mapcount().

