Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03483C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 16:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEB42076C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 16:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EYO8WHm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgF1QgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgF1QgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 12:36:01 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ED0C03E979;
        Sun, 28 Jun 2020 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n/hcDObI/DMWlNE/auMQa77Bg8QRthUTwPM6folDItA=; b=EYO8WHm10pKP+mpQ6yVKANpNKy
        zMf4FCJwPYrymkE9yOnb63hh6mWx39tz+nio44PiBgN0GHH0UOXdYkZQrmdF80ke46kk+tg6ntrRn
        4z1gx7wnZxD3EYTJCgK5H7m5NoHWgG0Ck4sWy86zjs4+Qy7ZRLKWD3IUHue+g0gqhWICwjjQDkWNi
        nZoyNnd9ph12YmB62guoveGIh+tSzN9uUc9lJy0FPXZkdAQdOg44TAMhh1OgdRjFKyGoaHYINseKz
        GrbTfspTTtOHCKohxmWfFCMYaLVYZA6P+EInlFilp2vbtO/JBj82JQ7QDZl8Qo/O+6Ix5pfrBAXhG
        iUjzvSpA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpaHL-0006Z6-2k; Sun, 28 Jun 2020 16:35:39 +0000
Date:   Sun, 28 Jun 2020 17:35:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Long Li <lonuxli.64@gmail.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] mm: Free unused pages in kmalloc_order()
Message-ID: <20200628163539.GA25523@casper.infradead.org>
References: <c5f54ce3-dad6-a2aa-d32a-cc7620676b76@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f54ce3-dad6-a2aa-d32a-cc7620676b76@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 01:17:59PM +0200, Markus Elfring wrote:
> > kmalloc(1024, GFP_HIGHUSER) can allocate memory normally,
> > kmalloc(64*1024, GFP_HIGHUSER) will cause a memory leak,
> 
> Would you like to explain the influence of the selected allocation size
> in a different way?

Markus, this is not useful.  Please stop.
