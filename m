Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB61C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03DD206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZusycQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgF2WYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:24:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgF2WYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593469462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CH00j3xLGgY5MCOHoqIWuWnauDKW7cEZeJtWO3pCrfs=;
        b=MZusycQnVNuQUNXyzHrTcrMbnLeqQVgWwzhyJf5OEP6CGK7J6hqHDT5bm3x93BkAs+QlPU
        x3H+6p2w5mcQ3igQEF6MDj3EgxOck181uW5xjEuqqji24WJK3/16TgqrIKkQIZw3dFPqZ1
        LZOXtTFt25JbQZyvDGyr3qnq9kW0Hjc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-Q0QhZMiDNLSfwL9zHMxAOw-1; Mon, 29 Jun 2020 02:21:54 -0400
X-MC-Unique: Q0QhZMiDNLSfwL9zHMxAOw-1
Received: by mail-wr1-f71.google.com with SMTP id a18so16145099wrm.14
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CH00j3xLGgY5MCOHoqIWuWnauDKW7cEZeJtWO3pCrfs=;
        b=AQMAznrQ+D27KWU7m+FFbJo/YkS4QFMucbP/Fx1qCerFMIVl4FeheeNM4oRM+op8xt
         i9ZHEt+Qdl6TSh/t0AO6MyKDqegvawt95dylFGfliDULApDWfqbyX8gFap8quiUAPTJT
         GFa12kp8PnpQW8rCGw8duUSSe5xxoG5Y+BHduk+IoWfYIxGIDUNLNs82jlz5JDKVPReR
         hrb98a/M+KHNHyY8FOWjDHiQFZqngL8ItzsGEyI6OUtRXX91IDeTyNA2Z7CZTZmsaIYu
         QAcX/WgTDK6Lx3FzhTzUopnKdlqju2Aus/rU5mNPZBvy7R2uqqhmkKZT//lF/Oi7IQw7
         eWcQ==
X-Gm-Message-State: AOAM532mTvQ2fwbmOiL7v1EOSoFfgmdoOPn5gsYt44OSxoJ299zhhN88
        hBMtDENj5OwVBjRQhOV00PnS55gdKoHmYE2eUQRyuqWlLBmBVo4zuYhduKjF7StnR99xhscMCX/
        WpfOMNC8QAm1X6uyD1bNCznbE
X-Received: by 2002:a1c:2842:: with SMTP id o63mr213022wmo.169.1593411713730;
        Sun, 28 Jun 2020 23:21:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKYcxmqMsT/1ldFS1WC1gydKg7IfQlagc8Qi0Jdy4z5P71txG/ryJ4wq5phGebg35mwOxHnw==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr213007wmo.169.1593411713418;
        Sun, 28 Jun 2020 23:21:53 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id k126sm22276200wme.17.2020.06.28.23.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:21:52 -0700 (PDT)
Date:   Mon, 29 Jun 2020 02:21:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200629022124-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <DB6PR0402MB27601CA74B85DA5A9F5E5DD6886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27601CA74B85DA5A9F5E5DD6886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 03:05:19AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
> > 
> > On Thu, Jun 25, 2020 at 10:31:27AM -0700, Stefano Stabellini wrote:
> > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 24, 2020 at 02:53:54PM -0700, Stefano Stabellini wrote:
> > > > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > > > On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> > > > > > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > > > > > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > > > > > > > Export xen_swiotlb for all platforms using xen swiotlb
> > > > > > > > >
> > > > > > > > > Use xen_swiotlb to determine when vring should use dma
> > > > > > > > > APIs to map the
> > > > > > > > > ring: when xen_swiotlb is enabled the dma API is required.
> > > > > > > > > When it is disabled, it is not required.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > >
> > > > > > > > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for
> > this?
> > > > > > > > Xen was there first, but everyone else is using that now.
> > > > > > >
> > > > > > > Unfortunately it is complicated and it is not related to
> > > > > > > VIRTIO_F_IOMMU_PLATFORM :-(
> > > > > > >
> > > > > > >
> > > > > > > The Xen subsystem in Linux uses dma_ops via swiotlb_xen to
> > > > > > > translate foreign mappings (memory coming from other VMs) to
> > physical addresses.
> > > > > > > On x86, it also uses dma_ops to translate Linux's idea of a
> > > > > > > physical address into a real physical address (this is
> > > > > > > unneeded on ARM.)
> > > > > > >
> > > > > > >
> > > > > > > So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be
> > > > > > > used on Xen/x86 always and on Xen/ARM if Linux is Dom0
> > > > > > > (because it has foreign
> > > > > > > mappings.) That is why we have the if (xen_domain) return
> > > > > > > true; in vring_use_dma_api.
> > > > > >
> > > > > > VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.
> > > > > >
> > > > > > Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also* forces
> > > > > > DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.
> > > > > >
> > > > > > Unfortunately as a result Xen never got around to properly
> > > > > > setting VIRTIO_F_IOMMU_PLATFORM.
> > > > >
> > > > > I don't think VIRTIO_F_IOMMU_PLATFORM would be correct for this
> > > > > because the usage of swiotlb_xen is not a property of virtio,
> > > >
> > > >
> > > > Basically any device without VIRTIO_F_ACCESS_PLATFORM (that is it's
> > > > name in latest virtio spec, VIRTIO_F_IOMMU_PLATFORM is what linux
> > > > calls it) is declared as "special, don't follow normal rules for
> > > > access".
> > > >
> > > > So yes swiotlb_xen is not a property of virtio, but what *is* a
> > > > property of virtio is that it's not special, just a regular device from DMA
> > POV.
> > >
> > > I am trying to understand what you meant but I think I am missing
> > > something.
> > >
> > > Are you saying that modern virtio should always have
> > > VIRTIO_F_ACCESS_PLATFORM, hence use normal dma_ops as any other
> > devices?
> > 
> > I am saying it's a safe default. Clear VIRTIO_F_ACCESS_PLATFORM if you have
> > some special needs e.g. you are very sure it's ok to bypass DMA ops, or you
> > need to support a legacy guest (produced in the window between virtio 1
> > support in 2014 and support for VIRTIO_F_ACCESS_PLATFORM in 2016).
> > 
> > 
> > > If that is the case, how is it possible that virtio breaks on ARM
> > > using the default dma_ops? The breakage is not Xen related (except
> > > that Xen turns dma_ops on). The original message from Peng was:
> > >
> > >   vring_map_one_sg -> vring_use_dma_api
> > >                    -> dma_map_page
> > >   		       -> __swiotlb_map_page
> > >   		                ->swiotlb_map_page
> > >   				->__dma_map_area(phys_to_virt(dma_to_phys(dev,
> > dev_addr)), size, dir);
> > >   However we are using per device dma area for rpmsg, phys_to_virt
> > >   could not return a correct virtual address for virtual address in
> > >   vmalloc area. Then kernel panic.
> > >
> > > I must be missing something. Maybe it is because it has to do with RPMesg?
> > 
> > I think it's an RPMesg bug, yes
> 
> rpmsg bug is another issue, it should not use dma_alloc_coherent for reserved area,
> and use vmalloc_to_page.
> 
> Anyway here using dma api will also trigger issue.
> 
> > 
> > >
> > > > > > > You might have noticed that I missed one possible case above:
> > > > > > > Xen/ARM DomU :-)
> > > > > > >
> > > > > > > Xen/ARM domUs don't need swiotlb_xen, it is not even
> > > > > > > initialized. So if
> > > > > > > (xen_domain) return true; would give the wrong answer in that case.
> > > > > > > Linux would end up calling the "normal" dma_ops, not
> > > > > > > swiotlb-xen, and the "normal" dma_ops fail.
> > > > > > >
> > > > > > >
> > > > > > > The solution I suggested was to make the check in
> > > > > > > vring_use_dma_api more flexible by returning true if the
> > > > > > > swiotlb_xen is supposed to be used, not in general for all Xen
> > > > > > > domains, because that is what the check was really meant to do.
> > > > > >
> > > > > > Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is
> > wrong with that?
> > > > >
> > > > > swiotlb-xen is not used on Xen/ARM DomU, the default dma_ops are
> > > > > the ones that are used. So you are saying, why don't we fix the
> > > > > default dma_ops to work with virtio?
> > > > >
> > > > > It is bad that the default dma_ops crash with virtio, so yes I
> > > > > think it would be good to fix that. However, even if we fixed
> > > > > that, the if
> > > > > (xen_domain()) check in vring_use_dma_api is still a problem.
> > > >
> > > > Why is it a problem? It just makes virtio use DMA API.
> > > > If that in turn works, problem solved.
> > >
> > > You are correct in the sense that it would work. However I do think it
> > > is wrong for vring_use_dma_api to enable dma_ops/swiotlb-xen for
> > > Xen/ARM DomUs that don't need it. There are many different types of
> > > Xen guests, Xen x86 is drastically different from Xen ARM, it seems
> > > wrong to treat them the same way.
> > 
> > I could imagine some future Xen hosts setting a flag somewhere in the
> > platform capability saying "no xen specific flag, rely on
> > "VIRTIO_F_ACCESS_PLATFORM". Then you set that accordingly in QEMU.
> > How about that?
> > 
> 
> Michael, Stefano,
> 
> So what's your suggestion here, that we could avoid similar issue
> for virtio drivers in ARM DomU?
> 
> Thanks,
> Peng.
> 
> > 
> > >
> > >
> > > Anyway, re-reading the last messages of the original thread [1], it
> > > looks like Peng had a clear idea on how to fix the general issue.
> > > Peng, what happened with that?
> 
> We shrinked the rpmsg reserved area to workaround the issue.
> So still use the dma apis in rpmsg.
> 
> But here I am going to address domu android trusty issue using
> virtio.

My suggestion is to first of all fix DMA API so it works properly.

> > >
> > >
> > > [1]
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fpatchwork%2Fpatch%2F1033801%2F%231222404&amp;dat
> > a=02%7C0
> > >
> > 1%7Cpeng.fan%40nxp.com%7C08ba48d3b3d54e775a8108d819e62fd0%7C68
> > 6ea1d3bc
> > >
> > 2b4c6fa92cd99c5c301635%7C0%7C0%7C637287823721994475&amp;sdata
> > =Cw4FHWrH
> > > uVKBCn3%2BKS2VM7cWuGoTI6R7SHJrJSLY5Io%3D&amp;reserved=0

