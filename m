Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C553C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA1A206F2
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQOD5BBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgF1EZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 00:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgF1EZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 00:25:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B14C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 21:25:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b184so37991pfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 21:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=T6k3mUS0NyU/oVqx+193+R6qE7iZSRfZJ4keDgLyvLo=;
        b=RQOD5BBOUOC26pA97VueO5OK2Bgh40J4A0HPLYUXfmeH8MWKYoyUA2z4afWtMANAXD
         +69alJ6XTAgXMXX8JQ7u8Mpnk3skIXEXGMVe1vxIGpeuisO4+C+SwCnsj7N7ctUW1CJ/
         x0ImdAHsCK0HpkxIPutNwTpB6lpVUIgWGXIKof8shyqqbrHN/tDfq84acBbTFbCI9AJl
         d2tAA57OvD3r8JmRkdDi+N62fWnWylytHh/Yy1EJPtCVIiwbpfr3mb1FcC3uVLkTuFnG
         m9QEU37k0MI48Hryx7zx2+kW043E7AwHk3gQ3G1GxnSXRB8a/YSU6wp+J20aVIxyoKc5
         sW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=T6k3mUS0NyU/oVqx+193+R6qE7iZSRfZJ4keDgLyvLo=;
        b=U7J6ttZaIk0OmrH86oK6/uVkx/KY6q0D2+zOFKH/x9uE0oZGSpXAJP5szRRKaHrfXe
         PNyC94zCpqkakUh9BDywF/B+uiHHVOxf9wYrijbjr9GjrBkHE8AHACYmzFt+PcgGmCfO
         iW5N4Th2X+CAgKbzkQSG/L3QhnGvQc4TT3meY8t4HO7iSUUVl9fxXZrQJlhl1hDSQPQm
         i4siHQ4U1FuUP+QKQ9IknjUsQ8JgMS271ps0b8v4y5MX8T9LkfRV4wEWLjtNZyneYoSR
         9vJo+lB4QWzYxLe0qiiXZzWSn86DfzmOOiT1j341MQyVqMPAziA4dFzMBw/mwkxJiFwk
         89JA==
X-Gm-Message-State: AOAM532FBLug0ti5cSyKd6KFMF7N2K3MJeaIjYnC5VKg6jEPztQ1TMBZ
        prYVjQsYG9mKTx3beNQare2I7Q==
X-Google-Smtp-Source: ABdhPJzQXFRnjjCyGFerSlarK8lzzF7IXh0YSHV55/dv+KxzFDN3rMB78EAtPtATQehvaa2OaDcNgQ==
X-Received: by 2002:a62:aa0e:: with SMTP id e14mr8983062pff.128.1593318323161;
        Sat, 27 Jun 2020 21:25:23 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t126sm5550162pfd.214.2020.06.27.21.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 21:25:22 -0700 (PDT)
Date:   Sat, 27 Jun 2020 21:25:21 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] dma-pool: warn when coherent pool is depleted
In-Reply-To: <20200621211200.GA158319@roeck-us.net>
Message-ID: <alpine.DEB.2.22.394.2006272124470.591864@chino.kir.corp.google.com>
References: <20200621211200.GA158319@roeck-us.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020, Guenter Roeck wrote:

> > When a DMA coherent pool is depleted, allocation failures may or may not
> > get reported in the kernel log depending on the allocator.
> > 
> > The admin does have a workaround, however, by using coherent_pool= on the
> > kernel command line.
> > 
> > Provide some guidance on the failure and a recommended minimum size for
> > the pools (double the size).
> > 
> > Signed-off-by: David Rientjes <rientjes@google.com>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Also confirmed that coherent_pool=256k works around the crash
> I had observed.
> 

Thanks Guenter.  Christoph, does it make sense to apply this patch since 
there may not be an artifact left behind in the kernel log on allocation 
failure by the caller?

> Guenter
> 
> > ---
> >  kernel/dma/pool.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -239,12 +239,16 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
> >  	}
> >  
> >  	val = gen_pool_alloc(pool, size);
> > -	if (val) {
> > +	if (likely(val)) {
> >  		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
> >  
> >  		*ret_page = pfn_to_page(__phys_to_pfn(phys));
> >  		ptr = (void *)val;
> >  		memset(ptr, 0, size);
> > +	} else {
> > +		WARN_ONCE(1, "DMA coherent pool depleted, increase size "
> > +			     "(recommended min coherent_pool=%zuK)\n",
> > +			  gen_pool_size(pool) >> 9);
> >  	}
> >  	if (gen_pool_avail(pool) < atomic_pool_size)
> >  		schedule_work(&atomic_pool_work);
> 
