Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52538C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F68E20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580471014;
	bh=YUFEVwCNlddvIgP4Qt2+V8mNS/hMbmBZNY+3hypDBV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eG3NaIElxwuFx+0+cETHAA2hKVGcPfVQwqHQ2qUndSxJ+8m4APAAfAkgqH6d3Feq7
	 it0lq7aUxnyvgBBsqNj2trt68SZD583Ti1edplzBoXZckBoDrXSNAL+giAQBCkpZLn
	 KC56w3haHo6dcko1gxnivySnwf5B/Z5cJql+vsKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgAaLnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgAaLnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:43:33 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360FE206F0;
        Fri, 31 Jan 2020 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580471012;
        bh=YUFEVwCNlddvIgP4Qt2+V8mNS/hMbmBZNY+3hypDBV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jW4AoN2X6dGPfIaw14g6qm7SO5ds6Xpe3ahdMQc74ts03Pw78P56dLgB+YVAAUZyE
         VROLZcQcq/SFvgav0mP3RRoXqxQ0in99t7On5kpNK/t553bMkNLc6BUEfImq9AxWiL
         sjpa5jnjYHH9utuJEy/wMS0VOlhqNy57JQxnTxpc=
Date:   Fri, 31 Jan 2020 11:43:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200131114327.GB4298@willie-the-truck>
References: <20200129103941.304769381@infradead.org>
 <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
 <20200131093813.GA3938@willie-the-truck>
 <20200131102239.GB14914@hirez.programming.kicks-ass.net>
 <20200131111459.GO14946@hirez.programming.kicks-ass.net>
 <20200131111824.GA4298@willie-the-truck>
 <20200131113139.GC14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131113139.GC14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 12:31:39PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 31, 2020 at 11:18:24AM +0000, Will Deacon wrote:
> > > > > +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> > > > >  {
> > > > >  	struct page *page = alloc_pages(GFP_DMA, 0);
> > > > >  	pte_t *pte;
> 
> > Does that mean we can drop the GFP_DMA too? If so, this all ends up
> > looking very similar to the sun3 code wrt alloc/free and they could
> > probably use the same implementation (since the generic code doesn't
> > like out pgtable_t definition).
> 
> Many software TLB archs have limits on what memory the TLB miss handler
> itself can access (chicken-egg issues), it might be this is where the
> GFP_DMA comes from.

Fair enough, that sounds plausible.

> I can't quickly find this in the CFV4e docs, but I'm not really reading
> it carefully either.

I can't find any code under arch/m68k/ which suggests it, but for now
I guess we should stick with the old pgtable_t definition for sun3 with
a comment (and keep the GFP_DMA in for coldfire).

Will
