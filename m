Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C03C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D1D207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AdXJC/hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFQUCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:02:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC5C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9J8ZAxKKt3rYTkzZ/REcW+6qQSyuOPH1KZ7A4yaiyPk=; b=AdXJC/hQhxSujPpefoe9zdg9eV
        Ww7jsZFi2YRiF9EUuhRByXRCC/y/6FdUWiAVTz8Rv/K9wdAOFw7ibB6pehWvEEEnOu6LgiCfGrOIz
        +fVWlGN6ETaPTQeo6qFGuFJRNkC5iv1Vpqs/41uSP1ovc5TqAHiXGMnE0IK9oOe9HHay3FhrHsPOw
        +mQmNzA6iItHOHVicbE1WCoSF85LSYKTDXcb20VRahYMVfZajpoMhAhaFEzG7Iv3001sXoDx2/Pe0
        20KlDX8TEDjKh3cffiIFTpK+ZFnouWyLBJn140i1pqUYmIKiSomI2xrp7ArmwuurnAwM72UZXK0dn
        8EK4QNJQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jleFr-0001Jb-Lu; Wed, 17 Jun 2020 20:01:51 +0000
Date:   Wed, 17 Jun 2020 13:01:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Lameter <cl@linux.com>,
        Alexander Popov <alex.popov@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, vinmenon@codeaurora.org,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Expand CONFIG_SLAB_FREELIST_HARDENED to include
 SLAB and SLOB
Message-ID: <20200617200151.GM8681@bombadil.infradead.org>
References: <20200617195349.3471794-1-keescook@chromium.org>
 <20200617195349.3471794-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617195349.3471794-2-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:53:48PM -0700, Kees Cook wrote:
> Include SLAB and SLOB caches when performing kmem_cache pointer

... SLOB?  Really?  Objects from different kmem caches are mixed together
on the same page with SLOB (at least last time I looked).  So how does
this work?

> verification. A defense against such corruption[1] should be applied
> to all the allocators. With this added, the "SLAB_FREE_CROSS" and
> "SLAB_FREE_PAGE" LKDTM tests now pass on SLAB:
