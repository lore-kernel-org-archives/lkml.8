Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC3BC10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 11:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E3320663
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 11:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IV7IX21v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgCHLuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 07:50:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHLuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 07:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=roRbR4edE009phJ4jS/XgUrQgBpty89xGIVuf7gn68s=; b=IV7IX21v8OQ5tnEIrI+9Wq+7zw
        9OmRRy48F26TL3jNeUW9unwClxThGUe5HGXFC9RJATvoayH/ntdxyS8nIx7upou9Pg3hzq9z/8uJu
        7GPuaJM6X47BLPm5YuB1iLKuRBBwsyrQiG/bAz+vfBr8VbhSFTyIBjXEfJem+kGhgKtISl4uxECJ4
        PuUah+Axg0Y9M88bHERXWnE9P2AXUOmjdATCqEP9c5O7NaWescNdsWUdmFD6wEI6kZAVoBQywqZDe
        b6KIozUBuIqn1z7LgjPVscjmrt186A0YNjFnVGPxrJGphSzGXJkx9h1l0xga/gR6RcSxkIVDRtAVs
        myvd2zQw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAuRb-0004TL-Be; Sun, 08 Mar 2020 11:50:07 +0000
Date:   Sun, 8 Mar 2020 04:50:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mateusznosek0@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/page_alloc.c: Micro-optimisation Remove
 unnecessary branch
Message-ID: <20200308115007.GE31215@bombadil.infradead.org>
References: <20200307225335.31300-1-mateusznosek0@gmail.com>
 <20200307151542.b14131037dc44a8edcb22cad@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307151542.b14131037dc44a8edcb22cad@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 03:15:42PM -0800, Andrew Morton wrote:
> On Sat,  7 Mar 2020 23:53:35 +0100 mateusznosek0@gmail.com wrote:
> > -	if (unlikely(ac.nodemask != nodemask))
> > -		ac.nodemask = nodemask;
> > +	ac.nodemask = nodemask;
> 
> This will now unconditionally dirty the ac.nodemask cacheline, which
> means that cacheline will need to be written back.  If it is truly
> unlikely that the write was needed then the thinking goes that the
> test-and-branch is worthwhile, by saving on memory traffic.
> 
> At least, I assume that's why the code is the way it is.

The line immediately before this hunk is:

        ac.spread_dirty_pages = false;

ac is on-stack and is only 32 bytes.  I don't see a reason not to do this.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
