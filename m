Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640ECC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF162078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eELfQzbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgIAUyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:54:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E6AC061244;
        Tue,  1 Sep 2020 13:54:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so1542295pfh.3;
        Tue, 01 Sep 2020 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRTR1pQ5xaQZ2uOprnJ9rvvshbUxSZlhlKoxnO7URRM=;
        b=eELfQzbSGjuv8KyOMVHl+sTrzSe3ziixFesUVCgWOu7/Z9muIvFP7Bi4DRJZMs6RcJ
         uhMvWISw8EQN1/7gxRmFAFsNBG5Sh9QbZV6QgcFDjmSpu/uuHUY9boYcGOBpACpZ2QKm
         2xrLnc3Zu6wcDZtzf6kTWiFrA/YhL2qcA9RPBXgRzmQs/uy/H7Jn+SzylyQeVuoHjASv
         vAVeYbXCILJrBBwG1cAuMAGgHRm6simSr4if2kYJM3hqSroABMSvzIJAMe0A2WueufHt
         t5wBEp5mZqpgLu3vzcoJLecspOTik/9RM6BJkEqtdcJgnSSWtV2vjAN/aVdEovSHd2Tj
         jceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRTR1pQ5xaQZ2uOprnJ9rvvshbUxSZlhlKoxnO7URRM=;
        b=N5aNCXzxJApOPZFxE4JGLzB6qJYXuGF2hBysLwgYBRO0rMQLtkR5JMIM4tBdOsM9u6
         R05VHXGifDA9tjY9aSxNRt06ZcqvyJm0LQtWHS2QihRFCKLmf0yR8hyrWOHVF11dBLKk
         CK3xj6M017lQcXyQM9lInXZhLEBd86YFdVsJh1aPUtvmwIMp4KkwvTfUQoGmZVEX+/n9
         Jck4BRaxSITI7vxUNATMP2XxDJ/aOLZDLWsSLJYf6c3W98rLlOcUQLXHLHjY2Dh5vqHH
         btVzDhBru9ZC0fNcku3cL8CVQS6NgVySlRyhb4WABlDoJzy8jLTQm88oNQHpj7/gYk4g
         292g==
X-Gm-Message-State: AOAM531aw/rl0fXU/RIE2O7CVcyV6csCx6lLGeSpu7ZTkNav71UdcbbY
        ZeIkpYqTdxJKS5Zwmeywrlw=
X-Google-Smtp-Source: ABdhPJybz8lKswfhAONDTigR0brpOOZSb0wvBo43ZZyZYaJi6PxdmqR6MUqDZmJI2ioaYEYqLLibGw==
X-Received: by 2002:a63:384b:: with SMTP id h11mr3124012pgn.113.1598993661459;
        Tue, 01 Sep 2020 13:54:21 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y1sm3016263pgr.3.2020.09.01.13.54.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 13:54:21 -0700 (PDT)
Date:   Tue, 1 Sep 2020 13:53:47 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     benh@kernel.crashing.org, paulus@samba.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, tony.luck@intel.com,
        fenghua.yu@intel.com, schnelle@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, sfr@canb.auug.org.au, hch@lst.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: [RESEND][PATCH 1/7] powerpc/iommu: Avoid overflow at
 boundary_size
Message-ID: <20200901205346.GA17362@Asurada-Nvidia>
References: <20200831203811.8494-1-nicoleotsuka@gmail.com>
 <20200831203811.8494-2-nicoleotsuka@gmail.com>
 <87lfht1vav.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfht1vav.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:27:36PM +1000, Michael Ellerman wrote:
> Nicolin Chen <nicoleotsuka@gmail.com> writes:
> > The boundary_size might be as large as ULONG_MAX, which means
> > that a device has no specific boundary limit. So either "+ 1"
> > or passing it to ALIGN() would potentially overflow.
> >
> > According to kernel defines:
> >     #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
> >     #define ALIGN(x, a)	ALIGN_MASK(x, (typeof(x))(a) - 1)
> >
> > We can simplify the logic here:
> >   ALIGN(boundary + 1, 1 << shift) >> shift
> > = ALIGN_MASK(b + 1, (1 << s) - 1) >> s
> > = {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
> > = [b + 1 + (1 << s) - 1] >> s
> > = [b + (1 << s)] >> s
> > = (b >> s) + 1
> >
> > So fixing a potential overflow with the safer shortcut.
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/powerpc/kernel/iommu.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> Are you asking for acks, or for maintainers to merge the patches
> individually?

I was expecting that but Christoph just suggested me to squash them
into one so he would merge it: https://lkml.org/lkml/2020/9/1/159

Though I feel it'd be nice to get maintainers' acks before merging.

> > diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> > index 9704f3f76e63..c01ccbf8afdd 100644
> > --- a/arch/powerpc/kernel/iommu.c
> > +++ b/arch/powerpc/kernel/iommu.c
> > @@ -236,15 +236,14 @@ static unsigned long iommu_range_alloc(struct device *dev,
> >  		}
> >  	}
> >  
> > -	if (dev)
> > -		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
> > -				      1 << tbl->it_page_shift);
> > -	else
> > -		boundary_size = ALIGN(1UL << 32, 1 << tbl->it_page_shift);
> >  	/* 4GB boundary for iseries_hv_alloc and iseries_hv_map */
> > +	boundary_size = dev ? dma_get_seg_boundary(dev) : U32_MAX;
> 
> Is there any path that passes a NULL dev anymore?
> 
> Both iseries_hv_alloc() and iseries_hv_map() were removed years ago.
> See:
>   8ee3e0d69623 ("powerpc: Remove the main legacy iSerie platform code")
> 
> 
> So maybe we should do a lead-up patch that drops the NULL dev support,
> which will then make this patch simpler.

The next version of this change will follow Christoph's suggestion
by having a helper function that takes care of !dev internally.

Thanks
Nic

> 
> 
> > +	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
> > +	boundary_size = (boundary_size >> tbl->it_page_shift) + 1;
> >  
> >  	n = iommu_area_alloc(tbl->it_map, limit, start, npages, tbl->it_offset,
> > -			     boundary_size >> tbl->it_page_shift, align_mask);
> > +			     boundary_size, align_mask);
> >  	if (n == -1) {
> >  		if (likely(pass == 0)) {
> >  			/* First try the pool from the start */
> > -- 
> > 2.17.1
