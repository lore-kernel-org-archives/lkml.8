Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446282078B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593474374;
	bh=WDGpgzzhrbi6jQoYwzCQkNgOhgPsy28c3rLvtZR7RUk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=HkRsKLacSDVecR40Jdvg0ROVSrxsNV/Ulzy5mvPQKwocodT+8b/7EQ4xlw4RLVP96
	 CEmStLLonel2vDGOecfCQgRyHKpRtVAtc9dy1KIG5spTakhqN/PlV8Ou06A+bvh7Ym
	 yFir9i4BHhH3uuliQwMsQktPNkxNXChstnE2e7po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgF2XqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgF2XqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:46:11 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295E220780;
        Mon, 29 Jun 2020 23:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593474370;
        bh=WDGpgzzhrbi6jQoYwzCQkNgOhgPsy28c3rLvtZR7RUk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Pf5MDB7DOBdEr6c0RglkzzT1r3dTYzbt2u/c7A3AdRs/o8UoRl6QypV4aghq8AZ4i
         IJAPil2gChGThnm9ZkxQxnhckYBUxA9BiGW12zOqqiKnj7oshyDxTRcpd1NDKRLeO1
         Tc1pH31YrW/NkNz+YyAWrTi3TIP+BTENO+WdOpEk=
Date:   Mon, 29 Jun 2020 16:46:09 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     "Michael S. Tsirkin" <mst@redhat.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, boris.ostrovsky@oracle.com,
        jgross@suse.com, konrad.wilk@oracle.com, jasowang@redhat.com,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linux-imx@nxp.com
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20200626110629-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
References: <20200624091732.23944-1-peng.fan@nxp.com> <20200624050355-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s> <20200624163940-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s> <20200626110629-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020, Michael S. Tsirkin wrote:
> On Thu, Jun 25, 2020 at 10:31:27AM -0700, Stefano Stabellini wrote:
> > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > On Wed, Jun 24, 2020 at 02:53:54PM -0700, Stefano Stabellini wrote:
> > > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > > On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> > > > > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > > > > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > > > > > > Export xen_swiotlb for all platforms using xen swiotlb
> > > > > > > > 
> > > > > > > > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > > > > > > > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > > > > > > > disabled, it is not required.
> > > > > > > > 
> > > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > 
> > > > > > > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > > > > > > Xen was there first, but everyone else is using that now.
> > > > > > 
> > > > > > Unfortunately it is complicated and it is not related to
> > > > > > VIRTIO_F_IOMMU_PLATFORM :-(
> > > > > > 
> > > > > > 
> > > > > > The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
> > > > > > foreign mappings (memory coming from other VMs) to physical addresses.
> > > > > > On x86, it also uses dma_ops to translate Linux's idea of a physical
> > > > > > address into a real physical address (this is unneeded on ARM.)
> > > > > > 
> > > > > > 
> > > > > > So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
> > > > > > always and on Xen/ARM if Linux is Dom0 (because it has foreign
> > > > > > mappings.) That is why we have the if (xen_domain) return true; in
> > > > > > vring_use_dma_api.
> > > > > 
> > > > > VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.
> > > > > 
> > > > > Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also*
> > > > > forces DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.
> > > > >
> > > > > Unfortunately as a result Xen never got around to
> > > > > properly setting VIRTIO_F_IOMMU_PLATFORM.
> > > > 
> > > > I don't think VIRTIO_F_IOMMU_PLATFORM would be correct for this because
> > > > the usage of swiotlb_xen is not a property of virtio,
> > > 
> > > 
> > > Basically any device without VIRTIO_F_ACCESS_PLATFORM
> > > (that is it's name in latest virtio spec, VIRTIO_F_IOMMU_PLATFORM is
> > > what linux calls it) is declared as "special, don't follow normal rules
> > > for access".
> > > 
> > > So yes swiotlb_xen is not a property of virtio, but what *is* a property
> > > of virtio is that it's not special, just a regular device from DMA POV.
> > 
> > I am trying to understand what you meant but I think I am missing
> > something.
> > 
> > Are you saying that modern virtio should always have
> > VIRTIO_F_ACCESS_PLATFORM, hence use normal dma_ops as any other devices?
> 
> I am saying it's a safe default. Clear VIRTIO_F_ACCESS_PLATFORM if you
> have some special needs e.g. you are very sure it's ok to bypass DMA
> ops, or you need to support a legacy guest (produced in the window
> between virtio 1 support in 2014 and support for
> VIRTIO_F_ACCESS_PLATFORM in 2016).

Ok thanks. I understand and it makes sense to me.

 
> > > > > > You might have noticed that I missed one possible case above: Xen/ARM
> > > > > > DomU :-)
> > > > > > 
> > > > > > Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
> > > > > > (xen_domain) return true; would give the wrong answer in that case.
> > > > > > Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
> > > > > > the "normal" dma_ops fail.
> > > > > > 
> > > > > > 
> > > > > > The solution I suggested was to make the check in vring_use_dma_api more
> > > > > > flexible by returning true if the swiotlb_xen is supposed to be used,
> > > > > > not in general for all Xen domains, because that is what the check was
> > > > > > really meant to do.
> > > > > 
> > > > > Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is wrong with that?
> > > > 
> > > > swiotlb-xen is not used on Xen/ARM DomU, the default dma_ops are the
> > > > ones that are used. So you are saying, why don't we fix the default
> > > > dma_ops to work with virtio?
> > > > 
> > > > It is bad that the default dma_ops crash with virtio, so yes I think it
> > > > would be good to fix that. However, even if we fixed that, the if
> > > > (xen_domain()) check in vring_use_dma_api is still a problem.
> > > 
> > > Why is it a problem? It just makes virtio use DMA API.
> > > If that in turn works, problem solved.
> > 
> > You are correct in the sense that it would work. However I do think it
> > is wrong for vring_use_dma_api to enable dma_ops/swiotlb-xen for Xen/ARM
> > DomUs that don't need it. There are many different types of Xen guests,
> > Xen x86 is drastically different from Xen ARM, it seems wrong to treat
> > them the same way.
> 
> I could imagine some future Xen hosts setting a flag somewhere in the
> platform capability saying "no xen specific flag, rely on
> "VIRTIO_F_ACCESS_PLATFORM". Then you set that accordingly in QEMU.
> How about that?

Yes, that would be fine and there is no problem implementing something
like that when we get virtio support in Xen. Today there are still no
virtio interfaces provided by Xen to ARM guests (no virtio-block/net,
etc.)

In fact, in both cases we are discussing virtio is *not* provided by
Xen; it is a firmware interface to something entirely different:

1) virtio is used to talk to a remote AMP processor (RPMesg)
2) virtio is used to talk to a secure-world firmware/OS (Trusty)


VIRTIO_F_ACCESS_PLATFORM is not set by Xen in these cases but by RPMesg
and by Trusty respectively. I don't know if Trusty should or should not
set VIRTIO_F_ACCESS_PLATFORM, but I think Linux should still work
without issues.

The xen_domain() check in Linux makes it so that vring_use_dma_api
returns the opposite value on native Linux compared to Linux as Xen/ARM
DomU by "accident". By "accident" because there is no architectural
reason why Linux Xen/ARM DomU should behave differently compared to
native Linux in this regard.

I hope that now it is clearer why I think the if (xen_domain()) check
needs to be improved anyway, even if we fix generic dma_ops with virtio
interfaces missing VIRTIO_F_ACCESS_PLATFORM.
