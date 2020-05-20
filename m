Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12383C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB7B20674
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fy9UQtON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgETAYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:24:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87264C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:24:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v15so546480qvr.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+E0kIe70syNL6UAJLN3BrixhuqHouK19XEdYSaz4boc=;
        b=Fy9UQtONhqqEyoT6JmaD8ZWUnGxG2gZuC2E3cEOWtLwNQF0SIgpqUFvE9KUjKC89q+
         XtceAwte+1dGT/OhpeYI3ntI0RPTtUT+XfgXYR1NYWwCRXvCeRE+Ul9GyfDY/0qWXY46
         A1GAG7bBwmxQ3451vi6Jsx9UNZ863wFu8CkooGlunMDGao0JPlGNXOVdDht0fZbVUpTB
         cooBF8O4DF9LAX9OgBTVTHvmL8UuuAQoap8rR5QMGz08VZtBv526dmgst+bzuECwzHP2
         rHyOGuKeLOrq1/ijJXLF6YBbA0oJXUTq01Z/kbX8jn8OpuXdfUSMsEjVCYlbxFYUIm+a
         EfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+E0kIe70syNL6UAJLN3BrixhuqHouK19XEdYSaz4boc=;
        b=lM3jyn/xPUyanbH69amaQZ4tnL/dm8Xe01pp/1XVNfeG2vBBdEnpz4DHdqSpXmzSC3
         6iNh7/WUh/9zE4FenToxECcODHYDXBrS/SsLl1M0vCKf7pJ56dm5vqh70jfBhZka/LBr
         cpMB2L4SHRQd6UrXQea0++JRKLHHIfmQDAbbLaQ2yrVsStC4B3aNIFGYN+qOYF2Vf9EI
         2hJOLAFzwaQYlyLMwYuHh3qbWFBiwdM8ldm+XELdVpDOr1P/JJeF2tlP8+f5bhamrIXA
         EK6KS8svpFaPiptCOYew40B/hol0VrfApVABqGWFo6iK1Tu49hm28sfvMDB+3FXXP1j+
         rCqw==
X-Gm-Message-State: AOAM532DRzd+mQo0c5NQNGRe/MMILsco1d6Bs8zvzKgkbHp6UCn4sJ80
        nWLZFh+YNjNXNGXxhOsOcr9ZJA==
X-Google-Smtp-Source: ABdhPJzepcju1X6ZbEK/rqZRJGs7XRG5GX9RZoCeTzWm53K2Qq7a4cM8kRPLEcG1JwR0CyqZG0/SmA==
X-Received: by 2002:a0c:b992:: with SMTP id v18mr2366070qvf.223.1589934270821;
        Tue, 19 May 2020 17:24:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m59sm1124723qtd.46.2020.05.19.17.24.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 17:24:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbCX8-0003W3-0k; Tue, 19 May 2020 21:24:30 -0300
Date:   Tue, 19 May 2020 21:24:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH 0/2] vfio/type1/pci: IOMMU PFNMAP invalidation
Message-ID: <20200520002429.GE31189@ziepe.ca>
References: <158947414729.12590.4345248265094886807.stgit@gimli.home>
 <20200514212538.GB449815@xz-x1>
 <20200514161712.14b34984@w520.home>
 <20200514222415.GA24575@ziepe.ca>
 <20200514165517.3df5a9ef@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514165517.3df5a9ef@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:55:17PM -0600, Alex Williamson wrote:
> On Thu, 14 May 2020 19:24:15 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Thu, May 14, 2020 at 04:17:12PM -0600, Alex Williamson wrote:
> > 
> > > that much.  I think this would also address Jason's primary concern.
> > > It's better to get an IOMMU fault from the user trying to access those
> > > mappings than it is to leave them in place.  
> > 
> > Yes, there are few options here - if the pages are available for use
> > by the IOMMU and *asynchronously* someone else revokes them, then the
> > only way to protect the kernel is to block them from the IOMMUU.
> > 
> > For this to be sane the revokation must be under complete control of
> > the VFIO user. ie if a user decides to disable MMIO traffic then of
> > course the IOMMU should block P2P transfer to the MMIO bar. It is user
> > error to have not disabled those transfers in the first place.
> > 
> > When this is all done inside a guest the whole logic applies. On bare
> > metal you might get some AER or crash or MCE. In virtualization you'll
> > get an IOMMU fault.
> > 
> > > due to the memory enable bit.  If we could remap the range to a kernel
> > > page we could maybe avoid the IOMMU fault and maybe even have a crude
> > > test for whether any data was written to the page while that mapping
> > > was in place (ie. simulating more restricted error handling, though
> > > more asynchronous than done at the platform level).    
> > 
> > I'm not if this makes sense, can't we arrange to directly trap the
> > IOMMU failure and route it into qemu if that is what is desired?
> 
> Can't guarantee it, some systems wire that directly into their
> management processor so that they can "protect their users" regardless
> of whether they want or need it.  Yay firmware first error handling,
> *sigh*.  Thanks,

I feel like those system should just loose the ability to reliably
mirror IOMMU errors to their guests - trying to emulate it by scanning
memory/etc sounds too horrible.

Jason
