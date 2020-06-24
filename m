Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546BEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1752C2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh/XwDvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgFXWQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:16:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53286 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388232AbgFXWQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593036996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYBrrjiMl0OQwY7HbHO2EuoBSyetaNO9eIfsg2bUWrc=;
        b=Oh/XwDvGuWT0oUenzrrlIU9gvZ79iVcOlJ9EOfmtc2Ow+1FARwUq9NuOI0/CzBz0KfNyzw
        j9a9GY+cZiP1DF7yXnETrNN7pO/wzTA0oOwUzvdJcf3cC8ZDFjfJ+k6OGQI2PemI4ozlt4
        QlA4DWvrmwI/01GT+2GRKzcGf7pwCkk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-dWh0u7-aPcaM46dWL8BbDw-1; Wed, 24 Jun 2020 18:16:32 -0400
X-MC-Unique: dWh0u7-aPcaM46dWL8BbDw-1
Received: by mail-wm1-f70.google.com with SMTP id l2so4414511wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 15:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wYBrrjiMl0OQwY7HbHO2EuoBSyetaNO9eIfsg2bUWrc=;
        b=NWaDsZcU7pznkWeA2dWC2M1pw4MwZGnA5IT0SyTi7Sta4gw4G10h1RhtoCE66C0o3R
         nAI8kjHzpBfr6xJgKBesTX6Y1NRaublGU1LPA8mRz2+HWIAnsCDQsKu2ftZbNFPhVdRM
         f0lKEnDNUFdLaW+2fGmPPtotRqMg4XZ98o8sF8gCcBV43QeIp+zNGzCv3BbEzXUid8vo
         RHnwUIhk1jo3UCNLSKhtJDb0K4fcnrbB6uc08sd9oKP/ueLJhN5oRYyBP/tXUhAcse7+
         yZ6AidIJcgp/gkGAuWtah0zAGOj9LtNmSu3PJwbkPA2vlKwRwgWHIXBELYfuei//ygka
         4SzA==
X-Gm-Message-State: AOAM530RpdUvVHKAsJGK6fEOH5hWyme5nU/ltGHrOCdsFxe/jWv8Z/l2
        VBQbVn9Yp6REMNOBFTPYANs0FIPyOEINHhzaHWt84MTpmwv+93MNtNMFlVQkKhs32blnFHk4vVx
        An/5niV8/1u6ZPX//UhyqS308
X-Received: by 2002:a5d:630d:: with SMTP id i13mr29616363wru.208.1593036991415;
        Wed, 24 Jun 2020 15:16:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoZZ/QqNAP1QypcHjt3mv7sAp97QrEj/Mw3Cz3gd3OBPJIW+fGMGO1Vs/5O0ZnQg6aHPyOeQ==
X-Received: by 2002:a5d:630d:: with SMTP id i13mr29616327wru.208.1593036991077;
        Wed, 24 Jun 2020 15:16:31 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id e8sm26368886wrv.24.2020.06.24.15.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 15:16:30 -0700 (PDT)
Date:   Wed, 24 Jun 2020 18:16:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, boris.ostrovsky@oracle.com,
        jgross@suse.com, konrad.wilk@oracle.com, jasowang@redhat.com,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linux-imx@nxp.com
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200624181026-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 02:53:54PM -0700, Stefano Stabellini wrote:
> On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > > > Export xen_swiotlb for all platforms using xen swiotlb
> > > > > 
> > > > > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > > > > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > > > > disabled, it is not required.
> > > > > 
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > 
> > > > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > > > Xen was there first, but everyone else is using that now.
> > > 
> > > Unfortunately it is complicated and it is not related to
> > > VIRTIO_F_IOMMU_PLATFORM :-(
> > > 
> > > 
> > > The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
> > > foreign mappings (memory coming from other VMs) to physical addresses.
> > > On x86, it also uses dma_ops to translate Linux's idea of a physical
> > > address into a real physical address (this is unneeded on ARM.)
> > > 
> > > 
> > > So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
> > > always and on Xen/ARM if Linux is Dom0 (because it has foreign
> > > mappings.) That is why we have the if (xen_domain) return true; in
> > > vring_use_dma_api.
> > 
> > VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.
> > 
> > Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also*
> > forces DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.
> >
> > Unfortunately as a result Xen never got around to
> > properly setting VIRTIO_F_IOMMU_PLATFORM.
> 
> I don't think VIRTIO_F_IOMMU_PLATFORM would be correct for this because
> the usage of swiotlb_xen is not a property of virtio,


Basically any device without VIRTIO_F_ACCESS_PLATFORM
(that is it's name in latest virtio spec, VIRTIO_F_IOMMU_PLATFORM is
what linux calls it) is declared as "special, don't follow normal rules
for access".

So yes swiotlb_xen is not a property of virtio, but what *is* a property
of virtio is that it's not special, just a regular device from DMA POV.


> it is a detail of
> the way Linux does Xen address translations. swiotlb-xen is used to do
> these translations and it is hooked into the dma_ops framework.
> 
> It would be possible to have a device in hardware that is
> virtio-compatible and doesn't set VIRTIO_F_IOMMU_PLATFORM.

That device would be basically broken, since hardware
can't know whether it can access all memory or not.

> The device
> could be directly assigned (passthrough) to a DomU. We would still
> have to use swiotlb_xen if Xen is running.
> 
> You should think of swiotlb-xen as only internal to Linux and not
> related to whether the (virtual or non-virtual) hardware comes with an
> IOMMU or not.

IOMMU is a misnomer here.  Virtio spec now calls this bit
VIRTIO_F_ACCESS_PLATFORM. We should have done the same a while ago -
I'll send a patch.

> 
> > > You might have noticed that I missed one possible case above: Xen/ARM
> > > DomU :-)
> > > 
> > > Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
> > > (xen_domain) return true; would give the wrong answer in that case.
> > > Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
> > > the "normal" dma_ops fail.
> > > 
> > > 
> > > The solution I suggested was to make the check in vring_use_dma_api more
> > > flexible by returning true if the swiotlb_xen is supposed to be used,
> > > not in general for all Xen domains, because that is what the check was
> > > really meant to do.
> > 
> > Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is wrong with that?
> 
> swiotlb-xen is not used on Xen/ARM DomU, the default dma_ops are the
> ones that are used. So you are saying, why don't we fix the default
> dma_ops to work with virtio?
> 
> It is bad that the default dma_ops crash with virtio, so yes I think it
> would be good to fix that. However, even if we fixed that, the if
> (xen_domain()) check in vring_use_dma_api is still a problem.

Why is it a problem? It just makes virtio use DMA API.
If that in turn works, problem solved.



> 
> Alternatively we could try to work-around it from swiotlb-xen. We could
> enable swiotlb-xen for Xen/ARM DomUs with a different implementation so
> that we could leave the vring_use_dma_api check unmodified.
> 
> It would be ugly because we would have to figure out from the new
> swiotlb-xen functions if the device is a normal device, so we have to
> call the regular dma_ops functions, or if the device is a virtio device,
> in which case there is nothing to do. I think it is undesirable but
> could probably be made to work.

