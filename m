Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D905C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B26B2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VyD+5kQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgFLTfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:35:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D397CC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+5+IcG8sXlMhiox/FgJWWsRtf+hRc3YO/1sJoEPrqoM=; b=VyD+5kQpi5iwqF6m2FD8IlHyrV
        r3e6fkIn6zAAxbvBjS2CrgIlvm9ufT9ImrZZEjsY6GgwyWdMmLiSI26vAUd3fyA328o7ccFDBq9S5
        cyBy7JnaVqETitlmN8Ix25OwomjkkEpp7o7gqEpCmi0CFYbbtoo6APyITJ4N6ibrJrlSLVY+wlA00
        BOSiA2fV4a8m5awRXHvf23bo57qkegL094Gh9rtY56+EPILfX2tcxNW8Flan9T1qv9bnTCBGwiwb8
        z7v29o8XjqMdMRBrzvywPYHRJAmoSb1+QAX36JWnu8n3TkbOFSfzWZp7DWBLzcmIy9/ardtaVKYX0
        EQapKAbA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjpSW-0007FE-9J; Fri, 12 Jun 2020 19:35:24 +0000
Date:   Fri, 12 Jun 2020 12:35:24 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/hmm: remove redundant check non_swap_entry()
Message-ID: <20200612193524.GL8681@bombadil.infradead.org>
References: <20200612192618.32579-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612192618.32579-1-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:26:18PM -0700, Ralph Campbell wrote:
> In zap_pte_range(), the check for non_swap_entry() and
> is_device_private_entry() is redundant since the latter is a subset of the
> former. Remove the redundant check to simplify the code and for clarity.

That is highly configuration dependent.

#else /* CONFIG_DEVICE_PRIVATE */
...
static inline bool is_device_private_entry(swp_entry_t entry)
{
        return false;
}

...
#if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
    defined(CONFIG_DEVICE_PRIVATE)
static inline int non_swap_entry(swp_entry_t entry)
{
        return swp_type(entry) >= MAX_SWAPFILES;
}
#else
static inline int non_swap_entry(swp_entry_t entry)
{
        return 0;
}
#endif

