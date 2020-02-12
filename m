Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1688C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E1320661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvXCHiQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgBLIFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:05:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBLIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mfh22nnJA5UNcevaTVHWUNz/Hk2YlNViPplGbZhfF7U=; b=nvXCHiQF6iQecbKUY7PY3KUBOi
        a/j1xdEbL3FWLw5EuNcbyDJjHSUjj3QSZ1dvIH+lxLE/O/FLlJGGx5JX+weO/zq/7FSrucklbXmop
        8F8G3UDYNC8pDwiSMbvoo7dLq2PpSyALNfZ4xJDF6COXvQSpWFGXmFP6Nij4dXRPKnvmm2Pec7JIu
        mntGlUH1DWZ960p3RgDo5MRiL0pb638q77P7gpq14Nvs2X3ns5GYdjEAutfQVI/3axN90suTulV8s
        IsQgDQ9sXpmWkZ5pSlc014HVNat0dlSWwaV7mtTSxwbaf84kVhIqyVgyeUgY38e2U7vS7WS/z3odF
        9FYhYSaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1n1Z-0002IE-VX; Wed, 12 Feb 2020 08:05:33 +0000
Date:   Wed, 12 Feb 2020 00:05:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/25] iomap: Inline data shouldn't see large pages
Message-ID: <20200212080533.GB24497@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-19-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:38PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Assert that we're not seeing large pages in functions that read/write
> inline data, rather than zeroing out the tail.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
