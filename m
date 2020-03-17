Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC89FC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4B920752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JN0AzelZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgCQTVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:21:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b+zfqjJJKArO89lYc5D7AoeuSHTXzYgw70bPUpJTsPA=; b=JN0AzelZ51FBfzVAgwUsuP0RuO
        JHEtx+lrODYkdbaJgKRBPlYgliQHrWV/uMbpTw/a7gcdMuwz0V0R9ZLhGunPdDyUQieNMr5uxbx2k
        ocUyqSx2lnGiqE8Y9t9+32FkEAg/GopV3py2OLShAO1qrg+pHyo4E3lk2cxDa5bCLZaDdCmEx9fZZ
        LJnP/S00kDdTEr56TbnUT7BMsexZA8BCP/jUroVV3syxIHzHU22eQtX0CDssQMJgd+3J4fHMRBNfW
        sZ0QvGZ6ab1Y5lAO6ISCvuHWSh1kInAU8cICaTnYfhJHSBclSu+mgSSLQF83KGfSc1OzcEG0V84/Z
        lJOGNf8Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEHmS-0000x1-9o; Tue, 17 Mar 2020 19:21:36 +0000
Date:   Tue, 17 Mar 2020 12:21:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] mm: swap: make page_evictable() inline
Message-ID: <20200317192136.GE22433@bombadil.infradead.org>
References: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 01:42:50AM +0800, Yang Shi wrote:
> -static inline int mapping_unevictable(struct address_space *mapping)
> +static inline bool mapping_unevictable(struct address_space *mapping)
>  {
>  	if (mapping)
>  		return test_bit(AS_UNEVICTABLE, &mapping->flags);

Shouldn't this be:

-static inline int mapping_unevictable(struct address_space *mapping)
+static inline bool mapping_unevictable(struct address_space *mapping)
 {
-       if (mapping)
-               return test_bit(AS_UNEVICTABLE, &mapping->flags);
-       return !!mapping;
+       return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);
 }

