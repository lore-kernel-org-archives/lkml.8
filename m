Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A3E22B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FzUcUdR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgGaUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgGaUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:49:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EDDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/q30urdzzKXnpoJ7dXdtjQrPbekj62/yJbF+tw5Z+LY=; b=FzUcUdR8C6VL3g1heE8U8qPOOz
        skp4/ZS5oZ/jNXWB9AIGNkGq5yYjwRvWaaI+t9JzJUKMIz4OlhO9o633+W2DXzDBaQnUsn5f5U8N8
        NTixXRNwq8Wq0Zcw04ROlFjkQMIXch+/ycVdIkpUBTrOtbglDRkfrTIlwHYjeTmENH/L525S5nVYY
        lSVIZfrPPten5K1gomKBrrciuobW9nOO0TXH2Rkijc4iHARPxUpF1RXVpoQckjDLub/iTlaIGv0Ur
        JpkKHg7qXfggG2fBxLwxWXLmfSrwTgiMi70LQIbd6P8wWCfYnTbd9UwmR4cV9KaAH7be+85bLiiX8
        f+cb23Aw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1byH-00021t-4m; Fri, 31 Jul 2020 20:49:41 +0000
Date:   Fri, 31 Jul 2020 21:49:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     qiang.zhang@windriver.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/dmapool.c: add WARN_ON() in dma_pool_destroy
Message-ID: <20200731204941.GR23808@casper.infradead.org>
References: <20200731023939.19206-1-qiang.zhang@windriver.com>
 <20200731023858.GO23808@casper.infradead.org>
 <20200731133215.73cf5ce464e2b894aeac0773@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731133215.73cf5ce464e2b894aeac0773@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 01:32:15PM -0700, Andrew Morton wrote:
> On Fri, 31 Jul 2020 03:38:58 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Fri, Jul 31, 2020 at 10:39:39AM +0800, qiang.zhang@windriver.com wrote:
> > > The pool is being destroyed, all page which in the pool,
> > > should be free. if some page is still be use by somebody,
> > > we should not just output error logs, also should also add
> > > a warning message.
> > 
> > There's already a warning message.  What value does this actually have?
> 
> Presumably so we get a backtrace in order to identify the errant
> caller.  

The existing message includes the name of the pool.  We don't typically
have more than one place that destroys a pool.

What might be helpful would be something that said who allocated and
didn't free the object, but again, there's typically only one place which
allocates from any given pool, so even that would be all that helpful.

I'm not particularly impressed by these patches which don't actually
justify themselves.
