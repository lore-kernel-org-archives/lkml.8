Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9174C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F220665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQfEnqeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH1Ull (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1Ulj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:41:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4245C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:41:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n129so826305qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=OuigYDRHbp0KD0Zigxqddli6PufHO0STYLtihCwC7Hk=;
        b=QQfEnqeh1/DkaJc+NqJ2Yqnl2m1Jeuh7CjGU+7LEnRD/yUo2qSeXBNZRCfbODu1V/z
         T6HIB0XbUPONs1uGgTn+xkQArTwiSPcS4zoMuEHUkvRaFFX6uDoAtSuDowfLt3SlkWaK
         PJpBYS/hbRXB0yRN3ybrnR/rbgctTWbnXPkKaR4zlcwDOtK4v38xvyd6BvIM4dbPgOUE
         m6NcphyEMXw9QxJ0x2B93UHy01OcuZWOExqJbzf5OOhbmEgbtXMC66kLjeyJWafsMHBJ
         GaAR9O6V9qaff46f02rxqWWHMwMqjfCVgULwIQiqeVC0kyFGs5YdALtPGmCDXbV20Ag3
         55Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=OuigYDRHbp0KD0Zigxqddli6PufHO0STYLtihCwC7Hk=;
        b=aaVeS60z++wkmgpQ3yA1GENWMrN8X2kOFT2UmLTJAzXKeqdpDRvUHG4o7iAzs0VYxU
         AhWRGA2/0Pmi7sVkTO8o4fZbQ0YuI4py17dAIW6yzuXHmOpbWnMWJsbFmkutDxkmaAjN
         06s+2JReYZ/bG1wJjrDXM257K5M5JzkMoLl05OPko/vUFRIwOeR8CPMFlkHPXM1YFvul
         4aBhFEzLMyQ5qNFLGwdK47SZ9CRPCQN1/rSgkXH6Fb00Nmf8LHTVN8hvO7lFRk20dw0T
         DNU5QiK1ieHCVMdwP8hrjqVvL8ECCRlOY3AqHEm20Vt4mVvTGTJ7LnvYrX4gz1/Hf27n
         tRKw==
X-Gm-Message-State: AOAM530Q4uz8NashTgDbN0vb3QPnLlAcvMZjj3PIiIA5+zaZsRAzpS68
        EX4Hzr0K19Xh0bp/rWgf6J9dyAreAtg=
X-Google-Smtp-Source: ABdhPJwvfHdveujPEOwZqSc9XJ9uaa/erp/yRgUdSL3/XppVxyA1noiGOKt0mKK7osmvKdkm8bmg7A==
X-Received: by 2002:a05:620a:4051:: with SMTP id i17mr886364qko.457.1598647298769;
        Fri, 28 Aug 2020 13:41:38 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id i14sm255894qkn.53.2020.08.28.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:41:37 -0700 (PDT)
Message-ID: <2aacd45f047489642da1731c92d3555ad101e3c7.camel@gmail.com>
Subject: Re: [PATCH v1 02/10] powerpc/kernel/iommu: Align size for
 IOMMU_PAGE_SIZE on iommu_*_coherent()
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Aug 2020 17:41:29 -0300
In-Reply-To: <da473389-f921-075a-ec8e-ea516de4f177@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-3-leobras.c@gmail.com>
         <7b9640e0-568f-1470-40f4-a3ccec8abcf2@ozlabs.ru>
         <c67c66e466ad27d15aa2b970c48d2336d95b2971.camel@gmail.com>
         <da473389-f921-075a-ec8e-ea516de4f177@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-28 at 11:40 +1000, Alexey Kardashevskiy wrote:
> > I think it would be better to keep the code as much generic as possible
> > regarding page sizes. 
> 
> Then you need to test it. Does 4K guest even boot (it should but I would
> not bet much on it)?

Maybe testing with host 64k pagesize and IOMMU 16MB pagesize in qemu
should be enough, is there any chance to get indirect mapping in qemu
like this? (DDW but with smaller DMA window available) 

> > > Because if we want the former (==support), then we'll have to align the
> > > size up to the bigger page size when allocating/zeroing system pages,
> > > etc. 
> > 
> > This part I don't understand. Why do we need to align everything to the
> > bigger pagesize? 
> > 
> > I mean, is not that enough that the range [ret, ret + size[ is both
> > allocated by mm and mapped on a iommu range?
> > 
> > Suppose a iommu_alloc_coherent() of 16kB on PAGESIZE = 4k and
> > IOMMU_PAGE_SIZE() == 64k.
> > Why 4 * cpu_pages mapped by a 64k IOMMU page is not enough? 
> > All the space the user asked for is allocated and mapped for DMA.
> 
> The user asked to map 16K, the rest - 48K - is used for something else
> (may be even mapped to another device) but you are making all 64K
> accessible by the device which only should be able to access 16K.
> 
> In practice, if this happens, H_PUT_TCE will simply fail.

I have noticed mlx5 driver getting a few bytes in a buffer, and using
iommu_map_page(). It does map a whole page for as few bytes as the user
wants mapped, and the other bytes get used for something else, or just
mapped on another DMA page.
It seems to work fine.  

> 
> 
> > > Bigger pages are not the case here as I understand it.
> > 
> > I did not get this part, what do you mean?
> 
> Possible IOMMU page sizes are 4K, 64K, 2M, 16M, 256M, 1GB, and the
> supported set of sizes is different for P8/P9 and type of IO (PHB,
> NVLink/CAPI).
> 
> 
> > > > Update those functions to guarantee alignment with requested size
> > > > using IOMMU_PAGE_ALIGN() before doing iommu_alloc() / iommu_free().
> > > > 
> > > > Also, on iommu_range_alloc(), replace ALIGN(n, 1 << tbl->it_page_shift)
> > > > with IOMMU_PAGE_ALIGN(n, tbl), which seems easier to read.
> > > > 
> > > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > > > ---
> > > >  arch/powerpc/kernel/iommu.c | 17 +++++++++--------
> > > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> > > > index 9704f3f76e63..d7086087830f 100644
> > > > --- a/arch/powerpc/kernel/iommu.c
> > > > +++ b/arch/powerpc/kernel/iommu.c
> > > > @@ -237,10 +237,9 @@ static unsigned long iommu_range_alloc(struct device *dev,
> > > >  	}
> > > >  
> > > >  	if (dev)
> > > > -		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
> > > > -				      1 << tbl->it_page_shift);
> > > > +		boundary_size = IOMMU_PAGE_ALIGN(dma_get_seg_boundary(dev) + 1, tbl);
> > > 
> > > Run checkpatch.pl, should complain about a long line.
> > 
> > It's 86 columns long, which is less than the new limit of 100 columns
> > Linus announced a few weeks ago. checkpatch.pl was updated too:
> > https://www.phoronix.com/scan.php?page=news_item&px=Linux-Kernel-Deprecates-80-Col
> 
> Yay finally :) Thanks,

:)

> 
> 
> > > 
> > > >  	else
> > > > -		boundary_size = ALIGN(1UL << 32, 1 << tbl->it_page_shift);
> > > > +		boundary_size = IOMMU_PAGE_ALIGN(1UL << 32, tbl);
> > > >  	/* 4GB boundary for iseries_hv_alloc and iseries_hv_map */
> > > >  
> > > >  	n = iommu_area_alloc(tbl->it_map, limit, start, npages, tbl->it_offset,
> > > > @@ -858,6 +857,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
> > > >  	unsigned int order;
> > > >  	unsigned int nio_pages, io_order;
> > > >  	struct page *page;
> > > > +	size_t size_io = size;
> > > >  
> > > >  	size = PAGE_ALIGN(size);
> > > >  	order = get_order(size);
> > > > @@ -884,8 +884,9 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
> > > >  	memset(ret, 0, size);
> > > >  
> > > >  	/* Set up tces to cover the allocated range */
> > > > -	nio_pages = size >> tbl->it_page_shift;
> > > > -	io_order = get_iommu_order(size, tbl);
> > > > +	size_io = IOMMU_PAGE_ALIGN(size_io, tbl);
> > > > +	nio_pages = size_io >> tbl->it_page_shift;
> > > > +	io_order = get_iommu_order(size_io, tbl);
> > > >  	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
> > > >  			      mask >> tbl->it_page_shift, io_order, 0);
> > > >  	if (mapping == DMA_MAPPING_ERROR) {
> > > > @@ -900,11 +901,11 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
> > > >  			 void *vaddr, dma_addr_t dma_handle)
> > > >  {
> > > >  	if (tbl) {
> > > > -		unsigned int nio_pages;
> > > > +		size_t size_io = IOMMU_PAGE_ALIGN(size, tbl);
> > > > +		unsigned int nio_pages = size_io >> tbl->it_page_shift;
> > > >  
> > > > -		size = PAGE_ALIGN(size);
> > > > -		nio_pages = size >> tbl->it_page_shift;
> > > >  		iommu_free(tbl, dma_handle, nio_pages);
> > > > +
> > > 
> > > Unrelated new line.
> > 
> > Will be removed. Thanks!
> > 
> > > 
> > > >  		size = PAGE_ALIGN(size);
> > > >  		free_pages((unsigned long)vaddr, get_order(size));
> > > >  	}
> > > > 

