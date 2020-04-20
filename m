Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3BBC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5212084D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eAkVkLKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgDTT2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDTT2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:28:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203A7C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PeNgxIYdhodceyRsiQXJ9AHM++VjzL0tYm/762Y/HsI=; b=eAkVkLKBGXi0Nf6wszcH6YjhXG
        7xTDxRFfaqpfYG3jkxcNldZqzUzdk3kS+1/rdj+N5JTshWeqUSg5m3X5/DeCn6J+Fd1rtWCkMTcpt
        +8oYWRWM07oeWlO1kCYryg6TWNtTM5UUBcJdLSmFgzFZ4j0rWRWZzPNs9+WEsVfv3AVymMUld56Os
        4qaWXguOzrXyZz8/VCwrvTOxX4tI4Ga3um6Npi60sTGI6NttY29ZzUX/ES35xyQTrUbUkFmPxmD2x
        SG3u+2UVA76U6X3ulMs4sHkoHTRwvWCEaotWziw3sEPOFhokSAHd6DjmKL7hoGF4FAhkhmdijCyCI
        bfeuD5iA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQc5P-0007df-2o; Mon, 20 Apr 2020 19:28:07 +0000
Date:   Mon, 20 Apr 2020 12:28:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v4 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
Message-ID: <20200420192806.GE5820@bombadil.infradead.org>
References: <20200415004353.130248-1-walken@google.com>
 <20200415004353.130248-9-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415004353.130248-9-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:43:51PM -0700, Michel Lespinasse wrote:
> @@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
                                            ^^^^^^^^
>  	.pgd            = swapper_pg_dir,
>  	.mm_users       = ATOMIC_INIT(2),
>  	.mm_count       = ATOMIC_INIT(1),
> -	.mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
> +	.mmap_sem       = MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
                                                ^^^^^^^

Shome mishtake, shirley?

I don't see that this particular patch buys us much.  The name 'mmap_sem'
is still used, and I appreciate we abstract away the type of the lock,
but wouldn't this be better?

-	.mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
+	MMAP_LOCK_INITIALIZER(tboot_mm),

