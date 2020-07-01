Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C599C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004892082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAB+GTQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGATsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgGATsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:48:41 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80EFC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:48:40 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p7so11583078qvl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=F+zOFzzQGW/IWyDrMNDLzgC5H7MP7fwCTcrqfKVNTg0=;
        b=hAB+GTQQpCETbZHenGH6duyUbioG5Ol2dwra3/38/gHPTbyAbAV7nUnZbVUx5fMvho
         h8+oMgHOyI99Z/nhFr/rJ0LNqmcphzEyvGGQ2kiTpp0sbRbEOxVgqSf5o3eWsG0nhNxW
         EpJTGxVXVYg+bbLDPcpoVC1SNXTDWD4LXyx6x5mVWXZAUS/ANs6NuJKPMel22+yl8GL2
         q4vewjCVRa0u0fdX+Bnb6PHbR1pXGnanPvI9/a20/NtsLfrZIVaDTcEXq87BpzUFmYIX
         5thhjuQHDEgz+CmG3bKc9gsPmjUg+a/gzqZM/ki0NiEnxfBsKyQzWt122XUS1rfpsZql
         0/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=F+zOFzzQGW/IWyDrMNDLzgC5H7MP7fwCTcrqfKVNTg0=;
        b=bReuthXnW7hJy0Fov8PR+6086TX7IIC67g3lX7qbdeYiZGS6DPnKZcOIwo5jVw2Ksn
         BW6rwjhjIzUBp5D69BFEAPGein3pO4AwAoYws+vYqijq5CKh9y19OsctELxesZSLwFqF
         o72pWDsxV0KBtiJpN9NJzc2azAyJbyN/XwfwN/2M/jo/RToRazGsxxoGlihp2MLuP4Fz
         Hrzdc4iIWNWfbZy9+AlBiDCNKcBu3sQxBW6pob345Xpbj78gy7Xwapn2bv1Ryp+OIrk/
         IcK+TnZ4FfceV29h8fXnNmeffG5s8B4nYQ8rCK8mMkEyNNJdibJ4LbeHBZaPPMPuyxPq
         CBsg==
X-Gm-Message-State: AOAM532GZyNJSihyjB9M10p+/sUpl1BukcRs/lp22xLpcFOcI9Z6LpcB
        En7OBxfmhxZUxr0Zd68/zSc=
X-Google-Smtp-Source: ABdhPJzU5xygkbKHsZhoN0wv1tTdnJ1PHu+l27Lo6dgQ/TjIwGafcKr1iso828lWlwcx1YtbiPZ+lg==
X-Received: by 2002:a05:6214:7a5:: with SMTP id v5mr25679250qvz.22.1593632920004;
        Wed, 01 Jul 2020 12:48:40 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id w77sm6653841qka.34.2020.07.01.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 12:48:39 -0700 (PDT)
Message-ID: <42e7174bf60227caee4d1c353235e42b90305632.camel@gmail.com>
Subject: Re: [PATCH v2 4/6] powerpc/pseries/iommu: Remove default DMA window
 before creating DDW
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 16:48:33 -0300
In-Reply-To: <e00340a3-1070-a787-5acc-0bfc37f73dff@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-5-leobras.c@gmail.com>
         <e00340a3-1070-a787-5acc-0bfc37f73dff@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 18:17 +1000, Alexey Kardashevskiy wrote:
> 
> On 24/06/2020 16:24, Leonardo Bras wrote:
> > On LoPAR "DMA Window Manipulation Calls", it's recommended to remove the
> > default DMA window for the device, before attempting to configure a DDW,
> > in order to make the maximum resources available for the next DDW to be
> > created.
> > 
> > This is a requirement for some devices to use DDW, given they only
> > allow one DMA window.
> 
> Devices never know about these windows, it is purely PHB's side of
> things. A device can access any address on the bus, the bus can generate
> an exception if there is no window behind the address OR some other
> device's MMIO. We could actually create a second window in addition to
> the first one and allocate bus addresses from both, we just simplifying
> this by merging two separate non-adjacent windows into one.

That's interesting, I was not aware of this. 
I will try to improve this commit message with this info.
Thanks for sharing!

> > > > If setting up a new DDW fails anywhere after the removal of this
> > default DMA window, it's needed to restore the default DMA window.
> > For this, an implementation of ibm,reset-pe-dma-windows rtas call is
> > needed:
> > 
> > Platforms supporting the DDW option starting with LoPAR level 2.7 implement
> > ibm,ddw-extensions. The first extension available (index 2) carries the
> > token for ibm,reset-pe-dma-windows rtas call, which is used to restore
> > the default DMA window for a device, if it has been deleted.
> > 
> > It does so by resetting the TCE table allocation for the PE to it's
> > boot time value, available in "ibm,dma-window" device tree node.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 70 ++++++++++++++++++++++----
> >  1 file changed, 61 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index a8840d9e1c35..4fcf00016fb1 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -1029,6 +1029,39 @@ static phys_addr_t ddw_memory_hotplug_max(void)
> >  	return max_addr;
> >  }
> >  
> > +/*
> > + * Platforms supporting the DDW option starting with LoPAR level 2.7 implement
> > + * ibm,ddw-extensions, which carries the rtas token for
> > + * ibm,reset-pe-dma-windows.
> > + * That rtas-call can be used to restore the default DMA window for the device.
> > + */
> > +static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
> > +{
> > +	int ret;
> > +	u32 cfg_addr, ddw_ext[DDW_EXT_RESET_DMA_WIN + 1];
> > +	u64 buid;
> > +	struct device_node *dn;
> > +	struct pci_dn *pdn;
> > +
> > +	ret = of_property_read_u32_array(par_dn, "ibm,ddw-extensions",
> > +					 &ddw_ext[0], DDW_EXT_RESET_DMA_WIN + 1);
> > +	if (ret)
> > +		return;
> > +
> > +	dn = pci_device_to_OF_node(dev);
> > +	pdn = PCI_DN(dn);
> > +	buid = pdn->phb->buid;
> > +	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
> > +
> > +	ret = rtas_call(ddw_ext[DDW_EXT_RESET_DMA_WIN], 3, 1, NULL, cfg_addr,
> > +			BUID_HI(buid), BUID_LO(buid));
> > +	if (ret)
> > +		dev_info(&dev->dev,
> > +			 "ibm,reset-pe-dma-windows(%x) %x %x %x returned %d ",
> > +			 ddw_ext[1], cfg_addr, BUID_HI(buid), BUID_LO(buid),
> 
> s/ddw_ext[1]/ddw_ext[DDW_EXT_RESET_DMA_WIN]/

Good catch! I missed this one.

> 
> 
> > +			 ret);
> > +}
> > +
> >  /*
> >   * If the PE supports dynamic dma windows, and there is space for a table
> >   * that can map all pages in a linear offset, then setup such a table,
> > @@ -1049,8 +1082,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  	u64 dma_addr, max_addr;
> >  	struct device_node *dn;
> >  	u32 ddw_avail[DDW_APPLICABLE_SIZE];
> > +
> 
> Unrelated new empty line.

Fixed!

> 
> 
> >  	struct direct_window *window;
> > -	struct property *win64;
> > +	struct property *win64, *default_win = NULL, *ddw_ext = NULL;
> >  	struct dynamic_dma_window_prop *ddwprop;
> >  	struct failed_ddw_pdn *fpdn;
> >  
> > @@ -1085,7 +1119,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  	if (ret)
> >  		goto out_failed;
> >  
> > -       /*
> > +	/*
> >  	 * Query if there is a second window of size to map the
> >  	 * whole partition.  Query returns number of windows, largest
> >  	 * block assigned to PE (partition endpoint), and two bitmasks
> > @@ -1096,15 +1130,31 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  	if (ret != 0)
> >  		goto out_failed;
> >  
> > +	/*
> > +	 * If there is no window available, remove the default DMA window,
> > +	 * if it's present. This will make all the resources available to the
> > +	 * new DDW window.
> > +	 * If anything fails after this, we need to restore it, so also check
> > +	 * for extensions presence.
> > +	 */
> >  	if (query.windows_available == 0) {
> 
> Does phyp really always advertise 0 windows for these VFs? What is in
> the largest_available_block when windows_available==0?

For this VF, it always advertise 0 windows before removing the default
DMA window. The largest available block size is the same as after the
removal (256GB). The only value that changes after removal is the
number of available windows. Here some debug prints:

[    3.473149] mlx5_core 4005:01:00.0: ibm,query-pe-dma-windows(53)
10000 8000000 29004005 returned 0
[    3.473162] mlx5_core 4005:01:00.0: windows_available = 0,
largest_block = 400000, page_size = 3, migration_capable = 3
[    3.473332] mlx5_core 4005:01:00.0: ibm,query-pe-dma-windows(53)
10000 8000000 29004005 returned 0
[    3.473345] mlx5_core 4005:01:00.0: windows_available = 1,
largest_block = 400000, page_size = 3, migration_capable = 3

> 
> 
> > -		/*
> > -		 * no additional windows are available for this device.
> > -		 * We might be able to reallocate the existing window,
> > -		 * trading in for a larger page size.
> > -		 */
> > -		dev_dbg(&dev->dev, "no free dynamic windows");
> > -		goto out_failed;
> > +		default_win = of_find_property(pdn, "ibm,dma-window", NULL);
> > +		ddw_ext = of_find_property(pdn, "ibm,ddw-extensions", NULL);
> > +		if (default_win && ddw_ext)
> > +			remove_dma_window(pdn, ddw_avail, default_win);
> > +
> > +		/* Query again, to check if the window is available */
> > +		ret = query_ddw(dev, ddw_avail, &query, pdn);
> > +		if (ret != 0)
> > +			goto out_failed;
> > +
> > +		if (query.windows_available == 0) {
> > +			/* no windows are available for this device. */
> > +			dev_dbg(&dev->dev, "no free dynamic windows");
> > +			goto out_failed;
> > +		}
> >  	}
> > +
> 
> Unrelated new empty line. Thanks,
Fixed!
Thank you!

> 
> >  	if (query.page_size & 4) {
> >  		page_shift = 24; /* 16MB */
> >  	} else if (query.page_size & 2) {
> > @@ -1194,6 +1244,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  	kfree(win64);
> >  
> >  out_failed:
> > +	if (default_win && ddw_ext)
> > +		reset_dma_window(dev, pdn);
> >  
> >  	fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
> >  	if (!fpdn)
> > 

