Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4946AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF342065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JHUqTEYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgENWYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728468AbgENWYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:24:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C22C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:24:17 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i5so550227qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6gJR0Sy3H0/XrBYi8uAvN59tWwDOSIM+GynOKet6WU=;
        b=JHUqTEYZp+HqW1JBxgtnjxP4djlGHQPkmUyH2Wjj5jM9ZprnKhIN8x0G1Kdrwwyfy3
         1PyW+F6sVeccUBertkUhBvYIgiiX/XngYQ6SzG+6abkuBE7xoaxU1ZpC0sKKDYo0YV8W
         orOdC1CexbE0pS1bb4xNIbVLo3LEnrFrRF2NYGCVkA4oKOds5T/k2sIfbf9tAelRhVzS
         vLsDrzLAD2u39msc3xMftQVshOM3NFpcmFH1pryFpeaaQg4wVVLXPMA5KqrLaVSpBv3G
         /F2+NulO0IAFnv4LRNcljRsce4ozcOy5up8dE4Pi3ok4Hnk6pWgKSmq833UfRxpsgUZr
         Agjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6gJR0Sy3H0/XrBYi8uAvN59tWwDOSIM+GynOKet6WU=;
        b=GKdj93NNbOZtRp7z7CXKs1srau4qwgYePCdZ6FvpP9qitw2bpX1sjGJfa0v8BATYs6
         6VLQpz+oPZItdF0wsDwA9yoce1QH7Lq0UZSTFpfV1ngBwiESWO34W1yRJFgT4NiJhvNg
         cL5dqUaEcJjP/zA2WIn2qS5783Kn8jyyg2Xp6qYE98855UPn2gYhMeFINK3A5HbKl/3t
         5y8I2E5f0GNzQZU5Tdx5K+x4vrXZALWo3PY6AjfH/eIZ+PJd7q24+RfhjLYgCKUXs7jr
         nrTM69zqEv5WN/JQ7HvzzZ/ST4q3HzjBI5sf1mrte6jcejG1kS2cx81jWxmRzsX3osRk
         1Xsw==
X-Gm-Message-State: AOAM531A5n6voFoxHKYWJPDQM+yVNaHzOCypm48qC+KsyfaPShaJbKuA
        Xh5hqaGVYhHlXWRGFF9WXaOl7A==
X-Google-Smtp-Source: ABdhPJwsz6wMRxc1JF8iiotnhQJugDFi5kwnJZK7l9SB8eVt2lnxnmiiN6ML2U+E04O+xdaryGmPuA==
X-Received: by 2002:a37:8d3:: with SMTP id 202mr594916qki.237.1589495056702;
        Thu, 14 May 2020 15:24:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g66sm173662qkb.122.2020.05.14.15.24.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 15:24:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jZMH1-0006WK-Mo; Thu, 14 May 2020 19:24:15 -0300
Date:   Thu, 14 May 2020 19:24:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH 0/2] vfio/type1/pci: IOMMU PFNMAP invalidation
Message-ID: <20200514222415.GA24575@ziepe.ca>
References: <158947414729.12590.4345248265094886807.stgit@gimli.home>
 <20200514212538.GB449815@xz-x1>
 <20200514161712.14b34984@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514161712.14b34984@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:17:12PM -0600, Alex Williamson wrote:

> that much.  I think this would also address Jason's primary concern.
> It's better to get an IOMMU fault from the user trying to access those
> mappings than it is to leave them in place.

Yes, there are few options here - if the pages are available for use
by the IOMMU and *asynchronously* someone else revokes them, then the
only way to protect the kernel is to block them from the IOMMUU.

For this to be sane the revokation must be under complete control of
the VFIO user. ie if a user decides to disable MMIO traffic then of
course the IOMMU should block P2P transfer to the MMIO bar. It is user
error to have not disabled those transfers in the first place.

When this is all done inside a guest the whole logic applies. On bare
metal you might get some AER or crash or MCE. In virtualization you'll
get an IOMMU fault.

> due to the memory enable bit.  If we could remap the range to a kernel
> page we could maybe avoid the IOMMU fault and maybe even have a crude
> test for whether any data was written to the page while that mapping
> was in place (ie. simulating more restricted error handling, though
> more asynchronous than done at the platform level).  

I'm not if this makes sense, can't we arrange to directly trap the
IOMMU failure and route it into qemu if that is what is desired?

I'll try to look at this next week, swamped right now

Thanks,
Jason
