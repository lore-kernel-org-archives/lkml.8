Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB5EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD6A206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfGvWn92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgENK4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:56:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33582 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgENK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589453769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHZ41h14fTWrbRLrhrALieAAJlnpk4leLK6sw8NuxOE=;
        b=EfGvWn92IvuAQZ6DQKrCF+mLZV0ppxbwAqNqTSBIhMl3F//UOO6502SuNcSWlccahw1rHH
        oAP7nO4ebP9Zq609+zTBoPTXD+bsVWLwZLOjY0Xd2Oz56lEIi5a9CzCNMhMiKNRwtnXjC9
        ybpwNSetAMMDRxYPDoF24O2o8AwAV14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-iF9Kl0BxNiqc_JIkeIYZMw-1; Thu, 14 May 2020 06:56:08 -0400
X-MC-Unique: iF9Kl0BxNiqc_JIkeIYZMw-1
Received: by mail-wr1-f71.google.com with SMTP id w9so1395658wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 03:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VHZ41h14fTWrbRLrhrALieAAJlnpk4leLK6sw8NuxOE=;
        b=DnGhwBT/ndXMDdl0PPuYkMa2IOo5zbLbiffEFcMfGV5TjYEjvXRKd8qLovvus+A2LC
         TFOKVzXKsbZd/crMEZeqxWLclrSfpwOyqIVo3D07twmN3L6PBfSbWbzsDb39TIk81FlI
         HqGXTf7L3bagxqLTJo9oB8B98xl/y84T2Auk5iJ8XsSEVqP0XUChVB4flNhxvU1F3eCM
         QIl7m0pV7e9a09MVjPQB5r30xy8C6YJv6A70T0lzs2ENkYt1wW+72nmpkTEV9lcaGrS5
         LI0l+etWWM6dzv6R7GeQ1+iFZXCAc40uiVogEHdE0LhEuBBoBs3L1KNFnonJeRw3qdIE
         pT1g==
X-Gm-Message-State: AGi0PubICQIad3mAoXpV/4b8/X5wWt0Nsagd+5OTqlbjiWhk+WVTJKrv
        42mMto94q8ERaiKDppWHQG2Z/Rvaro2TSN8fEqD6op+hZsOv49utF/L9x2RUs7FW1p78wusZ02l
        MDH8k4lf/EFT0diBLi7jK30Sh
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr24622382wme.26.1589453766567;
        Thu, 14 May 2020 03:56:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLMsnXPsM1b2L/2KOfug1uDYVUAjsPOiK0fTUG+tCUxOeBoYLkhY7lRS7Z1AhFO2DsqYHF2vA==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr24622353wme.26.1589453766300;
        Thu, 14 May 2020 03:56:06 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
        by smtp.gmail.com with ESMTPSA id f123sm26861427wmf.44.2020.05.14.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 03:56:05 -0700 (PDT)
Date:   Thu, 14 May 2020 06:56:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Bharat Bhushan <bbhushan2@marvell.com>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org,
        jasowang@redhat.com, eric.auger.pro@gmail.com,
        eric.auger@redhat.com
Subject: Re: [PATCH v6] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200514065206-mutt-send-email-mst@kernel.org>
References: <20200514075237.3941-1-bbhushan2@marvell.com>
 <20200514043747-mutt-send-email-mst@kernel.org>
 <20200514105016.GA2252@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514105016.GA2252@myrica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:50:16PM +0200, Jean-Philippe Brucker wrote:
> On Thu, May 14, 2020 at 05:31:00AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2020 at 01:22:37PM +0530, Bharat Bhushan wrote:
> > > Different endpoint can support different page size, probe
> > > endpoint if it supports specific page size otherwise use
> > > global page sizes.
> > > 
> > > Device attached to domain should support a minimum of
> > > domain supported page sizes. If device supports more
> > > than domain supported page sizes then device is limited
> > > to use domain supported page sizes only.
> > 
> > OK so I am just trying to figure it out.
> > Before the patch, we always use the domain supported page sizes
> > right?
> > 
> > With the patch, we still do, but we also probe and
> > validate that device supports all domain page sizes,
> > if it does not then we fail to attach the device.
> 
> Generally there is one endpoint per domain. Linux creates the domains and
> decides which endpoint goes in which domain. It puts multiple endpoints in
> a domain in two cases:
> 
> * If endpoints cannot be isolated from each others by the IOMMU, for
>   example if ACS isolation isn't enabled in PCIe. In that case endpoints
>   are in the same IOMMU group, and therefore contained in the same domain.
>   This is more of a quirk for broken hardware, and isn't much of a concern
>   for virtualization because it's easy for the hypervisor to present
>   endpoints isolated from each others.

Unless they aren't isolated on real hardware :)

> * If userspace wants to put endpoints in the same VFIO container, then
>   VFIO first attempts to put them in the same IOMMU domain, and falls back
>   to multiple domains if that fails. That case is just a luxury and we
>   shouldn't over-complicate the driver to cater for this.
> 
> So the attach checks don't need to be that complicated. Checking that the
> page masks are exactly the same should be enough.
> 
> > This seems like a lot of effort for little benefit, can't
> > hypervisor simply make sure endpoints support the
> > iommu page sizes for us?
> 
> I tend to agree, it's not very likely that we'll have a configuration with
> different page sizes between physical and virtual endpoints.
> 
> If there is a way for QEMU to simply reject VFIO devices that don't use
> the same page mask as what's configured globally, let's do that instead of
> introducing the page_size_mask property.

Or we can even do the subset thing in QEMU. Can be transparent to
guests.


So I guess this patch isn't really needed then.

> 
> > > @@ -615,7 +636,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> > >  	struct viommu_dev *viommu = vdev->viommu;
> > >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > >  
> > > -	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> > > +	viommu_page_size = 1UL << __ffs(vdev->pgsize_bitmap);
> > >  	if (viommu_page_size > PAGE_SIZE) {
> > >  		dev_err(vdev->dev,
> > >  			"granule 0x%lx larger than system page size 0x%lx\n",
> > 
> > 
> > Looks like this is messed up on 32 bit: e.g. 0x100000000 will try to do
> > 1UL << -1, which is undefined behaviour. Which is btw already messed up
> > wrt viommu->pgsize_bitmap, but that's not a reason to propagate
> > the error.
> 
> Realistically we're not going to have a page granule larger than 4G, it's
> going to be 4k or 64k. But we can add a check that truncates the
> page_size_mask to 32-bit and makes sure that it's non-null.

... on 32 bit

> 
> > > +struct virtio_iommu_probe_pgsize_mask {
> > > +	struct virtio_iommu_probe_property	head;
> > > +	__u8					reserved[4];
> > > +	/* Same format as virtio_iommu_config::page_size_mask */
> > 
> > It's actually slightly different in that
> > this must be a superset of domain page size mask, right?
> 
> No it overrides the global mask

OK so I'd copy the comment and tweak it rather than
refer to virtio_iommu_config::page_size_mask
(besides, virtio_iommu_config::page_size_mask isn't legal C,
I know C++ so I figured out what's meant but it's
better to just say "page_size_mask in sturct virtio_iommu_config" )


> 
> > > +	__le64					pgsize_bitmap;
> 
> Bharat, please rename this to page_size_mask for consistency
> 
> Thanks,
> Jean
> 
> > > +};
> > > +
> > >  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> > >  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > >  
> > > -- 
> > > 2.17.1
> > 

