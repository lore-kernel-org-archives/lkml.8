Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3920CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025A82051A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eu2LmHTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCGAgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:36:10 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38520 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgCGAgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:36:10 -0500
Received: by mail-pj1-f67.google.com with SMTP id a16so1781050pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iQN4zhJ6gBuJKLE8KIK1cxkBH9N65rsEBT3TSzucx+4=;
        b=eu2LmHTzZatSpWXnyqQgwxY6vHjsxT3DBgnHFPIgUh05TCzeDd6g3W2Fq6R8IGy07T
         4XCC2t/8YXu++lulhOj4jT45tpq1Z96LVAaoSHkVnK1h9PaDrWAkZ3Nm/mpvF5RkK3Qe
         V5MdZ/9yEHaOumBM1tVotFpLW+lXscQ2BKGiQdXplBDbU3nZAxiuUy8kn+JmEB6bn92V
         KBml2dtUS7X3dM0OXrhNoRC+3HZM0o26ziS6o5n43QOpFWSnfWuk12mhTm4PVtTxj2hT
         fv6g0YFYNqiqa4wwzv2n7uvm2DgUWQYZPyUFnkGJuxhQ0anP1oTrxPoqS5XPOzPeY78v
         WBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iQN4zhJ6gBuJKLE8KIK1cxkBH9N65rsEBT3TSzucx+4=;
        b=taTIvDAmR9ieAsQnDwWh3HXEa9eHPBeMbn6L43Mn30PnXHLtezQ/ovRTnCQ8tni6NJ
         YjZlnNv4QTIzaTpj3rlPYr/6EFhyqAeuwBA2fDkqU6QPZu/66JUZBdoyLYHLHBfFFaX0
         Rs02kdjRP4qyUj4MNJPY8yAMKldXiJY91Mit5jd1UtbhJJlo116k0X0t/rg42VopCShI
         BCyxhr2Ygfny/zXfixp1ITt6FVNstcsEk/RWhXnZ0ceK5eSDwLV3jQ45NtAQTl1ppfZn
         SMtniBV/ftxkP+7pwtDOYbgLnRt8CI91sSG558FSvcf+w83IJeFaEi1IxSl7Q++eLD3/
         93/w==
X-Gm-Message-State: ANhLgQ1Qr6HqLCoh876hKZUXJzXOiXdzjE+e2aG9nQqFQxWsY5DLFwFl
        8uhi/B5rF9IvWr3ZjI3wk7PoJQ==
X-Google-Smtp-Source: ADFU+vtfYToP6REtbWXHCtEWR3i7fS41u9MkA2s+ci8D1inDN5qS5L8FCEUfetDWg0rQbJ5CRedjJw==
X-Received: by 2002:a17:90a:20cf:: with SMTP id f73mr6192744pjg.42.1583541368949;
        Fri, 06 Mar 2020 16:36:08 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r13sm10421590pjp.14.2020.03.06.16.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 16:36:08 -0800 (PST)
Date:   Fri, 6 Mar 2020 16:36:07 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc 5/6] dma-direct: atomic allocations must come from unencrypted
 pools
In-Reply-To: <20200305154456.GC5332@lst.de>
Message-ID: <alpine.DEB.2.21.2003061623060.27928@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011538040.213582@chino.kir.corp.google.com> <20200305154456.GC5332@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020, Christoph Hellwig wrote:

> On Sun, Mar 01, 2020 at 04:05:23PM -0800, David Rientjes wrote:
> > When AMD memory encryption is enabled, all non-blocking DMA allocations
> > must originate from the atomic pools depending on the device and the gfp
> > mask of the allocation.
> > 
> > Keep all memory in these pools unencrypted.
> > 
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >  arch/x86/Kconfig    | 1 +
> >  kernel/dma/direct.c | 9 ++++-----
> >  kernel/dma/remap.c  | 2 ++
> >  3 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1523,6 +1523,7 @@ config X86_CPA_STATISTICS
> >  config AMD_MEM_ENCRYPT
> >  	bool "AMD Secure Memory Encryption (SME) support"
> >  	depends on X86_64 && CPU_SUP_AMD
> > +	select DMA_DIRECT_REMAP
> 
> I think we need to split the pool from remapping so that we don't drag
> in the remap code for x86.
> 

Thanks for the review, Christoph.  I can address all the comments that you 
provided for the series but am hoping to get a clarification on this one 
depending on how elaborate the change you would prefer.

As a preliminary change to this series, I could move the atomic pools and 
coherent_pool command line to a new kernel/dma/atomic_pools.c file with a 
new CONFIG_DMA_ATOMIC_POOLS that would get "select"ed by CONFIG_DMA_REMAP 
and CONFIG_AMD_MEM_ENCRYPT and call into dma_common_contiguous_remap() if 
we have CONFIG_DMA_DIRECT_REMAP when adding pages to the pool.

I think that's what you mean by splitting the pool from remapping, 
otherwise we still have a full CONFIG_DMA_REMAP dependency here.  If you 
had something else in mind, please let me know.  Thanks!

> >  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > -	    dma_alloc_need_uncached(dev, attrs) &&
> 
> We still need a check here for either uncached or memory encryption.
> 
> > @@ -141,6 +142,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >  	if (!addr)
> >  		goto free_page;
> >  
> > +	set_memory_decrypted((unsigned long)page_to_virt(page), nr_pages);
> 
> This probably warrants a comment.
> 
> Also I think the infrastructure changes should be split from the x86
> wire up.
> 
