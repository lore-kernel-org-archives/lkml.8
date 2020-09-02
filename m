Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58119C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308C220767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="maRen52V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIBT5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgIBT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:57:41 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DC9C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 12:57:41 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so183545qvk.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GvfTb4Ukg4eRdTfVxDoeOFtlOK7caIxpUoVhsrSJNME=;
        b=maRen52VTm0wyWAEpZ/yQqgL+ekrkSonuUlxs/DRhPm2NSJk8pJsxABr+8gFZkramm
         udpBGDXt0itgVjM6xvA4f1TAuK+5UWmH21cZxvA4Rlan4lv6dQxeUJDR+QkoDV6ruvQN
         lIQcIk0asoiZyx+LBevV81cJ21B84/0NqhFo3qTOYbRsfmjgGOm2v2B/rS2ziupKYry4
         lxGF5rYqh/vNzsfLo9msR64aIGidn5j6VQhrxKLS5+o49R0IulsNg4veF8DBaFY5VkgC
         LS7+okBbJlUwLeFymf+ihx7wNF9ECOAoKR1HL4KFshgNvGY2AgrPc925I5coEX+EqtEW
         Q+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GvfTb4Ukg4eRdTfVxDoeOFtlOK7caIxpUoVhsrSJNME=;
        b=nZA6HnBq5RGh22UKxccE02ldqkkccgSNG023bKDtWLqR2CTHWUBpjvZ0l33VC9WW9r
         UphLRKXdtBBPFvxsLzV7kBCmBN+1ri39paJa9hOzXWV8yN8rtE6MrThSaf8LsvV4VLxf
         QpJXhvtXK0t7ejckEyQxvCxzF7GPUKnCogr0TPMk1qBs5amN30BzlB7iQekgspQEQ0/n
         2sMFDv3ZSRDZZTq8yscefCzFxALMU/PiCWoPzyPGEGRp4JlLbMt1dkKeph792PG0V87H
         zhGC5Pbkirq2fHCqwGgE1jkW5Mc+245DyB8wgL8ewOPNb2GqoMYcxyAQbVFNQE0gN1D/
         Tbqw==
X-Gm-Message-State: AOAM530RFXPwxh9e1D20zIzc35PSqqmxbCuUmYVfZNzluevp+0U4ki0t
        Yp+krffQfQzDgtHJaxFnyI8DQg==
X-Google-Smtp-Source: ABdhPJxfwT9NmGMEK0ziwhKHyFx6LE3R67e7mvrI7pfZ6XNSJjy0TEfEwKf4DP9bDtwS6q+bT7Eedg==
X-Received: by 2002:ad4:4890:: with SMTP id bv16mr8542219qvb.148.1599076660399;
        Wed, 02 Sep 2020 12:57:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c1sm331693qta.86.2020.09.02.12.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 12:57:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kDYt1-0065rX-4P; Wed, 02 Sep 2020 16:57:39 -0300
Date:   Wed, 2 Sep 2020 16:57:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200902195739.GI24045@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902184053.GF24045@ziepe.ca>
 <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
 <20200902184852.GH24045@ziepe.ca>
 <C5EFA1CC-311C-47D5-9506-D087D9AE58D1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5EFA1CC-311C-47D5-9506-D087D9AE58D1@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:05:39PM -0400, Zi Yan wrote:
> On 2 Sep 2020, at 14:48, Jason Gunthorpe wrote:
> 
> > On Wed, Sep 02, 2020 at 02:45:37PM -0400, Zi Yan wrote:
> >
> >>> Surprised this doesn't touch mm/pagewalk.c ?
> >>
> >> 1GB PUD page support is present for DAX purpose, so the code is there
> >> in mm/pagewalk.c already. I only needed to supply ops->pud_entry when using
> >> the functions in mm/pagewalk.c. :)
> >
> > Yes, but doesn't this change what is possible under the mmap_sem
> > without the page table locks?
> >
> > ie I would expect some thing like pmd_trans_unstable() to be required
> > as well for lockless walkers. (and I don't think the pmd code is 100%
> > right either)
> >
> 
> Right. I missed that. Thanks for pointing it out.
> The code like this, right?

Technically all those *pud's are racy too, the design here with the
_unstable function call always seemed weird. I strongly suspect it
should mirror how get_user_pages_fast works for lockless walking

Jason
