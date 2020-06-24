Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D359C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37F52081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NF2dsNPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391512AbgFXUrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:47:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55773 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729867AbgFXUrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593031647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1reBoQYH57HQ1CEDrheXYLt8D4SLeQ87NHH75QUkc8=;
        b=NF2dsNPSLYo7W0d3DNoeyIVdLTNNbaMA60M8XYx9HQ+l98H+WW5j1NEUuXmPPwVryAFma9
        dm4dNs7ngtCk+zwxM4GDgSyjQsyqEED1UWYl564Lch1lZ7Ua6sEgexuTCYciYjqWPPlCm6
        ivgeAbpDdfyneMU3i0RbZJc31rRxL1g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-trV-RyjcNPS95k48masl2A-1; Wed, 24 Jun 2020 16:47:26 -0400
X-MC-Unique: trV-RyjcNPS95k48masl2A-1
Received: by mail-wm1-f71.google.com with SMTP id g187so3994519wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O1reBoQYH57HQ1CEDrheXYLt8D4SLeQ87NHH75QUkc8=;
        b=Dq8gT+dCcA4DW0mzjFxaFjf+Y4wWDakVbfZrHiKFVxievKcUa+0EocvH77WyarQQ6i
         7E0iy/HlKUNzLe8F1hEovRob+aXQ54nXH4DRfYsngYYUmUcWt9jiQ0fEzcYMoOkSO64O
         AGoGkqQ3F/Oqtj6aKbrduihhe1nTl+X4T96xRA3qsdX2n23tRkeWDMkPuVIRGlzBV8el
         eliSUJIZIa7mmN4EGbVwxjfgs2F/+gDNU9X0FV3WdJaYBU3pPC8CUntKquBQkFvZ9Wso
         Vv1jdB71LvnbfcbB4gy/2fdkqPWyQJaRDwgZehuQ4vRA4X80Lzoz/tTRae7pFLhnWUvW
         RYlg==
X-Gm-Message-State: AOAM532Oh9aEgFUT6SDJr9d5yghq6B71CDotkPsdtY6yKPktxakZBiti
        FqTb1ThLXWn7If8js7Y49ic2wpDrbd+W8/0uoS/EwayVceAHz6UduyLTrPvGB4ZQVoMqpMvlOoc
        icq4IkBwXGywVdvnV7atSo/SL
X-Received: by 2002:adf:ed47:: with SMTP id u7mr30096020wro.201.1593031644705;
        Wed, 24 Jun 2020 13:47:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPnaDNUPfot+ph5kW9eA3bmRXVnTYtGfhIgsVyoq9C+ZHJySjaF/DLGkUFrdWo8f0RjJM2sQ==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr30096000wro.201.1593031644489;
        Wed, 24 Jun 2020 13:47:24 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id v7sm28870842wrp.45.2020.06.24.13.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:47:23 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:47:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, boris.ostrovsky@oracle.com,
        jgross@suse.com, konrad.wilk@oracle.com, jasowang@redhat.com,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linux-imx@nxp.com
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200624163940-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > Export xen_swiotlb for all platforms using xen swiotlb
> > > 
> > > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > > disabled, it is not required.
> > > 
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > Xen was there first, but everyone else is using that now.
> 
> Unfortunately it is complicated and it is not related to
> VIRTIO_F_IOMMU_PLATFORM :-(
> 
> 
> The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
> foreign mappings (memory coming from other VMs) to physical addresses.
> On x86, it also uses dma_ops to translate Linux's idea of a physical
> address into a real physical address (this is unneeded on ARM.)
> 
> 
> So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
> always and on Xen/ARM if Linux is Dom0 (because it has foreign
> mappings.) That is why we have the if (xen_domain) return true; in
> vring_use_dma_api.

VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.

Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also*
forces DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.

Unfortunately as a result Xen never got around to
properly setting VIRTIO_F_IOMMU_PLATFORM.

I would like to make Xen do what everyone else is doing
which is just set VIRTIO_F_IOMMU_PLATFORM and then put
platform specific hacks inside DMA API.
Then we can think about deprecating the Xen hack in a
distance future, or hiding it behind a static branch, or something
like this.


> You might have noticed that I missed one possible case above: Xen/ARM
> DomU :-)
> 
> Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
> (xen_domain) return true; would give the wrong answer in that case.
> Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
> the "normal" dma_ops fail.
> 
> 
> The solution I suggested was to make the check in vring_use_dma_api more
> flexible by returning true if the swiotlb_xen is supposed to be used,
> not in general for all Xen domains, because that is what the check was
> really meant to do.

Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is wrong with that?


> 
> In this regards I have two more comments:
> 
> - the comment on top of the check in vring_use_dma_api is still valid
> - the patch looks broken on x86: it should always return true, but it
>   returns false instead
> 
>  
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index a2de775801af..768afd79f67a 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	 * the DMA API if we're a Xen guest, which at least allows
> > >  	 * all of the sensible Xen configurations to work correctly.
> > >  	 */
> > > -	if (xen_domain())
> > > +	if (xen_vring_use_dma())
> > >  		return true;
> > >  
> > >  	return false;
> > 
> > 
> > The comment above this should probably be fixed.
> 
> > 

