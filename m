Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBE1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3012080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhvtUapI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgFZPcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:32:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725275AbgFZPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593185569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTWe4soL1srkDL8PEEfq928W6GWa5t1pS8aCmfU8LHE=;
        b=EhvtUapIFt7i7WtEm4zKlZwJ66ueRYL1HMDLqFUD9sCUzdEz453LpX/JHmCvWlcOlbTJBb
        qL4QXTgytDesLZR0cZG0KW9uHvFJgN2VJXt+WVGn9+6naCBi7RqtzJPYIOsUSJwSDPcESW
        35/6v9AYCcTuBtRVQ4RtJxVnLay6uv4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-B69HOd67M-m1Bed0EVRgww-1; Fri, 26 Jun 2020 11:32:47 -0400
X-MC-Unique: B69HOd67M-m1Bed0EVRgww-1
Received: by mail-wm1-f70.google.com with SMTP id t145so11758551wmt.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RTWe4soL1srkDL8PEEfq928W6GWa5t1pS8aCmfU8LHE=;
        b=oPaVJr/niCj62nfVoYYiwiQh6jDCgpAp80axaU2iSPuG9WltfqtyAtJ776umyTiWdh
         4UYF4AUcyMuIj80EhGYiMVeUi1R3o0ZIwUvPOec6ZHDz6eQQ9TUi/8FOXn1pWa7yKDeu
         FagX+XtEStBZv1u5HibdZrKLiT6DzMgq8w7UBz5FwP5AMKpsYiXvZpJZosLsIkweSkMk
         WnfOnyPmRZClzSS6YzXuhFP1WE6i4WuDOnFkZd4xvsic4mFrrQy53dHObl594S284w2V
         b3gGa6T2LaFe4qTI5Z9e4qKhl+combZLh/FA2w/GhZ0E75hEenN5Qe/MCNqB38qxc5RB
         8Qdg==
X-Gm-Message-State: AOAM532seVEFeuerVJ+6TsR7qp3wANxdbGtJaMMJjbGNJ+1wSWL+dQ87
        Z7+q/oRCL1nUJMyv+/TZ0uIGKlCXZfM0N9oJrWoiKSAXHEmp1X3XmOGR7MZtdfSa4DWTtK7NUdI
        CwCJ55WkuWjLL+O5hImJK9vz4
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr4167961wrw.28.1593185566632;
        Fri, 26 Jun 2020 08:32:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKcm6jtqvubhG72TQoDWqW1duiFh/JDhCCKL54qZ+AftyQ9QDCAEubqgx6Fkb+6w/6lcA4Aw==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr4167932wrw.28.1593185566346;
        Fri, 26 Jun 2020 08:32:46 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id 65sm18427582wma.48.2020.06.26.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:32:45 -0700 (PDT)
Date:   Fri, 26 Jun 2020 11:32:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, boris.ostrovsky@oracle.com,
        jgross@suse.com, konrad.wilk@oracle.com, jasowang@redhat.com,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linux-imx@nxp.com
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200626110629-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:31:27AM -0700, Stefano Stabellini wrote:
> On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 02:53:54PM -0700, Stefano Stabellini wrote:
> > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> > > > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > > > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > > > > > Export xen_swiotlb for all platforms using xen swiotlb
> > > > > > > 
> > > > > > > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > > > > > > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > > > > > > disabled, it is not required.
> > > > > > > 
> > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > 
> > > > > > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > > > > > Xen was there first, but everyone else is using that now.
> > > > > 
> > > > > Unfortunately it is complicated and it is not related to
> > > > > VIRTIO_F_IOMMU_PLATFORM :-(
> > > > > 
> > > > > 
> > > > > The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
> > > > > foreign mappings (memory coming from other VMs) to physical addresses.
> > > > > On x86, it also uses dma_ops to translate Linux's idea of a physical
> > > > > address into a real physical address (this is unneeded on ARM.)
> > > > > 
> > > > > 
> > > > > So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
> > > > > always and on Xen/ARM if Linux is Dom0 (because it has foreign
> > > > > mappings.) That is why we have the if (xen_domain) return true; in
> > > > > vring_use_dma_api.
> > > > 
> > > > VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.
> > > > 
> > > > Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also*
> > > > forces DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.
> > > >
> > > > Unfortunately as a result Xen never got around to
> > > > properly setting VIRTIO_F_IOMMU_PLATFORM.
> > > 
> > > I don't think VIRTIO_F_IOMMU_PLATFORM would be correct for this because
> > > the usage of swiotlb_xen is not a property of virtio,
> > 
> > 
> > Basically any device without VIRTIO_F_ACCESS_PLATFORM
> > (that is it's name in latest virtio spec, VIRTIO_F_IOMMU_PLATFORM is
> > what linux calls it) is declared as "special, don't follow normal rules
> > for access".
> > 
> > So yes swiotlb_xen is not a property of virtio, but what *is* a property
> > of virtio is that it's not special, just a regular device from DMA POV.
> 
> I am trying to understand what you meant but I think I am missing
> something.
> 
> Are you saying that modern virtio should always have
> VIRTIO_F_ACCESS_PLATFORM, hence use normal dma_ops as any other devices?

I am saying it's a safe default. Clear VIRTIO_F_ACCESS_PLATFORM if you
have some special needs e.g. you are very sure it's ok to bypass DMA
ops, or you need to support a legacy guest (produced in the window
between virtio 1 support in 2014 and support for
VIRTIO_F_ACCESS_PLATFORM in 2016).


> If that is the case, how is it possible that virtio breaks on ARM using
> the default dma_ops? The breakage is not Xen related (except that Xen
> turns dma_ops on). The original message from Peng was:
> 
>   vring_map_one_sg -> vring_use_dma_api
>                    -> dma_map_page
>   		       -> __swiotlb_map_page
>   		                ->swiotlb_map_page
>   				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
>   However we are using per device dma area for rpmsg, phys_to_virt
>   could not return a correct virtual address for virtual address in
>   vmalloc area. Then kernel panic.
> 
> I must be missing something. Maybe it is because it has to do with RPMesg?

I think it's an RPMesg bug, yes.

> 
> > > > > You might have noticed that I missed one possible case above: Xen/ARM
> > > > > DomU :-)
> > > > > 
> > > > > Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
> > > > > (xen_domain) return true; would give the wrong answer in that case.
> > > > > Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
> > > > > the "normal" dma_ops fail.
> > > > > 
> > > > > 
> > > > > The solution I suggested was to make the check in vring_use_dma_api more
> > > > > flexible by returning true if the swiotlb_xen is supposed to be used,
> > > > > not in general for all Xen domains, because that is what the check was
> > > > > really meant to do.
> > > > 
> > > > Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is wrong with that?
> > > 
> > > swiotlb-xen is not used on Xen/ARM DomU, the default dma_ops are the
> > > ones that are used. So you are saying, why don't we fix the default
> > > dma_ops to work with virtio?
> > > 
> > > It is bad that the default dma_ops crash with virtio, so yes I think it
> > > would be good to fix that. However, even if we fixed that, the if
> > > (xen_domain()) check in vring_use_dma_api is still a problem.
> > 
> > Why is it a problem? It just makes virtio use DMA API.
> > If that in turn works, problem solved.
> 
> You are correct in the sense that it would work. However I do think it
> is wrong for vring_use_dma_api to enable dma_ops/swiotlb-xen for Xen/ARM
> DomUs that don't need it. There are many different types of Xen guests,
> Xen x86 is drastically different from Xen ARM, it seems wrong to treat
> them the same way.

I could imagine some future Xen hosts setting a flag somewhere in the
platform capability saying "no xen specific flag, rely on
"VIRTIO_F_ACCESS_PLATFORM". Then you set that accordingly in QEMU.
How about that?


> 
> 
> Anyway, re-reading the last messages of the original thread [1], it
> looks like Peng had a clear idea on how to fix the general issue. Peng,
> what happened with that?
> 
> 
> [1] https://lore.kernel.org/patchwork/patch/1033801/#1222404

